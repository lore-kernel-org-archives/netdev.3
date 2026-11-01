Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515314;
	b=h8weCOrfA2O90o2Cp6qup11VTDpuahl3EjywsaqPp4Umv5mKMzPrKsLSaQFLudi/m77W
	 N6NFkWhu2vL9iIyub8dav7xrgWcnGLNpbSw1L1RpjvSqnwIhY7n4H0e/b0nvq4d+dpDZ2
	 jT/8NBBd5L/9Za5h14ys4vx0trMSiQAIcQo+c5iLjmy/qZi6DBR5lqB3yZBgivL7OPyuJ
	 55Zc6dRcXjDd3uDNZCHmL4JyFWLa+JTw1OfOzavuKUde+w+Gr3htUXkhQAcDfv6rBTmCC
	 L52k5Zdx+qOptRmRwvoMQkJJj/48OzhP+ggWGvACC8Dx17Yd4meJpfCS4KnSZVAaUSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515314;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sNHJ5c2IaTn4fBsjDeRFPYb3MZ2fhYgpYQHFen2RsV4=;
	b=Bg2WXDebGvUmKwYOnHS1uudo3jPK8HipWFYhWY3fQbwqEkT97mpUz9oiaLQ/VVaEzA0r
	 pXET+aSjgXF/qGxLyyV2ef1KLIRu4O/AoG12gmIKiLK8zdwZvQbeYla7X/NI33sLz6Z7O
	 9ekFGe3imISY9Y3sNX/HQ8j3QZobuj1eIZlbDQwc1/ZSB47xhNWWIkavXEox+Bf2k/vH6
	 6m7c56wdOYqCHZj4p72gHIVhe9EIt797Bx8uqQ+bfFaG3Ebt0UZ36yklWnJilIpwLzIIm
	 DF562BQfVQP0ZTs4w8IaFUZd4455ORjtZZnhaLC/er0jh708s5Bt0pKCBOETBzBztqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWMKvNLM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC55606A324;
	Sun,  1 Nov 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWMKvNLM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19551F000C1;
	Sun,  1 Nov 2026 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793515313;
	bh=sNHJ5c2IaTn4fBsjDeRFPYb3MZ2fhYgpYQHFen2RsV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jWMKvNLML2PHnG0zTANlE8EEHvZVwcBAk6LfMZ4H50y6NlYY+enhiZc5v5mZwpjE4
	 T4JXWmCjR8koJuh2c+ZsxSMxDQAPW6qcwUVMCXx2KFexrcx9+isVujI+6WGt+EUB89
	 j0Nnm81nwxminp97CLXdcXKiwg06ZQQfDeAcEUY+lFLjKcdRCj6f2Bpn6opu0XUrlO
	 /LWJo16YtAQ3Felve8O/GyjTw68xJLrywsm1BwbkDntd5aHYtka9tCMA696OvQuEsh
	 /2peaZK9Pz1zMcKAgNyGbewM+hquDH5dnVhMuuP4ymPMtFrsCvLFciTWQg8MZLTqII
	 7iGQgpLignYzg==
Subject: Re: [PATCH net v3 1/2] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
From: netdev-bot+sashiko@kernel.org
To: congei42@163.com
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2026 06:41:52 +0000
Message-ID: <179351531244.3131.14224078514634412496@kernel.org>
In-Reply-To: <20261031063823.876645-2-congei42@163.com>
References: <20261031063823.876645-2-congei42@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Applied alone, the patch "sfc: fix use-after-free of filter_work
  in efx_realloc_channels()" only cancels channel->filter_work in the…
- [Medium] Applied alone, the patch "sfc: fix use-after-free of
  filter_work in efx_realloc_channels()" leaves the old channels' aRFS…

--

sfc: fix use-after-free of filter_work in efx_realloc_channels()

This adds efx_free_channel(), which cancels the per-channel aRFS expiry
work synchronously before freeing a channel. It is used in
efx_realloc_channels() and efx_fini_channels(), and the expiry work is
re-armed at the common exit of efx_realloc_channels() for channels that
still have filters. The same changes are applied to Siena.

Link: https://lore.kernel.org/netdev/179310908138.3134.11515982039281965575@kernel.org/

> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index f4dc3f3f4416c..44943345fa87a 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -561,6 +561,14 @@ static struct efx_channel *efx_alloc_channel(struct efx_nic *efx, int i)
>  	return channel;
>  }
>  
> +static void efx_free_channel(struct efx_channel *channel)
> +{
> +#ifdef CONFIG_RFS_ACCEL
> +	cancel_delayed_work_sync(&channel->filter_work);
> +#endif
> +	kfree(channel);
> +}

[Severity: High]
Is waiting for filter_work enough before this kfree()? The per-NIC aRFS
insertion works in efx->rps_slot[] can also hold a pointer to this
channel. efx_filter_rfs() queues them with schedule_work().

efx_filter_rfs_work() in rx_common.c looks up the channel when it
starts. It then sleeps in the MCDI insert before it touches the channel:

drivers/net/ethernet/sfc/rx_common.c:efx_filter_rfs_work() {
    struct efx_channel *channel = efx_get_channel(efx, req->rxq_index);
    ...
    rc = efx->type->filter_insert(efx, &req->spec, true);
    ...
    if (rc >= 0) {
        mutex_lock(&efx->rps_mutex);
        if (channel->rps_flow_id[rc] == RPS_FLOW_ID_INVALID)
            channel->rfs_filter_count++;
        ...
        channel->n_rfs_succeeded++;
    } else {
        ...
        channel->n_rfs_failed++;
        ...
        __efx_filter_rfs_expire(channel, min(channel->rfs_filter_count,
                                             100u));
    }
    ...
}

None of efx_device_detach_sync(), efx_stop_all() or
efx_soft_disable_interrupts() flushes these works.

Can efx_realloc_channels() call efx_free_channel() on an old channel
while one of these works is still blocked in filter_insert()? If so, the
work writes into the freed channel when it resumes.

The failure path also runs an expiry pass on the freed channel, which is
the problem this patch is meant to close. Siena has the same pattern, in
its efx_filter_rfs_work() and efx_siena_realloc_channels().

The next patch in this series, "sfc: quiesce aRFS work before copying
channels in efx_realloc_channels()", appears to fix this:

  - It adds a netif_device_present() check to efx_filter_rfs() and
    efx_siena_filter_rfs().
  - It adds efx_filter_rfs_flush(), which calls synchronize_net() and
    then flush_work() on each rps_slot[].work. This runs before the
    channels are copied.

Could that be folded into this patch so it is correct on its own?

[ ... ]

> @@ -898,10 +906,21 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
>  		if (channel && channel->type->copy) {
>  			efx_fini_napi_channel(channel);
>  			efx_remove_channel(channel);
> -			kfree(channel);
> +			efx_free_channel(channel);
>  		}
>  	}
>  
> +#ifdef CONFIG_RFS_ACCEL
> +	/* Re-arm the expiry work on the channels now in use: the copies on
> +	 * success, the originals after a rollback.  The copies inherit the
> +	 * aRFS filters, so they must inherit the expiry too, or a channel
> +	 * that gets no further NAPI polls would never expire its filters.
> +	 */
> +	efx_for_each_channel(channel, efx)
> +		if (channel->rfs_filter_count)
> +			schedule_delayed_work(&channel->filter_work, 30 * HZ);
> +#endif

[Severity: Medium]
Can the rfs_filter_count checked here be stale on the copies?

The copies come from efx_copy_channel(). It does a plain struct copy
without taking rps_mutex:

drivers/net/ethernet/sfc/efx_channels.c:efx_copy_channel() {
    ...
    *channel = *old_channel;
    ...
}

This copies rfs_filter_count, rfs_expire_index and rfs_last_expiry. The
copy also shares the rps_flow_id pointer with the old channel.

With this patch, the old channel's filter_work is only cancelled in
efx_free_channel(), in the out: loop above. By then the clone, the swap
and efx_probe_channel() on every copy have already run.

Until that cancel, __efx_filter_rfs_expire() and efx_filter_rfs_work()
can still update old->rfs_filter_count and the shared rps_flow_id[]
under rps_mutex:

drivers/net/ethernet/sfc/rx_common.c:__efx_filter_rfs_expire() {
    ...
    channel->rps_flow_id[index] = RPS_FLOW_ID_INVALID;
    channel->rfs_filter_count--;
    ...
}

So the copy's count could be too high after an expiry on the old
channel. It could also be too low after an insertion, and later wrap.

Suppose a copy's count ends up at 0 while rps_flow_id[] still holds
valid entries. Would this loop skip that channel, so its filters never
expire? That seems to be the case this block was added for.
efx_siena_realloc_channels() has the same ordering.

The next patch in this series, "sfc: quiesce aRFS work before copying
channels in efx_realloc_channels()", seems to fix this too. Before the
clone loop, it calls efx_filter_rfs_flush() and then
cancel_delayed_work_sync() on each channel's filter_work. It does this
in both efx_realloc_channels() and efx_siena_realloc_channels().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031063823.876645-1-congei42%40163.com
