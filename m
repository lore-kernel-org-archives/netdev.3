Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7F2DC334
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595458; cv=none; b=S9WznqcRTpWaJHxjRJLnp8v4VW2GcZvK06oSVsZ3Ayg+/4ym6mPpE1QHPM2w4JOGquCaT6qYlZI1SwcgQqmQPPNb6T1dfwFsVrzWqkhE1j4+NuGdeUR/RJq7X1mg7GIfD2LWGSbyovCVcGvX9ia8hF/z70pSvS2ZeiRZCgFAQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595458; c=relaxed/simple;
	bh=JRMHnmhfG3B6xuyQWjwZEprewEM6W3SPcwx8IxbuaCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dT4kK8+4a+jfhHcCyNnlaNh79sCeDqTXh+lwtjFjfD+LyAjcjfW0xvUzLKCiZTnGbAlkM7gDQGzblWT3EDrhaM0zgxu5BIG98rePjLTYo9YWQ+t1Eh9CtavgPVuSbfOPx+xlvg2AkTlf/oyidwqBqH9T/SWRvMvbhF0an63zLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phyikz3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phyikz3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787F1F000E9;
	Sat, 27 Jun 2026 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595457;
	bh=JRMHnmhfG3B6xuyQWjwZEprewEM6W3SPcwx8IxbuaCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Phyikz3pA74Q5lyDEZnuLRPA8xnBvrPk6KRxU27hLtNKfgClveMG409o6/nZ2419t
	 mTHRO4klxzICVLG47FpZTarp7mQXx+Y8l0zzBJQ6NJu8Sj/ngvlAVQjqxHif1f3q4e
	 7R4CnL1TdI4ApuIeZmfq/Cb/8kacH6S42aR3TWCmhvPTaY0rzezcySxx1TBy/90lku
	 vrHFlTj7KZu6dJyyU5byNDnjyz8hsAAQI+lYj9qJiC9B5oF73LfFkS4cVAdmTeuH5+
	 ziGG4lQ6bIc3c371OyB47P3OLLdyTZHILxHZrytFDt05Uq9G28Wemk8naU9oCT6Lbz
	 uY6y7zdD5NWNw==
Date: Sat, 27 Jun 2026 14:24:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: atharva-potdar <atharvapotdar07@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] r8169: migrate Rx path to page_pool
Message-ID: <20260627142416.249bb17d@kernel.org>
In-Reply-To: <20260627035241.59689-1-atharvapotdar07@gmail.com>
References: <20260627035241.59689-1-atharvapotdar07@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 09:22:41 +0530 atharva-potdar wrote:
> Signed-off-by: atharva-potdar <atharvapotdar07@gmail.com>

net-next is closed see the process documentation

Please also spell our name in a more usual way.
