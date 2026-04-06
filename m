Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593B12F585
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483395; cv=none; b=lJLjCMvC5QxAlxWUTZHHoBTPVUF8LHge0EAK3NOny5QImvwSwTifSEtYmFSE6GVgBwKzMkLnh23IjqiXRrvevXCHB4/yHxUvMrbI3H398dO8IyXJRNQCpPqSm8QPpQsxVQwzTV0IcEnryR8Zv6WRnFRfhHjHO878dMo+SL3lXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483395; c=relaxed/simple;
	bh=RZUsFfESBuVmb4QgvFPBzask0YG+d0Yv6r68Du3mDSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXJjDCnWuVt35vfqdMNm2w0nGOTkKcZnu3su8Qct4hz1Qe2jkBDxqWn8/kkf5OG3Mjmg8mNjxagUQppKbiVgV26hC9+4hqB5jTVFTOgq0SQc0ph4IdML49o4Hj/1/XwwTV4Rxf9eWs1HAUqCLHyo7WZL1tw0gW9BmYrkDXSKM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa5PIQT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa5PIQT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A43AC4CEF7;
	Mon,  6 Apr 2026 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775483394;
	bh=RZUsFfESBuVmb4QgvFPBzask0YG+d0Yv6r68Du3mDSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa5PIQT8fDA2c+/sIUoNm7sDYmv0YbaJm6hIx4yMCOYhIq9eANr/8jgidfH6381df
	 wnNkn05GA5VqfkzB2+x1Fg3XPfRflyXiUTJE0PnjuWQMoIgA8tZvrIAOJ6L8U7og5S
	 PIkEJ/m6iFx5JsoqsxGirREuGrTCt13KexUpqnyDriMWHUs8EUmRuqEqoAgntYFpQ6
	 gXEeHcnD41s7tQ3KwCptImCuvHrAd8d7Wl4KEqmcePRZ/9Gm6RaVxc3B987Z2CUrzP
	 9sZNP7wCS8O/9UPYcurCBAcQlfpVmyA3eZCZUta5CmzG2yCMLhfYa+YsPJ8tXG+Wza
	 EqpRZUYuK68tg==
Date: Mon, 6 Apr 2026 14:49:50 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: dropreason: add
 SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
Message-ID: <20260406134950.GA395680@kernel.org>
References: <20260403022443.3480770-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403022443.3480770-1-edumazet@google.com>

On Fri, Apr 03, 2026 at 02:24:43AM +0000, Eric Dumazet wrote:
> ipvlan and macvlan use queues to process broadcast or multicast packets
> from a work queue.
> 
> Under attack these queues can drop packets.
> 
> Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> 
> Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.
> 
> Also change ipvlan_rcv_frame() to use SKB_DROP_REASON_DEV_READY
> when the device is not UP.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

