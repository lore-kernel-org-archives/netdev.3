Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E63D5C1C;
	Fri,  5 Jun 2026 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626955; cv=none; b=gaHenATafhP+u2y9ru2awXEN4yw0VozhkueDPhXWAZ9Ow1FmK5o2bacqE4/NRXP9tZYWMwOCCk2dI5oW+QibSSDk5M0Ejkb9yVLNymFYcRcdnCj6Z+RB+GMYVkajoHNjR+usk/TojfztJYSj6wrfFbOs8HX4Jsh3p0auJbh0WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626955; c=relaxed/simple;
	bh=4syzfle8p+s3CLwFnoZREUHgXnYaA/1uQh5pyaw++dU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpDhDWskNpXSwTaiYhkvAthVYAkEVnAcYV5WzDceR/6lQbT+qpRP3c6lJGYAXdxFCxqWk5ljQnIDgGMp8BN2BiEFIdK7n35w3Hwm6KJmH1KjvcHMOjF0U2ToyScyvYNmzxzyB41cvh3nDVL9L/niECysJhZihvIsWTHNrrocO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXDsRfXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXDsRfXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986CF1F00893;
	Fri,  5 Jun 2026 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780626947;
	bh=tWAfsZJ7PYM40/QGh9zjMPfFlssKUGxkrXrkncBqhTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cXDsRfXJSWzYkOUfa5meFZmeCaVr6bR7cSheV4LCUOZgevzSAxEqKCABlyEET5wV2
	 z6S/29MK88mr27FwX3Ye3Smm7IrrIuAQACl8BOl1lFhpPIEsYUUu5HekWn4AqfYIiS
	 sLPLAF77Vg3xExYV/w9D/T1z/uThQwl4bQMlpGvegkrZ/xLC8p12zPDzofPWVbLBuP
	 QM/GVE1p5aiyg4MLZX7gdh37dwLy6Fy+uHKWhg8ZI/t0xStN1Ho+MTYgLpFFMO2Gzc
	 p95i5SsBFwCdLyoeBXkJet54F4dM5whkz/LaLGtboINiOqu7N4wRt9GYITA52Kmaoy
	 Zb0zsPaO5UZ5A==
Date: Thu, 4 Jun 2026 19:35:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: lawson.fidelio@gmail.com, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, marex@denx.de,
 maxime.chevallier@bootlin.com, horms@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Tristram.Ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com,
 marex@nabladev.com
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss
 cable PHY tunables
Message-ID: <20260604193545.0a906598@kernel.org>
In-Reply-To: <20260604114119.170747-1-pabeni@redhat.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
	<20260604114119.170747-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 13:41:19 +0200 Paolo Abeni wrote:
> > @@ -3114,6 +3114,9 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
> >  	switch (tuna->id) {
> >  	case ETHTOOL_PHY_DOWNSHIFT:
> >  	case ETHTOOL_PHY_FAST_LINK_DOWN:
> > +	case ETHTOOL_PHY_SHORT_CABLE_PRESET:
> > +	case ETHTOOL_PHY_LPF_BW:
> > +	case ETHTOOL_PHY_DSP_EQ_INIT_VALUE:
> >  		if (tuna->len != sizeof(u8) ||
> >  		    tuna->type_id != ETHTOOL_TUNABLE_U8)
> >  			return -EINVAL;  
> 
> [Severity: High]
> Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
> equalizer tunables?
> 
> This heavily couples the global API to the 8-bit register layout of the
> KSZ87xx hardware without defining generic units like Hz for bandwidth. 

AFAIK this is the one comment from AI that survives scrutiny.
Seems unlikely we'd need more bits, but then again - why not.
u32 should be our default for integer values, u8 is more for
booleans.
