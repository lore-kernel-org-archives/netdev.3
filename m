Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C23222582
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275853; cv=none; b=eqUes8bfCL01mEMgtSDttDwUBlSeKnLZe4nqIqVzreS8LqDotRSkNEt18AUa0e7gJHoL1sFnAOs5p9odbMeoufa8mlmCSel/s32MVmu2nftQzYsvneoo8v4IYKeWRBpvv+aLXHUkqhjr/hxVbomNVwr6FLhoXfSuUzYm0GLAf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275853; c=relaxed/simple;
	bh=kWlqJdzwUmprV1aSxqcZKGIM8ovHj3K8M8iLohg+Xpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOw4M5JCl6lh1ZUGug23e2uylacGrq1DKfJvRdviz9fboHrYoVUE6P1g2J+YS7XgLkDJc1rN7mymh0pEpK7OU7FMGxKJPhvSPnDI7ZVeWTJmvHwUwk7f+G25+EXiRjgLResa7hjqvvAE0ppaJiPMEpy76uAj/NivwcqY9bvk8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4NtSD36; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4NtSD36"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c35980fdso10101245ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275849; x=1781880649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=O4NtSD364MfPP6okfMOAMe61yJla1vUsvO0eIoc4ospQDfZJutvt4TllYTLBtMEwPO
         4coyOH1xtz4utgRberzWbY/vr4J6p31J9anyQ4+aIN8Fxg++riqFtdz6rg3PdmE4KYBM
         OstrOcM8H+q+rYRVGWZrH4nVBT5vdA64S/JuCCjLEmyvj+TaQJ06M2eIB/jpNJe6rg75
         c17QxGBNM3HapY3iZcWJ2l+3U9Oq1plcp1ehRpD6XsENX9onBGwRnOEaj1UEE/0NKhCe
         RxF0pTPy9VGZcm0m6Ka11xUUwhcvA/vcvrOlU/0A/cY0PDRPr5/0/54zY7qNOaxJ9aLS
         /2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275849; x=1781880649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=a0WdiTAEOw3NVZHPaOUlBxFmbBfLapw73UVsH8e1CugGmkQPVx9kbXsqc/1Jb8bM9h
         Qpybi6BgQWQn6H0P0i+J4vecC7HIWFN8WcGrtb9rtuTDaRFnB0wfHvJAuKVWMyAe44ZS
         KtmeN0UsF4eEeKjjgKX+VPyZBVASIC5coEb17snz7jA6huoL6r64OVfNH6OzL63HLZqb
         zf+88VVWsr7zxDVmpTUkqnp0Vm4px0IcFy24crd+vlgQiQcWAkgtPdlBvlrJNchkIIjd
         3drdSXfXL8pMga+oJoguTSjYqbLchH3zL9mj5GCD+zukAnjUpwx09ncgFRuIM8YGItFQ
         CcFA==
X-Gm-Message-State: AOJu0Yzvwfyz7EfhT2ILOE09oKSm8EHbtkBl09UYEzfv8nnNGyn4TMmD
	GQEUMSZ/S57twjl8MEW9TvkEUY6WFWFManeht1Uag2wdJr3qIPtPbLLm
X-Gm-Gg: Acq92OH762y1UeK1BllPtEvvsZQ3ACkfB2ayW8o3GOU+mv9ZawfCPd0POWLAh0uuJYR
	wpYJNRJe3NBp8wiD8AVnuib0uAcprr52fCo9yPGITo6wP0FGlwDil15faRA5BPI25B4pDL++p5Y
	T2JhAADosFo1e9NevhHeiCDiM1B8uJkjUzLT7qhwhXqp7zCQjcjDjISNaQjloUOoFrYRnR30hRA
	vc+s/I8i70i71fzUWTYiPNf9lhSMaJUmPWDz6RmZPs8twUgB4lKYAd71Z1UyCKKaoTCC+gqSf2e
	bc4b+G/LTesVQXBto0yRDsNSP3fmNeZ0yZodAfjFzW2BvZfQ5f09iYpjCRqZy82iwzyebC4DevX
	+IvoaW51VXna/75GFiFcMvLNJHY3Bd45kKT5kgVqsL+mDsWPI6ID78jCRvcUA2nJH/p4b/4G+qz
	82YGbqCdu7j8WP/vffg0CB8YGYDRvmmEVHaScTMTo40g1k
X-Received: by 2002:a17:902:e742:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c41235e5cbmr40486225ad.17.1781275849291;
        Fri, 12 Jun 2026 07:50:49 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm25637165ad.38.2026.06.12.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:50:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:50:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiwcxOVDB8Vc2RAA@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
> Add vsock_pending_to_accept() to move a socket directly from the
> pending list to the accept queue in a single operation, avoiding
> the sock_put/sock_hold dance and the sk_acceptq_removed()/
> sk_acceptq_added() pair that would otherwise be needed when
> calling vsock_remove_pending() followed by vsock_enqueue_accept().
> 
> Use it in vmci_transport_recv_connecting_server() where a completed
> handshake transitions the socket from pending to accept queue.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  include/net/af_vsock.h         |  1 +
>  net/vmw_vsock/af_vsock.c       | 10 ++++++++++
>  net/vmw_vsock/vmci_transport.c |  3 +--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 4e40063ada..30046a3c20 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -220,6 +220,7 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
>  void vsock_add_pending(struct sock *listener, struct sock *pending);
>  void vsock_remove_pending(struct sock *listener, struct sock *pending);
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
>  void vsock_insert_connected(struct vsock_sock *vsk);
>  void vsock_remove_bound(struct vsock_sock *vsk);
>  void vsock_remove_connected(struct vsock_sock *vsk);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ce1063d4a..1f94f0d44c 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -496,6 +496,16 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_pending);
>  
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
> +{
> +	struct vsock_sock *vpending = vsock_sk(pending);
> +	struct vsock_sock *vlistener = vsock_sk(listener);
> +
> +	list_del_init(&vpending->pending_links);
> +	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
> +}
> +EXPORT_SYMBOL_GPL(vsock_pending_to_accept);
> +
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  {
>  	struct vsock_sock *vlistener;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 91516488a7..635ebf9da4 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1258,8 +1258,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
>  	 * listener's pending list to the accept queue so callers of accept()
>  	 * can find it.
>  	 */
> -	vsock_remove_pending(listener, pending);
> -	vsock_enqueue_accept(listener, pending);
> +	vsock_pending_to_accept(listener, pending);
>  
>  	/* Callers of accept() will be waiting on the listening socket, not
>  	 * the pending socket.
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
