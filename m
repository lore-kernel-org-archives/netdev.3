Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC83BCD21
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621782; cv=none; b=o/K5UiiEPfD6evU0yYjxde7OwV0HxfdFHVHqdduZcRqZdzlBlsvV+hHE210wTXm9gJZUBROqOs8Mx8acdNDQbxy6LkAa0n2P/qGLCsPyzIHUUL8ndaH4s8cB0FH3fOG1u3HztW4neKBG5iMdVUNo+YJSp4Kk5880+yRoshjLZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621782; c=relaxed/simple;
	bh=5slQAElgfZpSC390llkyG2ptDvaG0tCGX9ooyuj1pgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu8LuO09t1D87dF0VX0gvoyeFbXlG4+Dnq2LTLvlPDNUoCicKGUU6cWdQB1rwkY2p43kvManYKWkfLT2OKn4j26/Ad2rc7BKIM4rzR++KkUgIbQRKcAIb/bWfecMJAHTSndrAeezYG7bRm2k7jdCga7wH6lwURXIPP3ftGaSiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3hdTjxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3hdTjxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790621777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4K00wFZX7obLjuq3aJ1gijSWm2lWXuSlMVN2kh/yO8=;
	b=Y3hdTjxliXgJPqYbgYvohqbM8jxJsn0XSLtmg6IvCftmLGiArUMPWi0Cqo93EOGQJT4wnY
	GNoSvTiSKhCye7g/z7OhxAXuyHUsQxECw83ThO2mLGSnYkId+inRJCTQF7RkHWQsWS7wsj
	reoJeOEme4lkJPbWEfRhkIv90Rfyq3U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-DnOc-uVlNcCiag2issrRsQ-1; Mon,
 28 Sep 2026 14:56:13 -0400
X-MC-Unique: DnOc-uVlNcCiag2issrRsQ-1
X-Mimecast-MFC-AGG-ID: DnOc-uVlNcCiag2issrRsQ_1790621771
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6DEB183EEF0;
	Mon, 28 Sep 2026 18:56:11 +0000 (UTC)
Received: from p16v.luc.cera.cz (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 567C71956041;
	Mon, 28 Sep 2026 18:56:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] dpll: zl3073x: consolidate pin capabilities into bitmap
Date: Mon, 28 Sep 2026 20:55:50 +0200
Message-ID: <20260928185552.1103515-5-ivecera@redhat.com>
In-Reply-To: <20260928185552.1103515-1-ivecera@redhat.com>
References: <20260928185552.1103515-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace the per-pin 'esync_control' boolean with a 'caps' bitmap in
struct zl3073x_dpll_pin. The bitmap is built from the pin properties
during pin registration and is easily extensible with further per-pin
capabilities.

No functional change intended.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 426974b0b5dc5c..fcf91aba2988af 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -38,7 +38,7 @@
  * @dir: pin direction
  * @id: pin id
  * @prio: pin priority <0, 14>
- * @esync_control: embedded sync is controllable
+ * @caps: pin capabilities (ZL3073X_DPLL_PIN_CAP_*)
  * @phase_gran: phase adjustment granularity
  * @operstate: last saved operational state
  * @phase_offset: last saved pin phase offset
@@ -55,7 +55,7 @@ struct zl3073x_dpll_pin {
 	enum dpll_pin_direction	dir;
 	u8			id;
 	u8			prio;
-	bool			esync_control;
+	u8			caps;
 	s32			phase_gran;
 	enum dpll_pin_operstate	operstate;
 	s64			phase_offset;
@@ -63,6 +63,17 @@ struct zl3073x_dpll_pin {
 	u32			measured_freq;
 };
 
+/*
+ * DPLL pin capabilities
+ */
+enum zl3073x_dpll_pin_caps {
+	ZL3073X_DPLL_PIN_CAP_ESYNC_BIT,
+	ZL3073X_DPLL_PIN_CAPS_NBITS /* must be last */
+};
+
+#define __ZL3073X_DPLL_PIN_CAP(name)	BIT(ZL3073X_DPLL_PIN_CAP_##name##_BIT)
+#define ZL3073X_DPLL_PIN_CAP_ESYNC	__ZL3073X_DPLL_PIN_CAP(ESYNC)
+
 /*
  * Supported esync ranges for input and for output per output pair type
  */
@@ -189,7 +200,8 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 
-	if (!pin->esync_control || zl3073x_ref_freq_get(ref) <= 1)
+	if (!(pin->caps & ZL3073X_DPLL_PIN_CAP_ESYNC) ||
+	    zl3073x_ref_freq_get(ref) <= 1)
 		return -EOPNOTSUPP;
 
 	esync->range = esync_freq_ranges;
@@ -897,7 +909,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	synth_freq = zl3073x_synth_freq_get(synth);
 	out_freq = synth_freq / out->div;
 
-	if (!pin->esync_control || out_freq <= 1)
+	if (!(pin->caps & ZL3073X_DPLL_PIN_CAP_ESYNC) || out_freq <= 1)
 		return -EOPNOTSUPP;
 
 	esync->range = esync_freq_ranges;
@@ -1837,14 +1849,17 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	if (IS_ERR(props))
 		return PTR_ERR(props);
 
-	/* Save package label, fwnode, esync capability and phase adjust
+	/* Save package label, fwnode, capabilities and phase adjust
 	 * granularity.
 	 */
 	strscpy(pin->label, props->package_label);
 	pin->fwnode = fwnode_handle_get(props->fwnode);
-	pin->esync_control = props->esync_control;
 	pin->phase_gran = props->dpll_props.phase_gran;
 
+	pin->caps = 0;
+	if (props->esync_control)
+		pin->caps |= ZL3073X_DPLL_PIN_CAP_ESYNC;
+
 	if (zl3073x_dpll_is_input_pin(pin)) {
 		const struct zl3073x_chan *chan;
 		u8 ref;
-- 
2.55.0

