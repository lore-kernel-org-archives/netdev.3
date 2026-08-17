Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE93AFD16;
	Mon, 17 Aug 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976799; cv=none; b=BWsuq5Ox2wbTz1kiS6Ne3Y2/Ra0G+uOiRMu4l55N7w6IL/edopOFAz5JjP8qKpBFdF0WWxdUKecuBk8mESLMkjW68cbFLL9Z7fJk6HWpiFtjoYERxdXVOr3Wkyy6GKM8GlWp9+AojAgTsbMy8ZLUOp+thwmBrUgoYItIGrHS9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976799; c=relaxed/simple;
	bh=odO48VtrD6cmttovTwNfzUBdNWesHHm5eV8rNrjxhB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KO3l7L3xP7pbKtjBA2iskbjU997sn+meQsXtEQ9NbQt6JMnDGRFCaGZqZpi9QMur1hK77KR6HaLEm2q5sYEvWRp6CoHwDEUalDsJbIGav6VXL9KejRbKs0rIg0YcRaapTCPy1ybRrzTNRLUSC5Sf2A/vWOgdhPgsLzyRzQ7EXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEZrpxn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEZrpxn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCD91F00A3D;
	Mon, 17 Aug 2026 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976797;
	bh=ku13IIlN+P0gudOOvoiEjtYTqvazrd8x/nYHW6yxPKY=;
	h=Date:From:To:Cc:Subject;
	b=nEZrpxn2gxEA27+CQVWRTjEFGpc09W1n+d9F9SrcTjOuo9MZR+NhhFNoY3adGgIPM
	 SM2JjIIcTkT5WQTeKRDKjc2jQjbabmc6pFHedUt3cwdgxsrSGbbuzbqxM0qdvs1qDq
	 Eu55twPOLpP+x9TUsMfHugbV5HGF6xgJ8ie1nskANLPKS0gvl/ric2FufpKLTtoePk
	 7+gCW/I723BazobJiEmAaBaalIDvF0HVFknzeW5CBVZIOw4cGwt3k4w4dc2xAmNupy
	 OFqsh4vSssk/1/o6fOBMBKUzMdueGhndGhuSVSIvjKKAK7KjInXa9EFQ0XVZx7VCEn
	 wpDQpoywTqowQ==
Date: Mon, 17 Aug 2026 15:26:32 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Charlie-cy Wu <Charlie-cy.Wu@mediatek.com>,
	Charlie-cy Wu <charlie-cy.wu@mediatek.corp-partner.google.com>,
	Felix Fietkau <nbd@nbd.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the origin tree
Message-ID: <aoMaGJ1GcPZOoT_i@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/wireless/mediatek/mt76/mt7921/regd.c

between commit:

  d6e7d57ed967d ("wifi: mt76: mt7921: refactor regd update to fix recursive mutex deadlock")

from the origin tree and commits:

  1f83a8378eb26 ("wifi: mt76: mt7921: refactor regd update to fix recursive mutex deadlock")
  9b80bd9cab40c ("wifi: mt76: mt7921: add regulatory wiphy self manager support")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index 4722007abafd5,4a8ea4624fee5..0000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@@ -10,6 -10,15 +10,15 @@@ static bool mt7921_disable_clc
  module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
  MODULE_PARM_DESC(disable_clc, "disable CLC support");
  
+ static struct ieee80211_regdomain mt7921_regd_ww = {
+ 	.n_reg_rules = 1,
+ 	.alpha2 =  "00",
+ 	.reg_rules = {
+ 		/* IEEE 802.11b/g, channels 1..11 */
+ 		REG_RULE(2412 - 10, 2462 + 10, 40, 6, 20, 0),
+ 	}
+ };
+ 
  bool mt7921_regd_clc_supported(struct mt792x_dev *dev)
  {
  	if (mt7921_disable_clc ||
@@@ -33,6 -42,9 +42,9 @@@ mt7921_regd_channel_update(struct wiph
  	np = mt76_find_power_limits_node(mdev);
  
  	sband = wiphy->bands[NL80211_BAND_5GHZ];
+ 	if (!sband)
+ 		return;
+ 
  	band_np = np ? of_get_child_by_name(np, "txpower-5g") : NULL;
  	for (i = 0; i < sband->n_channels; i++) {
  		ch = &sband->channels[i];
@@@ -71,14 -83,15 +83,16 @@@
  	}
  }
  
 +/* Internal version that assumes mutex is already held by caller */
  int __mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
  			     enum environment_cap country_ie_env)
  {
  	struct mt76_dev *mdev = &dev->mt76;
  	struct ieee80211_hw *hw = mdev->hw;
  	struct wiphy *wiphy = hw->wiphy;
- 	int ret = 0;
+ 	int ret;
+ 
+ 	lockdep_assert_held(&dev->mt76.mutex);
  
  	if (!dev->regd_change)
  		return 0;
@@@ -101,7 -114,7 +115,7 @@@
  int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
  			   enum environment_cap country_ie_env)
  {
- 	int ret = 0;
+ 	int ret;
  
  	dev->regd_in_progress = true;
  
@@@ -150,10 -163,176 +164,176 @@@ void mt7921_regd_notifier(struct wiphy 
  	if (pm->suspended)
  		return;
  
+ 	if (MT7921_REGD_SUPPORTED(&dev->phy)) {
+ 		mt7921_regd_update(&dev->phy, req->alpha2);
+ 
+ 		return;
+ 	}
+ 
  	mt7921_mcu_regd_update(dev, req->alpha2,
  			       req->country_ie_env);
  }
  
+ static struct sk_buff *
+ mt7921_regd_query_regdb(struct mt792x_phy *phy, char *alpha2)
+ {
+ 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+ 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+ 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+ 	struct mt7921_clc *clc = phy->clc[MT792x_CLC_REGD];
+ 	struct mt7921_regd_query_req *req;
+ 	struct mt7921_regd_cc *regd_cc;
+ 	struct sk_buff *ret_skb = NULL;
+ 	u8 *pos, *last_pos;
+ 	int ret = 0;
+ 
+ 	if (!clc)
+ 		return NULL;
+ 
+ 	pos = clc->data;
+ 	last_pos = pos + le32_to_cpu(clc->len) - sizeof(struct mt7921_clc);
+ 	while (pos < last_pos) {
+ 		u32 req_len = 0;
+ 		u32 rules_len = 0;
+ 		u32 sign_len = 4;
+ 		u32 n_reg_rules;
+ 
+ 		if (pos + sizeof(*regd_cc) > last_pos)
+ 			break;
+ 
+ 		regd_cc = (struct mt7921_regd_cc *)pos;
+ 		n_reg_rules = le32_to_cpu(regd_cc->n_reg_rules);
+ 		if (n_reg_rules > NL80211_MAX_SUPP_REG_RULES)
+ 			break;
+ 
+ 		rules_len = sizeof(struct mt7921_regd_rule_header) +
+ 			    sizeof(struct mt7921_regd_rule) * n_reg_rules;
+ 
+ 		if (pos + sizeof(*regd_cc) + rules_len + sign_len > last_pos)
+ 			break;
+ 
+ 		pos += sizeof(*regd_cc) + rules_len + sign_len;
+ 		if (memcmp(regd_cc->alpha2, alpha2, 2))
+ 			continue;
+ 
+ 		req_len = sizeof(*req) + rules_len + sign_len;
+ 		req = kzalloc(req_len, GFP_KERNEL);
+ 
+ 		if (!req)
+ 			return NULL;
+ 
+ 		req->ver = regd_cc->ver;
+ 		req->sign_type = regd_cc->sign_type;
+ 		req->size = cpu_to_le32(rules_len + sign_len);
+ 		req->n_reg_rules = regd_cc->n_reg_rules;
+ 
+ 		memcpy(req->alpha2, regd_cc->alpha2, 2);
+ 		memcpy(req->data, regd_cc->data, rules_len + sign_len);
+ 
+ 		ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+ 						MCU_CE_CMD(SET_REGD_CH),
+ 						req, req_len, true, &ret_skb);
+ 
+ 		kfree(req);
+ 
+ 		return ret < 0 ? NULL : ret_skb;
+ 	}
+ 
+ 	return NULL;
+ }
+ 
+ int mt7921_regd_update(struct mt792x_phy *phy, char *alpha2)
+ {
+ 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+ 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+ 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+ 	struct mt7921_regd_rule *mt7921_rule;
+ 	struct mt76_dev *mdev = &dev->mt76;
+ 	struct ieee80211_regdomain *regd;
+ 	struct ieee80211_reg_rule *rule;
+ 	struct mt7921_regd_rule_ev *ev;
+ 	int i, num_of_rules = 0;
+ 	struct sk_buff *skb;
+ 	int ret = 0;
+ 
+ 	if (dev->hw_full_reset)
+ 		return 0;
+ 
+ 	if (!MT7921_REGD_SUPPORTED(phy))
+ 		return -EOPNOTSUPP;
+ 
+ 	mt792x_mutex_acquire(dev);
+ 	skb = mt7921_regd_query_regdb(phy, alpha2);
+ 	mt792x_mutex_release(dev);
+ 
+ 	if (!skb) {
+ 		ret = -EINVAL;
+ 		goto err;
+ 	}
+ 
+ 	if (skb->len < sizeof(*ev) + 4) {
+ 		ret = -EINVAL;
+ 		goto err;
+ 	}
+ 
+ 	ev = (struct mt7921_regd_rule_ev *)(skb->data + 4);
+ 	num_of_rules = le32_to_cpu(ev->n_reg_rules);
+ 
+ 	if (!num_of_rules ||
+ 	    WARN_ON_ONCE(num_of_rules > NL80211_MAX_SUPP_REG_RULES)) {
+ 		ret = -EINVAL;
+ 		goto err;
+ 	}
+ 
+ 	if (skb->len < struct_size(ev, reg_rule, num_of_rules) + 4) {
+ 		ret = -EINVAL;
+ 		goto err;
+ 	}
+ 
+ 	regd = kzalloc(struct_size(regd, reg_rules, num_of_rules), GFP_KERNEL);
+ 	if (!regd) {
+ 		ret = -ENOMEM;
+ 		goto err;
+ 	}
+ 
+ 	for (i = 0; i < num_of_rules; i++) {
+ 		mt7921_rule = &ev->reg_rule[i];
+ 		rule = &regd->reg_rules[i];
+ 
+ 		rule->freq_range.start_freq_khz =
+ 			MHZ_TO_KHZ(le32_to_cpu(mt7921_rule->start_freq));
+ 		rule->freq_range.end_freq_khz =
+ 			MHZ_TO_KHZ(le32_to_cpu(mt7921_rule->end_freq));
+ 		rule->freq_range.max_bandwidth_khz =
+ 			MHZ_TO_KHZ(le32_to_cpu(mt7921_rule->max_bw));
+ 		/* not used by fw */
+ 		rule->power_rule.max_antenna_gain = DBI_TO_MBI(6);
+ 		rule->power_rule.max_eirp = DBM_TO_MBM(22);
+ 		rule->flags = le32_to_cpu(mt7921_rule->flags);
+ 	}
+ 
+ 	regd->n_reg_rules = num_of_rules;
+ 	regd->dfs_region = ev->dfs_region;
+ 
+ 	memcpy(regd->alpha2, alpha2, 2);
+ 	memcpy(mdev->alpha2, alpha2, 2);
+ 
+ 	dev->regd_change = true;
+ 	mt7921_mcu_regd_update(dev, alpha2, ENVIRON_ANY);
+ 
+ 	ret = regulatory_set_wiphy_regd(wiphy, regd);
+ 
+ 	kfree(regd);
+ err:
+ 	dev_kfree_skb(skb);
+ 
+ 	if (ret < 0)
+ 		return regulatory_set_wiphy_regd(wiphy, &mt7921_regd_ww);
+ 
+ 	return ret;
+ }
+ EXPORT_SYMBOL_GPL(mt7921_regd_update);
+ 
  static bool
  mt7921_regd_is_valid_alpha2(const char *alpha2)
  {
@@@ -191,7 -370,9 +371,9 @@@ int mt7921_regd_change(struct mt792x_ph
  	if (!memcmp(alpha2, mdev->alpha2, 2))
  		return 0;
  
- 	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+ 	if (MT7921_REGD_SUPPORTED(phy))
+ 		return mt7921_regd_update(phy, alpha2);
+ 	else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
  		return regulatory_hint(wiphy, alpha2);
  	else
  		return mt7921_mcu_set_clc(dev, alpha2, ENVIRON_INDOOR);
@@@ -204,7 -385,11 +386,11 @@@ int mt7921_regd_init(struct mt792x_phy 
  	struct mt792x_dev *dev = mt792x_hw_dev(hw);
  	struct mt76_dev *mdev = &dev->mt76;
  
- 	if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
+ 	if (MT7921_REGD_SUPPORTED(phy)) {
+ 		wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED |
+ 					   REGULATORY_DISABLE_BEACON_HINTS;
+ 		return mt7921_regd_update(phy, "00");
+ 	} else if (phy->chip_cap & MT792x_CHIP_CAP_11D_EN)
  		wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE |
  					   REGULATORY_DISABLE_BEACON_HINTS;
  	else
