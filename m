Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999017;
	b=ygH0uD1DYiySP5pdKKrKIsEVAFMjwGVzfbyGasFsKcPusN+DQBqhXy446vS5+TQ894mr
	 q3OIZGmpBeeVM9qfWE5FkHBGgOClkuIsBUXLdlLQ+3QEnxOakV3LHKRBHj/3N+785eUCk
	 tsCcNOGoJFE/Wkzg8HQXYtqwLBTMXHVllhC4J7Zay8kpf66m6UiOs8QMdVDSCLl3X8Niq
	 Qgsz+Kq3N3ja2H2k2Ntf8DViAqAAsBzNLGC362ScrQ8SRUkhr+HQa5uBLOYqWw41iGGax
	 BjFG2bhT5bwEUrDDs09yo+vmy7Yf9k1uFEJ/DMspTWmj+AyVtRXOer8AS4O1N9sBHKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999017;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gV6xwDZ9w0hHJs47+VeebrJn1QU3mACMhc25E6qrRMc=;
	b=JCISgMrXBDcTbuSQdaFOoz6zra0EPdS4ds6pWcZOAZB06buKuHKj7n45ANulM1c7G2dj
	 Tv7yA+9yqYCFTtvc0DGnlng9t73hjEB9E6qijygMUlacuQRpwOZrkqSmNFqTaajd/x5BM
	 T/b7HBQihYV1jA3arEfJFD26/WfTVV3nlGgdsEGs9h/j3Zn/CjfWeLxfNZoOey5IgvXGn
	 kI9z9qeMKnnyeMqq83o9ay04APYjIvQihdWWQyErOMZ8Cdg7jfvvZEbM2wrb9zmxldQqe
	 Inctk3EYipJNsoeKJPgTXdgu7M+iF4YpP9qZZ5GVyydaGosJSystNI9QX+pWJcpsKgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb+Uxxso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56594606A326;
	Fri,  6 Nov 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb+Uxxso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B191F008A2;
	Fri,  6 Nov 2026 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999016;
	bh=gV6xwDZ9w0hHJs47+VeebrJn1QU3mACMhc25E6qrRMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eb+UxxsoLgTEe+s0wkGq+l34usyaycfMkdXpqfOLgMZyVlcnoIZugd966EnoiRFEk
	 /5uLtOUfWuURKa83UqFQCgoByfaU5NMjlkwt32OTWb4emK4qg8AXS+qKcGwyaji/Xj
	 yB0Qp5k11pL9G/db7POi2TU4wNxrqk/hgpTLMb2q88MyUfag00OXFEAmZVm8mnEodL
	 mw6bMzO1Y/APTRDwpuNOZVpQ18fX4M6X49eFMVJCmRt0tnPBgCKWNqquX9cI/4dyrd
	 3/PREcsXMA1T2NLgVcAX72hwUvGwRv2LnYygEvRJbj2sPWpskmapM2rnfhz+yY+2pe
	 3g+OMsSTI9DYg==
Date: Fri, 6 Nov 2026 13:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Romit Sagu" <romit@romitsagu.com>
Cc: <netdev@vger.kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH net-next] net: sfp: add quirk for OEM
 SFP+ONU-XGSPON
Message-ID: <20261106130333.05261ed7@kernel.org>
In-Reply-To: <20261103011849.181392-1-romit@romitsagu.com>
References: <20261103011849.181392-1-romit@romitsagu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 01:18:42 +0000 Romit Sagu wrote:
>  	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
>  
> +	// OEM SFP+ONU-XGSPON is a XGS-PON ONT stick with broken TX_FAULT
> +	// and slow startup, just like potron.
> +	SFP_QUIRK_F("OEM", "SFP+ONU-XGSPON", sfp_fixup_potron),
> +
>  	// HORACO HC-10GE-113C uses Rollball protocol to talk to the PHY.
>  	SFP_QUIRK_F("OEM", "HC-10GE-113C", sfp_fixup_rollball),

The quirks seem to have been sorted alphabetically once upon a time.
And the OEM section is starting to look very randomly order.
Please put this in a better place?
-- 
pw-bot: cr
