Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511058;
	b=I4WaL+2HlEvbtRRUIl0S7Sz0flAukgfuALs27N9i14iHNo38vZXYwXbr1NGhOM6DmpDJ
	 im/viv10Jp5BZGNVRnchQkp1OMbVKgtifdkaZPQoTzOtanzc91bsl97wGT5wL1O4whsZe
	 fbtU2rXBbEJudTLZAQ3eT9/nMLaZ+e8uRpM50zBe+ZVSVJJxO0XKvFmrs6eHx46Qb4Kqz
	 lKE4cUK6rv4PkL7KTD0W+Yrpc0LyzG2JSt/QbIs0YQq/+9E0AXd2sF1RyV7fFDCuNxrUT
	 BTnxhTqrkQuZnGrSjpE2IeRw6AOEmHhWnivM0gEsBkG0Zc/eIdi7pmP4iRTjB3enVyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mgRO0VBWjRY/9EHbtSgQvAd+ddMpjekAAo3rcaJiw5U=;
	b=PMpdAB7TI6/r6j6b9eqyrDeGSYbmLMemi/EVrQ4sUg4/8Oo3eX4UYJvexvpRyzexoRMO
	 VWOHKTsMddUzBnh2kcfCGb3C0u7mKGGqfJZnU4ROmem+TyDN8qVJSVycYSCuz2t5+USGG
	 rPHZPd4tz1OrNqedNFNWdwEj0uAjN3r7qH6XF+b4qqUkGUADkritCxZzhzLeVGD8VWQQC
	 /3BtOtH1ssi9zmuXzwdgAnrTh2QUFGVijb9ql+xEI346m/GRnK4IuwnRiLDcOKiIAl8MV
	 v+geonCedx8R2R2xaolQ2aK1S8ZZvRw5w1Eg10/LZPJb8dNwir00U1p4SzNzYyZdUeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+GrNe7Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDF606A31C;
	Thu, 12 Nov 2026 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+GrNe7Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0796B1F000C4;
	Thu, 12 Nov 2026 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511058;
	bh=mgRO0VBWjRY/9EHbtSgQvAd+ddMpjekAAo3rcaJiw5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j+GrNe7Yeq/1XBFJGG2GGi4w4nBOCjKTif4kT2vB8GzXwlBcSGwr4z3h1++5rg/Qr
	 gFnCgvJed7L7xWkXaYwde0T7vLhUjxjk8rxPn75sV/GGVaAldE8toCSDCb6R+xVm9u
	 FtwVNZPTKZgzNu1BKOKSzdWmePVOJLMU2KrbAL9xU0UMcxH9SEZa4tOvpBThqwsz98
	 YVpn8OsbyZgCtmhZNk671j7IRoTDMRZrRjc0zMdXQ7Otg1UhQGW8wSjein2bSnZL4G
	 m/UhbPxf+Cfu7l0MdXjc9A+wIEFeC2a7Mhm1sJzKJ4/oBo5ZMs6f2F/kQtFY0hCm5w
	 3MlS4o9/Ouv7w==
Date: Thu, 12 Nov 2026 11:17:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Lukas Wunner <lukas@wunner.de>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Wei Fang <wei.fang@nxp.com>, Niklas
 =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>, Paul Barker
 <paul@pbarker.dev>, Florian Fainelli <florian.fainelli@broadcom.com>, Doug
 Berger <opendmb@gmail.com>, Thangaraj Samynathan
 <Thangaraj.S@microchip.com>, Shenwei Wang <shenwei.wang@nxp.com>, Haoning
 Cheng <Haoning.CHENG@cn.bosch.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during
 sleep with MAC-managed PM
Message-ID: <20261112111737.730f8875@kernel.org>
In-Reply-To: <20261112-phylib-v5-sinfo-reply-1@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
	<179444109487.2168702.10631162542543162252@kernel.org>
	<20261112-phylib-v5-sinfo-reply-1@iav.lv>
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

On Thu, 12 Nov 2026 01:55:16 +0200 Igor Velkov wrote:
> Patch 4 fixes a hang seen on Helios64 (dwmac-rk, RTL8211F): in s2idle
> without WoL the board hung or reset 10 of 10 times without the series.
> The PHY IRQ thread stalls its CPU on an MDIO read while the GMAC clocks
> are off, so that CPU never answers the NMI:
> 
>   watchdog: CPU0: Watchdog detected hard LOCKUP on cpu 1
>   After 10 seconds, these CPUS still haven't responded to the NMI: 1
> 
> Patches 1-3 fix defects found by code inspection and Sashiko review;
> they were not triggered.

please remember to add this to the cover letter
