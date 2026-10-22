Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708225;
	b=roieRCGEfZDSHJrFE0VrE1cC5oDCLRfxIqTd+I/0JMmV9Z381B42FUQwAsq8QsT0OZTd
	 Ic63d+Ldn6uOOndtImow0zGw1CyjDvE2ifvuXIrr8o7vxi8psvplPlHMyWCIjan2qg8FT
	 /IFKDqBEWN7NqmmsoWDFQIzqILnurMzcML9SRSYXJAnPcX5j6YnivJRj+LQfaQdT76ABe
	 JgHBEEVX2Qjic+CvpQOWx1E28cUCuvoHB87fFy62BMTzjSx4WHvTRHIkSkEAoNrUU8bum
	 d8J/CpxkGZ/dbsr5gLAWy0BBa34ZdHkVmyG7J/v/4S87BB13SVTI7WlBJppGYV0m1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Plu3+ssJmDtN7QABnZS/dzw7T36ZZ1uQzc5jvzqtel4=;
	b=OhQJZrkCsEpH5ox3I1Lnuz9AvKGm7UeND/WtFCpOrXGLyI/VxS57pydA7irocVgrgqve
	 mM+qVPT5QKAuJYbz4VutmeDqU9tPVkWnEFN2OUGU4rykFn/IOoTQyVD/sHRfrHvle0+Q2
	 K6Rp1D61QLMVrHMiy015xqOaDDu7voRbWkqU0bJCJCUfZcsmQpk7y53WUsCxd0juOc6Xe
	 pNmbCGWDLZ5idixER1YVUMm2I0JGe2tDOENj407+Ni2QxWJri4g7mTbYpw1lpxcooMvIR
	 C5epV2RQyzmJzd5dJDT5LN8GuQMQQWD54C2cWK3qhAUp3mqGmVdzf/7sF4xlEcc2a+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Uv2k6mhP;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B03606A32D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B03606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Uv2k6mhP
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso2663525e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792708223; x=1793313023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Plu3+ssJmDtN7QABnZS/dzw7T36ZZ1uQzc5jvzqtel4=;
        b=Uv2k6mhPiQeP5yU8YfvHZplpwjguFYEz748JwfgVSjcRTVTXls1RXkkkU7vmhjMK3C
         AsbW5zsii1/XLgDdhN5Sy0UxdR5x1+1gnOQgyFETh6ixT+ke46+wFjnRoD2OvPIKfXeU
         iiigB7kAqd7opuwEh5I7NJVlHaDHpVSKdf03bRsEUcFBtt6PoYAC4yGlIY/OFKeVFmAo
         vtxgcu2zfxhGyp8t8KWN936ptxg60d+1ET+JSGNHP8A/ODbEDpbL3rlo1gS8qIHDT7vx
         y4oHx6KBQw4ZMJMCh5LgkV/mPmthj9kjR/EtjJkaIPMvzsGz7cDDHgcBpqX5xKLzFILu
         lNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708223; x=1793313023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Plu3+ssJmDtN7QABnZS/dzw7T36ZZ1uQzc5jvzqtel4=;
        b=fDiRes8QtJ+dZw+jMpypyOf9LZGBfkrI8KO0tjycLf7SsXQsSLzLiV7DAvsIbxK1Ss
         T9rXDYbes7sK9vNHXx0ZPUwEZkCPGoB2l2euzyMKx0VgABIO0PG/4G+xcaNhkBZPKzg4
         jMpSz2HkUbYRtjtW7mWqEjl6X0maPM5YTNipcBxJ7uWpMonpMEOs8pwwf/gTN+z3Yt5P
         IPoY1VwImwQalDPvmXMGcM7UK8gMCaQEAzhAb/1YrvooOtAQf+/iaZ2p2qzG5TDOa7Lc
         99r3Kb+dUosFligRXolXCbKOvBoE9ahHQirv7CxTeo+fN3yjOKQETHQUgk2eM0SXP8R5
         kzDg==
X-Forwarded-Encrypted: i=1; AKwUvBz4Flkik5Ykj2yx8pcjMW4D7DtqZrV+XVNuBZFDiNNcHJsQhGyGAsx5jEdWHIeH3OKMDgzcK84=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR3VRUeDJ0pdmiPB9n3bDVJ1UI0o6arcl2P1K2kHWQVd2i221z
	0gaytmRDSGtmoOayrWHXi/MuXCESb6ZtG3LIg1e97Nc3OtFvFEnbqadU
X-Gm-Gg: AYBFou2ma82k8ojCcwmhMt2XMlXnVudJavJn7aoGxmq4/l+hE3H/1iiZxZAPMEOGPeA
	ooHQ52MJfgUKE+DtZqoAvUa8hdguwGadkqUwQqb5fYvN+VdcOjmapktDf1lD9p/sKeB3n9dNOrp
	BGoRLejrv3nT2fXC6hJihDuwmS3B45/VaZaO5q+czC3BeIiyoqOzICs9wKSQPCq8f7cG+CCwl+3
	FQ+1tT348dXoc/IAHfTIRnL45IYliKaCV5WjV0VHelXPKW/LE4mz95qKsIEPw82FJrWSrycRMGx
	FMEoWG+Z3iCpAqufH0KEkz2BFt/16LL/1kXnXswTLCpTblAX96DYPsfG9A6JZ1sf9HJ00GDJYh9
	jjjijnVFpTWGvkcXfYlkp/3Ypyxx14X0vgVRN/Mercq+WkuzMjR3L6yrZByUq43DEB0kVs9CjPX
	C2Q+n1N2NcKesy2GD/Ec1QNXeyl57IgGYo7xS7uJWwEp1IWtc/Z4kBSLuatmSUHVOecN5DwwBkv
	nmaxvfJJYfWBZ+r35bnrlWLIKKBkzjZqr8SCb6dBr28VZFxR/6W5MJPLk/29gCqQsy3+X1VRMkM
	gxmwxE3qyGp7e/vbVSL+eL6E2ZEzKLZWqnUjL4oPXfwjHZY+OW0msJBESlyn
X-Received: by 2002:a05:600c:e548:20b0:4a2:1364:252a with SMTP id 5b1f17b1804b1-4a2136426b5mr1430135e9.3.1792708223011;
        Thu, 22 Oct 2026 15:30:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a211be8f79sm11958795e9.14.2026.10.22.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:30:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/4] net: phy: as21xxx: handle odd firmware on loading
Date: Fri, 23 Oct 2026 00:29:54 +0200
Message-ID: <20261022222955.698722-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022222955.698722-1-ansuelsmth@gmail.com>
References: <20261022222955.698722-1-ansuelsmth@gmail.com>
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

Even if firmware for AS21xxx should be always u16 aligned, we can't assume
this will be the same forever. Better address this by simply validate the
index before reading out of bound from the data buffer.

A zero padded buffer will be passed to the AS21xxx mailbox in such case.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add this patch

 drivers/net/phy/as21xxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index e2988cb10c04..db1a7cd68cef 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -325,7 +325,9 @@ static int aeon_firmware_boot(struct phy_device *phydev, const u8 *data,
 
 	/* Firmware is always aligned to u16 */
 	for (i = 0; i < size; i += 2) {
-		val = data[i + 1] << 8 | data[i];
+		val = data[i];
+		if (i + 1 < size)
+			val |= data[i + 1] << 8;
 
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
 				    VEND1_GLB_REG_MDIO_INDIRECT_LOAD, val);
-- 
2.55.0

