Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228453;
	b=SnioJdeF2mBf8+epCwvccc538hvBW2UxXA9L8NMZZgVlCeVbQsuhGvnuN/VZzMH7h52q
	 Um4RlA78YMVVUUjwTUamXi9ekgXQSdmcmvkkTt1Uccm13CZ4dUaToEfzFBfkjfayrV/xX
	 /GrqQ1THC0NkzLMIOOLKsYZlW0ITPXM9xFFvgYBLXa4YlczBHqBSmFM9oVyN4rdLCOWcX
	 ZdvoEPV37Ti408lWgI1q7NuMx+9xjArFbukjWN3k6vY1opgBmCKOithGUtMezFLUqmwpU
	 i9PdvzJ60Mae1VUP7X1mMiHkGO1QtOo0gLk7Q6utcHsb6d32hbxTPrq4OBL3qbe6MZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228453;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Last-TLS-Session-Version;
	bh=QuYZLtnKMHEcAcUxLsM2ljrGy77CRXukRc0UPuPtex0=;
	b=r/bxbBR4jvreLPE+8oyqtWRLowxhUPZGQGVQ4aohXVsCdm0vODXPfqpnfnOvbl+ztUAB
	 xV+Eal6gu0O3dgdiBOMDfyX+cRTOQnBuyxE6em07yozNd3Iz6CxmHQVbeDH1Sv3ESY6Wi
	 Zq7bkFcZy2oPhDWDG+G7ytaMwQJFnbDUuMR54RRWmjVNmIsWeImzrdXYP7HB3S/Tf+XWb
	 5ecqXM3gcifY+qFIJixA/IShlXlZ4nu/JAoJbJ4WRANwgjZ0EzJUOaTkasQKBaCl0vpwE
	 Dq7Q/WDW8g/ybTEoA6T1HT7L/cwsygdSRcZ7nAl+FzwcTBtOEvblqYELXO/Htb9MvkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="CuhI6/9Y";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F65606A31C;
	Mon,  9 Nov 2026 12:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F65606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CuhI6/9Y
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B5D061A15D4;
	Mon,  9 Nov 2026 12:47:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A47260051;
	Mon,  9 Nov 2026 12:47:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43CC2103293A7;
	Mon,  9 Nov 2026 13:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794228443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QuYZLtnKMHEcAcUxLsM2ljrGy77CRXukRc0UPuPtex0=;
	b=CuhI6/9Yi4MgJwoP5jSjEMV1TY2JezkL7wXtTbILwnHrEsbUbHedVvVhd3nLFw0kbDTh7+
	EVKtMEiAquQdTgJt+ov6X8tjbDwV4xEE1xJ2P04EuNqiZWoZ/DfLk/ForN7ViaqZBxEupr
	hghf9WLmxtxzLNkRjlit7zYQGZiLvYcQYMQuv2yKAxlYayxmSuI56A3LONKNp4rchSgLbF
	nJawbjdrvnDjMnYxKUzbiH6svj6XiWY+qJZQbVciXmTGmyF8vZKsRWCwKde/zpb+FDKzDG
	m2JFF8ChItJOlpu4tPrn3/mSWVuaPJv5V0v6cpsqCqBYsqXHkzd0FtUzBsjQxw==
From: Paul Louvel <paul.louvel@bootlin.com>
Subject: [PATCH net-next 0/2] net: phy: marvell: add RGMII-to-Copper mode
 configuration
Date: Mon, 09 Nov 2026 13:44:54 +0100
Message-Id: <20261109-marvell-phy-rgmii-v1-0-026979ef4f13@bootlin.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4W8s5u0TWzAXzEeCi6wBirZVoIh/
 LtVj5PJzI7EKpxwqXYor5LkGQvYU4VuDHFgknthOOO8taahOejK00TL+CYdZhHyJtRt721zrh1
 Ktyj3sv2eV0TOFHnLuP1NerUP7vJ3ieP4ANIeKdZ/AAAA
X-Change-ID: 20261109-marvell-phy-rgmii-60a8bf619582
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794228436; l=764;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=mbGCsPwgAkAZ8fZw5RZTWDh4/18d78xEBhmc27GgT0U=;
 b=srFqsaNSSiMvUehmRjL71ctHxUpboyqiA+YHMYJfQUe/nzbEzThks3C1CgEmD5qKDQXZbgLFO
 MuIRuPJPzArClHUxUkjeVFC/k0vhA5Pf7k595XzKe9ML0EmfnXjjsZZ
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This series add the configuration of the RGMII-to-Copper MAC interface
for Marvell 88E1510/88E1518/88E1512/88E1514 PHYs.

Patch #1 is a preparation commit to factor out common code.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
Paul Louvel (2):
      net: phy: marvell: move mode configuration into standalone function
      net: phy: marvell: add RGMII-to-Copper mode configuration

 drivers/net/phy/marvell.c | 69 ++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20261109-marvell-phy-rgmii-60a8bf619582

Best regards,
--  
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

