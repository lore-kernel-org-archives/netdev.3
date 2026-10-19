Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430933;
	b=4TG+1l9JOeT1+a/1ICn/bYcqDP+KJDnvl1RZM57Ox/JUszslMY+gP1G7bpn5qgUvT5vk
	 q98e8q8xega4zMaHuW4KdfS1sPV43tLwS7YHeOdlUfHIQkTpTeZPoH0iI+sgNujZbFIox
	 snaSOEjCzISEi4ud9V2CzR2eKz7AG5uxhUJ2k8XJ8VhcJPg1E/pATPI6FcDM/y3uyHzFA
	 DLCSkMW49OZ6P67G8I09fzgTH4zt02jCeo6jAV0lYOVwplQaD34wkc6KFXShoCHe3PEY5
	 dznP2n+OYC+bYEX2MyX0npV+l1v4ilZtagDj3NKL3BaSL1TKJvCXp7uP0Nm14/0Vzaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430933;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dliaXstf3K3hpFahkZm0VAS+ySnc8omsj37vCzjs6yI=;
	b=gErjG/Ih1RrWfHTldqoo9J30meQ7vLvX3XnakmhsIfGbkGCOYrdoz0y7vmtoJQG0D+AN
	 zAt3xvuwkV0pIphOU61nlKJgxjeVjK2Jr3qn9xapVK/N6cDJ55Um7Dza2Tv+L9a1LW9w+
	 iqcRh0hVJ79enfI3MvERxlLwCzxaXVXg3sFmyqa7ixJpb1m7eawLTRjkOX5pTsquPDu/D
	 XeASXxhD8X6IFWme3hgBdaovJBDUq5UBXgFdN3JZ/yEGI9UM55lve0Dg+BLE1XM1fqLQg
	 Pr4w8DcBJ4P9+b75Sww2Hcs9H8cHt/qgGmcr4fHsZxyDjXIlh22mtVXv0KhYviFV93Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtzMmqux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DE60A261A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtzMmqux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1501F000D4;
	Mon, 19 Oct 2026 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430933;
	bh=dliaXstf3K3hpFahkZm0VAS+ySnc8omsj37vCzjs6yI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GtzMmquxisJB08FAAog4nPAoTislfpPi2o1WD26xln1gDGEF4JalyrWbztkKobe9l
	 8GlV+P/d8iQyScColHXR+hJGOyGZ02ppy9LP+GwCxcerA/Vnj3x1UKajvUehf8Nrcb
	 jmGJulo8vkxqPmzxaccVGYog2KeJdxGAby4S90ygeA5+OT0sMG+IKT1crGmshkACvF
	 PHco5+NIELAAtjlOgABVvi/zslBaZU9VkQj1cDmJyNVczpUhXNWlxFcT1pXZNNYqzT
	 q1ErZgQj7Uon0jnmtA1tLSilgPBtVX+5m40rFWcGyjSMzb8eJxKQV5MrxdkM2wjFoV
	 Ihh7rM/nXqNKQ==
Subject: Re: [PATCH net-next v5 12/14] net: ethernet: cortina: Release partial
 RX frames on stop
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:52 +0000
Message-ID: <179243093210.3135.6481358173986954956@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-12-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-12-b5c9e2f7b8a3@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit 'net: ethernet: cortina: Release partial RX frames
  on stop' fixes a regression introduced by 06937db21ee3 ("net:…
- [Low] The commit message describes the bug only as "leaking every page
  already attached to the frame".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but gmac_stop()
  calls hrtimer_cancel(&port->rx_coalesce_timer) (line 2229) as its…

--

net: ethernet: cortina: Release partial RX frames on stop

This patch makes gmac_stop() free a partially assembled RX skb with
napi_free_frags() before it clears port->rx_skb. The discarded frame is
counted as rx_dropped under rx_stats_syncp, using the irqsave update
helpers.

> A NAPI poll can retain a partially assembled frame across invocations. The
> stop path clears that pointer without releasing its fragment references,
> leaking every page already attached to the frame.

[Severity: Low]
Is "leaking every page" an accurate description of the unfixed behaviour?
gmac_stop() only clears port->rx_skb, so napi->skb still holds the partial
skb. After a reopen, the first good SOF gets that same skb back:

gmac_rx()
  gmac_skb_if_good_frame()
    skb = napi_get_frags(&port->napi);   <- stale napi->skb

gmac_rx() then resets frag_nr to 0 and runs:

    skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
    skb->len += frag_len;
    skb->data_len += frag_len;

This overwrites frags[0] and sets nr_frags to 1, so the old page
references are lost. Meanwhile len and data_len keep growing from their
stale values.

At EOF, this uses the stale length:

    frag_len = frame_len - skb->len;

When frame_len is at least the stale len, the skb reaches napi_gro_frags()
with a data_len larger than the bytes actually in its frags. When the two
are equal, it carries the old frame's payload.

When frame_len is smaller, err_drop frees the skb with napi_free_frags()
and nothing leaks. If the device is removed instead of reopened,
free_netdev()->__netif_napi_del_locked() also frees napi->skb.

Could the commit message say that a malformed skb could reach GRO, and not
only that pages leak?

[ ... ]

>     Assisted-by: LLM
>     Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Medium]
Should this have a Fixes: tag? Commit 06937db21ee3 ("net: ethernet:
cortina: Make RX SKB per-port") added port->rx_skb = NULL to gmac_stop()
without a call to napi_free_frags().

Before that commit, the static assembly skb survived a stop/open cycle,
and the next SOF in gmac_rx() called napi_free_frags() on it. Since that
commit, a partial frame left over at stop stays in napi->skb, and
napi_disable() does not touch it.

06937db21ee3 has its own Fixes: 4d5ae32f5e1e tag, so it is probably in
stable trees. The other fixes in this series also carry Fixes: tags.
Perhaps:

Fixes: 06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port")

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index d4e90aa97d220..843423187f8da 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2224,12 +2224,19 @@ static int gmac_open(struct net_device *netdev)
>  static int gmac_stop(struct net_device *netdev)
>  {
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
> +	unsigned long flags;
>  
>  	hrtimer_cancel(&port->rx_coalesce_timer);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
rx_coalesce_timer be re-armed after this cancel? The RX interrupt is still
unmasked at this point. It is only masked later, by
gmac_enable_irq(netdev, 0) and free_irq().

An RX interrupt can land anywhere in that window, including while
napi_disable() sleeps. gmac_irq() then does this, with no check for a
stopping device:

	if (val & (DEFAULT_Q0_INT_BIT << netdev->dev_id)) {
		gmac_enable_rx_irq(netdev, 0);

		if (!port->rx_coalesce_nsecs) {
			napi_schedule(&port->napi);
		} else {
			...
			hrtimer_start(&port->rx_coalesce_timer, ktime,
				      HRTIMER_MODE_REL);
		}
	}

gmac_set_coalesce() sets rx_coalesce_nsecs to ethtool rx_coalesce_usecs *
1000 with no upper bound. The re-armed timer can therefore fire up to
about 4.29 seconds after gmac_stop() returns.

If the interface is reopened before then, gmac_open() calls
hrtimer_setup() on a timer that is still queued in the clock base. Would
that corrupt the hrtimer rbtree?

If the netdev is unregistered and freed instead, would
gmac_coalesce_delay_expired() then run container_of() on freed port
memory and call napi_schedule() on it?

This ordering goes back to 4d5ae32f5e1e, and the rest of the series still
calls hrtimer_cancel() first in gmac_stop(). Could the hrtimer be
cancelled after the RX interrupt is masked or after free_irq(), or be
cancelled a second time there?

>  	netif_tx_stop_all_queues(netdev);
>  	gmac_disable_tx_rx(netdev);
>  	gmac_stop_dma(port);
>  	napi_disable(&port->napi);
> +	if (port->rx_skb) {
> +		napi_free_frags(&port->napi);
> +		flags = u64_stats_update_begin_irqsave(&port->rx_stats_syncp);
> +		port->stats.rx_dropped++;
> +		u64_stats_update_end_irqrestore(&port->rx_stats_syncp, flags);
> +	}
>  	port->rx_skb = NULL;
>  	port->rx_frag_nr = 0;
>  	port->rx_dropping = false;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
