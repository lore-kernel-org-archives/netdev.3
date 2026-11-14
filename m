Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794615653;
	b=fBKk7B9b6iW/fIA+oOCQbMyY6mFRMIyQ6R/5DKM7krqcpk/f7LICboTVplErZNcBsS1G
	 g/qjQ5xIqOMf+Ic1Cv++ubEqY4HkJLTnuyy9h3U249zqfMFQXIk3SwY8iru3JGZT00+DU
	 5JVohyQIIc947lA0eiqGpZLiEeRvzZhx0loH6BAMBxdfOqD20FeQv89RrU/mHTG5wSgQY
	 0N0mG4VaAnwCrj/D4T1kzQc9dMUETCZx5o5pNtDhOxcQuaWaM63U3bcwF3gRwzXJCtnyQ
	 yEMRHJHzZbfaDyWu7qK5QqjSpZ0td1JnbkSLDUYVPFPwyUaD3mYJJc11foRuasceRSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615653;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WIopzPvsYRfZHQFGDuvt4Tkqdc0XaieTCpebg+KuRL8=;
	b=eiXaiYVpdrpr6NhmV2zDN/qw8SOU3S+nYcwYIGIIfx56Vg1yg8mCJ17ANYqo+pAUTLWK
	 eptuhOAlro3jKru9OaOLfAEesbZ8Kcgm0a4a4w8KKR/nRfnlbycxKaMTa4RkMAF/zacg8
	 /I+2MbK4zoRmX/z4u+kAFeyLenT3wwjC+q4qnKe6c2a6YzYdKJPOeezQvfPny4eLzUdP0
	 QjpmR5dd23COzp3+CC/DP8iltck+tAXan6Efuzn6KRVYEWd1CUc5SpQBLfk+qU7hhv9Xf
	 QgNpWtV0sQUmnVi6PVEcjUlv0Pk0refDQtjh+HOBEeZrlwKu6K6v56hIk/4tB8MG5+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=RxO8jvzs;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C97606A334;
	Sat, 14 Nov 2026 00:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C97606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=RxO8jvzs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794615650; bh=WIopzPvsYRfZHQFGDuvt4Tkqdc0XaieTCpebg+KuRL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxO8jvzs03Urb+YEtVImRGsENxFCcHzrUzMO4qQjPk4T1WgL54vTWHivqJE/7RIFi
	 b9VlbSMuQjs9ew7gULmz2ExvnS5EzwTIH6HeAphqMikOH78H82OAFFb7hu8BpE8c3+
	 K3+LzsG6cnFjDA5pLLvetmm7ISQRlANqEvWivM8nPa7a1Mca0qRr2T5pNaslqejzw0
	 a7+zPXUkBEMCrrZPjVlYrYML0s9ZAVl1/9VtqiqAZGvGoF7oMvTpS2ZD8A1kLtnOfn
	 egONkWgzIvPGWENQiiANg7ESTh8J4hnnO8dUZs1NdI9k0a/y3ZSS1TxylrJSF4cTW7
	 xjQpc4+VjsGHw==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 8EF6427A347E;
	Sat, 14 Nov 2026 02:20:50 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: mtk_eth_soc: add 9K jumbo frame
Date: Sat, 14 Nov 2026 02:20:50 +0200
Message-Id: <patch-63fdf3015315ecb8ed8c06b638f66d45@loljews.com>
In-Reply-To: <179452725692.2199510.7733814065763991670@kernel.org>
References: <patch-271a13eac7135a653a78c355e66438ab@loljews.com> <179452725692.2199510.7733814065763991670@kernel.org>
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
Content-Transfer-Encoding: 8bit

On the v4 review of patch 3/3:

> [Medium] The shared RX length leaves no room for an 802.1Q tag at
> 1 KiB boundaries, including the advertised max_mtu.

Right, thank you.  v5 adds VLAN_HLEN to the length before the 1 KiB
round-up and lowers the advertised max_mtu by the same four bytes to
9194, so a tagged maximum-size frame is exactly rx_buf_len 9216 and
still at or under the XMAC 9216 cap.  XMAC_RX_CFG2 and the ring
buffers therefore cover a tagged frame at every MTU, including the
maximum.

> [Medium] GMAC1 (the built-in switch port and DSA conduit on MT7988)
> advertises max_mtu = 9198, but the only receive limit the driver
> can program caps at 2048.

You found the missing piece: the vendor driver has a second MCR
max-rx field (bits 31:28, 1024-byte units) that this port never
wrote.  v5 clears and programs MAC_MCR_MAX_RX_JUMBO for GMAC1, so the
same shared length is programmable for the switch port as for the
XGMII MACs.  The new field handling is limited to the
MTK_NETSYS_RX_9K SoCs, so every other SoC keeps its previous MCR
programming bit for bit.  Whether the internal switch path enforces
the field for switch-side frames at all remains a hardware question;
the commit message documents it honestly.

> [Medium] The unpolled QDMA RX ring is now filled with jumbo-sized
> buffers.

Right.  v5 changes mtk_max_frag_size()/mtk_max_buf_size() to take the
buffer length instead of struct mtk_eth, and mtk_rx_alloc() sizes the
never-polled QDMA RX ring at the fixed 2K length; only the polled
rings grow.  HW-LRO rings keep their 12288-byte sizing.

> [Medium] Possible kernel memory exposure (speculative).

Accepted as a robustness fix: v5 drops any descriptor whose PLEN0
exceeds ring->buf_size, with rx_length_errors, before the buffer can
be passed up, so the larger build_skb() size can no longer expose
unwritten memory even if the engine over-reports the length.

> [Medium] The PDMA RX max-frame (SDL) field may now be set 12 KiB
> above the posted buffer size (speculative).

The field is programmed the way the MediaTek downstream driver does
(frame length offset by MTK_PDMA_LRO_SDL in GENMASK(30,16)); the
local 6.18 backport drops jumbo frames without the write, and the
vendor 5.4 tree programs the plain 0x3000 LRO offset, both consistent
with the offset reading.  The encoding is the vendor's and not
publicly documented, and the comment and commit message now say
exactly that and ask for a datasheet confirmation.  No code change
in v5.

> [Medium] net: mtk_eth_soc: mtk_xdp_setup() rejects XDP detach when
> MTU is jumbo.

Right, the pool-size check now runs only when a program is attached,
so a detach always succeeds.  The shared eth->prog weakness the rest
of the analysis describes is pre-existing and is not addressed in
this series.

> [Low] The commit message hides a behaviour change on other SoCs and
> gets the buffer sizes wrong.

The message is corrected: order-1 (8 KiB) covers rx_buf_len
4096..7168 and order-2 (16 KiB) starts at rx_buf_len 8192, and it
now mentions that the build_skb()/truesize change also covers the
HW-LRO rings on mt2701, mt7622, mt7623 and mt7629.

> [High] On the first open, a failure while filling an RX ring leaks
> the buffers and frees with size 0.

Pre-existing in v7.3: ring->dma_size is set only after the fill loop
(introduced by ee40681037c0, "net: ethernet: mediatek: add HW LRO
functions of PDMA RX rings"), so this series does not create it.  It
will be sent as a separate fix that sets ring->dma_size before the
fill loop.

v5: https://lore.kernel.org/all/patch-f1e62a87eb0f914e1ea52a395f465998@loljews.com/

pw-bot: cr

