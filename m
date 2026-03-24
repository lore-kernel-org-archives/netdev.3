Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75B37BE6F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375724; cv=none; b=u7ycc+0h14uHs495CztruUbOFCNuJ6HHNjm31veFngXWrwzkkpdvwDGWG0DlAK7gsSqnNZT1gBOQ/YaGD/3eRzHLsp/7nxMBf94zxdr8iS49N0rlVPL/AqbMl4FTD4nf2tkUwa3SjvnCOk3LwRdMtG9165xG7NcqpHlBalUmWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375724; c=relaxed/simple;
	bh=NgfLipFM0Dk1gfiBEsohfyHzKpf3P1NucBsd11NO1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRhN2pbnUgSGMJBAyTP76aTsbSx/S/Bjfg6hRdoQXyQDgowDTqNnpIJxhXYWAXwKEuH8D8uTv9YuPJhTGlS7TlHIyLfOqFE34/1s2Sf69d08a214/iYfJ/juXdVFz27PQqi+Dk4qBNWHtRQyKj43bpIqpr9jk36AOvh0WriFqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sytc89EJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sytc89EJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0E38A1A2FBA;
	Tue, 24 Mar 2026 18:08:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C054C601A0;
	Tue, 24 Mar 2026 18:08:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40D1A1045081D;
	Tue, 24 Mar 2026 19:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774375717; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=PNweYHXD+IcTbOdye61fCp5JZUKnt9he9k3dnaA244o=;
	b=sytc89EJZoL+PUYaswLW530Sz7mXHoAqyhSxqUUsBhAdXrYI846GC+ZejX0PohUc3UWesb
	wNGMKHYDAGqSBWM8W6K4YuYLLlkI+tH3rK8H1eQd8kQztqERC0g5xycpUFKMzt0IIC7RhG
	TRD2gbyq0WOTLTnCHM8E4Y/NOURoxGAtqUBI++rPSkS/K2gOH0q0HVF2WZXkksiISbYlLG
	l6U1LbItHYYVAiBy7DoqSC/jf40gEQVa4P04kuN0vk4sHCnUFjISDRHpnvt43k5fLebH6m
	/DNkRaRtS+sLw2VW0pQJf+j+2fjv7dZfgVGeUrRfAMpviCZ0x0fvLU0de7+snA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	UNGLinuxDriver@microchip.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: microchip: Small cleanups for ksz9477 SGMII
Date: Tue, 24 Mar 2026 19:08:23 +0100
Message-ID: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

While working with ksz9477, I've done some  very minor cleanups around the
PCS code for the SGMII port. No changes intended.

Maxime

Maxime Chevallier (2):
  net: dsa: microchip: Drop unnecessary check in ksz9477 PCS setup
  net: dsa: microchip: drop an outdated comment about SGMII support

 drivers/net/dsa/microchip/ksz9477.c | 57 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 30 deletions(-)

-- 
2.49.0

