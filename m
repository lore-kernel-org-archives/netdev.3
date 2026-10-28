Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227223;
	b=HApeIGk0WKXOhLnecfOzN3z0th+ks5lIQ/I9UXelpGJffhkNNLpFUHDzi8QqqBNWpMeG
	 Q1nk7wm86LsShoKx4y06AtFEiLbotnydVhqkVf7fenkTDNAhOPl0i4lM7BGoXH8pYYexs
	 lQwFztyeqcRJQwmeD73AtB8i5+qe0OkTptqTXqpnvXbJQRYOWnxwm73Iq+ntZzWkqANrP
	 +1QDetOdxJcmXjD07j2YE1PJGL8vKByzeXTxTtSmvrvggn+SbGfqMeaL1Nar/Stzh1/Rl
	 wUJ72oMHsqaXMoFG8LMbp1dOW98pzhCjLK22QpAnLQ2p7P58MZkgAcTnJNwn7Mw0WIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vchmSYkHmKdflmDG5H4EwLHNkjgm5d0ay44nIwMriHk=;
	b=bBbP3pTWOdP/vcNLz7pR1kHqQjVPpydRyNppI9Wof3OUEDPWcMpy5Sd9r22M2O89md1T
	 HjqOk0Jk8PIRm753nnNWfYDLZn7hUziVUeL1cTF73SMp311loCBnKytz17Piuuac7KdLh
	 kyBWJ0ZWThJGi+cm9/C4M218jHIWHSPcYgHWrrbvnkzXd2v34E8bSNoDFQyN+aaRB8jLj
	 4ARRDNyqaj7fz/IRmDoRkTqxW3Ska35q74J0rjdDW2X2eNtQnwGfdsmmfSVGtWVH9dGzK
	 ukP0iJrudUrLhO1yO6y6emN5wgw6FufKW3feVX9N14IjVURI2zyxUX+hvq1NVjQ3rAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUD5Ci5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81C606A31A;
	Wed, 28 Oct 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUD5Ci5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4131F01825;
	Wed, 28 Oct 2026 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227223;
	bh=vchmSYkHmKdflmDG5H4EwLHNkjgm5d0ay44nIwMriHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FUD5Ci5QgzzkrfJuYLXmShf04Voy43E5DlrgzUZzGdp7oSzWGW7JAPzDNaqOSWxGS
	 0DtyhFwCFRtb/EJi4MZrFpmdzTPeJuLm+0YT7/lOJ67vzaZPbYUskfhRKn6AbPgB+B
	 v60YiXlmR7274OuDjxKGGvl09Voic7T9U90Wd1mUUtlrWh4IwP5I+hILZ9DuUJXMS9
	 Nb2BdOIsDlUAhTUnXKffJdTDXMQAeyM8vps3CXPydvBiiOltYc6w/VfoIHOdvvI9G7
	 F66t/FXLsfrFLqVVgbBwqWUenuORsSll7/DDMvpqWbhVew/cjH6d5WKOVUXDNsRDUC
	 QuHzi0iLrUZrg==
Date: Wed, 28 Oct 2026 15:40:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen
 <tung.quang.nguyen@est.tech>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Message-ID: <20261028154022.5910cf0a@kernel.org>
In-Reply-To: <179286268997.95651.12726720970940214765@gmail.com>
References: <179286268997.95651.12726720970940214765@gmail.com>
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

On Sat, 24 Oct 2026 14:24:49 -0300 Joas Antonio dos Santos wrote:
> A peer can lower the link MTU to TIPC_MIN_BEARER_MTU (100 bytes, plus
> the UDP encapsulation header) with the max_pkt field of a RESET or
> ACTIVATE message; tipc_link_proto_rcv() only checks the lower bound
> returned by tipc_bearer_min_mtu().  The same bound is applied to the
> device MTU when a bearer is enabled.

Does not apply, please rebase on latest net/main and repost.
-- 
pw-bot: cr
