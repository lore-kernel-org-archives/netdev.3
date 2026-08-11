Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE42C032C;
	Tue, 11 Aug 2026 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436371; cv=none; b=Jl8aqO8Aju70uT/+HUx5jQuGQBSyncp3zSDBzrArVF73e58Uem9jQRueSNIszlSOZtIbhqEN+f3FY3bj55pxFox4ZIEd9/UhsP31PVx/H/hwwgYX0Lhl4Vsipw+YHThkvO+u/oACHZy0HrLEGMZfVlWAN1i8iW1onv08hBjAUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436371; c=relaxed/simple;
	bh=nWKozPvyrxJWcxJcvUKGnijZGAz7hWAYbC8jFwLPGAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZukrcQ6CcE43lYxE7R0q9ibj2z8W4WHIVC8NLbBSxhh6s4e7sGbKZxIrUnO2wt+I6sh1OltUfyOZlf2921cSEDc7+KMJB1b1ntKvi9E88mQvp/b07Lfyfi98Oc7mjGN/6HyV5j8wuM6siOM8fGgtopW6Qw6qvNy1oMPXDUGp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejW4YNuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejW4YNuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB06C1F000E9;
	Tue, 11 Aug 2026 08:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786436370;
	bh=vJ/nn4l998g9AAeq2RJa47GwzFPg+QFpEzPNd0q7XpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejW4YNujmqdWfFloDDdYwVSrzbhN/cWQf948Xbd/jgyGXjuSeqJ65EkBmSsW2Ndb4
	 Kqd1XSR0uY0KxpKzLsqGYTKluDrukFUCVvdnypcOlUK9e/0oNrgH2STadAon2pgl5y
	 O/UyXdy1IOz4XdAUk13DBmYTgweTWQ3fqjCTuOuvI9l/VolXNWlQ1vMzUVcR7bPtGK
	 7A1zN/WHYtVkUVNC5gxMDxreyrx2ZO3dIMnq1q/rT4xclVNrdkwOHXfZYucxRvkrMT
	 VBpfw4O2gSZGrPjhdDUWi2Kr9nYjFeWOPG4KLaIcvTJzFt0orfKuu0Wo9g9Iwn3pH1
	 yf+/QE7vE/9fg==
Date: Tue, 11 Aug 2026 09:19:24 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <weir@nebusec.ai>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, david@ixit.cz,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pengpeng@iscas.ac.cn, kees@kernel.org,
	error27@gmail.com, raoxu@uniontech.com, dddddd@hust.edu.cn,
	ian.ray@gehealthcare.com, joe@dama.to, kuniyu@google.com,
	linma@zju.edu.cn, vega@nebusec.ai, rakukuip@gmail.com
Subject: Re: [PATCH 1/1] nfc: llcp: Pass caller buffer to
 nfc_llcp_general_bytes to fix UAF and memory leaks
Message-ID: <20260811081924.GX51943@horms.kernel.org>
References: <cover.1786029423.git.rakukuip@gmail.com>
 <006437e618b55acc0df69d94255244a490b11461.1786029423.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006437e618b55acc0df69d94255244a490b11461.1786029423.git.rakukuip@gmail.com>

On Sat, Aug 08, 2026 at 12:28:51AM +0800, Ren Wei wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> attempted to fix a use-after-free (UAF) issue by
> invoking nfc_llcp_local_put(local) after accessing local->gb. However,
> if the reference count dropped to zero, local was freed prematurely,
> leading to a Use-After-Free when the returned pointer was accessed.
> Alternative approaches using dynamic allocation (such as kmemdup) introduced
> severe memory leaks and state inconsistency because callers consistently
> treated the returned pointer as borrowed memory.
> 
> Fix this properly by refactoring nfc_llcp_general_bytes() and
> nfc_get_local_general_bytes() to accept a caller-provided output buffer
> (out_gb) and its maximum length (gb_max_len). The general bytes are
> safely copied into out_gb BEFORE calling nfc_llcp_local_put(local),
> ensuring safe lifetime management without ownership transfer complications.
> 
> Update all callers across drivers (microread, pn533, pn544, st21nfca,
> digital_dep, and nci) to allocate local stack buffers of size
> NFC_MAX_GT_LEN and pass them to nfc_get_local_general_bytes().
> 
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Hi Ren,

Thanks for your patch.
I've provided some minor feedback below.

> diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
> index 4149c5d735bd..0f0a03da9ff4 100644
> --- a/drivers/nfc/microread/microread.c
> +++ b/drivers/nfc/microread/microread.c
> @@ -251,9 +251,8 @@ static int microread_start_poll(struct nfc_hci_dev *hdev,
>  		param[1] |= (1 << 1);
>  
>  	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
> -		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
> -						       &hdev->gb_len);
> -		if (hdev->gb == NULL || hdev->gb_len == 0) {
> +		nfc_get_local_general_bytes(hdev->ndev, hdev->gb, sizeof(hdev->gb), &hdev->gb_len);

Please line wrap so that lines are 80 columns wide or less.
Likewise elsewhere in this patch.

> +		if (hdev->gb_len == 0) {
>  			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
>  			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
>  		}

...

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index dc65c719f35f..1ed0ecde5872 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -635,23 +635,29 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
>  	return ret;
>  }
>  
> -u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
> +u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len, size_t *general_bytes_len)
>  {
>  	struct nfc_llcp_local *local;
>  
> +	if (!out_gb || !general_bytes_len)
> +		return NULL;
> +
> +	*general_bytes_len = 0;
> +
>  	local = nfc_llcp_find_local(dev);
> -	if (local == NULL) {
> -		*general_bytes_len = 0;
> +	if (local == NULL)
>  		return NULL;
> -	}
>  
>  	nfc_llcp_build_gb(local);
>  
> -	*general_bytes_len = local->gb_len;
> +	if (local->gb && local->gb_len) {
> +		*general_bytes_len = min_t(size_t, local->gb_len, gb_max_len);
> +		memcpy(out_gb, local->gb, *general_bytes_len);
> +	}

x86_64 W=1 builds with GCC 16.1.0 warn that:

  net/nfc/llcp_core.c: In function 'nfc_llcp_general_bytes':
  net/nfc/llcp_core.c:653:13: warning: the comparison will always evaluate as 'true' for the address of 'gb' will never be NULL [-Waddress]
    653 |         if (local->gb && local->gb_len) {
        |             ^~~~~
  In file included from net/nfc/llcp_core.c:15:
  net/nfc/llcp.h:77:12: note: 'gb' declared here
     77 |         u8 gb[NFC_MAX_GT_LEN];
        |            ^~

>  
>  	nfc_llcp_local_put(local);
>  
> -	return local->gb;
> +	return out_gb;
>  }
>  

...
