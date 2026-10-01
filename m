Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42275488D84
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887749; cv=none; b=KNXkJ+ny7djW32Qbd4pf1H9/O/BTj3DTg/uHS1MM2fP9M/D12oLoFPHd1DIgBP0KYBMe6yjr9WmSxAiFQaK5BCssj5ZHCA+EzPKRd+IjglMQ7Bdd5JP2mLRhrdR9vM+3OGO2S+urZsI5sb9fbnq4E1dVlFmf1fjI5qh+ZWy+h8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887749; c=relaxed/simple;
	bh=e51v+uffkvWKukyVwt9+dt/mfd+sA5qAewrhxZrFdsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1BxGEVbIjZEdzGAl9QsHvBDSmByUvhfSUTBEZShNplyMwpePEqx5VjGvkEJuCauJfUJC5kDpB+gC7qq6Th/fNGesQpM7mCL68xbLvm/qw9Rjvrganxku7jDwMWwgD9lBlnBbHCZmhC1uTa/evBxv1Rx7u5K5kPtlgZ3Zj9RrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3EDX98Y; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3EDX98Y"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4c276e1c7so1268452a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790887745; x=1791492545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qBlOqwcwfWu4MEBtB6QndOlBm7A0SRavqBgNL1qKZzw=;
        b=Y3EDX98YjS/F9aTEbFNb/wTmS4TBuHdY4nrBc+sEbJJFDevl/ZGziLKpF32PLRaUjS
         HFxLpT7OPPVxOuli+56Rm4uiU+mqqpcPbnBZVUGI5CjuNXG+FcuNBvdz3VKAKqkZvtMr
         X3QV5xKsuPDfXbZ3b2aNHxZ+SAQQvds5hIun4kW1BjO4LT5FY5SNFBPuhHvtrkQF62v1
         rg8UBmlXT89FmEXamUSibzeJ91AnP4Rg29WB+xP3XQF0Iz/PU0OMThrG0GCFB8VhhRhR
         MqIXwA1OhI5mmvrhQlhzLlrX1DnnWpoZhMUyZ+abT05/C7bYG+t2e9a51sf5ynFF5xq9
         qBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887745; x=1791492545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qBlOqwcwfWu4MEBtB6QndOlBm7A0SRavqBgNL1qKZzw=;
        b=jZ8kjfHXq0MBv/xy+0N1lbTeDf5G4ysO/N3b1scpDnZMsII8aGobh7t4aIcvHABBfm
         yxW+P0ZZMy7zzP1NfWCN1sWwrI5wF3ZzROrsr8phDuwlx423u+CSrDYpRvSVIAJbBBTl
         6Lv/sXnHIRYGZ0FnouBwRyzs5Xvo0r6D6v2jhTpsHeb7bX2loLiUhfMbhMX+SY8Ucmsf
         fd0cD8QQtv0LLtKkAuKFdanZO1VRGIJiHDh0IRYo8U/IIcsqmb7C22m1BpmeroQ8Eyht
         WEILM47kSn6xooAxtgPBijuV6wR2Ts0ElQzM3eqcbT8pAOdPj9oUgSJybw+ffNI60sG4
         HhRQ==
X-Gm-Message-State: AFq9FYJaLnSfY4nkGiN+vii2H0lHBTIC1CJ7cwB/kaUe+e5c9cuPIcvw
	ge+3Tu6nwtij17INFClmogLheMplW96LKWpILRNbFW9Wz2ozbUp/lsEeZTfh84bV
X-Gm-Gg: AYBFou0qxq81jc5b+qYj/g+TO3zoJubdMtPEw8y+KqYzXlQhekmX2g2isawujxQ8ZXS
	npx8ozuFM5Ro58r5iEEs42MRKSyg1VtxmxSJ0XMSLuJbHEaja+zLjPvYOO6G9vR9vVJHwY1TPoP
	ZE7WQi1ttyX5dlpGzOJg4MBm8FrZJzMe1Xbi+OQx8x1eBvc+vAO3HRCVjKvGGhIVC6NbdMFfZxa
	fHYgm3qadoHto+xgXuQRbHlDrlo04+udCNUN+mBsccQiWhg5OWsMen6kqu6WvxQ0uhPqoJpfdA3
	Bb98WCd3eULoIOLMYeK2O6nQm3qUhQU5WqFu4YDQ5XpfWXNQNZkAwyt8v7Sg7fWLyIcAUIdc5Qj
	QLBsbZv0L3ITN/9NWV4bUYCjjf2lfZvgMwWWXEJnf7DIC1AeSmmclS9SS7R5KukoWwqsLbPj3nW
	zK3KvFeaRbp0tK0frWZ9kHJlfs33lW9YAVh0pue6RTbbakdBSrK9JAC6G/pHStRsJDRKFtMyb8U
	96DlVUEnIANgJGoNciyJtXyzg==
X-Received: by 2002:a17:90b:2648:b0:3a4:6ff6:413b with SMTP id 98e67ed59e1d1-3a6ce82a2eamr281166a91.47.1790887745201;
        Thu, 01 Oct 2026 13:49:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661e:3050::4d0:26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e9c6sm5658797a91.14.2026.10.01.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 13:49:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: dsa: motorcomm: Hoist type casting helper into chip.h
Date: Fri,  2 Oct 2026 04:48:44 +0800
Message-ID: <20261001204851.2576101-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001204851.2576101-1-mmyangfl@gmail.com>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
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
index 3ff2de383157..aa7d6ab34cbb 100644
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
@@ -272,7 +269,7 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
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
 	struct dsa_port *dp = dsa_to_port(ds, port);
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
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
 
@@ -3576,7 +3573,7 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 {
 	const struct yt921x_info *info = priv->info;
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
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
index 6613fe3b0471..a402d1cf28d1 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -12,7 +12,6 @@
 #define to_yt921x_led(led_cdev) \
 	container_of_const((led_cdev), struct yt921x_led, cdev)
 #define to_yt921x_port(led) ((led)->port)
-#define to_device(priv) ((priv)->ds.dev)
 
 static u32 yt921x_led_regaddr(struct yt921x_priv *priv, int port, int group)
 {
@@ -414,7 +413,7 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 		 struct fwnode_handle *fwnode)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 	struct led_init_data init_data;
 	struct led_classdev *led_cdev;
 	char name[LED_MAX_NAME_SIZE];
@@ -569,7 +568,7 @@ yt921x_led_setup(struct yt921x_priv *priv, int port,
 static void yt921x_leds_remove_port(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
+	struct device *dev = yt921x_priv_to_device(priv);
 
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

