Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D21C695
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400137; cv=none; b=elofnGkhI3GpdNCZpGpNxXuU1+6llNWQznsSxuVATXEvZcyPap7R7/32I0Z0jugnwCSVq+7R4cN/JGQcfwfySZs8ZSS1+lwR2uzyr7tFSXV/GP2xuBDfFediU1WWMT5zPkkKofN1+8eTuvzOjzI6v7IG1yiYysoEiOPjizTDb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400137; c=relaxed/simple;
	bh=T+mazuz88HSQp9AISBHa1RwblZqs3JqcY50r/r411X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBYA2U/mg3XcFZhft4o1Ae+atGWS3AknlBf+qrKnukhcu/OijqhddnWHHicw5U6QrMrZf9xYFgRBCyMWPjIOtCoLwkuasd6j2s/BnuULF142slBOrlqXBtScRTcaA0qnpWEmwsgkI8vPBcIVhEFk4SciuoAKvSnsASNwQYmsvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/4PQJJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/4PQJJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838511F00A3A;
	Thu, 25 Jun 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782400135;
	bh=F0IxRSwExU9yzE3OgxmfYZtXeHuMfQM2x5PbEfFY5CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M/4PQJJqSQMRPOkw1P5Um8Jjel0+bpENf33TyjEdCzIiIkXyqJEKPZX4rIlp3iOqg
	 RlfOsoSP+mOxGJYEd7iun0JWMtOp0kTgm/7/kY2wBONv78epnNqhrg8kwRWBIfPLzT
	 GFAyyjRIB/duuDrb7DkHGAG4yCXH/AREMjff4KgAdyKmXI865a/b8y7pPmBfAP6sBq
	 FmpJ0RUJwy5MWNOy3UO17ITFRmYJMnwqFREFmAJ2NHBm5q7Oqefm0lGfhpQpBuCNYF
	 jvGZ005yxsckfGDFWoh7mKenOFKobDATfQlN2c7PUlnQnsBesObNZnsVAx8AeKxv1D
	 4O91CK69vIbhg==
Date: Thu, 25 Jun 2026 08:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 2/3] net: udp_tunnel: convert state flags to
 atomic bitops
Message-ID: <20260625080854.06851faf@kernel.org>
In-Reply-To: <20260625065938.654652-3-edumazet@google.com>
References: <20260625065938.654652-1-edumazet@google.com>
	<20260625065938.654652-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 06:59:37 +0000 Eric Dumazet wrote:
> These flags can be modified concurrently from different contexts:
> - RTNL-locked paths (like add_port/del_port) write to need_sync and
>   work_pending.

These should hold utn->lock. Not sure why udp_tunnel_nic_lock() 
is locking in the callers rather than directly in
__udp_tunnel_nic_add_port() / __udp_tunnel_nic_del_port()..

> - The RTNL-less reset path (reset_ntf, used by netdevsim) writes to
>   need_sync and need_replay under utn->lock.

I'd rather add asserts to confirm utn lock is held everywhere.
This code is hard enough to follow as is, without having to
think through potential concurrent accesses.
