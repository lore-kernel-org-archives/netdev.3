Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321108;
	b=PQgdBM1iFKYxGBQgLgaHzPnF8hahoN/pmJ0F0geVRHnosvsLEwYi9vXqPT2+z38Z9yQZ
	 va/jMIJ1Xlk+G9H/RIIV2AZ6cFy9z0zaDiUwa4m5uLov3RUr0ZM269QK/yT8VSYEM8/Xp
	 g42ZkLUcWN1gQXgQIXUYb0ZaWxxYo81OXNtuKgHZqiblWTHGUq75SyJnERzlWtRFGwGsJ
	 VDIyAHjcASjUINT9Ryt9T62+CvGzK4mhsxnLwclZhOqP7AwTQE5ssGIrLERbIhYNm4Xd3
	 Q0iXq1ItVt0zcIwgefDv9kv6IBFA43+CU2bKCe/nWuxlHsBMiuUfDuLFLexC1GA25AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321108;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=OlTyX/eRdkd2ub5ISBF1y4LBYRbIgdGhTfqDORaDu3k=;
	b=jiVromaCrYNkmnH5P5pDTmJ/0bp7N7ChFtENVYv8d9mIr+AduTQv64t5iZRupku5oAAe
	 79oc6cxZafRZzG+llfB7jHOIrz+JtziRz+hyyxkjFjT7tV2jWybmgw5AEkBHNiOD8BxHZ
	 8QtWtDRxg+/wK1S3m++hwb41DBrZNlo5hd5+vV3SkvSaak8zIZ7uCy92DXmteSvNip3z6
	 cMvNFYposrdr8WEBJAvY9t833idHI+cSn4Exk2kWB6GuHFlpi2U/6wHTdc34dWi2dH9Z+
	 OuBW/vxpcImiNasejq6qXMj4E3L8rG1N4leZCs52qaBjUddXG3OpjkmPw0P2liZnWgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=euCSPe+l;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922A606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4922A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=euCSPe+l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794321106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OlTyX/eRdkd2ub5ISBF1y4LBYRbIgdGhTfqDORaDu3k=;
	b=euCSPe+lDpI9zDM04alIKShDvAvPIv6B9+n9OGf1JjNAcYSO+MqkSsEOFPXXtpMRVcReUJ
	8C4DBI0AHuoyyufXu1MduJIIMXTLYoVc1ie87zc8P5pl7aVHsbRhzoWo8msWkNB0s2Dxoo
	+TQGIaDBaeuqolwxFtRn4NamtBlYh1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-a_fOVax3NlS4GWkOWJXNng-1; Tue,
 10 Nov 2026 09:31:42 -0500
X-MC-Unique: a_fOVax3NlS4GWkOWJXNng-1
X-Mimecast-MFC-AGG-ID: a_fOVax3NlS4GWkOWJXNng_1794321100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CC261956049;
	Tue, 10 Nov 2026 14:31:39 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.49])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 719A4180034C;
	Tue, 10 Nov 2026 14:31:32 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: dpll: refuse pin states that are not valid for the pin
Date: Tue, 10 Nov 2026 15:31:19 +0100
Message-ID: <20261110143119.2313907-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The DPLL core checks only that a pin may change its state, which states
a pin accepts is left to the driver. The ice callbacks turn the
requested state into an enable flag by comparing it with the one state
that enables the pin, so every other state disables it, including the
one that has no meaning for the pin.

The inputs of the EEC and PPS DPLLs are enabled by selectable, as these
DPLLs select their reference automatically. A request for connected,
which Documentation/driver-api/dpll.rst reserves for manual mode and
for pins with the state-connected-override capability, disables the
input. On an E810:

  # dpll pin set id 1 parent-device 0 state connected
  # dpll pin show id 1
  ... state disconnected on both DPLLs

A recovered clock pin is connected to or disconnected from its parent
pin, and a request for selectable disconnects it:

  # dpll pin set id 2109 parent-pin 2094 state selectable
  # dpll pin show id 2109
  ... state disconnected on parent 2094

Add a helper that translates the state for a pin given the state that
enables it. Disconnected disables the pin and anything else is refused
with -EINVAL and an extack message. Use it for the input and recovered
clock pins, and for the output pins, which already refused selectable
and now tell the user why.

The SMA pins have the same problem. It is left out here, as the rework
of the SMA and U.FL pin control that is queued for net-next refuses the
states these pins cannot serve.

Found with the pin state selftest of the dpllsim series running against
an ice E810.

Fixes: d7999f5ea64bb1 ("ice: implement dpll interface to control cgu")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 61 ++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..b2b515420bc8cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -961,6 +961,40 @@ static int ice_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 	return 0;
 }
 
+/**
+ * ice_dpll_pin_state_to_enable - translate a requested pin state
+ * @state: pin state requested by the user
+ * @on_state: the state that enables the pin
+ * @enable: on success true to enable the pin, false to disable it
+ * @extack: error reporting
+ *
+ * A pin is enabled by exactly one state: selectable for an input of the
+ * EEC and PPS DPLLs, which select their reference automatically, and
+ * connected for an output and for a recovered clock on its parent pin.
+ * Disconnected disables the pin. No other state has a meaning for the
+ * pin, so it is refused rather than taken for one of the two.
+ *
+ * Return:
+ * * 0 - success, @enable is set
+ * * -EINVAL - @state is not valid for the pin
+ */
+static int
+ice_dpll_pin_state_to_enable(enum dpll_pin_state state,
+			     enum dpll_pin_state on_state, bool *enable,
+			     struct netlink_ext_ack *extack)
+{
+	if (state != on_state && state != DPLL_PIN_STATE_DISCONNECTED) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "pin state must be %s or disconnected",
+				   on_state == DPLL_PIN_STATE_SELECTABLE ?
+				   "selectable" : "connected");
+		return -EINVAL;
+	}
+	*enable = state == on_state;
+
+	return 0;
+}
+
 /**
  * ice_dpll_pin_state_set - set pin's state on dpll
  * @pin: pointer to a pin
@@ -1027,12 +1061,15 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
 			  enum dpll_pin_state state,
 			  struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_CONNECTED;
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_dpll *d = dpll_priv;
+	bool enable;
+	int ret;
 
-	if (state == DPLL_PIN_STATE_SELECTABLE)
-		return -EINVAL;
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_CONNECTED,
+					   &enable, extack);
+	if (ret)
+		return ret;
 	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
 		return 0;
 
@@ -1062,7 +1099,13 @@ ice_dpll_input_state_set(const struct dpll_pin *pin, void *pin_priv,
 			 enum dpll_pin_state state,
 			 struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_SELECTABLE;
+	bool enable;
+	int ret;
+
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_SELECTABLE,
+					   &enable, extack);
+	if (ret)
+		return ret;
 
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
@@ -2518,18 +2561,24 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 			       enum dpll_pin_state state,
 			       struct netlink_ext_ack *extack)
 {
-	bool enable = state == DPLL_PIN_STATE_CONNECTED;
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	struct ice_hw *hw;
-	int ret = -EINVAL;
+	bool enable;
 	int hw_idx;
+	int ret;
 
 	hw = &pf->hw;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
 
+	ret = ice_dpll_pin_state_to_enable(state, DPLL_PIN_STATE_CONNECTED,
+					   &enable, extack);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	mutex_lock(&pf->dplls.lock);
 	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
 	if (hw_idx < 0)
-- 
2.56.0

