Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742F49E5D8
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300698; cv=none; b=BDeIenIFp9V4cCPW3G/vmJbuubpaeBZm4Iizw2BSRk3/Dr2IXqeV/Zve7F3bLfBb4GH4UQpiPEgr0/dBLlIYN53jPvpXJDdyMDLk5QO6XUj6ZbzrgNUj91+YPUU4nejogcp4HLho2qan+50hCRqSwBH+WWJlgt/VaSWTZWRNwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300698; c=relaxed/simple;
	bh=NDcWWfUqcXcst6/4FXE15/mqx3d3Elv04MQM40QjygQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0IOK5wphYdodnAh0c0aqvq16hj2YfIa1vdI0EKN52wAbCqucXGLFVZu5Rt+L2sT8QtvruBpIphiNUlfIt9ZygaJCn5+zYV2CUbyYEiVsbILU8cAmNR9IjGB3FG25bGeug8jqVQ3KNoxpFjwlviUzt5KNfCx+aB/jX0SbZYzR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDAwPTRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDAwPTRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791300696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ux8o+bJzBRtT2IkkN8Eeam1tG44ASM1U0Q7eBguhy4=;
	b=PDAwPTRZT9Jg5xGyEpuK5uEXvSd4tiVi5N51Nw1zWUnXgC9IwN6EcvV1lg90qObf/Mzgxa
	W30Ax2AbSkRATx6Iql90ORBprc8/YwWK73kha9lBbXkVzyS7N/XXH4HOdbTrUr4LUNSgzY
	RM7oUT9amcAR72GpwujgtCgxV1QK/Ag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-hdYPv0lSO42IDaL6cVsxTA-1; Tue,
 06 Oct 2026 11:31:31 -0400
X-MC-Unique: hdYPv0lSO42IDaL6cVsxTA-1
X-Mimecast-MFC-AGG-ID: hdYPv0lSO42IDaL6cVsxTA_1791300689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A35191869BBC;
	Tue,  6 Oct 2026 15:31:29 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 216511800592;
	Tue,  6 Oct 2026 15:31:26 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/4] dpll: zl3073x: reject inexact frequencies for N-divided outputs
Date: Tue,  6 Oct 2026 17:31:15 +0200
Message-ID: <20261006153116.347497-4-ivecera@redhat.com>
In-Reply-To: <20261006153116.347497-1-ivecera@redhat.com>
References: <20261006153116.347497-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

For N-divided outputs the P-pin and N-pin share the output divisor and
the N-pin frequency is synth_freq / (div * esync_n_period). The frequency
set helper computed esync_n_period with a truncating division and only
rejected a zero result, so a frequency that does not divide evenly was
silently rounded. Setting the P-pin could then shift the N-pin frequency
too (e.g. 600 MHz synth, div=60, period=10 gives P=10 MHz, N=1 MHz;
setting P to 2.5 MHz moves N to 1.25 MHz).

Check the division remainder and reject the request if it is not exact,
and require esync_n_period >= 2 so the N-pin frequency stays below the
P-pin one.

Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 7c997966c3c3..65107b4cc4f8 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1007,15 +1007,28 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 
 	if (zl3073x_dpll_is_p_pin(pin)) {
 		/* We are going to change output frequency for P-pin but
-		 * if the requested frequency is less than current N-pin
-		 * frequency then indicate a failure as we are not able
+		 * if the requested frequency is less or equal than current
+		 * N-pin frequency then indicate a failure as we are not able
 		 * to compute N-pin divisor to keep its frequency unchanged.
 		 *
 		 * Update divisor for N-pin to keep N-pin frequency.
 		 */
-		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
-		if (!out.esync_n_period)
+		u64 prod = mul_u32_u32(out.esync_n_period, out.div);
+		u32 rem;
+
+		out.esync_n_period = div_u64_rem(prod, new_div, &rem);
+		if (rem != 0) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "OUT%uN freq must divide OUT%uP freq",
+					   out_id, out_id);
 			return -EINVAL;
+		}
+		if (out.esync_n_period < 2) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "OUT%uN freq must be less than OUT%uP freq",
+					   out_id, out_id);
+			return -EINVAL;
+		}
 
 		/* Update the output divisor */
 		out.div = new_div;
@@ -1030,9 +1043,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		 *
 		 * Update divisor for N-pin
 		 */
-		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
-		if (!out.esync_n_period)
+		u64 rem, prod = frequency * out.div;
+
+		out.esync_n_period = div64_u64_rem(synth_freq, prod, &rem);
+		if (rem != 0) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "OUT%uN freq must divide OUT%uP freq",
+					   out_id, out_id);
 			return -EINVAL;
+		}
+		if (out.esync_n_period < 2) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "OUT%uN freq must be less than OUT%uP freq",
+					   out_id, out_id);
+			return -EINVAL;
+		}
 	}
 
 	/* For 50/50 duty cycle the divisor is equal to width */
-- 
2.55.0

