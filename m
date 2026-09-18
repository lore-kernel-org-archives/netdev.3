Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230F30BB8D;
	Fri, 18 Sep 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690578; cv=none; b=RqqEdOc5Gqv69HdRmI7m9TvfeLnPnnqyeTeiFMwJIzRwUaci2PIIG+HqEOAnak/2YKj+6H2YFPvMRpP5WGEV7PjGyKNTjpwkPETLFFVkoqOWXfd61a1HYQVv0822/v/t1iBHi6f/YL50D+HSxTIpQ5RGUEOyYp+Wj4jWyVojlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690578; c=relaxed/simple;
	bh=+B/szHm0JdqOqFYXYObPXuCuRITYUel5hBEKnNBAIcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwoiEJ5DCx9SPvNIVUG1uzkJkoq/KXGeeIpDUxiJuNY72wVbr5HvJZyY0ZYr4HXshd63rfXx0SUCVOzWe/3mfdVOEm6igQUBIMyngrxk9kzrHWkFAYIrq+THyA0Qgymkr5VpfP4ehSOgUUKFVpbI5izo8qJCKljCDzmumyZDMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NLLQq2Lb; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLLQq2Lb"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9EECBC0C3BCB;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9EECBC0C3BCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690061;
	bh=+B/szHm0JdqOqFYXYObPXuCuRITYUel5hBEKnNBAIcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLLQq2LbFU3fxGPozCbhdUAmLKzoPq+VsKwDhPSlJhCm3sqzzp6NwO88mcmOn/cL6
	 fsiQFC2jMVm8ojE6JTrSbCGJzoZryGAj/AXdXSrEozXakYHmbiAk847j5YyjoBDpGB
	 uw2ta/mz/LWJdVd0AQe7SQUqZ/acuvXWpsvlmtcc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 76512AE0;
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
Subject: [PATCH net 6/8] net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
Date: Thu, 17 Sep 2026 17:07:30 -0700
Message-Id: <20260918000732.276506-7-florian.fainelli@broadcom.com>
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

bcmgenet_set_mac_addr() did not check whether the provided MAC address is a
valid Ethernet address before applying it. Userspace could configure an
invalid address (such as all zeroes or a multicast address) while the
interface is down.

Add a call to is_valid_ether_addr() and return -EADDRNOTAVAIL if the MAC
address is not valid.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I1cae9178ff2c9243510556f42a194058c10aea7e
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 799da63e3a4e..90ca4f220cc7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3635,6 +3635,9 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
-- 
2.34.1

