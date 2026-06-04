Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0F263F4A;
	Thu,  4 Jun 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613738; cv=none; b=OTRWBNB9ZC6Bg1vYi3ySXMolBzV9wMHRUkcKfJZcshxN0yEwNqq0jvUrEKmLdSVj/Hv5WBjZCSEys4S2lXn2YuvhZGyf8HJIaQNCLaRVRvaUUbHiXzag2vlK1BUpOmA1AiYEmBMiaC6hCTCnOulxtIV4mIRMXW+dOO6m0FIyM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613738; c=relaxed/simple;
	bh=HcZsm+qYr6MG1H0x7EN55ovk4ALF/9RpoJUOgpbJrgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5lAL5cUERHuBuU9eBqNPkAfq/kS2q1xdnIahXDEyYd3syVInGbZ1UYcaWBXjQYPv1XLlmgL9VIW3br+195yetZLJungdM29DcYTpkWDUf/VoezMN2k52C8KV0/PeZeukY5fSWstTSFeG+BXyEkIeX9C/fmRDNvJ9gpcZOcrlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRPL097j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRPL097j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0551F00893;
	Thu,  4 Jun 2026 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780613736;
	bh=v+E88Z5ofHG6vsKwXAZCwJwlTj2po7duBoxSzzzG9TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gRPL097jOZ/0aH7fFsTdVSnTrxJmt62ZpGLgdPyXukAJahnGFbMZES7EEzhzL1xLO
	 wYXy5tP0iZ1r8T8f/fGVkI6UH9TXGIfYzws5s2JIoEHKqJfy/vy98NcGj5YRpqCD7w
	 v2FNFmW0Km1euMrrpTj0oUiR2104vJukTfsW3XwYVv3HLw/X8AqtNhUHQc32iok9dw
	 To6SkGkxhLkN79s0prMXDioc1Bd3jkARL5eB/f7CKfby6WMPoiOjWzwhGLCzdQqMd8
	 hYJ7e8F+tSvfJ6gD74VDUk3NPtWrqcOoduLWUvoXxCLYMHW5yml0+F1F8vWu4jZE8e
	 n6FJ7CO4p4rbg==
Date: Thu, 4 Jun 2026 15:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Stefano Brivio
 <sbrivio@redhat.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
 Beniamino Galvani <bgalvani@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>,
 ihuguet@redhat.com, regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260604155535.4662a95b@kernel.org>
In-Reply-To: <20260604183909.GA877115@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
	<20260529134045.56330243@elisabeth>
	<ah57wxGjL7JBORR1@zatzit>
	<20260602132118.GA508395@shredder>
	<ah-SvHdPRrYXX6lx@zatzit>
	<20260603074717.GA569921@shredder>
	<20260603174538.5454bb93@elisabeth>
	<aiDUMHKi2Sn1_dYD@zatzit>
	<20260604183909.GA877115@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 21:39:09 +0300 Ido Schimmel wrote:
> Given the above, my preference would be #3 -> #2 -> #1. The first two
> options expose the same capability to user space, so #1 doesn't buy us
> anything over #2, except a bit less code, but we risk introducing a
> regression.
> 
> Between #2 and #3, production software can't drop the fallback even if
> we implement #2, yet #2 requires us to maintain uAPI forever. I think we
> should accept that the divergence between IPv4 and IPv6 is not ideal,
> but at least it's predictable and dependable (Fernando is working on a
> ksft and documentation).

+1 to this, FWIW
