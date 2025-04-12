use dep::std::hash::pedersen_hash;
use dep::std::merkle::compute_merkle_root;

fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field,
) {
    // Verify the commitment = PedersenHash(id, r)
    let commitment_calculated = pedersen_hash([id, r]);

    // Enforce the commitment is correct
    assert(commitment_calculated == commitment);

    // Recompute the old Merkle root from commitment
    let recomputed_old_root = compute_merkle_root(commitment, index, oldPath);

    // Check that the new root matches what is on-chain
    assert(recomputed_old_root == newRoot);

    // Recompute the new Merkle root with the default value 
    let computed_new_root = compute_merkle_root(0x18d85f3de6dcd78b6ffbf5d8374433a5528d8e3bf2100df0b7bb43a4c59ebd63, index, oldPath);

    // Check that the old root was correct
    assert(computed_new_root == oldRoot);
}
