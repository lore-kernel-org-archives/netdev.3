Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFA1397
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558380; cv=none; b=ougbqowv3eL6E5aikDVwVECBII5vYjfQfLm9nTux6neuWqqTnBCZE2kytm/IUDhVQoT+pBQPkyJTUCdfXfDUVnTDGMvCsIYsefHolSTG2G9ZU2Mvb+aatNIH80NUVy3VeupZDgzGX1t49tl8WapOQznCkx6z26YlBLdNcffSF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558380; c=relaxed/simple;
	bh=T1Q1qBSqnVJIk94dr55GCcw/GkY9e40DE3AqaXVAM/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuE2hNd7Hr6R7OxIjVo5h7klh64b6sGU85zLQU8D4/3NfFEOQqu0yj3VKmy5qh7/wgRwG8GSIFFex28Szw1qZATTeVRkKCUd2KHMypGJpXjsHDsDZ7rZ5bZCvfz6N8Vmfg0FS/YIYP3pcViXftOR/3jSYzz+/O/dUfYavdXptyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KzXHzUr8; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KzXHzUr8"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T1Q1qBSqnVJIk94dr55GCcw/GkY9e40DE3AqaXVAM/s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790558376; v=1; x=1791163176;
 b=KzXHzUr8kPI8RU67miE/lE9qnAyVsBwl0p3hJbJzlGULZRJ5GNzI4VwzPiVJb/j8m+KgMksJ
 OQVP5iUuhKJxp5UOiNBWVbbO0IcGxsmt38pfGYkGSNDMRVIamK3sVzf8NJI0hKx9aUw0cM24jGH
 Oo6k/Hmvd3+Z0V/3n+1D+cQM=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 46b8d1b57dee1be2;
	Mon, 28 Sep 2026 01:19:36 +0000
X-Mizu-Trace-ID: 46b8d1b57dee1be2
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:19:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/9] netlink: specs: rt-link: re-align IPv4
 devconf
Message-ID: <arnAnUVFHJZ8eroW@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-2-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:04PM +0000, Asbjørn Sloth Tønnesen wrote:
> The YNL "ipv4-devconf" enum is misaligned with the IPV4_DEVCONF_* enum.
> 
> IPV4_DEVCONF_* starts at 1, ipv4-devconf starts at 0.
> 
> $ git grep -B3 -A1 IPV4_DEVCONF_FORWARDING include/
> inc../uapi/linux/ip.h-/* index values for the variables in ipv4_devconf */
> inc../uapi/linux/ip.h-enum
> inc../uapi/linux/ip.h-{
> inc../uapi/linux/ip.h:        IPV4_DEVCONF_FORWARDING=1,
> inc../uapi/linux/ip.h-        IPV4_DEVCONF_MC_FORWARDING,
> 
> Re-align the YNL spec by explicitly setting the first value to 1.
> 
> This misalignment has been present since the spec was added in
> commit b2f63d904e72 ("doc/netlink: Add spec for rt link messages").
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/rt-link.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 7a72cd1b7e1e..8d63933f9910 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -309,6 +309,7 @@ definitions:
>      entries:
>        -
>          name: forwarding
> +        value: 1
>        -
>          name: mc-forwarding
>        -
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
