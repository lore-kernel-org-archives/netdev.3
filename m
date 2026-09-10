Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBF21CC5C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073182; cv=none; b=DbiSzEcBJZR5Gu+OlnK9tS9GcXjHeFl5+3iVDQBZ+2+nH3Lp6MLy8CcV8KKloOMEQ2QdErMvkKoEjf0fghV4DNUl3lQ5L0dmmzezKEQd4sVy4dOziKTQRcHXjy7LpNzJAkTkx26JJYyBNPfHbtfepsMLbRyZh5hrZUB554bRXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073182; c=relaxed/simple;
	bh=bwAPtH1cFw/vzZlX0EdiGOMwPvyvahfWBCcWXcEO3yE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SskOSVVyqtVIbxz58DrpL21ySol4YeENE3ohDDc9o5e9Es15ttOZoKNTrHKuZjSsRFvwEx5FPima4gYWt4S8FE7XH5mb4q1DuZmLglCgcXkYebop/pmDh0hjWp+vg0DzDhAB3R1aLWCxBsPMD2qbX0nmkr6XjEittyRcDeD0DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4ZHopnU; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4ZHopnU"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cc0ed09b5so2988096d6.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789073179; x=1789677979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYLFwrOrOVw0RHZLD0RIjp5m/FrSWd8oD6D8uWEyFtA=;
        b=O4ZHopnUI7XLwiXRgX94U+aNBFq3Iy+ixJhLFfLLJgKX7SXQ1DyU5HLDNdbh0OtshI
         ClE/E3jU2e0JP5cOUVCYHfMiRmCLPQ3XrExqQ66Rt4wDf16g4J1kM2gChl1WYw4K3RaF
         2xjAWT2eFAPDAFUflpvzRTSQjr9uXiEc5U8df4JgPOHT7elIDCs+AQO/9yV5flu9Ft2m
         ShmAm7l0scO1cKL35EbDdd+XsxWLQ5IpkDDkmHMw91GAxSN2+bbRvUDMHE15wr8v7kjZ
         oD6kyh6X2qkzih3pIeD8n6NyZbn9uDJvPinc5ZsrE8SGOeH37yXh+sAHhY4Ve4PU0dI1
         nyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073179; x=1789677979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYLFwrOrOVw0RHZLD0RIjp5m/FrSWd8oD6D8uWEyFtA=;
        b=sfFnsF2rc85z1IeTbONUTCThm+G+jSKQcXjfUFFe+ZrDhy6O4ja6Nt66oa6/tNOb0a
         qGeG/4J+WaLog4t/y9cQkTnWouEzup6y5+Ggwhg8X6qpIfc6dlwG4mGricHXf44mdL7M
         diYPEWdZgGmV1FWlzZw/BFMoFM+VfVY2K5X1Yw3KMvh1DTNsR8r3tZaXNWHro94NKsPr
         Q40UE6Wt3FVYQJ507fKlQsGp5tGSR2Wz7NkAUECHfqSh/jSNE+xiG/gE9AKoggEdf77b
         vrf77G2TGgErIyMWPqiw+2otfF/pwPLuBFX8pBeEbP0MFnzw8FipnhA64BvY6MR/20n0
         uHpw==
X-Forwarded-Encrypted: i=1; AKwUvBwBdDCk+koFr0gVSiYnsFtu0R8UshhuoLeDf8c5kMrp07Kq+rsfXcGqe7IavNpKhgH4YJ/PQAI=@vger.kernel.org
X-Gm-Message-State: AFuF++kuXLkhSC8SXCaSovfUZ3ZW/RmUoHrN2NVlqW20q866iGHEppng
	8/TktOWQ6W2+GZl2J1gwA84gMmeLC4d1OFQ1KlFNef+9XWZj95Gmt31/LzAbIDlCQlAvlu3iB6l
	gYavRwVkLMwDxpw==
X-Received: from qviz7.prod.google.com ([2002:a0c:d787:0:b0:911:5c05:d75e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6008:b0:933:aa0:bb83 with SMTP id af79cd13be357-939ea213922mr107285885a.34.1789073179066;
 Thu, 10 Sep 2026 13:46:19 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:46:10 +0000
In-Reply-To: <20260910204612.3762015-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910204612.3762015-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910204612.3762015-3-edumazet@google.com>
Subject: [PATCH net 2/4] drop_monitor: use timer_shutdown_sync() to prevent
 timer rearming during teardown
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In drop_monitor teardown paths (net_dm_trace_off_set(),
net_dm_hw_monitor_stop(), and error unwind paths in net_dm_trace_on_set()
and net_dm_hw_monitor_start()), per-CPU timers are stopped using
timer_delete_sync() followed by cancel_work_sync().

However, there is a circular dependency between send_timer and
dm_alert_work:
1) sched_send_work() (timer callback) schedules dm_alert_work.
2) send_dm_alert() / net_dm_hw_summary_work() calls reset_per_cpu_data()
   or net_dm_hw_reset_per_cpu_data().
3) If memory allocation fails under memory pressure in the reset
   function, it re-arms the timer via mod_timer(&data->send_timer, ...).

If dm_alert_work is running concurrently while timer_delete_sync()
executes on another CPU, an allocation failure in the worker will
re-arm the timer after timer_delete_sync() has already returned.
Once cancel_work_sync() completes and module_put() is called, the timer
remains active in the timer wheel. If the module is then unloaded, the
timer will fire and execute sched_send_work() in freed memory,
triggering a kernel panic / use-after-free.

Switch from timer_delete_sync() to timer_shutdown_sync(). This guarantees
that any in-flight timer handler has finished and prevents subsequent
re-arming attempts from running workers from succeeding. When monitoring
is restarted later, timer_setup() is invoked, which cleanly
re-initializes the timer.

Fixes: 9398e9c0b1d4 ("drop_monitor: Perform cleanup upon probe registration failure")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 018d19e3a71de0be50bcc5753ba65f715f678aaa..873155ca72432924322bb7961996dd3430d052bc 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -1083,7 +1083,7 @@ static int net_dm_hw_monitor_start(struct netlink_ext_ack *extack)
 		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		timer_delete_sync(&hw_data->send_timer);
+		timer_shutdown_sync(&hw_data->send_timer);
 		cancel_work_sync(&hw_data->dm_alert_work);
 		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
 			struct devlink_trap_metadata *hw_metadata;
@@ -1117,7 +1117,7 @@ static void net_dm_hw_monitor_stop(struct netlink_ext_ack *extack)
 		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		timer_delete_sync(&hw_data->send_timer);
+		timer_shutdown_sync(&hw_data->send_timer);
 		cancel_work_sync(&hw_data->dm_alert_work);
 		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
 			struct devlink_trap_metadata *hw_metadata;
@@ -1179,7 +1179,7 @@ static int net_dm_trace_on_set(struct netlink_ext_ack *extack)
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		timer_delete_sync(&data->send_timer);
+		timer_shutdown_sync(&data->send_timer);
 		cancel_work_sync(&data->dm_alert_work);
 		while ((skb = __skb_dequeue(&data->drop_queue)))
 			consume_skb(skb);
@@ -1207,7 +1207,7 @@ static void net_dm_trace_off_set(void)
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
 		struct sk_buff *skb;
 
-		timer_delete_sync(&data->send_timer);
+		timer_shutdown_sync(&data->send_timer);
 		cancel_work_sync(&data->dm_alert_work);
 		while ((skb = __skb_dequeue(&data->drop_queue)))
 			consume_skb(skb);
-- 
2.55.0.1007.g17ff1f9808-goog

