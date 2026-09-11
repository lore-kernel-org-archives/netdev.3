Received: from mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F13D5221
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120644; cv=none; b=CQYFHwEVntJJRB9MggtS8aNymsnOc7NBpzeG/reVfpZ6d5RaCmGgpCourRhCClL+0JuGKTwh87QXdsSC5S0+qxSHfeywODVOHaCl1DWWaQjzZz8a/P4wQs91LPChQyeRPqiMtwa/Iti0Cqdh1n74YdtyitqUYdJ2J4KIUhN48Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120644; c=relaxed/simple;
	bh=fFdkA+caKNeL//jDBbEEXJrfiRWlnqZSIcHdCu2aQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwE4m/nE/oDZqXEDzExo+0zHM7b0Mw0mS9FLMN3ncJvSh5yEhQHl9ga5adabeOfajL4GsMDPveR/JIE+OpFc4xGV3qd7GXsHGvTkPAIHyR7Y54u3TP5ucomv3kRqI3N17klKAeJ+PBNo2uXqJOfCmwKlt0lO2FjDF1+idAiTc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q6W7MM5T; arc=none smtp.client-ip=91.218.175.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q6W7MM5T"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fFdkA+caKNeL//jDBbEEXJrfiRWlnqZSIcHdCu2aQaE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120639; v=1; x=1789725439;
 b=q6W7MM5Tv7FvJfnrM8xgO5ETU+0553BqM5toxU5mMh+/eSEQ7NkP/Y/2Ji8euKePyRw3kPzq
 fflsQz4iguxaPpquB3tg/VccWggkDURBi+iZYIDm9L6fRS5HuOC2LZHVziito/niNWz6j3Ed89n
 u6rf8QW8AqDTK5XGF1Y3Tlok=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7a5139a216fbc9b0;
	Fri, 11 Sep 2026 09:57:19 +0000
X-Mizu-Trace-ID: 7a5139a216fbc9b0
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 17:57:12 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/4] drop_monitor: use timer_shutdown_sync() to
 prevent timer rearming during teardown
Message-ID: <aqPQeBYd-8M4P3BI@fedora>
References: <20260910204612.3762015-1-edumazet@google.com>
 <20260910204612.3762015-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910204612.3762015-3-edumazet@google.com>

On Thu, Sep 10, 2026 at 08:46:10PM +0000, Eric Dumazet wrote:
> In drop_monitor teardown paths (net_dm_trace_off_set(),
> net_dm_hw_monitor_stop(), and error unwind paths in net_dm_trace_on_set()
> and net_dm_hw_monitor_start()), per-CPU timers are stopped using
> timer_delete_sync() followed by cancel_work_sync().
> 
> However, there is a circular dependency between send_timer and
> dm_alert_work:
> 1) sched_send_work() (timer callback) schedules dm_alert_work.
> 2) send_dm_alert() / net_dm_hw_summary_work() calls reset_per_cpu_data()
>    or net_dm_hw_reset_per_cpu_data().
> 3) If memory allocation fails under memory pressure in the reset
>    function, it re-arms the timer via mod_timer(&data->send_timer, ...).
> 
> If dm_alert_work is running concurrently while timer_delete_sync()
> executes on another CPU, an allocation failure in the worker will
> re-arm the timer after timer_delete_sync() has already returned.
> Once cancel_work_sync() completes and module_put() is called, the timer
> remains active in the timer wheel. If the module is then unloaded, the
> timer will fire and execute sched_send_work() in freed memory,
> triggering a kernel panic / use-after-free.
> 
> Switch from timer_delete_sync() to timer_shutdown_sync(). This guarantees
> that any in-flight timer handler has finished and prevents subsequent
> re-arming attempts from running workers from succeeding. When monitoring
> is restarted later, timer_setup() is invoked, which cleanly
> re-initializes the timer.
> 
> Fixes: 9398e9c0b1d4 ("drop_monitor: Perform cleanup upon probe registration failure")

Nit, not sure if we need add

70c69274f354 ("drop_monitor: Initialize timer and work item upon tracing enable")
and 8e94c3bc922e ("drop_monitor: Allow user to start monitoring hardware drops")

Thanks
Hangbin

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/drop_monitor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> index 018d19e3a71de0be50bcc5753ba65f715f678aaa..873155ca72432924322bb7961996dd3430d052bc 100644
> --- a/net/core/drop_monitor.c
> +++ b/net/core/drop_monitor.c
> @@ -1083,7 +1083,7 @@ static int net_dm_hw_monitor_start(struct netlink_ext_ack *extack)
>  		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
>  		struct sk_buff *skb;
>  
> -		timer_delete_sync(&hw_data->send_timer);
> +		timer_shutdown_sync(&hw_data->send_timer);
>  		cancel_work_sync(&hw_data->dm_alert_work);
>  		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
>  			struct devlink_trap_metadata *hw_metadata;
> @@ -1117,7 +1117,7 @@ static void net_dm_hw_monitor_stop(struct netlink_ext_ack *extack)
>  		struct per_cpu_dm_data *hw_data = &per_cpu(dm_hw_cpu_data, cpu);
>  		struct sk_buff *skb;
>  
> -		timer_delete_sync(&hw_data->send_timer);
> +		timer_shutdown_sync(&hw_data->send_timer);
>  		cancel_work_sync(&hw_data->dm_alert_work);
>  		while ((skb = __skb_dequeue(&hw_data->drop_queue))) {
>  			struct devlink_trap_metadata *hw_metadata;
> @@ -1179,7 +1179,7 @@ static int net_dm_trace_on_set(struct netlink_ext_ack *extack)
>  		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
>  		struct sk_buff *skb;
>  
> -		timer_delete_sync(&data->send_timer);
> +		timer_shutdown_sync(&data->send_timer);
>  		cancel_work_sync(&data->dm_alert_work);
>  		while ((skb = __skb_dequeue(&data->drop_queue)))
>  			consume_skb(skb);
> @@ -1207,7 +1207,7 @@ static void net_dm_trace_off_set(void)
>  		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
>  		struct sk_buff *skb;
>  
> -		timer_delete_sync(&data->send_timer);
> +		timer_shutdown_sync(&data->send_timer);
>  		cancel_work_sync(&data->dm_alert_work);
>  		while ((skb = __skb_dequeue(&data->drop_queue)))
>  			consume_skb(skb);
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 
