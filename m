Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483766;
	b=Wmqnfv/PiPuZHkv17PLDKOgDXnM8IL65yHWqeV4J+SnxtXbfgmRimiTtnNvHMq0imYyF
	 yv9FvDG0GWvbYgdXRf8YNb354uf7YnzlaKNnvZrceEM5y/wUqjc20DXKpIaOw53x84C30
	 TMWGUvYY1p0X0AF3wmq/fN6XFVxafqjmUxu0mhQrgPQcf7lFQTj2IdmvNN3ehcI91kT1V
	 shzf3iSaq4yhm9AsRIhKIp7ubymlfnlNb309LS3eZDavZdLq1cCkL1n9bMDKdxKGpi7jG
	 imDYS7vP7/lkSCvQlyE9V7Lt/snD5yCP5ZfZIGl4bShvKurOKCnDzzTs03DjUBHKbEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483766;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ykP+MwqA/l/YdXpyZZSFOFQEPMX5a/+ZQKH5JKL7Kd4=;
	b=J2iaeqeX1QdYgbz5ipgRNP4vzjU2/WHd1HML4rIb38E1Sl2BpV/9qXyH/TB8IFw8NZvI
	 77rnezvKorGqp4bwxWcXYrBUAeC94BMtEtxKTSzs3sa9xF3+YEihgjUu6/qnu4er4ARwA
	 UYY1bbnwKAy3bncp+CYGsQeAPf1ndmKfWTPKeG2Br4NMvgCELYB/eCt4pOXv5JRrhVTIG
	 jJnV31PGiwnf0cuYs2hF9gDJ1jYwn00WpMLxHAjjHME+Nj81TybHXV7iEdOgvEcYKeQkj
	 hkww0pV6Rt5MFBIm8iFOFxJOwA88Xk2vHUmMhp0JZZULglRkVw8/ML5Xn97cw2fQpNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtmKAUHZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EB606A32D;
	Sat, 31 Oct 2026 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtmKAUHZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2071F00A1C;
	Sat, 31 Oct 2026 21:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793483765;
	bh=ykP+MwqA/l/YdXpyZZSFOFQEPMX5a/+ZQKH5JKL7Kd4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NtmKAUHZGWOTr4/8sBfHtMsD6iJhTcXz/mwTb1j7N1LZr2mh3s0DrUwpkx5wfSJ3g
	 3e3UmrhV4jlaA25sk1KivPQMq+ruPvnZSiV+FZOKh8hTkZ7mXnse2dmCyKfw9SI5L3
	 IJf9fYbfAYulsXM5Ygdafa1zGcpsUzIqWKvsqkWC92Lh10TvDA2N4nPHEOmhVOC7Pn
	 gbLzRJuffyehLPPRNT8e9efDGc8OEwxloVapNEU67YWtM7bYIAHQq6bdUL53dQrrpH
	 sNA1XdaDWRZ1Qd9suMhvd671KtDEZme95nnwxY9kRhAxcGEFcfjSb0449ffMNMnrzP
	 euylZRLNLy8xw==
Subject: Re: [PATCH net v3 6/8] net: dsa: b53: reference count shared mirror
 source bits
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 21:56:04 +0000
Message-ID: <179348376420.3131.8153125267393893230@kernel.org>
In-Reply-To: <20261030211617.288562-7-florian.fainelli@broadcom.com>
References: <20261030211617.288562-7-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a per-port software counter of mirror source
  references (struct b53_port::mirror_count[2]).
- [Low] At this commit, the first-reference path in b53_mirror_add()
  (b53_common.c:2573-2582) ignores the return values of b53_read16(loc),…

--

net: dsa: b53: reference count shared mirror source bits

This commit adds a per-port, per-direction reference count for the b53
mirror source bits. The hardware bit is programmed on the first
reference and cleared only when the last reference is removed. A
delete with no matching reference is ignored.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 75033b28100ec..b16167c9510b8 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c

[ ... ]

> @@ -2559,6 +2560,11 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (*mirror_count) {
> +		(*mirror_count)++;
> +		return 0;
> +	}
> +

[Severity: Medium]
Can mirror_count get out of sync with the hardware after a suspend/resume
on bcm_sf2?

On resume, the switch is reset and setup runs again:

drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_resume() {
    ...
	ret = bcm_sf2_sw_rst(priv);
    ...
	ret = bcm_sf2_cfp_resume(ds);
    ...
	ds->ops->setup(ds);
    ...
}

bcm_sf2_sw_rst() does a watchdog chip reset, or a reset_control
assert/deassert on BCM7278. That puts B53_MIR_CAP_CTL, B53_IG_MIR_CTL
and B53_EG_MIR_CTL back to their defaults. Later in the series,
bcm_sf2_sw_setup() also calls b53_mirror_init(), which writes 0 to all
three registers.

The only place dev->ports[] gets cleared is in b53_reset_switch():

	memset(priv->ports, 0, sizeof(*priv->ports) * priv->num_ports);

and only b53_setup() reaches that, not bcm_sf2_sw_setup(). Unlike CFP
with bcm_sf2_cfp_resume(), nothing replays the mirror configuration.
DSA also keeps the tc matchall filters installed across resume.

So after resume, a port can have mirror_count[dir] >= 1 while its source
bit and MIRROR_EN are both clear. If a new matchall mirror filter is
added on that port and direction, the destination check passes because
the registers read back as 0. It then reaches the early return above
and reports success without programming any register.

Wouldn't the filter show as offloaded while nothing is mirrored, until
every filter on that port and direction is removed?

Before this patch, every add did the full read-modify-write, so adding a
filter after resume reprogrammed the hardware. The later patches
"net: dsa: b53: harden mirror register programming" and "net: dsa: b53:
fix mirror port encoding on BCM5325 and BCM5365" keep this early return.

>  	if (ingress)
>  		loc = B53_IG_MIR_CTL;
>  	else
> @@ -2573,6 +2579,8 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  	cap_ctl |= MIRROR_EN;
>  	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
>  
> +	(*mirror_count)++;
> +

[Severity: Low]
At this commit, b53_mirror_add() ignores the return values of
b53_read16(loc), b53_write16(loc) and b53_write16(B53_MIR_CAP_CTL), and
then increments mirror_count anyway.

If one of those bus accesses fails, the count says the source is
programmed when it isn't. Every later add on that port and direction
then takes the if (*mirror_count) shortcut. Will that keep the source
unprogrammed?

In b53_mirror_del(), the count is also decremented before the unchecked
clear.

The later patch "net: dsa: b53: harden mirror register programming" in
this series fixes this. It checks every read and write and only
increments mirror_count after programming succeeds. On the delete side
it logs failures, since .port_mirror_del returns void. A failed clear
there leaves a stale bit with a count of 0. That can be recovered,
because the next add goes from 0 to 1 and reprograms the bit.

>  	return 0;
>  }
>  EXPORT_SYMBOL(b53_mirror_add);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030211617.288562-1-florian.fainelli%40broadcom.com
