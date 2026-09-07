Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B23B9D9F;
	Mon,  7 Sep 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815393; cv=none; b=GO4y7aRSahm3lqnT1V5tv4IFQECJ3LFv1Qj4NGZeQT2ZZkmA0IC1obwkbEkA3RwurIOtSQAFxO2b2C56KM6hbjqhO1h53WsQyc3Q64ldOkKkfUJpKykVFVf7fkb03mZQvox39VOWtNtXPw2oARoLEogQh6JqVgUNdyoC+Sjoe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815393; c=relaxed/simple;
	bh=UlKeBwjwUYl2aoGciboia37uLJvGoVOXU7lbc76pecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYrNV/tjln1YvVgo7+5jxj/oBHdq/o/l04wSiPk5T5GshXzkN1ZzVjW7p5HCrTkDEIJjcd8qA57pRo4PPAqd2LMwLcg+N56QnHW+t8GTw7OXnnlvcupQABhcpNxot4SXVR2HjTnCvio3XZ9gOSuUM/eyzY4wy/WVMZ0sDLhPkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=eSZ+nwpP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="eSZ+nwpP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45D87A02BC;
	Mon,  7 Sep 2026 23:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788815380; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=zrQ7Kh1IkO0a+G6PE2GwVDG3+P+/2/J2aoYs+helvPA=;
	b=eSZ+nwpPgveHzvQwBtBUczUrJ16o9a6FdPXcyyw+/n4P9VlFjtzghjhESoFrmy2Bu1rf6c
	LN7c5mtHicrEcJeFANBnHWNAkhocZnWMFAnEVz00D6j4DnlfcDpGqVEDIFC4+XK3R1GeYY
	OA3ef1hb4gfjAYg96giR+1sgXk1IQO6Ga4tKkqJrUVPKxHiOsZLwzt7PEHSCqBXsNq0MfK
	doZ+5OOMWo3Yv+V/Urv4cu5zOwSod4HuIa3uNlx2k38bMte//eJhQVnTqtYWfwYDLpBamn
	cX7cspqs/uHAKwcORFamqZKMU5gw5K7YWda4idwM96b4kilgiAnSL1S/app7yg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	atenart@kernel.org,
	o.rempel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] net: macb: fix two probe path leaks
Date: Mon,  7 Sep 2026 23:08:54 +0200
Message-ID: <20260907210856.1673589-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Two independent leaks on macb probe paths, both noticed while reviewing
the fixed-link unbind crash fix [1].

Patch 1 destroys the phylink instance when probe fails after
macb_mii_init() has succeeded. Patch 2 drops the "mdio" child node
reference on the success path of macb_mii_init().

[1] https://lore.kernel.org/netdev/20260902102836.2019355-1-vineeth.karumanchi@amd.com/

Nicolai Buchwitz (2):
  net: macb: destroy the phylink instance on the probe error path
  net: macb: put the "mdio" child node reference on success

 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
-- 
2.53.0

