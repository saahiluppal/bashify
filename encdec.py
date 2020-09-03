import hashlib
from getpass import getpass
from absl import app
from absl import flags

FLAGS = flags.FLAGS

flags.DEFINE_string('path', None, "path to file")
flags.DEFINE_string('passw', None, "password to encode/decode")
flags.DEFINE_integer('chunk', 4, "[chunk] digits for each variable")
flags.DEFINE_bool('encode', False, "encode the [path] file")
flags.DEFINE_bool('decode', False, "decode the [path] file")


def main(args):
    password = FLAGS.passw
    chunk = FLAGS.chunk

    assert chunk != 0, "Chunk must not be zero"
    assert FLAGS.encode != FLAGS.decode, "Choose [--encode] [--decode] carefully"

    print("Encoding..." if FLAGS.encode else "Decoding...")

    script = hashlib.sha256(password.encode('utf-8')).hexdigest()
    index = (2 * chunk) - 1

    for _ in range(index):
        script += hashlib.sha256(script.encode('utf-8')).hexdigest()

    lookup = [script[i: i + chunk] for i in range(0, len(script), chunk)]

    assert len(lookup) == len(set(
        lookup)) == 128, "Password showing *entanglement*. Increasing *chunk* may help"

    with open(FLAGS.path) as handle:
        output = handle.read()

    if FLAGS.encode:
        encoded = ''
        for letter in output:
            encoded += lookup[ord(letter)]

        new_path = '.'.join(FLAGS.path.split('.')[:-1]) + '.enc'
        print('Path = ' + new_path)

        encoded = [encoded[i: i + 80] for i in range(0, len(encoded), 80)]

        with open(new_path, 'w') as handle:
            handle.writelines('\n'.join(encoded))

    elif FLAGS.decode:
        assert FLAGS.path.split(
            '.')[-1] == 'enc', "wrong file. encoded files ends with .enc"

        decoded = ''
        output = output.replace('\n', '')
        for idx in range(0, len(output), chunk):
            decoded += chr(lookup.index(output[idx: idx + chunk]))

        new_path = '.'.join(FLAGS.path.split('.')[:-1]) + '.txt'
        print('Path = ' + new_path)

        with open(new_path, 'w') as handle:
            handle.writelines(decoded)

    print("Done...")


if __name__ == "__main__":
    app.run(main)
