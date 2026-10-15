Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0A3F410D
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107230; cv=none; b=m9Ia3wcMaiebb18bEZzw+yOYCP1hAf8KkN4PepaFWozEAWgO6bYn8Ydd9J4hzhlo2MyR7KQPgtZcdu/qm/Dbd6YO3mM1JT1m15wIg6TfOTpZ9U0UDPwXphLiIrj0Ve1CQvjnMDX1GmcTRnPgBkqdvQldIXLE10ag4kC8IpfT4T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107230; c=relaxed/simple;
	bh=BSZQsz4AaktraRMPo+kte0Fmcp27FfRs07kAnpmG6i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=It6mDIQsuGIgmIRn56WsoIJ29SdsObAelp48D6DllU/7nBoE3+t7vw+yTMVy+h031U3LAXf/UqgunBN34JgcYJrOWmeV7W8UNUrqusDcxswPv6YE2UfT8/zu+d+7ZAFjeZBSiP0sLCVYB1oCLQuSL9tunaCSaVshS6XIPLIbvRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLrDUoUW; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLrDUoUW"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6f8a519e215so480200eaf.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107226; x=1792712026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FV6Q2SmXqF6b78Av68WgjEHjZ+64cqPVR4bTm+D2U4=;
        b=KLrDUoUW5UT88MtsY54o7EK8IOXjZdJzjSN3Homu0icuHQkEZkepFPcG++9YNAYd3E
         j89y2OU8i74DE+SEVCSUxtOJS/VDHAHw0buG30mUS/MuydKr47LZ7rSoIKH+NelwOxOH
         vzw4UH+RKmpdzMdHJ35aOkYnCfJg8KvCqbZ2zhq2G7X3zfxGAJsy0l36XEipM5Wao8d0
         +UlQjaAlRxmr5s6duDEoDPhdTB++3J9mvNIkwOYiN+AiJdL65nK34eeR8v4yMbPtoqQW
         w9kpMXRQYQSIjZgt1+10KIlQP459WU7S/qc+6zNL3hmMdG9paofiW5uwIOJXDmzP+d4w
         9gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107226; x=1792712026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FV6Q2SmXqF6b78Av68WgjEHjZ+64cqPVR4bTm+D2U4=;
        b=YuqL2DKseysu6HzYWCqyS3x6/VfObDA9whEu+ef6wQZWmJe92Lzw55TWxYiz67X+Jl
         O6GKu5NRMhrPFLFjmf8QjYC1vv1/b+WgH5ols0pg5sflzZLcaNdF9dkdwIoK18sLsMOE
         tLvDQv1g6lyfpRv1gHPPmRN+vCzs8FRxJKALma3c4hlY1Qk1VSOSE4UG1v7hg+PzMiFv
         J7EPV/3k8IZq+veEK1tE9WLLATvP7N5VDdYlzHuRX8aWlRQ0ZtIQ/jzQxJoPVsXh1X8g
         QHBjCTDJyc6x3ZX2WyFq3PRN4/VrNWj+kpjzf7RQdkG/r2MrE4OsB6Bpe9XozKLVzx5l
         MY8g==
X-Gm-Message-State: AFq9FYIGIQs8829OKjvFi9q7W4d4SyrZzerE7UcFzMlVxLUdDbV2PFHS
	uH79gIIAEyUjp2cXtWSgb+cqPL/vWWYPpxRaY0u1oN0wWuVsh8++FhLh
X-Gm-Gg: AYBFou0FCJ/6LZDtqZJmQvujadTqLxh7NMizAmD7D4MxfQzeCwbqpcus7p+liPyt1dQ
	hHr63IcDRwGUkPXZPLoqhz5yPnXvDc2e+/f+cK1U2XU+xRDl6HXBsOhbk+ZHaqMPdlDdilFtDpJ
	hajg19u10i4DOSqOsve+Uw35B7GyulPWob/jXq1XkU7FQGe5gkW5C0/K+MULxoA3dtvNgRxRvRL
	hUiS45plC2KWxr6bT/CsZ2XevyUOfstH3ND4/eYDe9Ne+vHXoHr9LL1kfNIxPoZjaJZ0A8TtvXW
	uF/vhZSvR5CjZe6I1E/jtUl+nrKustEQCMJ9DW7g0F0S4IReItQZJsx+ZahrXTCwvHM73f0wqw9
	iRqVTAsomp9wmqiwpaEf5a6OK6Px1uAOoiJDSPdxWAhfMrm9CmuSjJMVHIFRXqJO2i7xgOCfxA8
	9sN269FPF3RouXgY2Fn98Sl9IHnLneXRAMvJhk2yLHO2Gc6BHwvQAyPi91emZ5Mp2vcA93Z84BH
	VYkN8sM3ODZLQxdp5hdKMbnim7LhTQlfx2VSg3jO9Y/0T3jaFSutP55j8OBpSq3VZfrnvLA/jOM
	aeu8644g3NbiLukZUVqoMDCfx/7cHGMMB/CvPxyGUmtFSPyD2YrHLWGtIANcozJehh3v5fvnuOh
	JmEU5FNmrq95BDwmOsuiq8Q==
X-Received: by 2002:a05:6820:83ce:10b0:6f7:9fc6:88dc with SMTP id 006d021491bc7-7010c368679mr753319eaf.1.1792107226429;
        Thu, 15 Oct 2026 16:33:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 17:33:35 -0600
Subject: [PATCH net v4 5/5] ptp: vclock: preserve missing hardware
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ptp-vclock-sampling-v4-5-cba6ffc8ceb6@gmail.com>
References: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
In-Reply-To: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Socket timestamp delivery converts hardware timestamps to a bound
virtual clock before checking whether a hardware timestamp is present.
A zero timestamp means that the packet has no hardware timestamp, but
timecounter_cyc2time() can turn that zero into a nonzero virtual time.
The socket then reports a hardware timestamp which was never supplied.

Return zero without conversion when the input timestamp is absent.
This also covers skb_get_tx_timestamp(), which checks for an absent
timestamp after the same conversion.

This was identified during review of virtual clock sampling changes.

Fixes: d7c088265588 ("net: socket: support hardware timestamp conversion to PHC bound")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/ptp/ptp_vclock.c         | 2 ++
 include/linux/ptp_clock_kernel.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 88161be5eabc..39c3276ded77 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -312,6 +312,8 @@ ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index)
 	u64 ns;
 
 	ns = ktime_to_ns(*hwtstamp);
+	if (!ns)
+		return 0;
 
 	srcu_idx = srcu_read_lock(&vclock_srcu);
 
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 36a27a910595..56f6ab1855d3 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -496,7 +496,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
  * @hwtstamp:     timestamp
  * @vclock_index: phc index of ptp vclock.
  *
- * Returns: converted timestamp, or 0 on error.
+ * Returns: converted timestamp, or 0 if @hwtstamp is zero or on error.
  */
 ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index);
 #else

-- 
2.53.0

