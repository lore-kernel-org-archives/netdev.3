Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006190;
	b=nV2lAfg4Ic7LlMcY7UUfMTCBoOP0186tHa3XXNHu0l6IBCqnlhM9GWZEmrUq/nUpVRiq
	 4LKcN84nu9sU0MLnDbi91QkwTKjSs8dJxSKHyjixzC25SJlYGqmWZvdUbZ2GLRwSv+/4S
	 7jUV9E50ezUphGvgenokrc5qNNDcRW4dYEaO80Bpvwv1XmZ48hOGDo7rKkQzBpW3a9dQz
	 LPLfAPJ9rgHLGFWc31gQT/phHAdSOh1U+Z2voijntDUH+YbHhZIl8tzmoz3gcskYd8DlZ
	 4TVyrN4K4G2FIhHQM+C1EUgs2xNkDxQop+CRYkyUf2UZ/TBFhtayTEW4kObZedwmjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006190;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
	b=bpX9Ix2tC26fs9EUh6uN+xpMNEIT5fXWVTC4516goP6ubyePlRJDe2H/ZNXBphihFtFR
	 SlMN4OpSHoPfyNWaaD3BFrC9QtE4PpjZEucipPhB/X316cXcPHfKaeh5dSOshhJU+gFQV
	 VSDTY0sgtPrsKaH6O4Y7+rbCyd5XR5d2BGaV+tKmyavm/Bx1aHneIceXwXTV5Wlz6XqH7
	 qLOHY2F79eRORGqScregGfdOmS1/Dqchh1pNr4zJfu+RXp6evCuibQdkNmGtVdeCrtBIB
	 Irs/x/lc4chKcYoZuztW3trNvBB2yPBDG7n6NgMoiOmMemeZfQlwQVb+hYfGCePeKqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=beLj96EI;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D67606A325;
	Mon, 26 Oct 2026 09:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D67606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=beLj96EI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793006187; x=1793265387;
	bh=wouIUEMfT4N12nqmNUUiAXbLnyN9+PofrbIF3cPgc74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=beLj96EIW19JDsM2etulD9M/cG0l4KatJN5vP/dsT8gmPCa+1i4tQHY+PZCB/UKk/
	 eJEQRYwqvjSpggu98rec1Lo4FBBj5VhyVYw0HAsJh+NEKOiwKva1T6lQhWAvfwT+Vo
	 eSMIzEnZIIeMbUdwvBajMmfB4mJVVUkrOTa0HTIzLXRKVhmoaI7IFgfKqQZIDQpx1z
	 CZX6A51yX16pcX/2BZQSv7aADMCD1fEcT4GZyMDjjUuMSeAE6qPatLgM+rWIFDlMFg
	 q5mPWGkL52rwixPQQL+5C+Rc7EArIEd2PaqvZPZQNsd3yHziv56iFaN8wSX/LYsH62
	 gAka4m+ml9K7A==
Date: Mon, 26 Oct 2026 09:16:19 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX timestamps
Message-ID: <20261026091549.605810-3-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 6fa17044f218a9b5dc8a444b577e6cd4e46ef864
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

igb_xmit_frame_ring() takes an extra skb reference for TX timestamping
before transmit preparation. For GSO packets, igb_tso() calls
skb_cow_head(), which can reach pskb_expand_head() with a shared skb
when the header is cloned. Commit c7d8bc3dd511 ("net: skbuff: don't BUG()
on bad arguments to pskb_expand_head()") replaced the BUG_ON() with
-EINVAL, causing TSO preparation to fail and the packet to be dropped.

For non-GSO packets with CHECKSUM_PARTIAL, igb_tx_csum() falls back to
skb_checksum_help() for unsupported checksum offsets. This can also
reach pskb_expand_head() through skb_ensure_writable(). igb_tx_csum()
ignores the error, allowing transmission to continue without completing
the checksum.

Move TSO and checksum preparation before taking the timestamp reference.
Add the timestamp bit to first->tx_flags without overwriting the offload
flags.

Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and=
 interrupts.")
Fixes: 6e033700887b ("igb: Add support for generic Tx checksums")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 31 ++++++++++++-----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index d4a897a8c82c..04c0053dbaae 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6559,6 +6559,21 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09first->bytecount =3D skb->len;
 =09first->gso_segs =3D 1;
=20
+=09if (skb_vlan_tag_present(skb)) {
+=09=09tx_flags |=3D IGB_TX_FLAGS_VLAN;
+=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
+=09}
+
+=09/* record initial flags and protocol */
+=09first->tx_flags =3D tx_flags;
+=09first->protocol =3D protocol;
+
+=09tso =3D igb_tso(tx_ring, first, &hdr_len);
+=09if (tso < 0)
+=09=09goto out_drop;
+=09else if (!tso)
+=09=09igb_tx_csum(tx_ring, first);
+
 =09if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09struct igb_adapter *adapter =3D netdev_priv(tx_ring->netdev);
=20
@@ -6567,6 +6582,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09=09=09=09=09   &adapter->state)) {
 =09=09=09skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
 =09=09=09tx_flags |=3D IGB_TX_FLAGS_TSTAMP;
+=09=09=09first->tx_flags |=3D IGB_TX_FLAGS_TSTAMP;
=20
 =09=09=09adapter->ptp_tx_skb =3D skb_get(skb);
 =09=09=09adapter->ptp_tx_start =3D jiffies;
@@ -6577,21 +6593,6 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
 =09=09}
 =09}
=20
-=09if (skb_vlan_tag_present(skb)) {
-=09=09tx_flags |=3D IGB_TX_FLAGS_VLAN;
-=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
-=09}
-
-=09/* record initial flags and protocol */
-=09first->tx_flags =3D tx_flags;
-=09first->protocol =3D protocol;
-
-=09tso =3D igb_tso(tx_ring, first, &hdr_len);
-=09if (tso < 0)
-=09=09goto out_drop;
-=09else if (!tso)
-=09=09igb_tx_csum(tx_ring, first);
-
 =09if (igb_tx_map(tx_ring, first, hdr_len))
 =09=09goto cleanup_tx_tstamp;
=20

