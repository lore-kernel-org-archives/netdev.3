Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719E29408
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772586523; cv=none; b=ORWFs7tVx84sfb6epu+g6XY3F/edDpmIQOzISrTrJm511RPqsh5RUiapjjZb9G5+TQB8Jixk77qeZ8+yYE70KDq5e4+d6m8CawYwdlpJOjem0P0WT2pRHtT9NjKowTVrf2JXy1EiKd2KMZCaCx1CXc18PhtKgQsttj8z25xDkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772586523; c=relaxed/simple;
	bh=DQnIqIa8jSessrJ7z0E3IiEhGL1TxcQcGfMsY3LmGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTFLfibr+EHXe4rYKtKMXCfre2ejUtW+SmUsJj0B8cLJ3A5YngKNB99EMhqHsJZsp3tWoamn0YNJJIhAwGPIsAs8BxJoH3Rjsalo4Dho+uPMsFzf3DF285fxQfYn8CyxasRjBqucD/UpByt5oASN2fxCC3h/9W/OYDNFcS3H3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIIu8f/h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIIu8f/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A7C116C6;
	Wed,  4 Mar 2026 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772586523;
	bh=DQnIqIa8jSessrJ7z0E3IiEhGL1TxcQcGfMsY3LmGhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIIu8f/h12uLMM/JTLmvYi3N7DJbUrQKvJ6Kis/CcGxr63s+BWdLfEeNHqYWsLwKi
	 7UitPMzV5DQZfdiPCowI0H5dTPB6S5hVngVUwwBqd/nrYpAadN4w37WgCkeBKrWtC6
	 7Nj04rt65dWX+EbCtrJUCcmzrDw4T29y+bInIE2Z+093JjAoS54L9w4bihptxSk2mc
	 /RdZQ7MUw0wnpRDBBUNIlaQDpVyGUobsNeLUctSSXREFbmkj8De60DAmAXHT/B12w8
	 DvFyBUNf0JyaZkbfTPZZkErNEI7IpF0RS9jgDIOSYHA9/2envuu1cELQBT77o5prqG
	 /Q+Mqxy57BduQ==
Date: Tue, 3 Mar 2026 17:08:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido
 Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260303170841.218b0816@kernel.org>
In-Reply-To: <20260302154201.1621117-1-edumazet@google.com>
References: <20260302154201.1621117-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote:
> ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> even if this pointer can only change once.
> 
> Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> direct calls when CONFIG_IPV6=y.

Does not apply to net-next.
It sounds like we're going to remove IPV6=m, however, perhaps transform
this patch into that removal?
-- 
pw-bot: cr
