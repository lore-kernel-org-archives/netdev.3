Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430853;
	b=tCL/eJx26Ss53Wwq5seNUHS2z+A9ZZlPR93h8KH5prHhbd3CfBmqaYRXn3sWXGgACqMq
	 c9jKUUKDQpgearSwBSFCAlv3vZLoe9YVaQ81dFubLyGCoKwNpOrj1NaoFcPPOstKoC9cU
	 Rk0iU/GKCtd+uFvDKTC0TLB1peVWaTgFad4gaFJS4bbJuwZLVwxUPW85RXcfjRlh6qQ9b
	 KYOakIDCnlXz8pA36/xpUTwGgSgodW3lY/NjuXhbz74XcKHlQ33CG5sExzi3oqKtL/edW
	 Lt41Xm+mkc4vi2GoNsyBfq/KCdEf6hv8Vq0dk8Ry1vMTezuStUOz19MZcffiXKKWX9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430853;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yugBpGGxGGEc6RbqJpkbtgb6PEZsTe7c84zW38n+L+k=;
	b=Fma97dFegJE3eL0LD1iibG/yErUasAa6GiUUl2DCMqRGHOaOsFlGldPTiojm/R2GDL9H
	 UZ3uTSHriUvIH4U5Kso4APGyL0ZN+H32UVEmwXhcgg1VOQGbHl8pAORxlCkXc4HqcMCwF
	 1Aqf7JWlz9pf0WO5rBGfflSsBut272+ihPAFAYqDCquS462IDKD32jWJg0hSMrJpXHAkl
	 kcEg6Bgf+a6VBy5uHPCxX6nZqleh2gLzWQLrMlO1uf6OVlEfwaLalwYHLndJKHhGUAM2T
	 cvLKOBhJopckdUXVcGRUK/CqMa4gd/+gn+NKGQXQm3hHmScXQQ+rxGJU0MOTbSC7GUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apP7P1JO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC08606A32D;
	Wed, 11 Nov 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apP7P1JO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA31F00A06;
	Wed, 11 Nov 2026 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794430853;
	bh=yugBpGGxGGEc6RbqJpkbtgb6PEZsTe7c84zW38n+L+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=apP7P1JOgRHAaJRS2NtEcZEGKyhQrLL2TFz8vgTi+ZcVBQpYA48YgDhYja0NjUvFn
	 5h1AmY1Dya53gfjc4TJCasiaMRX5Yw6kNF9gFJXr+Qx5RRjGRqPB9XedoUHcMVvCUI
	 /HH/d9bSa3UNR2Rjz3w2IZs49828+eQZfJWJOiffc9bhpua2P1QWzaiIhHKp5ABtp6
	 iunxX9h1/S9E9aZ5kqO1Om2Km6foS0Sg5JnGJOPKJ7b+JcLvaCl6f5g1X+z0a+PXax
	 QZuNG1GWPrKf4qYEPK0eQSf1UtHtlIUHD8aIpOLgk+Cz4KKzvshyZWR2NMHun5tNRk
	 5AKxV/nYcDoPA==
Subject: Re: [PATCH net-next v12] net: reduce ARFS flow updates by checking
 LLC affinity
From: netdev-bot+sashiko@kernel.org
To: nashuiliang@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, sdf.kernel@gmail.com, daniel@iogearbox.net,
 bobbyeshleman@meta.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 21:00:52 +0000
Message-ID: <179443085204.2199510.12725312671048285646@kernel.org>
In-Reply-To: <20261109030042.2956-1-nashuiliang@gmail.com>
References: <20261109030042.2956-1-nashuiliang@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] set_rps_cpu() (net/core/dev.c:5281-5284) decides whether to
  skip ARFS hardware steering by comparing next_cpu with old_cpu.

--

net: reduce ARFS flow updates by checking LLC affinity

This patch makes set_rps_cpu() skip the ARFS ndo_rx_flow_steer() call
when the CPU recorded for the flow and the new target CPU share an LLC.
rflow->cpu is still updated. A new sysctl, net.core.arfs_llc_affinity,
turns this on and off, and it is off by default.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3b60b15e2175e..0011cec296402 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -5273,6 +5277,12 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
>  		    !(dev->features & NETIF_F_NTUPLE))
>  			goto out;
> +
> +		if (static_branch_unlikely(&arfs_llc_affinity) &&
> +		    old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> +		    cpus_share_cache(old_cpu, next_cpu))
> +			goto out;
> +

[Severity: Medium]
Does rflow->cpu reliably show which LLC services the hardware queue the
flow is arriving on?

get_rps_cpu() takes old_cpu from the hash slot in the arrival queue's
table:

	tcpu = rflow->cpu;
	...
		rflow = set_rps_cpu(dev, skb, rflow, tcpu, next_cpu, hash);

That value is software bookkeeping, and other flows can share the slot.
The new check runs before the cpu_rmap_lookup_index() /
skb_get_rx_queue() comparison. So it can suppress ndo_rx_flow_steer()
even when the arrival queue's IRQ/NAPI CPU is in a different LLC from
next_cpu.

The skip path still reaches:

	WRITE_ONCE(rflow->cpu, next_cpu);

sd_llc_id equality is transitive, so every later migration inside that
LLC would skip again. Could the flow then stay on a far queue
indefinitely?

Here are some ways rflow->cpu can drift away from the real hardware
queue:

- After a successful steer from queue A to queue B, packets still in
  flight on A go through set_rps_cpu() again and hit:

		if (hash != READ_ONCE(tmp_rflow->hash) ||
		    next_cpu == tmp_cpu)
			goto out;

  This records next_cpu (LLC X) in A's slot, but A's IRQ may be in LLC
  Y. Two later cases then hit the new skip, with the application on
  another CPU in LLC X. One is a flow whose hash collides with that slot
  and which RSS delivers on A. The other is the original flow coming
  back on A after rps_may_expire_flow() let the driver drop its rule.
  No failure is needed for this to happen.

- The existing goto out paths still record next_cpu without moving the
  hardware queue. These are ndo_rx_flow_steer() returning rc < 0 (for
  example -ENOMEM, -EPERM or -EPROTONOSUPPORT from
  mlx5e_rx_flow_steer()), a target queue with no flow table, and an
  active colliding filter. Before this patch the next migration retried
  the steer. With the sysctl on, migrations within the same LLC never
  retry.

- irqbalance or an admin moves queue A's IRQ to another LLC. cpu_rmap
  gets updated, but the skip happens before cpu_rmap is consulted.

- A driver drops all of its hardware rules without touching
  rps_dev_flow, for example mlx5e_arfs_disable()->arfs_del_rules().

In each case NAPI would process the packets on a remote LLC, and they
would then go through the RPS backlog to the application's CPU with an
IPI.

This also seems to conflict with the new text in
Documentation/networking/scaling.rst, and with the similar wording in the
commit message:

  "since the application's cache locality is preserved either way"

The reported ~99% drop in mlx5e_rx_flow_steer calls cannot tell avoided
redundant updates apart from steering that is wrongly suppressed.

Would it be more accurate to compare next_cpu with the CPU servicing the
arrival queue instead of the previously recorded rflow->cpu? For example,
that could be smp_processor_id() for non-threaded NAPI, or the CPU tied
to the queue from skb_get_rx_queue(skb).

>  		rxq_index = cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
>  		if (rxq_index == skb_get_rx_queue(skb))
>  			goto out;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109030042.2956-1-nashuiliang%40gmail.com
