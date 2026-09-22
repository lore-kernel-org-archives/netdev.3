Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29E3839A0;
	Tue, 22 Sep 2026 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062320; cv=none; b=ABPHSNE1oOC9/fqxN4ki40TtAHMXMYl7H9wA7GQvqjvOzk537muAeARvIx3Pz3wspafGN8nPQ6+AFFpjGh9trVkUCSIofztVB8PlUlLrcdjnsvPhxzTwGhyP7iPDQ7LxLQwZQCxVFLZSiRs9hoWJ2A44ARnu7Y0+w7kvsXo+ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062320; c=relaxed/simple;
	bh=oZ3iJGvM4xDk5Uoh2lk/XSP9ju5Rskh9YFXtmG7sbT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn35aqksJzwjuh6pRLBFxMpHU7BQyZnkMGbDq/CHiuJFP1zmUj7LP2f3x5a/lxlJyn9zkV3c2yEVUrubjUgviTmEepZWi5HjKoE/c+OtpwM59ltIjLPStxuPA76OKJyt+q0B2QTVqI2WqhWhYH2anPce/GMm1bphDkpjkNIfGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XWkpkMJA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XWkpkMJA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54E52A3808;
	Tue, 22 Sep 2026 09:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790062315; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Gmo4tRlnZTaFCi9/Yl+BBe9ada+cd7sZvdg/YYdmQ9E=;
	b=XWkpkMJAYbOapdtfRG9Jr+m3UOigyWWCyZMqRJnrqJrfVMjswAzScrJRmWa//B71LmbVuz
	sqKGFwjSyO0ww3GMX2D0hqCF63a1WFikFSGGMZHXvBoyH7QRaKqjEqQE3Qh9g9gs//XVBr
	pAFiNNHEejcVaxeMeufFT22iTy/HFKrCDb3ywCHfLbB94J+dqyyKyrLwssv9TDPIPTTzKk
	HEaSNrcQSoMu1TtyVH0uDPn7+dTO8wktNGX7AD4NiR8Bf1JJ5lFQuTDqOTucK/cYouQYbN
	Eb7jpJSkQPBi64i2SmcisM0/W1NESOQ7egalX+VPkIHIXUxknkX1IK2PF+fZrg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] MAINTAINERS: add Nicolai Buchwitz as GENET maintainer
Date: Tue, 22 Sep 2026 09:31:40 +0200
Message-ID: <20260922073140.1471858-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

I have been contributing to and reviewing the GENET driver for a while
now. Florian asked if I would like to formalize this commitment, so add
myself as a maintainer.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3ce77c839b0..3575469643b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5454,6 +5454,7 @@ F:	include/linux/brcmphy.h
 BROADCOM GENET ETHERNET DRIVER
 M:	Doug Berger <opendmb@gmail.com>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
+M:	Nicolai Buchwitz <nb@tipi-net.de>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.53.0

