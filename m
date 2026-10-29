Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306394;
	b=pyGujeq3sjW8YfLshBGsFmH6coKgedQ34hbxHex1vq/6/SpEuj2uuP4mmeYpQr4iWSlW
	 QZG3Q3i2hLvCmsrBLwGNX4rGFE22SVBut8EXAMtuMyBmINlVOwZufk61/IdcX7Ge3u3nU
	 SQxhdtfiZmm+yc4ZuM9xmuX0PSK7PoR55Voa5mK4IcNTPOlKj9UjRouQUoJtu3GnPHmlg
	 OVXJptFr5NGJE1VlpPAIU98grqXHqcLprytdrnDkI/8muqrDODixX6lPC63ZPrOjx+i56
	 jgJ6YLQSKva8q/zrGM/z4DfQI7SSh+NHv07s3h3eGit9yhvu6MGLgv0tkkqjzDLbd1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306394;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mjJsHvgkPVbsV8pOVDoaMOHsvMLGkg1B7ioq26UXLtE=;
	b=pK9yKAsEzNEeENGQr2a3ULSyhtt0+MCQB1yeEx7NQP932588uKpHlr5X9/0ugNFBY3Fb
	 0+vwuhP1ZqKfIJIpj0w7BQXGISsN5yjANyodYV1owDTK/15f6hphQLiIzy8yGn/I7wJl/
	 JRj16zdw++/eKxAjAO75O9m8FiM9DGnhrN8kr1Dr0L2g2ImIUUhvEmbmZ5PbqIE6u3kl2
	 DFHLR01DQZ8sBFja7HUmVFz4gLPoNE5QvRwKsMSRTjknBA+dq0ZL7+JVI9xbwv67mpqGC
	 G1VOkSQ84Zv+pbEv9JQxhz6RtvKRYMjAQ7FM9pHJWsbn6mTn82j0QZd8SxulyH0AWAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHF0NyVg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C05606A32C;
	Thu, 29 Oct 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHF0NyVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D81F01826;
	Thu, 29 Oct 2026 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306394;
	bh=mjJsHvgkPVbsV8pOVDoaMOHsvMLGkg1B7ioq26UXLtE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QHF0NyVg9bEAumkFm6imYEhZQ/gBSYz6nw3MpMhhG4uChI3Fhq0qjJJHZcrmiJAZQ
	 WMypGnI2zn/mfU/6tLbkJOYRWjDSreqJVs0fwe5KZl8/mhKXtcR588kn4TLxgdK030
	 S9HWggKIXuGbninl36njVPc+q9d6/qdEwZCCnpHk6hsu1crMk/iY7mLrtmy9HrQv+K
	 psEz9gaVG1rUrgeQ2MIhsotce20OlwVIuZkarTxyWRyKDo0es743OuehOqj32mEsN9
	 SCMkZKQmm1cuCtP1AFbno/f3ekC/V+xWl6LWFjvLI1x9K0XmC5ZbGej2s6HYSR1Qqw
	 gnxY5+Hvh9Zsw==
Subject:
 Re: [PATCH net v3 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 20:39:52 +0000
Message-ID: <179330639281.3134.16708275740775166450@kernel.org>
In-Reply-To: <20261026203742.3198673-3-florian.fainelli@broadcom.com>
References: <20261026203742.3198673-3-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new code in b53_phylink_mac_link_up() sets speed = 2000
  for any port where dsa_is_cpu_port() is true on BCM5301x.
- [Medium] The fix covers fewer chips than the regression it reverses.
- [Low] b53_regs.h documents PORT_OVERRIDE_SPEED_2000M (line 103) and
  GMII_PO_SPEED_2000M (line 149) as "BCM5301X only, requires setting…

--

net: dsa: b53: restore the NSP IMP port 2 Gbps mode

This commit forces 2 Gbps mode and flow control on fixed-link CPU ports of
BCM5301x and Northstar Plus (BCM58XX) switches in b53_phylink_mac_link_up().
It restores the PORT_OVERRIDE_SPEED_2000M bit, which b53_force_port_config()
clears when the 1 Gbps fixed-link speed is applied. Clearing that bit
caused queue discards and TCP retransmissions.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 0880310c9ce3f..743fc04da0a48 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -1663,9 +1663,15 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
>  	}
>  
>  	if (mode == MLO_AN_FIXED) {
> -		/* Force flow control on BCM5301x's CPU port */
> -		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
> -			tx_pause = rx_pause = true;
> +		/* Force flow control and 2Gbits/sec on BCM5301x and NSP CPU
> +		 * ports
> +		 */
> +		if ((is5301x(dev) || dev->chip_id == BCM58XX_DEVICE_ID) &&
> +		    dsa_is_cpu_port(ds, port)) {

[Severity: Medium]
Does this actually force 2 Gbps on BCM5301x CPU ports that are not the IMP
port?

The condition matches any port where dsa_is_cpu_port() is true. However,
b53_force_port_config() only handles 2 Gbps correctly when
port == dev->imp_port, which is 8 on 5301x/58xx. Other ports go through
the GMII override register:

b53_force_port_config() {
    ...
	} else {
		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
		val = GMII_PO_EN;
	}
    ...
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;

	switch (speed) {
	case 2000:
		reg |= PORT_OVERRIDE_SPEED_2000M;
		fallthrough;
    ...
}

PORT_OVERRIDE_SPEED_2000M is BIT(6) in the IMP register layout. The GMII
per-port register has these two bits the other way round:

#define   GMII_PO_EN			BIT(6) /* Use the register contents */
#define   GMII_PO_SPEED_2000M		BIT(7) /* BCM5301X only, requires setting 1000M */

On a non-IMP CPU port, case 2000 just sets GMII_PO_EN again and falls
through to 1000M. GMII_PO_SPEED_2000M never gets programmed.

This looks reachable in-tree on bcm53015-meraki-mr26.dts and
bcm53016-meraki-mr32.dts. On both boards port@5 is the CPU port, with
ethernet = <&gmac0> from bcm-ns.dtsi and a 1000/full fixed-link, and gmac0
runs with BGMAC_FEAT_FORCE_SPEED_2500. Most other boards that use port@5
as a CPU port have no fixed-link, so mac_link_up is never called for
them.

The Fixes commit b6a8a5477fe9 cleared BIT(6), not BIT(7), on the GMII
register, so it never wiped a GMII_PO_SPEED_2000M set by the bootloader
on port 5. Whether these boards still have a mismatch depends on what the
bootloader set. Either way, this statement in the commit message is only
true for the IMP port:

    Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.

Should the speed override be limited to port == dev->imp_port, with the
commit message reworded? Or should b53_force_port_config() use
GMII_PO_SPEED_2000M for non-IMP ports?

[Severity: Medium]
Should BCM583XX_DEVICE_ID be covered here too?

The clear in b53_force_port_config(), added by b6a8a5477fe9, runs for
every is58xx() chip:

	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;

is58xx() includes BCM58XX, BCM583XX, BCM7445, BCM7278 and BCM53134. The
restore added here only covers is5301x() and BCM58XX_DEVICE_ID.

BCM583XX (Cygnus/BCM11360/Omega, through the brcm,bcm11360-srab,
brcm,cygnus-srab and brcm,omega-srab compatibles in b53_srab.c) seems to
have the same topology as NSP:

- In bcm-cygnus.dtsi, port@8 is the CPU port, with ethernet = <&eth0>
  and a 1000/full fixed-link.
- eth0 is a brcm,amac with no phy-handle, so bgmac_probe() in
  bgmac-platform.c sets BGMAC_FEAT_FORCE_SPEED_2500.
- bcm911360_entphn.dts enables both &eth0 and &switch.

If the Cygnus IMP uses the same 2 Gbps mode as NSP, the IMP 2000M bit
would still be cleared on every fixed-link link-up while the AMAC stays in
its high-speed mode. Wouldn't that leave the mismatch the commit message
describes in place on that SoC?

Could the clear and the restore use the same chip predicate?

> +			tx_pause = true;
> +			rx_pause = true;
> +			speed = 2000;

[Severity: Low]
This isn't a bug, but b53_regs.h still says the bit is 5301x only:

#define   PORT_OVERRIDE_SPEED_2000M	BIT(6) /* BCM5301X only, requires setting 1000M */

GMII_PO_SPEED_2000M carries the same comment. This change now sets
PORT_OVERRIDE_SPEED_2000M on BCM58XX IMP ports, and b53_force_port_config()
already clears it on all is58xx() chips. Should that comment be updated?

> +		}
>  
>  		b53_force_port_config(dev, port, speed, duplex,
>  				      tx_pause, rx_pause);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026203742.3198673-1-florian.fainelli%40broadcom.com
