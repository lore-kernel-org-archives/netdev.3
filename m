Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9BA4B7A5C;
	Mon, 12 Oct 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824295; cv=none; b=C94quohFzCKolehX1CyYBvCkcXPAhJ2+Dy1VKOezhiGGBkCkrVt/HlY+jbaVvljiVNH4fWzxUfn+Ih0lTQN3vUzbUXiMJpg2f9gGIil6ESUFhGSdtOLrB6QfA/DBWz4V4IQPJQwLykj0Y6b+3VN2Tl+pKEmsvz/VGosf+p/Ve5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824295; c=relaxed/simple;
	bh=cMwBAastac/SwLSfCXNFutcItb00suFmuq/i2VUWIL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAqZ8BJjjV/6/RcLfpiw5ei7K+ZzhpMjtNMnbKJu/HqsTFyt2VUwdHKr6JjAmRJM5ttE6Ucf5rzZUOnuj/xTX1gglss9r8y+mhdNvd8GGw8eyMPdTXU/BOayYVS8w+j4J5b8DNQJDBE0O6nrJzRj6aWk/+NwdB7iX6Y6UBsT5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=rvMpFm6B; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="rvMpFm6B"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 678E4C0000E0;
	Mon, 12 Oct 2026 09:58:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 678E4C0000E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791824283;
	bh=cMwBAastac/SwLSfCXNFutcItb00suFmuq/i2VUWIL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvMpFm6BJUVAyUyvMoXpg6qhiAfJiQyKOkIZoIN3leoMGcQZeTzVz9yulFNGNnPfA
	 xvkkEU82Lyow/RQkCU+3QhcRcPeicwnUezb19VbI23fLx+JQ2c1y94eSKtM4k0STYf
	 aX0Hl6yU/MqasOsOPMNTsWd7vEz3OUyo3TNCCMIU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 122A9AEA2;
	Mon, 12 Oct 2026 12:58:02 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
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
Subject: [PATCH net v3 4/6] net: bcmasp: fix OF node reference leak for phy_dn
Date: Mon, 12 Oct 2026 09:56:52 -0700
Message-Id: <20261012165654.3480668-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
References: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcmasp_interface_create(), intf->phy_dn is obtained via
of_parse_phandle() or assigned ndev_dn. of_parse_phandle() returns a
node reference with its refcount incremented, but of_node_put() was
never called on intf->phy_dn in bcmasp_interface_destroy() or the
error unwind path in bcmasp_interface_create().

Acquire a reference on ndev_dn for the fixed-link case as well so that
intf->phy_dn consistently holds a reference, and release it with
of_node_put() on teardown and error.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index d679c796c8c2..693e8cdfe960 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1298,7 +1298,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 				 ndev_dn->name);
 			goto err_free_netdev;
 		}
-		intf->phy_dn = ndev_dn;
+		intf->phy_dn = of_node_get(ndev_dn);
 	}
 
 	/* Map resource */
@@ -1338,6 +1338,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(ndev_dn))
 		of_phy_deregister_fixed_link(ndev_dn);
+	of_node_put(intf->phy_dn);
 err_free_netdev:
 	free_netdev(ndev);
 err:
@@ -1350,6 +1351,7 @@ void bcmasp_interface_destroy(struct bcmasp_intf *intf)
 		unregister_netdev(intf->ndev);
 	if (of_phy_is_fixed_link(intf->ndev_dn))
 		of_phy_deregister_fixed_link(intf->ndev_dn);
+	of_node_put(intf->phy_dn);
 	free_netdev(intf->ndev);
 }
 
-- 
2.34.1

