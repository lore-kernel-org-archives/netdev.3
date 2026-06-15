Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE84014AB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537865; cv=none; b=n+7pAQ1k3C2LyOHr6qRSqPfEwbXwOu6ShkrOXXVa2E25MdxZnlI7/UfWK1eE8xLeFviJ5DBdnJ5WWZmftx3e3qZFnIcGE/oUCTaCwA9OirboMSSCHkG0Cqkw7q15ppFfMdPqegt+g5GurUV7dEaHbDY8mhoRDs0SwvXhDWcyOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537865; c=relaxed/simple;
	bh=xqlOlwigqrIM/Y/+TBsFl5g9YdOJs4b6TsH6I6aIo+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5OesKb0jk/sscMTtcbS4PKc2I5xQdeB9F7g6GWESi3p8aco1GE8qd9GVa3xCCzp8Yim/kh4SywOMRcwnJG3ViSvz0IPoqu8wzSfkicP3zaZS55UMmwov/2OgJnCkKr463M+hRH4cgaS2BNCjQGRPB/STx7xAta3XccQGtKUam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okWOI/+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okWOI/+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090081F00A3A;
	Mon, 15 Jun 2026 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537864;
	bh=xqlOlwigqrIM/Y/+TBsFl5g9YdOJs4b6TsH6I6aIo+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okWOI/+k19+dyAzwZWyqbXmN0nlb2qHCkt/AARHABlxtartt9i7knE1zaWoGarAoW
	 uhq3z6Usd/tAzp7fHatR6cVHEKlJWl7IthHXS44CD+27pGEKas6ynf2uLTrWdczuvA
	 5HNQU+cEQhuFeu0exaTLVipBZ2HfqGWxbvzpxByFDOM2P4Skv57bHrrSlc6QdqU4B4
	 daXCgwQm3CEJeRoNzzBm/M7U2Yhi0GH6mqqkSIdZJ3CK7hO0THt8dJeGcPlv372ie5
	 mC8kmH3/zKoZ1I/kKfRTfQqPqME0VsC/ZIExO4C990cCi5xrcuVIeteIwH6IQHOnBO
	 udlgSzT10WZgQ==
Date: Mon, 15 Jun 2026 16:37:40 +0100
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric.joyner@amd.com
Subject: Re: [PATCH v4 1/6] pds_core: add support for quiet devcmd failures
Message-ID: <20260615153740.GN712698@horms.kernel.org>
References: <20260614050052.1048328-2-nikhil.rao@amd.com>
 <20260615153400.772876-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615153400.772876-3-horms@kernel.org>

On Mon, Jun 15, 2026 at 04:34:02PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Apologies, I sent this by mistake.

I do not believe the AI-generated review for this patch
needs consideration in the context of this patchset.

I meant to forward the review for patch 3/6, which I have now done.
