Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61924403AFD
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566132; cv=none; b=UPtWxT6k2mo5Z1XNe3ceVOO3FrmlXIc58TcttarbOAdswztZPPJuEMbrDYYZJDAlk67oijTiLzphV85ldTzaq95Kt9CB6+j/6JSXt5qr6Vg+uxANyCIos+GrdTGGPjXjjfbgn0jxYto5AM/PVzUw3DoLJoQS2QsNTLZpjq0kFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566132; c=relaxed/simple;
	bh=/JYatdn31meLcQd/D3tIjVAyB0LfgwUcuSDHoSPSPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJ9cMW7IHPzwKNpcmxtzRt9qCzRGy/6JuedL+YdKkCc6qh35S/1v5wosnynffT4rktpigVd/Vqobre86mNqXtQA2b/xdIP2d2evLdSNKMvFj24T2Q9zLYpY67kBrJet79kgF3a8vj019y1ooK//IFS2CG0NbVOLqUsMDDbNxDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5w5JPOl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5w5JPOl"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848761b5897so1200788b3a.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566130; x=1788170930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umgcoSfn5DzL6NaHAeud4eWB5u+3aTh8Dut0celLp8o=;
        b=f5w5JPOlGnhfiQS62NMkej/+s9kYgMeN3sO2+d6mkX2Me3NEMcAINlUnHrHjCVwvZl
         6IYbbh4jlgsZayoAcuo6PBq2LElqr9bNhh547wg1kux6/w0fxb1SlUhErZrtvzEWxx8h
         +PnYXlZcofhQOb4pB8/DceAPRmOGF1d8rCT46rkuj6dAT/2kKQWRGebFRVXLfWBJnkEn
         HhLNKd/59Q70U6f5uRGj+0oK+67mrPb8AYNheE7LisgDu8rQ0AowMWe8gfGMbwifJbR5
         iyQnhMpr0wXhfLwDzdo5kBxDBvgu7m1FsnShLo/j/FAr5eA+J5bdjoNf5KacjjWJubZ5
         BLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566130; x=1788170930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umgcoSfn5DzL6NaHAeud4eWB5u+3aTh8Dut0celLp8o=;
        b=LXFL7+JkbpFGN1bMuY5xqI0UIT63XkDSujXSYsRsGBA+Mewxf/jQpb+1yJ7vRaqGhS
         MjxfIzirpaHmLIHJ/uKN3EH5NMBMv0FFlVqPiPvTDwgXx38yBx3cqJXUqW+Lmpys+bLh
         7R5fn0T9AsHLv/qaI7OFSbUSPSNslReWeGJ/oBKl5K5T2WrCECBeWsko/p6y+IXzz+yd
         iUszcYljEe3g1mW5Z2PyuCfHow7Z9bQiX5QOywLKOnoybsMVgkxpzD6cau84F5dA64uP
         ayleius/e0ovOV78zlhimb9ix9FABffsh45v7as/+13pV2NukyFfHrxhBbI9VSLeOCkR
         j0YQ==
X-Forwarded-Encrypted: i=1; AHgh+RrizLQu3H6p0ryRGiTSsxr2xcQkikQyajujzZBFsOFt+/aP/g/EEighqK3GUgtEV3AWLyCDW14=@vger.kernel.org
X-Gm-Message-State: AFuF++k0NSGWIM4Q6bdAr8C+1er0s34/BXmBPpNlWH7QnWJ3RPsa9jpo
	0E/vPEBRczbw68e5tOH/36DaqtwVea8ra3+sPnmmmTUePEqVfbu3C7qCoKQoyw==
X-Gm-Gg: AR+sD10vV75gY0RY2X6pBLr5OpwFU7RR+rCpci02TIwRRgz0TGOm7yKp6g+MB4ApMhs
	MvwCM0FY6WtRTTrufcOePhIqPOuonHiqfMjfABlRVlWEM3xctIPNLAde9R4LWNHy4i/07I6EVlM
	76UOg7oaHEshTpgL7BLSwR4B8bb1uwTrMAylhu3OvC74gBPKXRTijJWH7DAUsMCrY/d+CY5huBP
	kUh7DJzSU633M5/XD3MnppylFKqw8qYAQ49v5jCOc9AQfTHIL/y5KJnw1paKtfK2NTQNx1ATurW
	EoPot9x//giVvG9M1Sn+6/fD/PpVmD2dFyR5dote7IM895AkC5ywdEhwpYfQMJk5CPYJwnWvcDd
	zlm7Y6U39LK5vgKsEYHk4GRp4EljZkaqvZebf/3UGA6EaUti/O3+ri6CxwfmOd8p7nwYUXBwsm+
	Kyc2JfV46XfzxOduBWGyVobYfst6EVxdx5fTigGRYi/VGCPl3GjHMaUsiEwHelJnNPp0UMkfZNp
	SBDqnYo7Bstkwz3kTMo792+VNvGa5L/y5J3W9jYuloQ+oJvEoMhKaGWHkccm3nAfdc1Y9Lvg6m0
	0bw0
X-Received: by 2002:a05:6a21:a96:b0:3c3:954d:278d with SMTP id adf61e73a8af0-3cd3009cf0fmr18811755637.9.1787566129563;
        Mon, 24 Aug 2026 03:08:49 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm888828a12.3.2026.08.24.03.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:08:49 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net] net: fec: only stop PTP if it was initialized
Date: Mon, 24 Aug 2026 17:08:34 +0700
Message-ID: <20260824100834.31655-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

fec_ptp_init() is only called when fep->bufdesc_ex is available.
However, fec_probe() unconditionally calls fec_ptp_stop() on the
failed_init path.

Check fep->bufdesc_ex before calling fec_ptp_stop() to avoid stopping
PTP when it was not initialized.

Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ced4dbf8cd90..7a87f40d12d9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5457,7 +5457,8 @@ fec_probe(struct platform_device *pdev)
 failed_irq:
 	fec_enet_deinit(ndev);
 failed_init:
-	fec_ptp_stop(pdev);
+	if (fep->bufdesc_ex)
+		fec_ptp_stop(pdev);
 failed_reset:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.43.0

