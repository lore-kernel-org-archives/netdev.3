Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDCE3644C6;
	Mon, 27 Jul 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120182; cv=none; b=sS0nuQaPWKS7z3ShFEJ6LFzoT5xXW6ch4TTrZkDIWVGB7bOMFjB7UYJDh9az0V+U/P0MUyjoV6ytSnrluy/2YFcVHLLCCs6TodPSJ/oUzXy3857Ke1JFbP6DE0iA7ltPmaohWSF4SmJ0b6HbxmXOSDA05LZgLc2uur4Lc68kRkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120182; c=relaxed/simple;
	bh=rvJ+B9DyiRjAis5SSXmIyWxIh/0+fXuGrZ8F9SqSN6M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTGHc76C1PzpsA4EbcSRcM+C2p+fd/NSHZ2UnE1doOI1fe3JlEJlLCRbjdWbrcVBP5kTxwWPcAUQCFO1I38jjkjdDU/1oL4vLweyCm0rsCM4uO7V1+6HrDiD7ijjIsD2RtQ29wWsRy+YgrWlUwqivfSVxFpfQBpPXCPqU4SQyjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1woBIn-000000005iW-0z8N;
	Mon, 27 Jul 2026 02:42:49 +0000
Date: Mon, 27 Jul 2026 03:42:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/5] net: dsa: wire flash_update devlink callback
 to drivers
Message-ID: <e3dede274f8b490f084b67d294ca1ae6e2a9116b.1785119999.git.daniel@makrotopia.org>
References: <cover.1785119999.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785119999.git.daniel@makrotopia.org>

Add a devlink_flash_update callback to dsa_switch_ops so that DSA
drivers can support devlink dev flash without open-coding the devlink
plumbing. Unlike the other trampolines in net/dsa/devlink.c, the
flash_update op is only installed for switches whose driver implements
the callback: the devlink core rejects flash requests up front when the
op is absent, before fetching the firmware file from userspace, and an
unconditionally present trampoline would defeat that early check and
let unsupported requests block on request_firmware() only to fail with
-EOPNOTSUPP afterwards.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: no changes
v5: no changes
v4: only install the flash_update op for drivers implementing the
    callback so the devlink core keeps rejecting unsupported flash
    requests before fetching the firmware file
v3: no changes
v2: align continuation lines with the open parenthesis

 include/net/dsa.h |  3 +++
 net/dsa/devlink.c | 50 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 12 deletions(-)

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
index ed342f345692..d6022267a839 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -20,6 +20,15 @@ static int dsa_devlink_info_get(struct devlink *dl,
 	return -EOPNOTSUPP;
 }
 
+static int dsa_devlink_flash_update(struct devlink *dl,
+				    struct devlink_flash_update_params *params,
+				    struct netlink_ext_ack *extack)
+{
+	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
+
+	return ds->ops->devlink_flash_update(ds, params, extack);
+}
+
 static int dsa_devlink_sb_pool_get(struct devlink *dl,
 				   unsigned int sb_index, u16 pool_index,
 				   struct devlink_sb_pool_info *pool_info)
@@ -167,18 +176,31 @@ dsa_devlink_sb_occ_tc_port_bind_get(struct devlink_port *dlp,
 							p_max);
 }
 
-static const struct devlink_ops dsa_devlink_ops = {
-	.info_get			= dsa_devlink_info_get,
-	.sb_pool_get			= dsa_devlink_sb_pool_get,
-	.sb_pool_set			= dsa_devlink_sb_pool_set,
-	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,
-	.sb_port_pool_set		= dsa_devlink_sb_port_pool_set,
-	.sb_tc_pool_bind_get		= dsa_devlink_sb_tc_pool_bind_get,
-	.sb_tc_pool_bind_set		= dsa_devlink_sb_tc_pool_bind_set,
-	.sb_occ_snapshot		= dsa_devlink_sb_occ_snapshot,
-	.sb_occ_max_clear		= dsa_devlink_sb_occ_max_clear,
-	.sb_occ_port_pool_get		= dsa_devlink_sb_occ_port_pool_get,
+/* The devlink core rejects flash requests up front when the flash_update
+ * op is absent, before fetching the firmware file from userspace. Only
+ * install the op for switches whose driver implements it, so that
+ * unsupported requests keep failing early.
+ */
+#define DSA_DEVLINK_OPS							\
+	.info_get			= dsa_devlink_info_get,		\
+	.sb_pool_get			= dsa_devlink_sb_pool_get,	\
+	.sb_pool_set			= dsa_devlink_sb_pool_set,	\
+	.sb_port_pool_get		= dsa_devlink_sb_port_pool_get,	\
+	.sb_port_pool_set		= dsa_devlink_sb_port_pool_set,	\
+	.sb_tc_pool_bind_get		= dsa_devlink_sb_tc_pool_bind_get, \
+	.sb_tc_pool_bind_set		= dsa_devlink_sb_tc_pool_bind_set, \
+	.sb_occ_snapshot		= dsa_devlink_sb_occ_snapshot,	\
+	.sb_occ_max_clear		= dsa_devlink_sb_occ_max_clear,	\
+	.sb_occ_port_pool_get		= dsa_devlink_sb_occ_port_pool_get, \
 	.sb_occ_tc_port_bind_get	= dsa_devlink_sb_occ_tc_port_bind_get,
+
+static const struct devlink_ops dsa_devlink_ops = {
+	DSA_DEVLINK_OPS
+};
+
+static const struct devlink_ops dsa_devlink_flash_ops = {
+	DSA_DEVLINK_OPS
+	.flash_update			= dsa_devlink_flash_update,
 };
 
 int dsa_devlink_param_get(struct devlink *dl, u32 id,
@@ -378,12 +400,16 @@ void dsa_switch_devlink_unregister(struct dsa_switch *ds)
 int dsa_switch_devlink_alloc(struct dsa_switch *ds)
 {
 	struct dsa_devlink_priv *dl_priv;
+	const struct devlink_ops *ops;
 	struct devlink *dl;
 
+	ops = ds->ops->devlink_flash_update ? &dsa_devlink_flash_ops
+					    : &dsa_devlink_ops;
+
 	/* Add the switch to devlink before calling setup, so that setup can
 	 * add dpipe tables
 	 */
-	dl = devlink_alloc(&dsa_devlink_ops, sizeof(*dl_priv), ds->dev);
+	dl = devlink_alloc(ops, sizeof(*dl_priv), ds->dev);
 	if (!dl)
 		return -ENOMEM;
 
-- 
2.55.0
