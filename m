Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C473E9291
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179416; cv=none; b=fDiClDbHqVVdOZxkLkIfiesvG8Yred2SxaA3saRiXVDr+IO1KoMsL9kPBJKOtl6rRRkhm+CcPuT29FtWB+RjiECYiIf4TutlpqQr2m4cDPGJXzkOwDbgvykR7mBi6vr378d8AKey60zFCFHZxAFSUPDqqJYIbpch8SFZBNpN96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179416; c=relaxed/simple;
	bh=ggSETvh3icY+/hTcESIbhOhiBOa8twMOPdmNAZhTfug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXLGzWEdve3HSoKri/G/lrhpocMaNqpVgLmaz7cuE+OyFUJNP4qv64Al4yf1ylCRuQuf+41kN8wQzyqS3sYVPp/4UrG4gHgdqBEoaADfDgo7nA60JyqicL/6B6vBUk0lkPwMMG+Q4o6dC04dPDyXxWoCaJDr4Nfb+ha1zJmkxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BpVOeRsV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BpVOeRsV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF7B54E42990;
	Tue, 14 Apr 2026 15:10:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A001D60410;
	Tue, 14 Apr 2026 15:10:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B50DD1045127E;
	Tue, 14 Apr 2026 17:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776179411; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pmPEtSYTgH4yoR0eNuKm5NDfBKW6he0d8HChYODJoRQ=;
	b=BpVOeRsVC1RUDrWcNqxrQSLxRdujaoVjZIVmnhvJos1Rn4j0jW8pogg272Bb7fy7WG1phV
	nGd3CBNdZZwF4cyQFu3HAqjcIFmvd7uzzMYRSv7pO9mPsEGVsiQ6dA54PbKUWXnsjLZZix
	WfokWFcvDECE5CaGVfio5/Bty+Z1jVlSu48s2bYs8rLhFa0STt0NLH3BhpXz5tVwc2ZH1O
	7hL8qMTvOUbO0mLdDnUcPBBIwrOYgyuLOnru1/aWdjnM3ETbTCtZFk6n1d4HFyuoC6LMt5
	j2ZaKB3zLuhIdSHYLlJuF+C7KH58gm1NThFdXLPHTNA2N8DcSp058cJC3DNUvw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: fix kernel-doc function name for pse_control_find_by_id()
Date: Tue, 14 Apr 2026 17:09:47 +0200
Message-ID: <20260414150948.744618-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The kernel-doc comment header incorrectly referenced the function
name pse_control_find_net_by_id() instead of the actual function name
pse_control_find_by_id(). Correct the function name in the documentation
to match the implementation.

Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2ced837f375d2..0848097ce7bf3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -234,7 +234,7 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 }
 
 /**
- * pse_control_find_net_by_id - Find net attached to the pse control id
+ * pse_control_find_by_id - Find pse_control from an id
  * @pcdev: a pointer to the PSE
  * @id: index of the PSE control
  *
-- 
2.43.0

