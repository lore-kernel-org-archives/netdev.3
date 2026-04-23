Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E92D0C72;
	Thu, 23 Apr 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971430; cv=none; b=WN8+JDfY/lNHbEQICdxxTJgFm9hrNk82UKbEDoaOl1f1STDWvcHMuukSVaydz++PXv5b3vGaAi4aWAL5es+NRHs8cubAuYf42S6j7Brs/qaEOmdyoqwVAfBATLRgpEGsPCFO8h/c1XmoZNgCyFXRTq4nlwge99zroUNjAgp16DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971430; c=relaxed/simple;
	bh=8CQFHiiCKbq7zgsrgaz6pt31g625ZCmmS9WRYx+cFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgbhxB4kSm+aONvPtXHzgprbE5Fo0nejnStsU3c03sdv6wlxsWNOIvb/pqa8sUTSd07YJwSd7T5ovdLFrkYkBSLheIeEfOD04i4c+wM5wPrq7Q9H8PiKgrRmrthI8FqSKWaLIbfzKqWBIwa7oKWIoN4+iDjt+Goo8WCT3+GyuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOJDR2Ta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOJDR2Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72BC2BCAF;
	Thu, 23 Apr 2026 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971429;
	bh=8CQFHiiCKbq7zgsrgaz6pt31g625ZCmmS9WRYx+cFBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOJDR2TaSqwBPtRjWf7v5oep4qFIuGzG/g3o4tiSorBKWkdoqualqifJVh2Xuipga
	 54JWsybnIUG+2wkSl1BvzFGNRvsDiWZdwrhNaw2Hp87DQVIy9KAkrSbDBQ6S6swxqu
	 mMJgO9n6yWwnahXM065/0pl2noCHTAxnoXmCA/U7NvVQs7FEZKiv/Up84qbZLgfBAS
	 bPglJbh52xC37tjeF8wLAlifQJLrXJpjBzV4vaTFuxlH5JF9lLN86GufXthbjchz2o
	 viTN6pQvbwVROCHWzNR5A7yObVXtgwcrvMsvepgSp9FsReNlI0zi/ba92O76lm0390
	 f05ewczxvc1eg==
Date: Thu, 23 Apr 2026 20:10:25 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: Re: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
Message-ID: <20260423191025.GJ900403@horms.kernel.org>
References: <20260421124528.162996-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421124528.162996-1-lee@kernel.org>

On Tue, Apr 21, 2026 at 01:45:26PM +0100, Lee Jones wrote:
> tipc_msg_validate() can potentially reallocate the skb it is validating,
> freeing the old one.  In tipc_buf_append(), it was being called with a
> pointer to a local variable which was a copy of the caller's skb
> pointer.
> 
> If the skb was reallocated and validation subsequently failed, the error
> handling path would free the original skb pointer, which had already
> been freed, leading to double-free.
> 
> Fix this by checking if head now points to a newly allocated reassembled
> skb.  If it does, reassign *headbuf for later freeing operations.
> 
> Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and contents")
> Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 1v => v2: Keep the passed pointer type the same, but reassign on-change

FTR: Sashiko has generated a review of this patch which I have examined.
I do not believe that review should halt progress of this patch
as it appears that the problem flagged pre-dates this patch. Actually,
its unclear to me if it is a problem that warrants addressing at all.
But I'd appreciate if it could be looked over as a follow-up task.
