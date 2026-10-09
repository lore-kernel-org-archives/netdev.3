Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1D3B47F6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573984; cv=none; b=Jnsg5cYB6KqA62OJv6Aq6rujmJEK1SwRDOz6tnueGVuCcCCHXKPnZgFYSQPAkQw6ME4ww6WGjsrkpK/XfHjpWBT71f8wFapLbLzD12E8oXxViBJwp4IOEIMyuyCqSPQGIFYx90Yp+0bES5o+x7U0b8aEkQTmNO0Q04MA6iQteN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573984; c=relaxed/simple;
	bh=Ln8m+xnCksA9E6LXiU+gkb+LOEIEi15sW4QftJDr7aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enJ+F32Gr7vDHvfuaoawWnHZyhxQAOhh2U5oBgpsaOgTDnd80z9ho4QcHFmvgrgg3MLcP3x8BgEmRvXmux18VLMN3I7XN5SORBvfEy7Kzs2lzxPbvFVmDIBKzMYUNKwFXN8fx+LkEkSi+EoNzkS89h9FSPHExtUC491n4n9TRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XX5hNxqt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XX5hNxqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791573976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUDXEmkMZhRnOlkDVop7EVX0VJ9Yz8Pv2InL9R3FvMY=;
	b=XX5hNxqtGgQCq0RvNsP9oYl61KD5F03g4JmW0Kg+VVMOZy1VNFwKNSe6YqZwI/IP53aIVD
	HeWiFKRLgQVtcJytBUTGaJecQVDIISCFAjlARnR6pSeNBW17lo7Q/ZkO4UqAvB7eBDhuhB
	qRXb57Kkk2T6mv4kFM5jm1anBVKWSkU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-ctstl5wpP76jMomrqceWIw-1; Fri,
 9 Oct 2026 19:26:14 +0000
X-MC-Unique: ctstl5wpP76jMomrqceWIw-1
X-Mimecast-MFC-AGG-ID: ctstl5wpP76jMomrqceWIw_1791573973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4A7180A34C;
	Fri,  9 Oct 2026 19:26:12 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72C5218005B6;
	Fri,  9 Oct 2026 19:26:10 +0000 (UTC)
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
Subject: [PATCH net v4 4/5] dpll: zl3073x: reject inexact frequencies for N-divided outputs
Date: Fri,  9 Oct 2026 21:25:55 +0200
Message-ID: <20261009192556.272263-5-ivecera@redhat.com>
In-Reply-To: <20261009192556.272263-1-ivecera@redhat.com>
References: <20261009192556.272263-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For N-divided outputs the P-pin and N-pin share the output divisor and
the N-pin frequency is synth_freq / (div * esync_n_period). The frequency
set helper computed esync_n_period with a truncating division and only
rejected a zero result, so a frequency that does not divide evenly was
silently rounded. Setting the P-pin could then shift the N-pin frequency
too (e.g. 600 MHz synth, div=60, period=10 gives P=10 MHz, N=1 MHz;
setting P to 2.5 MHz moves N to 1.25 MHz). When setting the P-pin, the
product esync_n_period * div used for the rescale was computed in 32
bits and could wrap, so a wrong N divider was stored for low N-pin
frequencies.

Require esync_n_period >= 2 so the N-pin frequency stays below the P-pin
one, reject a P-pin frequency for which the esync_n_period keeping the
N-pin frequency does not fit into 32 bits, and check the division
remainder and reject the request if it is not exact.

Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 46 ++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 8bac680394d7..6d9a6d21d30b 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -972,6 +972,7 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_synth *synth;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
+	u64 n_period, rem;
 	u8 out_id;
 
 	guard(mutex)(&zldpll->lock);
@@ -1016,16 +1017,11 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	}
 
 	if (zl3073x_dpll_is_p_pin(pin)) {
-		/* We are going to change output frequency for P-pin but
-		 * if the requested frequency is less than current N-pin
-		 * frequency then indicate a failure as we are not able
-		 * to compute N-pin divisor to keep its frequency unchanged.
-		 *
-		 * Update divisor for N-pin to keep N-pin frequency.
+		/* Keep the N-pin frequency: the new P-pin frequency has to be
+		 * a multiple of it, at least twice as high.
 		 */
-		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
-		if (!out.esync_n_period)
-			return -EINVAL;
+		n_period = mul_u32_u32(out.esync_n_period, out.div);
+		n_period = div64_u64_rem(n_period, new_div, &rem);
 
 		/* Update the output divisor */
 		out.div = new_div;
@@ -1033,17 +1029,31 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		/* For 50/50 duty cycle the divisor is equal to width */
 		out.width = out.div;
 	} else {
-		/* We are going to change frequency of N-pin but if
-		 * the requested freq is greater or equal than freq of P-pin
-		 * in the output pair we cannot compute divisor for the N-pin.
-		 * In this case indicate a failure.
-		 *
-		 * Update divisor for N-pin
+		/* The N-pin frequency has to divide the P-pin frequency and
+		 * be at most half of it.
 		 */
-		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
-		if (!out.esync_n_period)
-			return -EINVAL;
+		n_period = frequency * out.div;
+		n_period = div64_u64_rem(synth_freq, n_period, &rem);
+	}
+	if (n_period < 2) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "OUT%uN freq must be at most half of OUT%uP freq",
+				   out_id, out_id);
+		return -EINVAL;
+	}
+	if (n_period > U32_MAX) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "OUT%uN freq is too low for OUT%uP freq",
+				   out_id, out_id);
+		return -EINVAL;
+	}
+	if (rem != 0) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "OUT%uN freq must divide OUT%uP freq",
+				   out_id, out_id);
+		return -EINVAL;
 	}
+	out.esync_n_period = n_period;
 
 	/* For 50/50 duty cycle the divisor is equal to width */
 	out.esync_n_width = out.esync_n_period;
-- 
2.56.0

