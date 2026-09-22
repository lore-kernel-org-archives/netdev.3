Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291D456DE2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790069492; cv=none; b=kDldRxUmoJhc2vQGSGeStz8XLDqGOPIiu97Oisma0S67o3HYISu+NzExggvyHxr6LkdBiGSEIkezxSheisovnID773+P1ApvyVPnrXvexco//6INvZxl0yBN7ksC6Z1PdbCnqroMcCUABzauXGOAsnB/Ctq/vAl8phEhY2Hu8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790069492; c=relaxed/simple;
	bh=HsCTEwCejflIPGn6aDN5s1ankMoE3xb+l71/mPF9Rtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3YNDZtZMy6mdTYf4T0EeVWRskZQdP6DL4I2OGOwRWx5Sc1W+MXQdeVSo2xTatFCWJp40OBhcYK+hsgdJ9pqRlvAn62IF8PVOP/w6s/LKwzxXXEGR8e80KYbff7vcoRWQRZFM2VzPxK+BJDGVj8STCXgrEkK+fOsx3BT/xjJc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFES/QKq; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFES/QKq"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd77300825so39153845ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790069489; x=1790674289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSk/o6B7IWQ+VmqUZ/savpxYdtj5YDadYMQXYJCjXc8=;
        b=VFES/QKqFYMpjZFNWkcWcFi5dFQSjHZstd5TZflEVJwY76hQbTgE7ofQDLNCpM/Y8+
         6OJ0WgwxIVJTXSPS8zIdrABmQ6+BwtPj3hZIfv1HLIsZirihnuxmyAjcV85gff8qpqSB
         AO9AbLszt0Pyxids6NUgzAadi36hJhe3kspf1n1LIbpUe6gmudMP+A//W+oK/MiWa18r
         kaCTWCiWp1V3EVDFIUzy72CEO1fQHmAIbbDoWigjX1yQZxoiLwHQ89XuSxI77U+o59Ck
         vhd1jhZahCuMzwWMsImrdR6ZuCucFg1gVNaHJei9XSGI4S0+328KI4CRkejSDM20vdSk
         tZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790069489; x=1790674289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSk/o6B7IWQ+VmqUZ/savpxYdtj5YDadYMQXYJCjXc8=;
        b=iDVU+hsVm5j3EPyND8zduLbYHknF2f451iXcCQxfRO7+0x8WLkfCxqJby+nwR9lKy0
         Ic43W0IKBqwjHyWZMsYn6NuaKXPVsPp1ESsyh1UxLbmPwUj+0MlTb4knGMznkLZSADhu
         q2Gztb5zEdV64Hx4E1s3EtriBb7ZhF67/xOTCpNnmenAbw8cZJAfohhwGXOOpl6OydC+
         q6FYUO5kQgTDPAU2HqvdGVt4/t8XYUh0y3+GYnv+gEgLf9rircGMQEx3k7RBMNQBPA14
         CcX7jmeba4l10jqc7p2cS1EEoUYjUw818iH3T78mkVJ3764vbXpHCrVS+dM7sqwtYH2g
         ztPQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8nOXcybA8T2Lb7NNGoylBKW1lB03D0qpCqrQMwqcjTOGuN+NAhQ73xoCk6ml7Fape1hFbWzg=@vger.kernel.org
X-Gm-Message-State: AFuF++nZiobmSEAdDRQzAdl16x+3WrzC9Ga3IIaWUs3/dl0/tPlyvFU5
	FZT+4iOEqDDXr1yWSHlKkFqAwI2vGdNzuDOPssReCOQLAataTRe9md0k
X-Gm-Gg: AYBFou07MIHummC0LL2+w9JNHQA/un4Th3I0OmO3i104FvUO5Gqu0xnU8LGJBQneg5a
	3DbmVydx+g+NPk8cj4WoHFvlksKGX69nfVHt7lo+Hwim4QnUacdr62MNKnEu4ljrZKEBLnneL8S
	opc1UNqecxRrAiA5OWH3AzauMmOVLq4dVwb/aaxidm8wOw3V9+b74bm4JwXJkPRm0s0TaxM4/MZ
	KBCh2D2ntDh5w/l4H+PncF/sOr1Tpoorw/8D0rw+iQ9xqY4FebUEu8qK/F8wqXVhWYIQLuRY1n6
	dafdjeqIQflMXagigHwo3J1O5p0W2NpFUA0zKl0WL4UeFNhN4buZR2p3k0q7yMpOwgM15cYE4JV
	Nw1HNzhuK25lUG+Gbh5Bu+ss30HpW4eRVOU5aIUkzfc7S0UE3noCbfIxcJZZDibRyakYPO4BIES
	mdFu8CDHuUOyG5a7D0nmHDraKaZCZKzm63Uxnyvk8OF7chRh3RJLQjPppW5hgT7st9cq/jH/EsD
	1zJwDdtNTMtFaMV2auntQMbvza9AS0FMoGTMyRCVM/4GC6ARLkUvddU6cyjM6YgmjncoIJY0H+M
	tRmes5Z3AYXKC6CNR8qO
X-Received: by 2002:a17:903:3c4d:b0:2dd:88b4:6920 with SMTP id d9443c01a7336-2df609d2351mr6599915ad.22.1790069489351;
        Tue, 22 Sep 2026 02:31:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df63a22f54sm103915ad.61.2026.09.22.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:31:29 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Hui Peng <benquike@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Tue, 22 Sep 2026 09:30:25 +0000
Message-ID: <20260922093126.141969-4-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260922093126.141969-1-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
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
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 8aa7ffe..ab245ad 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1758,19 +1758,15 @@ static int ca8210_skb_rx(
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
@@ -1778,9 +1774,25 @@ static int ca8210_skb_rx(
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
2.49.0
