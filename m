Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348732;
	b=5phewTcKLplffoYQZts72Q2hAIEu7PqktB/rziFtgVFKTXwDZdwDDJqBivqDu6/KQZCe
	 FodOHOYo3+r3iiUlytg4nXuGdWY+rg0cy/aQ6K9V3OGdj81pdoaEbW6OofsEW3fJngFR9
	 KyJvsY4GJFAOumHhkK6IiWqwNNQVK2zSFy8P8rBaxHS1YfNhKse3pNZd9kJwgYxGNdfAC
	 N7Az+c5sy4c3DrCXjgb2JKjgmwlSWkr9ijTqfFM33oWBV+S8I1NsUy1YTWvzegbhanY4y
	 9SAyVjDX2BiJNzaEmQACeR5bR3td1B707gbH8KTeVrtYDxp4L8cq5Z4JvD7qwx/g64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348732;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dN5drd0uqfbH4uOQyrJ9U/vgopKZp89w0mBihZ58l2Q=;
	b=V9FUVwjw+yl1XG5ZGtUW0swB9nMgAg9c3WE3fjFpb5X3FDTo1xpHNLSKApvu6UnpxI1X
	 le2xskNpwVu9NQRzK+rPCo5ZSUheIxAKhjJkGusaNq9V2hK307sPEpDGC4fPHbrj6YKUo
	 rkIJnetLhpOxu0AB2/BeFX8E8j4zC990HbJ9Fx3KHcyf7MHZ2O9VYQHb1Xfr9Q4vXn8pZ
	 uKuB8VicI/d9soF26gV/TmCmDbvwldjtVsoqJmwfoesHPHlLiDIl2I5KgtLlFjFkfgBoe
	 ZeFrUkTFNvS0QbszodKDAtzKDyM8vcJkxFoLPrZZMRVmS3aVCpDJylC82wLd1NDBX6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V2/5aS/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C9606A31D;
	Fri, 30 Oct 2026 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2/5aS/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4241F00A15;
	Fri, 30 Oct 2026 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348732;
	bh=dN5drd0uqfbH4uOQyrJ9U/vgopKZp89w0mBihZ58l2Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V2/5aS/wEwMKQ8FNPwF1svPr0VW0QaFcBZJ2Ep6YnNIlRvZYSDHM0D9wrhEE4Yy4X
	 miHFpLZBPgJEX57ONaJ8OyHnDlcJwaRCW+mkEdC1BwUZcdzXpF4ru+t/uhZp4zFquf
	 7yCoCPDhb19HSjOyR+o+7EMIQz50qSlyPLuMEbPozJkRxeAeK98mFwcy6ogsJWZc6X
	 T80971Eb3WKb4rRhgOtjh+Pgx1k/FRaAGwPuJZeDUzSwxRt/aUCXdbrXNjFxUPUg+8
	 ypCQPPXhj6bBFUNGVkKfbjgwO0YSfjRRuxbf4LftfNLLGAOcj5df0ymeHiVn23/yBy
	 2hUzi8teHyk5w==
Subject:
 Re: [PATCH net 4/5] net: dsa: b53: reject conflicting mirror destinations
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 08:25:30 +0000
Message-ID: <179334873083.3134.3549069956742693590@kernel.org>
In-Reply-To: <20261027202230.3539646-5-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-5-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Only one capture-control read is checked; the other register
  reads in the mirror helpers still ignore errors.
- [Medium] The new check in b53_mirror_add()
  (drivers/net/dsa/b53/b53_common.c:2553-2558) treats MIRROR_EN and…
- [Medium] b53_mirror_add() ignores the results of both hardware writes
  and always returns 0: the source-mask write `b53_write16(dev,…
- [Low] The commit message justifies the b53_mirror_del() hunk with
  "Clear the capture-port field when the final source is removed so a…

Pre-existing issues:
- [Medium] b53_mirror_add() does not reject a second mirror rule for the
  same source port and direction.

--

net: dsa: b53: reject conflicting mirror destinations

This commit makes b53_mirror_add() read B53_MIR_CAP_CTL before it touches
the source masks. If mirroring is already enabled toward a different
capture port, the new rule is rejected with -EOPNOTSUPP and an extack
message. b53_mirror_del() now clears the whole CAP_PORT_MASK field along
with MIRROR_EN once both source masks are empty.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 0871a10d8cbc7..b8a7b380bac87 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  		   struct netlink_ext_ack *extack)
>  {
>  	struct b53_device *dev = ds->priv;
> -	u16 reg, loc;
> +	u16 reg, loc, cap_ctl;
> +	int ret;
> +
> +	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
> +	if (ret)
> +		return ret;
> +
> +	if ((cap_ctl & MIRROR_EN) &&
> +	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Only one mirroring destination is supported");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
This check uses only MIRROR_EN and CAP_PORT_MASK in B53_MIR_CAP_CTL. Can
that register hold stale state that this kernel never programmed?

B53_MIR_CAP_CTL, B53_IG_MIR_CTL and B53_EG_MIR_CTL are only accessed in
b53_mirror_add() and b53_mirror_del(). Neither b53_setup()->b53_reset_switch()
nor the bcm_sf2 setup paths initialize them.

b53_switch_reset() only does a soft reset for is539x() and
BCM58XX/BCM583XX, plus a reset GPIO when one is wired:

    b53_switch_reset_gpio(dev);

    if (is539x(dev)) {
        b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, 0x83);
        ...

On chips like BCM53115/53125/53128, BCM5325/5365, BCM63xx or BCM5301x
without a reset GPIO, mirror state left by a bootloader or a previous
kernel survives. kexec is one example: dsa_switch_shutdown() never calls
port_mirror_del, so the old kernel's tc mirror rules stay in hardware.

If MIRROR_EN is left set, every rule to a different port fails with "Only
one mirroring destination is supported", even though no mirror rule is
installed.

Adding and then deleting a rule to the stale destination may not clear
it either. b53_mirror_del() clears only BIT(port), and it clears MIRROR_EN
only when both source masks are empty. Leftover source bits for other
ports keep MIRROR_EN set.

Before this patch the destination was simply overwritten. Should the
mirror registers be reset during setup, or should the driver track
installed rules in software?

[ ... ]

> @@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  	reg |= BIT(port);

[Severity: Medium]
This is a pre-existing issue and wasn't introduced by this patch.
b53_mirror_add() accepts a second rule for the same source port and
direction. What happens to the remaining rule when one of the duplicates
is deleted?

dsa_user_add_cls_matchall_mirred() passes every matchall mirror rule to
the driver without a duplicate check. Each tc prio gets its own matchall
tcf_proto, so two rules A and A' (port 1 ingress to port 2) can share one
hardware bit.

Deleting A clears BIT(1) in B53_IG_MIR_CTL. If no other source remains, it
also clears MIRROR_EN and CAP_PORT_MASK. A' is still reported as offloaded
but does nothing in hardware.

A later rule C (port 1 ingress to port 4) then passes the new check, and
A' traffic goes to port 4.

mt753x_port_mirror_add() and qca8k_port_mirror_add() reject duplicates
using software masks:

    if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
        return -EEXIST;

The new check assumes MIRROR_EN reflects the live rule set. Would b53 need
similar tracking?

>  	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
>  
> -	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
> -	reg &= ~CAP_PORT_MASK;
> -	reg |= mirror->to_local_port;
> -	reg |= MIRROR_EN;
> -	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
> +	cap_ctl &= ~CAP_PORT_MASK;
> +	cap_ctl |= mirror->to_local_port;
> +	cap_ctl |= MIRROR_EN;
> +	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>  
>  	return 0;

[Severity: Medium]
Both b53_write16() results here are ignored, and 0 is always returned.
Can a failed write leave the hardware out of sync with what DSA has
recorded?

b53_mdio_write16() can fail before the target register is written, either
from mdiobus_write_nested() or with -EIO from b53_mdio_op(). SPI and SRAB
writes can fail too.

Suppose the source-mask write succeeds but the B53_MIR_CAP_CTL write
fails. MIRROR_EN stays clear, but dsa_user_add_cls_matchall_mirred() still
adds the rule to mall_tc_list because 0 was returned. A later rule to
another destination passes the new check and redirects the leftover
source. That is the redirect this patch is meant to prevent.

The final B53_MIR_CAP_CTL write in b53_mirror_del() is also unchecked. If
it fails, MIRROR_EN and the old capture port stay set with no sources, and
the new check rejects every other destination.

Should these writes be checked, with the source bit rolled back if the
capture-control write fails?

>  }

[ ... ]

> @@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
>  
>  	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);

[Severity: Medium]
The commit message says the patch will "propagate a failed
capture-control read rather than making the decision from uninitialized
data". This capture-control read is still unchecked, though. Is that
intended?

The b53 backends leave *val unchanged on error. b53_mdio_read16() returns
before assigning it:

    ret = b53_mdio_op(dev, page, reg, REG_MII_ADDR_READ);
    if (ret)
        return ret;

b53_spi_read16() only assigns on success.

reg is reused here. If this read fails, reg still holds the other
direction's B53_IG_MIR_CTL or B53_EG_MIR_CTL word, and that word is written
to B53_MIR_CAP_CTL unconditionally. The source bits land in CAP_PORT_MASK,
and the MIRROR_FILTER bits land in BLK_NOT_MIR/MIRROR_EN.

That usually clears MIRROR_EN while rules remain. A later rule to a
different destination then passes the new check in b53_mirror_add() and
silently redirects the remaining sources.

b53_mirror_add() has the same problem, and there reg is uninitialized:

    b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
    reg |= BIT(port);
    b53_write16(dev, B53_MGMT_PAGE, loc, reg);

If that read fails, stack garbage ORed with BIT(port) goes into the
source-mask register. That can mirror arbitrary ports or set
DIV_EN/MIRROR_FILTER. MIRROR_EN is then set and 0 is returned.

Later deletes only clear BIT(port). The stray bits keep MIRROR_EN set, so
the new check rejects every other destination.

The earlier reads in b53_mirror_del() that set loc_disable and
other_loc_disable are unchecked as well. Should all of these reads be
checked?

>  	/* Both no longer have ports, let's disable mirroring */
> -	if (loc_disable && other_loc_disable) {
> -		reg &= ~MIRROR_EN;
> -		reg &= ~mirror->to_local_port;
> -	}
> +	if (loc_disable && other_loc_disable)
> +		reg &= ~(MIRROR_EN | CAP_PORT_MASK);

[Severity: Low]
This isn't a bug, but the commit message says:

    Clear the capture-port field when the final source is removed so a later
    rule can select a new destination.

Is this hunk needed for that? The new check in b53_mirror_add() only
applies when MIRROR_EN is set, and b53_mirror_add() always rewrites the
field:

    cap_ctl &= ~CAP_PORT_MASK;
    cap_ctl |= mirror->to_local_port;

The old reg &= ~mirror->to_local_port already cleared the field whenever
it held to_local_port. Could the commit message call this a cleanup
rather than a requirement?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027202230.3539646-1-florian.fainelli%40broadcom.com
