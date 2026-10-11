Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929C3E317B
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699151; cv=none; b=qA8EKnqfl1zKhIP40tIyDDNZ94Rb1DQNGVSs2nEQAGPAQQ57c9ujKY4Yrm1Rde8ScNKOoTsQoU1FJ9VtGMd5z9y+rxKRfpbJjx4p+I54OFpP2dzK+yZr5xzPbQYeyebxVpzorZXDpO6DInvBthmYU6P4IBXZx61JA6YPGjF4WgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699151; c=relaxed/simple;
	bh=vj6H1vowi2lzxnQSBay1TKsc7Z/dB/o1ypHjOfhCG6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+dvI87DEf2Yqcc6Xw7CXMLecgrXp9ufPT5TkqclmiVH5UtMD0K8W6pxdlgxpZf1VwXyYKmRQB/AVKpPfYPfr/94/eoVtvHqI0M3mms3CNGWcao0L0jGC6u3B2bHKROZ3q1Cl9f5jNbraGClDTr5IfsZUiUzauROvwiOfpiVGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aO+LB0rS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO+LB0rS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791699148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRD/ercjdw7VLBbGpPtluMnT33XK5IWG7zFOISNZCnE=;
	b=aO+LB0rSYbOCVFKJtlPpQRUhrwJGMWCrS/A1TOiSnECmnqQXYhc32m8luMF4puCfwwxV27
	GxMtZGSuaxn42jXpfmx1mUsos8X+23kEVKTfQzxdgzAmf0s79ZVxt8UDjndqiOGfDmvbye
	7QlenL8qWGybRdEfL/DM/Lk42g5AnuA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-lgqQXx-GO1eAZNx_OD_w4w-1; Sun,
 11 Oct 2026 06:12:26 +0000
X-MC-Unique: lgqQXx-GO1eAZNx_OD_w4w-1
X-Mimecast-MFC-AGG-ID: lgqQXx-GO1eAZNx_OD_w4w_1791699145
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2DB18009CC;
	Sun, 11 Oct 2026 06:12:24 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 877671956095;
	Sun, 11 Oct 2026 06:12:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 3/5] dpll: zl3073x: reject output frequencies with too small divisor
Date: Sun, 11 Oct 2026 08:12:09 +0200
Message-ID: <20261011061211.448373-4-ivecera@redhat.com>
In-Reply-To: <20261011061211.448373-1-ivecera@redhat.com>
References: <20261011061211.448373-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The output divisor has to be at least 2: a divisor of 1 bypasses the
divider and the hardware then ignores the pulse width and eSync
registers. For the N-pin of an N-divided output the N divider (>= 2)
applies on top, so its effective divisor has to be at least 4.

zl3073x_pin_check_freq() only checked that the frequency divides the
synth frequency. Require also the minimum divisor. For N-divided
outputs this is necessary but not sufficient, the rest is checked by
the frequency set callback.

Hit during development: an N-pin frequency that needs an N divider of 1
was accepted, and with esync_n_period = 1 the N-pin produced no output
on an oscilloscope.

Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index 768e5424de2d..4e006ed5950a 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -22,7 +22,8 @@
  * The function checks the given frequency is valid for the device. For input
  * pins it checks that the frequency can be factorized using supported base
  * frequencies. For output pins it checks that the frequency divides connected
- * synth frequency without remainder.
+ * synth frequency without remainder and that the resulting divisor is not
+ * below the minimum the driver supports.
  *
  * Return: true if the frequency is valid, false if not.
  */
@@ -41,18 +42,38 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
 		if (rc)
 			goto err_inv_freq;
 	} else {
-		u32 synth_freq;
-		u8 out, synth;
+		u32 synth_freq, div, min_div, rem;
+		const struct zl3073x_out *out;
+		u8 out_id, synth;
 
 		/* Get output pin synthesizer */
-		out = zl3073x_output_pin_out_get(id);
-		synth = zl3073x_dev_out_synth_get(zldev, out);
+		out_id = zl3073x_output_pin_out_get(id);
+		synth = zl3073x_dev_out_synth_get(zldev, out_id);
 
 		/* Get synth frequency */
 		synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
 
 		/* Check the frequency divides synth frequency */
-		if (synth_freq % (u32)freq)
+		div = div_u64_rem(synth_freq, freq, &rem);
+		if (rem)
+			goto err_inv_freq;
+
+		/* The driver requires an output divisor of at least 2 -
+		 * below that the hardware bypasses the divider and ignores
+		 * the pulse width and eSync registers the driver programs.
+		 * For the N-pin of an N-divided output the effective divisor
+		 * also includes the N divider (>= 2), so the minimum is 4.
+		 * For N-divided outputs this is only a necessary condition -
+		 * whether the frequency can be set also depends on the output
+		 * divisor shared by both pins, which is checked when the
+		 * frequency is set.
+		 */
+		out = zl3073x_out_state_get(zldev, out_id);
+		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
+			min_div = 4;
+		else
+			min_div = 2;
+		if (div < min_div)
 			goto err_inv_freq;
 	}
 
-- 
2.56.0

