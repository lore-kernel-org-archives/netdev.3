Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E641439327
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465541; cv=none; b=prl2YPxdbg/ys7aaovdef3MLKzQ7ieizA0SDkiIfRuj1JOMNPqmVoNcGwK8rQoRATVemirwegRDF20YQn8dgtzkFeYvGz5xpQTh2TXHGTwdWjAofpo56vn/57fopjUGlYzmZq7UrBreo/tQUGaJWzVHOm2VBydL+D7BqYsheXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465541; c=relaxed/simple;
	bh=Lt7hcozxwbSroeAZ0DevtwN0d5XjaXXFkpsuvOS5ZLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwn2gAryOz7qbuYVTxTOtoP6j2NjpHgNBMOBvc7ne3NkXtpez18LQGoTlFpZh8e+zEkxnvYWFm4Q4+sfhF6ixlW2Ckg1L3yFSEljzQH3x6npwwFICV4jju65H+1ttwSSmwJsM6WrLTTF9/UC9PuYUQkeWVbn8RZaEQEJerhhfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INkOm+QI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqtRVZBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INkOm+QI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqtRVZBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791465538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
	b=INkOm+QIwNKq7HKUOkkrEeuwr3r7S0w4ISdFrnZPA5/aIGIHzvvVozMjk64tnyNX1L5rhO
	1dHW0BlOYXWkP0j7sEuKxY0sUpggsI40OLAtekV+v5vYRIKtwq7QX5JH8r22JOaLzi9YMB
	b3SfqlzptsJPki2A38PUtKSKTrKBBkg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-P0pCdvL-Pu2kAQzIASFAPw-1; Thu, 08 Oct 2026 09:18:57 -0400
X-MC-Unique: P0pCdvL-Pu2kAQzIASFAPw-1
X-Mimecast-MFC-AGG-ID: P0pCdvL-Pu2kAQzIASFAPw_1791465536
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a019d53f46so42579335e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791465536; x=1792070336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
        b=YqtRVZBRKD5R03niQzo86uOVOIiVJplcySj5ffJRNIfuWI4i/NtjpC0CXRmX8WVjKd
         8a46tzGgEoDQQ7KQmzO8ku76aFrnWSLoZIkXxFr8Nu8cNIJSShQ14gz0nZRjR+CjYqdm
         7Q7Fv8do5AgOOJj7gzfmzJlko8MAnxpQbnSfJ8CxxskC5RpKRjP9pIHACRT7z8XUSw3/
         /xp84/MRcvUHPBkhmeYd1V46a4HcGTEzEYVfksOcn46mEn7T2a0InYleBMDJawJE7k7u
         G4WZpep9c8fZeeeQgw2LA38dT91srjhYBHOPLDkx8F9tHCfS54ag3FEWzsVs0dvXbNIU
         dSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465536; x=1792070336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
        b=cMzoocNdw7N+xbY+l4/cfw2dK2YbvBGX+kajUV5t2K3J/27Oiq61tgxabLDk3YLP6e
         QS5sD1+wzJmSgp4+nNibc36n/eTTwg2x2R8toBFJNDTllfNDwMMIHvJsVIevXZh7Uc+t
         c3ADcmVU28OW4ZHB0m4qUMVZA9pEkGoR2jH/uHmIatpTVvK749zJ7blL3uwriqYZBRtG
         Ol6l5e22I577ACXAD+KfGZNs6x7PyFdW29ECi0DPpGnPgrRw7MYfLG9U+nf6LdYrDSBq
         3llnBmls5Su9tfVfLKOppnsHkzTR/GBcnoHYGBaVX4lrHiGfcy+tgdwCmzcXf8rNqPjr
         BYhA==
X-Gm-Message-State: AFuF++k6jt6Th17oSz9XePlWIrJpgUlGfp1CMcZAxaGD8B6f07jrwtSe
	OB0GY1eaCevYN3b742xCzGV3MJQwz+JPirJ932EeyXevRFLc5OUk73ywrFe2o3Ag6Rdow2Xp2Wo
	DpEXa++eyOkHBzf0hqFRzWG0GhSTMD3DV//y9PCw95PQ+UvEKVlZQJTE75g==
X-Gm-Gg: AYBFou21dQLZWJEwQ8cZNACwqmvesua4p3pICx8H0c0IO4o+J8gpAkj8ueV5vhViKgO
	z5AU4QYWGp4WsAEcICxavuXtA8bB9nQ5A8oQUY/LcMaW2agi3LXHL9LismOAcCI4wg6c2neA9qI
	8C2/TQRbIomIb8nFA5ysHLcaw9U7VkU9RLAxlZXZa38IixbViPL0/94raIfEXDo2RkEwEhqRp65
	oTDaV2mnoBXc833dAaEMFktwUjoX07ATugP65BUqLLYZenZ0RYp70Eg+OLriucuag0/whOaMeGz
	QhfwU2xC0A6fGg1mwbF0EnIyiIDA8OulPjZpRAV+/KzvPRhM/inAZp0oiIgd5XnUYctMpLbjc9D
	3QNK+Mpjg7JAIboTN7b7fWF/IIOkPhOsm
X-Received: by 2002:a05:600c:c4a6:b0:4a1:7856:f4b0 with SMTP id 5b1f17b1804b1-4a180671a42mr99650415e9.30.1791465535580;
        Thu, 08 Oct 2026 06:18:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a6:b0:4a1:7856:f4b0 with SMTP id 5b1f17b1804b1-4a180671a42mr99649895e9.30.1791465535142;
        Thu, 08 Oct 2026 06:18:55 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:18:54 -0700 (PDT)
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
Subject: [PATCH iwl-next v5 1/2] i40e: move ATR sample rate from ring to PF level
Date: Thu,  8 Oct 2026 16:18:23 +0300
Message-ID: <20261008131824.248508-2-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008131824.248508-1-mheib@redhat.com>
References: <20261008131824.248508-1-mheib@redhat.com>
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
index 0ae50d7f3465..9b1ecb2c4edc 100644
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
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
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
index 109ba6b20f8e..d83116596eda 100644
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
@@ -12754,6 +12749,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
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

