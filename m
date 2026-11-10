Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326799;
	b=0Rsop1/L0tqEnMIiipBBMDeWfLXD9ESdcAceBRSUp2ljzCdXQrLjHMq25oR9J+2/EHs3
	 5Fd+fP9YKqA/3u6snqY11P28OxUlqK0XrdKgiaONauRD4g0YofJ9OUu0a6ZQHoqLf5q+F
	 Khor8LdUEThXCzfms39G+FHveVGk8DACJ5cG8oaA+lAgK6ijHDWrIS427scMqzAS9d0xg
	 mFei7JPo7O/LMiA7d1UwnAQEyFHZ6FTGbFdEqJmmUgcWf5GYxJ1F+MXP6Z4o4Bkq7rwVc
	 aSqCsuNX3IZycNRkKPx31AVw4yimKg0F2YFF2+lnX99bJtye2y7Ty1fwkY7SXEVgy0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kJO+2+1LAsC2NcBt84N3ty/qYLz68nqiItgXHSjfx20=;
	b=v8oHX2Fvl1SLBL1a7ja0eayy+fY+JzcRjwodnDfzbPnxOP0HEKZUqRl4rc8i63StRTHp
	 EtwCMQNg1IVw5YcMFIPaH52q0MB4ABWtnRyAAo6f4BlhCw0qDeVOE2bWNNaqUTDHLWhvG
	 K4R/DK+BqlDr7GHoQGjZewgitrZG3ofqMoWSG7PKxUGXIPU7OMta5qqR5Z9GJhxyVUN+R
	 51m5qH+WxILvWkmex+nHCC0FoeoNta1+K8lW8OjoTTF+YjdwRpDKVc4uBSgESreSzvNiY
	 SEuYhiBzhTzhBTNChfXSFsBSyLZjIo4HZZ9yJuW9HpffvmTcMyNDWLGL+uQOC+DZGrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+kdlYun;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7F606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+kdlYun
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36fe5944e9aso2285756eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326798; x=1794931598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJO+2+1LAsC2NcBt84N3ty/qYLz68nqiItgXHSjfx20=;
        b=w+kdlYun1XgxamcR9SkDJYFCJTMM4Evboj/4Y1m2LNGYZhV3KqmS2dsWF9rLkAXWij
         eJ94HOJ17aj+Ine1vZ7TaRuw5KX9uGGB6QKyquVAWuNMCgeJ5EBQq4V1afNGfUxUBH+0
         SbhkxGDpWxxOA0TRr+I9ihrBVMYTdiCtNYuF0C0GXCbphGn82bbQ7r1WP3MTS1rb2esF
         MvI89j+qe0aso1hG4soMbaLYHaDZatw7oYOPK3qIr8vgZVmLmOu3nuuPMS9rF14Q7VO2
         psE0cYD5k8x/OjstEocqTD9YLO/JJygrvXiXbRlT4ZgicdP/EeljOERPbuby53ABBvIp
         UGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326798; x=1794931598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJO+2+1LAsC2NcBt84N3ty/qYLz68nqiItgXHSjfx20=;
        b=AxOUaMFXJ0tQEeZmgTQ3vcZHnV0VXNp0mylkKn5Fa2ubyCEbEo0Kg8Pfo1ELuz8EC6
         +u+XmyZGY4iBUdZ5yu0wCp4FaEzAj2rU6eOg4WYwqs6et+huHPcZFj6HB4w25JZnEnio
         7y5zcvnNYJS9WKYEGj1j7U/YWtMudx4qTmeVLrTFt8AeZzOPd1bzBZrhSoNzdHwoxohS
         N9XqR+7p84Zn9ESsj0McURaxw+ZZTaoKmGW05HkaV6BR+wP/FW8VunxHZUybIl+I4A/D
         pOc1W0U6VVCnbFYsGhV5TLfkYS72BwbZ+pw/pCP4ELwr2OsNidylg5zZhyrxH6BDGGCf
         LkcA==
X-Forwarded-Encrypted: i=1; AL+hErG72pPmz3CPwEzI0R9f25l2V9ceKJ4CnDjV5ea05j+dxv4EYsodD8Wb+rpIBK0mxcPu8wdbRpA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DQm8bBJwxHxtSZTnn/JOyyPN1ctpxT+W5/arOVQc/kWukSx4H
	egpfWKMc/iCiMbq1Jbygs9owHcKvBIhJePkJgjJjMbWvi09rZb9EZDbE
X-Gm-Gg: AYBFou1Ef8WG4HbxLFD5dnmz0uMs35I4H2smskzfT2hfbEkEQ31g6L8aOF1tY+2KG+M
	PNWL0DOQF63we0/fjJmShtR5YIwvOPBv3cYxHfsdYaaAlnt8fLnXsEDGbVh3zlmlQYX6CNKa4Ca
	Dc+uI7yBHUsw0cRiwlY4VDf8U+xzVHABGUxb3jbpFrWOD73MbPtHHIK7Ahsi0CP3Jrq62zt/Ms/
	ChP0+L44uqCK3tujAeec8kKV4rS7T+D8q4VxlPS2KHRN/AC/d39C8r1SeRBddyoVCK98i5CWhJX
	mSJy6oXAd0Ejb7ZWm7MyTQx0ky06dPV0tBB4cAE0UuFWi1ih1kgcSOqpxxyRpT7LIcWQxcV5DJ5
	xGrh9u2378hBS+ygz6P0ZmkNgkraNYBQ+QW+jQFYyjH9fKcREmRfXrIjEkzUf8K5HuBoib9EwRA
	XTZFtn74EVeZn1zMQ9hQqkRcaYN3ZCk+E/6xtQy7qMgSrOHBQ+hjLM54MGa+g2ZUzBdI0gAS2Tg
	qRSq8nuUL1EKhqvXL0xQWSZ0Z5zyfOCHPwV8omGVHIxffcRPEzeyLYkg9XyX4EDYjuJ+osRjIug
	xw5GgM7X9UgBqFGO1OHcZno+4t0=
X-Received: by 2002:a05:7301:d188:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-3751eb8ababmr3534905eec.13.1794326798150;
        Tue, 10 Nov 2026 08:06:38 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm8453403eec.7.2026.11.10.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:06:37 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v4 1/2] net: phy: move DECLARE_PHY_INTERFACE_MASK_ZERO to core
Date: Wed, 11 Nov 2026 00:05:53 +0800
Message-ID: <20261110160554.918652-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110160554.918652-1-coiaprant@gmail.com>
References: <20261110160554.918652-1-coiaprant@gmail.com>
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

The txgbe driver currently defines DECLARE_PHY_INTERFACE_MASK_ZERO()
locally, but incorrectly uses PHY_INTERFACE_MODE_MAX as the array
length instead of BITS_TO_LONGS(). This allocates significantly more
space on the stack than necessary.

Move the macro to include/linux/phy.h and build it on top of
DECLARE_PHY_INTERFACE_MASK() to correctly size the bitmap, while still
initializing the stack variable to zero.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 3 ---
 include/linux/phy.h                             | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 757d1ce8d3ad..8071464c7b90 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -315,9 +315,6 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev, bool reinit);
 
-#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
-	unsigned long name[PHY_INTERFACE_MODE_MAX] = { 0, }
-
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 21afc2082b17..43aba23109fa 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -159,6 +159,9 @@ typedef enum {
 #define DECLARE_PHY_INTERFACE_MASK(name) \
 	DECLARE_BITMAP(name, PHY_INTERFACE_MODE_MAX)
 
+#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
+	DECLARE_PHY_INTERFACE_MASK(name) = { 0, }
+
 static inline void phy_interface_zero(unsigned long *intf)
 {
 	bitmap_zero(intf, PHY_INTERFACE_MODE_MAX);
-- 
2.47.3

