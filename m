Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322A447250
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181857; cv=none; b=G9ZmTFMnlcdrcz70nW14D/SvAw4YYvPjSRKLyiII3UdkKXu9dO5MAq42B8Dv/eF00XxA3m+7OdbcM84SMQ7cPoIZyZGEE6iNjWqosQ/VWM5iWt0tAmXr0ExtiGxkSOBcO8UrMWjwZ3GObmd7PfBjoisCPWiOs3E7xuKSXuHrVdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181857; c=relaxed/simple;
	bh=E218LKQCjZxRpqK3RpeE/LcjEKq18ly/EeizpzrOy1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrg83Za010Q2mvJ9gojgI7zPQU/eDVCYFFGR1W+E93qkjdzQs3bsk7C3QUszdatOVe4AnfccE/PEuYs2CtRuK9SmC/BaG5ukPwCaE2CwinQO0C5ZRlYqo3fhfgJe8YrUddtCV22mq6cmbgGYfoJBLE70Tb+JZBDJqcB76rjZ7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdFM5SFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdFM5SFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864411F000C4
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181850;
	bh=kzilHhUfm0myD2eC9Uhgr5xramTNvO26FwdeKaiUQGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZdFM5SFaMr0lidkPHTLJzYPb9UCKVYGntQIlT/1yICTXv2G7nBELK/7VCPHpXo/lF
	 5Nv6dqs9qQNKCROqBH5i5cCAVPI8YD1BZzMzSkRqkmRVxVHsmnU4s9s5tf+ux+9vZM
	 KyOFHGsAwPrCjaKhH/6OkNQ+hcYEvIr6L8ORCN2thH7WiCScctJsdIIVNTwe1y7HON
	 1YeJ3viKF/OwXSAawWAn+cKn7pc1LfsFehKxyztFlBxiXOjc1ErED88K/dl3f5h54v
	 5is3QlO089pq3FS8kn5bLTG0mmQsP9uoK98XxWe/m1RJmXXM1CDMZz6A+VHwZlYUaJ
	 0erChWuSgj9mg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso308989e87.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:17:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwVOZOrD8hWBG270K4PKdMSdwL3CylAR1Fp2/VxCun08jAGgZfhsJMLdooIntbgNdAvn2w+jXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLal/X3v0nLCL6K3kgTQPg9AeMcg0QrVHIG7spY5njc+zfOgVXn
	3cl9EsGZT1+B1Ky2rMjYdc0UjGEyQZiLp4Wzr++BWroU2RNVVCtWnqLd7FoOl7iq8LTw0KnSRY2
	XyWBJ4bWPrvzizxUai13yOIzNgpOMsZA=
X-Received: by 2002:a05:6512:6ce:b0:5bc:ebb7:6a4e with SMTP id
 2adb3069b0e04-5be50a3d7d4mr178201e87.21.1792181849314; Fri, 16 Oct 2026
 13:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <c43a5bf1-0cf9-4c68-b905-e9b615e2c9b2@yahoo.com>
In-Reply-To: <c43a5bf1-0cf9-4c68-b905-e9b615e2c9b2@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:17:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqvVAkCuxBWywHoDPO8uHxzREXr3b6QusYMO7Zt00=KA@mail.gmail.com>
X-Gm-Features: AclHuK9bheQH6yDpRSNqmAHDvBeqqVl1H5mFyuLm2TKYU8BVmxm-sHvDPi1KSKo
Message-ID: <CAD++jLmqvVAkCuxBWywHoDPO8uHxzREXr3b6QusYMO7Zt00=KA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 8/9] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:08=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> The family D receiver latches on the DISABLE -> HSGMII edge in SDS_MISC
> rather than on the value, and it will not latch until the MAC at the
> other end of the trunk has brought its own half of the link up. If it
> does not latch, the trunk reports 2.5Gbps/Full on both sides but moves
> no frames: the CPU MAC transmits, the switch CPU port counts no octets,
> and there are no CRC, alignment or FIFO errors.
>
> The two ends can be seconds apart, e.g. on an IPQ5018 board:
>
>   5.27  rtl8365mb: configuring for fixed/2500base-x   <- pcs_config()
>   7.72  ipq5018-gmac-dwmac eth0: configuring for fixed/2500base-x
>   8.02  ipq5018-gmac-dwmac eth0: Link is Up - 2.5Gbps/Full
>   8.56  SerDes latches
>
> pcs_config() runs seconds before the far-end MAC even starts
> configuring, so a single edge driven from there is not enough: the
> receiver has nothing to latch onto yet. Neither is pcs_link_up(),
> which is seconds early for the same reason. phylink does not help
> either - it never calls rtl8365mb_pcs_get_state() for this port in
> the first place, since mb->pcs.poll only arms phylink's own poll for
> in-band links, and this CPU port is a fixed link.
>
> There is no local signal that predicts when the far-end MAC will
> bring up its half of the link (bit 8 of the SDS link-status word
> does not change ahead of it), so the work cannot wait for it; it can
> only tell afterwards, from the link-status bit, whether an edge took.
>
> The far-end MAC starts when its conduit is brought up, which DSA
> reports through ->conduit_state_change(), so an episode of re-latch
> attempts starts there. pcs_config() only arms the work, and starts an
> episode itself if the conduit is already up. The work re-arms itself
> after each edge; the next run checks whether the edge took, rather
> than waiting on a poll that will not come. When the conduit goes down
> the work is stopped, so a link without a far end is not reported as
> lost and not parked every 10 s.
>
> Each attempt (park for 20 ms, then restore the target mode) is
> performed by a work item rather than from the callbacks, because the
> attempts have to continue for seconds after they have returned.
> pcs_config(), pcs_disable(), teardown() and conduit_state_change() are
> serialized by a new sds_cfg_lock and cancel the work before touching
> SDS_MISC or restarting it, so an attempt never interleaves with a
> reconfiguration. Before parking, the work reads the link status itself
> and does not park if the receiver has already latched, since the
> condition that queued it may be stale by the time it runs; it then ends
> the episode instead.
>
> Attempts are spaced about 1 s apart and capped at
> RTL8365MB_D_SDS_RELATCH_MAX_TRIES (15) per fast episode. After the last
> attempt one more run checks whether it took and only then warns that
> the SerDes did not latch. The work then keeps driving one edge per
> RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL, so a far end that comes up late
> or a link that drops again is recovered without a reconfiguration,
> at a bounded cost of one 20 ms park per interval.
>
> Once the receiver has latched, the work keeps checking the link every
> 10 s (RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL). If it finds the link down
> outside a reconfiguration, e.g. after the far end reset its PLL, it
> logs that and starts a new episode.
>
> For family D, pcs_config() keeps the masked update of SDS_MISC and saves
> the value it wrote as the target the work restores. The work parks and
> restores with masked updates over the same fields, so other bits are
> never touched.
>
> The work reads the SerDes link status through the SDS_INDACS indirect
> access window, a multi-register ADR/CMD/DATA sequence that the PCS
> callbacks also use, so those sequences are serialized by a new sds_lock.
> The SDS_MISC updates need no extra locking: each one is a single regmap
> read-modify-write.
>
> The work is only armed for 2500base-x, the mode the re-latch edge was
> observed with. It is cancelled from pcs_disable(), from pcs_config()
> before SDS_MISC is touched, from conduit_state_change() and from
> teardown(), and disabled by a reboot notifier and by a devres action.
> disable_delayed_work_sync() is used in the latter two so that a late
> pcs_config() cannot queue the work again, and so that it never outlives
> the PCS or the driver data and does not touch the bus while it is shut
> down. dsa_switch_shutdown() does not stop the PCS, which is why the
> reboot notifier is needed.
>
> If restoring the target mode fails, the lane stays parked. The mode
> field in SDS_MISC tells so, and the next run of the work puts it back
> before doing anything else. If the work is stopped before that run, the
> lane stays parked until the next pcs_config().
>
> No chip uses family D before the last patch of the series, so this code
> is unreachable until then.
>
> Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
> Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

It's a lot of comments and commit message in this patch,
and it's pretty hard to understand. But FWIW it looks good
and maintainable to me:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
