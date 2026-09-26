Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7043356762;
	Sat, 26 Sep 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790464991; cv=none; b=HXaxm33dUfvewbfh97rGkj/D98iKON9zf7okZSeMiRV7D7us1G7UQCVA2Vx2USHXNoNCfHp75rZowP4C/iuM2MXSjE3+Fq+dtohauKAuegFCPfruVz1TjXwhr7ZDYp8fWA+sJDzCJ24X1Jf39yQjt7WZFzr3y15hyXqOPcd54eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790464991; c=relaxed/simple;
	bh=/ozAqHwym+Z5sVGPOe9fFGYDt4IlByYRu+rnvAuNlPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt99XYzs6321v3699zW7DKmaxUhA2JuLhgSsMOKSgzC751Yoii+BwCg7WvbJB5S1t0bdSn6U6lddE9a4ghdP5clpN5sLWJ2Hu/ZQHpPPGq8GeLqbp83CrNctC+pmTQmIASWOUnIJqGN2Zr/QNGn+Fyhj9OAe+abgWbH1mLMKcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dJkw7B+d; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dJkw7B+d"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50161570;
	Sat, 26 Sep 2026 16:23:04 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E6FA3F85F;
	Sat, 26 Sep 2026 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790464988; bh=/ozAqHwym+Z5sVGPOe9fFGYDt4IlByYRu+rnvAuNlPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dJkw7B+drhz4rJmrg8FxuIGuMCPa2Noark29wKB/0VaxqeyGQ0lLtIJY0P5HypHpO
	 D4FZGkqHFE+UwEQsgMmKa4Lfl9O31oQZfXhJqjvdZ+Wmn814ZcMXP3fkzbCvnYVGzl
	 ed+pV6F5ym+NYX2TbnxyxNa2tP5NcJSmMsVNwfiw=
Date: Sun, 27 Sep 2026 01:18:15 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Per Larsson <per@palvencia.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liu
 Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
Message-ID: <20260927011815.66cc1769@ryzen.lan>
In-Reply-To: <20260901074827.39a649bc@rpi>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
	<20260803101452.2993721-7-andre.przywara@arm.com>
	<20260809134607.65d66069@rpi>
	<20260901074827.39a649bc@rpi>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 07:48:27 +0200
Per Larsson <per@palvencia.se> wrote:

Hi Per,

thanks for having a good look at this!

> On Sun, 9 Aug 2026 13:46:07 +0200
> Per Larsson <per@palvencia.se> wrote:
> 
> > On Mon,  3 Aug 2026 12:14:52 +0200
> > Andre Przywara <andre.przywara@arm.com> wrote:
> > 
> > > +		pinctrl-0 = <&ephy_25m_pin>;  
> > 
> > This should be &ephy1_25m_pin, right?

Argh, of course. This was from an earlier version, with just one pin,
and I used that DT version in U-Boot for testing, so didn't notice.
Fixed now, of course, thanks for spotting!
 
> With this typo (and the one in patch 4/6) fixed, this series gets a
> Tested-by: Per Larsson <per@palvencia.se>

Thanks, added that, v2 is on its way.

Cheers,
Andre.

> since it eliminates the need to use hackier methods to get the ethernet
> port to work on this box.
> 

