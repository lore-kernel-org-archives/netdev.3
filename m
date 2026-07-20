Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A838A726;
	Mon, 20 Jul 2026 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517291; cv=none; b=Whnl+JYX3erpHtAz5XKUFAGOZxx73dDAiLfaf/VSMtd+X3cKPDY4VTRSELPrcY6JutfQF1PqXbZsPrGVhgWTZKrAtICQD5cu9p3pkgW9cyusGAL+GQ02fp/MBrquFDw2aKjR3xqGDcRgWG0CEaYDgJtZVPx/rwgxwobF09feRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517291; c=relaxed/simple;
	bh=UimoZUMbCCyFM27tF1hH2BBImofUy5/7sLBavLYvdzE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKMpDeUaBAx95CNlR3H3J0swu9BQvfkLq+BgphnY8/CWn6o2iKTvA8NTaxGgliONSvBA15qHHRZLg1J3O1C1a/TadDIz/QgkuX/82DqritpYrDX42ChoU6LOcw+5IT0EVQKzxyWOA5xHCihUa2tLMfseywcCWCE8LPGAb/XAr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wleSs-000000007os-0Id6;
	Mon, 20 Jul 2026 03:14:46 +0000
Date: Mon, 20 Jul 2026 04:14:43 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: dsa: wire flash_update devlink callback
 to drivers
Message-ID: <3c7abcd84465ec86df4bfbf4575a109958ff5665.1784513694.git.daniel@makrotopia.org>
References: <cover.1784513694.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784513694.git.daniel@makrotopia.org>

Add a devlink_flash_update callback to dsa_switch_ops so that DSA
drivers can support devlink dev flash without open-coding the devlink
plumbing. The new trampoline in net/dsa/devlink.c follows the existing
dsa_devlink_info_get pattern exactly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: no changes
v2: align continuation lines with the open parenthesis

 include/net/dsa.h |  3 +++
 net/dsa/devlink.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8c16ef23cc10..c9e19348de61 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1170,6 +1170,9 @@ struct dsa_switch_ops {
 	int	(*devlink_info_get)(struct dsa_switch *ds,
 				    struct devlink_info_req *req,
 				    struct netlink_ext_ack *extack);
+	int	(*devlink_flash_update)(struct dsa_switch *ds,
+					struct devlink_flash_update_params *params,
+					struct netlink_ext_ack *extack);
 	int	(*devlink_sb_pool_get)(struct dsa_switch *ds,
 				       unsigned int sb_index, u16 pool_index,
 				       struct devlink_sb_pool_info *pool_info);
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index ed342f345692..25311a87cbc5 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -20,6 +20,18 @@ static int dsa_devlink_info_get(struct devlink *dl,
 	return -EOPNOTSUPP;
 }
 
+static int dsa_devlink_flash_update(struct devlink *dl,
+				    struct devlink_flash_update_params *params,
+				    struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
+
+	if (!ds->ops->devlink_flash_update)
+		return -EOPNOTSUPP;
+
+	return ds->ops->devlink_flash_update(ds, params, extack);
+}
+
 static int dsa_devlink_sb_pool_get(struct devlink *dl,
 				   unsigned int sb_index, u16 pool_index,
 				   struct devlink_sb_pool_info *pool_info)
@@ -169,6 +181,7 @@ dsa_devlink_sb_occ_tc_port_bind_get(struct devlink_port *dlp,
 
 static const struct devlink_ops dsa_devlink_ops = {
 	.info_get			= dsa_devlink_info_get,
+	.flash_update			= dsa_devlink_flash_update,
 	.sb_pool_get			= dsa_devlink_sb_pool_get,
 	.sb_pool_set			= dsa_devlink_sb_pool_set,
 	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,
-- 
2.55.0
