Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109082;
	b=Bj+Be4CLStwBaULeOHFeZYhRAxE7PkQ2Bseb2redF+DOYmclMGQ8yo09hhgjdETOJub6
	 eCtIH3hgCiTNrC8KP3gRdh7/5Lhopw76Ujv2NSS7KTK0PdmZb12pg0cxYLFyCGcSG/sFe
	 2b4A/b+fwnROC639jx8XEzyuaOBy3LweHffEoIWqg+a+Uuxn5noHmouUDlmPzcG/ri/NZ
	 JleJBzJj5NLYxQ+O/k202HvbKCytKUHLtAqiPyXz0+EFfXJ+N/LuqUuDyJMLdHSFJMn4+
	 xd9+9lH2bgRKEBATfNNkEjMLHmlyHGPuldbALmiLuoX4HaJ++RNptI273QSHRw0FjdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109082;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=r2/2cR8qALhmhKdTWhnMtzLvqgJAAiVZEUJ32k9sl40=;
	b=Svk4qVhDSQpI92Pu6Sb/e3tAal1H7YawjRJkvxK4vIFBoVJZvfVhgeGy/1ewC7eP50sZ
	 fQkND7YfqSPGe0FnXX4+QIe3WY/RVBckuCKIMQA5MNtJkvmq+IKH/mEmkI7C3zKTksxDR
	 CSmFFvh01KX45b+4l3bchD1E8BRYgDWj8rrsyZlf+USKtIl/tfb/7hOaSy89WZtJfOzn9
	 BWMOnV2RMYb/F6unAMJyzVsVrrYbUVJveawF10adihXJJFONZgHQkuqA7gj+WH0Ywufmj
	 aLoav8HaIBmU3736eNWJssufMCr+/8Dc58IjC8NP0Te4KMQyVKL/RcdmOYUy/uBktzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/6fCTrn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97101606A31A;
	Tue, 27 Oct 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/6fCTrn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23781F01825;
	Tue, 27 Oct 2026 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109082;
	bh=r2/2cR8qALhmhKdTWhnMtzLvqgJAAiVZEUJ32k9sl40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F/6fCTrnQmnO88hUGBbsE/PiCwINF72f/XhAMhFwmt09BfGHeipiJVX2cCaz0gREu
	 KWiDeGRHf3o9yEpQlcriiI7ssj+g0sQCP5z6ihXleQzF4iDNIt+SFGvlpRAALgP2cz
	 f5j5WCH5/BLHZ10t2CavrY9T6enH+JG5x1DGqYs4teykLcp2zK0OpR0c3vJ3qMvVv9
	 qi0cyn5D49b6CJn+zT31VajYU7ZRhHTXMEZjU7JYlj1Zn5BaTqKWttBNrn/GjyzI2Q
	 nCfMPtdJl9RPdVH9i2hg1pCyQ68UcUphgw/Y1sVZloMmFwyTKyxZMmhSOm09Q8z075
	 22RJQq0q9JerA==
Subject: Re: [PATCH net v2] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
From: netdev-bot+sashiko@kernel.org
To: congei42@163.com
Cc: ecree.xilinx@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 13:51:21 +0000
Message-ID: <179310908138.3134.11515982039281965575@kernel.org>
In-Reply-To: <20261023134214.322796-1-congei42@163.com>
References: <20261023134214.322796-1-congei42@163.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After a ring resize, the replacement channel's aRFS expiry
  work is never started, so periodic expiry stops on that channel.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the async aRFS
  insertion work can still use a channel that efx_realloc_channels() has…
- [Medium] This problem wasn't introduced by this patch, but the cancel
  is placed late, so a race remains in efx_realloc_channels() /…

--

sfc: fix use-after-free of filter_work in efx_realloc_channels()

This patch adds an efx_free_channel() helper that synchronously cancels
the per-channel aRFS expiry work (filter_work) before freeing the
channel. The helper is used in efx_realloc_channels() and
efx_fini_channels(), and in their Siena equivalents. This closes a
use-after-free where the self-re-arming expiry work outlives a channel
freed on the ethtool -G ring resize path.

> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index f4dc3f3f4416c..3e29b892e90cb 100644
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
This isn't a bug introduced by this patch, but efx_free_channel() only
syncs filter_work. Can the async aRFS insertion work still touch a
channel that has been freed here?

efx_filter_rfs() queues efx->rps_slot[slot].work on system_wq and pins
only net_dev via netdev_hold(). efx_filter_rfs_work() caches the channel
pointer before it sleeps:

drivers/net/ethernet/sfc/rx_common.c:efx_filter_rfs_work() {
	struct efx_channel *channel = efx_get_channel(efx, req->rxq_index);
	...
	rc = efx->type->filter_insert(efx, &req->spec, true);
	...
		mutex_lock(&efx->rps_mutex);
		if (channel->rps_flow_id[rc] == RPS_FLOW_ID_INVALID)
			channel->rfs_filter_count++;
		channel->rps_flow_id[rc] = req->flow_id;
		mutex_unlock(&efx->rps_mutex);
	...
}

Suppose ethtool -G runs efx_realloc_channels() while this work is
sleeping in filter_insert() (MCDI) or waiting on rps_mutex. The old
channel can then be swapped out and kfree()d by efx_free_channel()
before the work reaches those accesses. None of
efx_device_detach_sync(), efx_stop_all() or efx_realloc_channels() waits
for in-flight rps_slot works.

The work would then read and write the freed channel. That includes
storing req->flow_id through an rps_flow_id pointer loaded from freed
memory, the n_rfs_succeeded / n_rfs_failed updates, and the
__efx_filter_rfs_expire(channel, ...) call on the failure path.

Should the channel teardown also wait for outstanding rps_slot works?
The Siena copy of efx_filter_rfs_work() has the same pattern.

> +
>  int efx_init_channels(struct efx_nic *efx)
>  {
>  	unsigned int i;

[ ... ]

> @@ -898,7 +906,7 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
>  		if (channel && channel->type->copy) {
>  			efx_fini_napi_channel(channel);
>  			efx_remove_channel(channel);
> -			kfree(channel);
> +			efx_free_channel(channel);

[Severity: Medium]
After the resize, what arms filter_work on the replacement channel?

efx_copy_channel() copies rfs_filter_count, rfs_last_expiry,
rfs_expire_index and the rps_flow_id pointer from the old channel, so
the aRFS filters stay installed. It only re-initializes the work:

	*channel = *old_channel;
	...
#ifdef CONFIG_RFS_ACCEL
	INIT_DELAYED_WORK(&channel->filter_work, efx_filter_rfs_expire);
#endif

With this patch, the old channel's self-re-arming work is cancelled here.
The only other place that arms filter_work is efx_poll():

		if (channel->rfs_filter_count * time >= 600 * HZ)
			mod_delayed_work(system_percpu_wq, &channel->filter_work, 0);

The self-re-arm in efx_filter_rfs_expire() exists to cover the case
where no NAPI poll happens:

	/* Ensure we do more work eventually even if NAPI poll is not happening */
	schedule_delayed_work(dwork, 30 * HZ);

Take a channel that still has aRFS filters after ethtool -G but sees no
more events. Does expiry ever run on it again? Its stale filters would
seem to stay in the NIC filter table, and its rfs_filter_count would stay
non-zero indefinitely.

Could the new channel's filter_work be re-armed after the swap, for
example when the old work was pending or rfs_filter_count is non-zero?
efx_siena_realloc_channels() has the same gap. The commit message also
doesn't mention this change in behaviour.

[Severity: Medium]
This is a pre-existing issue, but the cancel happens quite late in
efx_realloc_channels(). Can the old channel's filter_work still run
between efx_copy_channel() and this point?

efx_stop_all() and efx_soft_disable_interrupts() don't cancel
filter_work. efx_copy_channel() then does *channel = *old_channel
without rps_mutex. After that, the old and new channels share one
rps_flow_id[] array but keep separate rfs_filter_count and
rfs_expire_index values.

The old work could fire after the copy but before efx_free_channel().
That window covers the swap and efx_probe_channel() for every copied
channel. If it does, __efx_filter_rfs_expire(old) removes filters from
the NIC and does:

				channel->rps_flow_id[index] = RPS_FLOW_ID_INVALID;
				channel->rfs_filter_count--;

The rps_flow_id[] write lands in the shared array. The decrement and the
rfs_expire_index update go to the old channel, which is freed right
after.

The live channel's rfs_filter_count then stays above the number of
filled rps_flow_id slots. That breaks the invariant in net_driver.h:

 * @rfs_filter_count: number of accelerated RFS filters currently in place;
 *	equals the count of @rps_flow_id slots filled

Only efx_probe_filters() resets the count, so the ethtool
rfs_filter_count stat and the expiry quota calculation would stay
inflated.

Would cancelling each old channel's filter_work right after
efx_stop_all(), before the clone loop, close this window? The same
ordering exists in efx_siena_realloc_channels().

>  		}
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023134214.322796-1-congei42%40163.com
