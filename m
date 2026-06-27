Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83081ACD;
	Sat, 27 Jun 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595831; cv=none; b=AYIIELYmVNmaXKnZCame/n438G2f+wrrE1/4hNKX3/Vl9FzHOrGeNBvkkIgz95jkfctorsI85O++5gMfYOykVjbsjclMd9tHgi0i90apvcG9ESNqs3utkC1yqXzeWNVITtro3dVZAr6lnbUdSbmzWdIhVN6edVPnGdrt4T3u91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595831; c=relaxed/simple;
	bh=krTNiPDsPuRh5LLdM0DdlxpaPCAeoJuT2fD7ycNc3Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4dEQAwUfrBIO3GT9+DvcwGgP5E1OUPURSXg2IbBDavbkNNqeftGMHJ9S9OIl5deBRccE7MccKF03PQZbAsBYwKqK1zp0cA82dTvrLnyeww25eZfRBUErXUeWyb6mQiUtauzakkayH8G+qK0Yo4ArRjXZHpZgwAXNw+/3kBL/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYkqtHXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYkqtHXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6A71F000E9;
	Sat, 27 Jun 2026 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595830;
	bh=7zmeTFPg9RCjxyqzDSGo/9G7XtLWMfidKxIsvz34kIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mYkqtHXGPooym5zZZo1nDJxpwIiv9Z1134InZEewnnzNXqRueS5ORaiC33uxAgOXR
	 ZLVw+Y7T4qM+XbFwZZZzYkMPHwhPA7cJ8XEItUYxu53Lj3tuK2f7jmndPSQuiwf6if
	 kud+E6D3YyaSZX0F3Xdd1MUbZB8QwcRvaEljHYp07gK+FYxndcMEySF4vtLD6zTFBC
	 EVjqNd+Zx92lKFSVknwZY3YdoEEXOqfzPAzyX96kLGqjuw63BItAIrefx8P6+p5noL
	 9srYxAWxYBy3rK44NzQ/0MNuZrBdyQ8bL896W5uvFLjLIqVK+vc7Il5rsVya7HGITL
	 AGXrn/QWEyGXg==
Date: Sat, 27 Jun 2026 14:30:28 -0700
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
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260627143028.5afed23a@kernel.org>
In-Reply-To: <12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
	<20260526172447.10ca4b9e@kernel.org>
	<5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
	<38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
	<58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
	<65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
	<5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
	<20260626173352.7dc8f106@kernel.org>
	<12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 07:34:31 +0200 Maxime Chevallier wrote:
> > This is very far from what existing python tests do in netdev.  
> 
> We can probably drop the class, as it is with this discussion, it's merely a way
> to regroup doc common to similar tests. The rest really is the usual set of
> ksft funcs you can feed to the run function, with a set of ksft_ethtool_*
> annotators for generic checks.

The common way of checking prereqs in the tests is to call a function
called require_xyz() which then raises a skip. At a quick glance - the
rss_api and xdp_metadata are good tests to get a sense of the usual format.
