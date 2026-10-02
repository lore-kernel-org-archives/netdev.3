Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FC4D4882
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951761; cv=none; b=mlIlkybWp7XaQ5r8hqLrZtUJbLuyGFYkeFOFWlWHPyTayninp+DiX85t48fH63EgmCwavdu2e+cd0N9yoiyXtP4rka0rarRAVVGWSHjM+OCKw74JgaK4SBfCGi8z3DRTO7wT2qkA16Lse32jDKLzC6Gpnz78QS7LjK+aUvDBG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951761; c=relaxed/simple;
	bh=Lg5Ulei+U+KvWSaIx5EGde2ohcrF7ioScpl1qhHqqqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co5AKl/+5H9VI/v+cBdhQDJrh4MkFmWriKWMX+dvesBH3EwZsJgz8HnKxZ7NdKCfHNU9B78TkUI0506plisb1URMbXp/xyb5leS8Jo4VMDUA4HJ8rhGJliejwGrSNYA7DLH/KjvBUg1dWAy277TKx5wChtZEc8aSLXdPhJBydgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=WcEvdJ23; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="WcEvdJ23"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso32044755e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1790951758; x=1791556558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uL2YA6plGhWRBGkvkLWd93Lb0zO4IcY21sq2nOcbvrU=;
        b=WcEvdJ236dXxxv0NAgEamM+CraHvC7qM/HZ/0ee9SsI5Ha6w3zyeb5dFhumVQ5ndoI
         jsACAnRLyr9bI3+AZBmb3B9Y/G2jf5Dyjc5/21u70bFFtySSdbRRLtu3+bGtU1Zd8ymG
         BMUf8fPOO/zplTgKRs5M6EcdzuXm2l7lx4facFUkZlCxXokKbGDTtNjzJLZ8xjY5LwbS
         es1GwYZpTuWtWOyC85UwXGN9fkWtkGW1P8LPZ4p3hwgM/vXwa44iTtR7/P/DG1DVUuuH
         f5C4rZJ1NdMGF0ADF4tFOSf+Olof3jbWiDh1GhhsBM9advovLDWC9jMM6hSMhziIyguS
         6yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951758; x=1791556558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uL2YA6plGhWRBGkvkLWd93Lb0zO4IcY21sq2nOcbvrU=;
        b=RVJ27l7kYTf0qBf8H/g50JL2WK0lxd+Ch2Gzi4Pz2cEXGGHCi4mP+37hc+aDpAIxDH
         qpNQfx8vJzgm8gm9yidDqb035fu9ACYGZtecXzhNNy6TehvFi3NjEceUz7KE+PN/6369
         lAHU/Ss9kPvCDiVSR72VwICzwGagtvGc9iLbVvIwIIZqoFRXTSq8KNEVoZL5uIfG6Z6Q
         JbR0rm9clxTROa0zEY1+/bC3DKaxH4KG/1zci2OxNkiq194sv96uxJjAZcaB6n56lehE
         I5mbemLF7leHVzmWFgtWvWLqE4TTaYnVcKBE6l5ysvUufsXWN250A1sisDZxQ5bUCFJd
         Jl1g==
X-Gm-Message-State: AFuF++mazWU999RlMs6i+1aFoWw9DtO4LLePCBhjI4XRnEuxSe9pc8kA
	SyO1M73GKWLI+SikEc5PhSR44/XcpJwJd9k4LYam0zzseETkS0w8ulUhT9kk3vhSmj0Zkmvahnp
	RarxNcHWSgA==
X-Gm-Gg: AYBFou1tbz85O2lAPn7Mh66PTCNK4M5P8iCOVtxj0f1v/1r0AXWccAMP8GjJFkytSYy
	R8VRrWLG8UZ1KPosustQHbpAezuGwoB0rDq1+qB9/tiHFpnkaPV+mqKFt1dd4lWdOs8Gi88BpY7
	QA+jAXJ3zNr4qqTdYoqcfQhiFkh0AK8bJrR+6eBbkPU6Vutv8nYIcBrR5d+F8uNQV4zj0l+W/Gg
	5npGLdnHJRY09jRJDoxWb7wNs1JuYrzOb763TwCwY+nL7SkhUKM5E3ceZejeSdxdCIeRzksgzGQ
	1jqreL66rs59eF0Ws2Q1PF7S9oHd5vou4fu4T9rKgpv5N6LUHrHWpTkaAZpgD7EGRBxmgDEvU2W
	CZYjOsFgExYxmisAJ2seydfGoONgLsmCEU0Av7HB418DSGCoeQFdGrprnUkx9v6q7Oi0ataXIqR
	r2kD7dvaTnc9qy8uF5X0bbC7n74DlobbDj22MhrOqHvQq67pIMcal133QLuQRyyDaUUJT2tVU1N
	9uMXA==
X-Received: by 2002:a05:600c:c166:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-4a0276d7e8amr55189965e9.22.1790951757685;
        Fri, 02 Oct 2026 07:35:57 -0700 (PDT)
Received: from koen-nuc11.. ([2a09:bac0:1000:2ef::4e:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f67cbfesm8715315ad.28.2026.10.02.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:35:56 -0700 (PDT)
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
To: netdev@vger.kernel.org
Cc: quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dnlplm@gmail.com,
	linux-kernel@vger.kernel.org,
	Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: [PATCH net-next 1/4] net: rmnet: use fast monotonic time for tx aggregation
Date: Fri,  2 Oct 2026 16:35:26 +0200
Message-ID: <20261002143529.3217189-2-koen.vandeputte@citymesh.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
References: <20261002143529.3217189-1-koen.vandeputte@citymesh.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rmnet egress aggregation logic currently relies on ktime_get_real_ts64()
to determine if the aggregation bypass time threshold has been reached.
Calling a wall-clock time function on the transmit hot path introduces
significant performance bottlenecks, causing cacheline bouncing and pipeline
stalls when processing high packet volumes. Furthermore, manipulating and
comparing struct timespec64 fields adds unnecessary branching overhead.

Since the driver only needs to measure elapsed time between consecutive
packets to evaluate the aggregation bypass condition, absolute wall-clock
time is not required.

Replace ktime_get_real_ts64() with ktime_get_mono_fast_ns(). This reads a
lockless, per-CPU timestamp directly in nanoseconds, returning a simple u64.
Update the aggregation state variables (agg_time and agg_last) in
struct rmnet_port to u64 accordingly.

This optimization significantly reduces CPU overhead, eliminates struct
timespec64 math, and provides a much faster, cache-friendly timekeeping
mechanism for high-throughput egress traffic.

Signed-off-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  4 ++--
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 22 ++++++++++---------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index 5adda0323dda..78c0289b6583 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -47,8 +47,8 @@ struct rmnet_port {
 	struct sk_buff *skbagg_tail;
 	int agg_state;
 	u8 agg_count;
-	struct timespec64 agg_time;
-	struct timespec64 agg_last;
+	u64 agg_time;
+	u64 agg_last;
 	struct hrtimer hrtimer;
 	struct work_struct agg_wq;
 };
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 39d6d084e73f..2eafb1d969c1 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -536,7 +536,7 @@ static void reset_aggr_params(struct rmnet_port *port)
 	port->skbagg_head = NULL;
 	port->agg_count = 0;
 	port->agg_state = 0;
-	memset(&port->agg_time, 0, sizeof(struct timespec64));
+	port->agg_time = 0;
 }
 
 static void rmnet_send_skb(struct rmnet_port *port, struct sk_buff *skb)
@@ -591,21 +591,23 @@ static enum hrtimer_restart rmnet_map_flush_tx_packet_queue(struct hrtimer *t)
 unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port,
 				    struct net_device *orig_dev)
 {
-	struct timespec64 diff, last;
+	u64 diff, last, now;
 	unsigned int len = skb->len;
 	struct sk_buff *agg_skb;
 	int size;
 
 	spin_lock_bh(&port->agg_lock);
-	memcpy(&last, &port->agg_last, sizeof(struct timespec64));
-	ktime_get_real_ts64(&port->agg_last);
+	last = port->agg_last;
+
+	now = ktime_get_mono_fast_ns();
+	port->agg_last = now;
 
 	if (!port->skbagg_head) {
 		/* Check to see if we should agg first. If the traffic is very
 		 * sparse, don't aggregate.
 		 */
 new_packet:
-		diff = timespec64_sub(port->agg_last, last);
+		diff = now - last;
 		size = port->egress_agg_params.bytes - skb->len;
 
 		if (size < 0) {
@@ -614,8 +616,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 			return 0;
 		}
 
-		if (diff.tv_sec > 0 || diff.tv_nsec > RMNET_AGG_BYPASS_TIME_NSEC ||
-		    size == 0)
+		if (diff > RMNET_AGG_BYPASS_TIME_NSEC || size == 0)
 			goto no_aggr;
 
 		port->skbagg_head = skb_copy_expand(skb, 0, size, GFP_ATOMIC);
@@ -625,11 +626,12 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 		dev_kfree_skb_any(skb);
 		port->skbagg_head->protocol = htons(ETH_P_MAP);
 		port->agg_count = 1;
-		ktime_get_real_ts64(&port->agg_time);
+		port->agg_time = now;
 		skb_frag_list_init(port->skbagg_head);
 		goto schedule;
 	}
-	diff = timespec64_sub(port->agg_last, port->agg_time);
+
+	diff = now - port->agg_time;
 	size = port->egress_agg_params.bytes - port->skbagg_head->len;
 
 	if (skb->len > size) {
@@ -653,7 +655,7 @@ unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port
 	port->skbagg_tail = skb;
 	port->agg_count++;
 
-	if (diff.tv_sec > 0 || diff.tv_nsec > port->egress_agg_params.time_nsec ||
+	if (diff > port->egress_agg_params.time_nsec ||
 	    port->agg_count >= port->egress_agg_params.count ||
 	    port->skbagg_head->len == port->egress_agg_params.bytes) {
 		agg_skb = port->skbagg_head;
-- 
2.43.0

