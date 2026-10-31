Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483763;
	b=hsFAcpZHBn417EHHxpQE/pTYRE/E7ytPNqTTSFuLSLp5GMAqexfhBt2uORdbuYCaCL+a
	 NoDdsh8gQHn6RLMRBP0DnkpSROgNlVwvFnD+XcH/11GTlcFr9nYoN2cax3Bc0h1mIUFsl
	 uWbPsH2qT2cfhzmSiLTnxKB/SshixSOanlDklLj7vbynhHnu1kU2K6U9/O2t11LnVHM4g
	 kuR0laYtNnaj1vz2Rd4MVdkn5kgHAmlOIqoyXDm3LF/kfzzPMnfc85CEWsDhTG02P2lTV
	 x+eR5o8RBHc04slk2lkpIPTITYz63uywmgdore7n6zoTvlGGR6Vho+T26XSJJ9MH4uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483763;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4lCF8ue4fqRbdp2FWw4PAof35U3+geJ4LVeQ3vq2dF4=;
	b=nwP0kPU+uBSoDqgj1kw0Rva2kfZQ45xb/39Sgj3fQq/Ri8kCMdF1A78sqUMT8PGU/MaR
	 hQmohQzvf0jkfhSXyhFaCApwM9OadY6dHtWVLdV+kXbov1vdg1ZneassJhPFirxfzkske
	 PYOf62ujalEEFhaqB6elC0rOb6UcSOXr1yveYv9Dg2CcjROfYt6LgwVKGEzu2xjAXbyPf
	 /XFH/f0mOTuatE4MqawVhi8YtnhEnovVxC7ZZohQ12EnomKyv/fVanI/UwCxjeHmZYu4v
	 Gd8aiqcuqk4581WiVA8IDIQKfGhxGaCM78LLtcwk+OkA58i5H9tRPAlGhfThHEVTF/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJqpWoLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B038606A323;
	Sat, 31 Oct 2026 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJqpWoLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEE41F00919;
	Sat, 31 Oct 2026 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793483762;
	bh=4lCF8ue4fqRbdp2FWw4PAof35U3+geJ4LVeQ3vq2dF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YJqpWoLSYbzOYNtJ1AlfZeUGfInQv3fcMIFVyOKNnj7tm6l9SAT+YjGWp8eX8H/qw
	 Lgw5/QORUPjK61ahMDV2QOj6LbTwW+HvPHJfYy8OQyUxsTHZv8c2GiSGDliIJ143I7
	 3LVBduhJtrtWdPu+apl5O9CjJL6EVO0tiYaxuyKRae89uLEYZmSfPd5C9/GLnzkQTu
	 eM+x2DHsA8uaboNroknYwKHtLN4CENFKx5ym/weAR4DIP+6KGc+GK/Y/B/PQhLhVSF
	 zGAvlBYj6D6CiNdiuZ4WmpPKhgw3z8giIuM6/lisBxUf6AqPdHlD8uLM4cWuLLY2th
	 eGU/5Sq8TvyIQ==
Subject:
 Re: [PATCH net v3 4/8] net: dsa: b53: reject conflicting mirror destinations
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 21:56:01 +0000
Message-ID: <179348376172.3131.11440720201294156466@kernel.org>
In-Reply-To: <20261030211617.288562-5-florian.fainelli@broadcom.com>
References: <20261030211617.288562-5-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the new conflict check in b53_mirror_add()
  (drivers/net/dsa/b53/b53_common.c:2553-2557) decides whether rules…
- [Low] The commit message says the patch propagates a failed capture-
  control read, but only the B53_MIR_CAP_CTL read in b53_mirror_add()…

Pre-existing issues:
- [Medium] Each per-port, per-direction mirror source bit is shared by
  every tc matchall mirror rule on that port and direction, but it is…

--

net: dsa: b53: reject conflicting mirror destinations

With this patch, b53_mirror_add() reads B53_MIR_CAP_CTL first. While
MIRROR_EN is set, it rejects a new mirror rule whose destination differs
from the one already programmed. b53_mirror_del() now clears the whole
CAP_PORT_MASK field along with MIRROR_EN when the last source is removed.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index c38e8c5838bd8..378f47e7250cd 100644
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
Can leftover hardware state make this check reject a valid first rule?

The check only looks at MIRROR_EN and CAP_PORT_MASK as read back from
B53_MIR_CAP_CTL. It doesn't look at B53_IG_MIR_CTL or B53_EG_MIR_CTL.

At this commit, nothing in the setup path writes any of these three
registers. The only writers are b53_mirror_add() and b53_mirror_del().
Also, b53_switch_reset() doesn't soft-reset every chip.

Suppose a bootloader, a previous kernel (kexec or warm reboot) or an
earlier driver bind left MIRROR_EN set with capture port X. The first tc
mirror rule to any port other than X would then fail with -EOPNOTSUPP and
"Only one mirroring destination is supported", even though no software
rule exists. Before this patch, the add path just overwrote the stale
destination.

The reverse case also seems possible. Stale source bits with MIRROR_EN
clear pass this check, so those ports end up mirrored. The same stale bits
also stop b53_mirror_del() from ever clearing MIRROR_EN.

The later patch "net: dsa: b53: harden mirror register programming" in
this series seems to fix this. It adds b53_mirror_init(), which zeroes all
three registers from b53_setup() and bcm_sf2_sw_setup(). It also bases the
occupancy test on the source masks:

	if (((reg | other_reg) & MIRROR_MASK) &&
	    (cap_ctl & cap_mask) != cap_port) {

Could that be folded into this patch, so this commit doesn't regress on
its own?

>  
>  	if (ingress)
>  		loc = B53_IG_MIR_CTL;
> @@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
>  	reg |= BIT(port);
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
>  }

[Severity: Low]
The commit message says the patch will "propagate a failed
capture-control read rather than making the decision from uninitialized
data". Are the other register accesses here still unchecked?

Just above this hunk, the source mask read is not checked:

	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
	reg |= BIT(port);
	b53_write16(dev, B53_MGMT_PAGE, loc, reg);

reg is an uninitialized stack variable. On failure, b53_mdio_read16() and
b53_spi_read16() return without writing *val. A failed read therefore
writes garbage back into B53_IG_MIR_CTL or B53_EG_MIR_CTL.

Both writes are unchecked too, and the function returns 0 either way. DSA
then keeps a mall entry that the hardware never accepted.

The source bit is enabled before B53_MIR_CAP_CTL is written. If the
capture-control write fails, MIRROR_EN can stay clear, and a later rule to
a different destination would pass the new guard.

b53_mirror_del() has the same pattern. If its B53_MIR_CAP_CTL read fails,
reg still holds the other-direction source mask, and that value is written
into the capture control register:

	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
	...
	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);

The later patch "net: dsa: b53: harden mirror register programming" in
this series seems to fix all of these. Every read and write is checked,
B53_MIR_CAP_CTL is programmed before the source bit is enabled, and the
delete path jumps to an error label instead of writing back garbage.

> @@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
>  
>  	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
>  	/* Both no longer have ports, let's disable mirroring */
> -	if (loc_disable && other_loc_disable) {
> -		reg &= ~MIRROR_EN;
> -		reg &= ~mirror->to_local_port;
> -	}
> +	if (loc_disable && other_loc_disable)
> +		reg &= ~(MIRROR_EN | CAP_PORT_MASK);

[Severity: Medium]
This isn't a bug introduced by this patch, but each per-port,
per-direction source bit is shared by every matchall mirror rule on that
port and direction, and it is not reference counted.

dsa_user_add_cls_matchall_mirred() in net/dsa/user.c allows several
identical rules, and each one is tracked as its own mall entry. Earlier in
b53_mirror_del(), deleting any one of them clears the shared bit:

	reg &= ~BIT(port);

With this patch, if that was the last bit, MIRROR_EN and CAP_PORT_MASK are
cleared as well. Does the remaining rule then stop mirroring in hardware
while it is still installed? And would the new guard in b53_mirror_add()
then accept a rule to a different destination?

The later patch "net: dsa: b53: reference count shared mirror source
bits" in this series seems to fix this. It adds mirror_count[2] to struct
b53_port, so the hardware is programmed only on the first reference and
cleared only when the last one goes away:

	if (--(*mirror_count))
		return;

>  	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
>  }
>  EXPORT_SYMBOL(b53_mirror_del);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030211617.288562-1-florian.fainelli%40broadcom.com
