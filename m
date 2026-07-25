Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CF20ED
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937920; cv=none; b=iFNA7hRVGRo0Jmc8IqcEDgRGGjPpiMTQmeZw7+8/dxbnsSQCT1LhsrUzTATaWhnqg4SBm+7R8PMX9GLdHg5Nhl9+6+4xQMp2tZGBnujIJnASLT/SrSw3vj9LAKeqGd+OI2Jl6NBgaj8+PW37f55edyAfEyNpYgD+eOWMUfk2pRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937920; c=relaxed/simple;
	bh=xRuyJvOECs/hkV6rG1fdSmxQzWOOMMk+74zg70/tK/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGeYaQhsQS24MjmoXL2KS4IcKhw2XdnO7JwxYBa4XLMTk8L2P/mgDfAcUExYFsQFF/sL38K2fVJVAPpJG945qLTFPuj9L/hQyyARVWGDf1J//skByORhYgwwBPDTPamftY5/2T4NZDrd37cMI/fyxz9GPiyxPnuoVVF36ydsm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bufLQoeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bufLQoeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF60D1F000E9;
	Sat, 25 Jul 2026 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784937919;
	bh=XQRXvft88VzlGF21ZOVVLk9TY/HsDIXr0NIeagvR3Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bufLQoeKn+K5gzTg99/ckWgJoHHi7SCQkgAqA2w2rce91/p2VHxR1dYZYYhaxwWXG
	 xpjzcMdAzhabVVGgHnq6mZlhxso4QJvqTDKS95LyPgvpx4eXqPzn+gJI+ZOSxV2FBR
	 9npbxEtyeZKSAqkfB6vo4KnNC0w4zlF/A7NQCyPcQ8JHVslXKQkhUa3HTca9e8FDsm
	 vVZfxtfBLIkijaGCMmbenm7Nh+oFH2tv+6KPJvRVq07MZxr7+gq+z7Mf7gWaeKvXPl
	 8wgEp7sgrg4gMftSDDHmPnTSyyFcxUnVdxjr1uFrV/0vbADiOREQN9no/22ibGHm8s
	 xzElBQ3RHvM3w==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: realtek: rtl8366rb: Fix up port isolation
Date: Fri, 24 Jul 2026 17:05:17 -0700
Message-ID: <20260725000517.1733195-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721-rtl8366rb-fixes-v2-1-24464bd1efa4@kernel.org>
References: <20260721-rtl8366rb-fixes-v2-1-24464bd1efa4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8366rb: Fix up port isolation

The patch changes the initial port isolation setup in rtl8366rb_setup()
from passing 0 to passing RTL8366RB_PORT_ISO_PORTS_MASK, and also
tidies up two comments.

Link: https://sashiko.dev/#/patchset/20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5%40kernel.org

> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index d2fa8ff6a5d0..6d5a6e7bc5f1 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -794,8 +794,8 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
>  static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
>  					u32 mask)
>  {
> -	/* Bit 0 enables isolation so set this if we enable isolation
> -	 * any of the ports an clear it if we disable on all of them.
> +	/* Bit 0 enables isolation so set this if we enable isolation on
> +	 * any of the ports and clear it if we disable on all of them.
>  	 */
>  	if (mask)
>  		mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;

[Medium]
Should the mask argument to rtl8366rb_port_set_isolation() be treated as
a port-index bitmap (bit N == port N) rather than a register-layout mask?

The helper unconditionally shifts its argument left by one via
RTL8366RB_PORT_ISO_PORTS():

    #define RTL8366RB_PORT_ISO_EN           BIT(0)
    #define RTL8366RB_PORT_ISO_PORTS_MASK   GENMASK(7, 1)
    #define RTL8366RB_PORT_ISO_PORTS(pmask) ((pmask) << 1)

    if (mask)
            mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;

All other callers construct mask as a port-index bitmap, e.g.:

    upports_mask |= BIT(dp->index);
    downports_mask |= BIT(dp->index);
    ret = rtl8366rb_port_set_isolation(priv, dp->index, upports_mask);

so port 0 is expected to be encoded as BIT(0) in the argument, and
RTL8366RB_PORT_ISO_PORTS() places it at the correct register bit 1.

> @@ -951,7 +951,8 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>  		rtl8366rb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
>  
>  		/* Start with all ports completely isolated */
> -		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
> +		ret = rtl8366rb_port_set_isolation(priv, dp->index,
> +						   RTL8366RB_PORT_ISO_PORTS_MASK);
>  		if (ret)
>  			return ret;

[Medium]
Given the port-index vs register-layout convention above, does passing
RTL8366RB_PORT_ISO_PORTS_MASK (GENMASK(7, 1) == 0xFE, an
already-shifted register-layout value) here double-shift the mask?

Following the helper:

    mask = (0xFE << 1) | BIT(0)
         = 0x1FC | 0x1
         = 0x1FD

which is then written to RTL8366RB_PORT_ISO(port). Two observations:

Bit 1 of the register (the isolation slot for port 0) ends up cleared,
so port 0 does not appear to be isolated in the initial setup, which
seems to contradict the "Start with all ports completely isolated"
comment and the commit log's "setting all isolation bits in the
isolation mask".

Bit 8 lies outside RTL8366RB_PORT_ISO_PORTS_MASK (GENMASK(7, 1)) and is
written as 1, touching a reserved bit in that register.

Would a port-index bitmap covering all ports, for example
GENMASK(RTL8366RB_NUM_PORTS - 1, 0), match the convention used by the
other callers and produce the intended 0xFF register value (bits 1..7
set plus the enable bit)?
-- 
pw-bot: cr
