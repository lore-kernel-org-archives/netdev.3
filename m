Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A3342CBA
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720200; cv=none; b=Q7I1ii8PEDqIrAMaGJ41vHPSPwFAFMMhhmicejCXJo7hlB8nNXsrUshvl2LE1liRSS6chhceIazMRy4L25RxHr9x5Cegq6VvhknGN9MrwNIWNKxhrsxgiUWI14bXQmIwo0HP1I1VlHpk2g99eqeoacRXUsteaRjCdw1gTAdjKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720200; c=relaxed/simple;
	bh=vxeDzG0dETAgd8enYff39xewjU+LR/JSW1IPUs7/rrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVPJTbqwY3yU9I+/8OXNMxC3yxayskYuwndrEdbLP6QtyPlLsVbfA/7ekmUgWOsnL6TECOQcWxssfo7ycxVzChDmFL92QCV2nUlfTb56LpB5T4fdgT6GMtZaqcvHKvWWXQc3aj6HGhVl0nXvjb9KFG0Ja6ytLxPRiQwI+rqyjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdGv2XZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdGv2XZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770720198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nfR/OF7oQxX+S9y8bWGeGsU+wME2509CjFgofV0CQpM=;
	b=HdGv2XZ/rPJ0UcPvF5ggcdfNYGkGtY1IdVRAwoEFcq1ToUzcn/bgeCpJA63VcQ18T7ycy4
	BugZUgXRV0n/4Yy6HeHFEa/kpeGUglRx/T+sb4F6/33CKyC3UVxf8z4iWlej9ol6T8JIzq
	cPumobOxET+R1Xy2Q86VHyYTcXZfUNk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-yf8Vy9SiOuGcMdPRGTLIiw-1; Tue,
 10 Feb 2026 05:43:14 -0500
X-MC-Unique: yf8Vy9SiOuGcMdPRGTLIiw-1
X-Mimecast-MFC-AGG-ID: yf8Vy9SiOuGcMdPRGTLIiw_1770720192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B97A180034D;
	Tue, 10 Feb 2026 10:43:12 +0000 (UTC)
Received: from p16v (unknown [10.43.3.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B111180066D;
	Tue, 10 Feb 2026 10:43:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] ice: dpll: fix rclk pin state get and misplaced header macros
Date: Tue, 10 Feb 2026 11:42:59 +0100
Message-ID: <20260210104259.121729-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix two issues introduced in commit ad1df4f2d591 ("ice: dpll: Support
E825-C SyncE and dynamic pin discovery"):

* The refactoring of ice_dpll_rclk_state_on_pin_get() to use
  ice_dpll_pin_get_parent_idx() omitted the base_rclk_idx adjustment
  that was correctly added in the ice_dpll_rclk_state_on_pin_set() path.
  This breaks E810 devices where base_rclk_idx is non-zero, causing
  the wrong hardware index to be used for pin state lookup and incorrect
  recovered clock state to be reported via the DPLL subsystem. E825C is
  unaffected as its base_rclk_idx is 0.

* Add bounds check against ICE_DPLL_RCLK_NUM_MAX on hw_idx after the
  base_rclk_idx subtraction in both ice_dpll_rclk_state_on_pin_{get,set}()
  to prevent out-of-bounds access on the pin state array.

* The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related field
  masks) were placed after the #endif of the _ICE_DPLL_H_ include guard,
  leaving them unprotected. Move them inside the guard.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c |  5 ++++
 drivers/net/ethernet/intel/ice/ice_dpll.h | 32 +++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index baf02512d041a..73a4e28ed75fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2440,6 +2440,8 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 	if (hw_idx < 0)
 		goto unlock;
 	hw_idx -= pf->dplls.base_rclk_idx;
+	if (hw_idx >= ICE_DPLL_RCLK_NUM_MAX)
+		goto unlock;
 
 	if ((enable && p->state[hw_idx] == DPLL_PIN_STATE_CONNECTED) ||
 	    (!enable && p->state[hw_idx] == DPLL_PIN_STATE_DISCONNECTED)) {
@@ -2503,6 +2505,9 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
 	if (hw_idx < 0)
 		goto unlock;
+	hw_idx -= pf->dplls.base_rclk_idx;
+	if (hw_idx >= ICE_DPLL_RCLK_NUM_MAX)
+		goto unlock;
 
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_RCLK_INPUT,
 					extack);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index ae42cdea0ee14..8678575359b92 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -8,6 +8,22 @@
 
 #define ICE_DPLL_RCLK_NUM_MAX	4
 
+#define ICE_CGU_R10			0x28
+#define ICE_CGU_R10_SYNCE_CLKO_SEL	GENMASK(8, 5)
+#define ICE_CGU_R10_SYNCE_CLKODIV_M1	GENMASK(13, 9)
+#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD	BIT(14)
+#define ICE_CGU_R10_SYNCE_DCK_RST	BIT(15)
+#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL	GENMASK(18, 16)
+#define ICE_CGU_R10_SYNCE_ETHDIV_M1	GENMASK(23, 19)
+#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD	BIT(24)
+#define ICE_CGU_R10_SYNCE_DCK2_RST	BIT(25)
+#define ICE_CGU_R10_SYNCE_S_REF_CLK	GENMASK(31, 27)
+
+#define ICE_CGU_R11			0x2C
+#define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
+
+#define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
+
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
  * @ICE_DPLL_PIN_SW_1_IDX: index of first SW pin
@@ -157,19 +173,3 @@ static inline void ice_dpll_deinit(struct ice_pf *pf) { }
 #endif
 
 #endif
-
-#define ICE_CGU_R10				0x28
-#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
-#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
-#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
-#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
-#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
-#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
-#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
-#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
-#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
-
-#define ICE_CGU_R11				0x2C
-#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
-
-#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
-- 
2.52.0

