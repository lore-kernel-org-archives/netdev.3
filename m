Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4554EEA5;
	Tue, 22 Sep 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087110; cv=none; b=P6y6py8KoypK2f+vTj0ZH5rUgNITG/QWh0xcdoMdnRqNLYmsdlir3NalULONpQJebh6U3e8oVH+yycCzbAqwyEJ59xxh6sjHxO90QtbmMC3OIJBCrk+kRtpGTXD8DpBQnPN97OzTXj3EFL43kKMCzJ7D22wZ1prP5iVd6z2a+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087110; c=relaxed/simple;
	bh=OEPf1DHbYLRp+U95w3TDZGGq76TMsSYLp5J77gCMCF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0RUfQ3M4jtgYlCPqx4V/fIovCUY9uf4NVdUIgP/oHouWYq/+aXtnALmFa/tG1uY5PGvyhhbtyq6fXM+0d5QUrCs1C8ADXnstUqb56Lz+7zX0Gn5rseU3YzuUrK0w6r8pFZ1/kEG63SIDL6rqqUCc9UMr1Xa7Zu+qgy3yVheAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfDurrLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfDurrLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748C11F000FF;
	Tue, 22 Sep 2026 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790087108;
	bh=EVZnlPkgPlP0JdUsO54GE+/u6fUDYx0uLnQOtCq0qek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfDurrLcTaGuy2kSlTJdFaV8U9XmQfz3XVWupekrsh7VHO/6PCN9YT93BVYt9FRbm
	 9mdHMODKadgSg9WHa2SXxQgW14OTge24xtWajx0rjzfHPrjuIlMka/Q0BfCrSfBd9/
	 9ka9434fM/4WXKsUymAyAnQk/bQyY8SDA4ytOXOHjSv5sVjr7h0FR+VRwD4qtLZP8T
	 SUpcIjj5tS34EcVLGEhqV15LnOPrlnvZ4AoyU4H+0YcRsh/rUTu5Xik1saY3DyUZv9
	 Brj/wLjgvRcwLnv7jqQQr5QkAuodREr7MlvZ6xacSNKKMz1rFP+lqG+1UsR1sawfzt
	 D7nNQvtde6KbA==
Date: Tue, 22 Sep 2026 15:25:04 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: benquike@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: fix bsd_decompress() OOB read and
 ppp_decompress_frame() headroom check
Message-ID: <20260922142504.GF13925@horms.kernel.org>
References: <20260919215233.3470411-1-benquike@gmail.com>
 <178994484954.2160803.7340548461955780287@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178994484954.2160803.7340548461955780287@kernel.org>

On Sun, Sep 20, 2026 at 10:54:09PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 3 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] ppp_decompress_frame() (drivers/net/ppp/ppp_generic.c:2555-2557)
>   now calls pskb_expand_head(skb, 2, 0, GFP_ATOMIC) unconditionally on…
> - [Medium] The commit message states that the decompressed length 'is
>   only checked for len < 0 before indexing ns->data[2..3] and calling…
> - [Medium] The patch hardens only one of the three in-tree implementers
>   of `struct compressor::decompress`.
> - [Medium] The new pskb_expand_head(skb, 2, 0, GFP_ATOMIC) in
>   ppp_decompress_frame() (drivers/net/ppp/ppp_generic.c:2556) creates…

Hi Hui,

There is an expectation that AI-generated reviews forwarded to
the netdev ML are responded to. That can take a variety of forms
including an email response that agrees with or refutes the review,
or an updated version of the patch with an appropriate changelog.

The expectation is the patch author or submitter handles this.  But in
order to move things along, I did take a look over these and taken together
it seems to me that these issues warrant a new revision of the patch.

Please keep in mind that distinct problems should be in separate patches,
and related patches should be bundled together in a patchset.

-- 
pw-bot: changes-requested
