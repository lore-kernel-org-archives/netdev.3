Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5338C40C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275875; cv=none; b=CE2JM/gDXz3fHo4eEctg+OIiAq4HL75KRKMWKRQQekpNOV6hn39+GNaov2sL0+qDbyy4jhfz0zJha30iaN/3Y5wd5PDvX7YldbSHwjT0HxYJ7x1G/HCPBQIyyLcbPm5XsDk9ZAqi7w+A3T3kwP8Vhgut83hfxyCBgWpIG1JNmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275875; c=relaxed/simple;
	bh=xtXxe3z9/83f1d9JXlONnXmtGAWAAyq34DBcdNeg+WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY1TWu8rbNFi+sx4w/6OMQ+bJ1ZEcH1zmnIZCkiq+uVMlIsnuHwtLvxW/0GImxkga95RbszaQAK/x5bDazW2QgNPAtw2bkgLxyoc3ROghCJ+5svZVOdFQCdxHuRsp2XO0UFvmK79OS5CtadXrXIRJTNtlOiR6agdEFiJgDz2UBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeEA1S0J; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeEA1S0J"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b900f350fso972676a91.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275872; x=1781880672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeDBR9JZ0sbjdg1IEKBF44Dw6trVSJWUdQSKPXsa88o=;
        b=UeEA1S0J0KIMRO88rkkeeGbnoB9j5cLfokViwAxAM+pMcPp1vxVHmQxijYfIOuJCAh
         WShK0n8xjNr3b6S0gvZUJC4P8LaKFnafaJZcsrrzA34Dg5LUEF3HV4ksQqC8LtCIBrTZ
         erNBFnQKk6kHsMmi4kYbhN1CNumapXtDFuZ2wincmH7xQ/eUk12CmGNHKujBZNYAa8sv
         8/JcL6Vg+BUszkSnhMeblAepeQrlsqEAiXdc33sO9xZ3+T9FucoRziQgKlNcynaLMFXL
         TofIXAU+Sk2oyODnMbKq0HYqfJZRC+wpnp+tb2n2jkgmL5XYNl+Y6PUJaBnAlPT48i+9
         SBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275872; x=1781880672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeDBR9JZ0sbjdg1IEKBF44Dw6trVSJWUdQSKPXsa88o=;
        b=Dd5Ku1XjjWlf3Bw//YdzTC4FKdirOT/LJrgR2qDvo80Kb77XNIyvQnAwtehvwZgrTf
         K4ThVvIf7HLfhrUyBzFVoL/SABf0IrBY3+iWXEBzXH2EY35RA9ONpUolGnKe36myj02W
         WYkpnTTD6OMFN8pw/QhmemyUalp+lFWbT8nDWZdomtrOFhBdk3vo5dqLm/QD7wcHdVeT
         G4ddiaxz1xPLCiZr0YbdgYow82chDSduTAkhYwEuyUBCrxIACPtJlKt7MvRsLLNJvfmE
         6wrnOibFx/BMV8WPE2QDY7kW4zSxCGPuFZxl3tV9875YmTc+ZXftiWXKpvehbCnws58A
         FUhA==
X-Gm-Message-State: AOJu0Yy+L+AgJlTcExzlqAFccge3QgAh6C4crb5O+e1sHnF23alURdR/
	+xXmxxpmdwt0hlC/Hrlc6U2+fgWItdFqWaV5KMeW814i2pDDXgvwbeq8
X-Gm-Gg: Acq92OGbJFCrOTrHWufyJvQySqTNjgohzhFHQ0PX25lo+igkrRF2pM8200YYKRo5pnW
	i2Fgcq2yjaybc1fvnBimszwY+TruX5YVWeVupFogZ9jBywaZQvy/3VCrob4VkFQr1zBiV3YO+6f
	NdtnkdEFuwDrRuPUYA7vsObUdGFNjob2UAyaln83Al+a0DMqdPWUYhcjhrIOqxwWbDWgcoCn6H8
	Zfs1dhQBMA1bRpCWGDDWvyLVhEDSdx5RWwJ1ygfyiCmbBskAlIQBS59a3ENY5E+hOPbP8rdgcQb
	qZhC91fLw4dNncrUunoM/tuaNemMr78psIFOnABcCiq1QOOy79LpxjRrt8jSjrAc8SaN2v0/Ab1
	mnrOu0DeG/ib8l98H/hOtCfLOjEgxe9YuQ9k+l21zTDDipPEHa7wwV07Xj7xOGHHAUwg+cHlGrw
	vN+wHhVz9dMpO0433JvwgIhtaR9BxvrvNiUX+NS7PAJsZU
X-Received: by 2002:a17:90b:3b4c:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-37a0458dc83mr3802343a91.22.1781275871672;
        Fri, 12 Jun 2026 07:51:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a263a43f0sm2791084a91.15.2026.06.12.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:51:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:51:09 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aiwc3c7LWhub8SP+@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
> Move sk_acceptq_added() into vsock_add_pending() so callers cannot
> forget it. vmci is the only transport using the pending list and
> is updated accordingly.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c       | 1 +
>  net/vmw_vsock/vmci_transport.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1f94f0d44c..6cfa89b6f3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -483,6 +483,7 @@ void vsock_add_pending(struct sock *listener, struct sock *pending)
>  	sock_hold(pending);
>  	sock_hold(listener);
>  	list_add_tail(&vpending->pending_links, &vlistener->pending_links);
> +	sk_acceptq_added(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_add_pending);
>  
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 635ebf9da4..c2db016cca 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  	}
>  
>  	vsock_add_pending(sk, pending);
> -	sk_acceptq_added(sk);
>  
>  	pending->sk_state = TCP_SYN_SENT;
>  	vmci_trans(vpending)->produce_size =
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
