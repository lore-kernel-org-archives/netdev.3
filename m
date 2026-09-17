Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EB4D17B1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671837; cv=none; b=Hms1eYmJndZl3d5riFsO2icoMmpfzGRegkQL+PsuPtAmPUhTn5W1y8+F/6tExbaR9/tJ3GAOe7kXY99yDPnIIb9bSBQoaoBMtc7NugxikwDWRDUPdniMiTNCiuLeh6OykMGOnvuhgjtndUmJZogvTjbX1WHf3MalVNQje9OOivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671837; c=relaxed/simple;
	bh=OLZID42pPMN04HGauhtTfWuZxPmP5Meo6qGQ7Li5M4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmKn2loXZSyaw8D7wD+Tbo2P58ULnrm8/iGSKenDdLIJYw3VMc7K5j6hc74uqBrnXs+R73NcFxs0F/N4rynzQxqFLkBnlCXShKryXtKvGSY17QtdKX3pyI37DNBUH/0dBqpFVO/FyrrL0N2CxuGg7atD7NN1dk5df7UKo0/Rzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5FQLC1C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5FQLC1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789671834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kd7ve/ETXrtuVxH9TgTAu12Pa3xhhvP5Wd1l1AlHCZQ=;
	b=d5FQLC1C687n8+2W0EY/1d6OuXV+Nw5vYWoP//Lc5fg3NDXqHM/Bh2SK+PJcYox+Zov0WT
	4c+c0X9MxPlPoJ5qbC+aO4I5XSnoKu3x6z+Cnw4Dsyw081poM8fyzWwqkcXeEoUft82too
	MuJwBH6mFi53vnlpt3uQ11REgEp7OZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-_a3_3AhVM029upCQa8ESvg-1; Thu,
 17 Sep 2026 15:03:51 -0400
X-MC-Unique: _a3_3AhVM029upCQa8ESvg-1
X-Mimecast-MFC-AGG-ID: _a3_3AhVM029upCQa8ESvg_1789671829
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 180BF18052E5;
	Thu, 17 Sep 2026 19:03:49 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B55D430001A2;
	Thu, 17 Sep 2026 19:03:45 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next] ice: describe generic DPLL pins from firmware pin classification
Date: Thu, 17 Sep 2026 21:03:39 +0200
Message-ID: <20260917190339.3239476-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When the number of CGU pins reported by firmware does not match the
static pin table for the device, the driver falls back to the generic
pins added by commit 6e58c33106220c ("ice: fix crash on probe for DPLL
enabled E810 LOM"), named "0" to "15". The same labels are used for
inputs and outputs, so a PIN_ID_GET lookup by board label fails with
"multiple matches" for any index present on both sides and userspace
such as synce4l cannot address the pin at all. The pin type is guessed
from the current frequency and no supported frequency list is exposed.

Firmware already classifies every input pin. Get CGU Input Config
(0x0C63) returns a type field marking GPS, PHY recovered clock and
external inputs, and a capability field with the supported 1PPS and
10 MHz frequencies. The driver discards both, ice_dpll_pin_state_update()
passes NULL for them.

Use them in the generic path. Inputs become GNSS-<n>, RCLK-<n>, EXT-<n>,
or IN-<n> when firmware reports no kind, with the matching dpll pin type
and frequency list. An external input flagged as accepting any frequency
advertises the standard 1PPS and 10 MHz pair. Outputs become OUT-<n>.
Labels are unique across both directions and the 16 pin limit, which
existed only because of the static label table, is gone. Labels that
happened to be unique before, indexes above the smaller of the two pin
counts, change as well.

On an E810-C timing board firmware reports the C827 recovered clock
inputs as PHY, the SMA inputs as external with 1PPS and 10 MHz, and the
GNSS input as GPS with 1PPS, matching the static table for that board.
A vendor board with 8 inputs and 15 outputs, which takes the generic
path today, gets addressable and correctly typed pins instead of
ambiguous numbers. The DPLL registration on such boards is fixed by
"ice: DPLL init fixes for E810 timing boards" on iwl-net, this patch
is independent of it.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 72 +++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 4 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 81bb32d2b23012..6e3e8fa94a3823 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4284,10 +4284,60 @@ static void ice_dpll_phase_range_set(struct dpll_pin_phase_adjust_range *range,
 	range->max = phase_adj;
 }
 
+/**
+ * ice_dpll_init_info_pin_generic_input - describe a generic input pin
+ * @pf: board private structure
+ * @pin: pin to describe
+ *
+ * Derive the pin type, board label and supported frequencies from the pin
+ * classification reported by firmware.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - AQ failure
+ */
+static int
+ice_dpll_init_info_pin_generic_input(struct ice_pf *pf, struct ice_dpll_pin *pin)
+{
+	u8 type, caps, num;
+	const char *kind;
+	int ret;
+
+	ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, &type, &caps,
+				       NULL, NULL, NULL);
+	if (ret)
+		return ret;
+
+	if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_GPS) {
+		pin->prop.type = DPLL_PIN_TYPE_GNSS;
+		kind = "GNSS";
+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_PHY) {
+		pin->prop.type = DPLL_PIN_TYPE_MUX;
+		kind = "RCLK";
+	} else if (type & ICE_AQC_GET_CGU_IN_CFG_TYPE_EXTERNAL) {
+		pin->prop.type = DPLL_PIN_TYPE_EXT;
+		kind = "EXT";
+		if (caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_ANYFREQ)
+			caps |= ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP |
+				ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
+	} else {
+		pin->prop.type = pin->freq == ICE_DPLL_PIN_GEN_RCLK_FREQ ?
+				 DPLL_PIN_TYPE_MUX : DPLL_PIN_TYPE_EXT;
+		kind = "IN";
+	}
+	snprintf(pin->label, sizeof(pin->label), "%s-%u", kind, pin->idx);
+	pin->prop.board_label = pin->label;
+	pin->prop.freq_supported =
+		ice_cgu_get_pin_freq_supp_by_caps(caps, &num);
+	pin->prop.freq_supported_num = num;
+
+	return 0;
+}
+
 /**
  * ice_dpll_init_info_pins_generic - initializes generic pins info
  * @pf: board private structure
- * @input: if input pins initialized
+ * @input: if we are initializing input pins
  *
  * Init information for generic pins, cache them in PF's pins structures.
  *
@@ -4298,13 +4348,10 @@ static void ice_dpll_phase_range_set(struct dpll_pin_phase_adjust_range *range,
 static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 {
 	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
-	static const char labels[][sizeof("99")] = {
-		"0", "1", "2", "3", "4", "5", "6", "7", "8",
-		"9", "10", "11", "12", "13", "14", "15" };
 	u32 cap = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 	enum ice_dpll_pin_type pin_type;
-	int i, pin_num, ret = -EINVAL;
 	struct ice_dpll_pin *pins;
+	int i, pin_num, ret = 0;
 	u32 phase_adj_max;
 
 	if (input) {
@@ -4319,12 +4366,9 @@ static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 		phase_adj_max = pf->dplls.output_phase_adj_max;
 		pin_type = ICE_DPLL_PIN_TYPE_OUTPUT;
 	}
-	if (pin_num > ARRAY_SIZE(labels))
-		return ret;
 
 	for (i = 0; i < pin_num; i++) {
 		pins[i].idx = i;
-		pins[i].prop.board_label = labels[i];
 		ice_dpll_phase_range_set(&pins[i].prop.phase_range,
 					 phase_adj_max);
 		pins[i].prop.capabilities = cap;
@@ -4332,12 +4376,16 @@ static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
 		if (ret)
 			break;
-		if (input && pins[i].freq == ICE_DPLL_PIN_GEN_RCLK_FREQ)
-			pins[i].prop.type = DPLL_PIN_TYPE_MUX;
-		else
+		if (!input) {
+			snprintf(pins[i].label, sizeof(pins[i].label),
+				 "OUT-%u", pins[i].idx);
+			pins[i].prop.board_label = pins[i].label;
 			pins[i].prop.type = DPLL_PIN_TYPE_EXT;
-		if (!input)
 			continue;
+		}
+		ret = ice_dpll_init_info_pin_generic_input(pf, &pins[i]);
+		if (ret)
+			break;
 		ret = ice_aq_get_cgu_ref_prio(&pf->hw, de->dpll_idx, i,
 					      &de->input_prio[i]);
 		if (ret)
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 103ba3e490682c..2360d920eb9ed8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -6,6 +6,7 @@
 
 #include "ice.h"
 
+#define ICE_DPLL_PIN_LABEL_LEN		16
 #define ICE_DPLL_RCLK_NUM_MAX	4
 #define ICE_DPLL_TXCLK_NUM_MAX	2
 #define E825_EXT_EREF_PIN_IDX	0
@@ -83,6 +84,7 @@ struct ice_dpll_pin {
 	bool active;
 	bool hidden;
 	enum ice_e825c_ref_clk tx_ref_src;
+	char label[ICE_DPLL_PIN_LABEL_LEN];
 };
 
 /** ice_dpll - store info required for DPLL control
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751b5..2ee6a720bd8929 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6059,6 +6059,37 @@ ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num)
 	return t[pin].freq_supp;
 }
 
+/**
+ * ice_cgu_get_pin_freq_supp_by_caps - get supported frequencies from pin caps
+ * @caps: input pin capability flags from Get CGU Input Config
+ * @num: number of returned frequencies
+ *
+ * Return: array of supported frequencies, NULL if no fixed frequency is
+ * advertised.
+ */
+struct dpll_pin_frequency *
+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num)
+{
+	bool pps = caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_1PPS_SUPP;
+	bool mhz = caps & ICE_AQC_GET_CGU_IN_CFG_FLG1_10MHZ_SUPP;
+
+	if (pps && mhz) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_common);
+		return ice_cgu_pin_freq_common;
+	}
+	if (pps) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_1_hz);
+		return ice_cgu_pin_freq_1_hz;
+	}
+	if (mhz) {
+		*num = ARRAY_SIZE(ice_cgu_pin_freq_10_mhz);
+		return ice_cgu_pin_freq_10_mhz;
+	}
+	*num = 0;
+
+	return NULL;
+}
+
 /**
  * ice_cgu_get_pin_name - get pin's name
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 16b1988e993d2f..c59d9488b52220 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -367,6 +367,8 @@ int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
 ice_cgu_get_pin_freq_supp(struct ice_hw *hw, u8 pin, bool input, u8 *num);
+struct dpll_pin_frequency *
+ice_cgu_get_pin_freq_supp_by_caps(u8 caps, u8 *num);
 const char *ice_cgu_get_pin_name(struct ice_hw *hw, u8 pin, bool input);
 int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
 		      enum dpll_lock_status last_dpll_state, u8 *pin,
-- 
2.55.0

