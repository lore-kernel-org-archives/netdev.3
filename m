Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CF3C1D50
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120012; cv=none; b=olCYcZQaeohcxHxQjauYg6GyY1BFIuHidDMuMFYQgID1tnjMdHl4SA0A8ANFbQCK7bzYS8K8rjlWCcJc+I2Lki62ZYBXQxWG35hX2bdCfXdZas3AJDvurLnHGZcowqhdJHlNU2xg6HkShBXx6LeHrd1+/nxZJWIaNw+x8c9vX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120012; c=relaxed/simple;
	bh=kOAhPxH6SoYXPS4IKQeL/hq3CmjduXbohYecZfKqjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VshCUGgZtIEcAqt9v8/SkyYdgAkdbIMyV6iIwaAIs3xxdpv5+4yVVZcsutynq+Iw65/oQyPcqQ3bq1emC4UKL8xkfe8DpDCyDWo23YCCGdny55oeV7xrsdzeu37DJjZqlWCl0x45xZFGO06PQ8u6/CJEsP3nZP74asaHhbOHf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LGebA+Cp; arc=none smtp.client-ip=91.218.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LGebA+Cp"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kOAhPxH6SoYXPS4IKQeL/hq3CmjduXbohYecZfKqjuU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789120007; v=1; x=1789724807;
 b=LGebA+Cp9gm+Bkan2mGvb2DHz1qfFN8eApxlH1eLt3frpD2o6YhEkzF6rxYJ9ONr3yY/zser
 mXjW9wnOye6etjrvhvkq28MadJQrcrWFonixCi5s50RZayQSrUDhW2v0/UZWSh+ODZ2ldtknK2I
 BA/bMxR9sCyccxq6qVXuME4o=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 09c34544a41792a3;
	Fri, 11 Sep 2026 09:46:37 +0000
X-Mizu-Trace-ID: 09c34544a41792a3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 17:46:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 1/4] drop_monitor: synchronize tracepoint
 unregistration on error path
Message-ID: <aqPN8ozDUDE0fRNA@fedora>
References: <20260910204612.3762015-1-edumazet@google.com>
 <20260910204612.3762015-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910204612.3762015-2-edumazet@google.com>

On Thu, Sep 10, 2026 at 08:46:09PM +0000, Eric Dumazet wrote:
> If register_trace_napi_poll() fails in net_dm_trace_on_set(),
> unregister_trace_kfree_skb() is called to roll back the kfree_skb
> tracepoint registration.
> 
> However, tracepoint_synchronize_unregister() is omitted before calling
> cancel_work_sync() and module_put(). An in-flight probe executing
> concurrently on another CPU could call schedule_work() after
> cancel_work_sync() has already returned, leaving a pending work item
> scheduled after the module reference is dropped. If the module is then
> unloaded, executing the work item triggers a kernel panic.
> 
> Add tracepoint_synchronize_unregister() after unregister_trace_kfree_skb()
> in the error path, matching net_dm_trace_off_set() and
> net_dm_hw_probe_unregister().
> 
> Fixes: 7c747838a558 ("drop_monitor: Split tracing enable / disable to different functions")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/drop_monitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
> index abaf108ac4db8c762c23f1d9c708c687ee36c7c9..018d19e3a71de0be50bcc5753ba65f715f678aaa 100644
> --- a/net/core/drop_monitor.c
> +++ b/net/core/drop_monitor.c
> @@ -1173,6 +1173,7 @@ static int net_dm_trace_on_set(struct netlink_ext_ack *extack)
>  
>  err_unregister_trace:
>  	unregister_trace_kfree_skb(ops->kfree_skb_probe, NULL);
> +	tracepoint_synchronize_unregister();
>  err_module_put:
>  	for_each_possible_cpu(cpu) {
>  		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
