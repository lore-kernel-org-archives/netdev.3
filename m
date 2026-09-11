Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB242E8D6
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121969; cv=none; b=nTECo/UZu2UwQsmO3R5P+6Zl9qt5MkHXi9KbAXvUwwUpoBhb/kDfDmBf2BDMFDEpoo4TV9gloBazfSVY45ShDyWG9bpcc+cGg+4QCcYLshcdKFbLcvWrH7zrsrn+m5SfsWzVrPiXTFrxuAJqCFbqTYwRSt7PXuSAQkoe5bieLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121969; c=relaxed/simple;
	bh=LyM82dSPAoxD1ECL3cim9jzMpE05vcHmndgsrH4nxHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sce6RFNNb+qPn8MqDQF8hmBADPX3y/fbyUrPSQ0fUaWF5APuTkgsN12TbnE7koXsUbLSMQx/vfSX/wr12EvUJR9kmwOQAb++Tj75kQrNzkKSY2FpL07Nf/GwRCVZOwcyhoTM98NG4RCUQF4T02a7nUdAvOf0X7NUaU6IwKicy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZIhiUjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZIhiUjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733A61F000FF;
	Fri, 11 Sep 2026 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789121967;
	bh=RujwQAraUAFps8XFWwJ00y0IuC6HN+2wM5m56sc/vpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZIhiUjZ2l8LZMATomme7DqNaXjDz/ghJ1aOwpz4WSYdndTPuYzlna1VxFSfyUdkI
	 HtNUV9pKo3N4HDusN07LB5Fi/JlIcO2lfMdqdBBaxoJhkNOXOiObN8jhuAQELcHNZd
	 YulQWUjlzjBQ0CGiiKJq9mf8wIjF3om8uzetYkvyQOa4PLN/xFCFQ1+gQyiZJ5vk+l
	 stua/1He6Ry9uDKhshPVfQwLGxklE4eOez4u0+2JmX8opNdayND5h13e5mMKsKiy5D
	 WwBBIdJiwF+/O1LgjfxaHe/ZS7tppBNDP0nZurEeaJEZqeCTsMgMIyjAADUcpVPT4b
	 bPOmDkbNBSjVg==
Date: Fri, 11 Sep 2026 11:19:21 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, mike.marciniszyn@gmail.com,
	lee@trager.us, jacob.e.keller@intel.com, leitao@debian.org,
	vadim.fedorenko@linux.dev, daskald@meta.com, bobbyeshleman@meta.com,
	asml.silence@gmail.com
Subject: Re: [PATCH net-next] eth: fbnic: Make Rx completion coalescing
 configurable
Message-ID: <20260911101921.GA48209@horms.kernel.org>
References: <20260909211111.1795726-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909211111.1795726-1-mohsin.bashr@gmail.com>

On Wed, Sep 09, 2026 at 02:11:11PM -0700, Mohsin Bashir wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> The Rx completion queue writeback coalescing window controls how long
> the queue manager may defer writing completions to host memory.
> 
> Expose this window through the standard rx-cqe-nsecs ethtool
> parameter. Preserve the existing 2000 ns default and accept values
> from 1000 ns through the device maximum (~109 us).
> 
> Hardware expresses COAL_WAIT in 600 MHz core clock cycles, or 1.667 ns
> per cycle. Programming rounds the configured value to the nearest clock
> cycle, resulting in an error of less than 1 ns. Retain the requested
> value for get_coalesce() because this error is below the one-nanosecond
> resolution of the ethtool interface.
> 
> Signed-off-by: Mohsin Bashir <hmohsin@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>

