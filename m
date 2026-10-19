Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453370;
	b=mkhbPn9fGOtg9VMHwdmBecRCD+9d8ko3Cl74wg4bOFxRO6BdAkS+TiOaVz2BHhRajY1r
	 O5exFDQ2DHs3Epz4h3qG7fAiPyHQXnNMHqhkl4f5m61LlbVAHRPcKmnIs81RCTLvRafYt
	 hdbimi1QvW4WxDqZT8XAB5piSp+wnhCx456DMHsYxnTHYI7zYCwD+69UUpFJrfBMe23WC
	 xLBCMdXB6ZgffmbSWCI0dGPlknG01KgMOR/sc3AxzyRSuMzBp+CBW4MQh/4DeLJqERKe5
	 dvggYhsA2BnYW+Iwu4wHDPqoUQLjDf03XDNZQgaqJfW6hkXDF92luywnvgM2Rly3KJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453370;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FYa8dnTvUVmkNxFv7StTWYj3kgHUq3JoGbZV2fZG/0o=;
	b=WTpqmNJYfR8LFxUl8usq1KXXfb6jBSx/bP/HrSeA35sw+kmGaY5tUKe1V2XiG9wM2H/R
	 RCnaHRiCfFD/0N034LUcouHoIG56voRt2TjZDWbFD3JfVPeUbRhhXA2UE9CnJ0gd1VKd2
	 4d7IIHsAPkULobfkv/reiAkCnOXs8eIbdO1VStwN+o7XaV8jmScgGn9suS35XIT4FD38h
	 PHDsR+o1+8DYXFcB7+NQM0zWtM6gZprSb2WQEG0nPeliXW5DUyjefj4TZHeo1xCaN3SQQ
	 Bnrw67Gz4OV29Hrkq2KflE/Sn1Hg/OvZbMhPrNb/NrpO+tNepBulM4AFxkQNQzL85IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD861fDb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29F606A319;
	Mon, 19 Oct 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FD861fDb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C81F000C6;
	Mon, 19 Oct 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792453370;
	bh=FYa8dnTvUVmkNxFv7StTWYj3kgHUq3JoGbZV2fZG/0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FD861fDbm8GtaxjHtgQ5PMUOMr0YwWlb/t/5/S/OJfxB1zoGoLnAOCSdf2VnLyN0i
	 oparZiRwQHeuDBkTg9qh7DJBucW1pK2jk/Y6yHptT2FBLiWRkE+30t6Y3bbecYI0U7
	 2q76LTQGsJzDLloZ4LlmamzH5ftVhdiklYJvyp9A4nxStdHqgzInDItodWnDNU4iBi
	 cNsnQ9qnfxgvzJjQjDJn0sGiSlZzvZqFcqBmtonx9CVxCf8o0tY1sXV9UOIVe0ittp
	 VIVDG3cwaXFvM2TaS0xe2MM2PhSyxGcAEAlLghSCuUmXaVCanYNjJGIEbJ1PitP5Id
	 HtwOfdN3Tt52A==
Date: Mon, 19 Oct 2026 16:42:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, Joris
 Vaisvila <joey@tinyisr.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v25 04/10] mfd: an8855: Add support for Airoha
 AN8855 Switch
Message-ID: <20261019164248.037971c8@kernel.org>
In-Reply-To: <20261009161102.38961-5-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
	<20261009161102.38961-5-ansuelsmth@gmail.com>
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

On Fri,  9 Oct 2026 18:10:49 +0200 Christian Marangi wrote:
>  drivers/mfd/Kconfig         |  14 +
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/airoha-an8855.c | 579 ++++++++++++++++++++++++++++++++++++

You didn't explain why the MFD is needed and more importantly what
merging path you expect. We need an ack from Lee, at the very least.
Given the merge window has already started I don't think we can
do the necessary dance in time.
-- 
pw-bot: defer
