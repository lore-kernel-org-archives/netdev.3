Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76F5650E5;
	Tue,  8 Sep 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882147; cv=none; b=nRGwHLdeaYOIm3W+WVRJcmBzKkpsAOV3oImHf8MVveMKLlr/1Re8fA+4c6LiQxnTHWbrAOwX9Yvb8IVUEAHobVsWsD8JjqZ7Bid7Cij1Y8Letda6AtL3S33wzJy1CA+6YkXsUtiZWW6A+h7GOQ+yl5zkv4n5S34FiZ90jX1DNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882147; c=relaxed/simple;
	bh=I0PA1aW11Ll2I20WSWDwxpUIPtq7nTpywQaUUt5mpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji5ShqwTKccKwgHVj6hdCB/e2OjCahMJ1wHuKI4Q+lWqVXuKwm+Cv5IQ0ysTfqkqq7Vi7kYFrm6LQqUHB3PWCgFmAITUZEDX9YhtuHntnqMs58HZjOVUHChhZnufPu8Q0yxuY45WsUHKZXd1jTyusg3qvz2cPq1xBaUx6+LLsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6141A1F00A3A;
	Tue,  8 Sep 2026 15:42:24 +0000 (UTC)
Date: Tue, 8 Sep 2026 16:41:52 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] nfc: llcp: fix slab-out-of-bounds reads when
 logging service names
Message-ID: <20260908154152.GA40544@horms.kernel.org>
References: <20260905225211.596366-1-omermetekaya0@gmail.com>
 <20260906003917.627282-1-omermetekaya0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906003917.627282-1-omermetekaya0@gmail.com>

On Sun, Sep 06, 2026 at 03:38:08AM +0300, Ömer Mete Kaya wrote:
> nfc_llcp_wks_sap() and nfc_llcp_build_sdreq_tlv() pass non-null-
> terminated strings to pr_debug() using the %s format specifier.
> The buffers are allocated via kmemdup() or come from netlink
> attributes and are not guaranteed to be null-terminated, causing
> __dynamic_pr_debug() to read beyond the allocated region:
> 
>   KASAN: slab-out-of-bounds Read in __dynamic_pr_debug
> 
> Fix both call sites by using %.*s with the explicit length to limit
> the output to the actual length of the string.
> 

As a patch for net, this needs a Fixes tag here
(no blank line between it and other tags).
> Reported-by: syzbot+1e3df0852e82c21ca418@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1e3df0852e82c21ca418
> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
> ---
> v3: Also fix identical issue in nfc_llcp_build_sdreq_tlv() as
>     suggested by Sashiko review.
>  net/nfc/llcp_commands.c | 2 +-
>  net/nfc/llcp_core.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index ca89fe967d6a..1213946ce91f 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -135,7 +135,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
>  {
>  	struct nfc_llcp_sdp_tlv *sdreq;
>  
> -	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
> +	pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri);

This does not compile because the trailing uri_len argument is now missing.

>  
>  	/* sdreq->tlv_len is u8, takes uri_len, + 3 for header, + 1 for NULL */
>  	if (WARN_ON_ONCE(uri_len > U8_MAX - 4))

And some notes on process that I'd appreciate you keeping in mind:

1. Please wait at least 24h before posting updated revisions of patches
   CCed to the Netdev ML unless you receive a wavier from one of the
   Networking maintainers on the ML.

2. Please send updated revisions of patches as new email threads,
   not as replies to earlier versions (or any other email).

You can read more about the Netdev development process here:
https://docs.kernel.org/process/maintainer-netdev.html

Thanks!
