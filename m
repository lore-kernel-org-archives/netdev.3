Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB064C8C50
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607060; cv=none; b=QRgz+fnte6ZQ+JeUKqw0LulAu0xMlSr4w7NibxTzz0pWJV4KPPftkt7oIhz8bppJNmHdxXZK6I4AU2ihLJETQSJ2at0sl7yxCobcu+xL9+A0DlQxvsM4dQmuKpskuw+CGF0aoHAuHgOtOD4y705+y/At0ANXeucsrT6vbnzJgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607060; c=relaxed/simple;
	bh=iWkWDGNdURg+OiihageyrbZ+a1Gfd++w69an/fPU3Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2maWbtVNghqKpf7EHH/GTWhCMT/rq0PWr4c0Jg6XFs4mThAboajJD6S6jPYZHp3rV6zMDsFSZTAfKK6ZtQbl3Pqr7PwZuL8n4e7DqfVNdysLWMMDCLEDJ8zD31FP8cm+o5OAC3tRk//4tjrwtHYuQ9wO7tNOy3wOBaf3zPoQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UKL7/9h7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UKL7/9h7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7ADAD1A1036;
	Mon, 28 Sep 2026 14:50:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36976601BD;
	Mon, 28 Sep 2026 14:50:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4672D10329684;
	Mon, 28 Sep 2026 16:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790607053; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TvuuZ6aLqblf+H0W8nqZvZBIx+Xtg4eiL7p4ol//ojc=;
	b=UKL7/9h7KmpkIo3dALdGSlM5n7z1V5/Yd4YECQ5G4LmP12RroYSNYjfwu7P/4SYsf8U+JF
	54OHmcgorp8B56TQTY85WLxck1r4yQ/ovJbvx1oHdpVRbYQgSaHdYh5bSMUbo+KLjCgukV
	lORj+NtvVj8K7DLUMKPd02Gvm3JE7v83rohMt9sKrrkqoPOaIJJ2gWNAlqKDxDja05yiLa
	q5GR4aCvMdof/nokisMmUqyCAq8HR7eW1meMrwb+5be+XTr9fA9bMOMJQ5jSGMSjh/CKHa
	uIZPQP5flK4JuHJePICzTxXxh6+OXkJKoDYi9oeaiOWtwRV5B308kgP05j8qOg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: Report RSS as not supported
Date: Mon, 28 Sep 2026 16:50:40 +0200
Message-ID: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is V2 of an RSS cleanup for stmmac, discovered while running the
rss kselftests on stmmac. It returns bogus indirection tables and key
sizes, when RSS isn't actually available at all.

RSS is currently not supported on any stmmac devices upstream, so
code that was already useless is now effectively dead. It has been the
case since 2019 when the code was added, as platforms need to set rss_en
in their plat data, and no glue ever did that.

Russell King ran a poll in february 2026 [1] asking if the code should
be dropped, without any reply going in either direction.

Jitendra Vegiraju from Broadcom sent 9 iterations of a Broadcom PCIe glue
driver [2] that actually sets rss_en = 1, so there's some hope that this
may be used in the future.

[1]: https://lore.kernel.org/netdev/aYd4BkAeNW6d0iIC@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju@broadcom.com/

Nvidia platforms seem to be RSS capable, but it's not going to work out
of the box. Let's leave the feature there for now, with proper -EOPNOTSUPP
returned for RSS ops.

V2:
 - target net-next
 - Add a dedicated helper, following Nicolai's review.

V1: https://lore.kernel.org/netdev/20260926093343.292181-1-maxime.chevallier@bootlin.com/#t

Maxime Chevallier (2):
  net: stmmac: Introduce a helper to check RSS support
  net: stmmac: Don't set or get RSS parameters when not supported

 drivers/net/ethernet/stmicro/stmmac/stmmac.h         |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  4 ++--
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.55.0

