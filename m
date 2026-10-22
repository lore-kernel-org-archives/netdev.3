Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697381;
	b=JRznPfmo6b2nonW4wJKmYEl5PNry6mfwGlEh8k/l2JBmFPJvSwdjmSn4Txqx9pz02cu4
	 tyTmsLIkPEmzHcoPz62xMeAQkY91LxcFM4QvkDnsyuYEzzBeMab9l9vDwSjqHlyObSS2i
	 QgaziXXLlKgKnSAUW/wfe2KscjCpw1z+Z5TzMaMw6bQRUDwgA45wrQX1H0oajlwisgDVw
	 gCWuPYt1/dLoZHN1MbsWI8tIYQ/BJiqY9WpqzCsqvoqKf+sqgfv7g7qkn9k9EXa/kwGwD
	 bAk71goL2+L8HuENAaHRxSDjscc/goUP71t192+9zKwSb6Rg0VnVQo3ItxjpHqd8TsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r80E+FaLXiNjwBu9/mQZB5r7KjC0VPfcUsV7OA2gnz8=;
	b=oUKGcd7odFfHSmD5pgBr3riCl+jLloEGscoQ3VOa7US0gQ60QMkOnsGuEa2dLrXW6niJ
	 H6eel5ki1BRnEbJFPanwptAb4PUw9Bamg4RMZnRq5tl7lzYC/1sCMmdFiKhQScjlseO7R
	 xZOZF3feFHAvKPHOTopX5GqCkoq2Ug0r+GKq+k7wvCgStefO56VOVbj6wqIeLspEhuuA+
	 5ywjZa5j5gFR+LiwHDVwsBsIGrJ+Si/MTd5Zkj0MxnMryTb5ncoA/AKjwVgnmPRc3Qb8r
	 4sUdurC5gb7MllgoqzBdelGSfHY1+okjz9eEMSNa0hFOg7uxcqkzLSdAz4D+OrrQHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODCmDwaa;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA9606A32A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3AA9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODCmDwaa
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso1764285e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697379; x=1793302179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r80E+FaLXiNjwBu9/mQZB5r7KjC0VPfcUsV7OA2gnz8=;
        b=ODCmDwaalLSWIpa6R3N+4FgXGi0/graEHVWlp+Gqa7Rgm3toA4fthR1lRYMP/fQFNF
         oRoGFcprzo3g3mvlopCbUM/bRbQGvPW3brwF8iWmTA6obM7oXG2uI8UouMv26KTv2yrL
         D1FPbuqOZHPk/VULgFm2bKOcGnAjCq5X2TLOrtqrbXf42DiDDITENsuY+xdry3PTew3R
         df/bNZnZKKH/oDF19EpCGjR8B62Us86VIPcc2LRHvk4M2WEsDOvRE/tsTA6OkTuiAkK3
         R7up2S1MQKjbv4+SM5+Zp962rmjCnU+WTduaIZzHVBKO90LUk8aOSiBRIQR9xx1QoXVu
         J99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697379; x=1793302179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r80E+FaLXiNjwBu9/mQZB5r7KjC0VPfcUsV7OA2gnz8=;
        b=ZA+X/UTPcz0RPI3Cz2DJ46L7DkFmFnTuZ7u16WuZlb/FodMRayWmpNj/eIK4bF5AnP
         K1qzYKf61MM8P35A7TF5rGY6ee1dSTzZSZlcHH07Juu2wnrIsKU3Khh6F0q+uAknQh/y
         eGQW9QdkdB0fx0w07chV9qHN54ZRdaScomDKm/mc9+2oMlfLNHrimDGh/sqC92VJi9WE
         mpjxnB4yZfEWz72GzmpReL+EL23Iw+Houux6Np8WrQISsc3jUnLgAvSBwS3+ynlfvcNM
         /7290qhQixp4HgzwVXP+22n0qR2WMEM5b/OkHMd0iwQoLzPgv6NQNwj+eQG8ZwlwUdnL
         FgFw==
X-Forwarded-Encrypted: i=1; AKwUvBwnwxMyfvC3FYqLS1yQneYd0Pp0ZVr1sgpsxdqshjZpvy9b4CPcHc9vf6Hu6BvZ1C3cgkNZnwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoWPIjQOXe6dDU1FyiGP/iFZ9RFVx44sT8gWpa92HpDoqUHG6H
	i6q0ZYnlrc5N1ogiLkw+TPJWONOKVYcoO/ncVe0ZcXSmUdl1cLP0Bw/Q
X-Gm-Gg: AYBFou38WZs+j+IJOCbSBulL9RA0HpViyGP2TNTBw+kYWMjjeib5BFxunF6RwRxpL2Z
	k1F3bgVK6FRMcKIDv2dWWK23Mfaubg60Dv1eU+1zA4aiDnSfdMcGUTWFeYyE6eDnjKHfax9s7Td
	VE2fitU3P5ErWXQqrURw6Ux+CdIPx1zmjC5qBzb/Kc6x0h0/MKjrIrWBSK1t+r9LVe8DrmYO9OZ
	jYWZJWrXf4In1xb16H9oKCiqja2PlTFwHM8NhZ8IajP2T2TrDsNxvuMno/QPMHIQr5Wy+3lcqwG
	cPtrrk+BBSl5MMqODbcXjk/7L/uoVujE6SQeDMid6XcDVzUXfn4Qifk4NTpWR7zL1vf8xF1y8gk
	XgXB0bBAY0glpKX5zZQJidhD8RREfVfRHIJL+1Stbq3+3xJuLoHtBmbgJYMdvmG1m3x9PJVa+5M
	mDqqK+jb0aGXQKdWYf6XdnqAQfK8bOQdsu83luA5g4ETtQeNID/vMVGzC7z1zqhY/zShctBwU/Y
	7JIw5WmBLxoHQzil5oH8YwLCam/Gin/r5gVC6lvIsgjDB5u/sYeU4xtECzUDuBq2YipJGPk2Y/6
	82E=
X-Received: by 2002:a05:600d:82c7:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4a211ee56ecmr677055e9.20.1792697379202;
        Thu, 22 Oct 2026 12:29:39 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:2010:42d8:74da:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cedcesm20269405e9.0.2026.10.22.12.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:29:38 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: qca8k: let regmap serialize register access
Date: Thu, 22 Oct 2026 21:29:31 +0200
Message-ID: <20261022192933.384898-2-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022192933.384898-1-kuncy7@gmail.com>
References: <20261022192933.384898-1-kuncy7@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regmap is created with .disable_locking, on the ground that the
qca8k read and write callbacks do their own locking. They only lock the
bus transaction, though. Since the driver moved to the regmap
read/write API, regmap formats the register and parses the value in the
map's shared work_buf, outside of the callbacks, so two concurrent
users can swap or corrupt each other's register and value.

Most register access runs under rtnl, but not all of it: phylink's
resolve work (mac_link_up/down) and the LED class callbacks do not, so
a link change can race with an ethtool or LED access and write the
wrong switch register or read back the wrong value.

Let regmap take its own lock. Every user of the map can already sleep,
on the MDIO bus or on the management frame round trip.

Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4c928983b..49be53b7f 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -574,7 +574,6 @@ static const struct regmap_config qca8k_regmap_config = {
 	.write = qca8k_bulk_write,
 	.reg_update_bits = qca8k_regmap_update_bits,
 	.rd_table = &qca8k_readable_table,
-	.disable_locking = true, /* Locking is handled by qca8k read/write */
 	.cache_type = REGCACHE_NONE, /* Explicitly disable CACHE */
 	.max_raw_read = 32, /* mgmt eth can read up to 8 registers at time */
 	/* ATU regs suffer from a bug where some data are not correctly
-- 
2.43.0

