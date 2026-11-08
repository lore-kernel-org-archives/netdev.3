Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141573;
	b=m5w8ffhd3I9behgTyMutVBOgok6Kf7imuLD50dbtusDLz0vDnjD14pOyYdSHk4qW5W8a
	 b/1yENc8eZinvbdBX1uVhnkmvTPtKeHEpfIoyCWz+2BJrEbDpzPCK1wiSezsGodLxoCxh
	 xDEJUeJ2wb9UXyGeLFI5jctlw4N7JdOczcLtx9ujLdHGWzExZci4/V5SrYo2ZeCBE+rfj
	 2UP3mCBjGXCcMXLJHXDd9vlPWam2XtAhsInAVTBh5MrT3VcUr9rUPBGD60DF8ATdyxVZ5
	 v2GD7rHV7S5gvgY7se35OsGogHcuX+heuczIv9g3+6bjS29ZYnr1Fp9svRhGnFy998Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141573;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Xm1hehkTkheewVHZFkFtM4dICzsV3Hiezfso6Iy1pAw=;
	b=YTY322FmY4VFniNzg+LPu9e3do3HiHMPITy60bqTrmVs7xkZAQaLHdCnsi0FBNiyBLGU
	 mggqvYOVHE1g+80bbYoF7QAVHQQYR4do7lHM10uCiWymw96FIxwuxxR/fbIY7ieS+J1y8
	 fe0AqpdEI/4m5MrsbZIYFRFu+aS+EDSnDJUeshd/ASt15dcf35+p9rTADseDeTuJGiI2c
	 +pVwtvra58Vx6XP+KECPum90PXS7mwgYov4FxjtrxUv28eqeSDBlN2DzmlpPe9WcmSwsy
	 Um1ni2qsSItv57n4lTwa7xKjhoQ1zYL/+1DUDC/xv9brL76ShrC1e77UOKip3M/NBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrIvraA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4A606A321;
	Sun,  8 Nov 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrIvraA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7171F008A2;
	Sun,  8 Nov 2026 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141573;
	bh=Xm1hehkTkheewVHZFkFtM4dICzsV3Hiezfso6Iy1pAw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TrIvraA5pvHZig8QlDwhdgk4IWbzIFcNTguOOouKluYYvCTJZMnfZdXrp/CZfSdAG
	 obdRgS4qscDH7SO1Ts6OekpT7EqemNtZw1wlfN9AyRHdJT2KiCrKuEGNH6BnqNHf6P
	 EIqbZG7hcmgE8bl6un1eMF/HjWi2Z6cPfbGXd+1cd+VtmDm4RJ6BsJwjk9gA5Wbe1T
	 RLE0fNWb7iJA223It8+R8f/G/GFosGtdpGCP8Fcl8lV+piQV437qIVtKXVPESNki/i
	 6QJ0GhIypa1YSSkrynFWwCFmbh7/gWzkH7cxm50blHqr6ZC3EiFyP//rMLq65ckLje
	 M9QwIZNB601yQ==
Subject: Re: [PATCH net-next v4 2/8] net: dsa: motorcomm: Drop VID 0 VLAN
 table programming
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:32 +0000
Message-ID: <179414157227.994134.8326158294654980832@kernel.org>
In-Reply-To: <20261107121631.1040612-3-mmyangfl@gmail.com>
References: <20261107121631.1040612-3-mmyangfl@gmail.com>
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

- [Medium] The commit message says the VID 0 entry is never looked up,
  but the driver itself can make VID 0 the classification VID, so the…

--

net: dsa: motorcomm: Drop VID 0 VLAN table programming

This commit removes the write of VLAN table entry 0 in
yt921x_chip_setup_dsa(). That write set LEARN_DIS and all port members
with an empty untag mask. The commit message says the hardware classifies
priority-tagged frames to the port's PVID before the VLAN table lookup, so
the VID 0 entry is never looked up.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 693564aeaec14..47f06945b8c4e 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -2321,15 +2320,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> -	/* Tagged VID 0 should be treated as untagged, which confuses the
> -	 * hardware a lot
> -	 */
> -	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
> -	ctrls[1] = 0;
> -	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
> -	if (res)
> -		return res;
> -

[Severity: Medium]
Is entry 0 really unreachable when the port's PVID is 0? The commit message
says:

  the hardware classifies them to the port's PVID before the VLAN table
  lookup, just like untagged frames (measured on YT9215S), so the VID 0
  entry is never looked up.

The driver itself programs a hardware PVID of 0 on VLAN-filtering ports.
In yt921x_vlan_filtering(), br_vlan_get_pvid() gives 0 when the bridge port
has no PVID:

	else
		br_vlan_get_pvid(bdev, &pvid);
	res = yt921x_port_set_pvid(priv, port, pvid);
	...
	if (vlan_filtering && !pvid)
		ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;

yt921x_pvid_clear() does the same after the PVID VLAN is deleted, for
example via yt921x_dsa_port_vlan_del():

	res = yt921x_port_set_pvid(priv, port,
				   vlan_filtering ? 0 : YT921X_VID_UNWARE);

In both cases the only extra guard is CVLAN_DROP_UNTAGGED. Does that bit
also drop priority-tagged frames? If it does not, a priority-tagged frame
on such a port would be classified to PVID 0 and look up entry 0.

After this patch, entry 0 keeps its reset contents. The 8021q layer can
also change it at runtime by adding VID 0 automatically:

dsa_user_vlan_rx_add_vid(vid = 0)
  dsa_port_vlan_add() / dsa_port_host_vlan_add()
    yt921x_dsa_port_vlan_add()
      yt921x_vlan_add()

yt921x_vlan_add() sets only the port, CPU port and untag bits, never
LEARN_DIS:

	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
	ctrls[0] = masks[0];
	...
	return yt921x_reg64_update_bits(priv, YT921X_VLANn_CTRL(vid),
					masks, ctrls);

No other code in the driver sets YT921X_VLAN_CTRLa_LEARN_DIS. Could the
switch now learn source MACs and forward in hardware in VID 0 on a
filtering port with no PVID? The Linux bridge would drop those frames.

The measurement in the commit message also covers only YT9215S. The rest
of the series does not restore a LEARN_DIS write to YT921X_VLANn_CTRL(0),
and PVID 0 is still programmed in yt921x_vlan_filtering() and
yt921x_pvid_clear().

Should the commit message cover the PVID 0 case and the loss of LEARN_DIS
on VID 0? Or should the VID 0 programming be kept?

>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
