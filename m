Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9B3D7D7B;
	Tue, 14 Apr 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162653; cv=none; b=RBbxK8MePVXkY6TuWI03rxnwN2wHViArPS1cP0CV1LJP2+Ndx7u8ycJoRfvCpr+cfG1qN3DUA8l7xYaGuneVzaAhRlzAoIR7NEww72Mtqo3f1wHPZqNCQ8/FunjD32PaimfCgoKJkeMw4m+aGa3PIPZUrIqfXOa8KzLqjjEB3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162653; c=relaxed/simple;
	bh=DT8tSptY3vgegLkhzSOyIhktRHD3jI5dM91CZuVfD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuacnxRyt1mjBmY0pVvr8YIBIqdcz7C+3Omr/zQBtzTOvKNyS4wuYHFJ3YQDG+xeBV8ryDlXcn+51bm7iB4vdVoaUuZmVcz7Non/6CAZcJjPoJyyK0CPuUHTKcu72QprCZjYRjqqk9Jz8ZCplDlfEgpL+pLeJCXLa1G6n/hprkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5E0C19425;
	Tue, 14 Apr 2026 10:30:49 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Charles Perry <charles.perry@microchip.com>,
	Conor Dooley <conor@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
Date: Tue, 14 Apr 2026 12:30:47 +0200
Message-ID: <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PIC64-HPSC/HX MDIO interface is only present on Microchip
PIC64-HPSC/HX SoCs.  Hence add a dependency on ARCH_MICROCHIP, to
prevent asking the user about this driver when configuring a kernel
without Microchip SoC support.

Fixes: f76aef980206e7c6 ("net: mdio: add a driver for PIC64-HPSC/HX MDIO controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/mdio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 516b0d05e16ebba3..c71132f33f8472e6 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -147,6 +147,7 @@ config MDIO_OCTEON
 
 config MDIO_PIC64HPSC
 	tristate "PIC64-HPSC/HX MDIO interface support"
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on HAS_IOMEM && OF_MDIO
 	help
 	  This driver supports the MDIO interface found on the PIC64-HPSC/HX
-- 
2.43.0

