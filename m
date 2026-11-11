Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438652;
	b=LjNxjMZg6gwNaicBSklGrcFqiZB5AxgTQfDvhcT9BgEfp3U+TKsV2r0fvPyhuEos3LVB
	 cFx24I7pY9t2Aib5P8cg57UHaR6c+zWspCeaL+5ERat0nxXG+iPYYJ6qUp6GFmpxZCFZ0
	 D9ZqCLfygoxIJ86F7xDmWfQOMGtpUjmMGwcFIePBmeXMIYPDNfzbFE55Ta30oICiWWnQH
	 AvljVSNlGmMW+xVbbosUksnzXFkrRyy+Q+Pp0nJHp05xBXDFJRyRpG9baFkfPrDSRZPX/
	 oZ53VGLn0fEkjAPQRCwfI20/YFxnQTy3yyoCuAIddlH8ZI6rZT13hn3eocIsC5rYxdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438652;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Qmf3dlF/mh5Uu/MOrc1xdUS8BOKsmyUIekhWTkTJJ4g=;
	b=oTVTxIzOV7nCfaiRQ55AYMGPV7DxEJWFlxrbPAwrbS6CVxEjV9dSZ5GHhbLpzCrK177u
	 yV/3HZc9o6KWoj5bd0MjKpQv6rH+khgeMSXpMcRVSvpYxh9EdNFyAyLDQuXUZqFiNMr9V
	 mppKQ5yAaYgJCkRhDknO8v0d8jN2EuGLQig3pwv2/O6Vymrmz5itQw6nPGwyRTMaowZLb
	 58MAJlqAU9UzC9K91g83igByBmOHpL6I92Ii3dE5KSGV8otuF4hogzW/5YEVvBd53rXSu
	 VbeJ0MPkZOny41eqiqkSQuPnBlNdJz8w7acg7UF36pCaW/5P7aOMcQbKZQ442lsGXWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es0SFyZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E8606A88C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es0SFyZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866A31F00A0B;
	Wed, 11 Nov 2026 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438652;
	bh=Qmf3dlF/mh5Uu/MOrc1xdUS8BOKsmyUIekhWTkTJJ4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Es0SFyZSsRDVhOMAIvUqBSpyPAWLbi91qVHWaJKn8VVai1ZvmXYb+0+xIW04M7Pn3
	 /0dZyYbwrP2R5mS5reZXajtXqShWZCw88c6cK3eMmzAZH3wTZG1Xf83HB+poS520bL
	 qbJScxacN4N8/R00COk5KfllAuY5yhkkbY+XUKALmMMXAoO3sujvTJsD66hfWUUYCE
	 4z1HRK0BB//E7/rtedTyirDesr+8UIWtU3/QR4sltetBIiLTb0ZxQAAc72AE9wNOSf
	 d1XC7ue9YqHmIzhTSidQGJ8q+GkLwu0LF/uWqFdiPhGDiZ3YOHtQxazcedAzxa7V34
	 Q74jwgkmGXX1w==
Subject: Re: [PATCH net-next v7 15/18] net: ethernet: cortina: Scope RX
 statistics updates
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:51 +0000
Message-ID: <179443865110.2199510.1541652335335896780@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-15-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-15-9c32a1a46aec@kernel.org>
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

- [Medium] net: cortina: softirq-unsafe tx_stats_syncp update in
  gmac_clean_txq()

--

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2870,6 +2879,9 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  	}
>  
>  	port = netdev_priv(netdev);
> +	u64_stats_init(&port->tx_stats_syncp);
> +	u64_stats_init(&port->rx_stats_syncp);
> +	u64_stats_init(&port->ir_stats_syncp);
>  	SET_NETDEV_DEV(netdev, dev);
>  	port->netdev = netdev;
>  	port->id = id;
>

[Severity: Medium]
Initializing tx_stats_syncp here is correct. On 32-bit lockdep
kernels, though, it also exposes an existing tx_stats_syncp writer
that runs from the wrong context.

gmac_clean_txq() bumps port->tx_frag_stats[nfrags] under a plain
u64_stats_update_begin(&port->tx_stats_syncp). When called from
gmac_start_xmit(), this runs with BH disabled, so lockdep records the
seqcount as used in softirq.

gmac_stop() also reaches it, via gmac_cleanup_txqs() and
gmac_clean_txq(), but from process context with BH and preemption
enabled. The last frames queued before the interface goes down are
normally still in the ring at that point. If one of them was a
multi-fragment frame (nfrags > 0), the tx_stats_syncp update runs
preemptible and with softirqs enabled.

On 32-bit non-RT, that hits the lockdep_assert_preemption_disabled()
check in __u64_stats_update_begin(). With the lockdep map now
initialized, it should also produce an inconsistent
IN-SOFTIRQ-W -> SOFTIRQ-ON-W report for tx_stats_syncp.

There is a real hazard behind the splat too. While the sequence count
is odd, nothing stops a softirq on the same CPU from reading TX stats
through gmac_get_stats64(). That reader would spin forever in
u64_stats_fetch_begin().

The other counters in these paths are already protected:

- The rx_stats_syncp update in gmac_stop() uses
  u64_stats_update_begin_irqsave().
- The ir_stats_syncp update in gmac_clean_txq() is done under
  geth->irq_lock.

Should the tx_stats_syncp update get the same treatment? Or would you
rather disable BH around gmac_cleanup_txqs() in gmac_stop()? Either
way, I think the fix belongs in this patch or just before it, since
the u64_stats_init() added here is what lets lockdep start tracking
this seqcount.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
