Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6157369997
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390958; cv=none; b=EhjO4W+n5biw9urJ6hzdqJXnFanUmocuAAFAPe908i+lgUBNP5vXEYj2WAAEaOyGWc2jZRpHn3N4gLAkmpdhOq2SCAkCFAUQVbKvansXKz2+AwWo2G9885sLw1BuXJEpPWvypxu7x+5mArV1Oxfksb6aaQYASTN6Jzw+9tcrkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390958; c=relaxed/simple;
	bh=Yt+oiNxM46JdJ0iy4ss11GdaLmVx4/rlRnbghOC0MfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbct2ckEhPxx34WPIhg0TetRepTs1WNtMG7tu7A6RT5VQS9eplW7D9LEXv1xwPOYngg69aXL9zBDHxa/ZRxUZsS1ONRgqzH/g0HGhx19mrylZK/rxBJLwvLXGf6O94tDirSxIOjBXufJ/ulqv23XFDn2eG4PTTp3ao60nO5nJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOadDIBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOadDIBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A202A1F000FF;
	Wed,  7 Oct 2026 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791390957;
	bh=e4R5H1VHFPTdlQOeclhU/gW1RzRmpoMnz5h6gNpuP3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iOadDIBeDKcuSjY1nXkaAXz9MQh+hPJSNcczktkWM5wnJsaLGoebONJ+z5SgbWyPF
	 0P8peLF+3F91qw6fYxYLsg2Ycfs0RuhnFRq7YlD3MXDSiQwV6FPMxk+xpuYT4k0ycI
	 37Tc2BrwxR/eDsj6OXrZAnup5PfQP0exfpWgtW+1DFwm+D1RDkj69LBZDL0J/3E02D
	 GQH7Y9LVZh99q/8ZAxFsrbWbBAL8oPZuVjMpwWkNfDA4BfkZiQHzkBKKY7K3xcwA7j
	 ioPMcMwcH/PubndO7/Oj1aNtOyPSoNuj2Ojw26oFtXhkQ/OHPj5bBeoQGYlh2AIn9k
	 PQLcyIKVu9xgA==
Date: Wed, 7 Oct 2026 09:35:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific
 wrappers for neigh_lookup() and friends.
Message-ID: <20261007093555.66e9194f@kernel.org>
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
References: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 21:23:13 +0000 Kuniyuki Iwashima wrote:
> syzbot reported that ip6_finish_output2() could pass tbl and dev
> from different netns to neigh_create().
> 
> When namespacifying neigh_table, I chose to resolve neigh_table
> in callers to minimise changes, but it turned out to be error-prone.
> 
> This series adds IPv4/IPv6-specific helpers for neigh_lookup()
> and neigh_create() that always fetch the netns from dev to fix
> the problem.
> 
> Along the way, the confusing and now mostly redundant helpers
> __neigh_lookup() and __neigh_lookup_errno() are converted and
> removed.

Ido, David, thoughts?
The unusual (for Ido) silence makes me suspicious :)
