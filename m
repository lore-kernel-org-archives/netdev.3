Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F02571A9;
	Wed, 10 Jun 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055552; cv=none; b=DEc8GPglI7QrTMIh3zAPo7zWDF89gn+u/rP0+/9yjKkYT+3JhYlN4ehqUUmyf+rj3oThyf6EQXhyjN5etp10BtNhZV8W2WLOhXyI0RnApPnFh5UgKUoFjFqWb698Wia7GyvRSGtM9HXVeSr/qku+1MRd2Ch1jg9QuZmBD4UZcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055552; c=relaxed/simple;
	bh=KfHn3eD+CC9P6O5K8rIz31OQFPgDs7YLARSx4/zAYoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDs7LE0YG1V62ldTuObY+OLWDnqEUorjSuYvr8dYxXofVHWarqSCrrWVMyemPrv4RccM6v9/QnTB1icvg0ztkv2QaJD+llx4SCr5mrH+RXv2M7c2UzolfttJvY2wbQU8PHC9g+xi6UgHphY1CD45h/fO0/A/YCULrvrx0KJeJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+MP+Kz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+MP+Kz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6621F00893;
	Wed, 10 Jun 2026 01:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055550;
	bh=7vd+Y//vQXiHzoZvZTOIH4tYtPvAsV/Qxv8iBCfZ54g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b+MP+Kz+rQOpNgSjHLfiGgfL1bqHS6dnKl7U8NxCUZDtatmjPtbf3lN7j1ecsAEQH
	 CbCBClb4uvu3hWatXWzIfzW2mbARcY5pTKd2jKBJvDdnyD7PyTRpd6czFTXed6/omh
	 W2ZeY8tekCmMmmEXWStkuetf76Md/U9Oy6C8wXZUxfXqMf0ObULRUK3Dkco0sCgRym
	 zNhVV8zVeFCTqbD49rgHdEO7j33QDHas7tt8xyLPnE9uBVCFLE+jFx2Obb09gY4Yj5
	 p1tsLk/OEZBOUH9cXB0iQnTXp5vu38K5BQt8bptnh8nG7dDUO8ri5LDX9jl1xHq9EK
	 pJ58Yz01B8F9A==
Date: Tue, 9 Jun 2026 18:39:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: timur@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: emac: replace strcpy() with strscpy()
Message-ID: <20260609183909.2fa53143@kernel.org>
In-Reply-To: <20260607154423.67146-1-dennylin0707@gmail.com>
References: <20260607154423.67146-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 15:44:23 +0000 Hungyu Lin wrote:
> Replace strcpy() with strscpy() in emac_get_strings().
> 
> strscpy() is the preferred string copy helper in the kernel and
> provides better bounds checking semantics.

strcpy() on a literal falls under pointless cleanups, IMO:

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
