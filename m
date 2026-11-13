Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549082;
	b=1i17SV+U+w1+LA7yzwhWBvgPrE8IXrQNGAEKSj9heBmk5/rgy6xmBTt0Z1rXMiU7N8b5
	 iYcbd7RDkaqEttgWY+SUSremTIGuKqKFKaE5SbJfmiygmmtQ0hANoJtuRXXqSBbN92jsA
	 awA/btjr7obnZVw0wIGtmkat/N4YRzJWOtmrXRyXfYCZikdx5wHbYX+GxOQ0IySZLznQ5
	 oDF679dxCu38zJ1RpAD/Qey5kfi05ZGbveMv5FstZmmYwJDEzgHKF3K4UbKClOYcNXYFT
	 ANth4UOz4RHpwekSd164KGvRTp5wRWHXzK9cpIkd6jgLQwt6O6iF0iJSileDLeZ77xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549082;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4+gJpbdVYnZWcGwsu+QNNC0Ehog/4gvo/sFO8ZNB4Gk=;
	b=s1yTt8GouGdUO+Nd0cYw6uDxU1gU3WGCF4n+wSvHohbWkETsrHgEF0NeyvIEEy5fSwat
	 RJEYHoCBXVXYfFcdc/UyDyc4aeP3+XAJ4TvRpgowMP5n55IA8eL3NrZKm/BdGpOUgYCVM
	 J+7ON0LxJtJNe/+4CtxRlyvrHARtETkNmfobMXQCX7eViV8clNFoB4O7G0HSqxtxOkno3
	 Qn/5+gcm3INaWaCQ5iAkyTKMH1vhD8FM5t3Dv+/F39W5LsbGcTfeg0yAwqeyzOuqllmu5
	 tCoMvXIQagBhWydElItkcO9Xu6T4FiEQOXIS0dFfmWJmaNqM6uU0xLWCSGaLS8rIjow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4rg+ZxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CA606A33A;
	Fri, 13 Nov 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4rg+ZxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E291F000C6;
	Fri, 13 Nov 2026 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549081;
	bh=4+gJpbdVYnZWcGwsu+QNNC0Ehog/4gvo/sFO8ZNB4Gk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i4rg+ZxH+vuNDlpV9PooTIGKopDu0K88b5ZE2XjT01qQD++0F9t9vDbuWKkjXzcqd
	 VRpVXwTX7hs1l3QVcNpj8Tzd9WpCHTHXg1E1y++d/1jgFmYcFwyjU6yne9lG1w9ZZx
	 MkGEo0Q3jVfnVAH7pV3HylRtHPqdV8RASKINTGcCxtLldv64RKiM/UTAUXXoz0tdQI
	 oSNJcSG6TMzNE7Uq7qjc12wApFQHanHUZW3zD/TICcKzgrjU23bwQJVuKZWHz3yXCr
	 Um02agI6g88SKHCSZLv3r3TxynoWvGu9DIUQ78B2cOge1Eprr9sCUbtTcyB9FwvFxN
	 /DyBlxYkb37lw==
Subject:
 Re: [PATCH net-next v3 2/3] net: phy: acx00: report receive statistics
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:20 +0000
Message-ID: <179454908057.2199510.9219088866030975682@kernel.org>
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-2-fbc6327c5be4@gmail.com>
References: <20261109-submit-acx00-phy-stats-v1-v3-2-fbc6327c5be4@gmail.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The receive-byte wrap modulus was measured on AC300 only, but
  the driver applies it to AC200 as well.
- [Medium] acx00_ephy_soft_reset() takes its 'final' statistics snapshot
  on the assumption that the EPHY has not been reset yet, but phylib can…
- [Medium] __acx00_ephy_update_stats() can only account for one hardware
  rollover between two samples (lines 204-208).

--

net: phy: acx00: report receive statistics

This patch reports the ACx00 EPHY receive frame, byte and CRC error
counters through the generic PHY statistics interface. The 32-bit
hardware counters are sampled from phylib's update_stats callback and
added up as wrap-adjusted deltas in 64-bit software totals. The hardware
baseline is invalidated around soft reset and power-off.

> diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
> index d19ba6d8069a4..9ab98f6174442 100644
> --- a/drivers/net/phy/xpowers/acx00.c
> +++ b/drivers/net/phy/xpowers/acx00.c

[ ... ]

> @@ -76,6 +78,30 @@
>  	(ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS | \
>  	 ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS)
>  
> +#define ACX00_PAGE9_RX_BYTES_HIGH_REG		0x19
> +#define ACX00_PAGE9_RX_PACKETS_HIGH_REG		0x1b
> +#define ACX00_PAGE9_RX_CRC_ERRORS_HIGH_REG	0x1d
> +
> +/*
> + * AC300 hardware testing confirmed that the receive byte counter wraps at
> + * 4,000,000,000 rather than 2^32.
> + */
> +#define ACX00_RX_BYTES_WRAP			4000000000ULL

[Severity: Medium]
This modulus was only measured on AC300. Does it also hold for AC200?

The single "X-Powers AC200/AC300 EPHY" phy_driver entry installs
acx00_ephy_update_stats() and acx00_ephy_get_phy_stats() for both
packages. __acx00_ephy_update_stats() never checks priv->is_ac300.

On AC200, every sample with a byte count at or above 4e9 is thrown
away. The packet and CRC-error totals also do not advance for that poll:

	if (ret || counts[ACX00_STAT_RX_BYTES] >= ACX00_RX_BYTES_WRAP)
		return 0;

Byte wraps are also folded modulo 4e9:

		count += i == ACX00_STAT_RX_BYTES ?
			ACX00_RX_BYTES_WRAP : BIT_ULL(32);

Suppose the AC200 byte counter really wraps at 2^32. Wouldn't
rx_bytes_total then lose 294,967,296 bytes per wrap? At 100 Mbit/s that
is about every 5 to 6 minutes.

Could the commit message and comment say whether AC200 was measured?
Alternatively, could the byte statistic be limited to AC300?

A related point: the commit message does not confirm that the hardware
byte counter matches the rx_bytes_total definition from the preceding
"ethtool: add PHY receive frame and byte totals" patch. That definition
counts the Ethernet header, padding and FCS, and excludes the preamble
and SFD. Has this been checked on hardware?

[ ... ]

> @@ -350,6 +493,10 @@ static int acx00_ephy_soft_reset(struct phy_device *phydev)
>  
>  	mutex_lock(&priv->state_lock);
>  
> +	acx00_ephy_snapshot_stats(phydev);
> +	priv->stats_active = false;
> +	priv->stats_valid = false;
> +

[Severity: Medium]
Can this snapshot run after the hardware has already been reset?

For SIOCSMIIREG on MII_BMCR, phy_mii_ioctl() writes the value to the PHY
first and only calls phy_init_hw() afterwards:

drivers/net/phy/phy.c:phy_mii_ioctl() {
    ...
		else
			mdiobus_write(phydev->mdio.bus, prtad, devad, val);

		if (prtad == phydev->mdio.addr &&
		    devad == MII_BMCR &&
		    val & BMCR_RESET)
			return phy_init_hw(phydev);
    ...
}

phy_init_hw() then calls acx00_ephy_soft_reset(), which takes the
snapshot while stats_valid is still true. If the reset cleared the page 9
counters, they now read below stats_last[].
__acx00_ephy_update_stats() counts that as one full wrap:

			if (count < priv->stats_last[i])
				count += i == ACX00_STAT_RX_BYTES ?
					ACX00_RX_BYTES_WRAP : BIT_ULL(32);

For example, CRC errors dropping from 5 to 0 would add 4,294,967,291 to
rx_errors. Bytes dropping from 1,000,000 to 0 would add 3,999,000,000 to
rx_bytes_total. These are cumulative software totals, so the error would
never go away.

phy_detach_internal() seems to have a similar path. With WoL enabled,
phy_suspend() returns -EBUSY without calling acx00_ephy_suspend(), so
stats_active and stats_valid stay true. phy_detach_internal() then
asserts the reset GPIO with phy_device_reset(phydev, 1). On re-attach,
phy_init_hw() deasserts it, and soft_reset then takes its snapshot
against the old baseline.

The commit message says "Invalidate the hardware baseline before reset".
For resets that the phylib core applies before soft_reset runs, isn't
the old baseline still used after the reset?

[ ... ]

> @@ -475,10 +622,21 @@ static int __acx00_ephy_config_init(struct phy_device *phydev)
>  
>  	/* Restore the standard EEE policy retained by phylib across resets. */
>  	ret = genphy_c45_an_config_eee_aneg(phydev);
> -	if (ret <= 0)
> +	if (ret < 0)
>  		return ret;
> +	if (ret > 0) {
> +		ret = genphy_restart_aneg(phydev);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return genphy_restart_aneg(phydev);
> +	if (!priv->stats_active) {
> +		/* Establish a new baseline after reset, retaining the software total. */
> +		priv->stats_active = true;
> +		acx00_ephy_snapshot_stats(phydev);
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
Could keeping the live baseline here lose full byte-counter wraps?

__acx00_ephy_update_stats() can account for at most one rollover between
two samples. phylib only calls update_stats from the PHY_NOLINK and
PHY_RUNNING states in _phy_state_machine(). After phy_stop(), nothing is
sampled while the PHY is in PHY_HALTED.

With WoL enabled, phy_suspend() skips drv->suspend:

	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;

So acx00_ephy_suspend() never takes a snapshot or clears stats_active.
The PHY stays powered and keeps counting received traffic.

On phy_start(), the resume path is:

__phy_resume()
  acx00_ephy_resume()
    __acx00_ephy_power_on_and_resume()
      __acx00_ephy_config_init()

__acx00_ephy_config_init() sees stats_active == true and keeps the old
baseline. The next poll then computes one delta covering the whole
halted interval.

At 100 Mbit/s the byte counter wraps about every 320 seconds. Wouldn't
each extra full wrap during the unpolled interval be silently dropped
from rx_bytes_total? That would leave the traffic received while halted
counted modulo 4e9.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4%40gmail.com
