Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D62ED848
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570304; cv=none; b=JZR/UlZBXVfO2sNx1zg6BiuX3wdHY33zKSDIwhVTqH10LIdYkojXmJZyS4dLzg0Tp0hCPoIpLQCS5iXbxCxXemMydemtoRsfwc7dySqe+OZrLqeXs909n0VFh4IPMpr1XEYaexJq3omZIsXqqxvFN2sRr4AKPAY4HmOTCaTuICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570304; c=relaxed/simple;
	bh=v63VXNRiErMEzPyNAAyK8CLla7qb3cZv6MPq9ttQTcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I36UBhrGYGzTdslNKjtuSsw0HGB35NV+5NzZ1fkIJ2V3xZDLU8j4ci4opfF8f9cdDgOG2ofQQ5L37HDpuB7KVDg1ffVsyOznyh1uXWlKGkb5NyFmrWcNFAl82SIsEUapfxql6KkeQJ8KRqqbAh8BBe/i1McbvlCqYPQR5Dg/6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUUA7XM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUUA7XM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B91F00893;
	Thu,  4 Jun 2026 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780570303;
	bh=vcoW7KWGgBnAGtAq2C3nsUBYOOY7+quvQvEKX1WPkoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SUUA7XM2lBhvdm07RFTL7HX8TrzHD4QbrGWbt+SeKp/ULtQm7jYm+t0kvNBVB+HLL
	 s8L1onk4gOwPU0TZQOD9EBf7jSksPQkrlGdSRIwxaU1eYCdPEk964qTE8qT6x0Y/tK
	 1rcbQZTvADWEd9bq1RIAoBRlO/2bBrq0auITo9xqIFPV1jbyp47P/s3l8m8saZcHQ4
	 sGJCcAmLzofEKiFoXkJLVkYwyhKTuZIjxa8ZuL9f/nLsUCKF2CL7NSrx1RUUk0s50Z
	 LIdaSCioFJ2Kk2sQ9qZUoNZqhAMZMtYjZ7Le+wLLD8d+wkoCoZVzLrc5yXzH6BbqUp
	 9aEKGmP9ATN4Q==
Date: Thu, 4 Jun 2026 11:51:38 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] bonding: annotate data-races in sysfs and procfs
Message-ID: <20260604105138.GK3766816@horms.kernel.org>
References: <20260602152748.2564393-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602152748.2564393-1-edumazet@google.com>

On Tue, Jun 02, 2026 at 03:27:48PM +0000, Eric Dumazet wrote:
> bonding sysfs and procfs read parameters locklessly,
> while drivers/net/bonding/bond_options.c can write over them.
> 
> Add missing READ_ONCE()/WRITE_ONCE() annotations.
> 
> This came as a prereq to avoid RTNL in bond_fill_info().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

