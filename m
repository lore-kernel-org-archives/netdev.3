Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01A41DDFF;
	Fri,  2 Oct 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942336; cv=pass; b=PEh9fpUdqjhmh9L89Oh4wwwxNzarvUD8NXZuKLv8OmcAn8E2527kQnzHqjn1s7Ct5jHSLPPXZnC6gKPC/cm96NXfZbUoDsab2/OjmthPGiT/kOPiJgG/Bsd9bmBX8es0Q8mqG+V56IvNHKH43iO7092rgGzpKOS01BUCnRnAiQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942336; c=relaxed/simple;
	bh=Ne+zw6Z3n3WqVMV2fqf8aZmJmYx2fL3nhRGXxEjmg60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dD7Zsg++cdy+5mnuS3ncPZi5aVd1YAeMBAylRrhdL9QvczpDFpGRetMEMQbv+oWd3U6CFxVY4O2RCkeoERtmYE5VnmQ20KZUDo826BeNraJvQKnMXFaNfnCoaaotGh166YfxioH1p7E995JoA2GhyzO097KZ1Y3EH0DVwGWcZ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OJ4ch9rf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OJ4ch9rf"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 028D02001F2;
	Fri, 02 Oct 2026 13:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hNmgQyAvkv0OKBvtxViWTWhlPKS9kjVyEQNtHLI7nI=;
	b=OJ4ch9rffDh2hHDK7ptPxr2z4ZujtWSnN2giG/QOzYANWl0ZTBctcMXeLQwumQ9aZ5AvHc
	hbUs0lbv6onmCKKMOflxUC1miiR+9uMK3pB0YBc68r39ssAvJeEN5XBuLD5HedxUdtvTbQ
	7QyWBzDAsQUbNmbFNaAAZtlycR2F2AYkgK/Aqf3qi3yNkB/QUTe4ybZGQysug5MXhH6PcA
	EyF6+tqwp7lnyYCcUqm+oEmcsIR5kz442mIa7ck7TgcG3PJzZhb/amZ9GA353UJRxyWM6r
	WVupSbIbrQBzSIgDq39ln+DbU9SVdcjPjitpX1mh4ZgLsy0dQSBRwbKUSoHIaQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790942332; a=rsa-sha256;
	cv=none;
	b=do4ibnfQVrWGy72o4jck3I4O9v5ayU6cU/JjhrIM98Djibv2Q5xohaaKkTis0bTEs8X5iw
	gIZ17FIdewUeb6vnsLnVkrYN/0qkuzfdnFlGDl5v2EGCIt82qG0E5OtY57nQw5zernGYpF
	H3oFD/a+zkNXvafznrpbY5TSYzF4JMWoAenrPnGbR+KzUzFEywGwEvJzBOVqJ2fB0BxB3e
	b+GXZHioOGxGMMn9WCYp58m9hxZ8oRlX9R/A8i8V+DP8BmUAOhAKftpTE+h2uoUXETPbsQ
	9Dr2BRcXs7Cbc64L5f3wnXqpvxLkuXcbp+VIq/OUo460Gahzu2uxLZ5z39xr/g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790942332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hNmgQyAvkv0OKBvtxViWTWhlPKS9kjVyEQNtHLI7nI=;
	b=EJAqmT1Vc8iLtB2jyACcAbK2dZyEGKC6GaudxAFQffpKXhn3hnFRtPZLi6KLbfkvVg6dnc
	EkcqM89HAoOImyqbfcKKU6k+C46qAd4bumRQX7C6qd5wK5RB/Cz83qvBY1vHxlbJqscqSN
	/C+QDXj2zKPNW4SreNgIPUMeo8G7WJ0lnLHmfPCkHnqWuSyUPttaIdJMqQQr+0vk1gI31G
	pXVg++xDlp3+GhV1wCTOh1orirNxbReykoDLGyU48kdNTondnEWa/j4f6lceG2uagJJ0T0
	vlb6D5kRKHPmSCAxtLMXMakQCY8A59+kCC+RleEMc6DUpLctaOKLXxhyfYqG5Q==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id E30EC380BA7; Fri, 02 Oct 2026 13:58:51 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v1 0/8] net: dsa: realtek: rtl8365mb: DCB ingress QoS offload
Date: Fri,  2 Oct 2026 13:58:42 +0200
Message-ID: <20261002115850.962676-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DCB-based ingress QoS offload for the RTL8365MB switch via the dcbnl
app interface: a per-port default priority, PCP trust, and DSCP trust.
It also adds the few net/core ieee8021q helpers the driver needs.

Nothing changes on the wire until an admin enables PCP or DSCP trust;
until then every frame takes the port default and lands on one queue.

Tested on an RTL8365MB-VC.

ETS scheduling and CPU-tag ingress pre-classification build on this and
will follow once it lands.

Oleksij Rempel (8):
  net: ieee8021q: print traffic type and queue count with %u
  net: ieee8021q: add pcp_to_tt()
  net: ieee8021q: clarify the tt_to_tc() traffic-class mapping
  net: ieee8021q: add tt_to_pcp()
  net: dsa: realtek: rtl8365mb: store the egress queue count per chip
  net: dsa: realtek: rtl8365mb: add QoS baseline and DCB default
    priority
  net: dsa: realtek: rtl8365mb: offload DCB apptrust
  net: dsa: realtek: rtl8365mb: offload DCB DSCP-to-priority

 drivers/net/dsa/realtek/Kconfig          |   2 +
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/rtl8365mb_dcb.c  | 589 +++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_dcb.h  |  29 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  33 ++
 include/net/ieee8021q.h                  |  16 +-
 net/core/ieee8021q_helpers.c             | 115 ++++-
 7 files changed, 768 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_dcb.c
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb_dcb.h

--
2.47.3

