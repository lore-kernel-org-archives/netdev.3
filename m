Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F442F4A0C
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502134; cv=none; b=UFXf3uCwMZsnYSXhlCXS8/UqkptHKMqpwnQxXYOS/+eL7InjnQSd/QPQ/qXI0zw1OWcp05Gx5BBt9KOyCh5hPcYF6g2oIr8J5XLLDS/3FZyAFyh1K+296wvbDccy2YQ0TOk5edqvUf3y5HpPAGhs885hve4y4etkNPdhPUoM2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502134; c=relaxed/simple;
	bh=4TemnyeCphvNZp2Jwg3KkCeYo0iCn5hTXLLghBZO5K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD3Md63sNQFrJZMMrb1xXErUMnhbGitdjzAOfOgZpbi7BYFcnzKuev0URPrdd5Sh9rotFFJB5uppTyCQ8h4AZ0PFKThnaofXCNCWlNWcbPJfNkgtJ/0odNwIdHxXF5LG1eaR0u8m9vxN0pTp8jjAjGyJf82fg9uoRovgr9WNaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wA3nOMGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wA3nOMGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BCCC19424;
	Sat, 18 Apr 2026 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502134;
	bh=4TemnyeCphvNZp2Jwg3KkCeYo0iCn5hTXLLghBZO5K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wA3nOMGCR4R/FovnD2e1cmyf42t6E2tvRrflOwprTHsL1ea+oYG/V4PM2ENGN0oK9
	 YBa4//W98yo51FD6E6nBLduE1xfGyXVQCk2j9B2wNBCtgTp4aQgC2EJ+he3UJYF43x
	 4tR3nDphJtydGoZ4zWzIwIvu4ls2uvyhqKD4hSAc=
Date: Sat, 18 Apr 2026 10:48:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, alexs@kernel.org,
	si.yanteng@linux.dev, dzm91@hust.edu.cn, linux@armlinux.org.uk,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn,
	jiang.kun2@zte.com.cn, linusw@kernel.org,
	jihed.chaibi.dev@gmail.com, arnd@arndb.de, tytso@mit.edu,
	jiayuan.chen@shopee.com
Subject: Re: [PATCH net-deletions] caif: remove CAIF NETWORK LAYER
Message-ID: <2026041812-cringe-polyester-d039@gregkh>
References: <20260416182829.1440262-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416182829.1440262-1-kuba@kernel.org>

On Thu, Apr 16, 2026 at 11:28:28AM -0700, Jakub Kicinski wrote:
> Remove CAIF (Communication CPU to Application CPU Interface), the
> ST-Ericsson modem protocol. The subsystem has been orphaned since 2013.
> The last meaningful changes from the maintainers were in March 2013:
>   a8c7687bf216 ("caif_virtio: Check that vringh_config is not null")
>   b2273be8d2df ("caif_virtio: Use vringh_notify_enable correctly")
>   0d2e1a2926b1 ("caif_virtio: Introduce caif over virtio")
> 
> Not-so-coincidentally, according to "the Internet" ST-Ericsson officially
> shut down its modem joint venture in Aug 2013.
> 
> If anyone is using this code please yell!
> 
> In the 13 years since, the code has accumulated 200 non-merge commits,
> of which 71 were cross-tree API changes, 21 carried Fixes: tags, and
> the remaining ~110 were cleanups, doc conversions, treewide refactors,
> and one partial removal (caif_hsi, ca75bcf0a83b).
> 
> We are still getting fixes to this code, in the last 10 days there were
> 3 reports on security@ about CAIF that I have been CCed on.
> 
> UAPI constants (AF_CAIF, ARPHRD_CAIF, N_CAIF, VIRTIO_ID_CAIF) and the
> SELinux classmap entry are intentionally kept for ABI stability.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I think we should accumulate such patches over the coming days on a separate
> branch. CAIF is a no-brainer IMO but other removals may be more controversial.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
