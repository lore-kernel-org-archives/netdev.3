Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE64C10D7;
	Tue, 22 Sep 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119496; cv=none; b=KSLTd8/THl6E6NRfK70csGKUdvCx8mthg/lf5iWsNbBRJ2S0o08cyjKyOsGsvQME7DOF0VDcd6xEVf+BetLK+Tl4SaowKYUCy1CM5+oul7/ixGFzzhNMZgyX/kiOKSqRx4ZjLSWI4UqnJjooc6KKK4pMibdlr/N7b8TC7el9FGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119496; c=relaxed/simple;
	bh=bdVON6Ht62DqPaZ0tSzxTpeYzxAptaD4X2SL8HloeXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtcyqUHixqQ4fgeM+Czy9SlkpURXXkqO9TvQ3DpavTdW7SiZIWiBsevZw8W6T+H37M0/+jKb/Os1lXjgZvFyRbK8dxdD+5csiurtwsCiwoUfb7qEGlAARFLr+q1+Rl30yQ/qZ/0u/k1XrKR25HO2fFISetV93X9OvVQpz4W3CGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bW+BuVX8; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bW+BuVX8"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 29FC5C0000E9;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 29FC5C0000E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119486;
	bh=bdVON6Ht62DqPaZ0tSzxTpeYzxAptaD4X2SL8HloeXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bW+BuVX8uo4/KI+VGfFpUwObsQCoyh7+RbNEevp98Ub0e8wIOafCdUzheYBdUO94g
	 Jt7MRV/aCe9YllhnOgvKNk2W5itdKM0yQFuKxI7/MRcUAxgIjqbU/w13fiwoToJ3mg
	 X38dIhqG/6ie5pC+CWVrAT0p4FnxrFcfPqmIyft0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 04740ACC;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 05/10] net: systemport: Fix RUNT MIB counter register offset calculation
Date: Tue, 22 Sep 2026 16:24:35 -0700
Message-Id: <20260922232440.598918-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In UniMAC hardware, there is a 0xC byte gap between the RX MIB counters
and the TX MIB counters, and a second 0xC byte gap between the TX MIB
counters and the RX RUNT MIB counters.

In bcm_sysport_update_mib_counters(), 'offset' was only set to
UMAC_MIB_STAT_OFFSET (0xC) for all non-RX counters, omitting the second
0xC gap for BCM_SYSPORT_STAT_RUNT counters. As a result, all 4 RUNT MIB
counters were read from unmapped gap register space.

Fix this by setting offset to 2 * UMAC_MIB_STAT_OFFSET (0x18) when
reading BCM_SYSPORT_STAT_RUNT counters.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index ec43aab11790..9c1b515dc8cc 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -391,8 +391,10 @@ static void bcm_sysport_update_mib_counters(struct bcm_sysport_priv *priv)
 			if (priv->is_lite)
 				continue;
 
-			if (s->type != BCM_SYSPORT_STAT_MIB_RX)
+			if (s->type == BCM_SYSPORT_STAT_MIB_TX)
 				offset = UMAC_MIB_STAT_OFFSET;
+			else if (s->type == BCM_SYSPORT_STAT_RUNT)
+				offset = 2 * UMAC_MIB_STAT_OFFSET;
 			val = umac_readl(priv, UMAC_MIB_START + j + offset);
 			break;
 		case BCM_SYSPORT_STAT_RXCHK:
-- 
2.34.1

