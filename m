Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A54126C17
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351156; cv=none; b=dlUUqBwKtO8Ta6SGSO+J175GiP3WPxRK/VioUSPnWDWbQLvR6NTR/ADl6NmnSzlJMbq7Dc4tHg4tCC22d2bBuoplsUpsvko9ZEqojEzqQtVTSn7wLz59MAuZt+R7hr8htprMpDxvO0jzZ4V/gP/he9XT5GBzCXEH+YLRWDOCA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351156; c=relaxed/simple;
	bh=KlwbtFdBidZX03B1KMJMkseSGCQeKwTbpUbKBMzFv00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsXb1gKoCo9zyvwhuZCm7a+yadCVEEKTrevaZUdBGjWZMDNkO9vhh7s6d62Z6yEOkxr4h0s27OyygwEORMTwjRyOF/CFb0Vn8CDmfD8Pl9i4zm6YTRLpCkf03NzZQ+ep0WyxYaO/NnGkyTMcAPiJQLXm1COQ/tfTVnlav7W6ChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cleAv9vU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cleAv9vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF06C4CEDD;
	Wed,  8 Jan 2025 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351155;
	bh=KlwbtFdBidZX03B1KMJMkseSGCQeKwTbpUbKBMzFv00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cleAv9vUcrTRIh6ynOTvtcCdVXhUqadLip9Eq/7Eg504SmV5mhVraFgylgrXtXHnx
	 WDJ4Y2L0K5vLf4v4cOUMhNnl7yw6k5VvHsahAYgXGD2nMkOFtbIt0q4NLGX3RoJYHI
	 ESfPRJSCBCjzjy1jrZnXB9koiyah2zxcc+GL5o7HkOSK+otr3ogXHTA9e6F6HNPj1m
	 SP0RDheZpDBppk8u0VVi2LIEBXga/4ijid+pI3F29UZhkjVWM8AT2CPp8MqLxJHgMy
	 ygXh2/me/rL4v3zyT42ov2w6ROvfmHOjcLsh1Ce4qZm28AAMTYrFA/u+XqUyAwA7Ta
	 P+tPJB7GFSXKw==
Date: Wed, 8 Jan 2025 07:45:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Rengarajan.S@microchip.com>, <Thangaraj.S@microchip.com>
Cc: <Woojung.Huh@microchip.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Message-ID: <20250108074552.3d54cad0@kernel.org>
In-Reply-To: <9328391fd5466aa406873dc2d1167be100ad340c.camel@microchip.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-3-kuba@kernel.org>
	<BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250107070802.1326e74a@kernel.org>
	<SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
	<20250107081239.32c91792@kernel.org>
	<SN6PR11MB29264E3220B873B6CCC4C318E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
	<9328391fd5466aa406873dc2d1167be100ad340c.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 03:42:30 +0000 Rengarajan.S@microchip.com wrote:
> > > Could you share the full name of Rengarajan S ?  
> > 
> > Would you share it?  
> 
> My full name is Rengarajan Sundararajan.

Thank you!

I'll send the updated set momentarily. Please make sure you give this
doc a read:

https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
