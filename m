Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B6199949
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715974; cv=none; b=jyiuZlx9G9BQwWViOtnrhmEIr2O0wxFSXPCVbNMXiPirjKpBc+bWJye9QTcbXp/Qb/J1Fp03BN/ykGhP+WeyQaMNOyV6tPvZTrXLxkh4c3YUBqA7k46UNZ2b8cEWU7DEa6aS9St5J+tLjmRDNzAy7mEKSAYIMIY+2f4jfmRCJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715974; c=relaxed/simple;
	bh=5xJVlL+N9r5Z2TJrJJIutgkVQBOX/9Em1SLwmodXU7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3w4zRyDEfaFdvFSpfHhwBge9K2a5IL6tuJhYvpb8hbItCTUpko7kZMMOp9SYyep0qRz9yyfRIz+ekTTTziyvEz5q3Zrl0WR7WBZyHSLXV2BLySRVrJbEP4LxlyGsHjBeIy53dcdFJIUJsQV+6CJ/jjJBmTIpzVTjRagpitP+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ5QO5o4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ5QO5o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717ACC19421;
	Tue, 17 Mar 2026 02:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715973;
	bh=5xJVlL+N9r5Z2TJrJJIutgkVQBOX/9Em1SLwmodXU7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQ5QO5o4oWAEQNOXKLsgSVRz5hWmYbipbPLjKNEmq9HvR3qPWMelvjLBGXMWX72Zz
	 I7PjsUVH/4guLxiH4fpqVc30yrErERME9z/cy3rFnqlRgEvSxb/MtrBEKT7rGJmzzH
	 to8DL4bHAYCv9M8jb7C0Eh+osiV4j3M2Nz8H/fvgMmxH2G9LBGAGsLojAEqEfpM+qn
	 Q8QE3mcOwRs1Bxxq5YLX4Lio9i4iQaS1jrWKq1OYokaJZAjhOpqXEHB8S2t6SjTebB
	 IS6NUeMIytzNeyVrlhm4Uy9J2Ikee1Y6BC7dATr2PNYKaTLAGkDVxeaAliSN4fIW4A
	 sx0jgGkDbui1A==
Date: Mon, 16 Mar 2026 19:52:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>, Heiner Kallweit <hkallweit1@gmail.com>, Dust
 Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v33 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
Message-ID: <20260316195252.7fa24729@kernel.org>
In-Reply-To: <20260317015257.79494-1-xuanzhuo@linux.alibaba.com>
References: <20260317015257.79494-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 09:52:49 +0800 Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.

4 minutes too early, v32 was 56 past the hour.

Jokes aside, can't you got your own LLM subscription? The mailing list
is not a public CI. Please do not post this driver more than twice 
a week.
