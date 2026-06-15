Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC82379C33;
	Mon, 15 Jun 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525286; cv=none; b=FtQU3FRTAtIgLHKfEkZ1IwpFYIzsx3wabQWP+8KuoyJ1tyyguQqmk1C7+3xRqbuAemzuoJ/MZWJa+PXZxEVkV7sX12K72Q4MJJYbrvlOFLr4yXSkvRrELzfQk+IxJy3WFzBULfT3FzQ06DDoFToLQ4Y9D/GJEN1n22gVc5/gDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525286; c=relaxed/simple;
	bh=CwJUj6I5kPJ/A7PWvRHQcW6DKhG8kGLWzT1dGwVTm6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHwA/FzqrwWrc2jeS9ZQEtvtrW9SgUUCW7XZCiVynfapY0S59IYx4F2koK6tkCLchrkSriT4wyLF1wcXQcQHby017B/6zB4sbKLsyiDP9KUa4FbylCsfqvrfmLtoVM/jq04GqmM4MBxaLFwVediWjoxVUIchJfZc/BAg1kcEWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQXezVeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQXezVeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99CE1F000E9;
	Mon, 15 Jun 2026 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525285;
	bh=1mUZryqNrhJrA6yQ4bjuj9ZOB5+Z2b6bKF1iLQiqQNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kQXezVeJNQk6hi5xqqY6qBFU65wqDpm30pzdgat1bSKqOY92y7k7+Bh+tRw1q7L7B
	 bo5snRmcH2/hh9XvUoWy892UwX2dZpH2J/gs+CnR2p//o89OhOCnPkX/5DnHb9xqGm
	 WwYDAxjvdzuPe5yc0dELhQUqdZYlTw4UYOPBgek6YiHSpWZtECfJN/EcjR1mspo47W
	 lpJbGGkEi2SqifD/UEK35M9cXiS50Yxudsu4anYl7u0KmmoqVSoxS1oWTBk7QIeLfM
	 hibpMwkhNNPJoC5mOTMHB8J/2HgVKRX/JiUeJrJBjcRPjuKkjqXRmP2EkNefMOYpb/
	 S9eAaQqZkyLnA==
Date: Mon, 15 Jun 2026 13:08:00 +0100
From: Simon Horman <horms@kernel.org>
To: NeKon69 <nobodqwe@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, victor.raj@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix use-after-scope in
 ice_sched_add_nodes_to_layer()
Message-ID: <20260615120800.GA757061@horms.kernel.org>
References: <20260613101440.80190-1-nobodqwe@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613101440.80190-1-nobodqwe@gmail.com>

On Sat, Jun 13, 2026 at 01:14:40PM +0300, NeKon69 wrote:
> Commit 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> changed ice_sched_add_nodes_to_layer() from recursive control flow to an
> iterative loop.
> 
> Inside the loop, first_teid_ptr may be set to the address of a
> block-local variable:
> 
> 	u32 temp;
> 	...
> 	if (num_added)
> 		first_teid_ptr = &temp;
> 
> On the next loop iteration, first_teid_ptr may be passed to
> ice_sched_add_nodes_to_hw_layer(), after temp from the previous
> iteration has gone out of scope.
> 
> Move temp outside the loop so the pointer remains valid for the lifetime
> of ice_sched_add_nodes_to_layer().
> 
> This was found by Clang with LifetimeSafety enabled while testing C
> language support on a Linux allmodconfig build.
> 
> Fixes: 7fb09a737536 ("ice: Modify recursive way of adding nodes")
> Link: https://github.com/llvm/llvm-project/pull/203270
> Signed-off-by: NeKon69 <nobodqwe@gmail.com>

I agree that this patch is correct.

However, I do wonder if it would be cleaner to allow
passing NULL as the first_node_teid argument of
ice_sched_add_nodes_to_hw_layer()

...
