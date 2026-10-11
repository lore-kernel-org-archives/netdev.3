Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B9455625
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726627; cv=none; b=hEIueqLC1OPjxMxAANtmE0nL0YbqW8AWQoXdrgn+ceNw7TZcNskL75B7IwFT+UbHCHn8/g+R15EDO6kdK4YDgC1M/JYrI22MHFarUVuY4eGv6ncnPZwFYbtdtrHZA4J6mxS+ZIDvXAXE2yRazlqGYj0Vk6oUQAabwPk91qpoB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726627; c=relaxed/simple;
	bh=TMR3Z54dI+6+R9DKnXCwvPxQFG2a3g0ZlzpzPm9QYXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfUCwDVMSp4rGw6976KgjrTHxDCL7ybpYQQ3vA7B/TJw07K52KMJW6PFFNl+BnpeNXVnPczBsrZ7m4DPCmcWI8rxCOhOgIpCHXvrAf/4CbHKlVuxQFzEOsTGPZPwafJMsCOgW+XM+Aye1VQI+1L01kdVdCnP5jH8ySC1fsIdTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pgn62Nb1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9I38Cq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pgn62Nb1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9I38Cq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791726624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
	b=Pgn62Nb1undyt86+c1ZpxmzA6eLMr9z/EAW/Aw6VyqAS3HlAzetbKPdJudFaW73+6Cylvp
	3R10PTQhuyobRmmpTwlXPSKr7wHbMA6E55SmCl4AIaSvSA0xRI9G2Qkw830MCOp0RtHia/
	Tju3Xk23c+NUfz9t0lCv7AOIQu2SZ2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462--ODAS8BKOpCZPZ20x69p3w-1; Sun, 11 Oct 2026 13:50:20 +0000
X-MC-Unique: -ODAS8BKOpCZPZ20x69p3w-1
X-Mimecast-MFC-AGG-ID: -ODAS8BKOpCZPZ20x69p3w_1791726616
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a165fb7beeso10679885e9.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791726616; x=1792331416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
        b=I9I38Cq85x49NKkVNIt/+0fiWRzZvZYmFWNaqJ8Agh1ZMIRIzqyqGmmBxOuWblnCQo
         a+8kTGCTaYlTRMvLCjxWyMa6UxaQYcxGvTOEz3vPtAfSC/bS/2vZGopAioLIqC1XIekK
         f3lUSk5Qi7oKF7Q/VjTHQQD63Xn1WGqM50wgn9GxC3nW7/FtSyv0TWMnPT+QjZBKFHds
         LSgYVSVBpWbj1N3WpRZB9+CWKjFE6RDrFSnLDSKD2QMkDppBLoY7uFAFQ+QOzhz9sQ+u
         WElWJ45ODdMpmlzMwHUsF1dZQKWiEagZWn4X8LeDbr8y6PDDpFYqfmLtevUUVgvZDPmG
         VtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791726616; x=1792331416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
        b=iENv5+JYKpAqZtIr4tRQaMgtsrZXveep/VaYfHNHmtoROBegCqwSouWdzZronj1HO7
         to9HBN+cBelm97OMkTAtb+SUJjSsqLyJsgQ2j7XZXabMCsD9WQ23PqE7YuGOxzXqJ6Yo
         t0bYo4xlRuyULbRKX68ZlHud9NEeYrIMTGoDd8QT5qQwWU2AL4wU5jd35oLIixAnNKRS
         50nEgKl5LPD2x8yctKjNR/wgY/j1x5lPh1u043jCdeHvnAUTZ6G3Tn2ao2Xjh9kC6zZQ
         mJty7GVENDaxAba3pXF5G8g84+wgO/LHhVHFSBUBJv66BybcYlBis8acU6dJNHBuBG42
         dq7Q==
X-Gm-Message-State: AFq9FYId8v6uyQFZTYfQ0WAeRj7fB4cnjE31Y4QSEibkzzdAitMFknBu
	8kOlRjl0g+S0u+pJBcZZNlRDIoGKwXXbs29LI8GC5FUDaTvUlh5OcPi6NtyNo20ZHbCAjWJlf7/
	1SwV/ktJO/X9V94Lz1AhZTHSqVvmDyq9K5eK1ZSxirk7bu9BYxXLkv+qEGQ==
X-Gm-Gg: AYBFou2QPfbn+lPEiyasNSZHEW0nOypSh6HQvVAQr6wFKrKj9RqC4709sAYrXyZG3S4
	7iXYYAHKHbzszV1WirtGgr6f46e5ICpmAOqcW+FCv0FtrTYB/EM/aM2ARPN15ar2GlVvXwU/nqp
	lz+Tk3OM1YKB3y1Ks9ALmxNknNiBBhm/aWZtKJ/8ZsIYInYPu6Qt1rQbKHE62tOT6KS/2xrVykW
	Der9BJHkgTbbdoHvZXtVfxS35DjLwwhzrnHX02NmZixOjtVjLflsifXOJO/CQAy1UwKGGoXRMV6
	5jiqSzDG1OG5NDvqIaalv8ygLJMtzUBn9OuZ2hgi9EHXTS1Vyy1hrVS2ctcc4Gj0Mfxk5n8zj55
	yP2j+h4Ej+gwtdP16hA7SV+jk4p12CSUk
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18e48d45cmr139042725e9.16.1791726615981;
        Sun, 11 Oct 2026 06:50:15 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18e48d45cmr139042465e9.16.1791726615631;
        Sun, 11 Oct 2026 06:50:15 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:50:15 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v6 1/2] i40e: move ATR sample rate from ring to PF level
Date: Sun, 11 Oct 2026 16:49:51 +0300
Message-ID: <20261011134952.54887-2-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011134952.54887-1-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The ATR sample rate is currently stored per-ring and initialized when each
TX ring is configured. Since the sample rate is a global policy that
applies uniformly across all rings, it makes more sense to store it at
the PF level.

Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initialize
it once during i40e_sw_init(). Update i40e_atr() to reference the PF-level
field. Change atr_count from u8 to u32 to match the sample rate type.

This also changes a user-visible behavior: previously, re-enabling ATR via
"ethtool --set-priv-flags ethX flow-director-atr on" did not resume
sampling until an ifdown/ifup or PF reset, because the per-ring sample
rate was latched at ring configuration time. With the PF-level rate always
initialized, the flag takes effect immediately.

Trigger a PF reset when re-enabling ATR so that fd_ena is re-evaluated
in the TX queue HW context.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +--
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a9d79bbd3ea7..528ef329a647 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -486,6 +486,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0ae50d7f3465..bc9b4a2bc23b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5300,6 +5300,16 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
+	 * TX queue HW context. Skip when FD_SB (ntuple) is already
+	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
+	 * either FD flag is active.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
+	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
+		reset_needed |= BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
@@ -5431,7 +5441,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 				case LIBIE_AQ_RC_EEXIST:
 					dev_warn(&pf->pdev->dev,
 						 "FW LLDP agent is already running\n");
-					reset_needed = 0;
+					reset_needed &= ~I40E_PF_RESET_AND_REBUILD_FLAG;
 					break;
 				case LIBIE_AQ_RC_EPERM:
 					dev_warn(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 774bfc595aa9..98d2fcdcee68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3459,12 +3459,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		ring->atr_count = 0;
-	} else {
-		ring->atr_sample_rate = 0;
-	}
+	ring->atr_count = 0;
 
 	/* configure XPS */
 	i40e_config_xps_tx_ring(ring);
@@ -12750,6 +12745,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2032465c9b7c..acb47a9fd86f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2887,6 +2887,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u32 sample_rate;
 	int l4_proto;
 	u16 i;
 
@@ -2898,7 +2899,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	sample_rate = READ_ONCE(pf->atr_sample_rate);
+	if (!sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2950,7 +2952,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!th->fin &&
 	    !th->syn &&
 	    !th->rst &&
-	    (tx_ring->atr_count < tx_ring->atr_sample_rate))
+	    (tx_ring->atr_count < sample_rate))
 		return;
 
 	tx_ring->atr_count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..be587f804e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,7 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.56.0

