Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E13E762A
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407103; cv=none; b=TkJdlQMGHBWLhwIittqykaOMWtNGxPHZayDx4S9MS1V4sx9dQ+Q5D2ZroYCVc6+u1qxzQFxFIhdmK8ohLL2+HeJUZDv80eGJrqKoItcHLU2ND7Pj4ka5qa7fAe1NMKvYEW2pZP63EbxSzKqDrkWc1ki1j89FwA/8Q2lB+O5P+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407103; c=relaxed/simple;
	bh=N55rBgs8/xLmizm8awWYTKNMyxniN81W7V6XDoAbEho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAc8VHHc94L/wvtFtiGxdKY7si44dpbkF0Jag+/i+rstbAJG6skbAQDxsTli/BOZI9WU7Rqyy/1vjrH0m1LFzo44PvjsieASSLIeWPvwnSjy5lFPFtgrNKHWijzg1pjsbBB0PJGrmEyY5oBsmK2p6xt9RgUor1daef1qyfiG9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIGCVp78; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIGCVp78"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17961755e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407099; x=1786011899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q/xUoUB1/1TADTp7P1YLdGTC5axqAibkjkTuB6w90Qg=;
        b=RIGCVp78yk9R3LnWqWMR5jCbs05dRmqPl1uSuWf2YgPVtL79psXEcT/0YrptB8RVN0
         g1gUjQGcO89+g7rImoHzR+alByXFLCJtMdpevhDbsvJOYFfpTelKYi/KejMlOT2bGTOy
         Va1Jzf9ExD6g5rmnc458z+njQHv0tY2JGqSrnzaprR2vCaITdGWKJ3btz/vB1emZItYA
         t08YbIrpy92jLKk1Ja7i0reRE5UI60Nc5Pl7zaMkmc220KfuUO6e3LNO8e/dUrqJ9MtO
         etZ4Os7I7I96ufj0M28gdxrEtyyeqzBnMRE1jgRu2tgiXJ6d0LMC+9FYbZ3mp36xzm3C
         +TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407099; x=1786011899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q/xUoUB1/1TADTp7P1YLdGTC5axqAibkjkTuB6w90Qg=;
        b=WV5eLaCFrLuFdRLa/hpqS5bMLoR8nXV1XoBYZVRWizZJRtCEKEPKEeGvPGCAPHtxtm
         frYjJG/IjQ56IpRuR1EHwaL+WNoDlAtCRh2madBhepF+r1bs1QudUC8tUBYCqIWIj+lN
         8SlyOEE3Z4vZ1n+5THuj3GcLcdeULfcaKgo3sAP7Y94bfj182ePhkS3l2nJZYvWhMnQE
         VWrDVikWhzTdwi6cLmBvb9//u4a0BEic516f1NT3rY9koEr3jPed5h6+2v4XLYRCRs2+
         ew+n7+takBrcfviAS9P3ng9eNfXfLHVqENXJ2nITvDnJiwML2uaIyRpS6fFfTKs1kqVu
         bxmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPFlHqZ8nGyvASWMnqGJREmA8IdXGpG7X/nuoaZgFVsXcA5Q0tmRRT/wyqItZUdDWN/Hr/Quw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBFPGf9xCH78bgI7VtVor+0lZyZKMxDZwaGh8uhjlMxiPkdlT5
	bWeO93LBxCjlgmhI5y/iItErNhROG3Z5Jfyz0NhjIosPL+dWnOl05MP4
X-Gm-Gg: AR+sD11WhVFHDz8+8eR7kit/VeLsoSgYfbnS9hNSsM0Wrj4Qy8KWyfyd4Ve52ObdODJ
	+F7uzMe5XzC1yy/vnpRfRpstI8M49vWO4GXRthdOOWUqymdEcalljHEMsauYOzSEBdzsrVyqHNP
	GSpv3DcC3qspgM91lhDN+UILTWPcmBkOTBo/iDBt8aJzKLjYyWBT34shRcOfod8vpwWkil3tGFz
	Kq5mz8T/jIB+b4AuxvKv0P+w6DwttazWwiHU8+AW2NNxT2BUA0kmWY30LPoev/gz7SE+p93OI+x
	Xqp6rI+TDSiy3rdEuVDxVwvUKbcO1FY+lu5VQ4hQdZavFcbpjeiqhqnxjnpcNno8IgzTQi1hgIo
	1YJg4o/PH8kiV6czlUPCubUv+H4LDUSKDAp2Djg0c9GTILqCqptC96sbTQq+MZsGexqUxyCcG3t
	33jiCN3HGxHm1I76VV8b2C65AfLTHvR21rR8QRFfIuztM42cOCPCY2Z3kM2gitsGBj7gd3HcQop
	vcPNPbtW9H5kFKFcGffWglpS1gd/JlbsOqdeZMNnbrZCWx99mPoU0xelYtmYV2FvgJw3YsGR/G+
X-Received: by 2002:a05:600c:6d0d:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-49800eb9d43mr16965505e9.37.1785407098864;
        Thu, 30 Jul 2026 03:24:58 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-11-254-126.retail.telecomitalia.it. [87.11.254.126])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm44720295e9.7.2026.07.30.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:24:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v10 02/11] net: phylink: introduce internal phylink PCS handling
Date: Thu, 30 Jul 2026 12:24:13 +0200
Message-ID: <20260730102444.1967900-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730102444.1967900-1-ansuelsmth@gmail.com>
References: <20260730102444.1967900-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce internal handling of PCS for phylink. This is an alternative
way to .mac_select_pcs that moves the selection logic of the PCS entirely
to phylink with the usage of the supported_interface value in the PCS
struct.

MAC should now provide a callback to fill the available PCS in
phylink_config in .fill_available_pcs and fill the .num_possible_pcs with
the number of elements in the array. MAC should also define a new bitmap,
pcs_interfaces, in phylink_config to define for what interface mode a
dedicated PCS is required.

On phylink_create(), an array of PCS pointer is allocated of size
.num_possible_pcs from phylink_config and .fill_available_pcs from
phylink_config is called passing as args the just allocated array and
the number of possible element in it.

MAC will fill this passed array with all the available PCS.

This array is then parsed and a linked list of PCS is created based on
the allocated PCS array filled by MAC via .fill_available_pcs().

Every PCS in phylink PCS list gets then linked to the phylink instance
by setting the phylink value in phylink_pcs struct to the phylink instance.
Also the supported_interface value in phylink struct is updated with
the new supported_interface from the provided PCS.

On phylink_destroy(), every PCS in phylink PCS list is unlinked from the
phylink instance by setting the phylink value in phylink_pcs struct to NULL
and removed from the PCS list.

phylink_validate_mac_and_pcs(), phylink_major_config() and
phylink_inband_caps() are updated to support this new implementation
with the PCS list stored in phylink.

They will make use of phylink_validate_pcs_interface() that will loop
for every PCS in the phylink PCS available list and find one that supports
the passed interface.

phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
where if a supported_interface value is not set for the PCS struct, then
it's assumed every interface is supported.

A MAC is required to implement either a .mac_select_pcs or make use of
the PCS list implementation. Implementing both will result in a fail
on phylink_create().

A MAC defining .num_possible_pcs in phylink_config MUST also define a
.fill_available_pcs or phylink_create() will fail with an negative error.

phylink value in phylink_pcs struct with this implementation is used to
track from PCS side when it's attached to a phylink instance. PCS driver
will make use of this information to correctly detach from a phylink
instance if needed.

phylink_pcs_change() is also changed to verify that the PCS that triggered
a link change is the one that is currently used by the phylink instance.

The .mac_select_pcs implementation is not changed but it's expected that
every MAC driver migrates to the new implementation to later deprecate
and remove .mac_select_pcs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 226 +++++++++++++++++++++++++++++++-------
 include/linux/phylink.h   |  16 +++
 2 files changed, 204 insertions(+), 38 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3464e3ec5699..a5e2d342a92e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -60,6 +60,9 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* List of available PCS */
+	struct list_head pcs_list;
+
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
 	 */
@@ -154,6 +157,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
 
 static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
 
+static void phylink_run_resolve(struct phylink *pl);
+
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
  * @mask: ethtool link mode mask
@@ -517,12 +522,29 @@ static void phylink_validate_mask_caps(unsigned long *supported,
 	linkmode_and(state->advertising, state->advertising, mask);
 }
 
+static int phylink_validate_pcs_interface(struct phylink_pcs *pcs,
+					  phy_interface_t interface)
+{
+	/* If PCS define an empty supported_interfaces value, assume
+	 * all interface are supported.
+	 */
+	if (phy_interface_empty(pcs->supported_interfaces))
+		return 0;
+
+	/* Ensure that this PCS supports the interface mode */
+	if (!test_bit(interface, pcs->supported_interfaces))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int phylink_validate_mac_and_pcs(struct phylink *pl,
 					unsigned long *supported,
 					struct phylink_link_state *state)
 {
-	struct phylink_pcs *pcs = NULL;
 	unsigned long capabilities;
+	struct phylink_pcs *pcs;
+	bool pcs_found = false;
 	int ret;
 
 	/* Get the PCS for this interface mode */
@@ -530,9 +552,24 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
+
+		pcs_found = !!pcs;
+	/*
+	 * Find a PCS in available PCS list for the requested interface.
+	 *
+	 * Skip searching if the MAC doesn't require a dedicated PCS for
+	 * the requested interface.
+	 */
+	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs, state->interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
 	}
 
-	if (pcs) {
+	if (pcs_found) {
 		/* The PCS, if present, must be setup before phylink_create()
 		 * has been called. If the ops is not initialised, print an
 		 * error and backtrace rather than oopsing the kernel.
@@ -544,13 +581,10 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 			return -EINVAL;
 		}
 
-		/* Ensure that this PCS supports the interface which the MAC
-		 * returned it for. It is an error for the MAC to return a PCS
-		 * that does not support the interface mode.
-		 */
-		if (!phy_interface_empty(pcs->supported_interfaces) &&
-		    !test_bit(state->interface, pcs->supported_interfaces)) {
-			phylink_err(pl, "MAC returned PCS which does not support %s\n",
+		/* Recheck PCS to handle legacy way for .mac_select_pcs */
+		ret = phylink_validate_pcs_interface(pcs, state->interface);
+		if (ret) {
+			phylink_err(pl, "selected PCS does not support %s\n",
 				    phy_modes(state->interface));
 			return -EINVAL;
 		}
@@ -964,12 +998,22 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
 					 phy_interface_t interface)
 {
 	struct phylink_pcs *pcs;
+	bool pcs_found = false;
 
-	if (!pl->mac_ops->mac_select_pcs)
-		return 0;
+	if (pl->mac_ops->mac_select_pcs) {
+		pcs = pl->mac_ops->mac_select_pcs(pl->config,
+						  interface);
+		pcs_found = !!pcs;
+	} else if (test_bit(interface, pl->config->pcs_interfaces)) {
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs, interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
+	}
 
-	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
-	if (!pcs)
+	if (!pcs_found)
 		return 0;
 
 	return phylink_pcs_inband_caps(pcs, interface);
@@ -1264,10 +1308,36 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 			pl->major_config_failed = true;
 			return;
 		}
+	/* Find a PCS in available PCS list for the requested interface.
+	 * This doesn't overwrite the previous .mac_select_pcs as either
+	 * .mac_select_pcs or PCS list implementation are permitted.
+	 *
+	 * Skip searching if the MAC doesn't require a dedicated PCS for
+	 * the requested interface.
+	 */
+	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
+		bool pcs_found = false;
+
+		list_for_each_entry(pcs, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(pcs,
+							    state->interface)) {
+				pcs_found = true;
+				break;
+			}
+		}
 
-		pcs_changed = pl->pcs != pcs;
+		if (!pcs_found) {
+			phylink_err(pl,
+				    "couldn't find a PCS for %s\n",
+				    phy_modes(state->interface));
+
+			pl->major_config_failed = true;
+			return;
+		}
 	}
 
+	pcs_changed = pl->pcs != pcs;
+
 	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
 
 	phylink_dbg(pl, "major config, active %s/%s/%s\n",
@@ -1294,13 +1364,15 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pcs_changed) {
 		phylink_pcs_disable(pl->pcs);
 
-		if (pl->pcs)
-			pl->pcs->phylink = NULL;
+		if (pl->mac_ops->mac_select_pcs) {
+			if (pl->pcs)
+				pl->pcs->phylink = NULL;
 
-		if (pcs)
-			pcs->phylink = pl;
+			if (pcs)
+				pcs->phylink = pl;
+		}
 
-		pl->pcs = pcs;
+		WRITE_ONCE(pl->pcs, pcs);
 	}
 
 	if (pl->pcs)
@@ -1833,6 +1905,44 @@ int phylink_set_fixed_link(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
 
+static int phylink_fill_available_pcs(struct phylink *pl,
+				      struct phylink_config *config)
+{
+	struct phylink_pcs **pcss;
+	int i, ret;
+
+	if (!config->num_possible_pcs)
+		return 0;
+
+	if (!config->fill_available_pcs) {
+		dev_err(config->dev,
+			"phylink: error: num_possible_pcs defined but no fill_available_pcs\n");
+		return -EINVAL;
+	}
+
+	pcss = kzalloc_objs(*pcss, config->num_possible_pcs);
+	if (!pcss)
+		return -ENOMEM;
+
+	ret = config->fill_available_pcs(config, pcss, config->num_possible_pcs);
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < config->num_possible_pcs; i++) {
+		struct phylink_pcs *pcs = pcss[i];
+
+		if (!pcs)
+			continue;
+
+		list_add_tail(&pcs->list, &pl->pcs_list);
+	}
+
+out:
+	kfree(pcss);
+
+	return ret;
+}
+
 /**
  * phylink_create() - create a phylink instance
  * @config: a pointer to the target &struct phylink_config
@@ -1854,13 +1964,17 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
+	struct phylink_pcs *tmp, *pcs;
 	struct phylink *pl;
 	int ret;
 
-	/* Validate the supplied configuration */
-	if (phy_interface_empty(config->supported_interfaces)) {
+	/*
+	 * Make sure either PCS internal validation or .mac_select_pcs
+	 * is used. Return error if both are defined.
+	 */
+	if (config->num_possible_pcs && mac_ops->mac_select_pcs) {
 		dev_err(config->dev,
-			"phylink: error: empty supported_interfaces\n");
+			"phylink: error: either phylink_config .num_possible_pcs or .mac_select_pcs must be used\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1871,10 +1985,26 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_LIST_HEAD(&pl->pcs_list);
+
+	/* Fill the PCS list with available PCS from phylink config */
+	ret = phylink_fill_available_pcs(pl, config);
+	if (ret < 0)
+		goto free_pl;
+
+	/* Link available PCS to phylink */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		pcs->phylink = pl;
 
 	phy_interface_copy(pl->supported_interfaces,
 			   config->supported_interfaces);
 
+	/* Update supported interfaces */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -1882,8 +2012,8 @@ struct phylink *phylink_create(struct phylink_config *config,
 	} else if (config->type == PHYLINK_DEV) {
 		pl->dev = config->dev;
 	} else {
-		kfree(pl);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto unlink_pcs_list;
 	}
 
 	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
@@ -1916,28 +2046,31 @@ struct phylink *phylink_create(struct phylink_config *config,
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
 	ret = phylink_parse_mode(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto unlink_pcs_list;
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 		ret = phylink_parse_fixedlink(pl, fwnode);
-		if (ret < 0) {
-			kfree(pl);
-			return ERR_PTR(ret);
-		}
+		if (ret < 0)
+			goto unlink_pcs_list;
 	}
 
 	pl->req_link_an_mode = pl->cfg_link_an_mode;
 
 	ret = phylink_register_sfp(pl, fwnode);
-	if (ret < 0) {
-		kfree(pl);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto unlink_pcs_list;
 
 	return pl;
+
+unlink_pcs_list:
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
+		list_del(&pcs->list);
+		pcs->phylink = NULL;
+	}
+free_pl:
+	kfree(pl);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(phylink_create);
 
@@ -1952,11 +2085,21 @@ EXPORT_SYMBOL_GPL(phylink_create);
  */
 void phylink_destroy(struct phylink *pl)
 {
+	struct phylink_pcs *pcs, *tmp;
+
 	sfp_bus_del_upstream(pl->sfp_bus);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
 	cancel_work_sync(&pl->resolve);
+
+	/* Drop link between PCS and phylink */
+	/* Remove every PCS from phylink PCS list */
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list) {
+		pcs->phylink = NULL;
+		list_del(&pcs->list);
+	}
+
 	kfree(pl);
 }
 EXPORT_SYMBOL_GPL(phylink_destroy);
@@ -2412,8 +2555,15 @@ void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
 {
 	struct phylink *pl = pcs->phylink;
 
-	if (pl)
-		phylink_link_changed(pl, up, "pcs");
+	/*
+	 * Ignore PCS link state change if the PCS is not
+	 * attached to a phylink instance or the phylink
+	 * instance is not currently using this PCS.
+	 */
+	if (!pl || READ_ONCE(pl->pcs) != pcs)
+		return;
+
+	phylink_link_changed(pl, up, "pcs");
 }
 EXPORT_SYMBOL_GPL(phylink_pcs_change);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac..ca9dfc142388 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -12,6 +12,7 @@ struct ethtool_cmd;
 struct fwnode_handle;
 struct net_device;
 struct phylink;
+struct phylink_pcs;
 
 enum {
 	MLO_PAUSE_NONE,
@@ -151,6 +152,8 @@ enum phylink_op_type {
  *		     if MAC link is at %MLO_AN_FIXED mode.
  * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
  *                        are supported by the MAC/PCS.
+ * @pcs_interfaces: bitmap describing for which PHY_INTERFACE_MODE_xxx a
+ *		    dedicated PCS is required.
  * @lpi_interfaces: bitmap describing which PHY interface modes can support
  *		    LPI signalling.
  * @mac_capabilities: MAC pause/speed/duplex capabilities.
@@ -160,6 +163,10 @@ enum phylink_op_type {
  * @wol_phy_legacy: Use Wake-on-Lan with PHY even if phy_can_wakeup() is false
  * @wol_phy_speed_ctrl: Use phy speed control on suspend/resume
  * @wol_mac_support: Bitmask of MAC supported %WAKE_* options
+ * @num_possible_pcs: num of possible phylink_pcs PCS
+ * @fill_available_pcs: callback to fill the available PCS in the passed
+ *			array struct of phylink_pcs PCS available_pcs up to
+ *			num_possible_pcs.
  */
 struct phylink_config {
 	struct device *dev;
@@ -172,6 +179,7 @@ struct phylink_config {
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+	DECLARE_PHY_INTERFACE_MASK(pcs_interfaces);
 	DECLARE_PHY_INTERFACE_MASK(lpi_interfaces);
 	unsigned long mac_capabilities;
 	unsigned long lpi_capabilities;
@@ -182,6 +190,11 @@ struct phylink_config {
 	bool wol_phy_legacy;
 	bool wol_phy_speed_ctrl;
 	u32 wol_mac_support;
+
+	unsigned int num_possible_pcs;
+	int (*fill_available_pcs)(struct phylink_config *config,
+				  struct phylink_pcs **available_pcs,
+				  unsigned int num_possible_pcs);
 };
 
 void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
@@ -497,6 +510,9 @@ struct phylink_pcs {
 	struct phylink *phylink;
 	bool poll;
 	bool rxc_always_on;
+
+	/* private: */
+	struct list_head list;
 };
 
 /**
-- 
2.53.0

