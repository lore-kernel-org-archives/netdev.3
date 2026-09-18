Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFB30C35F;
	Fri, 18 Sep 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690579; cv=none; b=OroPtII0N58zJkXEFqZ/qH6+NxNrFqOow5N8T9oKIyabhuoXCPz0aLzucYXuOq5B7IyR7/myN6ThDTzRUwrOkx/Yxwv/WTjj4A/Jyo23XA5LmuynrnFvjgXZPcfVRex02UG0xlBLL3GrmMHfVehmY42FoJh0bw29fFkpWxrhSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690579; c=relaxed/simple;
	bh=jOu25o70E1s7sO22a6z6WGMnC4RHTu0+1eug8yWKmpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6b4xCC3hl4F5BTBnzS9rotxHpNF5Zkhwr74p3Z7cxo6RMo+JN2T1E8gHEsyBRM2LVUIxzj4D3Wed2CQi1PwlyHqUdH4YAb8BluH+4Rkg9yax6wmENkmUYpkQNAlqLtD8pMu9s4JU+FMWSgLq94vyUB4DF67mktpNoLh9ubvuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hYo3vjVN; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hYo3vjVN"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CE8ECC0C3BCC;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CE8ECC0C3BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690061;
	bh=jOu25o70E1s7sO22a6z6WGMnC4RHTu0+1eug8yWKmpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYo3vjVN6I5uFDtgJvMHaZT0aBEjFu6d9WjHVj0Zp7G5UrsamkmXHm8UHKMhOV5UL
	 nXkOsI7viq2naxXOVfZzyUcjj46klxcuGzEiHQl/lMSEjb+jM/2y82ymVc3jaMswkT
	 SY7brTR+qhR3aSeboKF22EEqOZ6L5QqBA20Y7uXE=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id A6521ACC;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
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
Subject: [PATCH net 7/8] net: bcmgenet: zero-initialize Transmit Status Block in bcmgenet_add_tsb
Date: Thu, 17 Sep 2026 17:07:31 -0700
Message-Id: <20260918000732.276506-8-florian.fainelli@broadcom.com>
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

bcmgenet_add_tsb() pushes 64 bytes of headroom onto the skb to form the
Transmit Status Block (TSB) but only assigns status->tx_csum_info when
skb->ip_summed == CHECKSUM_PARTIAL. For packets without checksum offload,
or for other fields within struct status_64, the status block contains
uninitialized stack/heap memory from previous skb operations.

Zero-initialize the status block with memset() after pushing headroom.

Fixes: 9a9ba2a4aaaa ("net: bcmgenet: always enable status blocks")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I6935e24408ea10f68eb61dce4cced9b0ead5c005
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 90ca4f220cc7..3a6a2f075959 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2084,6 +2084,7 @@ static struct sk_buff *bcmgenet_add_tsb(struct net_device *dev,
 
 	skb_push(skb, sizeof(*status));
 	status = (struct status_64 *)skb->data;
+	memset(status, 0, sizeof(*status));
 
 	if (skb->ip_summed  == CHECKSUM_PARTIAL) {
 		ip_ver = skb->protocol;
-- 
2.34.1

