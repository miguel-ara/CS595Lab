use dep::std::hash::pedersen_hash;
use dep::std::merkle::compute_merkle_root;

fn main(
    r: Field,
    index: Field,
    path: [Field; 8],
    root: pub Field,
    id: pub Field,
) {
    // Reconstruct the original commitment from (id, r)
    let commitment = pedersen_hash([id, r]);

    // Use Merkle path to compute the root from this commitment
    let computed_root = compute_merkle_root(commitment, index, path);

    // Ensure the root matches the public root
    assert(computed_root == root);
}