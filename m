Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED743F0B9;
	Thu,  8 Oct 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493656; cv=none; b=hGsHMgemopE5OgfepLVYw+uW+gkIn8YR4XbynO+VFFMXXOMQ2Mtx9mdMuQc3GRTJ4iUeTK6h9EUvxZLZ9bhHPeAWKa1TAHQHPVdjH/n+bowxHh+PRAWLnhTajj5Eqo+NrO4rN2eo1xxzxGH2tjDbeXbuAz9ccHOCv0IJ736faJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493656; c=relaxed/simple;
	bh=fhAXelu1j3bEqB/lYssgDg3EMsYtReun5p/aki3goJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noA4i8sfn1JxHlKr8GJa28kbeECrcZmf6/bZPairX5qQ6G2C450qf9xmM+pt9UYOiZmw2XTdq+Pz+dYqFgS0FDN2GaDqDopAK5fw5q2sjnGt9pdnH2YNgpdVvpnbPzugTjRJ43tX1a6A+Q78fHeB0PNO9elWduyJS4w+Irbj42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BWLWweoP; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BWLWweoP"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id C013AC0000FA;
	Thu,  8 Oct 2026 14:07:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C013AC0000FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791493647;
	bh=fhAXelu1j3bEqB/lYssgDg3EMsYtReun5p/aki3goJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWLWweoPq0CqK3V9orCcKhkmv3THiivmCp3m08ymVOdUaYFh6O8hegqXFAskZryiA
	 J5WdgXxMyYWzHYzpxW26wfviTPILP2ydqyRa9bthLVjZKYcNdt6mbhR3I8CYF9okRn
	 DuZ5ViqM5HXj1b3IfczlwlMzGFRNjiY9BM7nJJt8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 67D59A88;
	Thu,  8 Oct 2026 14:07:27 -0700 (PDT)
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
Subject: [PATCH net v2 4/6] net: bcmasp: fix OF node reference leak for phy_dn
Date: Thu,  8 Oct 2026 14:06:19 -0700
Message-Id: <20261008210621.1374785-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
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

