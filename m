Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127425;
	b=Km9AOQyRxcETZYkbPsdT7aavuJUvVnw2Y8jmpZKiv8iC3RHKxSXFIwGEUNoLYYJhSsWG
	 hKJIrRl69K8iRvH1jhnx8r8/4SEUqS/o+8mlaMaeL2/3+yk/Xp854pN8yTlTiC0kN4bOx
	 0ioUVZWYyoqbSSyeKDwq7c5AtM7I1guW9kmZgFX+JF9AaZ8jdOjMuUK6L9KdPJ3g0MDHx
	 RLdDiQFKg9enkG/DwYYhcPXzJWJosxvTaNinju1YKkc6iLG4WuvvSucBuJ9V41bQS5BCP
	 fBhMHbLc0eSd0E5Vb7GqqF+N5fH51hIFnvm9p0A/5cM78hh+o0j1nvCba8qwGXj7iAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127425;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NTu6xQo3qc3xPnwGy2quUxpwZu0qheDm9O+kUYdRyQQ=;
	b=oNREaybpsrliXD4Ua/ex3c6Y+ENOlhClCbtvN7OvzyiHa6q0qXTKsG7r5M8hGmIu/y84
	 Sdn4eNp3gdBXOUyBKGIpCr7mnMgyHhqT0tzzZxthCEMyvZ3mP4CixT8kqu6Pwop/1r+AU
	 KjLON2E3P5Idwhs/s/NteBZPEBo5DrE5tOxOCzu17349uC53lv6QQ74GdrxjhwCaVEs+H
	 qjzaXlMhboJxzYEV1ufglSr/qYUbHHsf/xcRkSaME3T8Nch6WxRF4zE+O2FYNPfq08ubE
	 Gv1tmrzYyXh6PCaeloz2/7ucfVDk4gOdLsdAdiw0Gtw6aJe0adO89ugxYiTlAuV2g1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoXkcmF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446D3606A320;
	Sun,  8 Nov 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KoXkcmF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735871F0089F;
	Sun,  8 Nov 2026 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127425;
	bh=NTu6xQo3qc3xPnwGy2quUxpwZu0qheDm9O+kUYdRyQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KoXkcmF++9T6/0XVOFsol4pJwoU7/qS1b3TIv6cfZwgm8AADDAUHrwRuyX8HMUusP
	 Bb5eZ6EIYiTjJ7dOSgTtlg04g1YGK/0e3bBrU0VIHEg1Y+nV/CEXkfv0WVg9N9lkMR
	 EbgTjR61i61I8ftIKzprbg3Ypaf/icfWx+kH+jnOAQLe7nz8jbLLVAGzWzazTFNskx
	 /vhABeTpvWHWbMtLb0/Bdcruq0wOx2zFOzCTnJJlU2v1l8Dzx/VB4AJZRsb+tL06dp
	 LDzvmjGlQLmg9yTodJRb3RjWSKlEuheiDeY1+xHpgTMWbN/CeOnIM6RXfXRJh2bfge
	 HCITEm1BPiDtw==
Subject: Re: [PATCH net 1/2] net: dsa: realtek: rtl8365mb: use IVL in VLAN 0
From: netdev-bot+sashiko@kernel.org
To: stijncleynhens@gmail.com
Cc: netdev@vger.kernel.org, linusw@kernel.org, luizluca@gmail.com,
 alvin.sipraga@analog.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 namiltd@yahoo.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 08:43:44 +0000
Message-ID: <179412742402.994134.1195257082406220235@kernel.org>
In-Reply-To: <20261104082514.2139278-2-stijncleynhens@gmail.com>
References: <20261104082514.2139278-2-stijncleynhens@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says "On its own this has no visible effect".

--

net: dsa: realtek: rtl8365mb: use IVL in VLAN 0

This commit adds rtl8365mb_vlan_4k_setup_neutral() and calls it from
rtl8365mb_vlan_setup(). The helper sets Independent VLAN Learning on the
VLAN4k entry of VID 0, so that lookups and learning match the IVL-keyed
FDB and MDB entries the driver installs for VID 0.

> On its own this has no visible effect: standalone ports do not learn and
> the driver does not control host flooding, so the unused static entries
> only meant that traffic was flooded to the CPU. The next patch, which
> moves VLAN-unaware bridges onto VID 0, depends on it.

[ ... ]

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffadce926..58948e76f122a 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -322,6 +322,37 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +/*
> + * rtl8365mb_vlan_4k_setup_neutral() - Use IVL in the neutral VLAN
> + * @priv: realtek_priv pointer
> + *
> + * Untagged frames of standalone ports and of ports in a VLAN-unaware bridge
> + * are classified to VID 0, the VID of the neutral PVID. No bridge VLAN sets
> + * up its VLAN4k entry, which by default uses Shared VLAN Learning, so the
> + * switch would learn these frames by FID while the driver installs its FDB
> + * and MDB entries for VID 0 with Independent VLAN Learning. Use IVL in VID 0
> + * as in every other VLAN.

[Severity: Low]
The commit message paragraph quoted above says "On its own this has no
visible effect". Does that hold for ports in a VLAN-unaware bridge that
have no PVID?

You can reach that configuration by creating the bridge with
vlan_default_pvid 0, or by removing a port's PVID with bridge vlan del. At
this commit such a port falls back to the neutral PVID, which is VLANMC[0]
with EVID 0. rtl8365mb_vlan_pvid_port_clear() keeps the frame filter when
the port is not filtering, then sets the PVID index to 0:

rtl8365mb_vlan_pvid_port_clear() {
    ...
	} else {
		/* skip undo_set_framefilter */
		accepted_frame = prev_accepted_frame;
	}

	ret = rtl8365mb_vlan_port_set_pvid(priv, port, 0);
    ...
}

As a result, untagged frames on that port are classified to VID 0.

Standalone ports don't learn, but bridge ports do:

rtl83xx_port_bridge_join() {
    ...
	if (priv->ops->port_set_learning) {
		ret = priv->ops->port_set_learning(priv, port, true);
    ...
}

Before this patch, VLAN4k[0] used SVL, so the switch learned and looked
up these frames by FID 0. The IVL {VID 0} FDB and MDB entries that DSA
installs never matched. That includes bridge static entries and the
assisted learning entries on the CPU port.

This looks like the same roaming and hairpin drop scenario that the
follow-up patch "net: dsa: realtek: rtl8365mb: keep the neutral PVID in
VLAN-unaware bridges" describes. This patch fixes it on its own for
PVID-less VLAN-unaware bridge ports.

This patch has its own Fixes: tag. Could the commit message say that it
already changes forwarding for PVID-less VLAN-unaware bridge ports,
instead of only discussing standalone ports?

A related point about the new kernel-doc: it says untagged frames "of
ports in a VLAN-unaware bridge are classified to VID 0". At this commit,
ds->configure_vlan_while_not_filtering is set, so rtl8365mb_port_vlan_add()
programs the bridge PVID (VID 1 by default) even when filtering is off.
rtl8365mb_port_vlan_filtering() also doesn't reset the port to the
neutral PVID.

So the comment is only true for PVID-less ports until the next patch in
the series lands. The code change itself looks correct.

> + *
> + * Context: Can sleep. Must be called with &priv->vlan_lock held.
> + * Takes and releases &priv->map_lock.
> + * Return: 0 on success, or a negative error code on failure.
> + */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104082514.2139278-1-stijncleynhens%40gmail.com
