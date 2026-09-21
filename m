Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272C43BDC3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976530; cv=none; b=X/MaS+VXDMownt4t2mfFIBRLQRqEogvcKFqijGVCJRz/pdBm63mUDq4mMrtgmDdhUIKTg9SbAK8mAk2tRu1HTAqZ7c7AE353VHQL3h/gCzuYgBqAOABDLzmpYQAXbzZdf/de3YyE6M3ErrDAHsssyx+RHtHMMFyUVvgMZ1Qls0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976530; c=relaxed/simple;
	bh=DRSbsEZlYqRU2ZFuKlgyDsGV2nz0JSOXB6TyqyEq7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQOmqjKtgg4kZXG85Fn0ljqjWsLclHAtp9wddY+CJzcLvgJDLnvTJDZA87hNxaydZAsX3pivfyP2JqxQh2yrt6H3rrTULvThFox9DqsQV0zvCmXF5bYXG6MIJ+tKu2pg4BNqL6Eh5ad02wmLt+aKnWRr85WZKQT4xhGv/UO89Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1yJiLDP; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1yJiLDP"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a1676000so2086271a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976527; x=1790581327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=A1yJiLDP9PGZxGGRtHL1bUKeU11xKVtc7lAoDUBe85brLViJwITGIRezyfTB3uzO2M
         tdOTF8C5hx5Qe9BM+fVxm3WC1D72z8Z2KCWgxi1YOrXiyf/0n0wEbPIXNrIGCfd3ic38
         htyNEb38eJpD7j6dgWr9Re9d+/3TvZcs2YMm5S4t1igoR7hTjWphu318p98kJKCcad61
         gCEJcAP+sxC37v4w33e1/xviZ4NnRKKJPDTEi+vvHn/qcMXNFFt5WhyzdZ53Fmj/0F4Q
         8X6UCosu1Dy9dM1kbmpXYFVlAeQ6x3h1XnwVzWgQYuFyvLhzJM0k7MDUjL+MmmFQLB4u
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976527; x=1790581327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=ZpLHzY/Ta+9wmP9bivY/uUiThkDX2xsZQ32oG95VSBnH0CB3tntxIZT5jLpGjGbthv
         PJXvzdSHCz9qMW8fL/M+jrjUrsAT0I2Q/fWKmXljLMHOTIpVwx8Zqvb5zF4y6QTMTeqw
         nmgUZ31Ei+qQ3JojrtdUlo8XQnQFP5x2QTFK2PvUIC3FzQ01aLn3qN0zYKkfJmdNbeh6
         6L+VEgJTh86VlWHz8ao9XOCgd0zgxIyd5+Zood72XU6MmvuPTkHcGDEbKqKl260TYgop
         HI88tkwUxFeIkQxSoUUj8xFCQw3TiMXDQs2K4DPpMbBRqqQNWpSNPFG1MPvYv1D184vJ
         JUHA==
X-Forwarded-Encrypted: i=1; AKwUvBzRUP3WhBGGekdSP2AiF+y8MhDNdlgpi21Rf2q+4P3+B+VgjJDJt9cFOckXV9vRD65m2rag3wk=@vger.kernel.org
X-Gm-Message-State: AFuF++mzZsqogKuwLyZkcMXOoPMDrzNhv6GiQFdJMvB3nibLNz/Gnny1
	6oMpyfst/bWTD3eu9e1FS1ZQK1rExYuKBzmD6d0nFrG1Pd3m3W6hpf+i
X-Gm-Gg: AYBFou3Uv2dzkKlKzKwsckYppIzPhF/bb4EXAcQdBJHDNCA9TAE4tzR5af98+XrVDrv
	z3htrieCKkztf/7rf+1yOL0p2s4JpOYyM85xE0v5WalWrReT2ddNDJHFiLTuGeJgSClsJshYBp5
	isfjCqbblKwiX45gZsaeJiQZbDOdVs1rqpOwrsnyvcpeJm74h7P9wabjltF4ca7hOY0bP3s1am3
	8bjy1pCzt8rjlWEofU0b2/TOY/owFaOporyCbw3fnVjgKZjFYWBie/EVEqeUEUeiTHycNiN2Wk8
	DrduTazPo/f+zRw784EyaSRAUFqC0j+ncVjYS/96JAQpqfb2+tKziolGbm4xd0ttw2Ft6sPaQrW
	/ZyUwXbpn0w78k25f/LhFxvZSPfxqBnudkmmCAm5ApEgfeQGNgkkbr+7F8R0zAgGW6wOGzzL93p
	kpNxcUu8BhX1V7Ye/MTb08DbjjXtlBN7BmWdXMWyjClUyOQePZCs3L/P1OWBGFP/5umEAI79j4g
	EHltE1HJuGE3hL69qxp493Dw+LRqZvUGSMcioF/nyOO6o3xYVwUGXTsjOOLTJSnAtN9SqD1+tlk
	6YKODkfR2Q==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-39e6a81fcf8mr8609680a91.36.1789976527065;
        Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Mon, 21 Sep 2026 07:42:05 +0000
Message-ID: <20260921074205.2289211-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213637.3316595-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
(mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
(security header), and 29 .. 29 + msdulen (payload) without verifying
that the received SPI frame length len covers those offsets, causing an
out-of-bounds read when msdulen exceeds len - 30:

  BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
  Read of size 64 at addr ffff888006453ddd by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
   ca8210_net_rx+0x96/0xc0
  ...
  The buggy address belongs to the object at ffff888006453dc0
   which belongs to the cache kmalloc-32 of size 32
  The buggy address is located 29 bytes inside of
   allocated 32-byte region [ffff888006453dc0, ffff888006453de0)

Consolidate all length and msdulen validations into a single upfront check
at the beginning of ca8210_skb_rx() before allocating the skb.

Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
msdulen = 64 and len = 30 into ca8210_skb_rx().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 1de6314..2aa7d8c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1759,19 +1759,15 @@ static int ca8210_skb_rx(
 	u8                    *data_ind
 )
 {
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = { };
 	int msdulen;
 	int hlen;
-	u8 mpdulinkquality = data_ind[23];
+	u8 mpdulinkquality;
 	struct sk_buff *skb;
 	struct ca8210_priv *priv = hw->priv;
 
-	/* Allocate mtu size buffer for every rx packet */
-	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_reserve(skb, sizeof(hdr));
+	if (len < 30)
+		return -EMSGSIZE;
 
 	msdulen = data_ind[22]; /* msdu_length */
 	if (msdulen > IEEE802154_MTU) {
@@ -1779,9 +1775,25 @@ static int ca8210_skb_rx(
 			&priv->spi->dev,
 			"received erroneously large msdu length!\n"
 		);
-		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+
+	if (len < 30 + msdulen ||
+	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
+	     len < 29 + msdulen + sizeof(struct secspec))) {
+		dev_err(&priv->spi->dev,
+			"received truncated data indication!\n");
+		return -EMSGSIZE;
+	}
+
+	mpdulinkquality = data_ind[23];
+
+	/* Allocate mtu size buffer for every rx packet */
+	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
 	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
 
 	if (priv->promiscuous)
-- 
2.47.3
