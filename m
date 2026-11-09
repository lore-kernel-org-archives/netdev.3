Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262949;
	b=BeWDaT1daqUibLoMvpL9uxsh5Gh0/jJ8e77MefOugjRQXZp86uqXVAhO5jirFtTY1uPW
	 JLLrBDucUR+VY9jFproS9apj+tmuxjk/UeezYIbuB4zoZTWFw99gvLFbY7dh3u3m2BT7/
	 rEeFgaAl7okAojTRQo7RTdD9/FqdUPCj86DbWA2kSnc60XKPABIo6pCJ341pohlcgvSob
	 28J5FMvoS1eDnm0P6R9uW1p2RoXoQ4u7/m3ZWK64QRaCc+7max4uzogWwy/29/y5xhqFx
	 8DAlhfAT41mFUiTVTTLG/190WOnKaMEK/WCM6vgAh4ND0VVKCf7cji5HveKBTheNcMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262949;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9NPLeku08GmCj363CiWIy/aymqtWXMX4G6VP01gGwnQ=;
	b=S/FQuHvMHOwxgO6wL/yRI4UH9esDYmnsOyQO5Ck8cgtqks180uD2/IglE4QOaKyT19Pv
	 Oz7G+X5jhGJaOSvkoPIKUDp9o+W5K3wIA+NYBGRJ6Ygri3OWp6fi4ooYMHH3zfsFv2uhV
	 8vQl4OJ0yazLFY0TQ2+67bbmY3u24wvKwR5B6wHtzimbfsUflawDtDB3pHE6oiTiLrAEF
	 JaDrJxnIPUJeSYJbiQ6xyznvcJflG64f4LPL76sy7Jji2R3IBxC3cVkota/dI1FQpHOc3
	 qFC0UhM0ycn8cnFYfAl+wDAg+exU1f5/qse2YwtJsg/wPVKdrHHQukdjrULGbInt7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvhiud0U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCE606A334;
	Mon,  9 Nov 2026 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvhiud0U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A7F1F0089F;
	Mon,  9 Nov 2026 22:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262948;
	bh=9NPLeku08GmCj363CiWIy/aymqtWXMX4G6VP01gGwnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mvhiud0UPCwGmjz6Knjs8ke8SKh0wq3V0gU2az74X6YKbcNSuONQXTNGzGSAkfAdi
	 IG+2C/I6BCj8FHem5Uu05Z5Oyjf62xE1yqDcV2k4WgFFJe8SUr3S+QP+qw6QzlI9ve
	 8x4rU7MMcCt1ZQLW4srlrVxfC1M7VhTDwsvzfurLjm1n1pmSjB5LqlOJPDbI7u6Amg
	 Wq1+gqQQ5MRcZmTBA8ACSExmJgHw4Lnfl9tEikxKKSzetge1+J4GroIeTTRDKQDerw
	 JTkMeSR9TFHmZQaNUATEcctqeDgJKbO9lU0szcC/DScMDMu5XNJBlAGomdeS3GA8hb
	 E5bS4pVrDCsnw==
Subject: Re: [PATCH net-next v5 2/7] net: dsa: motorcomm: Drop VID 0 VLAN
 table programming
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:22:27 +0000
Message-ID: <179426294748.994134.3345680195855302131@kernel.org>
In-Reply-To: <20261108214450.1662362-3-mmyangfl@gmail.com>
References: <20261108214450.1662362-3-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the VID 0 VLAN table entry is never
  looked up because the hardware gives priority-tagged frames the port's…
- [Medium] The commit removes the VID 0 VLAN table programming for every
  supported chip, but its only evidence is a measurement on YT9215S.

--

net: dsa: motorcomm: Drop VID 0 VLAN table programming

This commit removes the setup-time write of the VID 0 VLAN table entry
from yt921x_chip_setup_dsa(). The commit message says the entry is
unreachable because priority-tagged frames are classified to the port's
PVID before the VLAN table lookup, as measured on YT9215S.

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

[Severity: Medium]
Is the VID 0 entry still unreachable when the port's PVID is itself 0?

The commit message's reasoning only works if the PVID is non-zero. The
driver sets PVID 0 on VLAN-filtering ports in two places.

yt921x_pvid_clear():

	res = yt921x_port_set_pvid(priv, port,
				   vlan_filtering ? 0 : YT921X_VID_UNWARE);

yt921x_vlan_filtering(), where br_vlan_get_pvid() returns 0 when the
bridge port has no PVID:

	br_vlan_get_pvid(bdev, &pvid);
	res = yt921x_port_set_pvid(priv, port, pvid);
	...
	/* Do not drop tagged frames here; let VLAN_IGR_FILTER do it */
	if (vlan_filtering && !pvid)
		ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;

In both cases only CVLAN_DROP_UNTAGGED is set. Does CVLAN_DROP_UNTAGGED
also drop priority-tagged frames?

If it does not, then by the classification model in the commit message,
a priority-tagged frame on such a port gets VID 0. The hardware would
then read YT921X_VLANn_CTRL(0) for ingress membership, learning and the
untag bitmap.

Before this patch that entry had a known state: all ports were members,
LEARN_DIS was set and no ports were untagged. After it, the entry holds
either its reset default or whatever yt921x_vlan_add() writes when 8021q
adds VID 0 through dsa_user_vlan_rx_add_vid():

yt921x_vlan_add():

	masks[0] = YT921X_VLAN_CTRLa_PORTn(port) |
		   YT921X_VLAN_CTRLa_PORTS(priv->cpu_ports_mask);
	ctrls[0] = masks[0];

That write never sets LEARN_DIS.

Could this change how priority-tagged frames are forwarded or learned on
VLAN-aware ports that have no PVID?

Later patches in the series do not seem to restore any VID 0
programming. That leaves yt921x_vlan_add() and yt921x_vlan_del() as the
only code that writes VLANn_CTRL(0).

[Severity: Medium]
The commit message says this behaviour was "measured on YT9215S", but
the removal applies to every chip in yt921x_infos. That list includes
YT9215SC, YT9215RB, YT9214NB and YT9213NB. It also includes YT9218N and
YT9218MB, which have a different chip ID major:

	{
		"YT9218N", YT9218_MAJOR, 0, 0,
	...
	{
		"YT9218MB", YT9218_MAJOR, 1, 0,

Has the same PVID classification of priority-tagged frames been
confirmed on the YT9218 parts? The removed comment noted that tagged
VID 0 "confuses the hardware a lot".

If a variant does look up the VID 0 entry for priority-tagged frames,
that entry now stays at its reset default. After 8021q adds VID 0, it
holds a partial state with learning enabled instead.

On those chips, could priority-tagged traffic then be dropped by
VLAN_IGR_FILTER, forwarded to the wrong ports, or learned into the
VID 0 FID?

yt921x_chip_setup_dsa() does not check priv->info->major before
skipping this programming.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108214450.1662362-1-mmyangfl%40gmail.com
