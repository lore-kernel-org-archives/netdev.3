Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656219;
	b=G3zYNCIu1Fr1wO/wnULRrTTENPvw0WaUP3+XIlbnjrK3VXMOYAd+/bc6mjnphygNyC12
	 CMZSG0UydYfqetNNfkHxCRJ6+TS4RNhGwfysg2FmYSISWeS7Ekyn4lrca9mnAlae6yo2L
	 4n6EDiumPs7dLAhdjL5qzA43vMOeyVh/qa5SIIoKmOzv3dLf9FpZO7W2OT/Nihfq+xVvD
	 RMSMbBetZmKWZah0XDqVs/7cIs4ngUoz3fgUXoj5HbeRiMfMEE8GtbGpgnm2IS67xUs0e
	 NZzjZ4Oy/YGs8qIGc9ZkBroWWsWi0wkqX5rvZ5ztsmDJN9gkH516MlHIo3wGLG4L+PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656219;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sVJ7WQ6Nb1Qj5W711R3RnpPciF9EixP+LpBJt68TLao=;
	b=meageSFfqulTJO2FW7QWMOFQpY9BE5A0UDzbu9eP3aiag03JcXxtW5D+ZottGiWEP9I3
	 Uug1dRW8A669UkXFkisG32MPm0h92NEAC4o6klltKZv1MIoupcSlEPHBkvlDmiK8ctsnN
	 l18ref5v8gAzEJcFWBU8Bq3zZ/5l+GHaoHNL6W2U7/pkuq8PZGeIvcpPm2jat2AOlbeSM
	 PiipuG3uJZKgy5Xmi2ITx74FyBvrLDY/MIEQMG2XbQTIX49XTOAbQoCLSlbdxpcMRulS/
	 uqn7+j2jx7hHVFwf4jS49mlqMCIeTGUhLaNOZXytwEBeWDKh9Ye4GsECLUI5yscGoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AnC0z/Cy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCF606A32F;
	Mon,  2 Nov 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnC0z/Cy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049251F00A16;
	Mon,  2 Nov 2026 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656218;
	bh=sVJ7WQ6Nb1Qj5W711R3RnpPciF9EixP+LpBJt68TLao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AnC0z/CyuZbIP8MYOTXbguTVy9YBlMQBArUUwFZ8kdhoVUnnqvQBJI1R/01FU+K1t
	 e75wJHVCWsDXSFXEODrxzW655AUiJ0bTP1YNf+niMc/GY4BJyh3zIwKIJGxaYKgXGo
	 WqfHMDVuQvMdASbx6Gi9PsV3iijmoThaUM7rBSnl+ZXX2xD3V57yBAK40Ew+v/3g6x
	 uUGGdsvsv+z7BY4jNQI7DeURJd35DwRKjG2ym21biplFmfkXfSMVp2/Uz1EWwFm/BG
	 OUuBvvwVwR0baHIwKN0IrZgthjXhHCujbG6kNO/hBf3bQIbC8czjLEJdQ3ggRk+l7W
	 CGfnVsAixxtyQ==
Subject:
 Re: [PATCH net v4 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 21:50:17 +0000
Message-ID: <179365621756.3131.9531361745901719210@kernel.org>
In-Reply-To: <20261029211540.4123250-3-florian.fainelli@broadcom.com>
References: <20261029211540.4123250-3-florian.fainelli@broadcom.com>
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

- [Medium] The new code in b53_phylink_mac_link_up()
  (drivers/net/dsa/b53/b53_common.c) sets speed = 2000 on every…

--

net: dsa: b53: restore the NSP IMP port 2 Gbps mode

On BCM5301x and NSP, fixed-link CPU ports now get forced flow control and a
2 Gbps speed in b53_phylink_mac_link_up(). The goal is to restore the
proprietary 2 Gbps mode on the IMP port. That mode was lost because the
fixed-link description reports 1 Gbps.

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
> +			tx_pause = true;
> +			rx_pause = true;
> +			speed = 2000;
> +		}

[Severity: Medium]
Does this set up 2 Gbps correctly when the CPU port is not the IMP port?

The check is dsa_is_cpu_port() rather than port == dev->imp_port, so a
fixed-link CPU port on port 5 or 7 also gets speed = 2000. Those ports go
through the GMII override register in b53_force_port_config():

drivers/net/dsa/b53/b53_common.c:b53_force_port_config() {
    ...
	} else {
		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
		val = GMII_PO_EN;
	}
    ...
	reg &= ~(0x3 << GMII_PO_SPEED_S);
	if (is5301x(dev) || is58xx(dev))
		reg &= ~PORT_OVERRIDE_SPEED_2000M;

	switch (speed) {
	case 2000:
		reg |= PORT_OVERRIDE_SPEED_2000M;
		fallthrough;
    ...
}

The two registers use different bit layouts in b53_regs.h:

#define   PORT_OVERRIDE_SPEED_2000M	BIT(6)
#define   PORT_OVERRIDE_EN		BIT(7)
...
#define   GMII_PO_EN			BIT(6)
#define   GMII_PO_SPEED_2000M		BIT(7)

So on the GMII register, the 2000 case sets and clears BIT(6), which is
GMII_PO_EN. GMII_PO_SPEED_2000M (BIT(7)) is never written. The port ends up
at 1 Gbps, and its 2 Gbps bit keeps whatever value it already had.

Some upstream 5301x device trees use port 5 as a fixed-link CPU port, for
example bcm53015-meraki-mr26.dts and bcm53016-meraki-mr32.dts. bgmac-bcma
sets BGMAC_FEAT_FORCE_SPEED_2500 for these GMACs, so the speed mismatch the
commit message describes would remain on those links.

The new comment and the commit message both say 2 Gbps is forced on
"BCM5301x and NSP CPU ports". Should this either be limited to
port == dev->imp_port, with the comment updated to match, or should
b53_force_port_config() use GMII_PO_SPEED_2000M for the GMII override
register?

>  
>  		b53_force_port_config(dev, port, speed, duplex,
>  				      tx_pause, rx_pause);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029211540.4123250-1-florian.fainelli%40broadcom.com
