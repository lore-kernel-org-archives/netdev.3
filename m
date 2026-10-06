Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3849DBB4
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300692; cv=none; b=trjZ8A1uEf2DvVAFuEO4jCv1G8YOEhOji6G1Z6tIAyyFsf2QVC9EuMOtOZHr1WmVx5kWSvlArFtebfcjy4N5yrwQIn5fg6vkpVMEY9v4dt4M4H/kX2kU8n3Jagv3E5Ji0yO/vBC2VpNaaXa8nOUR9Yam5I20uvW9ZGXfDcbgUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300692; c=relaxed/simple;
	bh=eAOh1IoFN6+4dp3Ik63OJwIhNiWj37Mg8xyTW5OoZe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkcCRLt+oU+i2UkGufRu+Nd+2k+YQyAwk0u1caG8y+pIkHl2IrxdzvejqTz55pCEbKPE6SBDKDOGCeRWLhq9hAWpQu/wN/nX2L2P4MGbjqh1vWOTHA1CWHBjl7jZNrFrISvqK4DB/hdDLKccXdMHUfQkkSdJdi2IXN6+rVzg7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGAug4Y9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGAug4Y9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791300689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKCmPpuKg4Foc/IiRmeq22AiNjBgaFEIWUaosj61+Zc=;
	b=NGAug4Y9CvAz0oSe3FcOUgX8k0GHfH0ZXYg7pdXTlHdVrFULA5hv+2mJ9D61+WUc0pXXgH
	oNouhJqOH8KXhWNuY9EWKR5JeQiRGzSQBa1kVH2n7iXcUdLlB0zxME6ISgIKpjNvUH7QK+
	iC1cFARkOWMDHqA8plFAD0iJKttRqSQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-Zew6Rg4OM9GhNErQJbxDJA-1; Tue,
 06 Oct 2026 11:31:25 -0400
X-MC-Unique: Zew6Rg4OM9GhNErQJbxDJA-1
X-Mimecast-MFC-AGG-ID: Zew6Rg4OM9GhNErQJbxDJA_1791300684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED821865FF1;
	Tue,  6 Oct 2026 15:31:23 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45C701800592;
	Tue,  6 Oct 2026 15:31:21 +0000 (UTC)
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
Subject: [PATCH net v3 1/4] dpll: zl3073x: reject output frequencies with too small divisor
Date: Tue,  6 Oct 2026 17:31:13 +0200
Message-ID: <20261006153116.347497-2-ivecera@redhat.com>
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

The output divider has to be at least 2. In N-pin divide mode the
per-output divider must be 2 or more and the N-pin is divided once more
(also by 2 or more), so the N-pin needs an effective divisor of at least
4.

zl3073x_pin_check_freq() only checked that an output frequency divides the
synth frequency, so it accepted frequencies that would require a smaller
divisor. Reject them: require a divisor of at least 2 for normal outputs
and the P-pin of N-divided outputs, and 4 for the N-pin. Also reject a
zero frequency, which would otherwise divide by zero.

Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..a4bdc3878590 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -22,7 +22,8 @@
  * The function checks the given frequency is valid for the device. For input
  * pins it checks that the frequency can be factorized using supported base
  * frequencies. For output pins it checks that the frequency divides connected
- * synth frequency without remainder.
+ * synth frequency without remainder and that the resulting divisor is within
+ * the range supported by the hardware.
  *
  * Return: true if the frequency is valid, false if not.
  */
@@ -30,7 +31,7 @@ static bool
 zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
 		       u8 id, u64 freq)
 {
-	if (freq > U32_MAX)
+	if (!freq || freq > U32_MAX)
 		goto err_inv_freq;
 
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
@@ -41,18 +42,32 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
 		if (rc)
 			goto err_inv_freq;
 	} else {
-		u32 synth_freq;
-		u8 out, synth;
+		const struct zl3073x_out *out;
+		u32 synth_freq, div, min_div, rem;
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
+		/* The output divisor has to be at least 2. For the N-pin of an
+		 * N-divided output the effective divisor also includes the N
+		 * divider (>= 2), so the minimum is 4.
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
2.55.0

