Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D70175A8B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558974; cv=none; b=hV4crC45PMAsoDtOghUNxcWhSHLRbaA6Jsn0FTUx4QzKG3VqC83BMZgF5E4abq9c9AxNM85cX2W45HCJAXnXpOLNWFRq3QR623l/im2Vw3FfzSmy9BB9Ph9Z+2w9+iDYVTk6erIfYAUHSAPKjRNRlf9LtTT618dNiND2b5HdPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558974; c=relaxed/simple;
	bh=0g89Ex6s2sWg1JSWQRG3DTuAKG1uCf0qlWKk5mYyA9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZcjpMgnKbfZ57yQpKiMs3BHvPw6yhLqtSe1vtzM6Cy2bVFZR/10wOT5hT6Sjx5v3mooApcW9Qab72AncmlyKIZRxUoIR1XrPDCfdy5Y+UrWJnZX2CMyhwhtoveqIwKPI8ua3+wz5X6wPLAblWuqZNxPcsH8b8rznMx9615Phz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDCVcHDI; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDCVcHDI"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0g89Ex6s2sWg1JSWQRG3DTuAKG1uCf0qlWKk5mYyA9I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790558970; v=1; x=1791163770;
 b=DDCVcHDISb7ohXoyZ8BYbZI4OzrkIZOCjVi5Y2lVqRcwd0vMywe8bO6CvDxLk4WgnE0VqMhW
 HMMBULoYupD3u1MU8tkQCHQwSK0SROAQ6TmTqQYd7A56ztB7T44S7VuzTDtSZaj+dvJtUdQxdvn
 e+UqT0zNUAXy8YhYfWHT6x2g=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 41dc7886bafdfd5f;
	Mon, 28 Sep 2026 01:29:30 +0000
X-Mizu-Trace-ID: 41dc7886bafdfd5f
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:29:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/9] netlink: specs: rt-link: fix
 ifinfo-flags names
Message-ID: <arnC67hOBlXPzR-o@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-4-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:06PM +0000, Asbjørn Sloth Tønnesen wrote:
> Correct the names of `enum net_device_flags` constants:
> 
> - IFF_POINTOPOINT should be "pointopoint", not "point-to-point".
> - IFF_NOTRAILERS should be "notrailers", not "no-trailers".
> - IFF_NOARP should be "noarp", not "no-arp".
> - IFF_ALLMULTI should be "allmulti", not "all-multi".
> - IFF_AUTOMEDIA should be "automedia", not "auto-media".
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/rt-link.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 3560053cea7a..e3a4b4e7e5ef 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -25,17 +25,17 @@ definitions:
>        -
>          name: loopback
>        -
> -        name: point-to-point
> +        name: pointopoint
>        -
> -        name: no-trailers
> +        name: notrailers
>        -
>          name: running
>        -
> -        name: no-arp
> +        name: noarp
>        -
>          name: promisc
>        -
> -        name: all-multi
> +        name: allmulti
>        -
>          name: master
>        -
> @@ -45,7 +45,7 @@ definitions:
>        -
>          name: portsel
>        -
> -        name: auto-media
> +        name: automedia
>        -
>          name: dynamic
>        -
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
