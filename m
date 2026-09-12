Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076E429CD3;
	Sat, 12 Sep 2026 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789208208; cv=none; b=j2C5oKUY0VJnaujHV2W6XWsVc93jLZODlzX84z+gEJupXJw38H8jvr9oUMCUDndP4KxTkndLZj5TDcaGO7Y6g+APCKoeXxigxSh0pbzUviQk1k93AmenaecN7keiGI6AX7qOGZS6sJ/F4lXwSXf5W4K6gTExzjmFUS4uDksKs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789208208; c=relaxed/simple;
	bh=gVa1dVjl7V/eqPPObgo8XKv+oAm+cCFhetLkPA10Lxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c51FYlrKVYzG6K9DkcR1ilhczGUz8PW5gMRGsP8dgyL8h1YxoFZ82KZ1iG0y5KATKh1cnIQHJI1TaVxIHLPxE5HpLHKUO4mPTIsKREhFLeKyoaxlQ1U6aLEpXcL2Mu7dMmvc9Hj/ZfdJnulp+qYoTAWbvIN6kgwJ27XS++/5MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llJaGcJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llJaGcJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926A01F00893;
	Sat, 12 Sep 2026 10:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789208198;
	bh=40UkVy/O/19XXQwA+1zxlsKkYJUI6RG9Chr/nA1zAsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=llJaGcJ1COxLfKOwc0Q386Tm3604/ETgnVdFeoEHkKdO+8TkhIC/DuCdlcb08GUUN
	 a1sgQdcb0YV4Ctz3xxCFkyFjw4R8TsXoKFw0kMPGFM6tpE3V0AblYcS8TJflqQlbQT
	 WewVIELp50iXoQnTrmq8PcxlFWz7XOcFxuAR03makHK6tLf00ApR2zfU+xPyDUNA0U
	 WsvljSGsEW4KcE+S77ZcThD4cs1mRDJmidAbs1qYGgcVAuZSy92LSYGnuNkIaeiYtM
	 XautI4gPueHW8IVGPbJS9FTAnhAr7RmWpCzXFCM4lOAhOdysidXn0rOuLcEn+2LVuS
	 fcjteLwjj7LcA==
Date: Sat, 12 Sep 2026 11:16:33 +0100
From: Simon Horman <horms@kernel.org>
To: Ren Wei <weir@nebusec.ai>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, david@ixit.cz,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kees@kernel.org, pengpeng@iscas.ac.cn,
	raoxu@uniontech.com, rosenp@gmail.com, dddddd@hust.edu.cn,
	joe@dama.to, ian.ray@gehealthcare.com, kuniyu@google.com,
	linma@zju.edu.cn, vega@nebusec.ai, rakukuip@gmail.com
Subject: Re: [PATCH v3 1/1] net: nfc: fix use-after-free in
 nfc_get_local_general_bytes
Message-ID: <20260912101633.GG48209@horms.kernel.org>
References: <cover.1788841682.git.rakukuip@gmail.com>
 <3cbaac3bee23f8ff3a3284ed32d347696eb1d208.1788841683.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cbaac3bee23f8ff3a3284ed32d347696eb1d208.1788841683.git.rakukuip@gmail.com>

On Wed, Sep 09, 2026 at 01:19:24PM +0800, Ren Wei wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> Commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
> nfc_llcp_find_local") attempted to fix a use-after-free (UAF) issue by
> invoking nfc_llcp_local_put(local) after accessing local->gb. However,
> if the reference count drops to zero, local is freed immediately,
> leading to a use-after-free when callers access the returned pointer.
> Alternative approaches using dynamic allocation (e.g. kmemdup) introduced
> memory leaks because callers consistently treat the returned pointer as
> borrowed memory.
> 
> Fix this properly by refactoring nfc_llcp_general_bytes() and
> nfc_get_local_general_bytes() to accept a caller-provided output buffer
> (out_gb) and its maximum length (gb_max_len). The general bytes are
> safely copied into out_gb before calling nfc_llcp_local_put(local),
> ensuring safe lifetime management without ownership transfer complications.
> 
> Update all callers across drivers (microread, pn533, pn544, st21nfca,
> digital_dep, and nci) to provide their own destination buffers and pass
> them to nfc_get_local_general_bytes().
> 
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
> v3:
>  - Include <net/nfc/nfc.h> in pn533.h to fix build error in uart.c
>    caused by undefined NFC_MAX_GT_LEN.
>  - Restore nci_request() in nci_set_local_general_bytes() to preserve
>    ndev->req_lock synchronization (avoid unlocked __nci_request() via
>    nci_set_config()).
> v2:
>  - Use caller-provided output buffers to fix UAF instead of dynamic
>    allocation (kmemdup), avoiding memory leaks.

Overall this patch looks good to me.
But I'd appreciate it if you could consider my suggestion further below.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index dc65c719f35f..24cf212bf3f8 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -635,23 +635,32 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
>  	return ret;
>  }
>  
> -u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
> +u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len,
> +			   size_t *general_bytes_len)
>  {
>  	struct nfc_llcp_local *local;
>  
> +	if (!out_gb || !general_bytes_len)
> +		return NULL;
> +
>  	local = nfc_llcp_find_local(dev);
> -	if (local == NULL) {
> +	if (!local) {
>  		*general_bytes_len = 0;
>  		return NULL;
>  	}
>  
>  	nfc_llcp_build_gb(local);
>  
> -	*general_bytes_len = local->gb_len;
> +	if (local->gb_len) {
> +		*general_bytes_len = min_t(size_t, local->gb_len, gb_max_len);
> +		memcpy(out_gb, local->gb, *general_bytes_len);
> +	} else {
> +		*general_bytes_len = 0;
> +	}
>  
>  	nfc_llcp_local_put(local);
>  
> -	return local->gb;
> +	return out_gb;
>  }

As far as I can see the return value of nfc_llcp_general_bytes() is now
ignored. And for a bug fix the approach you have taken looks good,
as the interface provided by nfc_llcp_general_bytes() is only slightly
modified.

But, FWIIW, I think it would be cleaner if nfc_llcp_general_bytes()
returned the length, or 0 on error. And the general_bytes_len parameter was
passed by value rather than reference.

Something like this:

size_t nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb,
			      size_t gb_max_len, size_t general_bytes_len)
{
	...

	if (error_condition)
		return 0;

	...

	return general_bytes_len;
}

Perhaps that approach could be considered as a follow-up.
