Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112C2E7375;
	Thu, 17 Sep 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677953; cv=none; b=KDccr3Um9Y2/mXqckkofakWM24iqipfM12NNhroIUyF5Amuz1pkZe2cXSzym+zpnx+8pj9HeEVp5Di6IbxgiyAuO0shdPU9eADlRv3aDKh3Y3UKm5nUxoQ/oE61gh8N3tM5Dvmkzgxkq+oPY/8VAKwryzsxA2vP8dTJFG9sxMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677953; c=relaxed/simple;
	bh=BEK8Ojge3HpQp+cSaYN3l45bIgW26xVVmokqy2TfbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeKqi8T7Z4JnmnZXEcjKtvrdfu+JgyLmm0TzeDJ0r8Cpx9RsLOVAKhqiaT/DoBZr6VxPXTDbx6vRv/UH89CyZjJuE2hfarBmNz8keYEal0D6bW14Ufx01j16nda/M5jGVlRnn5GSu7INkVydqKCSy78mW0W4X2/p7pFeheewphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGC1A87g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGC1A87g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677951; x=1821213951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEK8Ojge3HpQp+cSaYN3l45bIgW26xVVmokqy2TfbyM=;
  b=KGC1A87gKBYI5chbFRjIsJuygHErXYhKNtxsKygqyquLMXr+1bIBVr+q
   Dn1HlKuwqEzXEyP/25bvMBNLwfF/eE8W0o8sVupgsGHuzHO4azR8LnLXw
   skwJX8A7SfsZHq+04XdxQ1J07npROvcf0P2/S/ur/1olRZeqvPtUWWRHE
   KfkTA/GzfYgxndNYjmMnSkk/jvLNVgpUCVR1kXUDBJSfYF7pbEhz9hlRD
   A204P7ozoPlPuGvbiAXXH/m2KKzLNN9q6FC2kSBjKcQA95OrUL9ydCM3v
   9wgdCd7kzf7o9stDKLZEIhMBKOVof2ZWq36+UDMv5u74Vfbr1Lad5YM8L
   g==;
X-CSE-ConnectionGUID: dCwGsBvATyKdJwuv5G6FVA==
X-CSE-MsgGUID: sLwk513gS5OPgxycrnfgVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100739290"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100739290"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:45:49 -0700
X-CSE-ConnectionGUID: cc3P8GvtSqGq6i0q0UjCAg==
X-CSE-MsgGUID: 0UkJuVPQRvaIzO46WEOtVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297502059"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 13:45:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 1/3] i40e: move ATR sample rate from ring to PF level
Date: Thu, 17 Sep 2026 13:45:38 -0700
Message-ID: <20260917204541.3072415-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
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

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 3 +--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1b6a8fbaa648..88eb40ee45f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -487,6 +487,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae..0a4272e1ab07 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3458,12 +3458,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
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
@@ -12740,6 +12735,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7f68adb5109b..e045f9c71c94 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2871,6 +2871,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u32 sample_rate;
 	int l4_proto;
 	u16 i;
 
@@ -2882,7 +2883,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	sample_rate = READ_ONCE(pf->atr_sample_rate);
+	if (!sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2934,7 +2936,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
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
2.47.1

