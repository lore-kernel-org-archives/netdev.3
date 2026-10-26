Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023873;
	b=f+ktnaoWbc7dYWtpylmniemCi2EDNUcBXPX20CHNzlT9PTHw7Q3jO6IqjHoZdF7Z/7jp
	 TUpRLaTujpztiALKVttYDpacHkcQcuDPgI1Dsa2E65DUKNiZxZ/8nTKtq4OVew7XpOUFT
	 3XlKpGpL3JztA3d8p47NcyTOyw7LN8V5Am5x+D5HSzmH7IESwbb5y7ZjAhZNlNcBSiVRy
	 LaaG8hUGmFG+eGPBHrrMmQ1HgEdGJDmdguY77QHslYfHeYJyMhLkjMqGuAhD2Cac5MF5n
	 ecyupvn8I9NLDKW19aKdbTMo6MVomeUsA9pCZz7n4v6N5Y/2bC5bhnmkZTqGtEmFyYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023873;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BpPlCyW8MdukDPLDPoCBq82lXRwMXzHMiBUUHDnO06E=;
	b=1aKJSNooIcccQp9hT1607cuXKq5HlOCfv7ZJkvxhxMFNsn5MN3AAMiI6Yay/yZF7ePAK
	 5qqEMXDXLH+vfeTEFbZncRA47lZJFQazcrD0NLbuFbcaLZpHS6SDfXUHHs3DKJzmQ1bZ3
	 vTYFddwe4rI0aSE02f3uMjK/1U3a1Uk2ITIzJutBeHuF00E+gTvkOWknaS6vcD4P2aJmi
	 8uS0lIVPPOwPzUlOgQsJKIPnu2HLzB4ZP6Oi0Vb82rll6wy09v6JT1SETwHGLff6bdMLl
	 QDVFRnorXD8qOIjVwQgNJ2S83yS0v82unATVAtPELQqXEyJnGs9niXwFJQvDmZynBig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2qzC504;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CA606A336;
	Mon, 26 Oct 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2qzC504
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152511F031E4;
	Mon, 26 Oct 2026 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023872;
	bh=BpPlCyW8MdukDPLDPoCBq82lXRwMXzHMiBUUHDnO06E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2qzC504KeoyuAp8rjboPSm/y/7l8ynmvGfsmXS5S39FeXCV8NQ2evyzWdMS5H2Mn
	 Meo63FrQKk7CnNjncoJwNsQrce6wP2zvYS+zEhYyUO2yIsgZaXw7Ukmv2m0P1l/YMp
	 RSismZDgdpgIBT9XRIsp13c8VOw+s4S4JUwAOJ08Nf+QXcj4VnfgVnjmX2sW6AssCJ
	 pw9LIHlgTlSwyPGhArunpzCOb47DnEbc6XfndgsFRychSu+9tTpvF4N/pbD/Fruzki
	 dZeN6FRFEOOAmQ4ObDYD/rZiCt9ar+7aS4Y7Jp8ECXrC4of2MbtlPH1NXExN26aXYd
	 kpOFmqwbXcGPQ==
Subject: Re: [PATCH net] sfc: fix use-after-free of filter_work in
 efx_realloc_channels()
From: netdev-bot+sashiko@kernel.org
To: congei42@163.com
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 14:11:11 +0000
Message-ID: <179302387159.3134.8640588618973558922@kernel.org>
In-Reply-To: <20261022133927.3860186-1-congei42@163.com>
References: <20261022133927.3860186-1-congei42@163.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] sfc: missing flush of efx_filter_rfs_work() in
  efx_realloc_channels()
- [Low] The commit fixes a use-after-free in efx_realloc_channels() and
  efx_siena_realloc_channels() that a CAP_NET_ADMIN user can trigger…

--

sfc: fix use-after-free of filter_work in efx_realloc_channels()

The patch cancels each old channel's aRFS filter_work before
efx_realloc_channels() frees the channel. Without this, an ethtool -G ring
resize can leave a self re-arming delayed work pending inside a freed
efx_channel. The same fix is applied to efx_siena_realloc_channels() in the
Siena driver.

> Signed-off-by: Sicong Huang <congei42@163.com>

[Severity: Low]
Should this patch carry Fixes: tags? The only trailer is Signed-off-by. A
CAP_NET_ADMIN user can trigger this use-after-free with ethtool -G. Without a
Fixes: tag, stable and backport tooling cannot tell which trees need the fix.

The work stays pending because of the unconditional re-arm at the end of
efx_filter_rfs_expire() in drivers/net/ethernet/sfc/efx_channels.c:

    schedule_delayed_work(dwork, 30 * HZ);

That re-arm came in with commit 6fbc05e59163 ("sfc: do ARFS expiry work
occasionally even without NAPI poll"). The resize path never cancels that
work.

The Siena copy in drivers/net/ethernet/sfc/siena/efx_channels.c came in with
commit 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)").

Would something like this be appropriate?

Fixes: 6fbc05e59163 ("sfc: do ARFS expiry work occasionally even without NAPI poll")
Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)")

Another option is to split the patch per driver, so that each half has its
own Fixes: tag.

[ ... ]

> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -896,6 +896,9 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
>  	for (i = 0; i < efx->n_channels; i++) {
>  		channel = other_channel[i];
>  		if (channel && channel->type->copy) {
> +#ifdef CONFIG_RFS_ACCEL
> +			cancel_delayed_work_sync(&channel->filter_work);
> +#endif
>  			efx_fini_napi_channel(channel);
>  			efx_remove_channel(channel);
>  			kfree(channel);

[Severity: High]
Does this close the whole window, though? filter_work is not the only
deferred work that holds a pointer to an efx_channel.

When aRFS steers a flow, efx_filter_rfs() claims a slot in
efx->rps_slot[] and schedules req->work. That work runs
efx_filter_rfs_work() in drivers/net/ethernet/sfc/rx_common.c, which
looks up the channel once at entry:

    struct efx_channel *channel = efx_get_channel(efx, req->rxq_index);

It then calls efx->type->filter_insert(). That call can sleep on
efx->filter_sem and the filter table locks, and can wait for MCDI.
After filter_insert() returns, the work goes on using the cached
pointer. It reads channel->rps_flow_id and updates
channel->rfs_filter_count and channel->n_rfs_succeeded or
channel->n_rfs_failed. It may also call
__efx_filter_rfs_expire(channel, ...).

Suppose a request is queued just before efx_stop_all() and is still
inside filter_insert() when efx_realloc_channels() swaps
efx->channel[] and kfree()s the old channel. Those accesses then hit
freed slab memory.

There is a second effect. The counter update lands in the old channel
rather than the copy, so the replacement channel's rfs_filter_count no
longer matches what was installed in the hardware table.

Nothing on the resize path waits for efx->rps_slot[].work. That covers
efx_stop_all(), efx_soft_disable_interrupts() and the teardown loop,
so cancelling filter_work alone does not stop this. Siena has the same
efx_filter_rfs_work() in drivers/net/ethernet/sfc/siena/rx_common.c
and the same gap in efx_siena_realloc_channels().

This patch already fixes the old channel being freed under a work
item. Could it also wait for in-flight aRFS insertion work before the
old channels are freed? One option is to flush each
efx->rps_slot[i].work after NAPI is stopped and before the swap. Or is
there something that already serialises efx_filter_rfs_work() against
the resize that I am missing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022133927.3860186-1-congei42%40163.com
