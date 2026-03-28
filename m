Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA81F30BB;
	Sat, 28 Mar 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774669821; cv=none; b=orvV8F971lzb/tQ9EAECH6e84Z/J9fy4NBc6iucysYoNRSUr2eyimRPBdokSE4yi3/zFSmh4Th/K0ayYUJH0/e4MDYyYh1RjMMj7mTUirBTA2X/OSCL8pGuQxLNglwAKZ0CrWV42bSj91dTPvZZNnhIqCIAfgAKE9tMkRMsqi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774669821; c=relaxed/simple;
	bh=5k/JPSKn+kKloIgLHKlmvgrCuTizRELOVOkwmdqMLQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omjFhyKVm664yC8kr84ZHgNm5GZBJz+EATFilJMb18AmN1hu+88WLSUH3MEzfklxKb2VPGrtBQZpFKUNY61CTeo3BgtQjN9okACeSUFjxu0FAtd+hkjrZ7UpdhYfd/KmDCtxTTrK/RLRVBVFMw+oVWEz6r4eqDXQZYVyZMG9wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gisSvAXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gisSvAXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C6C2BC9E;
	Sat, 28 Mar 2026 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774669821;
	bh=5k/JPSKn+kKloIgLHKlmvgrCuTizRELOVOkwmdqMLQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gisSvAXKYCRW1xQ3D5XogSDupfdy09Ul3WQHXqbegci7q7DbKruCQ3WNgEpo69WaB
	 CJgxJSA3BC/NH7DdQsaOHVDF+mRLQFRnmwpNMr6N8BAGGovTjSmDutL4IKeDcv2l6d
	 teTTAtWaDDm/irK0aj1HVImEaJEWZBocpbNgx4zNSl/J4VDIwjYp861dj/nGiR/r7c
	 WwjBII6Nbj+vie2bYXDtaiUx9jfGPa8a/x0uN6qPrbBGoTauS9eU/JVumytkPjW4Fb
	 Sx9z7I9g+gdjTahUIjbR4bO2ubGyD+NnGdLq+PlcsCfVd12Eeds8tI0TjQIur6XcHI
	 p7qB7PMk6xmbg==
Date: Fri, 27 Mar 2026 20:50:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for ZOERAX SFP-2.5G-T
Message-ID: <20260327205020.1c020731@kernel.org>
In-Reply-To: <20260325164034.1542787-1-jan@3e8.eu>
References: <20260325164034.1542787-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 17:35:58 +0100 Jan Hoffmann wrote:
> This is a 2.5G copper module which appears to be based on a Motorcomm
> YT8821 PHY. There doesn't seem to be a usable way to to access the PHY
> (I2C address 0x56 provides only read-only C22 access, and Rollball is
> also not working).
> 
> The module does not report the correct extended compliance code for
> 2.5GBase-T, and instead claims to support SONET OC-48 and Fibre Channel:
> 
>   Identifier          : 0x03 (SFP)
>   Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>   Connector           : 0x07 (LC)
>   Transceiver codes   : 0x00 0x01 0x00 0x00 0x40 0x40 0x04 0x00 0x00
>   Transceiver type    : FC: Multimode, 50um (M5)
>   Encoding            : 0x05 (SONET Scrambled)
>   BR Nominal          : 2500MBd
> 
> Despite this, the kernel still sets 2500Base-X as interface mode based
> on the (incorrect) nominal signaling rate.
> 
> However, it is also necessary to disable auto-negotiation for the module
> to actually work. Thus, create a SFP quirk to do this.
> 
> Signed-off-by: Jan Hoffmann <jan@3e8.eu>
> ---
> Note: I'm not quite sure "sfp_quirk_disable_autoneg" is enough here, or
> if it would be appropriate to use the full "sfp_quirk_oem_2_5g" quirk
> due to the not really correct compliance code / nominal signaling rate.

I'm no SFP expert but just going by the naming I strongly suspect that
the module is the same hardware as "SFP-2.5G-T" from "FS", so keeping
quirks consistent makes sense?
