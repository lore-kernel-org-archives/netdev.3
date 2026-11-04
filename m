Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793699;
	b=od0a7uwQGmC1bTsFJNicCB2qKOuGs7bJYVwC3PKFH6W7ytym55ams9/T29XHtWVBK0zd
	 weHhtE8bg7zb6MpPvzg86uu7p3o+VInGRdcMy2lou49wFi0dAnFDlRp9Ir+d2OMBunVY8
	 +aLbPnzBpVHOVhzUxGgKtgck/NbvnverQ6NnQnv1ikXvG5mJuTbxNcFsbxPRtjpTqUOnl
	 OgTMTU3cgkMTLT3iHncTy+SS9SZc5N76Yldf5CzzJ2/x4Fjzpf9o7kS8YZHZSPLy5jNFU
	 VL4QSzPMRrY5NBRKfbNygIWVx0/Zz4cf5MLnYEvEBQol+qoSXksgaDfUBe5F4pg2lgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pj46THSmK3XVIt6CZehlPvClpThRqk1tLW+1q1fbcIo=;
	b=WxaUWnRoCJ3k/TwyY5Nm+lA0BhQaoGBNAF90U3MDLpmvaPStyAfmO8a2hZyE5+tXkGlc
	 XbNP0xZFb6CjZyCSmbMT/cLPJuvUYl+WybnFlaZmompWVtwKr6u9FPqbd1wfk219YSHfL
	 8qiiMIRLQ7Dytf4HdnChRoKI/8gTiIY0e2aEJr5hoAPbHBNO/orTKSk0hc9U6i31vRi1C
	 VT/hchgGfR31uQgydPPufyKPHhsq0WPuih5lgv9hQSwXSO6BGOPR+ymDgyBfJlZCYoieh
	 NiEe/47xhDF/yk5YEtFPG15peQangjJLqbiE8fAJht2IXlm2pbr89gCFffjrLkvmBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jye49RJu;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78465606D815
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78465606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jye49RJu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c418e215671so87875366b.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793793698; x=1794398498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj46THSmK3XVIt6CZehlPvClpThRqk1tLW+1q1fbcIo=;
        b=jye49RJuZocwZEAZ575Aa1gSX2ycDMU9/pFnLzHIlC1AVD33GD1Fk22NvqOFvRX5Aq
         afswAdJe4KwshMtCSq+GGqvPnTTVM81asFMVc0Jpw52fNYpncJolxpntPVdgtElrgwz9
         dIpLTotsSa33nGoVk3KNQTeNy5iZ6iUqZn63u8FAT7wwMcXL1SeEMJ6UbYv2cL4wMAiP
         SkbHbAfP8+9OBQ6jRMzSNb9rRsscDctjhBA3lR/lOxdGJbtHWajug7d4Ulj4yeV4mfUU
         +UAIkwv9crXFl6pa4H9YayIaJSBpC9fUyGqX5JwjL9hoBd6jppDLDW5W/sdECWPEuAGs
         SnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793698; x=1794398498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pj46THSmK3XVIt6CZehlPvClpThRqk1tLW+1q1fbcIo=;
        b=brrL1Z5i42ewOy5yblZ9JzZKAUrb1ZhYYIziQkIqhVYC11a4+izRLcXIw/ZIZ6V9iu
         dTGn6pgieIaHIoaadRGShw/HdSFwTZlfLgcqgGhTGY9yq7nGcXM7d72FgEOyKuDppJeF
         eBWDZbO2TkrYw77hXoBm3vWzRlwhCL3zxpY51//3WEHdW/0LcNnd36b0urV/eG26qqt/
         5QhWm7i/f9VPEsixFwotxGjvNh6f6Y0lz6TKWX1txchRA2Xh++2yskkR4nmyk/Ts5mmD
         zW4DpLK6lArCVVaKg7UhwxDQP6k0gjG8lhUeB0+azBVeWqQmzNxmyIfVpDWmOvZdKKQb
         hoMw==
X-Gm-Message-State: APuU4Z+4TjOHtU8olXzXh/m4oQ8aVfkulSvOd/QfP9dskuRY6I+/LI4X
	d4gbvZGrtHdN6Wq9V1UhThtWhZMMy/HNWamS2/qQjaMmACYmApnDox+Sh8dLt2tZd2Y=
X-Gm-Gg: AYBFou0RO5JErpuRgxTlikPD/U69lp+ViNsaTMJ//CiXBOks/s2msjCYDJbktkxq5q6
	E4cbFNZenyIHd95uwmXw2R5mHkkAlZrmLzOAUh+QULQFEYdIWGplivNH6BoHTExf7i5PBKCA+yX
	YlzM6b9OUIMrpk7BdccXqQZwFVt71Ztk8soaEH/pvkrnjhdmnukcu09Ww93AwX6WlXXtdDYJC4g
	DtkKt1sIGpNt7WjQ8y/Q7uGm97RgfN1DC/NedlZYhXOKX+urMSG47ZY7TFAbbno6ner3jGazQbb
	BVHhD4779RNMgtaSy6l2Raohl/jjgRi701hTPifGSvey9rigYTGScMIV2Zb67mXXEKp1g/Zlygq
	qUExtINgHZKPdt7UnMkEyYnn4l4Uucd93D7fTFDVe6PrS+hQ48qkr/RQqn+2vDui13lCb3yCkTv
	o6WdDVd7a7k3bDtfba+OfE8OV37S272EIR/kG9kdfZbZRIkcVlzrmiKz9bcpdnULZGB5+UmXD0c
	A5NHcKmvbLU8Os5IvXRMaYauPNCAnnBOShxq1p32jK64xG1HIUUBqPvYemGDzOIMvrPASuZMwVz
	JLF3cjLsOzgT64+whBQ0khUZ5PNkZ0vk4JBVUHHwATJv2V8MXfTIM+hSE/1i3hJHgqsKpsuT7wu
	yZIKxynioVZ01+HSNvlZ5WoZd9AgW0KctNWsHK6iL/hWDPVE2pc+dRwhS
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id a640c23a62f3a-c4ca795fa50mr1804960966b.3.1793793697694;
        Wed, 04 Nov 2026 04:01:37 -0800 (PST)
Received: from CCM-PC (83-233-221-133.cust.bredband2.com. [83.233.221.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e424f94sm60940966b.24.2026.11.04.04.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:01:37 -0800 (PST)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>,
	Stanislaw Pal <kuncy7@gmail.com>
Subject: [PATCH net-next v8 1/2] net: dsa: qca8k: let regmap serialize register access
Date: Wed,  4 Nov 2026 13:01:28 +0100
Message-ID: <20261104120130.48455-2-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261104120130.48455-1-yongzhao.derek@gmail.com>
References: <20261104120130.48455-1-yongzhao.derek@gmail.com>
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

From: Stanislaw Pal <kuncy7@gmail.com>

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
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 07227ae8b..1e4f83e9e 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -579,7 +579,6 @@ static const struct regmap_config qca8k_regmap_config = {
 	.write = qca8k_bulk_write,
 	.reg_update_bits = qca8k_regmap_update_bits,
 	.rd_table = &qca8k_readable_table,
-	.disable_locking = true, /* Locking is handled by qca8k read/write */
 	.cache_type = REGCACHE_NONE, /* Explicitly disable CACHE */
 	.max_raw_read = 32, /* mgmt eth can read up to 8 registers at time */
 	/* ATU regs suffer from a bug where some data are not correctly
-- 
2.43.0

