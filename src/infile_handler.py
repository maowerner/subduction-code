import argparse
import ConfigParser

def get_parameters():

    ##############################################################################
    # Argument parsing ###########################################################

    parser = argparse.ArgumentParser()
    # parse the name of the infile and load its contents into the parser
    parser.add_argument("infile", help="name of input file")
    # verbosity is also parsed
    parser.add_argument("-v", "--verbose", action="count", default=0, \
                                                   help="increase output verbosity")
    # TODO: Only allow certain options, specify standard behavior, etc.
    parser.add_argument("-b", "--basis", choices=['cartesian', 'cyclic', \
                          'cyclic-christian', 'dudek', 'marcus-cov', 'marcus-con', 'test'], \
                          default='marcus-cov',
                          help="continuum basis to be used in the program")

    args = parser.parse_args()

    ##############################################################################
    # Reading infile #############################################################

    config = ConfigParser.SafeConfigParser(
            {'list of p_cm' : None,
                'Dirac structure' : 'gamma_i',
                'list of q' : None,
                'beta' : '1'})

    if(config.read(args.infile) == []):
        print "Error! Could not open infile: ", args.infile
        exit(-1)

    return args, config
