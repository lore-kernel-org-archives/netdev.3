Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D993A874A;
	Sat,  4 Apr 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296243; cv=none; b=UmYGN5kQCOCA7Vu0JrNNFaggToxfCxD4c+y2+8EAMxLUbCfzyg1SvfLHNZO0nRcKuDqkixLHMrYLIr5CADHuvDS2bVEHeLf4xMKm2BROQJjxf7byAHRpb7deGrawBeDpu+QJvkAn1jqtECNIH0dfv3HqKTPd2alRD3vMRf60z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296243; c=relaxed/simple;
	bh=A7CUD0VUPo8ONzbdbm9INatuwjcxSlUhHVxYjU2jlvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMCuLdIamP2BOdKFgqMAeCgSOjPc4XBko09JmO6Z5abbO30d70SeytRlVx9qxloeh6PHAM9bmRHxt7ezG5vAgHg8iu87SQO5qVmgHhksdWn2ZmhuDNezfimjPCpvsQWVMDwtj8ro6YgXkV9/3psIZxTE0tYtXTYy4K1W6hff+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYFKCUVt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYFKCUVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40BEC19421;
	Sat,  4 Apr 2026 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296243;
	bh=A7CUD0VUPo8ONzbdbm9INatuwjcxSlUhHVxYjU2jlvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYFKCUVt8h9gkcjFmXNR0rRq/JlszbgxYgrIzB11DsgxFKelANvaUm3I4zdNfqk/g
	 unbocUPQ/OcleQMlqb92t8c8rCpM0xHax97omQaQHFQ2hqslSIeV/O003oTHkqbv+6
	 ASI/VY+EZPpeoeU32XQkoW36gmjvP04+E8T2BEQ/hoU8RF4/EThA89fzPqlc7XKy8T
	 nW+4zLNM+gaY5p4oKGc2quA6O8LT9P7arYqChp8rAe4/fRlypmxqxXHxRMEU3bmZvN
	 JO04y22uyW5RsQBZ7kYq0bdHB8DaBcPMGo1eLhdh6hBDuSxnGSOr8ozXMWTxjFgL9Q
	 P3pyBQyMU9vig==
Date: Sat, 4 Apr 2026 10:50:38 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Michel <francois.michel@uclouvain.be>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 3/7] net/sched: netem: only reseed PRNG when seed
 is explicitly provided
Message-ID: <20260404095038.GX113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-4-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-4-stephen@networkplumber.org>

On Thu, Apr 02, 2026 at 01:19:31PM -0700, Stephen Hemminger wrote:
> netem_change() unconditionally reseeds the PRNG on every tc change
> command. If TCA_NETEM_PRNG_SEED is not specified, a new random seed
> is generated, destroying reproducibility for users who set a
> deterministic seed on a previous change.
> 
> Move the initial random seed generation to netem_init() and only
> reseed in netem_change() when TCA_NETEM_PRNG_SEED is explicitly
> provided by the user.
> 
> Fixes: 4072d97ddc44 ("netem: add prng attribute to netem_sched_data")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>

