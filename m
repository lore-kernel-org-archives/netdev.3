Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529956;
	b=z+dQdMcKMog21wK7KAh/V/nCBF4eLZmRPgopPaTR4Bx+cwzTEZQCn1S81+YTpLS5DqEE
	 PwLgVc+C1imYTku6yDIb2SjomVfRNcsZ84ZaAEluq/nwwdYJHLxdx45zDzqBZmOHVw5Mu
	 DhoB286E0pjrJTNY5wFkFTRtutpPzf/AhBEaxWXLhO/dqLB4kZ2hDSYjUr3RHaZMrZCsC
	 btHA5tRu77fkJWAtbRNy8l94fJPzMGoSeLMq8KC3pL1bGnMFiNGjQyvsPCShq+mMZTxYd
	 LADZqFTamBKZq5hO87IoPa7e86Z9rFWr/u5qJKK77E70KS2jjR2rUSXmcXLCb8l1nCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dw1hn68BiXd0YJB5bpAyF+EmdQCNMio62PhFYf8j5Nw=;
	b=pEtU76l9wCxUnGip5i3OECOA51/a2XQUKfxnVFA4L0b4cD8Emijz0IOwbvZ9RpRlZOri
	 XAl6fGOftCj4aqK/DgZRLG1bsrAa0wgO/Hk2z6dLAtvEEwGjUqBrb2oJ/JnP2lqu7RDF8
	 xh8CEfoSC14KOc6Qj/dAX1OZ2/lVzuOgxNWkrHFdTtaBEHU8We3gR3scN0ZBIefDVXkQW
	 tIW4s9Jx8gGJizANGqBpy/hJw0Cv0t+Ow6l6bTgrwpTckudElfFJJYZkjXtDRjJrnBMqF
	 ZTPEQOoGbChvogzJiqD8Dy9GGZ7vQgqIxorJHg2NvdFuLlCdSq2GB/tf9ugQtL4Lo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBDBTcZC;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5F606A33B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B5F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBDBTcZC
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso4855595e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529954; x=1795134754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dw1hn68BiXd0YJB5bpAyF+EmdQCNMio62PhFYf8j5Nw=;
        b=XBDBTcZCjuKKVYGNHtQhPi2z9pe/PXyhjeJ0igPeVwuoBcMmzWUKHdVdh/cynYICyr
         8S0NBx++puvkI7bZEOF1IVpA4nl4Zu1YV8GhVHtcQEPtEDjOujI6JVZvN1InvmnNan3L
         yCTbyJKb04bdofbmHuU+ZVL0dGMoVjL+dA7fXtzcq9bOIp7OQh2n1up5hnjaJHkdHDZz
         wGY3SeXAEviudpinp1pVKW7+/s8FCLP5AI7m/jHjpiMyu5CJlai90wAGD48B3nZmgYFy
         LzTLLw6/zmZ9/Jh+ngxFnSRaUcknDqgd1tEnExgu8Q2sdOPOMe95l01MZuTeYdYh/Xnn
         VahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529954; x=1795134754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dw1hn68BiXd0YJB5bpAyF+EmdQCNMio62PhFYf8j5Nw=;
        b=e0UtOcsDiQUO7fUkUXjifV625IlGx7wpt2OpNptiyJIPWcE2wdT4uqpMOEP9NFr69+
         zwJ73XW3Hcus2yzpsnYrI9VhZXHwRrB/pnWdRMnWFDkXBCu7XoAY57q9cVwLaCXj6IkU
         rk5Sxiz4Vm1CtPb4YSpkqynqI8zl/9uMC6Ee9rK9oegYhqbiZUX5/hw+t4JWMCRVhCuy
         SuU9eUtn2MeYIMZ8JGHQIqXlEhkpp1gmvvV0nr2EvZfuA78Ih1TYxBwE8e7c71CgUlUN
         qVvC6nUKs92Ad5G7RHvm7264kZAmkA0wuFYfFSRmjcz3htp86oDj36hdbx3g8dAIoSeH
         siMg==
X-Forwarded-Encrypted: i=1; AL+hErGhOv1no68m9/xXzFQgVdiAMPQ7xheehrr7EOrZpdihEh0n9VXKhWHK7SFgMwHADvepVpCIthg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MaVkSiWO3U5DoHKW+XcmGtyaoBH/cYzdfWaS8hDYKkHqLw6Zu
	QtHgySAtDTtp10+lUhGODkATgx+liVRlz1HUi91ao+2077U8/nzZylso
X-Gm-Gg: AYBFou2oZ8Uzl9w7/kS9sdXScLvdcipoMuWJoy5vOQra7saUF+xT2i/UI6TP6AeKvXg
	NoENc6OV/IiTYXberM4g2hFFu828ssxB02S3uI3Nyxo8vPaeRopvYQQif/Y3n1W+vjNWRWinMA0
	hilB6lGlxap6reUnj+MnW087sLnOAjyLJHvjbHhL39+Q352vYCCd85TKNkYudwVo0UUwME6P82J
	PUcvJeZvqw8dI0cDLJCCGxU1NNrH94MTKqJ0rCpA5HX6qp+m2IGWuxHQisbAwW28i1+PH0V8qI5
	srMK9jIS9RL+gjEziXKUcdc2KfvDGfYYsUwOm52PayFKdT887nFK4dHI5r3aOPk0F2KgDHY04n+
	/aSelouYoqRY+Rrt+fx8UG2Y0qmiQLjXdHbGMPQwUTp3RrdA9QWtvnd8c/7dK3ss23l1iJmwK/X
	6oShi89vyl8LCO6fbno4U55vIr3ALlKMx6REYHok8QWni2PV5iLXNOc2S4VYVckmQ8+5mFEZ7ps
	OAxOBElKPz/LgWEapO2fVCsWuty1myiVcNlNbyB8ug7OtEw8qOxG9Qgx8r5b32FN90jlNi+OCU3
	Di4C8ocl6VXVFIQgvE20WTgn/6toryLIVyTuEvNrpmZ6rNmrkxVBP45qDkieEXJHjR/Gaf7SiGJ
	6n7EFAqPlPYFZGBpQbXFMhbMIh+IJTuLQLMSfJC0RqpzsznNu+K7e+w==
X-Received: by 2002:a05:600c:4313:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4bb55a83305mr12654375e9.34.1794529954280;
        Thu, 12 Nov 2026 16:32:34 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:33 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH net-next v19 03/15] net: phylink: introduce internal phylink PCS handling
Date: Fri, 13 Nov 2026 01:31:53 +0100
Message-ID: <20261113003217.197757-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
 drivers/net/phy/phylink.c | 201 ++++++++++++++++++++++++++++++++++----
 include/linux/phylink.h   |  16 +++
 2 files changed, 196 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 83620a120f18..64b00d324988 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -63,6 +63,9 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* List of available PCS */
+	struct list_head pcs_list;
+
 	/* What interface are supported by the current link.
 	 * Can change on removal or addition of new PCS.
 	 */
@@ -522,6 +525,22 @@ static void phylink_validate_mask_caps(unsigned long *supported,
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
@@ -535,6 +554,21 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs))
 			return PTR_ERR(pcs);
+	/*
+	 * Find a PCS in available PCS list for the requested interface.
+	 *
+	 * Skip searching if the MAC doesn't require a dedicated PCS for
+	 * the requested interface.
+	 */
+	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
+		struct phylink_pcs *tmp;
+
+		list_for_each_entry(tmp, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(tmp, state->interface)) {
+				pcs = tmp;
+				break;
+			}
+		}
 	}
 
 	if (pcs) {
@@ -549,13 +583,10 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
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
@@ -968,12 +999,22 @@ static void phylink_pcs_enable_eee(struct phylink_pcs *pcs)
 static unsigned int phylink_inband_caps(struct phylink *pl,
 					 phy_interface_t interface)
 {
-	struct phylink_pcs *pcs;
+	struct phylink_pcs *pcs = NULL;
 
-	if (!pl->mac_ops->mac_select_pcs)
-		return 0;
+	if (pl->mac_ops->mac_select_pcs) {
+		pcs = pl->mac_ops->mac_select_pcs(pl->config,
+						  interface);
+	} else if (test_bit(interface, pl->config->pcs_interfaces)) {
+		struct phylink_pcs *tmp;
+
+		list_for_each_entry(tmp, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(tmp, interface)) {
+				pcs = tmp;
+				break;
+			}
+		}
+	}
 
-	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
 	if (IS_ERR_OR_NULL(pcs))
 		return 0;
 
@@ -1270,10 +1311,36 @@ static void phylink_major_config(struct phylink *pl, bool restart,
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
+		struct phylink_pcs *tmp;
+
+		list_for_each_entry(tmp, &pl->pcs_list, list) {
+			if (!phylink_validate_pcs_interface(tmp,
+							    state->interface)) {
+				pcs = tmp;
+				break;
+			}
+		}
+
+		if (!pcs) {
+			phylink_err(pl,
+				    "couldn't find a PCS for %s\n",
+				    phy_modes(state->interface));
 
-		pcs_changed = pl->pcs != pcs;
+			pl->major_config_failed = true;
+			return;
+		}
 	}
 
+	pcs_changed = pl->pcs != pcs;
+
 	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
 
 	phylink_dbg(pl, "major config, active %s/%s/%s\n",
@@ -1300,13 +1367,15 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pcs_changed) {
 		phylink_pcs_disable(pl->pcs);
 
-		if (pl->pcs)
-			rcu_assign_pointer(pcs->phylink, NULL);
+		if (pl->mac_ops->mac_select_pcs) {
+			if (pl->pcs)
+				rcu_assign_pointer(pl->pcs->phylink, NULL);
 
-		if (pcs)
-			rcu_assign_pointer(pcs->phylink, pl);
+			if (pcs)
+				rcu_assign_pointer(pcs->phylink, pl);
+		}
 
-		pl->pcs = pcs;
+		WRITE_ONCE(pl->pcs, pcs);
 	}
 
 	if (pl->pcs)
@@ -1901,6 +1970,49 @@ int phylink_set_fixed_link(struct phylink *pl,
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
+		if (WARN(rcu_access_pointer(pcs->phylink),
+			 "%s: PCS already attached to a phylink instance\n",
+			 __func__))
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
  * phylink_update_pause_state() - Update the phylink pause frame configuration
  * @pl: a pointer to a &struct phylink instance
@@ -2042,9 +2154,20 @@ struct phylink *phylink_create(struct phylink_config *config,
 			       phy_interface_t iface,
 			       const struct phylink_mac_ops *mac_ops)
 {
+	struct phylink_pcs *tmp, *pcs;
 	struct phylink *pl;
 	int ret;
 
+	/*
+	 * Make sure either PCS internal validation or .mac_select_pcs
+	 * is used. Return error if both are defined.
+	 */
+	if (config->num_possible_pcs && mac_ops->mac_select_pcs) {
+		dev_err(config->dev,
+			"phylink: error: either phylink_config .num_possible_pcs or .mac_select_pcs must be used\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* Validate the supplied configuration */
 	if (phy_interface_empty(config->supported_interfaces)) {
 		dev_err(config->dev,
@@ -2059,6 +2182,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
+	INIT_LIST_HEAD(&pl->pcs_list);
 
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
@@ -2096,16 +2220,31 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
+	/* Fill the PCS list with available PCS from phylink config */
+	ret = phylink_fill_available_pcs(pl, config);
+	if (ret < 0)
+		goto free_pl;
+
+	/* Link available PCS to phylink */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		rcu_assign_pointer(pcs->phylink, pl);
+
 	phy_interface_copy(pl->supported_interfaces,
 			   pl->config->supported_interfaces);
 
+	/* Update supported interfaces */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
 	ret = phylink_parse_mode(pl, fwnode);
 	if (ret < 0)
-		goto free_pl;
+		goto unlink_pcs_list;
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED) {
 		ret = phylink_parse_fixedlink(pl, fwnode);
@@ -2124,6 +2263,14 @@ struct phylink *phylink_create(struct phylink_config *config,
 release_link_gpio:
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
+unlink_pcs_list:
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		rcu_assign_pointer(pcs->phylink, NULL);
+
+	synchronize_rcu();
+
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
+		list_del(&pcs->list);
 free_pl:
 	kfree(pl);
 	return ERR_PTR(ret);
@@ -2141,17 +2288,29 @@ EXPORT_SYMBOL_GPL(phylink_create);
  */
 void phylink_destroy(struct phylink *pl)
 {
+	struct phylink_pcs *pcs, *tmp;
+
 	sfp_bus_del_upstream(pl->sfp_bus);
 	phylink_destroy_sfp_cage_port(pl);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
-	if (pl->pcs) {
+	/* Remove phylink instance from every PCS */
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		rcu_assign_pointer(pcs->phylink, NULL);
+
+	if (pl->pcs)
 		rcu_assign_pointer(pl->pcs->phylink, NULL);
+
+	if (pl->pcs || !list_empty(&pl->pcs_list))
 		synchronize_rcu();
-	}
 
 	cancel_work_sync(&pl->resolve);
+
+	/* Remove every PCS from phylink PCS list */
+	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
+		list_del(&pcs->list);
+
 	kfree(pl);
 }
 EXPORT_SYMBOL_GPL(phylink_destroy);
@@ -2620,7 +2779,7 @@ void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
 	rcu_read_lock();
 
 	pl = rcu_dereference(pcs->phylink);
-	if (pl)
+	if (pl && READ_ONCE(pl->pcs) == pcs)
 		phylink_link_changed(pl, up, "pcs");
 
 	rcu_read_unlock();
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 4a0dc6fa8010..418e8bec311d 100644
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
 	struct phylink __rcu *phylink;
 	bool poll;
 	bool rxc_always_on;
+
+	/* private: */
+	struct list_head list;
 };
 
 /**
-- 
2.55.0

