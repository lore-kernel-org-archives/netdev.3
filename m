Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77044314A6;
	Mon,  3 Aug 2026 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781716; cv=none; b=JVCLPAYoJ7gPnK8Ff1VKD7jKXkcXuU5AkjNDfDqAAiKO9fp6j+3F48yfOVvP7RVRFtuVmztvRHZBglYO7aetnwsXQ9v/dsRFk61pl2jh8RokG1fAjeaRKOt0DSSZmEigU92B8PFlNtnA2GSppvGYXW3oRrNRXn5eZtKMQNBRXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781716; c=relaxed/simple;
	bh=FaqHo9BudwEyHv+/rdoNrRmvIorD123rK4IvnWfTbmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d29T0awtiNOVP1/2y43Gn56wxlgMDETQzMm0ZdzypZB75c7d4Lpp0/HPvylYuyxxqCsFQc1DQy7YbV2PN4D6WUVlmi9KHhsnqf4jN4Q6W2SGWr5THV6Dx3a+BPRLnIx1YxR3dn2ZRBVi/CP960cIb/DU8Tpt9Dpnsyixy1xr7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egTSQAt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egTSQAt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428251F000E9;
	Mon,  3 Aug 2026 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781714;
	bh=FaqHo9BudwEyHv+/rdoNrRmvIorD123rK4IvnWfTbmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egTSQAt0cEFFuOuuL4k1JY87OH8zXcTq05yxOZF+JVRrUjL/4daKrXaxxqrsY6EFr
	 HjwHF6ho/pUoux2xNtdsWgPVae4gxXZdkRkIVv6sS4IK5Fj8B/ZBIfgkw9ZooYmag0
	 7hmMzvFkrVXuZvMHv+sFTJXLjCd/VuD69m2X9zO/IKBMb45E52011e+lq1NltqAf1N
	 roVF93TRdWvU3RDeqV31b7LA8ZVIqgytQS13zkISxF1W0OqRWQvWj4INmiF6zmThbv
	 LsKuk6zmd2RcfJTzn8ATFY1H6Y7ulL3R68nXXt+pAo27dbAbaKNN1FtCl68BwX4crv
	 QDHJfIFB0TWtg==
Date: Mon, 3 Aug 2026 11:28:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, Veerasenareddy Burru
 <vburru@marvell.com>, Satananda Burla <sburla@marvell.com>, Shinas Rasheed
 <srasheed@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, Guangshuo
 Li <lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Kiran Mallisetty <kmallisettyv@marvell.com>, Vimlesh
 Kumar <vimleshk@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix
 RX skb frags overflow and page leak
Message-ID: <20260803112833.0e5dcd7a@kernel.org>
In-Reply-To: <CO1PR18MB4747AB7BF286B86D25294844D8D72@CO1PR18MB4747.namprd18.prod.outlook.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
	<20260722090443.0c24a5df@kernel.org>
	<CAHPEe=HeQw_qtrrxc992q0v5CAys4ES3x1YTge4hev_2Z4B64Q@mail.gmail.com>
	<20260722132855.0faea241@kernel.org>
	<CO1PR18MB4747AB7BF286B86D25294844D8D72@CO1PR18MB4747.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 05:34:27 +0000 Sathesh B Edara wrote:
> Octeon_ep and octeon_ep_vf are not orphaned. Marvell maintains these
> drivers and will continue to actively maintain and support them. You
> can see patches we submitted just a few months ago.

My bad, I was confusing it with liquidio.
That one is presumably deprecated and can be removed?
