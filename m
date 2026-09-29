Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F657ED98
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721730; cv=none; b=TdTW8KJ83E9bkINTIWwNp1VKL2IKMVDV9eaw8wja7Jxsy0ozV3YYJyxehqEMG2Hm3IkdHgRDyLoG9R0IwFVV5asGR+M3tpUO4I2I4L00lgx38FHMs7y912433VJmMD2GPlY3kKPxxniYuFHgjAGd3flP9t0w5mnmbJkRG3Pp714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721730; c=relaxed/simple;
	bh=ki3QZDtvRDeyIzE/5QqKOeKqJl7emQO5II/+YZv/IDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP9pj0aMycMMTQJvZKOlEwoyEeRWB80ZQchIUHlJl+yZQV00nVbvjLtbVYwg5UdDe38CW9KXROaGBUE3KwQDPyAPTXvkB2VOYLqgniYYsYgOb+f5Z7lVy2UDl4qj9eIgQH1GMLS/q9Pwhq3yeLYbplto+Fk7x3Uu/WRT9l8zCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvS4xSX5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvS4xSX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790721728; x=1822257728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ki3QZDtvRDeyIzE/5QqKOeKqJl7emQO5II/+YZv/IDY=;
  b=SvS4xSX5BLf+CjuoaHiJPY6QKdpfS7OjQClcds9fIiGBxPBs+Fk9DW/X
   Ae818wz6EAi5BQg3JgxFHUvXct6jE5jAzg/N+dGnyIqwQAKa5TXB+dIg0
   b6CbIX11cYSZMx87OBplxo01NXG4Lf1WtIgPtvG+2acSlK1XGB/X9C7vB
   YCAuWZsqveJ8VKOi0sKveQ48Lc6cN8XGVcA7Y4jGZCQXts0K+IOPegqIe
   rUcFNcf9dV2f7ClKeC3bquBO2HY/7jljKj/piLfwvAd4XSW30vw6+/j4r
   AS1bYa2m+795+ns0NOYt2Zv/2WYZlVso9z9mOyMgKD4LUczMtORPQhW6O
   A==;
X-CSE-ConnectionGUID: nqfMvGGQTySTZPIMVtEIBw==
X-CSE-MsgGUID: SXOpQW0zS6eBh8uEaAVYkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91548886"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91548886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 15:42:01 -0700
X-CSE-ConnectionGUID: ftuq+SCORPW0x5ybM1X3TA==
X-CSE-MsgGUID: X0SvCfrHSNSk/2B2TZkGkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313452322"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 29 Sep 2026 15:42:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	aleksandr.loktionov@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	xiongwm2026@163.com,
	ynorov@nvidia.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 06/10] ice: add rx timestamp tracepoint for debugging
Date: Tue, 29 Sep 2026 15:41:46 -0700
Message-ID: <20260929224153.1455466-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-1-anthony.l.nguyen@intel.com>
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
index e54a98a0bdd0..b781004f856d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2330,6 +2330,8 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
 
+	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
+
 	return ts_ns;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 7568c917cdbe..7c43683a77d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -261,6 +261,24 @@ DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_req);
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

