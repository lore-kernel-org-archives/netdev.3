Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276533A9FC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791515; cv=none; b=EQnnN4Qg6QIfdMY77yh7PPlWUPl6WOMHMdbhur2pePmmLCG7xt8LXyz7gAxkh3uqh6hhE5rGn+5gUSIiWBAJjkdjzLY2sRj2Ay1v22ZsfxNGEdbjZazt0OpUHyjMfFlgyA0ilKfDGRJT22zn8v4MMQwlX/ePsxDoFbd32ZTFBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791515; c=relaxed/simple;
	bh=AZKPiQ9aiRW37dWddoXF7vN7LPSgaz8JeWjzxwFXxXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwdcL9eB0KdSFxr+vSOZ7qkrPlhO0YcERol8eIAEKGvtq1OIVX5xQDUZaaTlkdpmMobkTgBsHT4P52mFxnFC/8k8F6lEoDzJ8TxgXJBPc/8il8NRG7B9W7MOpQyFekJceGqoF1vB8E4RdAsLth8BdK0NI8sDpz6NsToHz3wEaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALMxsfM7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALMxsfM7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49548e01d02so14672765e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785791512; x=1786396312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=stFIXW7s/TnM/E95kc3HUht/NIboKcMs2RNUlN1S+GA=;
        b=ALMxsfM7W4JVAfdzZaQCUveDr5Q9kvhGOPDDKkgoTSR0t2tP6KXBcRw17Nz1nUoNj6
         L988uY9MuHSjVduJjoROoc1SawD/ScSycyl2Anp+iadpxUcaa8GMHa6uCTuRWSjm2qz/
         ol6BVBF9PWZRKO4nwX0TDfrGnMNOEmZxttUiiuBc2jxwTwtZQtUCABZJeu46UwyTqcfZ
         GTZun93V3qUdngbeuoApLKenH0pur4pWYT3syC++8C33zPI80+VxCJZrCQqNVTXKhmcW
         fPx0UjP9HxX0p+HYMWL8TgHdO6+sFm1SD/3DTV1JL5bMupewbByyc6hmr7lH5MK0xRpY
         6QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791512; x=1786396312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stFIXW7s/TnM/E95kc3HUht/NIboKcMs2RNUlN1S+GA=;
        b=BSw5InD+n60EndDvO/mRkglBMNh834oQ+tXXqTL5JTYoBRBd0NIChnDpSPIFCNfWWk
         qzKMWR/rov2EyIhemyHGKxh9XPxt1QX80VMgQfvXndfEypY6pHJGN5EdSYp1Rkf+x40V
         EMKwqHa4+5UIV/SC+D8QLosSkVQXbUwVPErYSSPUBWUvCZgyqloMsH/joPxUsu1djuOK
         i+3dqoXn8Cu9Yj2tZBHGK7t+7B478V8tkneyDHtq38tCStM/zD6iQqccJHhQKOquv82K
         d8VrWHqzOa2PKZhe3TBV1esHyd42+aSPsN9KFowQYLtA727QI6hr64kf+KsbuJAjI9C6
         WSJw==
X-Gm-Message-State: AOJu0YwYVL7pDXLLLyoJI0btPwXyp40AdJI09B1JNa2g5cChhRvShktO
	U4U8Yt/kFJzzAMB3qYx/1ds8bvqR4PT3hmKClabLdBi6d8zDk3XHvFhep7Dn9a3Vajg=
X-Gm-Gg: AR+sD11XYbx+O8UtrVKFPPwH0rOKtRe3wxDLn0IEx9GPyHXhlntXFD5steJg5hZi9bU
	nfCvyvkAubVTXKO/ebGKsQbAyYQnb0uFgR/0RaUBUvURj8M6Eykcn81ryvsu4nw8AAu9TxpACmt
	sb4g7TbtCLFHdzG9fOranpOgI8oCDl4fpG8ZiED4idIbAFmM5V1rI4WoZ9bPmSOzJW2jm0S8O9V
	RUWZ5Ig2FC/f5Y8FPd43upGhJP/IrDnC1RHN8LAkAG7fTKCKOSeE/eV06CZUl4OgQ3F2wgpGX3G
	YphOn+huYfsQKkaQQfLqAcoGn6MvKEhzz0lsbdBgt7iul14a7ebGsv/vpa9OEqmwnGDZDm/wkAv
	2mRE4MBZqHOCVGAq13FmlqDMbPAtUzjMr4x5oEaJDqo85LBN8AlpcWho9lKNWHMqg1LKKu/z/o/
	5RmKHOvm+0X4G0ouzX2jnoQnB0EkYxZuYfSxyINXyCtsv4K/h/oMBkVRLIMWH2zctpzdg=
X-Received: by 2002:a05:600c:4e90:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-4980eb4d5f9mr213539275e9.1.1785791512287;
        Mon, 03 Aug 2026 14:11:52 -0700 (PDT)
Received: from archlinux ([2001:861:79d1:d140:7f91:4899:f5d3:d30f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2da2sm25895085e9.3.2026.08.03.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:11:51 -0700 (PDT)
From: Ronan Marchal <ronanmarchal29@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Ronan Marchal <ronanmarchal29@gmail.com>
Subject: [PATCH v2] net: niu: fix potential buffer overflow/truncation in irq names
Date: Mon,  3 Aug 2026 23:11:49 +0200
Message-ID: <20260803211149.10585-1-ronanmarchal29@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building with W=1 reports a -Wformat-truncation warning on
niu_set_irq_name(): the "%s:SYSERR" format could be truncated
because irq_name[] was one byte too small for the worst case
interface name length (IFNAMSIZ-1) plus the ":SYSERR" suffix.

Increase the irq_name buffer size to account for the suffix and
replace the remaining sprintf() calls in the same function with
snprintf() to avoid possible buffer overflows.

Tested:
- Built the kernel with W=1 and confirmed the warning is no longer reported.
- No NIU hardware was available for runtime testing.

Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 6 +++---
 drivers/net/ethernet/sun/niu.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88df15e6dd74..54dd7281191d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -6021,11 +6021,11 @@ static void niu_set_irq_name(struct niu *np)
 	int port = np->port;
 	int i, j = 1;
 
-	sprintf(np->irq_name[0], "%s:MAC", np->dev->name);
+	snprintf(np->irq_name[0], sizeof(np->irq_name[0]), "%s:MAC", np->dev->name);
 
 	if (port == 0) {
-		sprintf(np->irq_name[1], "%s:MIF", np->dev->name);
-		sprintf(np->irq_name[2], "%s:SYSERR", np->dev->name);
+		snprintf(np->irq_name[1], sizeof(np->irq_name[1]), "%s:MIF", np->dev->name);
+		snprintf(np->irq_name[2], sizeof(np->irq_name[2]), "%s:SYSERR", np->dev->name);
 		j = 3;
 	}
 
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index d8368043fc3b..676d31499ac3 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -3262,7 +3262,7 @@ struct niu {
 #define NIU_FLAGS_XMAC			0x00010000 /* 0=BMAC 1=XMAC */
 
 	u32				msg_enable;
-	char                            irq_name[NIU_NUM_RXCHAN+NIU_NUM_TXCHAN+3][IFNAMSIZ + 6];
+	char                            irq_name[NIU_NUM_RXCHAN + NIU_NUM_TXCHAN + 3][IFNAMSIZ + 7];
 
 	/* Protects hw programming, and ring state.  */
 	spinlock_t			lock;
-- 
2.55.0

