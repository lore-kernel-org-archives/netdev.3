Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC513E4C75;
	Thu,  1 Oct 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875398; cv=none; b=fr4BYc9bDjFj2vjIlgiMwcxLqEtAHC9xwyymnb05QlcoI7YeItd8Y6V1jH1581n2p31raphDYGog6AHVyWqUPQ4a7Ftx34dLFyJFq/zG7WEGraRAwkO+6LWiQKrukd1Qk1KulvnXJn80Dr4BrKGoD/RDLWd7NYJBKlVup1kusBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875398; c=relaxed/simple;
	bh=SXn4T+ozck+cIFCMv70FphXxF9xVdpv/vALi6C1qnq0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poOJPIwAluygnrFIivrEBTxxsCVyv2NrK7L+25CpOYdxFh9U+QCysGUkeM457ypwdNAMUwHbylS3Lxk4uWb0edtQ4Tfe+mIWMIDEX37WvnkfyjRH7NQM2mopUUExLoasDfD0sCUFU4tZZZ9NBCpSkYP1LIIn0UL2A3GIcDFS3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byc1d4IN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byc1d4IN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6611F000FF;
	Thu,  1 Oct 2026 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790875397;
	bh=v91owQ3qllMRL7J86dqEzGCJbMk5nxT5/YsXOAlKUiA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Byc1d4INW5aIRaEq3/fE8VjQ7Nr+kmERXi20ZRlMLdClkTAxXKFDUKZQopjFA3Avq
	 VChspRWy0C53yiZK5swjdO7N35GaafAIq87qM1JXFhsLNQ52ZvxeJw9Agb0yFfRDa+
	 vX4CdIMT3DrnPVSG2hAv7J8YMEGdnuWMcHdKf7ccTl3yhDOIMreG1msQhoZqL1j2wj
	 9yLcP+heEkqFKJ8iqiISDyK5hZLAosmK7x1ySWeFgRRbe95XODl7c5MpjJQIx9Gize
	 rbVs1vpmMXrOVoKL+hI8SCUpVDZ72OBIYpBYVywUbJUHXuwkQpchujONuOnTUuzAax
	 mKZvSU3ZspFjw==
Subject: Re: [PATCH net-next] tap: report IFF_DETACH_QUEUE in TUNGETIFF
From: netdev-bot+sashiko@kernel.org
To: umangpokhriyall@gmail.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 17:23:16 +0000
Message-ID: <179087539624.434549.6585301310404315341@kernel.org>
In-Reply-To: <20260929142238.41742-1-umangpokhriyall@gmail.com>
References: <20260929142238.41742-1-umangpokhriyall@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tap_ioctl() (drivers/net/tap.c), TUNGETIFF now sets
  IFF_DETACH_QUEUE (0x0400) in the returned flags when q->enabled is…
- [Low] The commit message describes a user-visible bug: tap_ioctl()
  TUNGETIFF reports a detached macvtap/ipvtap queue as attached, and…

--

tap: report IFF_DETACH_QUEUE in TUNGETIFF

With this commit, tap_ioctl() sets IFF_DETACH_QUEUE in the flags that
TUNGETIFF returns when the macvtap/ipvtap queue is disabled. tun has
reported the flag this way since commit 3d407a80b62f.

> tap: report IFF_DETACH_QUEUE in TUNGETIFF
>
> tun sets IFF_DETACH_QUEUE in the flags returned by TUNGETIFF when the
> queue is detached, since commit 3d407a80b62f ("tun: Report whether the
> queue is attached or not"). tap_ioctl() returns only q->flags, so a
> detached macvtap or ipvtap queue is reported as attached.
>
> Cloud Hypervisor ran into this when checking queue state on macvtap.

[Severity: Low]
The message describes a bug that users can see, but there is no Fixes:
tag.

Commit 815f236d6227 ("macvtap: add TUNSETQUEUE ioctl") added queue detach
for macvtap. Since then, TUNGETIFF in tap_ioctl() has returned only
q->flags. Commit 3d407a80b62f later added IFF_DETACH_QUEUE reporting, but
only for tun.

If this is meant for net and stable, should it have a tag like this?

Fixes: 815f236d6227 ("macvtap: add TUNSETQUEUE ioctl")

If it is meant as feature parity for net-next, could the commit message
say so instead of calling it a bug?

> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index ff67d99deb39e..cb8ffb0c4a315 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -950,6 +950,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  
>  		ret = 0;
>  		u = q->flags;
> +		if (!q->enabled)
> +			u |= IFF_DETACH_QUEUE;

[Severity: Medium]
Can this break a read-modify-write of TUNGETIFF and TUNSETIFF on a
detached queue?

The TUNSETIFF case in the same function was not changed. It still rejects
any bit outside TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE) other than
IFF_NO_PI | IFF_TAP:

drivers/net/tap.c:tap_ioctl() {
	case TUNSETIFF:
		/* ignore the name, just look at flags */
		if (get_user(u, &ifr->ifr_flags))
			return -EFAULT;

		ret = 0;
		if ((u & ~TAP_IFFEATURES) != (IFF_NO_PI | IFF_TAP))
			ret = -EINVAL;
		else
			q->flags = (q->flags & ~TAP_IFFEATURES) | u;
}

Unlike tun, tap accepts TUNSETIFF again on an fd that is already bound.
Userspace can use this to change IFF_VNET_HDR or IFF_MULTI_QUEUE at
runtime.

With this patch, the following sequence now fails:

open /dev/tapN
  tap_open()                        q->enabled = true
TUNSETQUEUE(IFF_DETACH_QUEUE)
  tap_ioctl_set_queue()
    tap_disable_queue()             q->enabled = false
TUNGETIFF                           returns q->flags | IFF_DETACH_QUEUE
TUNSETIFF with that value           returns -EINVAL

Before this patch, TUNGETIFF returned exactly q->flags, truncated to
unsigned short. In its low 16 bits, q->flags only holds IFF_TAP,
IFF_NO_PI, IFF_VNET_HDR and IFF_MULTI_QUEUE. TUN_VNET_LE and TUN_VNET_BE
sit above bit 15. So writing the value back always passed the check above.

The commit message says:

    Report the flag from q->enabled, as tun does.

In __tun_chr_ioctl(), however, TUNSETIFF returns -EEXIST if the fd
already has a device attached:

drivers/net/tun.c:__tun_chr_ioctl() {
	tun = tun_get(tfile);
	if (cmd == TUNSETIFF) {
		ret = -EEXIST;
		if (tun)
			goto unlock;
}

So tun never had to handle its TUNGETIFF output being written back.

Should TUNSETIFF in tap_ioctl() mask off IFF_DETACH_QUEUE and
IFF_ATTACH_QUEUE? If not, should the commit message at least mention
this change in what userspace sees?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929142238.41742-1-umangpokhriyall%40gmail.com
