Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E413A874E;
	Sat,  4 Apr 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296205; cv=none; b=iPiNTl9L8whcl+uFBedbsOqcWOyctcqhZdvLoAC3aKxo95YfOP4AlbjrEsUpCCCpy5nHBHTfSozvFYrCkw1aJjeFroWkgfaRXYY1/doWq+YkPMIWNIPoJIf6XkKlhpskF5jSo7fLjtnFhJYq/PWhXSzh3+p6ClK6ApOEjtvJmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296205; c=relaxed/simple;
	bh=SzZZ4m6B0ylquAGc+B3H93RpgmwjD6lUxUD3s3bLtPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNg0AMs+0kO21KA23CMxOMZ7tewsISvVip9LVz3ze2XVGJpnE1/eAPegTNNvqiZ73f+xJtEN5c4h6MmQgoYB58i//EDvXdRXvzVFZMgneM/u61A4+Z+Ig2j1CRQ82t2hz5SZWnq7vPHBRHWN7HxTohqI859tmbffQFFpTdd3XPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7ERXc10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7ERXc10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB7CC19423;
	Sat,  4 Apr 2026 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296204;
	bh=SzZZ4m6B0ylquAGc+B3H93RpgmwjD6lUxUD3s3bLtPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7ERXc10YOzFApDzTz00uFVN3D9DhHhXGvQckkGINHCYtfRCi6R/giLLbyQ74iCQm
	 yw1dOvY8b9HpMj14fs0+krhPCruGawkFgFVF5uU+WKlwuCfRKnjLNaKs997nENO4Q4
	 ZpaQVsVhJ5JVJm9u2eObeDVkzI1r6YcI+2Um6kqqaTn2NcCfOvsFq6cQbv4nA+Me3N
	 E7M2tljMPfJWwjteVxkIzKpkca8mX+dukfQONSooY9KF6FNWLtT7K6UwU1BkYC5f7M
	 /csSSLr7LxHoBKa1wz2Dz/5qj0SXS1pXmIOf94imllNwEIfBFJiFvJVvGRo/Ei2klQ
	 QlcfBBoFFu2Qw==
Date: Sat, 4 Apr 2026 10:50:00 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/7] net/sched: netem: fix probability gaps in
 4-state loss model
Message-ID: <20260404095000.GV113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-2-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-2-stephen@networkplumber.org>

On Thu, Apr 02, 2026 at 01:19:29PM -0700, Stephen Hemminger wrote:
> The 4-state Markov chain in loss_4state() has gaps at the boundaries
> between transition probability ranges. The comparisons use:
> 
>   if (rnd < a4)
>   else if (a4 < rnd && rnd < a1 + a4)
> 
> When rnd equals a boundary value exactly, neither branch matches and
> no state transition occurs. The redundant lower-bound check (a4 < rnd)
> is already implied by being in the else branch.
> 
> Remove the unnecessary lower-bound comparisons so the ranges are
> contiguous and every random value produces a transition, matching
> the GI (General and Intuitive) loss model specification.
> 
> This bug goes back to original implementation of this model.
> 
> Fixes: 661b79725fea ("netem: revised correlated loss generator")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>

