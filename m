Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7841A93A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815550; cv=none; b=FnVSuOWv6IbYlStRZybaVzeSZJPUcnrWrTKkdGEBW9d5ZrX5l9FWOm0Q7MaA2Aitma7xWF0DU1fQQ7HMkjup+QUCGkFXI6NJDlQLK9UnmoKQmBa5syj7yCt9s2PBYoD7idhnWyGnZaUqDchD8hNkTnDqJivp6Pqzr7ItRdJlabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815550; c=relaxed/simple;
	bh=RQBKtPTBtX8ge1PNpwy60O/45C6MQ0xqp9gO/yr1nps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTrOIe46GdFyvmKyNZ1+DqqkmtDvwNrJpplt5zXCUTpXq842TzUP+dlLdP1OFjze5RIlfGbLRBdTS1a/Ze2uFREU+lunoMYmB2lip+1NP1NTRXGoOvhrsH+mPS/r7nlBVK0UrvXurrNtkNcqzaJ9wKRlAnzhecp9LxQmxRgNXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyOlfuO1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuvCYlc9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyOlfuO1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuvCYlc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
	b=QyOlfuO1b9vVTXDbBT8dGiSatlDofp4J1ClJEMGbj3fC4WH8DX8ytzBkA1B/NrDA6VHoDz
	KCixIrOChJuhLehz3v7X9cQSHTL/UkP5dRw4IjQWF/sWLmruidkUufwECZ5jqWv2Qqp2nE
	p0Wd9rbOZscIxPWi+ngVNkGIbC4Wljw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-meAPwCWVN9uoeLMeE-cKig-1; Thu, 23 Jul 2026 10:05:45 -0400
X-MC-Unique: meAPwCWVN9uoeLMeE-cKig-1
X-Mimecast-MFC-AGG-ID: meAPwCWVN9uoeLMeE-cKig_1784815544
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49553d98911so4153375e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815544; x=1785420344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
        b=EuvCYlc9kdgvGSokjec4chCj8pEn3KrPEAeWb+vz0gdKCHDhrgmvWraWeZoLPnOdmR
         Eia/GrUUeoTb+m67jkLIL2Otclr2p/lpXe1ua3fsX6OzK0+LJ97K0PAh3xGN0qh/jQl2
         +SJ+tnKDs+8gg8fMnGRy6Ix4EZ9vhSQpYt2ilXjCWJyxD3m6wBcVcBlS7JahS9qclKIf
         pInraB032o8tzHYi+7GxnUUMBDxsuXG2ImIrKTQORzho71OzuoafaE7k2601DPgazEXC
         oreaGJ5r9mMhKskuJWjqhiNkEwFAqxmnXp1g3QyM8WVN/3y4CBAHl5otsIn4OqDfTdcj
         Hw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815544; x=1785420344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I880Ca0KXpdJ71lyMD7Z6ZxjAEzuDwA1b+elqzVFveY=;
        b=dSwHFKKLGOQWC33qh3lmTPnDZR4mOlxX9IhvAUKq/hLUzS0OxhprakyOw7pnjh4Aco
         NhJ2DhcrIXAJDrZtQMo5x3hTGzk1s+caxMn0suFK97jMLgbPvnTe4AYOEpin4dDmoFiC
         GCkhx/lBDT2FujoxIaQpVp30Yk/YECHqwoqLUJM/C2s/+kgp3kFJ6n9lHff7brAglpQX
         7P5ahxNWlbmxdogf9q31bjbEzsUkLNmmWjHHG6OQiJZK4HhZ2IMx7GG2q6jD2d17V9lN
         JeG6e0GjGi8V7ZLxtD9pHnq3w7//KhdJwLxc+lQX4s04TPYoIGkpDp+IjqANO8ESOChv
         +DXw==
X-Gm-Message-State: AOJu0YztBsw/PppbPjqvdSt3EBG3f6QWOBChaTrLV5acsygiDkfkVJE6
	zF9T+JSZTEbYtoqBqITebW+/OrhKThD/LnM/SY/+WwLK+6eF5Avs9ouFGtk1Ph6omLEUjj2LwUp
	HVS0A6ac0MxLrcZhZPHDxE9HtHoA3nOA03QwVweJE1LPlXvEiWF09+Q5MqQ==
X-Gm-Gg: AR+sD11cbc//bqoMfaYZJiphs3pAFwLuYNVsPGSZ+SBUv0NzQagrQKwAex0z5HpjCXL
	HsAvwUtKyevVNgcwRHGxkSCeO+Zr/aBr20/HteRPBe4xlF2H2FZxRO+9DKXB78GBOjdOddWlb6d
	myCZA2nz9NhZquNCD0KYxNrvZYKjq15LBS/YJ/qSYM/hb0wWnk7kP3/WHEbTsyV1OXliXd0c9lH
	HqoXVbGeKg6S0iIHogLP/BwYBhgRCFmJh8j8WYx8JkFRCHakqaUQJuWMpicNNNYyNxJdQQhKo+C
	OCKGqCzCIvWRsX120+2wKttbErspWCcqklZsh8G/H9Ziq0LKS4FIE7LjZS2M1ei6YXx693k0tL2
	Wi+rZfRBTfZUXog==
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id 5b1f17b1804b1-495745ac487mr31796975e9.17.1784815543713;
        Thu, 23 Jul 2026 07:05:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id 5b1f17b1804b1-495745ac487mr31796565e9.17.1784815543225;
        Thu, 23 Jul 2026 07:05:43 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:42 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v4 1/3] i40e: move ATR sample rate from ring to PF level
Date: Thu, 23 Jul 2026 17:04:15 +0300
Message-ID: <20260723140510.184819-2-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
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
index 4e5307355484..22466460e40b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3457,12 +3457,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
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
@@ -12749,6 +12744,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 61525ab7d21e..48d05c2e698e 100644
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
2.53.0

