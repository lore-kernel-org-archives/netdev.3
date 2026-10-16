Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC3321F5E;
	Fri, 16 Oct 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138699; cv=none; b=WRxl67lka4CabzefHp5bPeTVPs22GXHKV3mwhPoEfb0vtXXzFaY8FHSGlY8/FuP+y37tpSg52C1o1L1Vsp9YCQUJxpshgrOi9HYNip3ETI0zQGwjrbMIV4V+94CZarlc6CE1afhJK1L0au9NVxgC5jGqhDRJpmvUVSp0jUf7OvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138699; c=relaxed/simple;
	bh=jPT2TNYxgshiy5c36ncFZHEPx/mEloRIpcHB+v9LGrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmpH4cnMcr7FYDxDz5q1QGWq1CU+v0LYkrKIf0iaCzIgFrm8zMpGatmR1gkoNuUv41m4/stTRU9fXbd+BSavMpC9E6gqmYnWgZIAjCNxzjj0J7TUsV+hn8QwzntE0gwJxL1YBYxAiqiYQbowvmRMU8lsnIRtim7UZa9prf+bUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnGcFODt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnGcFODt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351BE1F000C4;
	Fri, 16 Oct 2026 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138697;
	bh=dBB+2bgOQbqNUHoch49xb5bDvd9pyA5NBJLGE5ayi94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cnGcFODt0h+SiVoV8i/+BzuEC7rd1EYEB7hAH8IjoVWjs9otPZhAF0LZ+NJTszPnS
	 yH6dBCBq4lujTy7tEM+DH51XDx5FghhtalN0V+RmJX909ilj1oe/s6BjZVANAFs8Nn
	 RUnd/S9/OJHgaLbW6RJHKYl80MTn0P+OAkbjkkEk1x12486G0q3vWZCRlJNKsszCd6
	 6w4rOfZTtp9esNIaKqxCU9C1gKCPWbZ5/J8QNTa/k9HxCNJ+N6qqjBH+MuFTL+sSN+
	 5fs3nAH9D9uyJxzmpVn11wY1Kds+00rPCKHEXuPlRc/lWmBRW53MGe6eu3I/FaHL2H
	 ogHUR9q8SSk0A==
Date: Fri, 16 Oct 2026 10:18:15 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: ipconfig: fix OOB read in DHCP option parsing
Message-ID: <atHc9N49BfiGal3l@kwain>
References: <20261016041152.2294843-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016041152.2294843-1-liuc63@xiaopeng.com>

On Fri, Oct 16, 2026 at 12:11:52PM +0800, Liu Chao wrote:
> The DHCP option parser in ic_bootp_recv() advances the option
> pointer by the option length and only checks that the new pointer
> has not reached the end of the packet.  The length byte and the
> option payload (opt[1], opt[2]) are then read without verifying
> that they lie within the buffer, so a malformed reply from a
> rogue DHCP server can trigger an out-of-bounds read.
> 
> Validate the option length against the remaining bytes before
> consuming the option, and skip options that do not fit.  This
> keeps the existing parsing logic intact while ensuring all reads
> stay within the received packet.
> 
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  net/ipv4/ipconfig.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 22a788987..0b39a5ccf 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1081,25 +1081,27 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
>  			__be32 server_id = NONE;
>  			int mt = 0;
>  
> -			ext = &b->exten[4];
> -			while (ext < end && *ext != 0xff) {
> -				u8 *opt = ext++;
> -				if (*opt == 0)	/* Padding */
> -					continue;
> -				ext += *ext + 1;
> -				if (ext >= end)
> -					break;
> -				switch (*opt) {
> -				case 53:	/* Message type */
> -					if (opt[1])
> -						mt = opt[2];
> -					break;
> -				case 54:	/* Server ID (IP address) */
> -					if (opt[1] >= 4)
> -						memcpy(&server_id, opt + 2, 4);
> -					break;
> +				ext = &b->exten[4];
> +				while (ext < end && *ext != 0xff) {
> +					u8 *opt = ext++;
> +					if (*opt == 0)	/* Padding */
> +						continue;
> +					if (ext >= end)
> +						break;
> +					ext += *ext + 1;
> +					if (ext > end)
> +						break;
> +					switch (*opt) {
> +					case 53:	/* Message type */
> +						if (opt[1])
> +							mt = opt[2];
> +						break;
> +					case 54:	/* Server ID (IP address) */
> +						if (opt[1] >= 4)
> +							memcpy(&server_id, opt + 2, 4);
> +						break;
> +					}
>  				}
> -			}

Please fix the indentation.

Isn't there a similar issue later in that function?
