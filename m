Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029B4A43F0;
	Thu,  8 Oct 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470002; cv=none; b=fyMP1Jn1m/A0WIL7naiENUkjIVgksgGjoPixK5RR3lpNlpIQR2DwpSCoxwLEfkx4kcUG4pzDpXXZZFIeFU9+gBwgQ8VMnukjzu1YRFhpTqG7GoVI/SC4M6aGh0JgCdfbazGxdaEHAqriFwIw+ATUE71MT/rGd/VwXTEqsxPGBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470002; c=relaxed/simple;
	bh=iHTaIRVkrr9m8WvNalQfJTyQ/M71w6Tkd+5W1P/qawg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnMdLpcQPgVgpo0AiLu8G9rvee43hggngdFIFW6Yu7FxymZPGY8amTkwLhuaIYhw+A0ynUnIIqVF5TcXsj2BYlWTThD3+/LV9MgoG09U+hWdaoPrD+uqpN3DAMfnHTKz2eduU2b3S7VKael90rpQ5ORdiPa+PuKyYsAM9/WG/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:26fc:ddc6:af15:b0f7:2808] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xEpBE-000l4X-1B;
	Thu, 08 Oct 2026 16:33:08 +0200
From: John Crispin <john@phrozen.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [RFC net-next 12/12] MAINTAINERS: add the PON subsystem
Date: Thu,  8 Oct 2026 16:32:49 +0200
Message-Id: <20261008143249.3439762-13-john@phrozen.org>
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

Add an entry for the PON subsystem: the core under net/pon, its headers,
the uapi header, the netlink specification and the documentation.

Assisted-by: LLM
Signed-off-by: John Crispin <john@phrozen.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72ca3aab2106..0513cd25a039 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20774,6 +20774,17 @@ F:	include/linux/parman.h
 F:	lib/parman.c
 F:	lib/test_parman.c
 
+PASSIVE OPTICAL NETWORK (PON) SUBSYSTEM
+M:	John Crispin <john@phrozen.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/netlink/specs/pon.yaml
+F:	Documentation/networking/pon.rst
+F:	include/net/pon.h
+F:	include/net/pon/
+F:	include/uapi/linux/pon.h
+F:	net/pon/
+
 PC ENGINES APU BOARD DRIVER
 M:	Enrico Weigelt, metux IT consult <info@metux.net>
 S:	Maintained
-- 
2.34.1

