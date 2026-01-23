Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BE346AFC;
	Fri, 23 Jan 2026 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138372; cv=none; b=ZcJU3IIIRVUDd3FdEKVpj3gKShiFoYLc9ryj3DuW6MiR6jimFMJmthC8qpWHLSO1OuKr3KqmxE+D4/tuMhOHA5l2ZYcBeEZok5M6Gc3IQdrfBJhqjMMyd2M9qxJJ54xFiBfJ3hPn30OIKK02u2bQirE8v3fC97pkx9T4Fj3rvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138372; c=relaxed/simple;
	bh=y3T/t0lSLV5g6KhtsNll0AjQwXBN1Be8Z81EBWUaPcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaC1UpXoYxc9GECHZn29USSWNSObZqLbGOQ7pnsQxpUWhH4/JNSvRid/hRV4RcVr5iReXXn8OED4ApTIxPArGc7kPvcxhSH6DZ/UycE08OPUtE7QY0Myy6v6XOhtbJCFgE2TaDsIcQ8GUZTmNm5N4vopuO2B94Sb98xhIF4xe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=05t0QzxO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="05t0QzxO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LgF2IiBBgl+4u3dsiq9jM64amSwPsMv70P78RqO6sxo=; b=05t0QzxOYG0GgefSQyI6Wi1w1U
	2gTAblBFaFFhnSPxoky6SKiUn7tFZ2UvP1Oug0CKFzQFiQ+h5bEQrju3lJJjOcuKky2LUiEfnTtsz
	aTSK2BgJ2+AEmxkzxFHvJPJzsd+rfstWlHx+jNP8wjLH2XPYoGX55LK4X3m3VIX5b5bs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vj7hR-0043xL-7b; Fri, 23 Jan 2026 04:19:05 +0100
Date: Fri, 23 Jan 2026 04:19:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>

> > You say internal. So the skew is fixed, it is a property of the
> > silicon? If so, why a DT property? Why not just hard code it in the
> > driver? Since it is internal, different boards should not need it set
> > differently?
> > 
> Thanks for the question.
> 
> EIC7700 has two Ethernet MACs. Only eth1 has this internal RXC/RXD skew,
> eth0 does not.
> 
> So this is not a chip-wide constant that can be hardcoded in the driver.
> We need a way to distinguish the two MAC instances, which is why this is
> described per-port in DTS.

I assume the address of the interface is fixed. So you can just key
off that to distinguish the two instances.

Since this is an internal property, not a board property, it is not
clear it actually belongs on DT.

    Andrew
