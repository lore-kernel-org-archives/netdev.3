Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B673F58C2
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965762; cv=none; b=IH2Xo6zRVzBJGMhyh+zmIAIlFYIgWLsHW4dsohNBdMZBNjbssrkVNieTW28u/X+JHZpY8VxVpZh1WrAWY7e35v/Hxswth5KfTzNZrCb49LDZbUuVOK0ZcQiMTm4GwQJ3N7dm3xqVB0nfgnHF34Hczt6srfNomzvyH4M35ainS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965762; c=relaxed/simple;
	bh=ypMXXQ5fO86oWHzzDfilD1YSiNAtLjxqebpXXkG4V8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIiDri0Eg7mVAl1+3bb/n6JFnsWJNisCZy9Hjx2WK/gww7Y3G44dqrR9zkc6/u/Ir6fhdOj4R4tej/SjihxnL9spwfUrqZuQfSxHNjrzEp9xD17fR+haD5IVRBW3M3cjdl0em069LDKO9jJWRs/iANW87mu9K9mM8SKkMBCag8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKaLElte; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKaLElte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965755; x=1817501755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypMXXQ5fO86oWHzzDfilD1YSiNAtLjxqebpXXkG4V8M=;
  b=AKaLElteBPK4n8clxZjIeqrIimrKHbXNeYzwcgB7dH4sYYraKxaSTzXn
   E5P6XmJl02FCpuTUjHGDMmpye6ZfXUzIt/Q1LTx/xOzWEWFFkx11V37vp
   SC1eSS1Xf6Tkwzk3nugCLrvnxFQjzgBgjvMGWeIU2GVYmms9o3kL/hcJz
   rdEeSsnAw4glLnoxS8FiGkVHAG7NgSLCZlX0SxkJ5rWqiJ5vCwCa7H5hS
   7RB/PtBd0jEwYo9ZTYN8GXp/V+eO2/KfFL+HSSLlFbVR0g9dQq9NbxN9f
   UZQQNyPSiCabUqUBx8QpejAvmc4vl5huWDseiQx8SaPtNVXcd51saGKMT
   A==;
X-CSE-ConnectionGUID: 4AD8+cFJQgCMTpy4JMVxaw==
X-CSE-MsgGUID: JTjhJGk1R5ymT4j7A5YXWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343588"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:51 -0700
X-CSE-ConnectionGUID: V6+Il8c3RXOKmLCSLWnMCA==
X-CSE-MsgGUID: EOsOz7u4QuW6mwEjuz8WCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576139"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 09/15] ice: add rx timestamp tracepoint for debugging
Date: Wed,  5 Aug 2026 14:35:34 -0700
Message-ID: <20260805213541.2281287-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

Add ice_rx_hwtstamp trace event to help debug PTP rx timestamp issues.
The trace captures cached_time, ts_high, and the extended ts_ns value in
ice_ptp_get_rx_hwts().

Enable with:
echo 1 > /sys/kernel/debug/tracing/events/ice/ice_rx_hwtstamp/enable
cat /sys/kernel/debug/tracing/trace_pipe

Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  2 ++
 drivers/net/ethernet/intel/ice/ice_trace.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index eaec36ab6ae3..e8392ec4f134 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2327,6 +2327,8 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
 
+	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
+
 	return ts_ns;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..3cb8c6ea03cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -241,6 +241,24 @@ DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_req);
 DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_done);
 DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_complete);
 
+/* Trace event for Rx timestamp */
+TRACE_EVENT(ice_rx_hwtstamp,
+	    TP_PROTO(u64 cached_time, u32 ts_high, u64 ts_ns),
+
+	    TP_ARGS(cached_time, ts_high, ts_ns),
+
+	    TP_STRUCT__entry(__field(u64, cached_time)
+			     __field(u32, ts_high)
+			     __field(u64, ts_ns)),
+
+	    TP_fast_assign(__entry->cached_time = cached_time;
+			   __entry->ts_high = ts_high;
+			   __entry->ts_ns = ts_ns;),
+
+	    TP_printk("cached_time=%llu ts_high=%u ts_ns=%llu",
+		      __entry->cached_time, __entry->ts_high, __entry->ts_ns)
+);
+
 DECLARE_EVENT_CLASS(ice_esw_br_fdb_template,
 		    TP_PROTO(struct ice_esw_br_fdb_entry *fdb),
 		    TP_ARGS(fdb),
-- 
2.47.1

