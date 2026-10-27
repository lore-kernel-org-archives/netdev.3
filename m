Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141327;
	b=TAuawFGc7TehfAOM/Sy2ju4eazitmJb2Riteq7DEMbD9pfXDrUx+KeAenlr8cAWlf3ld
	 cFbpVRtrfZED3Qf7+UWd/QkuCF2DAGZQHtYuy7ER3YZEg9OEwvim72hxwQJUn87meHj1V
	 Q7tjrjEfOd8VyFomHoc8v91eg7dBMClyW2Y/PJ7CgVXusXktCERQG7oZuOEk2hT+oyw55
	 nOgOeNKUtErOKBw9482j6mHX8/y5PzaBpANsa2Vw97uYj+RVNgupsy0L6R4j1Hg+7mnim
	 1bYhkOhLyp9oP4sF/T3ABpJteWsyakGyEclTBPdmLwLKBnaKUZcBYkr86lJhJRfGzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141327;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AHSuLsmPArajERs48+ezcL7wF6flNWrV+Ftvie2M+AE=;
	b=qgUvb0tsww59eo6hxb/Qkalf+TIccHikBeFAVBc+GGw0kl4YcfImCBF9wYUvcqfqsQ8U
	 UkKlDD/funLa5VmxzL0FiDLiEqbn1u8+9PY0iJwII6Acd0xOiu2sLY5svB7c/0R8P7hK7
	 S3pGdR19/xtMFzC612uxXoRZf8VBQNj3wzQutQIJUFNpvyBUs8qZ6a0Ss006HyflTu0iG
	 Pd+OrTiZAgf/AxXZpvwB1T/Acgv+sUTRIR+hA/K9iqAcBpt9W9TP9zMjV1gnLpqxgv1Zz
	 Qd+QlxCA1pLV38MYE/z6QxFI0XTedshN0Ta9JNAx2K9/yhZ3FEUALnVZ9FS0k18+Yrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhC60JpT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A0606A31A;
	Tue, 27 Oct 2026 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhC60JpT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FA51F01825;
	Tue, 27 Oct 2026 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141326;
	bh=AHSuLsmPArajERs48+ezcL7wF6flNWrV+Ftvie2M+AE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dhC60JpTQ+oyZSm0MAOoe9dWr/rdcXLsL8YCCC08ksZJXA8ZobswopoigV/5/zCJf
	 NrizJI+GJKnBXg/DTfZXtA2Os+LJZaoCUc+7bHq6OQ8VZS86lN+2VPuhTbeqiMC9/G
	 dgUDj9Nu2K2O60Wwg8Uzz5EvRFAAP23vk/pASRzL9b94zqYntH1UQcw98V6oF8CMwr
	 fkmu+90ymqfWSeiu5lf3f9nUqeQzDpG+P7LNsajg8LG6/2fz0I3zoZJN3QxpyDEB5R
	 DpUqO9ZN9MzkN8rf+k6Ka0mYtagfrfrkEowkd+vT3EiCuWc+sHRMxXSMMsdF0xZrHD
	 TBY7q8xzKh96g==
Subject:
 Re: [PATCH] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 22:48:45 +0000
Message-ID: <179314132517.3134.14168811742216365656@kernel.org>
In-Reply-To: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
References: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new IGMP/MLD CPU-copy setup in b53_enable_mcast_snooping()
  (drivers/net/dsa/b53/b53_common.c) is static and has one caller,…

--

net: dsa: b53: Enable IGMP and MLD control packet CPU copies

This commit enables the IGMP and MLD high-level protocol classifiers in
B53_HL_PRTC_CTRL, so control packets get copied to the CPU even when a
multicast ARL entry matches. This lets the bridge keep learning listeners
after the first MDB entry has been offloaded. BCM5395 uses a 16-bit layout,
BCM531xx/5301x/58xx use a 32-bit layout, and older chips are left alone.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 0880310c9ce3f..54844cfadf019 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -836,6 +836,52 @@ void b53_brcm_hdr_setup(struct dsa_switch *ds, int port)
>  }
>  EXPORT_SYMBOL(b53_brcm_hdr_setup);
>  
> +static int b53_enable_mcast_snooping(struct b53_device *dev)
> +{

[ ... ]

> +	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
> +	if (!is531x5(dev) && !is5301x(dev) && !is58xx(dev))
> +		return 0;

[ ... ]

> @@ -1334,6 +1380,10 @@ static int b53_setup(struct dsa_switch *ds)
>  			b53_disable_port(ds, port);
>  	}
>  
> +	ret = b53_enable_mcast_snooping(dev);
> +	if (ret)
> +		return ret;
> +
>  	return b53_setup_devlink_resources(ds);
>  }

[Severity: High]
Does this fix reach the Starfighter 2 switches (BCM7445, BCM7278, BCM4908)?

b53_enable_mcast_snooping() is static, and its only caller is b53_setup().
bcm_sf2_sw_probe() sets the chip id and then swaps in its own ops:

drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_probe() {
    ...
	pdata->chip_id = priv->type;
    ...
	ds->ops = &bcm_sf2_ops;
    ...
}

bcm_sf2_ops sets .setup to bcm_sf2_sw_setup(), so b53_setup() never runs
on these chips. bcm_sf2_sw_setup() does not program B53_HL_PRTC_CTRL:

drivers/net/dsa/bcm_sf2.c:bcm_sf2_sw_setup() {
    ...
	b53_configure_vlan(ds);
	bcm_sf2_enable_acb(ds);

	return b53_setup_devlink_resources(ds);
}

bcm_sf2_ops still has this entry:

	.port_mdb_add		= b53_mdb_add,

So multicast ARL entries still get installed on SF2. After the first
listener's entry exists, the original problem looks unchanged there: later
IGMPv2/MLDv1 reports sent to the group MAC follow the ARL entry and never
reach the bridge.

The resume path, bcm_sf2_sw_resume() calling ds->ops->setup(), has the same
gap.

The is58xx() part of the gate above matches BCM7445_DEVICE_ID and
BCM7278_DEVICE_ID, but devices with those IDs never reach this function. Is
that check dead code? The commit message also says this covers the "newer
integrated RoboSwitch families".

Should the helper be exported and also called from bcm_sf2_sw_setup()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026172453.3152951-1-florian.fainelli%40broadcom.com
