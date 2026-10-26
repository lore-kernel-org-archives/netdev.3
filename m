Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006179;
	b=1XSAyr4qTmmCnjWPCM8316AGd7kEBqy6eMmL2diFycFMXa25WYzUKtaHzyJRUrrybPDv
	 UVc5o0qh2F1VLe/FhOmk6o2uzk8KuYDmNxU0E+A6bL+2z6Xhqq9LnZUuaX8ml37R3qxJ0
	 5nJ2ATRY1w28YyFNkGNN0fo10THHfWwkm19Uflz3/6MCiZTuU7WUY9MOz6AZfp3z9r3Rh
	 bPb4J64hthwi/gTkdHJiKQ9sf030QXDumA2Vqv/axLej1sBvQYh+jURkKPnrX7edYXq+5
	 dzceRihLabChu8A385g9FDnJutycd69o2q34ArG+XO85A1/YUQBFDYaoX9QwypvNkqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006179;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
	b=uzngYmPWqXWFXY2RRzbuvR3thjGlk9HAhhgsEn/YnZLkm0QlalILfJtoIKlLZB87UsCF
	 H1o6RoCF1zUwhwpRISHmnYHT7DNdOnLjNQCk43CpazGM4gH5g1TtVHGU9Cb3NEYMA4yS0
	 it7z0cRwOhcS+NmS9RJYwCwSgQFo63u44BSDO+TN5f3C6WM7rJYLjbOjgNRoVmYrHiX70
	 nKnlmeJ8gSlcbrYeP+CyWm2ZICdDDOppWebkmnkcYOMtGHmP1GuvN0M+z3XFxGCcaeVz6
	 hxqfQ/WYmeP8LEPFaFKGUSrZByOn+/VOIkxeicP+jgMtvLHs68KWg3Y5CL+j7VBWc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=QvX4DShW;
	arc=none smtp.remote-ip=79.135.106.117
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1D606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB1D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=QvX4DShW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793006175; x=1793265375;
	bh=6DTsjSztdBaV6GxeDQtkfm//5bQcS0bSnlwcmtgu62Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QvX4DShWiQlarzx63EuJ27qPSMsKXikWtn9c9MpVR9U5n42FrS01TPCmeZgBQeTgJ
	 LhEgA3es/K2NP6rglcyosx6ml10jR8NXurF6X3rKcTsr2QyQ3gpvVOSpR/HD6AgzfV
	 wihoUA6DTP21Ypgz6+mFI3DnfXBcw7yOCnskJcOewc5k1lSQxHxQBu+VIVMMqk9wha
	 udWcm2JmsO2nfUmoDpBr7KbBkmK95JYACuFxSQoLNKV72RDBVsj6T6up+Ly1si/H3E
	 yOwMnNNgMU2Gf7hFnPcRO9jJdBgJGkseRvhfRJFse8oJxLRxo65Ij/XhtBcaWY6Eat
	 EKvxOfoRm+AIg==
Date: Mon, 26 Oct 2026 09:16:07 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 1/3] igc: pad preemptible packets before reserving TX timestamps
Message-ID: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d33c929331c25b6f759b46fea624f64bcb228383
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

Preemptible queues require software padding so hardware includes the
padding bytes in the mCRC. Padding currently runs after TX timestamp
reservation takes an extra skb reference. If padding needs to expand
the skb, pskb_expand_head() rejects the shared skb.

Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
padding error path. skb_padto() drops one reference on failure, and
out_drop drops another. This can free the skb while the pending TX
timestamp still holds its pointer.

Move padding before TX timestamp reservation and use __skb_put_padto()
with free_on_error set to false so out_drop handles the skb release.
Preserve the VLAN flags in first->tx_flags when adding timestamp flags.

Fixes: 17643482e9ff ("igc: add preemptible queue support in taprio")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 39 +++++++++++------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe93c..f1bf4e462a51 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1661,6 +1661,23 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09goto out_drop;
 =09}
=20
+=09if (skb_vlan_tag_present(skb)) {
+=09=09tx_flags |=3D IGC_TX_FLAGS_VLAN;
+=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
+=09}
+
+=09/* record initial flags and protocol */
+=09first->tx_flags =3D tx_flags;
+=09first->protocol =3D protocol;
+
+=09/* For preemptible queue, manually pad the skb so that HW includes
+=09 * padding bytes in mCRC calculation
+=09 */
+=09if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
+=09=09if (__skb_put_padto(skb, ETH_ZLEN, false))
+=09=09=09goto out_drop;
+=09}
+
 =09if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 =09=09     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09unsigned long flags;
@@ -1669,10 +1686,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_bu=
ff *skb,
 =09=09spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 =09=09if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
 =09=09=09skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
-=09=09=09tx_flags |=3D IGC_TX_FLAGS_TSTAMP | tstamp_flags;
+=09=09=09first->tx_flags |=3D IGC_TX_FLAGS_TSTAMP | tstamp_flags;
 =09=09=09if (skb->sk &&
 =09=09=09    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
-=09=09=09=09tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;
+=09=09=09=09first->tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;
 =09=09} else {
 =09=09=09adapter->tx_hwtstamp_skipped++;
 =09=09}
@@ -1680,24 +1697,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 =09}
=20
-=09if (skb_vlan_tag_present(skb)) {
-=09=09tx_flags |=3D IGC_TX_FLAGS_VLAN;
-=09=09tx_flags |=3D (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
-=09}
-
-=09/* record initial flags and protocol */
-=09first->tx_flags =3D tx_flags;
-=09first->protocol =3D protocol;
-
-=09/* For preemptible queue, manually pad the skb so that HW includes
-=09 * padding bytes in mCRC calculation
-=09 */
-=09if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
-=09=09if (skb_padto(skb, ETH_ZLEN))
-=09=09=09goto out_drop;
-=09=09skb_put(skb, ETH_ZLEN - skb->len);
-=09}
-
 =09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
 =09if (tso < 0)
 =09=09goto out_drop;

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e

