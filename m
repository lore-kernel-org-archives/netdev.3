Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318053B2FD6
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130000; cv=none; b=NcUxO7AFYXxcJV00zoZr65hYIqFB/3rBXEheqFnhmmOIdHbV1ZHV2zy17Wh809yx0c20Iy81omw9xfeNiarTBRzT8chBzT2DXqm6K/hLJrF2gwgtHfoW6NAAJte/ET2O5UMOraqHePTuh3J0wl/6LgPE4hrUr6h7xM6MvCJNIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130000; c=relaxed/simple;
	bh=hh90W4IQmVXtfx/MrEKy9LK3PvzdqnLrG1VF1+Qn5PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtR6RIVD3aAAF56n6IS9H2rpPOE/kZD3hpmcfvNwRUBDWyEtgtwRswT1nGO6jy11UXQzJ1COTvON2YwC4TyJCJ0WhFeicZLQOdjjLT29b3C1aO+7qCqW3iPMRAaut1FkMJyvxu/nOznQlRVjdfVqdFcLW7g9EsEug4PgFXdkUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQbiYTw2; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQbiYTw2"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-882c2bcef77so446119b3a.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791129997; x=1791734797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmrTTeUZ0Xt4uI6HGA9fNDSizEM0m8lFI6R0dD7fUlI=;
        b=KQbiYTw2e80PFrMIF371gf1pMFPDBM6XQH5P5dtSlL1IcFipzFyDLrYGcMclP4b2js
         bdXd7swB7CeFkPcIX8FHNfZVaY1onq0Cn/U2x3zz9AMqUXd/GZ4xJ5B7TOqX5+muggDl
         N7ErPzANdnMXJY88Hou7AgCQmzceO8Jide4eya1vBIEPcPRvz85wPCERm5ol5ZmSwV/S
         gN75Zt1h46FSgMqj++4F100hflbicLlzsgcGW2lktjk7Yr6Brya0rlUht2j6zqdGJNQ3
         HFFnl0z+A2DfKwA8B4KxmfmMVx9zEFFFJbhfjyeutRrmrST5JLOuuQGovOKoNFium5/g
         Nqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791129997; x=1791734797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmrTTeUZ0Xt4uI6HGA9fNDSizEM0m8lFI6R0dD7fUlI=;
        b=NomwFxZNiKUjeBdlQPxNFl3v+OjZ/UYRtrDt+0jhHB6/MdiPjKyv3Uy9KjoVWVxrUx
         oG5ghB2bkqaN4Yu3Oj4aQRkbd9LuSLK1wC7vRwm65lgzb1cTLoiaJwsKkanL5LKt9AlA
         XRb+WePCJuo3dpL5IPebngLAOVjbS14PnQnSHTte/BPm0eqjmJy/iC8OpPh3QtCoJt/j
         ldQpoh3Aj585G4E3USFf87AZq5KjeaSi4nXXrJyvTNyLejxFqc1wmTikOgZg8uIOpE7n
         PtqM5o3CjZpOAaiKp5NgltLFyhsdiWnv0UX8fEqb/xIV0Wi4KcvTbQWBjzvZ47gM429V
         Ho2w==
X-Gm-Message-State: AFuF++kugb+L6J5thbf+nmUtpu5wX9dVVQqTZFLIlICqx6DgIANLUFJI
	/OqeUzeE2junQs2ZEPZ7LuOImkfUxh/1uP0Kvp8coMpIpwIpNc1iIApuGtddgiPNduw=
X-Gm-Gg: AYBFou3DTOCxrZ4yk9uUee0XPI10ixbOHezeCYRmjnSNrge+mC6rOKqtPDLYs03EkKB
	ESJ3hwepRX5pjbmaO2FtHkf+itMC7tjqGBX3wcpO6LZqFT/fsPcNYevWPEMNL6KVNIfgVrML2SV
	1K6Y6XxicaT9G1BCZeDbjhKAie7jsBglDJOYaNMW/R0o+9n57bkw7qPeWyk4+gOwUsvv6/ldnuC
	DmM12maQug6HJJ+vgrCA4oBGm0vPBa5ldIkEDqdGEi2ep9d2TLreI2SyyAe8gzhLOkKgUGVOkue
	+53M6TqSjbOLk2v4V9xOHTILHnZ1vwlgpJ5cAoaKHwnPbu+61Z72iawSUhbs0zDtk90uakZVtbF
	qAuo+Cg3IWLdOvUUui0OiRfyX2LI/NsBM+I0Y/jUdxsRp2qrATU5zKb5MpbB1HkJIOynl5IKEnq
	3FYq7EWHRprEGK/7lUDKZ6hVdFHywwa8713Ns5bark5sDiEbqCwNF4j61W+dqlohuspCDg0GWSm
	rKGaFHrOgibDG69ybUWTGUND3/3DSTwQBET
X-Received: by 2002:a05:6a00:1403:b0:878:34d7:6977 with SMTP id d2e1a72fcca58-88af655e794mr8119304b3a.37.1791129997349;
        Sun, 04 Oct 2026 09:06:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:36 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/6] net: dsa: motorcomm: Hoist type casting helper into chip.h
Date: Mon,  5 Oct 2026 00:06:15 +0800
Message-ID: <20261004160622.948037-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004160622.948037-1-mmyangfl@gmail.com>
References: <20261004160622.948037-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename and move dsa_to_yt921x_priv() and yt921x_priv_to_device() to
chip.h so all files use one definition.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c     | 127 +++++++++++++--------------
 drivers/net/dsa/motorcomm/chip.h     |   2 +
 drivers/net/dsa/motorcomm/leds.c     |   7 +-
 drivers/net/dsa/motorcomm/mdio_bus.c |  10 +--
 drivers/net/dsa/motorcomm/pcs-921x.c |   8 +-
 5 files changed, 74 insertions(+), 80 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 3ff2de383157..2c0f53cb2b8e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -171,9 +171,6 @@ struct yt921x_reg_mdio {
 
 /* TODO: SPI/I2C */
 
-#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
-#define to_device(priv) ((priv)->ds.dev)
-
 static u32 ethaddr_hi4_to_u32(const unsigned char *addr)
 {
 	return (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) | addr[3];
@@ -271,8 +268,8 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
 	struct yt921x_mib *mib = &pp->mib;
 	int res = 0;
 
@@ -364,7 +361,7 @@ yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 static void
 yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 	size_t j;
@@ -406,7 +403,7 @@ static void
 yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 			     struct ethtool_eth_mac_stats *mac_stats)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
@@ -442,7 +439,7 @@ static void
 yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 			      struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
@@ -471,7 +468,7 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 			  struct ethtool_rmon_stats *rmon_stats,
 			  const struct ethtool_rmon_hist_range **ranges)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
@@ -507,7 +504,7 @@ static void
 yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		       struct rtnl_link_stats64 *stats)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
@@ -543,7 +540,7 @@ static void
 yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 			   struct ethtool_pause_stats *pause_stats)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
@@ -598,7 +595,7 @@ yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
 static int
 yt921x_dsa_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -622,7 +619,7 @@ yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	 * maximum after reset
 	 */
 
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	int frame_size;
 	int res;
@@ -697,7 +694,7 @@ yt921x_marker_tfm(struct yt921x_marker *marker, u64 rate, u64 burst,
 {
 	const int C = flags & YT921X_MARKER_PKT_MODE ? YT921X_TOKEN_PKT_C :
 		      YT921X_TOKEN_BYTE_C;
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_marker m;
 	u64 burst_est;
 	u64 burst_sug;
@@ -873,8 +870,8 @@ yt921x_meter_config(struct yt921x_priv *priv, unsigned int id,
 
 static void yt921x_dsa_port_policer_del(struct dsa_switch *ds, int port)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -891,7 +888,7 @@ yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
 			    const struct flow_action_police *police,
 			    struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_marker marker;
 	u32 ctrl;
 	int res;
@@ -921,7 +918,7 @@ static int
 yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
 				  const struct tc_tbf_qopt_offload *qopt)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct netlink_ext_ack *extack = qopt->extack;
 	u32 ctrls[2];
 	int res;
@@ -1970,7 +1967,7 @@ static int
 yt921x_dsa_cls_flower_del(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -1985,7 +1982,7 @@ yt921x_dsa_cls_flower_add(struct dsa_switch *ds, int port,
 			  struct flow_cls_offload *cls, bool ingress)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_acl_rule_ext ruleext;
 	int res;
 
@@ -2056,8 +2053,8 @@ static void
 yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2074,7 +2071,7 @@ yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
 			   struct dsa_mall_mirror_tc_entry *mirror,
 			   bool ingress, struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2143,7 +2140,7 @@ static int yt921x_lag_set(struct yt921x_priv *priv, u8 index, u16 ports_mask)
 static int
 yt921x_dsa_port_lag_leave(struct dsa_switch *ds, int port, struct dsa_lag lag)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct dsa_port *dp;
 	u32 ctrl;
 	int res;
@@ -2206,7 +2203,7 @@ yt921x_dsa_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
 			 struct netdev_lag_upper_info *info,
 			 struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct dsa_port *dp;
 	bool unique_lag;
 	unsigned int i;
@@ -2269,7 +2266,7 @@ yt921x_dsa_port_lag_join(struct dsa_switch *ds, int port, struct dsa_lag lag,
 
 static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u32 val = YT921X_FDB_RESULT_DONE;
 	int res;
 
@@ -2338,7 +2335,7 @@ static int
 yt921x_fdb_read(struct yt921x_priv *priv, unsigned char *addr, u16 *vidp,
 		u16 *ports_maskp, u16 *indexp, u8 *statusp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u16 index;
 	u32 data0;
 	u32 data1;
@@ -2629,7 +2626,7 @@ static int
 yt921x_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
 			 dsa_fdb_dump_cb_t *cb, void *data)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2644,8 +2641,8 @@ yt921x_dsa_port_fdb_dump(struct dsa_switch *ds, int port,
 
 static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2660,7 +2657,7 @@ static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
 static int
 yt921x_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 ctrl;
 	int res;
 
@@ -2678,7 +2675,7 @@ static int
 yt921x_dsa_port_fdb_del(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2692,7 +2689,7 @@ static int
 yt921x_dsa_port_fdb_add(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid, struct dsa_db db)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -2707,7 +2704,7 @@ yt921x_dsa_port_mdb_del(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_mdb *mdb,
 			struct dsa_db db)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	const unsigned char *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	int res;
@@ -2724,7 +2721,7 @@ yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
 			const struct switchdev_obj_port_mdb *mdb,
 			struct dsa_db db)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	const unsigned char *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	int res;
@@ -2889,7 +2886,7 @@ yt921x_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
 			       bool vlan_filtering,
 			       struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	if (dsa_is_cpu_port(ds, port))
@@ -2906,7 +2903,7 @@ static int
 yt921x_dsa_port_vlan_del(struct dsa_switch *ds, int port,
 			 const struct switchdev_obj_port_vlan *vlan)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u16 vid = vlan->vid;
 	u16 pvid;
 	int res;
@@ -2940,7 +2937,7 @@ yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
 			 const struct switchdev_obj_port_vlan *vlan,
 			 struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u16 vid = vlan->vid;
 	u16 pvid;
 	int res;
@@ -3185,7 +3182,7 @@ yt921x_dsa_port_bridge_flags(struct dsa_switch *ds, int port,
 			     struct switchdev_brport_flags flags,
 			     struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	if (dsa_is_cpu_port(ds, port))
@@ -3202,8 +3199,8 @@ static void
 yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
 			     struct dsa_bridge bridge)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int res;
 
 	if (dsa_is_cpu_port(ds, port))
@@ -3223,7 +3220,7 @@ yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
 			    struct dsa_bridge bridge, bool *tx_fwd_offload,
 			    struct netlink_ext_ack *extack)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u16 ports_mask;
 	int res;
 
@@ -3244,7 +3241,7 @@ static int
 yt921x_dsa_port_mst_state_set(struct dsa_switch *ds, int port,
 			      const struct switchdev_mst_state *st)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -3278,7 +3275,7 @@ static int
 yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 			 const struct switchdev_vlan_msti *msti)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 masks[2];
 	u32 ctrls[2];
 	int res;
@@ -3304,9 +3301,9 @@ yt921x_dsa_vlan_msti_set(struct dsa_switch *ds, struct dsa_bridge bridge,
 static void
 yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct dsa_port *dp = dsa_to_port(ds, port);
-	struct device *dev = to_device(priv);
 	bool learning;
 	u32 mask;
 	u32 ctrl;
@@ -3356,7 +3353,7 @@ yt921x_dsa_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 static int __maybe_unused
 yt921x_dsa_port_get_default_prio(struct dsa_switch *ds, int port)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 val;
 	int res;
 
@@ -3373,7 +3370,7 @@ yt921x_dsa_port_get_default_prio(struct dsa_switch *ds, int port)
 static int __maybe_unused
 yt921x_dsa_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -3399,7 +3396,7 @@ static int __maybe_unused
 yt921x_dsa_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel,
 			     int *nselp)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u8 appprios[2][2] = {};
 	int nsel;
 	u32 val;
@@ -3433,8 +3430,8 @@ static int __maybe_unused
 yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
 			     int nsel)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u32 ctrl;
 	int res;
 
@@ -3574,9 +3571,9 @@ static int
 yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 		   phy_interface_t interface)
 {
+	struct device *dev = yt921x_priv_to_device(priv);
 	const struct yt921x_info *info = priv->info;
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
 	u32 mask;
 	int res;
 
@@ -3628,7 +3625,7 @@ yt921x_phylink_mac_select_pcs(struct phylink_config *config,
 			      phy_interface_t interface)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
 	const struct yt921x_info *info = priv->info;
 	int port = dp->index;
 
@@ -3651,7 +3648,7 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 			     phy_interface_t interface)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
 	int port = dp->index;
 	int res;
 
@@ -3674,7 +3671,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 			   bool tx_pause, bool rx_pause)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
 	int port = dp->index;
 	int res;
 
@@ -3695,7 +3692,7 @@ yt921x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 			  const struct phylink_link_state *state)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
-	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
 	int port = dp->index;
 	int res;
 
@@ -3712,7 +3709,7 @@ static void
 yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 			    struct phylink_config *config)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	const struct yt921x_info *info = priv->info;
 
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
@@ -3803,7 +3800,7 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
 
 static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	mutex_lock(&priv->reg_lock);
@@ -3817,7 +3814,7 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 static int __maybe_unused
 yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 val;
 	int res;
 
@@ -3834,7 +3831,7 @@ yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 static int __maybe_unused
 yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	u32 val;
 	int res;
 
@@ -3859,7 +3856,7 @@ yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 static int __maybe_unused
 yt921x_dsa_port_add_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	int res;
 
 	if (prio >= YT921X_PRIO_NUM)
@@ -3920,7 +3917,7 @@ static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
 static void yt921x_dsa_teardown(struct dsa_switch *ds)
 {
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 
 	yt921x_leds_remove(priv);
 #endif
@@ -3928,7 +3925,7 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 
 static int yt921x_chip_detect(struct yt921x_priv *priv)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	const struct yt921x_info *info;
 	u8 extmode;
 	u32 chipid;
@@ -3995,7 +3992,7 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 
 static int yt921x_chip_reset(struct yt921x_priv *priv)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u16 eth_p_tag;
 	u32 val;
 	int res;
@@ -4243,8 +4240,8 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 
 static int yt921x_dsa_setup(struct dsa_switch *ds)
 {
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct device *dev = to_device(priv);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct device_node *np = dev->of_node;
 	struct device_node *child;
 	unsigned long mask;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 28e4f26f9cc4..9c34fb704bf8 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -984,8 +984,10 @@ struct yt921x_priv {
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
 };
 
+#define dsa_to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
 #define yt921x_port_to_priv(pp) \
 	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
+#define yt921x_priv_to_device(priv) ((priv)->ds.dev)
 
 static inline int ethtool_speed_to_yt921x(int speed)
 {
diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
index 6613fe3b0471..79a4659b3a53 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -12,7 +12,6 @@
 #define to_yt921x_led(led_cdev) \
 	container_of_const((led_cdev), struct yt921x_led, cdev)
 #define to_yt921x_port(led) ((led)->port)
-#define to_device(priv) ((priv)->ds.dev)
 
 static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
 {
@@ -413,8 +412,8 @@ static int
 yt921x_led_setup(struct yt921x_priv *priv, int port,
 		 struct fwnode_handle *fwnode)
 {
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
 	struct led_init_data init_data;
 	struct led_classdev *led_cdev;
 	char name[LED_MAX_NAME_SIZE];
@@ -568,8 +567,8 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 
 static void yt921x_leds_remove_port(struct yt921x_priv *priv, int port)
 {
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
 
 	for (int group = 0; group < YT921X_LED_GROUP_NUM; group++) {
 		struct yt921x_led *led = pp->leds[group];
@@ -587,7 +586,7 @@ static void yt921x_leds_remove_port(struct yt921x_priv *priv, int port)
 
 static int yt921x_leds_setup_port(struct yt921x_priv *priv, int port)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct dsa_switch *ds = &priv->ds;
 	struct device_node *leds_np;
 	struct dsa_port *dp;
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index 1a3f3cc68275..dd6c52f37bbf 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -9,8 +9,6 @@
 #include "mdio_bus.h"
 #include "smi.h"
 
-#define to_device(priv) ((priv)->ds.dev)
-
 static int yt921x_intif_wait(struct yt921x_priv *priv)
 {
 	u32 val = 0;
@@ -21,7 +19,7 @@ static int yt921x_intif_wait(struct yt921x_priv *priv)
 
 int yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u32 mask;
 	u32 ctrl;
 	u32 val;
@@ -145,7 +143,7 @@ yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
 
 int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct mii_bus *mbus;
 	int res;
 
@@ -181,7 +179,7 @@ static int yt921x_extif_wait(struct yt921x_priv *priv)
 static int
 yt921x_extif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	u32 mask;
 	u32 ctrl;
 	u32 val;
@@ -275,7 +273,7 @@ yt921x_mbus_ext_write(struct mii_bus *mbus, int port, int reg, u16 data)
 
 int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct mii_bus *mbus;
 	int res;
 
diff --git a/drivers/net/dsa/motorcomm/pcs-921x.c b/drivers/net/dsa/motorcomm/pcs-921x.c
index 47467d803e13..e942b61d8eb2 100644
--- a/drivers/net/dsa/motorcomm/pcs-921x.c
+++ b/drivers/net/dsa/motorcomm/pcs-921x.c
@@ -8,8 +8,6 @@
 #include "pcs.h"
 #include "smi.h"
 
-#define to_device(priv) ((priv)->ds.dev)
-
 static int
 yt921x_serdes_config(struct yt921x_priv *priv, int port, unsigned int neg_mode,
 		     phy_interface_t interface,
@@ -116,7 +114,7 @@ yt921x_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
 	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int port = pp->index;
 	u16 bmsr;
 	u16 lpa;
@@ -155,7 +153,7 @@ static void yt921x_phylink_pcs_an_restart(struct phylink_pcs *pcs)
 {
 	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
 	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int port = pp->index;
 	u16 val;
 	int res;
@@ -181,7 +179,7 @@ static void yt921x_phylink_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
 	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	int port = pp->index;
 	int res;
 
-- 
2.53.0

