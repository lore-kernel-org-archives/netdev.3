Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622A28003A;
	Thu, 30 Apr 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592154; cv=none; b=HJBsGOnAj8WYAlxbAJXz57zi9TNB1LdZJeciFw77GTR75+nBzFtnZJErWNmMTPvClyg0FaNFZ9/tvbAPHvsM9qpC6fYEb38EPWGMBbZGTHkNsqnFPLmdnji5jRdc5/cwwjwjJazX1kdTQ/2GsZc7e4tyf7s2cDVv83DUeLy9/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592154; c=relaxed/simple;
	bh=UOaPDNLQb+DWXRX86NYkdWJLMQr/Dt6uSVxCr2qRPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQTEOE+H50b3IaHHTkjCMOXxU1JZuJuwAIFhDJ3+XFjOwPV+L+R8z9CD5aB5jK5u67rduuwiWBDSq+KixmwbRWVdB0pr93MhUIW8bWGxYxJ3J9oVF6x++fAUxs4t43nJUD2KE4KvtYqSVphneuXxstQMeveM02C5y6WZ+N0TGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaefObiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaefObiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA394C2BCB3;
	Thu, 30 Apr 2026 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592154;
	bh=UOaPDNLQb+DWXRX86NYkdWJLMQr/Dt6uSVxCr2qRPOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZaefObiUhiS06GyO2ZPam7v+xKSz/xj6dDyzgiFyYF5vwMapPmxw1tjLpeku4NLqC
	 MNemy1d3JrJcOG0Jk6NNf+6YhMUlpqGil4LcSSlKqyMAfYs1D2uso3FiUdlp+smO/v
	 XDZtnFLVXIgjhIMQGDxFxXhJa93t5Z12b7KOm5uOpZaFN/3PlwFZQty9JQr//W2vqL
	 Vq054sIidcx3nsS2/NxotU3HYGyHQmcfz2fSk/UXIx19WufrApEtG037RRolFUxlTG
	 mayqczXLjYDszlo6fCq5NDr1S/jjjhfzeFH0Q2VuF9eMDultmmSXbQg3mPEEmemBHz
	 lDzLMIcnrmfEg==
Date: Thu, 30 Apr 2026 16:35:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: andrew+netdev@lunn.ch, devicetree@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
Message-ID: <20260430163551.7491407a@kernel.org>
In-Reply-To: <2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
	<20260427072508.1151-1-lizhi2@eswincomputing.com>
	<20260428180625.738223cf@kernel.org>
	<2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Apr 2026 14:43:50 +0800 (GMT+08:00) =E6=9D=8E=E5=BF=97 wrote:
> > Why Fixes? If eth1 never worked this is not a fix but new functionality
> > If you want to make this a fix to prevent incompatibility - cut it down
> > just to the eth0 changes.
> >  =20
> Thank you for the suggestion.
>=20
> You're right that eth1 never worked at Gigabit speed, so this should
> not be treated as a fix.
>=20
> In v8, I will split the changes into two patches within the same series:
> - Patch 1 will contain only the fixes affecting the existing eth0
> functionality, and will keep the Fixes tag.
> - Patch 2 will add the eth1 support (RX clock inversion workaround)
> as new functionality, without a Fixes tag.
>=20
> Please let me know if you would prefer a different split or ordering.

If you want to consider some part of this commit a fix it has to be
posted separately to the net tree (rather than net-next).
Once it's merged and makes it way over to the net-next tree (each
Thursday) you can post the net-next chnages for eth1
