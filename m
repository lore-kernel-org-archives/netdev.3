Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A36FC5;
	Thu, 24 Sep 2026 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219454; cv=none; b=ATnGPJ1E/XgNv8F3Tp4708cphvvyiHM0ULat8u1xEH+tIIl3vXhKXocUwVney2fGorIOVgPw7pjCogNXIgErEK8IE7Ravhkt+Z6JG8LvwJ3VgomcMWSQlkyu609YjrxLwF6fgAAX0uq1RPdwj1mgq4KijrUjlh5qn+R/Il+K42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219454; c=relaxed/simple;
	bh=iH4cEpl2yToItacpJlcr0go5y/MtuKmQ6AJgqp43Omw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwmvnSlM2pKZfQ746EpNrGhMQ2iuad/QEZ+6rmrBgM3LuSXq0k+Wr82dhNn/pYLfw7frxQ8+TN68BLERR8EsQO/JxaiDOdUlM7flAbjVLeYKDfyez5BdKT+IMOqax+Mb5QJAytxHA1tTF2AhNvlpBfXBCZbfJg2mYc6hYeWR6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9LMcnhm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9LMcnhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA9C1F000FF;
	Thu, 24 Sep 2026 03:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790219452;
	bh=T+kv6vT32SgNczfSVs4UB09X7kIz5tk+LRTRTrrfiHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S9LMcnhmr1FQU7ak8xzn2dYyDFVYejUme2YYBFVZ0wV9sKVjev2/g1J8TQ03Eocfa
	 Zh9r+LDzX0qXSZawEsI4Z2fk4YZ+q1YToahvsMpNOvAz/XJM0KUHBjZ0xqSivYYrK+
	 qPAJacP0bgDYdcluYtmQkW/x5ew7U8GewQ0XJlA1g1/z0TSHeRSVOX8Pvxwgo5W9ct
	 5ANz0KOP0AxC+175kTZ+6PV28J8TmeE62+Zj+4NC/+PVvrelc9P/uPssJhtw7nhxVw
	 OK9vHww+5LM0nKd/9xPjnqeqbyDSscYs1/PpPU+kYAwteDYzxM57FP2sKIApujC7L1
	 9znGcYCdTo+aA==
Date: Wed, 23 Sep 2026 20:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <20260923201051.66e9bf14@kernel.org>
In-Reply-To: <72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
	<20260920164732.349744-2-maxime.chevallier@bootlin.com>
	<20260922194251.06e00e2e@kernel.org>
	<72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 07:41:13 +0200 Maxime Chevallier wrote:
> On 9/23/26 04:42, Jakub Kicinski wrote:
> > On Sun, 20 Sep 2026 18:47:27 +0200 Maxime Chevallier (Netdev
> > Foundation) wrote:  
> >> Future ethtool selftests are expected to use the same, these helpers
> >> are put in the net selftest lib.  
> > 
> > Please resist the urge to create libraries.
> > 
> > If you're doing this I suspect you didn't even read the README and 
> > you expect people to search around for libraries?  
> 
> I did read the README and fought the urge, that was something Andrew
> was asking for in the previous round :( I'm ok with either TBH.

I guess it was Andrew that didn't read the docs then :)
