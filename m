Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8845560E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297224; cv=none; b=CVowtRQA72y4+CqoYFtGxGV3wcpgVQd5gRLjJezG6yTu4nX532sPLjU2sGhil7soFsbSlJ4KbxqeoZch848o9KRs1MOD5CrAwRCUkXXby0jXT7VGm91a0MfjOwUI8qCzllF98h4A6CqQNeZ1YThNR8hwZBfXk0LFNXyI4N9FsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297224; c=relaxed/simple;
	bh=AHtQESmUQDbfBJupwFyXgqeFpsKsAMO/Fmo8tcPAIdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxJ2+H6AUk0qxO4kHrumxTcoI9sNKXjoBbZUGhTrmRyO9m0VMrlr02/KKpE5AjhuircO7NYij6aTeSoTaO7BsNnkqjVoXxK36keKfUmuk7qb5ZOzTlddAohxsPwRKw5SMQKNkDGfrJofiGyyQqPB4+PoscA0h1Ni1EYKpxWdxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po8pjY2m; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po8pjY2m"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08166ac6so403354f8f.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297222; x=1791902022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=szrJLEgfWw06ca3u4MTw98CHDldHiWIyomp/y7G6TPI=;
        b=po8pjY2mGMvZXbwyWm0Zmyl/d3iFN6Wsd0vxmD/icroU0EyutOxuWfDfEXhQH+Z0Kq
         +QHkzjcYh/HAHd6ae5z4wnIP3V4mdiKsB4jADf67jo2kH97vUVwxf9eqChWjcWKOrBnb
         V4SEwjBAdqI9iYX42iTJKUhP9nzY9EISYsanPILJg+LBnpxDQem3rDuFMxrAGgl5PrD+
         HQ6T4qda2YnR4OX9UVFMjC40WuFm8By3PwtaIysiZK2gvDltFqmZ0EceBCgoy1dNsaAX
         FTGIy9bNkgcfW18Y6sBJyXzVkJSLFR5FEgChOIlxCZh+2dLbzXF70sWqsjydEfkdt/Ok
         NDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297222; x=1791902022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szrJLEgfWw06ca3u4MTw98CHDldHiWIyomp/y7G6TPI=;
        b=SpLPy4PMj6udLkK6kFNjTsYjEUagbpdGm/G8mPzXZdcAtQWQ1v3Ve+vNNsFl8StXIZ
         uHWqY7KnXXlaWNulN/UNqOmJ7fCLYveO8dxbthoYUC+eWMoIX3O+I2dNqaUeyIZR2+OK
         ZFPood7mK+iv2XbNONF2CM0q7ZYL7tjeSLequiHeDBGASgymO9F3jU2e48KDRNvIIxAF
         AsQquizNTZJqBD7qJkFm7zuQ+5H6GpaiPA+AFbMn9RZrCA0X1iSJAU3+34KxH9S1LaPs
         kHkEX3Vk86iMAdv8n6hm4E0ADbv8ObXpS9+wmY+Hs0EEdfH8/lxJDYkYqxEDu4XeQu//
         scgw==
X-Forwarded-Encrypted: i=1; AKwUvBxW0kCSPpzptSSChBtTYrazGFDaR+9lCyoCIDAYMNVhcALwbAYf3LytUMtUSQqcbjWjtHcWPI4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLbAn62C/IL/M8eNl4YqjegXxqB24kyUDq3LVMpxbgfG0uYTGu
	Aj8mlxs7Pot3W2VYcXoDVivQT9Jxp3x576yBg1n6nNuzdvbAlgEMeHEy
X-Gm-Gg: AYBFou0pDJyOThJVhCJ062nVZ3tgcdSKrnEo+scFVw27OmDmn369tYwaagB/Nj985wy
	0Q5n1Nb4cDtewQfPBy7zlLviha4ypIRREbhEKlQBpE0EQXagbASIBWtN/KGqXZlPZSF++Kyy7By
	3jdZbPvcQjNnpoyHp00TNSQEJ6ghThVXvMms7mF5mjTqVUsgyOHV9NYQJfg1NoDV65SHdg+kmkr
	SQV+8jmTnQItYxnlSQrNCzo4HDNEV6lPQTgEzu31c9vfGt6ja+V/j43uCOdGJAxR6Hq53mkTPIo
	NjsGsZSBDCS5/+sux7q79CpKujOVQOP4gS1mKgH7eOH4F4Uo1vfeB1iDFmB2LQfxgtEIfK/IrD4
	cmCb8rmzkTv2z8ieQs4OghohnMFU6kQ0p4Wf7T/4Mb6Pvk8w9dvU6osYmjTQ4J87UZn8RFdzoCP
	DjllIITZTsYbc1R6+rbji2VOn4BonheUj9a2b8pJDpsd9rdgjghNy9/wKhSfT7M50XRKDNrSlhY
	yedDDA1gHBTj0Jk/U+i15+nKxIoa7t1KYgkPx4+dR/vVPhopjaD/lE1EPvU5RGj8SU=
X-Received: by 2002:a05:6000:2586:b0:48a:f3d0:5dbc with SMTP id ffacd0b85a97d-48b12711a15mr25744347f8f.4.1791297221448;
        Tue, 06 Oct 2026 07:33:41 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48c62289b62sm10911048f8f.20.2026.10.06.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:33:36 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ethernet: i825xx: Fix dma_alloc_coherent() size
Date: Tue,  6 Oct 2026 16:32:40 +0200
Message-ID: <20261006143247.54724-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sni_82596_probe(), the lp->dma buffer is allocated with
dma_alloc_coherent() and with size sizeof(struct i596_dma), and possibly
freed in the error path with the same size. However, in
sni_82596_driver_remove(), the same buffer is freed but with size
sizeof(struct i596_private). This error may leave the freed buffers
mapped, leaking a resource and allowing the device to access freed
memory.

Change the length in sni_82596_driver_remove() to
sizeof(struct i596_dma).

This patch was compile tested only, and found by hand.

Fixes: f2ec8030085a ("Ethernet driver for EISA only SNI RM200/RM400 machines")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/i825xx/sni_82596.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
index baa598988f47..73e1e153cb78 100644
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -159,7 +159,7 @@ static void sni_82596_driver_remove(struct platform_device *pdev)
 	struct i596_private *lp = netdev_priv(dev);
 
 	unregister_netdev(dev);
-	dma_free_coherent(&pdev->dev, sizeof(struct i596_private), lp->dma,
+	dma_free_coherent(&pdev->dev, sizeof(struct i596_dma), lp->dma,
 			  lp->dma_addr);
 	iounmap(lp->ca);
 	iounmap(lp->mpu_port);
-- 
2.43.0

