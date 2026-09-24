Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414823290BA;
	Thu, 24 Sep 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249080; cv=none; b=P5Mz2pw/4lW8uUIqQdWbFNR3pWZ8i1YIMqOFFQ045rgcDZkwYSCGjBy4ppGXop1BWqXuw9YbC0aGAUIIUiZ3QMKYH58jiV6K3RmrAHr9yk00y0Ef0my1XtcMjZkJj2qmfj3+pmW7zM7Ijl07k/N7GFfNk3zmRlk1xRlT8mdM6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249080; c=relaxed/simple;
	bh=3nj2S/4eIcXwTjeSxfFCd7Fzsb/BtkATWVo/2a0ZBDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRKy30WFIt9+wxG0cTOp91Hn1LtsqInOPkvrCaQY3nzwpz+iNahU28R1t3sUZbUDmTm8mhq5HXD+3NMky2G5FTM/aSDzA0UDXnt+c1WqjZGcEaa6vjOYyZ81Nl1REF3LAZZgiLzHs+9woM7QkxFJWQITB2/AeG+ULC3KGPxxhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM3z6UPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM3z6UPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E701F000FF;
	Thu, 24 Sep 2026 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790249079;
	bh=eeHx9p8W+zavQdOFh5Z81muF19kqe92MWdyI5wRv4KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GM3z6UPcfoLOogEli8aHsRAgiC5y3LgKgPF9siaQFzVqRK7EJSj+P8sQIJ0bYMq56
	 iwx/T2+HX+RFxHNqjAOuEpzSaAAmEpXyLfP3f4aGagn+LS5VvWJH8lqEybmvviHzlZ
	 V381wrMKam8koUft/JmxozRbG6VSRCIDyiCf0JscDOwObisa2Ru6BpPkoGhbXknzWJ
	 SkOp8urf2r9nNaqhPoFStNImL42lWiWO3rRPRv4WtIuGuDR+H7JCSoTttZOabscVoz
	 vMzFRhgMFiGnv9LWDnnMsJrXg+mCLq81k4TscdwL4nbmWtwsfuuf3dXcEIPumIEywL
	 Kw9nQNw1niD3A==
Date: Thu, 24 Sep 2026 12:24:34 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: benquike@gmail.com, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.aring@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: exthdrs: copy old IPv6 header before
 skb_mac_header_rebuild() in ipv6_rpl_srh_rcv()
Message-ID: <20260924112434.GC13925@horms.kernel.org>
References: <20260919210618.3028986-1-benquike@gmail.com>
 <179017599653.2160803.10920272565185423743@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179017599653.2160803.10920272565185423743@kernel.org>

On Wed, Sep 23, 2026 at 03:06:36PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

The above requires a response.
But as there is none, I will try to move things along.

> - [High] Incomplete/inverted fix in ipv6_rpl_srh_rcv()
>   (net/ipv6/exthdrs.c): moving `memmove(skb->data, oldhdr, sizeof(struct…

This [High] issues to seem to need to be addressed and the suggestion that
accompanies the issue seems sensible to me.

> - [Medium] Commit message inaccuracies plus an undisclosed functional
>   change.

And as given the presence of the [High] issue this one may as well be fixed
too.

> 
> Pre-existing issues:
> - [High] ipv6_rpl_srh_rcv() (net/ipv6/exthdrs.c) mutates the skb data
>   area without ever guaranteeing exclusive ownership of it, unlike every…

This seems to be a real problem but orthogonal to this patch.
I would suggest that it likely exists elsewhere too.

-- 
pw-bot: changes-requested
