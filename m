Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C139A4BA
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977994; cv=none; b=sFJ4uymSy4/rvFQFpwXWmDBloL20x28pKjol6xjCDS3V1haPOXajXrJAQYHKFuaajFepWHkGgRRW2V6dD+btxEI7Md81/2HrGP+eV10o9jUmYsXV/cASYBYuFhdeO2GK3Qr5e4RYOLIaLBwwFJVAFyqsWkvG1yfXW4E6MBmOdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977994; c=relaxed/simple;
	bh=AlMFWhcs+YKP5PGUmFYRDI98PWZvNa1cAeVqrOTwu68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTdCqZzuoU6yJb4VeB67I2DnL4nvbQXq4f8PSCrpoVpSEn34nPgSry16gtAX113CzKN/PgOax0eVjCOJWtDRa7Lb1sf+yZSquVATMc8rQGGTUgkBw12oERAJ9fHjBoMGw+nPcB2ALuqBedbEFqWDZv6Q0e/VjyI96CioB4cBpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+hsN1sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+hsN1sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295E21F000FF;
	Wed,  9 Sep 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788977992;
	bh=SrZkwe9j6uHF4QSy4OyCSL0ojz4au6a8EXrlLZ1AU0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m+hsN1snodl3OuhJn8sZryFq/Mhzoks6zjOvXa1ze9CeIuKmFCu4LWsr+WnImvD5R
	 V4oV3ldPybKwSeXKyiwDIcqjZ0NYvr4DFezQH+f1JT9eeAmNF4MIaYb7Udetnm73Ka
	 4SkqrfVdwoL/tgtcOGwci/uLy6JRxjAue4PYxa3UOdpDXo0PR1tHMDHH7XnpOXIXj7
	 fPI7yGiYrFhqiye8U0sIVori6/fzWcwULVHvr4WCamSlppIaUUdeLVMiESXjS/reJr
	 8YMajpnMFFVwf9RubCWBvXym3x0kZCt8v3zmD+RKPD2iOXutN7dNcC+YFYurl9PTG1
	 EyycFVutbg1Xg==
Date: Wed, 9 Sep 2026 19:19:49 +0100
From: Simon Horman <horms@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
Message-ID: <20260909181949.GM40544@horms.kernel.org>
References: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org>

On Wed, Sep 09, 2026 at 12:18:18PM +0200, Linus Walleij wrote:
> Fix two RX-path issues: acknowledge FIFO overruns with the correct status
> bit and bound descriptor processing when malformed chains lack EOF.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Hi Linus,

Perhaps it is a timing error relating to earlier work hitting net-next.
But unfortunately this series didn't apply with the CI ran.

Please (rebase and?) repost after the usual 24h delay.
Thanks!

-- 
pw-bot: changes-requested
