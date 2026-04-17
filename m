Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976503B8D7B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437979; cv=none; b=DyTXENxXPH7+nBpPzA6b5CIxABQ8cofIqSxsDXNYgfNE3Xtte71qMzlETMTHH0n41/ETQraUov/+EQwdiTgu2mxYq2H5bhMwfHWqN8W6lTYONVFvf32dLdlAfjJ7xb2XeRTIFTe4+Kf4KEzpjm+GkxsyyQg2C2fGSj3q9sbrrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437979; c=relaxed/simple;
	bh=U9v7yjnTehJh/xdHuBMwMeMMQWCt3zp6D5P1WM7JGUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqxXlULSqippp6FWi5+GbDFDmMl4KuCZ5kt7iP4xzUbe4f3buBCK4SLzof4pvQdLlT4IE1jY7jMVnpuIy305yl4T8+rScQkU5KFAs/nPcgVNe8Wj7GMgyHwrt6dji+BGYFQeWy4T1bHsJsPwsEdelyQKO72yxjUOjtgG+rpb35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1Y+vpf1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1Y+vpf1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776437974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEPdyw6AatoRW7dZ87XoM4QrLpIsuCA3Ya6pp2WqSW0=;
	b=Q1Y+vpf1bS+Ay2pfj+ut9pJZXVjxV+b2h6enuM4mVYQq20LMbKzUOIOVvw0Gz9Jv1OSswO
	cb9UlJz1HMdQV3ztppqnZPtjaW0oEh08xmUqrs3YUff4F7zsf18lfp6wZoGhPDJXx4nd7w
	BFB7XNrV3/O9szksD8Rte2IYwZSvMic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-ZQ7uMKMdOJO3sSbQVQ9QGQ-1; Fri,
 17 Apr 2026 10:59:31 -0400
X-MC-Unique: ZQ7uMKMdOJO3sSbQVQ9QGQ-1
X-Mimecast-MFC-AGG-ID: ZQ7uMKMdOJO3sSbQVQ9QGQ_1776437969
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15302195608B;
	Fri, 17 Apr 2026 14:59:29 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8D9E3000C1C;
	Fri, 17 Apr 2026 14:59:23 +0000 (UTC)
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
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v7 2/3] ice: fix missing dpll notifications for SW pins
Date: Fri, 17 Apr 2026 16:59:06 +0200
Message-ID: <20260417145907.696307-3-poros@redhat.com>
In-Reply-To: <20260417145907.696307-1-poros@redhat.com>
References: <20260417145907.696307-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The SMA/U.FL pin redesign (commit 2dd5d03c77e2 ("ice: redesign dpll
sma/u.fl pins control")) introduced software-controlled pins that wrap
backing CGU input/output pins, but never updated the notification and
data paths to propagate pin events to these SW wrappers.

The periodic work sends dpll_pin_change_ntf() only for direct CGU input
pins.  SW pins that wrap these inputs never receive change or phase
offset notifications, so userspace consumers such as synce4l monitoring
SMA pins via dpll netlink never learn about state transitions or phase
offset updates.  Similarly, ice_dpll_phase_offset_get() reads the SW
pin's own phase_offset field which is never updated; the PPS monitor
writes to the backing CGU input's field instead.

Fix by introducing ice_dpll_pin_ntf(), a wrapper around
dpll_pin_change_ntf() that also notifies any registered SMA/U.FL pin
whose backing CGU input matches.  Replace all direct
dpll_pin_change_ntf() calls in the periodic notification paths with
this wrapper.  Fix ice_dpll_phase_offset_get() to return the backing
CGU input's phase_offset for input-direction SW pins.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 47 +++++++++++++++++------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 3a90a2940fdc6e..11b942b83500fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1963,7 +1963,10 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 				       d->active_input == p->input->pin))
 		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
 	else if (d->phase_offset_monitor_period)
-		*phase_offset = p->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
+		*phase_offset = (p->input &&
+				 p->direction == DPLL_PIN_DIRECTION_INPUT ?
+				 p->input->phase_offset :
+				 p->phase_offset) * ICE_DPLL_PHASE_OFFSET_FACTOR;
 	else
 		*phase_offset = 0;
 	mutex_unlock(&pf->dplls.lock);
@@ -2659,6 +2662,27 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
+ * @dplls: pointer to dplls struct
+ * @pin: the dpll_pin that changed
+ *
+ * Send a change notification for @pin and for any registered SMA/U.FL pin
+ * whose backing CGU input matches @pin.
+ */
+static void ice_dpll_pin_ntf(struct ice_dplls *dplls, struct dpll_pin *pin)
+{
+	dpll_pin_change_ntf(pin);
+	for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
+		if (dplls->sma[i].pin && dplls->sma[i].input &&
+		    dplls->sma[i].input->pin == pin)
+			dpll_pin_change_ntf(dplls->sma[i].pin);
+		if (dplls->ufl[i].pin && dplls->ufl[i].input &&
+		    dplls->ufl[i].input->pin == pin)
+			dpll_pin_change_ntf(dplls->ufl[i].pin);
+	}
+}
+
 /**
  * ice_dpll_notify_changes - notify dpll subsystem about changes
  * @d: pointer do dpll
@@ -2667,6 +2691,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2675,17 +2700,17 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 	}
 	if (d->prev_input != d->active_input) {
 		if (d->prev_input)
-			dpll_pin_change_ntf(d->prev_input);
+			ice_dpll_pin_ntf(dplls, d->prev_input);
 		d->prev_input = d->active_input;
 		if (d->active_input) {
-			dpll_pin_change_ntf(d->active_input);
+			ice_dpll_pin_ntf(dplls, d->active_input);
 			pin_notified = true;
 		}
 	}
 	if (d->prev_phase_offset != d->phase_offset) {
 		d->prev_phase_offset = d->phase_offset;
 		if (!pin_notified && d->active_input)
-			dpll_pin_change_ntf(d->active_input);
+			ice_dpll_pin_ntf(dplls, d->active_input);
 	}
 }
 
@@ -2714,6 +2739,7 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
 
 /**
  * ice_dpll_pins_notify_mask - notify dpll subsystem about bulk pin changes
+ * @dplls: pointer to dplls struct
  * @pins: array of ice_dpll_pin pointers registered within dpll subsystem
  * @pin_num: number of pins
  * @phase_offset_ntf_mask: bitmask of pin indexes to notify
@@ -2723,15 +2749,14 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
  *
  * Context: Must be called while pf->dplls.lock is released.
  */
-static void ice_dpll_pins_notify_mask(struct ice_dpll_pin *pins,
+static void ice_dpll_pins_notify_mask(struct ice_dplls *dplls,
+				      struct ice_dpll_pin *pins,
 				      u8 pin_num,
 				      u32 phase_offset_ntf_mask)
 {
-	int i = 0;
-
-	for (i = 0; i < pin_num; i++)
-		if (phase_offset_ntf_mask & (1 << i))
-			dpll_pin_change_ntf(pins[i].pin);
+	for (int i = 0; i < pin_num; i++)
+		if (phase_offset_ntf_mask & BIT(i))
+			ice_dpll_pin_ntf(dplls, pins[i].pin);
 }
 
 /**
@@ -2907,7 +2932,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 	if (phase_offset_ntf)
-		ice_dpll_pins_notify_mask(d->inputs, d->num_inputs,
+		ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
 					  phase_offset_ntf);
 
 resched:
-- 
2.52.0

