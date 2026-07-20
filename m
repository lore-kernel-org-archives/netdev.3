Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948993E1211;
	Mon, 20 Jul 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545586; cv=none; b=jvhnXtAfL5i3IxckT8ume/o1IivmnlUjnEWKNEypYMElJ+JENQCKXLk04k/hLpeH+df946wPc9rz4ugaMR+JVxNvVfc0BETcHIiobffKxqCdxy/+bzEbBHzFve+4esvwk/N9bN72Zk061WlNHSkQ6trT8T4vCvg2xbc/wMjKjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545586; c=relaxed/simple;
	bh=7GOABv+AYuXQzZlQHAlO3V72hBM3trqznbKnM+hkbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQFcIjZwFz8PnQWtdtz1Ka0/lq1/2M7qa1snT2qJ1IRwSxxqc5yoFGNPYCaDQHtKbTpJaWryZt3JQdGAg7Is+WLWAbyVB00Q+dmZ6s6//GSlu+2H4Vt58Ern4PyvMcl1xwlVCKRKVFFhtkPQtp03N4pH07bUfW2STa5G7cuKQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G911/fl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G911/fl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C811F00A3D;
	Mon, 20 Jul 2026 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545584;
	bh=SHO9g24Kq3SD9aA1X2ub1fiTku3cJGmSjeTjaPLQiog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G911/fl8EkO0RFgXXF99hcT8qaFhsUyJk2tnwr+p90DteyB3R/yfx53n4oKsVUzs1
	 5UW1p48kRln3Fus+N0P0/N/U478HLPM7/RHWQCNtt/A5OsyjtdbiT/309QYiU1IDdo
	 SgfEZaId9+gikiOWgCqOushXTE5toIg6bGT3902joCUq5HwNM/hV1PExvGPAvKAUp/
	 0a4HQwST8xnWuWG93dDW0L4Uwow4S0QdD3ELsHw9IOQoNsISp+WcJSkY9KBYKd1ILi
	 psdKhUcFz5aj+j2gH5byXaksQL1Xu2WhhCvJUGUIlBFQ199WuEZ34Iwqz4HNHUmgGj
	 1BXaDOxF60hng==
Date: Mon, 20 Jul 2026 12:06:20 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/2] amt: fix use-after-free of the skb head
 across pulls
Message-ID: <20260720110620.GF19108@horms.kernel.org>
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 11:19:32AM -0400, Michael Bommarito wrote:
> Several AMT receive and transmit paths cache a pointer into the skb head
> and then call a helper that can reallocate that head before the cached
> pointer is used again, so the later access reads or writes freed memory.
> 
> Patch 1 walks every AMT path and, for each pointer used after a
> reallocating call, either snapshots the value before the first pull or
> re-derives the pointer after the last one.
> 
> Patch 2 is a smaller, separable hardening change: the three handlers
> that rewrite the ethernet header do so in place without making the head
> private, which corrupts a cloned skb (for example one held by a packet
> tap).  It adds skb_cow_head() before the rewrite, split out so the
> use-after-free fix is not held up by discussion of the clone case.
> 
> Both patches build cleanly (x86_64, CONFIG_AMT, W=1) and are
> checkpatch --strict clean.
> 
> Changes since v4:
>  - amt_update_handler(): also snapshot amtmu->nonce and
>    amtmu->response_mac before iptunnel_pull_header(), which can
>    reallocate the head for a GSO cloned skb; the tunnel-match loop read
>    both fields through the stale amtmu.  This is the same class as the
>    query handler's response_mac snapshot and was the one remaining site
>    the v4 fix missed.
>  - Remove the explanatory comments added in v4; the reason for each
>    snapshot/re-derive is described in the commit message instead.
>  - Order the local variable declarations longest-to-shortest in the
>    handlers that gained locals (amt_membership_query_handler and
>    amt_update_handler).
> 
> v4: https://lore.kernel.org/all/20260707193243.3448201-1-michael.bommarito@gmail.com/
> v3: https://lore.kernel.org/all/20260626111917.802243-1-michael.bommarito@gmail.com/
> v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarito@gmail.com/

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I believe the issues flagged in the AI-generated review of this patch
should not block it's progress. Rather, you may wish to consider then in
the context of possible follow-up.

