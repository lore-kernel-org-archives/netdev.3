Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615872;
	b=UgO9sn5uWX4nqqOhhyajuRdGAo6C/wep8n0v3spH6Ue513cg25N6OiX8s8LMLnijFFkc
	 YBQmz8y2UXf+qMkftVjyIygT+rRJrhLfjyohmNeWyIRjIwE01zigCsZci+0/rcNPll6pK
	 0xV749AfTnyxpe1ITLPUM0DK6L1lOE33JGSxVjMO9RCuK6pqu1Sf/wl4CO3yuEXYjKy9G
	 OLPenmJlkgnuCo8ZRk5/tSnsBXimNpR5/NJH9hDnE9eIhzq/Qg1t3rcG1FMW6j+st91T9
	 pjILKP2e1+KGI43FgFQbm5uLrL04Oz+MR87dY61LdMcrc6xVIEy2HJredqukxLt/ELw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615872;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8oR1TDc30vS42tVdKEBQYLBfET+uiNtd4gBWPh5UKow=;
	b=My5sCENIe6lt8FrXE4Yz1nUSS/lcFnykU9maGvZ2U7lcBVWQ9RDsdXUyGkV17AAedT1T
	 oVmftYMfZJX/EPpOFlNr3SsVwz1g3MIHpMm9wzV17YQYW4fT8Teyptt+cWEIYgcBzonDN
	 mC1uZ9/l0ELQFrXVqFRsTXZZpAvF2Wm+1Dwj13ideO/zgYUdS4yWELjqEuXV15i+ySXwZ
	 F61XW6qB8J6A2pYKn8GRRoHokcR3N2h8rAXmhLSeMkiw9eMqDJLOuYpCl5h5roGBV2QWJ
	 9+HMB427syt0rL+OSCHOnNhXvr35CcL+cKiW6fIaPkeIoMsL/9hAdFjxL4aWOVXB5yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ie2mhpbe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AC606A319;
	Wed, 21 Oct 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ie2mhpbe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1441F000C1;
	Wed, 21 Oct 2026 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792615871;
	bh=8oR1TDc30vS42tVdKEBQYLBfET+uiNtd4gBWPh5UKow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ie2mhpbeMqHER1Kb0zy9CbOWwdmNdVCT2pegFhnoiWhETvGcs56rXEPOBIbk0kytj
	 5TT4aXQK7MFhS3IIRwu/xRr91TaNjMIdd5PT3JYDTr/OK6RgPqplR2tylMQQJa1ATI
	 Ggqu+vi5UhVy2aCfaLpK+VGAKwpw7Xish6Nt2I28mw0M4pGwvsA0IXRkFKypCdY1lq
	 8DL8BSXSFEva2uPUZeJHOPau6w1vNULCYrGhhFcJ5B1rrySfBjSX6D/aOhxnCNkUjz
	 F6T2ijz0ZFDFImMbwjTWTC13HAvc+hg7TyFVmTlN97oZdAuRb1cUKhBbh/IcohsTw1
	 5Ej6XMQl89fIg==
Date: Wed, 21 Oct 2026 13:51:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
Message-ID: <20261021135110.785bb935@kernel.org>
In-Reply-To: <20261021155715.30094-2-jain.sm@gmail.com>
References: <20261021155715.30094-1-jain.sm@gmail.com>
	<20261021155715.30094-2-jain.sm@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 21:27:14 +0530 Shashank Mohan Jain wrote:
> The problem was found by code inspection, assisted by an LLM (Claude
> Code, Claude Opus 5.5), while reviewing the commit above. It was
> confirmed with a reproducer in a qemu guest (two netns joined by a veth
> pair, "ip route ... window 4096", tcpdump of the SYN and SYN-ACK, and
> TCP_INFO of both ends, including a SYN cookie case), and with the
> packetdrill tests added by the next patch, which fail without this
> patch and pass with it.

Sounds like a genuine net-next material. Please drop the Fixes tag
completely, and repost after net-next reopens

If someone disagrees please speak up.


## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
