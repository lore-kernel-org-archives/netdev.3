Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A773EACD
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913716; cv=none; b=JpvONJnrXTaMWsH7pBqwVFc9UmYuw1qang3ypSvgeoRKUW2eu2X8eQD2QIHApLy0cntGAiWws1adqDbKullBMn4no1fmE9kuIfI1o8Ycq/p0QW9jGV6qzB4YZkx6KBHOFmM0oH+C2XxYIQybZNz8KoSIwtKfI78VGofazDTT/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913716; c=relaxed/simple;
	bh=wOOFbcMB0D57W+KLzn4V9bAvKXI+GY8YT90YemBAyp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Tc43XGMlQZm1g511Qg+fJRLy0zLBCQ+MBpz8WJJAyHNOc6M6EVY26l3PTLNFjBaJSc8BPM4qz2Vd5r7pR/ufSJsklTwHbV701xulS64ZyhJYCQ/dKVOiRR3vTE2asTk1pNPsLREO5I8e/Sw33UA19HsrIZ/hBQjHtQrdAj+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2GD9Z2J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2GD9Z2J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6e954afbdso34477125ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788913714; x=1789518514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYPbCU8yItARlsLn9J/sS/uldVFQSebBvmwOe0YRnh4=;
        b=G2GD9Z2JyZXIsVYWdQLi67J7LXecbvoe/rJ0k5Ln5NvSE1HTHl5tTUjvB7jJ6c1DSR
         etftBwUfBwMf9b07rCMVIs8kWLQXFY4pG91mkYQiVmt9yucZp7nvSvbcgTQUczecDrFT
         L6NChZDFcf1f4lGSHEJYKdJ2fw+Tg7pk6XLK2lVlrQSBJjBGSbjH+iN6czxyQfz46r+p
         adVP5eA+Si8p0g2gV/pgRUkTRVKIHW2IXhyiwdB7lQ+tiIHHUFJ+sD0NeCV08terRxzZ
         OnovmgnSlEYylISMTyeiv2V+8kyDNq9Ay52+IZwMeEdujUl5KgawEVfOwyK3bVPpdxBV
         FgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788913714; x=1789518514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYPbCU8yItARlsLn9J/sS/uldVFQSebBvmwOe0YRnh4=;
        b=R0eMeToT089atCPJ7kY7pZHmTXLGtmb5n4IG15x4rseLVwsR2Jglhm3O82eHmvZOht
         lLItNlkmPV0AkWXcifRGrT3QDl0grEoWKZTQgcYzk2Ae/qk0GdT6DBOLCZTh5CfsLzNS
         EyFyeEsHzfaeOVeqO1KIwOenHyt0Q+B9jcJQZnRimfdM4Eq6CdR8cWQPNmAXjJAb/0Mb
         LFHO4Yh5cuKbNfqEEWU0CY60fvnGHqdRWOZHON33yS/9qWLAz0Hano5XRJz5WncWvzkw
         JPVxINZsTl9P6yabAQ8dEyPnh0AosIPn3DLO6M5AAnqs/OHzfpg/H5tCOuxqZuRRr66e
         TxVg==
X-Forwarded-Encrypted: i=1; AKwUvBzk8lTQa6kIi3St5Vx7HRtFc7/PigtLr4pRyffsuxB3dDY+Mjr7ODpByA1YMgsTcrTvqUJSSBc=@vger.kernel.org
X-Gm-Message-State: AFuF++k1DvN4Baglq1UUonwfMDaFqWEd8FI/mu4UmE6OHpy57RE/hRS7
	vIvN6V++uDfMPz35ZhvOVWuC/K7LnXc7vOmgf12JWoITXKiXVLafqbTi
X-Gm-Gg: AYBFou0ayWivR1SR3bpO77T1Bc9t4XoBN4h/9i8iGMTNJu7tVtUGjHuZaMMQJwWnTTV
	1Z3ISWP5fVwnuM1DZ8kxLsLyEfR862BZ6cqR9jGLcEcSPO2eBQJj4bppHgjNkVn/96vYJ6LxDIL
	GdlfNVdMbPKYfztejx/lLp4svZY0Kc9wkS7u+dB23hnJQfny97Sau1NUxnE22TuBmyuifM0ggFr
	esLl65Tmi3HasTpYdtFIaOGNYgILu/W1sj8IjBi/pVcEoQ0rcpdksijpkjELgnaSlL0kZCF+ZHm
	poNfRnCdg6QYg71oqenf7tYdR/ZJqfcDtbiNPPbA6fRuGY/QBvMReDXMAD/1I7eebb+Sdk+Rc0B
	6QpoJ+VT88tDBGx9AnCfGzqMt4H1hHjy3rv0+oJVwmmNMkSuWzK3sBB1tpvgoPgh0kmiXeRiEh2
	1YCzXa4CodBdsJVSzlWG12H3ikS6meXof4jzIda/UGPzp8O6J+8FvVQg==
X-Received: by 2002:a17:903:289:b0:2da:e67a:87d4 with SMTP id d9443c01a7336-2db1268128dmr476008115ad.19.1788913714218;
        Tue, 08 Sep 2026 17:28:34 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::3820])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db18a1eb47sm63337795ad.48.2026.09.08.17.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:28:33 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: ionut@badula.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: horms@kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH net-next v3] net: starfire: fix ioaddr sign-extension causing ioremap() failure
Date: Tue,  8 Sep 2026 18:28:29 -0600
Message-ID: <20260909002829.224639-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908124119.GW40544@horms.kernel.org>
References: <20260908124119.GW40544@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioaddr is declared as a signed long, but is assigned the result of
pci_resource_start(), which returns an unsigned resource_size_t.
On configurations where the BAR address has its high bit set, the
value sign-extends when passed to ioremap(), producing a bogus
64-bit address and causing device probe to fail:

  ioremap: invalid physical address fffffffffe480000
  starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting

Change ioaddr to resource_size_t, matching both the return type of
pci_resource_start() and the type ioremap() expects for its physical
address argument, rather than unsigned long, which is not guaranteed
to be wide enough on all configurations. Switch the associated error
print to %pa accordingly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198035
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
---
v2: use resource_size_t instead of unsigned long, and switch the
    error print to %pa, per Simon Horman's review.
v3: rebase against net-next, no content changes, per Simon Horman.
---
 drivers/net/ethernet/adaptec/starfire.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index f1109d90e1fc..b2f3998e128b 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -634,7 +634,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	int i, irq, chip_idx = ent->driver_data;
 	struct net_device *dev;
 	u8 addr[ETH_ALEN];
-	long ioaddr;
+	resource_size_t ioaddr;
 	void __iomem *base;
 	int drv_flags, io_size;
 	int boguscnt;
@@ -664,8 +664,8 @@ static int starfire_init_one(struct pci_dev *pdev,
 
 	base = ioremap(ioaddr, io_size);
 	if (!base) {
-		dev_err(d, "cannot remap %#x @ %#lx, aborting\n",
-			io_size, ioaddr);
+		dev_err(d, "cannot remap %#x @ %pa, aborting\n",
+			io_size, &ioaddr);
 		goto err_out_free_res;
 	}
 
-- 
2.55.0

