Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802991;
	b=kNWztw9neHLC3VJAoL8V92sqCIdVWA/OfmS3tvnsBy7reuB2ROPb2zgEW/MrPWJgyytd
	 WW+Hjxlwx5gSZJ9ye1Z+JklfMXoShUgIqL0Fp7rzob6ZQZLNtM1CtRetfU4awHzKILPeT
	 ruRtbSeCm9E/R/OTdWCQ5wepBFlvLG3OBt51gOkLwPKlrRhKl7dm+h0f4Pst/XiBWEXvt
	 9m9PPluo3+S0gLWPnTmg3wgzZx2h4mKU7Rf/O1Jhek3LJZHS4csCGRxGj5vhqXlJ9bV30
	 FHCSoJ0kMOnlZjiUfvBljDEpoOCMk+yLlTKFMccopGcNLnuLV7P6aaut1tdfVe9Tf6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
	b=avUkbX16RQWHgraYqkZ2FTfTB1nDRtXuktsM1FybX4Ln5wHj8a2EhIeg0vv8z8+8AdL3
	 zUlvIgD9uHtlqyf+/yhHAuspzIHXkiHL6S8SCPWP2EL4IHe/sQdWbD8segNuwET79CEvv
	 we7j8pE4X2WMlZRPdek3Ugea1ubOlL5Rh8B3uvoD/75BXdJxZl1h0rfs61OhjhoeNmcCM
	 IrGkS7tCfRhqCsclK4ZnJafigqXshsRB6uc+XzDB4LYpXWtAqA8ZZ7Z6fiOw5gYRIkF/y
	 hwuKy3DX/wGeCPqqxZhtuZYhg8/QJOCkXV/yqfQbIv3qbxY/jf7wdRNmp+hYLlbjhMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hvss5G9m;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D948606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D948606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hvss5G9m
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1218751eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802990; x=1794407790; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
        b=Hvss5G9mBXHoAafGDDQUN4FuXzGK2I4F28BMoy1eiwhT/Ce+0lcAUND/RSMKtLy5gv
         CRILA6BnD0J2HIQj41dFspHqJggQedsp/mIiEJX2bqkxwK9kXC2LXdJ//pX9P0I8/VGl
         J+Pg2976Iig95d9xreihq1sFJBOpltsLKsrefYl+1CmiS1Sq506b2jJLXqKF8oHJve8l
         mxrZhRIO7tEVjZjDrQrtGurLoZW4zuzDrhYXJzsnqHxHcr7ErpTrUpvs355jM3IsI3sx
         KEKO4d6t4Q4DfIIXOWGunuATiIAUQL7TLaECVXYfZUSAXX8K7xV5CWsRqyYnmrWXIJbv
         H9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802990; x=1794407790;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UsTSTNr9Wticc38e58ZIWY5uITUM7R+lCgEyKvDw3nQ=;
        b=gHgNIN3msREd7Czo6yY0xU7jFb3NGwBXLUeOtOrZu+7EjVr0pl26896r3DZJR7ZPq9
         u/oViKGvkCk6xxWCQhjp5Z0IMMMG6FUNjLPMwTIaSGiugj48G4wHYKhkplOPesLJejzX
         F8agSAF9cn/q4qRnAEfFWlfbzenEbk2Lh70TtefNITyMEocV0WBaREWoZyhhLPkaTmJ/
         XSGb2zJAn2BLm7VBmrkXVxJvN560xlLbrYSYeo8cL4qMj1YJsVuMxdmd/e57Scj3KRFl
         b4JS99roGcTutuwWjd8FEG8PDmrVqE5i/QMWLP9domJcXtxXUM6l7AUorO7eH9Ff0vFT
         BpFw==
X-Gm-Message-State: APuU4Z8+xEC5YCHh9BjtXytb+dCU7P8k2tVnRs7pvFCSAtnSGtUGzhCV
	qBmUFuSXXpW6joFVoY4EEC1/LTqYI6PSWSvF0+bNN1vRWMRzVx614eiMFVnVaMClmvs=
X-Gm-Gg: AYBFou2UEsVZQdJoAmtM9zpadUxr35SaDd/RnkCVOfeL4juIPirA7aV7Q6mQ75kI1+Q
	dweU538IvN8DUJ2FxEK3rgfiM6S0faJ0av0fN5ozEm++jct3NUBmCd7P2KodtYuyWCB40Sg9vO1
	LPx9bIVs/q64/QaS3sgm9HkuY/TN+RkAIspoJp5Capkb5fDsYHlKKxe+yXuRCOTeKde7HxF7Zpd
	4LMAc6jZBxaj6JzdgP1mlQvzBUEtVqH3Op3aQ7tBZ8FFkGlXnd86WeLr4ZJM0jBDS3OQnM8TNKE
	qI14alysweUWHdcM05yOAMhRBbV+TEwfl/PdFMWJNjtQT+9zUPbjeDnCXdZd+DBQEV0l62d7066
	/u+o4vX6IeaJFeKUSYI4kUCjbVViotTOGMdfSB4+6X1rd30YFJpbWYyP8WRtzgQ8my9/p+NWgch
	6dYcXTJijyVU5AGIdDTlsZr7yAXZ9eRB6zKiDaznlc8XWZ5Oep0ndc7A1PGUSUYQdJqxHa59zfF
	JkjdcMJkZEtNC1qoqgburMHzwVjtybaCqNkQGwkMgHMq4Gv+zfpfzjy5rRMU+UQv/cq84/gUxPx
	9wQX1xKRBZX3iHUadNCm01WH/JeNk1Dbtbi8QczNbonJUMexl4u7C5HoczM=
X-Received: by 2002:a05:693c:6092:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-36a424609c2mr29593192eec.35.1793802990157;
        Wed, 04 Nov 2026 06:36:30 -0800 (PST)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm6208241eec.5.2026.11.04.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:36:28 -0800 (PST)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Wed, 04 Nov 2026 22:36:11 +0800
Subject: [PATCH] net: ethernet: mtk_wed: fix double free in
 mtk_wed_rx_reset
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-double-free-v1-1-efa52326702f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBRF0a3IH2uiRRO2IgZaD18EaRGJ2Ltie
 Ab3XuThGJ7K6CKHgz0vc4CMI7JDM/cQ3AaTSpSWMslEu+xmgugcIIw2RW5VnhZWUyhWh47P71b
 Vv/1uRtjtXdB9Pyt+IfBvAAAA
X-Change-ID: 20261104-double-free-b6b95c2539c6
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793802984; l=1229;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=BAz+fNM/Iyf94+H1t6m97KLkVam+zChfLqMn+estExE=;
 b=n902yQuPJrVcZaUjXryGj97qgtl3JwbpauFUgWDNdIsyHcSg+2Qqp6KztWjzVWsc0l44pJhUw
 UWdl6ZEPjM4AWQvGOzBGd31a3rOHoTI09O+BKXmwl4p8a63U8pOu72N
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

mtk_wed_free_rx_buffer already calls mtk_wed_hwrro_free_buffer but
mtk_wed_rx_reset calls both subsequently. This would cause double free
because dma_free_coherent doesn't set freed desc to NULL.

Fix this by removing the mtk_wed_hwrro_free_buffer in mtk_wed_rx_reset.

Compile tested only because I don't own v3 hardware.

Fixes: 1543b8ff02f0 ("net: ethernet: mtk_wed: add wed 3.0 reset support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/map/216156
Cc: stable@vger.kernel.org
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index f40ac5794341..5e9674c9e63a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1723,7 +1723,6 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 				   false);
 	}
 	mtk_wed_free_rx_buffer(dev);
-	mtk_wed_hwrro_free_buffer(dev);
 
 	return 0;
 }

---
base-commit: 11140c51df12e594d6bf2c8d2af5dec63b0219ac
change-id: 20261104-double-free-b6b95c2539c6

Best regards,
--  
Zhi-Jun You <hujy652@gmail.com>

