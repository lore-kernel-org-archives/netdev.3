Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104717;
	b=nx3TZVBhaXygp8d+t5JfBJKbXiyG1usqR+OaR7ddQvJu/w5zo5Qk85uD7S5tqvOpJIlp
	 b9iRPZrqMwQNGXTZfbuDsknvTjE7U1T18pjg0cO4zADVbrRHs5EvNA1RFGTGQhNhzHDA1
	 DqckFavfrUJyRsOPv51ahyZ3uwRp+5ovD9FbEK3Wu5Rubsq7lj6uh+GZCtjgJwP/74AbS
	 XbT1wF8z5WC792xyWDgV8EsFcgJrHlCvwGKdSGTQ30KOTh/Rvpkv06/aoRm0xW7jvyTXM
	 giynoL+YpfVnv0dMrdhckmmeHTVDPq4X7+wRJC98LIkQZ+tP75vLYWFSwnsMuV5X4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104717;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jPVJ1cDNGbYm4OpEQ76gnpLJPBDVc6YZIrK9UtAnw90=;
	b=t1LzYTwiXh1lSM9q6XlD5BP3hQ6mrlukeSORsOaN/zAMLXs6DwBIddS/4MHrnkIKzBR4
	 McngRlVVNhlnJEnpC5cDdS5rml3xMZjRyrhDdhSc/FalauA66CbB5N+tHVxNOX2hCQBg2
	 ZSg9CadLRhs+0OZ8+oD8vLG+YpmcK1RbYRctT03Z4++mCNt9Z/AMliFhL9fHOENpeGDtn
	 Q5uosAN9Jnzz40oVQupYk0/JWPfVCyG5zALjzNP0fiCgNDwDl7OKWdehk11wzRVOJotRA
	 EejS/GniJiae8AcnbuABwn541DAJk6qcla6YsJ1KON6X3OELa8PojZiEXLKGv2AKZsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IJf1AIMI;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2F606A332;
	Tue, 27 Oct 2026 12:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD2F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IJf1AIMI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793104717; x=1824640717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6UIOgzPxsSvzq2lcgh7cv5Yo6+3mJZ8wHbFKnDYEB4=;
  b=IJf1AIMICrXU/S5RMG729SJtXyaLQm+O5WIjXx+FLgfYB8WVo/zbJbrg
   GmShHVfmFDJhtI5EyrJ6jiI3AUuD0BOW4Roe3QlmyTbcRtYCYJfvK4h5v
   NtGi9FDjEXlD+fLG5Fzzwdukpoqod5sskhMx8GFkmg/bJY0j8E6rLBAYZ
   IqBUw6m1LbmASq7FRxmAaGQc/a6In3ZGwK8pBspVMTYxuNPT7byWumRmV
   1rz3VnE7CGbo8VvXpwtjnabUzi3qKZYm0NlDbbLYQHZpXISlKzpE3ghM+
   YyRx5T9haWqVECFXuYQ+8T35F8JL7OIT+WwmvaCMXS034OYmDvDQxojpu
   g==;
X-CSE-ConnectionGUID: JLktRhCjScW6uyrDdvst3Q==
X-CSE-MsgGUID: bQcQRXadTsKA2hvBS0UuYw==
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="64649368"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:38:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 27 Oct 2026 05:38:30 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 27 Oct 2026 05:38:28 -0700
Date: Tue, 27 Oct 2026 13:38:27 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Sicong Huang <congei42@163.com>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Louis Peens <louis.peens@corigine.com>, Hui Zhou
	<hui.zhou@corigine.com>, <oss-drivers@corigine.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] nfp: flower: fix use-after-free in neighbour update
 work
Message-ID: <20261027123827.ouy6z635674mme4s@DEN-DL-M70577.microsemi.net>
References: <20261024044903.1130380-1-congei42@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261024044903.1130380-1-congei42@163.com>

> The netevent notifier handles neighbour updates and redirects by
> queuing nfp_tun_neigh_update() on system_highpri_wq. Each work item
> holds a reference to the neighbour, but only stores a pointer to the
> flower app.
> 
> During device removal, nfp_tunnel_config_stop() unregisters the
> notifier. This waits for notifier callbacks to return, but does not
> wait for the work they queued. The teardown then frees app->priv and
> app without waiting for these work items. Flushing cmsg_work in
> nfp_flower_clean() does not cover the neighbour update work.
> 
> A pending work item can therefore run after the app has been freed.
> Its call to nfp_flower_get_port_id_from_netdev() can then access freed
> memory while checking whether the neighbour's device can be offloaded.
> Even notifications for unrelated devices can reach this check. The
> same problem affects shutdown and probe error paths that tear down the
> app after the netevent notifier has been registered.
> 
> One possible interleaving is shown below. The neighbour belongs to
> another network device that remains registered.
> 
>   CPU0 (remove)                   CPU1 (notifier / kworker)
>                                   nfp_tun_neigh_event_handler()
>                                     queue_work(system_highpri_wq, ...)
>                                     return
>                                   /* Work has not run yet. */
>   nfp_tunnel_config_stop()
>     unregister_netevent_notifier()
>     /* Notifier callbacks have finished, but work may be pending. */
>   nfp_flower_clean()
>     vfree(app->priv)
>     app->priv = NULL
>   nfp_app_free()
>     kfree(app)
>                                   nfp_tun_neigh_update()
>                                     app = update_work->app
>                                     nfp_flower_get_port_id_from_netdev()
>                                       app->priv  /* use-after-free */
> 
> The work items are allocated per event and free themselves, so they
> cannot be cancelled individually, and flushing system_highpri_wq is
> not allowed. Use a dedicated workqueue for neighbour updates instead.
> In nfp_tunnel_config_stop(), unregister the notifier and destroy the
> workqueue before cleaning up the tunnel state. This prevents new work
> from being queued and waits for pending and running work to finish
> while the app and its resources are still valid.
> 
> Found by code inspection.
> 
> Fixes: 0ad722bd9ee3 ("nfp: flower: fix for take a mutex lock in soft irq context and rcu lock")
> Signed-off-by: Sicong Huang <congei42@163.com>

Looks right to me.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

