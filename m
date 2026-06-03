Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A937646E;
	Wed,  3 Jun 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511575; cv=none; b=nvzmgETMA45275FrvBOKQDc2BuZJHdo79PYvRuLtoxlIeQru9EHUArE04YVaTP7RIPTKOiZpIpbcjve5YrGVAMAAAjmJprHu5IcHG7WWupuJ8SLU51EZmZBx+eOBcVCzmb+yu123JQXkI5/f+Mey/rebg3aDzd2nhioK/xg/hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511575; c=relaxed/simple;
	bh=Or+hvxce+sEPgFelumGFymCFHJBZcWUny5H9fKrKFhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcMesVJnTUTrnIPZ8Bti2j3Q4E7sjDKyEWjVwhaazVdey8OfxWjg/8EbxhTnwLz2wxQG1Np5DoE7+fxXr3JCiqhB4Cw28+o+V22w9uViCcC/pxIccoeEahpQaS4I2gpO5i96mb/tKeSFmfzrSkGI9B6b4HgTkYS5rWpdiSqXLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1vuDAVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1vuDAVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FAF1F00893;
	Wed,  3 Jun 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511574;
	bh=gPY2pu+kFmzQjUUfL3ysiLAzza3ggJnJ0ow22y5D58c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1vuDAVN62beynYQhRY3qVxNV5+2urPD8D2cnKuAeB9QBauidlI69hn3sX/oipe1P
	 cTCtwYny9u64a7X3cB4Xzvcucl8LmreMHe9LfCcibJdOzjgd0D8Yp0x+1NPgWxyIJd
	 NoScEILhh7q3H4KLpDyc2ReU8IPHh8pEqe6e/07X0bGqmvXERIthHn5F2BhJDrnKd4
	 dYSrnipck9wdQ+c/mY5EWwd8wkUD8b8jUHRlkmkDzbo/JlLGSXGXM88A3nOtpgQNHi
	 2Kqfe8KgnKkk63ehdLF9e/J4RhSKiSxz6RCQu0sJeIukcD7zruKkR6ed779HdQGEB8
	 EzQ8+JxkptMrA==
Date: Wed, 3 Jun 2026 19:32:49 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix initialization of mcam's
 entry2target_pffunc field
Message-ID: <20260603183249.GH3766816@horms.kernel.org>
References: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>

On Fri, May 29, 2026 at 05:07:05PM +0530, Subbaraya Sundeep wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> NPC mcam entry stores a mapping between mcam entry and target pcifunc.
> During initialization of this field, API kmalloc_array has been used which
> caused some junk values to array. Whereas, the array is expected to be
> initialized by 0. This patch fixes the same by using kcalloc instead of
> kmalloc_array.
> 
> Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch available on sashiko.dev.
However, I believe that the issue raised there can be treated in the
context of possible follow-up and should not delay the progress of this
patch.

