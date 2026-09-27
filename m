Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7513D7D69;
	Sun, 27 Sep 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512122; cv=none; b=qLvRwCQvCbjbh8pnsBIdVpPtQQQNn4kErR2IHPLlKpGvWIqUMgivmS8HPgdlgfVNgwEIkQSx4BJhjUgMYrl12BOto0CNfxkjlRBQv+cxq69cfP/L4t55GywaGL8m6eWr4qVANuoCtMeyxShO6sKl523EUnGNXaxdCCbit1qgyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512122; c=relaxed/simple;
	bh=6QzDZqiRPqpTf3bsc6DnkPjNBvioAKgC67t9YqLNO00=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1zdF2ZdlJAk2L21Zr5JiJ2aLb2iYD2K1eu1XdlFhRzcDY9dRjuj/vNFy4TqkpQ7FwucOFKlHK0KN2+ig9Gl+k3/+5rp1WyLyZDuwJBaChHJIgTYm0PqGXaLYmInAkXvQq5gIs4zluDmSXL7bfOreDxN/jzXyNI2W/EfoV/Gfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9jmt4S0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9jmt4S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDA61F000FF;
	Sun, 27 Sep 2026 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512115;
	bh=8hR1TJP0wDyvqCtSFs7IWERwCvw+xUL/1ITEf1E4TFo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f9jmt4S0FDXn51MVC4jTdRpoxQTomgwo8/mBVqerstwHOBLa4BxQOHxbQl7jxYoxe
	 OcCmTL3N4NyZyord9m44ygT5Cs1LbbC+5Tch2iosGJ7cl87Z3tRjiBviJdO9aZegPG
	 +fuMrTmcXA0MBYQX7OTNaJ4FGVFaLKgp/eMHazCTdBxVHQOjbLczJ2OXvbl+TqVHuz
	 cvx2MOHL/M0+jML84QhXLglMJw/EJsYT3+UA5d0HaYSdSRnZ91l957Bxr+7VWZ0MA+
	 Q8uMIgywBzYazBaX6IsOVjylVRTNiQDRRaJsElmUys2CeouxMnrytSEOyAAC6dW301
	 lfjz198F4aAsQ==
Subject:
 Re: [PATCH net-next v3 8/8] net: dsa: soce: Disable unsupported hardware STP
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:34 +0000
Message-ID: <179051211407.2160803.13769145905433369718@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Series-structure concern.

--

net: dsa: soce: Disable unsupported hardware STP

This commit checks the STP synthesis bit in the implemented features
register. When the bit is set, soce_setup() clears the STP control
enable bit, so STP state handling is left to the Linux bridge.

> diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
> index f93ce9da8400c..3b9fde7a547e7 100644
> --- a/drivers/net/dsa/soce/soce_dsa_core.c
> +++ b/drivers/net/dsa/soce/soce_dsa_core.c

[ ... ]

> @@ -160,6 +165,7 @@ static int soce_sw_detect_features(struct soce_dsa_local *local,
>  		return -ENODEV;
>  
>  	features->port_vlan = regval & SOCE_IMPL_FEATURES0_PORT_VLAN;
> +	features->stp = regval & SOCE_IMPL_FEATURES0_STP;
>  
>  	implemented_numports =
>  		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);

[ ... ]

> @@ -420,6 +436,10 @@ static int soce_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	/* Unconfigured hardware STP blocks frame forwarding. */
> +	if (priv->features.stp)
> +		soce_stp_disable(&priv->local);
> +
>  	soce_sw_enable_tagging(&priv->local);
>  
>  	return 0;

[Severity: Low]
This isn't a bug, but could this be folded into the base driver patch?

Two earlier patches in the series already accept cores synthesized with
SOCE_IMPL_FEATURES0_STP set, but neither touches SOCE_STP_CTRL_OFFSET:

  net: dsa: soce: Add basic support for SoC-e switch IP cores
  net: dsa: soce: Add VLAN offload support

This commit's message says such cores block frame forwarding. So if you
bisect to either of those commits on an STP-synthesized core, the driver
would probe and then forward nothing.

The whole driver is new in this series, so nothing that worked before
regresses. A Fixes: tag pointing at an unmerged commit in the same series
wouldn't be wanted either. Squashing this change into the base driver
patch would avoid that intermediate state.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
