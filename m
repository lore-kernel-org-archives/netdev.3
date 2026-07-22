Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D230C37C;
	Wed, 22 Jul 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730113; cv=none; b=EB5BndYxiXn+LZWVIZZGGtVdOl7ByyFd7Q3f5EiRHWNCnBcCR7VygKQYEEczaGKIoIcq1USVfK2ZKOe8szcreCYuLueoE9Kjgyx0dbA9JXa2HX82tNqeR9Az0eY/iJr8el6xrVDYlE1aPnxJyY7XRhnuqF8JgI0Pt5x98UikCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730113; c=relaxed/simple;
	bh=DQPaqMbtextPLIv0+G7aRPIOBIout8MSabxv0GtPI8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMuNx5c4f6BJjm2AzJd9Iu7/ui1/V5Jg5HUXxg1RfobXm5NIy9Swol5kOsDrNd0F/CAOpII19z2K3k66xA3YHcsWZdIbOEfWJWOwNJ7cd0P530HkOjFcQegjF9nUpk0VKq39NHmfgptiPi1xnPB+C0f6v/FL67ZjxwkCGSvHGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q9U+aIf/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q9U+aIf/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 464DA4E40ED4;
	Wed, 22 Jul 2026 14:21:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0DFD60388;
	Wed, 22 Jul 2026 14:21:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD5B311BD3A22;
	Wed, 22 Jul 2026 16:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784730106; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=j5WRfwe5s7CD4n1/aXk/GuB0uSEMmPxIt38DrP+sT9s=;
	b=q9U+aIf/4yDREUm1HYpEzUsh0wIcz3rw2jHYkX5xMjcB7JLX50HQtTMbtSUvrI+VGae9vu
	YVn7SJP2PnfWlPRMHtkm3ieV2/EjSyukXuPY/zb3qRlGRCpIZ93uyHhkEhfaMIJ2itr58P
	m4fuxIAyPKu+js9RoCTwmMzZWdiIB/E61TY1nRJ6h2SCwjls1890/wwN/Eo++VVj9Jg7hv
	cBSEzLVgL3MVo8OtY7lK0sul9jXiSg3JI59jlM0m+npiflq+X01XX8jTtz3s71A//I9284
	mrnjhne27BDlfP8nEzrkqxzU4wCNDZfNqiT8QqIpKoQG8aQDG8j/BAWR9cmDJg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Yao Zi <me@ziyao.cc>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-rockchip@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	s32@nxp.com
Subject: [PATCH net] MAINTAINERS: Add myself for stmmac ethernet driver maintainance
Date: Wed, 22 Jul 2026 16:21:24 +0200
Message-ID: <20260722142125.1767689-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The stmmac driver based on Synopsys' dwmac IP is used in a very wide
variety of SoCs and is currently very actively used and contributed to.

It has been orphaned in January 2025 after the previous maintainers
became inactive, but Russell King was providing very valuable reviews
and fixes for the driver at that point.

Now we're seeing more and more activity on the driver, but are lacking
people to test and review contributions to both glue drivers as well as
core stmmac code.

I have access to some variety of stmmac-based platforms such as socfpga
CycloneV, imx8mp, some Allwinner SoCs and stm32mp1xx boards that I can
run regression tests on, and I'm offering to step-up as a maintainer for
driver, for the time being at least.

Let's hope other people will eventually join this effort.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Sorry for the huge CC list, I tried to include all stmmac glue
maintainers and associated lists.

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a674e36529f7..bea104a7e522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25972,8 +25972,9 @@ F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
 F:	drivers/phy/st/phy-stm32-combophy.c
 
 STMMAC ETHERNET DRIVER
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
 L:	netdev@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
-- 
2.55.0

