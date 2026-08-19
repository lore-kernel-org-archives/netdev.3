Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D92E737E;
	Wed, 19 Aug 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143710; cv=none; b=sVV69Dn3kh5EVRthMaJlaiDDfLoF4dL6xcqQgkv7/YgPr87xtTQqAht9qtB3ZrfneiAn66zIGc4GgF34KTGfqiuVmitbrKjQxUWlDQjLBjoJps8Oh8aZDIhhqRqHDng4IiiNbOpfQB3QM2seFru+1W1kvncKU56hmIGCWUAJ0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143710; c=relaxed/simple;
	bh=9EyqDgfZNpVtXQ5L2bgmD+fmumHQJOfol4BcEfkvL1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJN2xy8v5fY30pGBRBYapXKvx0DL+WdE7uR38OoHrJm0QxqUylgtj6HRSephVFvuad6YhFp2Rx4xo88Fvnc7Qq3YSululVTZS5ou8w2ey9pF6oWGiIezsYrU7F3g2x2naS6rKBJi8Rn3PCvAbtBjf4G6iLrR4XOb5R2TvBnZP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0jMG1lC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0jMG1lC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6C31F000E9;
	Wed, 19 Aug 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787143705;
	bh=kiI831g15HiSHlUT06TmmIKr4Nw0QxMvv7Rst5onLmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K0jMG1lCcJFhTnoRjVnkdYYgtr4AehcKz8Q8DO1FtXwNzI2DLpPHm15M5KdspgFh7
	 PtPtppx1VOPKkRy9nYakUWLuDVMZSb6TYvDLP6/NrrMrKwp0xNBAUj0pRcDH7B9fqM
	 PKN6NXdSRqo776UJc7bN2HWymYhlBMRn10nC68KoRdYchwzMbDPKcTDo+ew17OIEi6
	 dcD8hdbNWPFt8tJ0VjI8413WhjtkIOnMhC9PuWAsiCF7zke/aO1alGPdJ7RY8Razwl
	 s0Qadr9mOkIYj0SUMP02UsR1fnsyrPk3+wiE4X2GeUz72Y2d8ZRv8A/xVowZFc/JPI
	 0tbQL+6HM0lVg==
Date: Wed, 19 Aug 2026 13:48:20 +0100
From: Simon Horman <horms@kernel.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com, "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: Re: [PATCH net] gtp: fix NULL pointer dereference in
 gtp0_handle_echo_resp()
Message-ID: <20260819124820.GR265046@horms.kernel.org>
References: <20260816035205.57966-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816035205.57966-1-blbllhy@gmail.com>

On Sat, Aug 15, 2026 at 11:52:05PM -0400, Cen Zhang (Microsoft) wrote:
> In gtp_create_sockets(), gtp->sk_created is set to true before gtp->sk0
> and gtp->sk1u are assigned. A concurrent GTP Echo Response packet on
> another CPU observes sk_created == true and dereferences the still-NULL
> gtp->sk0 in gtp0_handle_echo_resp(), causing a kernel panic.
> 
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:gtp_encap_recv  (drivers/net/gtp.c:542 gtp0_handle_echo_resp)
>   Call Trace:
>    <IRQ>
>    udp_queue_rcv_one_skb
>    ip_protocol_deliver_rcu
>    ip_local_deliver
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> Reorder the assignments so that gtp->sk0 and gtp->sk1u are fully visible
> before gtp->sk_created is set to true. This ensures no concurrent packet
> path can observe the flag without valid socket pointers.
> 
> Fixes: b20dc3c68458 ("gtp: Allow to create GTP device without FDs")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  drivers/net/gtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..2b5a8f6d24d0 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1456,9 +1456,9 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
>  		return PTR_ERR(sk1u);
>  	}
>  
> -	gtp->sk_created = true;
>  	gtp->sk0 = sk0;
>  	gtp->sk1u = sk1u;
> +	gtp->sk_created = true;

I don't believe that this is sufficient to address the problem described as
there is no synchronisation between the reader and writer of sk_created.

I wonder if this might be addressed using smp_store_release/smp_load_acquire.

-- 
pw-bot: changes-requested
