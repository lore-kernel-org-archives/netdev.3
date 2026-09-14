Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5F372EF0
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368585; cv=none; b=Nn1CtXjddClrphef+H/IFAnBrxXThJfHimlJu3iYPZ7pLHQyyKINDmt1M6m4fxbpM9jSzyOSEVmQCZ5cTjqBNb5diIWW2Bwv+KifMTniQMvJNLYHkBSGxdcoGmNvdeEeG+JODfeOT0Yb28K1ItKCI2kbkqtKb2LB/kQAxyoqp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368585; c=relaxed/simple;
	bh=84Jr038UxuXD3UJldXXHD2Fmd0qlAhVjXgjcrpGHHx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqixa+2qkUhIMNPu9ueROsO9RJURGHis5b2Y8a6zEK2DDxn6TnUV9EkNSj4c2kquIVnuSjkkZK0czkttFtR2DjNpV8WSdJVv/6mKn5SE3Y4LywZrYppQtO4MzrsTZi4pJwrC8KqbniHweh6tvbHTl8bVgBSEwjV7ZnYqE3O1Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qF2ubaql; arc=none smtp.client-ip=91.218.175.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qF2ubaql"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=84Jr038UxuXD3UJldXXHD2Fmd0qlAhVjXgjcrpGHHx8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789368581; v=1; x=1789973381;
 b=qF2ubaqlpXZA0QoWpkN1n+OOW5OQNEUKKZN1ZUkgsNj50RDUq8yHQeDT3BokSD3WmYsGGkRY
 gNUn1bAk9s/peHeUDEgnzmXQtP8+Lq/I6JvRSV5KjsIWcjwwBNLvaY+SkYSCPtF52n5d4ynKwoM
 PhsGo+2rAFKuRmh85OsyDN2M=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 52dea20f1894b7d2;
	Mon, 14 Sep 2026 06:49:41 +0000
X-Mizu-Trace-ID: 52dea20f1894b7d2
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 14:49:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com
Subject: Re: [PATCH net-next 2/2] netlink: specs: tcp_metrics: drop the RTT
 shift instructions
Message-ID: <aqeY_G3XtQ3zSE0k@fedora>
References: <20260912234337.308298-1-kuba@kernel.org>
 <20260912234337.308298-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912234337.308298-2-kuba@kernel.org>

On Sat, Sep 12, 2026 at 04:43:37PM -0700, Jakub Kicinski wrote:
> All four RTT attributes tell the reader to left-shift, which inflates the
> value by 16 to 64 times, and the two usec ones say the result is in msecs.
> The attributes carry srtt_us and mdev_us, which hold 3 and 2 fractional
> bits. The shift to get the integer part would be a right shift.
> 
> Drop the instructions instead of turning them around. The number of
> fractional bits is the part worth documenting, whether to shift, divide or
> convert to a double is up to the caller.
> 
> While at it fix the acronym on the two variance attributes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/tcp_metrics.yaml | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
> index 1d365908084d..779e8a22b765 100644
> --- a/Documentation/netlink/specs/tcp_metrics.yaml
> +++ b/Documentation/netlink/specs/tcp_metrics.yaml
> @@ -93,14 +93,12 @@ kernel-policy: global
>          name: rtt
>          type: u32
>          doc: |
> -          Round Trip Time (RTT), in msecs with 3 bits fractional
> -          (left-shift by 3 to get the msec value).
> +          Round Trip Time (RTT), in msecs with 3 bits fractional.
>        -
>          name: rttvar
>          type: u32
>          doc: |
> -          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
> -          (left-shift by 2 to get the msec value).
> +          Round Trip Time VARiance (RTTVAR), in msecs with 2 bits fractional.
>        -
>          name: ssthresh
>          type: u32
> @@ -117,14 +115,12 @@ kernel-policy: global
>          name: rtt-us
>          type: u32
>          doc: |
> -          Round Trip Time (RTT), in usecs, with 3 bits fractional
> -          (left-shift by 3 to get the msec value).
> +          Round Trip Time (RTT), in usecs, with 3 bits fractional.
>        -
>          name: rttvar-us
>          type: u32
>          doc: |
> -          Round Trip Time (RTT), in usecs, with 2 bits fractional
> -          (left-shift by 3 to get the msec value).
> +          Round Trip Time VARiance (RTTVAR), in usecs, with 2 bits fractional.
>  
>  operations:
>    list:
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
