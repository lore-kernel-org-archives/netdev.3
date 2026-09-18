Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169294EE85B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744381; cv=none; b=uw2NplemwgTrsj4s0JhKysUXNnEvsK3sGppe1YpkcxIJe5HFlL1ocHd6KLnGcgdmW42KRtDCOoMAexWp8bDUw3u0xHjhX5DB6iGGXOhTMWCy9K0xHcoBsZGm9ZiroivFEczpeGwkVlcv/CNLGug9GaEuLwb47VJ97P5LVaxMmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744381; c=relaxed/simple;
	bh=82vreFulPlcg1uO79gkXMzwVfLzwd10dmcKU7i+o5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syoRRkibcoMBgjIJCJNJv1tFJX9FYrG8tEZTYYI1eD/+2R/RuFRRQKxwIUeDI0x609u80hHq6Hg5Tlx3n2ROMhqfXcqy4oohlAJarw5wzY00MSy2q/YzbBwv9qeRcjKmfbYLV33ZiG4zg1oUuMhqA5MtqReancgjgLiQ7w9g95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA5iQ8Z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA5iQ8Z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA2C1F000FF;
	Fri, 18 Sep 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744379;
	bh=7JuQi8XVapmXzyrEu95EKW/BozLvbkCfRHxSj1WN/DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TA5iQ8Z4hCP5RAOqfpXSeQAgUVOqN1vr7DdPtDXihQy/UcW7ZhGzh2aQDgQ3l+Tid
	 2XNvYr+jgVnHHHEHm+L+MOJ5kWDpQ/9TBcfFSLhkCCWqfz2uhKUQY5gWdrNmj40OAC
	 d7CRrF8DlzhJ2Npw0zdtYQwnWW4+l1/AHfA7wZGP3QOLLWYD1QqoDtNWMh460H/jhS
	 MiOWr3cPbyh5icDRVVnPLG+vG0wNOzZnClzvKEnEKcRYFLfM30+ygbecy6RLIGw/dg
	 ZdqEAPyfFghFHYlRnkv3+RSxwDZlLlPWmJfELGEovu44pZxcHzq0WTslcf/hJiuMsE
	 +QmA79ogRUmFQ==
Date: Fri, 18 Sep 2026 16:12:55 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: Re: [PATCH iwl-net v2 4/5] iavf: fix TC boundary check in
 iavf_handle_tclass
Message-ID: <20260918151255.GN51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-5-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:50PM +0200, Aleksandr Loktionov wrote:
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> The condition 'tc < adapter->num_tc' only gates the destination-port
> check for in-range TCs; when tc is out of range (tc >= num_tc) the if
> body is skipped entirely and the function falls through to
> VIRTCHNL_ACTION_TC_REDIRECT and returns 0, silently steering traffic to
> a non-existent traffic class instead of rejecting the request.
> 
> Simply flipping the comparison to 'tc > adapter->num_tc' does not fix
> this: it would let every in-range, non-zero tc (tc <= num_tc) skip the
> destination-port requirement entirely, while an out-of-range tc with a
> destination port set would still fall through and return 0.
> 
> Fix this by explicitly rejecting tc >= adapter->num_tc with -EINVAL,
> and only then requiring a destination port for the remaining in-range,
> non-zero TCs.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
