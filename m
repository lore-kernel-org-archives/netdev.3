Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443639A079;
	Wed,  3 Jun 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503792; cv=none; b=anTnSz8lLvkO8GKFPW+fpS+DnhNrDH3XxImZWwyQ+vtfG7giZuOK6tH0sh9unERb8TTeW/2LmnUH90tVTvr+1D+hw0hPbsdF0UdZmtekR+bEzPRmF0eL1F4Tmsn1Vfc9BdJLq8jidHNY5utQtFGuqVG3J7l0eH9zgR7C3MJ2ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503792; c=relaxed/simple;
	bh=bhPDkEYizj2vA6EDquDiMA1tOe2OrGhVbbRNZ4ZARqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOzjmPkX9NSKJOYUu57M3sxAb71bBAXSI1QNhQGB41qVyOP/bQowDOdM3+rz8u9SIh0chvBLywaG0a36fwCZCimmfJPyRwDH5rsS6RX8agNx9ZoGxEtAdsTNNAXQ4FSst0fvbEUsqF7JtLCtlN87MwC2ztKsZc1nSvN9XxjAdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6yRa7t7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6yRa7t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E11F00893;
	Wed,  3 Jun 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503791;
	bh=fjNBJrIha85FqeqfaconIz7Vic1SQcjfH7ztG0j9Vs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L6yRa7t7mogM9ighYdBQmCkIt9fqp1OJ0h5+tX7DamlCaxGi+hVxDfMLKfurkqgmE
	 CxeHLLImQaPMHwW8h5zkZ8vc7y68e5sarzff2FNNyntogppqUJusHvigB8jvrgh25c
	 l8R2b8BdJpFZBbQCPUxU5lxKQzRc7imcM7gLrRTds7rtCRsD5iwq9ip/KMXRMe52z5
	 CU4F42GKIJlfwLTvZmJjTYIsg1ht5MGdwgm26q/aiEzeWBHRCjP/YDXAUGuK/odycx
	 kx/FTucI/2LhQVPZFBMORoAoABUnr1JUPtwhdzVrJl6rs1HK/wDUHfshg0pvysnjtb
	 8pxb2G6k4A0CQ==
Date: Wed, 3 Jun 2026 17:23:06 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] appletalk: aarp: zero-initialize aarp_entry to
 prevent heap info leak
Message-ID: <20260603162306.GF3766816@horms.kernel.org>
References: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>

On Fri, May 29, 2026 at 06:50:16PM +0800, Yizhou Zhao wrote:
> aarp_alloc() allocates struct aarp_entry without zeroing it, but only
> initializes refcnt and packet_queue.  When an unresolved AARP entry is
> created, hwaddr[ETH_ALEN] is left uninitialized.
> 
> aarp_seq_show() later prints this field with %pM when users read
> /proc/net/atalk/arp.  This can expose 6 bytes of stale heap data for
> each unresolved entry.
> 
> Fix this by zero-initializing struct aarp_entry at allocation time.
> 
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI generated review of this patch available on sashiko.dev.
However, the issues flagged there appear to be pre-existing and I do not
believe they should block progress of this patch.


