Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A82DEA64
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557854; cv=none; b=DxdlhC40UpiwrBbxj+eBMpgeBYnki+l/9avQaGy8V6KKESdEulrelIOTjZ6/Ri3I/BSV2hEAdHiEl1dbSsjmNrJQfOB2jpuvK4QVN+KdcRolFUOsExZKpKFgr/zZ+mCtyyatrTb+SwFzkNf9Kty01vTNLXi8mHyYRrUT5xIRiCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557854; c=relaxed/simple;
	bh=rqxKWKvMZE9/vjy0NWZSUP0hbMN7FYhLl2QnYiQ5SAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxMTo1qEA7ZXJRYgxmWpAQ/TUCncJVaQTDxGHzBGcuDwUn72Wr1Kr6F8aIgNyKkqLLGqLKbHnkaSvH2UShvnOcAujh6gf/7e2zYzNMuMUr+wA4vzrNe+Q8VWa+2XiWZqcLI/CVYP7t6x+A9gpxRyRYccOgwSuoFCc+IQlDOnBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcAvnc4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcAvnc4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240CDC4CEF1;
	Mon, 27 Oct 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761557854;
	bh=rqxKWKvMZE9/vjy0NWZSUP0hbMN7FYhLl2QnYiQ5SAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcAvnc4cbU+7n1pD9lUW7uOZd2l2mkFvKdR/oUu/dJ1iAaQIWKJXsjT6lfyON0RUJ
	 ovaCJbr5+VWgk1X4It2oq8KYM7nqK2pwVX+I2FowIrZ+ZtEuSPN4RZ1JWgRSCopMgj
	 NbyvjWQ1Jl3DpgHHGqG6zmJziUjOU1uGnXcxjQ595x7B+565LRZi2LN+XzVZSqfVns
	 8/HRC3GjrwlK/v/HAi2GAT0FQ60GE6nNCPtteLlm1syrEsOv+/lZtA4V9ySrQfXZaV
	 Yiz+cBEO4cKQp9AIiUxxYvHAMpLn0VyHcslb2Ff4vVQxNLkAQ6+XxPmq1dBGKtV9Wu
	 C90+bBArXcIHA==
Date: Mon, 27 Oct 2025 09:37:30 +0000
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v16 01/14] net: homa: define user-visible API
 for Homa
Message-ID: <aP89WhbDEzt24sFG@horms.kernel.org>
References: <20251015185102.2444-1-ouster@cs.stanford.edu>
 <20251015185102.2444-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015185102.2444-2-ouster@cs.stanford.edu>

On Wed, Oct 15, 2025 at 11:50:48AM -0700, John Ousterhout wrote:
> Note: for man pages, see the Homa Wiki at:
> https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

...

> diff --git a/net/Kconfig b/net/Kconfig
> index d5865cf19799..92972ff2a78d 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -250,6 +250,7 @@ source "net/bridge/netfilter/Kconfig"
>  endif # if NETFILTER
>  
>  source "net/sctp/Kconfig"
> +source "net/homa/Kconfig"
>  source "net/rds/Kconfig"
>  source "net/tipc/Kconfig"
>  source "net/atm/Kconfig"

Hi John,

I think that the hunk above needs to wait until a patch
that adds net/homa/Kconfig. As is, this breaks builds.

Possibly the same is also true of the hunk below,
but the build didn't get that far.

> diff --git a/net/Makefile b/net/Makefile
> index aac960c41db6..71f740e0dc34 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -43,6 +43,7 @@ ifneq ($(CONFIG_VLAN_8021Q),)
>  obj-y				+= 8021q/
>  endif
>  obj-$(CONFIG_IP_SCTP)		+= sctp/
> +obj-$(CONFIG_HOMA)		+= homa/
>  obj-$(CONFIG_RDS)		+= rds/
>  obj-$(CONFIG_WIRELESS)		+= wireless/
>  obj-$(CONFIG_MAC80211)		+= mac80211/
> -- 
> 2.43.0
> 
