Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AA4AD4B9;
	Thu,  8 Oct 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470003; cv=none; b=U8qcVIuD4yQipYAcLEbSUMWYm7QdqAdc1Bz+gImoCJ1lbszZIYXLVKsKpNUD2ovKoKQVjbzZstFtiVldkE1Dsj55YdarawTk4+2cC8oheVn4P58K4uTE6l2WlBSMK2M4IUuk1q/RfiNb3YwkfRjhmTyItmY5XTB5d6yHrt9Uczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470003; c=relaxed/simple;
	bh=a+d5IY7w3QE/RZd8DbMKk3VQEiD0Sl4OXir9UTWYpaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8gQTFVUHn7AR8Q2kvpkIEXXIjdIAuMlbwv5Wtsp53O51gESoEBfxasWKoyVPapMxaGDPWopXhCny1KTVmIeB9o5NrjZBclgzm9DUjkex9xOUv17CUM11Pa35Y9tZKRPuvN0UFUZ/XRswBWAPugq/OgYPlA2vIqPRgQBLJBXEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBD-000l4X-2k;
	Thu, 08 Oct 2026 16:33:07 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 10/12] net: pon: build the PON subsystem
Date: Thu,  8 Oct 2026 16:32:47 +0200
Message-Id: <20261008143249.3439762-11-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_PON (a tristate) and the Makefile of the core. Hook net/pon
into net/Kconfig and net/Makefile.

The build is wired last, so every commit before it builds and the
series bisects.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 net/Kconfig      |  1 +
 net/Makefile     |  1 +
 net/pon/Kconfig  | 17 +++++++++++++++++
 net/pon/Makefile |  6 ++++++
 4 files changed, 25 insertions(+)
 create mode 100644 net/pon/Kconfig
 create mode 100644 net/pon/Makefile

diff --git a/net/Kconfig b/net/Kconfig
index 76ab44aa439a..117845100a06 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -82,6 +82,7 @@ menu "Networking options"
 
 source "net/packet/Kconfig"
 source "net/psp/Kconfig"
+source "net/pon/Kconfig"
 source "net/unix/Kconfig"
 source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 5b2dd7f07a85..757650c5428d 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
 obj-$(CONFIG_INET_PSP)		+= psp/
+obj-$(CONFIG_PON)		+= pon/
 obj-y				+= ipv6/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
diff --git a/net/pon/Kconfig b/net/pon/Kconfig
new file mode 100644
index 000000000000..af40d4ebd938
--- /dev/null
+++ b/net/pon/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# PON subsystem configuration
+#
+config PON
+	tristate "Passive Optical Network (PON) device support"
+	depends on NET
+	help
+	  Enable kernel support for PON (GPON / XG(S)-PON) ONU devices: the
+	  netlink configuration family (which also carries the OMCI
+	  management channel to a userspace OMCI stack) and per GEM port
+	  virtual devices.
+
+	  To compile this as a module, choose M here: the module will be
+	  called pon.
+
+	  If unsure, say N.
diff --git a/net/pon/Makefile b/net/pon/Makefile
new file mode 100644
index 000000000000..4b23d2265be9
--- /dev/null
+++ b/net/pon/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PON) += pon.o
+
+pon-y := pon_main.o pon_nl.o pon_omci.o pon_gem.o pon_conduit.o \
+	 pon_work.o pon_state.o pon_ploam_msg.o pon-nl-gen.o
-- 
2.34.1

