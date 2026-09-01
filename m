Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA34CCDFF
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254129; cv=none; b=EbCCt/jQzbfXtFRit9RrhS5xBboelisHX2fFX1sciDDihb+oISBIWXO7N6BWImS8sqzTtAV5uzMWtzlyfb3OTYO3IXg7JlNmrvNeqZn2T4kRmGiTjC3/fNgjZYrbCveMnLM1K4KUEcFFnmGanzGj8bCrvkieABrFOYXMeSCkUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254129; c=relaxed/simple;
	bh=CBSwalXu4jLN5MBpEKJgBaaMK9d1xJw+lzFyFc4Tq7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioXQjUjMG1cZojIEuUJrTeJCRyqn1iKtgEwUL2HR9tLrW9jGhG8YeQ9L3NB6xFYXUO5GTWboD9qt4EymT9UAozHLKfyAU9v0W0Zm1rvQpiELWIpkXJugDELLGW+lxTmXKwHqJgQDiOqhiJC7zYD/KWcsNfynrNMpldteRxVFaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EQHW0EwU; arc=none smtp.client-ip=95.215.58.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EQHW0EwU"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CBSwalXu4jLN5MBpEKJgBaaMK9d1xJw+lzFyFc4Tq7g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254125; v=1; x=1788858925;
 b=EQHW0EwUz0nVsyUvHQ9xNLh2/5YM7egZFTrGMUfCC04ifitU+IZQvfDQcNUzOoJ6gBALrKQb
 WtFQwsWchO3SrTCWUwtm2/lb4VC9HpupY/1tnXuMNz4lmcqAzo1Ykb8XW3+neFXkqSedAdEkwvp
 dTS/dL0B3JWjiSyL7X8VFsDI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fba90716fc2f014e;
	Tue, 01 Sep 2026 09:15:24 +0000
X-Mizu-Trace-ID: fba90716fc2f014e
X-Migadu-Flow: FLOW_OUT
Date: Tue, 1 Sep 2026 17:15:14 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	daniel@iogearbox.net, razor@blackwall.org, bobbyeshleman@meta.com,
	sdf@fomichev.me
Subject: Re: [PATCH net-next v2 2/3] netdev: avoid skipping objects on race
 with device disappearance
Message-ID: <apaXopeQGUR-xku2@fedora>
References: <20260831164159.1124679-1-kuba@kernel.org>
 <20260831164159.1124679-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831164159.1124679-3-kuba@kernel.org>

On Mon, Aug 31, 2026 at 09:41:57AM -0700, Jakub Kicinski wrote:
> If the currently dumped device disappears while we were mid-dump
> we will get the next device without resetting the sub-object ID.
> This is quite unlikely, it was reported by an AI tool not a real
> user. Let's fix it for better dump consistency.
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 04dcd7fc614e..e427bab4c4d2 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -312,11 +312,14 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  			err = -ENODEV;
>  		}
>  	} else {
> +		unsigned long start_ifindex = ctx->ifindex;

The NETDEV_A_QUEUE_IFINDEX policy is u32. And all ifindex getting/setting
in 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
is u32. Why the ifindex is defined to unsigned long?

Thanks
Hangbin
