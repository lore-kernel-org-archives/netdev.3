Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BD4DAFA6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407200; cv=none; b=FsIRzN036JTfP7WiXCwZAQ6h3QhtQ+xxkF2Cst4izDfewykAYqHL7uviTi7pdhHxsJYmbG7nafCJJVkUnM0hqC2gy375BzufICjxT4bqwjqdkA3CZ5wt9EHa0pZDOPqzaJVjCfpTcscADR9rXSGydbsLI6e4ohSDi1RW0X8nrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407200; c=relaxed/simple;
	bh=v3XAnC7a1Q89kbxj+7kktc5NUx9EHyzUV0eefrDbZ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEdz8SEjR/JWvpSj8PKLHfRINqV/FjWnNQcWhT/M8mOEH83XVGS+AgkpzfmHr61w9R2c7YI1uqAHsHm/VVyeuSQoxS/QII+pI/0/SrGa4Weccu+JjVO9qC1kTeyGYP6CQDpyfT3dZfyU94o06vryxoN5xp00FiihPOzkaUq408g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QkqkkEL8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QkqkkEL8"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D0183F471
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792407194;
	bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=QkqkkEL8hbAJJUJshQykmTz+O3PFA7ITI0lgcL3ZvOYNA9h++Bz+zEhlJCF+OHIyK
	 Gyzf8J1RGAwA6+SG8FgyHAUUexv2GsGuqvudZe2TemiRloiUddoX1d2dW5MEXaliKt
	 rb3PF8TG4TRVbfq61CTo4HhwVthtc72hi+pEtuiSCfGc7evfdm6mS4fYS1KbHCObbo
	 lDs2Ouek9RWtofOP9O4fbdTlZ+Q+DfTPSYS6hOhzBHfznWxs1pMXzbaFUp8xaR8LES
	 WFdLTVE2/7mE7eCHloIS/2zbND6+mWDk6NClN1RiS3BEXNuR7qQlPaWZDBLzPikhWZ
	 FSnJm2eLPViMA08nVpEfPu+4CqAOFhE5PUGOw0GkJNI5C449veNK9T8Om+6F3xCcuv
	 QGpEtKZ2QGRP3kVEVhHCwYkhRhIQNa0DDmKLFhL3YjTxHZvgR1+2UJ2W2OITi5kuWq
	 YIv4TMhujH5ZYLxe/rQ5hAQNFARGoVhy9hXsXWSLYH7NIQoPBLH4kX3ZfkxdFEIpPH
	 DRTJ/mvN9LU+XuBjygw4hd3j/iM2pJ2RRwzt7ybCtFQ1j8sA0aZMTh+9H1dHPo8vC2
	 QFCtEqJ+352ThVN14ww34KfneJUeJe+SMDsBoxEPf6+hPoLp45GH5QEyisWWSJs/80
	 ZzLVgCMvASvAfYJJdJYFu68k=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so16246045e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407193; x=1793011993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuW6cWkx9xiT5Oe5IZ1pUwdt55ZzaLd8Up2l6rgVZqw=;
        b=LPIFqINZSVWWyrvbdEHEM6B1KzxMvIbK1Gy02pxbB8JnV/osa+bpyKmCLSyWkv6TjT
         SPYDLvQuihZhf7EiJX627JELN+mTLj/XCCyKj1d0zn5A9p2HRamXCDIovr2vlhZ1u1wS
         dJ6ugiaV1XRy1omt8sb2TD4JwwV20v/CZ+SVE+riWzWIL61H4dMzg7OCoAC1qctnI/zZ
         JIHy18tQ2Ixq35xIRRe/Lm+FLygIeSdWCzveT1h6swB7xJbGBg1W4rJJdDVhUZJv8ynH
         9mMR+o3MSl3eOOCPTK6MHP1cq0qFvJ1caSdMEBQg+XVkQg0bD/z82XNJGfXviPTYeWns
         c+/A==
X-Forwarded-Encrypted: i=1; AKwUvBwneO/MqGJw4nzwN2nfUd9duGzhGMCdkKw/TSsKrqCfLFKJb3qEr0lYqra3xZEkT9OGn6n2H/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1la9PO+yxocGqltcVo4RSggMIP5mGOHUwvbLJAhkpbAKA4iIs
	FHXqk2r+lU83kXI3867ptNSIh9CU7KzAWE5rY8KDCkPB0v9ko2gQ1zMf53iptrejjBRLH4ILnGH
	LcHb9BIUvjzStIwFN6p6xpjKfIIyhiQ6LQlp3bWOxYT3YgkebnVTtlMetgwJW/SKvKdcG/BgzxA
	==
X-Gm-Gg: AYBFou3N0VP5aswzJ0Wcx0LMwNefFNOSqIkCrbAgwFQGPIAlu43LOA5bsPja9oYQkoE
	YwHQz8O58VWCtVmwgJ5QVjAkACJWMbX9hRpLUDw6ISSvw35LTd7326XYDqBoyH2nKM1GdSH2SPq
	NcuzAp17XCEMAUa3/zAv9cbRfDPlkJbpkEWkTfiLZuzm17LcPePw4E/wezlYi9P/+sc7LphFycE
	CVq4PM3doWE0NRrJ7P32DH9A5wbVYlZakAb02a9qgoIgqmmhwIYaZujMCIA1Jsyrdqjp8kvWa1f
	OSVULFXLTSmUjfFMMvbG3fCQIXmRyFDt6h7uZerEEJ2W5LQSshNkEqXhDmutfJhEV9QRCyRhrX+
	MqUPJb9cg7W5viJekfpac9AZO4LBTHFP1qyPwlX9ikoEsH8pyP9crdux/HHdJdIb2B/HKkgxJFn
	l/chGksGZ3rGpbv96C6b1lJOsZSUMeWFlSydIYArfxGH1yKR+9bgFcLQg2KWcjze+8LNI1ENMmZ
	mK2hkdg6eCajcVlS9vrSK2ahh7Z69N/CqHrwoZm
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a1d7616bfdmr147460675e9.29.1792407193689;
        Mon, 19 Oct 2026 03:53:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5250:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a1d7616bfdmr147460255e9.29.1792407193245;
        Mon, 19 Oct 2026 03:53:13 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([103.155.100.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm23238930f8f.55.2026.10.19.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:53:12 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	Brett Creeley <brett.creeley@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: [PATCH 5/5] ice: quiesce PTP periodic work before system suspend
Date: Mon, 19 Oct 2026 18:51:55 +0800
Message-ID: <20261019105155.3793063-6-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019105155.3793063-1-aaron.ma@canonical.com>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_suspend() stops the main service task but leaves PTP work active.
The PTP kworker is not freezable, so it can continue issuing MMIO
accesses after the PCI function has entered D3hot. Both the periodic
work updating the cached PHC time and the E822 offset calibration work,
which reschedules itself while calibration is pending, are affected.

Synchronously cancel both works when PTP is ready, after disabling the
VSIs and before shutting down the control queues.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Fixes: a69f1cb62aec ("ice: exit bypass mode once hardware finishes timestamp calibration")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ddebb28b2454f..3962910759067 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5450,6 +5450,12 @@ static void ice_prepare_for_shutdown(struct ice_pf *pf)
 	/* disable the VSIs and their queues that are not already DOWN */
 	ice_pf_dis_all_vsi(pf, false);
 
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
+	    pf->ptp.state == ICE_PTP_READY) {
+		kthread_cancel_delayed_work_sync(&pf->ptp.work);
+		kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
+	}
+
 	ice_for_each_vsi(pf, v)
 		if (pf->vsi[v])
 			pf->vsi[v]->vsi_num = 0;
-- 
2.53.0

