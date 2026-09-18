Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF92C3255;
	Fri, 18 Sep 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690488; cv=none; b=Fjdf0igBalWOUFxfVRALenPtFAvMrMd34NvJF6T3P1HsdnkJ8TTcAkmN+eS0zYKAICcwHvAF7cJU8YepciRf2dhSE9p7RqE+opV3OAltmb2helPEVI1i4wdWxcH02NERXRi+hPmf+mPZomAzvNMs9qMwkcj7NgwyfxtW8G2OzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690488; c=relaxed/simple;
	bh=ltgQEPMPlXFyA04U5tftgacR8zuqN+977jnHwjyj9OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+KEj5pLoY6R6RWjuqshGMY/GE+ctdFzUUPQlnPj0G5UylOTx0dxP/rMBXRs4GcmUwWw/+8gR8YGR9w+HymK64Qtat2c8q/jUHRn4lVFqpFbGlRBX0anpfEJ7EDxr6baWX7rfOCudxRbM9ILJdB8yOIxuwmFaemp2+Ts9w56dWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xo2wouNO; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xo2wouNO"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DB7B9C035EC6;
	Thu, 17 Sep 2026 17:07:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DB7B9C035EC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690060;
	bh=ltgQEPMPlXFyA04U5tftgacR8zuqN+977jnHwjyj9OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo2wouNOHvnCkLyjX9tOOS/MMJaxzPK0pTNf2CGpIzrCagHsfZhQD1k8J1T6QTqA9
	 QHWjBwffGjSPTRf8cgO9GXR3oBMmioJHCXNNdijvMrMnURMxLg6IYJTHC/dGcGZyvy
	 YOnCsUFpbnPHEJg44NVtn+AQ0fEy1reP5h7PU/mw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 7D155AD9;
	Thu, 17 Sep 2026 17:07:40 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Cursor <cursoragent@cursor.com>,
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
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 1/8] net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
Date: Thu, 17 Sep 2026 17:07:25 -0700
Message-Id: <20260918000732.276506-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918000732.276506-1-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bcmgenet was converted to 64-bit statistics, STAT_RTNL members were
switched to point into struct rtnl_link_stats64, whose fields are 64-bit
(__u64) regardless of architecture.

However, bcmgenet_get_ethtool_stats() retained a legacy check:
  if (sizeof(unsigned long) != sizeof(u32) &&
      s->stat_sizeof == sizeof(unsigned long))

On 32-bit systems, sizeof(unsigned long) == sizeof(u32), causing this
condition to evaluate to false. As a result, 64-bit RTNL stats fields were
read via *(u32 *)p. On 32-bit Big-Endian systems (such as MIPS BE), this
reads the high 32 bits and returns 0 until the counter exceeds 4GB; on
32-bit Little-Endian systems (such as 32-bit ARM), the value is truncated
to 32 bits.

Fix this by checking if s->stat_sizeof == sizeof(u64) so 64-bit fields are
always read as 64-bit values.

Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I3e9f2f8d4fd136392148d6c0cd4eb40f7ccbe4ef
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b916080f4ff1..7b089de9484e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1346,9 +1346,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 				p = (char *)&stats64;
 
 			p += s->stat_offset;
-			if (sizeof(unsigned long) != sizeof(u32) &&
-				s->stat_sizeof == sizeof(unsigned long))
-				data[i] = *(unsigned long *)p;
+			if (s->stat_sizeof == sizeof(u64))
+				data[i] = *(u64 *)p;
 			else
 				data[i] = *(u32 *)p;
 		}
-- 
2.34.1

