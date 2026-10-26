Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006180;
	b=lMFlA1P2cDZajnVbsXDX29QSzwp05grple3T01x6glNLjHjPij2BiYGtrNwEEL2TqkFm
	 /V6NsY4LdCWO7P4+La9Rz92IM5BSs3DsPKgvV89juCriYN7DSAmxqIb6QNmJbN/LbFFGp
	 wXazy7pEwaw2O1QuD9b4tIemk8zeF8QOvmTYEM7iBNh8h99I0lYguLIAf62RlfnKfEiqU
	 mA+2n5VObOQ8xEFcdmlN79uGFuhdYD+vDG5rO0SmkjJZzIuP0+sx0/iQ+g2rR18AbB8s2
	 XG/AK4GmIzl8j/OLqS8IZ8q33mrVw5b97fs5k8QUsWEfm6zJ1nqjpy8fftGFW1vK6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006180;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
	b=yus4A08kCKH2xrJpo2hwyQ3nrvWbLoj7GL0D5R1NHMJFPt6uxzOyw9UU3zeBU8wD8YTj
	 GFol+XNKXfVvAL/PrQBqWAfmio4Az+N9RLBZxgsXIK0nozjTS7SLyV7VVAGx+yPdtEG4t
	 lo/KDtKLYGXWz/gx9XHE3V/1QFuu9FZQ1mLePaJUKjcuc+GJ6P/9m9IdTBFDODHMosS2v
	 kFrv19XPm8dZdqs1gnwLn94tX5ScGHldxpDR4+ly0au6aCMlZK0Vzlt9eapgEC+4yE2Nk
	 EJ3Wg/7sHC+9eo7j1Al+CAbrduNCB1sH61MeVtyLFDu3rg3Dyakg6Fq47yCsKH2ptyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=GRxeK2Zz;
	arc=none smtp.remote-ip=185.70.43.99
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FED606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=GRxeK2Zz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793006177; x=1793265377;
	bh=7235CD4wqvIiye3CJAU8GfXs5OMk5RTaBUQJsuNXywk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GRxeK2ZzxrecvFfI7aBG8Q7p17VGKybNmD9OjXLNnTn3rIb0uiooltYWkE3pMFShI
	 y8sATr8/nVPBpARccFC8ROXDIuG6NhzPd2wyXquc9FdUIYPn68ta0z2JCn38u/3hml
	 ABUfXD0U+Nxu5cCRo1fWaMbBdfvyfb8THvc88oDnCvBj4B7aksvihJq28EtLWAbyyr
	 wP344Ux9jcx/u6IXni7//2D0oJJUbhfS6+2CGAvhHb5tWWr9nxBfdZCyxN6TX5obGm
	 m87RZ/ywdBGFKxG+5MZEz/hw+UGIXMsBfbArEsedeA9ZZVdSAo0bdfQ+E/HKGlX8sR
	 RPrekvep89v3Q==
Date: Mon, 26 Oct 2026 09:16:12 +0000
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
From: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: [PATCH net 2/3] igc: prepare TSO and checksum offloads before TX timestamps
Message-ID: <20261026091549.605810-2-p@1g4.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: d27c8f97c5a8bd6919b770c2879e25d6acf1a237
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

igc_request_tx_tstamp() takes an extra skb reference before transmit
preparation. For GSO packets, igc_tso() calls skb_cow_head(), which can
reach pskb_expand_head() with a shared skb when the header is cloned.
Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
pskb_expand_head()") replaced the BUG_ON() with -EINVAL, causing TSO
preparation to fail and the packet to be dropped.

For non-GSO packets with CHECKSUM_PARTIAL, igc_tx_csum() falls back to
skb_checksum_help() for unsupported checksum offsets. This can also
reach pskb_expand_head() through skb_ensure_writable(). igc_tx_csum()
ignores the error, allowing transmission to continue without completing
the checksum.

Move TSO and checksum preparation before TX timestamp reservation so
the extra skb reference cannot interfere with either operation.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Fixes: f38b782dccab ("igc: Add support for TSO")
Signed-off-by: Paul Moses <p@1g4.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index f1bf4e462a51..cd4c9815fca7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1678,6 +1678,12 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09=09goto out_drop;
 =09}
=20
+=09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
+=09if (tso < 0)
+=09=09goto out_drop;
+=09else if (!tso)
+=09=09igc_tx_csum(tx_ring, first, launch_time, first_flag);
+
 =09if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 =09=09     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 =09=09unsigned long flags;
@@ -1697,12 +1703,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buf=
f *skb,
 =09=09spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 =09}
=20
-=09tso =3D igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
-=09if (tso < 0)
-=09=09goto out_drop;
-=09else if (!tso)
-=09=09igc_tx_csum(tx_ring, first, launch_time, first_flag);
-
 =09igc_tx_map(tx_ring, first, hdr_len);
=20
 =09return NETDEV_TX_OK;

