Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25319049B;
	Wed, 10 Jun 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052202; cv=none; b=rMU65kbEkmi55m6toAuEmPA3qrmjEKEZESKHMVwu/PfJypi7NxtYuHFr2m+mbnGq379bB53JzHU73PUJb2NchYdSunlHbNhxNR6MiuY/tzJAJ5lA3uGYHcZBenMgTeoQ75FQc/zXtkWV4DcqFXoVCrNWJYrRVv6di1GfHPNhQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052202; c=relaxed/simple;
	bh=y47u2mojQaFgIzaPP5iBdXeet/tU+xRwGluaeHMiS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAnIqE4l+FLe1P6P+LwVcczU5Q4vQuMAw6IClewApuMRtJkiUPOLQl6FttUZDGcmjQdBNia/k94ufany2ldqWeQEx0xlf9y4Chc1Go0bv/hPpbvdvU4OZeu9mdJPp7DTphWRQGeP+oGu48AAGtA6pHsdkkXfF7jhKUPgyshshPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3pLhlPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3pLhlPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622011F00893;
	Wed, 10 Jun 2026 00:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052199;
	bh=QZIx+Tf8azM7qG2aSAnz24Idnsi94Gnzu2yNxGl6AFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G3pLhlPY7OcLPI8qk5azFogdQrAv8gtzAi0zNlhtXA6mjCOEZ+2A/LNObiD3YJjXi
	 OiKLfKC6aBa+u/w6LuKFGqMuryGcl1PJpuCy8zNwk+schZzDjhcTNA53dpH0Y9McSH
	 G1nCN3BV/lfS5Af0ndRySQDiz2gTuyT2aAkkdL7Y3Zv/YEoPsC3sXiDvuC4Cle2jrT
	 lAaWFCBf/LAVyQEHiCZPHxrL5Gkbk1sXAp8EFGl1mOOVxqgOow2dPu6xPrULP0+Nm5
	 eblA/buDTF0U2395T0hPoj5+QohTKXRPl2Z79rOLBo2GNuI+goWNysVvHOrW87BWo9
	 OFc2U8akHuUWQ==
Date: Tue, 9 Jun 2026 17:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Jose.Abreu@synopsys.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
Message-ID: <20260609174318.3e34e62b@kernel.org>
In-Reply-To: <20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 02:01:13 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> +	/* Both network proto and transport proto not present in the key */
> +	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto))
> +		return -EOPNOTSUPP;
> +
> +	/* If the proto is present in the key and is not full mask */
> +	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
> +	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK))
> +		return -EOPNOTSUPP;
> +
> +	/* Network proto is present in the key and is not IPv4 */
> +	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP))
> +		return -EOPNOTSUPP;
> +
> +	/* Transport proto is present in the key and is not TCP or UDP */
> +	if (match.mask->ip_proto &&
> +	    match.key->ip_proto != IPPROTO_TCP &&
> +	    match.key->ip_proto != IPPROTO_UDP)
> +		return -EOPNOTSUPP;

Please add extack messages to let user know which part of the match is
unsupported. Extack pointer is somewhere inside struct flow_cls_offload 

FWIW Sashiko points out a bunch of other potential issues, not sure if
they matter
https://sashiko.dev/#/patchset/20260605090114.16028-2-muhammad.nazim.amirul.nazle.asmade@altera.com
-- 
pw-bot: cr
