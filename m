Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773755;
	b=l7L8RN23Dor36ND+DLcJ4DZahjby3V3ffEOp4q6us/coRNrNaIe6NbVcFs0y4h1jIm0m
	 sEPD7BP+A54sEOlU/1QGp8biQTXEOaFCjnySghpbnbJm/tYXfnzaGNS2kvZev1/amqn/d
	 H/XcTiCcXCZED3WDAypwjx+dOiuIWP+BRCVzGVo2ZhWrGZSWpAmPqxAKxcA5yc5YEESjp
	 9aBPE7LrYb4QGJMc1olZ42kRMiLZaQM3LOo0ZDXjWuqFUyoxnyF/O9eEvTUF2EzFL5BlI
	 uuSah8k/wYcJ0UQRC+Uo9W62JeE7Aq4XDHZN7V3Ng3uoMUCb+2rINoOEiD6xEhSpGgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fvb7YIbuQNqXe0X0lqpdVo9LwpxBSbbeEYovcdWAiCs=;
	b=WrixgcxejsWtmDXiyJsAz5M00/Wc6x35OO8c4llMJ5BZztOR2qhdtFjgCH2mBdqC4R8F
	 iGcsQav+5x+a49x+94mOQH4owodghVf0UB9tbP68jytUiqehCXJtXB34nCbhwYhBBwj42
	 Pc8x6NYI7IrvtKFm0/Me3i1zvzS7iIBb99WvS5Y0AG5KwgBx0UNnUIl+6dkH1qgTfeOzr
	 fHFAN/QVANYATEWvE1XeD5IyXwQgJXxqHuACbmiHj7du+Hk1q5QNie9dMQANkcMU24g4p
	 kNkZ3NFWlVqInA54Sh/KZiDabDK4Hv/UZ4hglztLpkcgBqhKYJLIu4kU0vXPOggbCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OALD0rte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1E606A31B;
	Fri, 23 Oct 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OALD0rte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210B31F01825;
	Fri, 23 Oct 2026 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773755;
	bh=Fvb7YIbuQNqXe0X0lqpdVo9LwpxBSbbeEYovcdWAiCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OALD0rtekB14Pw9Bzl7amXP1L6rNyA1HsmaNxN2J2ptxRjzEgUbBWHZUs9t1dmhFI
	 MA5ul6fIZ8cj2jIZenxj8wIE+3ybQW0OY8xvIqDwHYuWmhv4fJhnhXlVmScNZuL4C0
	 8SfrD9GQsG1TclYolIMqYUjncXemUsm5lcdamzeUhAIsaH6nfxaCCt0IMHvjYIhaGv
	 cHina/Ft282Ax6izmauJPH6v3+dcjxWkJjI9Hnrz8eBJiba5COJi6S8zrnRbNu81+Z
	 a0it1vZFlDJxOXK79k1KNP2x7N2sdTQK5hEnHVtc+zlXp/sbSQFhWXmy3YmVjmGUC2
	 DxdjRWTMOowKg==
Date: Fri, 23 Oct 2026 17:42:31 +0100
From: Simon Horman <horms@kernel.org>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
	kuba@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
Message-ID: <20261023164231.GO708417@horms.kernel.org>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
 <20261016124858.1939743-1-hanson.wang@ugreen.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016124858.1939743-1-hanson.wang@ugreen.com>

On Fri, Oct 16, 2026 at 08:48:58PM +0800, Hanson Wang wrote:
> aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
> success. That function wraps usb_control_msg(), which returns the
> number of bytes transferred (6 for ETH_ALEN) rather than zero.
> 
> Callers such as netif_set_mac_address() and bonding treat any
> non-zero return value as failure when setting the MAC address.
> 
> Return 0 on success and propagate negative error codes on failure.
> 
> Link: https://lore.kernel.org/netdev/20260703073936.462231-1-hanson.wang@ugreen.com
> 
> Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>

Overall this looks good to me, thanks for your contribution.

Reviewed-by: Simon Horman <horms@kernel.org>

Some points on process to keep in mind.
There is no need to repost to address these.

1. Please respond to netdev-bot+sinfo.
   It's not too late to do so!

   https://lore.kernel.org/netdev/179215519735.408196.139629932849333374@kernel.org/

2. Please post new versions to patches in new email threads,
   not as a reply to an earlier versions.

3. Please don't repost within 24h.

4. Please don't repost the same version, without either
   incrementing the version number or including repost in the subject.

   [PATCh net v2 repost] ...

5. Please do include a summary of what has changed below the scissors ('---').
   Ideally including lore.kernel.org links to earlier versions.

   v2: Fixes indentation
   v1: https://lore.kernel.org/netdev/43a0904c-de59-4b40-b186-edd130f6c0cb@lunn.ch/

6. Please don't use the Link tag to link to an earlier version.
   Instead use it if there is some extra information,
   e.g. an otherwise unrelated email thread that lead to this patch.

For more information on Netdev processes please see
https://docs.kernel.org/process/maintainer-netdev.html
