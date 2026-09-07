Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02563AAF40
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786422; cv=none; b=p+eQKXSSk0d05gqnfxxWgP4g0aC1G6a4cxq30VQKmiMk3+EL64RVwlwUW7PeJxnO7XHZXLo6CC3qqzo6WXMfxAe+JlLLKdrI0dw1UNfznKHvPSyCNBoBau5/NZV1dlD9IOmdnRpcIvAajFOsXB8NLAwAK+47ZGip8mroxNekkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786422; c=relaxed/simple;
	bh=eoELJwkDlwS9cl0WbC/oBljazj8jzeYPt267DDxKQMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYy0xu29vG9/pZ5F8jpgafa+XFRNXGSe+cSorkWZVxz2hIj+xiUfSey7FyuWOIP/5IRjukTnKEym4+0bd7Law8cvl+2gpj9ZE6qd4whJhdgZkRuc7SRsnsPO8S0mCY3qmtPHyYmFjkG5fZv9zrGO4RCnAud3kVal9N1U5nKxEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN1OaUhM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN1OaUhM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482e067e908so2919229f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786406; x=1789391206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySxHLNrdZAbSwcz4SMQYBg7MBYiQBtCno7JKBz+dwo4=;
        b=dN1OaUhMVVuEw0c3URs5MBke2AXqLEWnlBw37xX2r1J5Vj4X4SiR4QP5oETKIYeR1y
         VORiQJTSScTbCy2k9R+IKlZuzhdTCl/W7CYCgCRLkqXs6kMzMskSrZQve7qYwkq877ZY
         dyFx01Ihs0FuR1p+SPINfUvrdpMm+r34/twUzRNLZ74X9hGpMmq19OEned9pvmCpHdez
         h+y1RU2OxT3y4dkR9OvypkeIEq685qXquuW6IcvkTISaMoZ26cNF8yG7+Xh0UuSREITh
         pa+YgjGItCzAOWGfj3TF0cuvIiTliUMZw6H1KFUXyn/eQx7ph60XBKA60iw9z+O8Dwjz
         aAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786406; x=1789391206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySxHLNrdZAbSwcz4SMQYBg7MBYiQBtCno7JKBz+dwo4=;
        b=FSiC5yvWZEdmwBH+n19KsaEubEQVM2JQlGsuzlIBPLvLweuuAh4Nb0UtDCcw/fX3OR
         AW86e6a2UoQC8OI4jYYMc/X4UqZ3yC2MmKhXzvZPhg7yoDJ+1sdyspakMaOT/9hI/SWC
         Z4Wrxp52idsYp+rMayCZIY10wT4TqlVc2r6bxMP11VXH2I8Fb7kJLm/dT4qOlzqPSX1a
         EJsWL212YlyDuW3Ygbmo0HkYRnbC/YwrQ5tSJ2dkAVo+NZwab7B9VGYDq7NlIlli8ya7
         pQYigfxiAcEYMzMttjuDj7LgymITuCzkOqvwhToKtSd6XtNTtC3ogqP+oZET/jsyAqqK
         SgJQ==
X-Gm-Message-State: AFuF++kanqj8zvce/dc+Gg/6LawFxC1r7uSULpbb9YEwl5fevb/QtCmI
	7+YuXVq2UOGLW3sIcx7GdT05xBkcP7QtJmzjSxZt0EwRjKrnKCvsgYoSnVM62uDU
X-Gm-Gg: AYBFou03jrp0gI00da/Oona74OXqYlDpgO1/kkfnlaxzPv9ftW7HY1d7e3PfGepIks8
	RoZB16Aq4X/VWfkYMNzIRid2lmpENb14piaNFfcAIqvSuy19OAznOecy2HAU8pgJxWCU8BU3DKm
	lXBcL1xXOKz3q4j88yAUUuaVoywl51qLRPp7q8rWI8ZYmFNeyC9YQN1sOgKDlBzUYT8Nl4cq4/P
	TG7aC+SqXcTs2aNJNrVCGk7+hzJkWuW8V+7Qa1TEV5JkoWI65+L+EJyC6aQ3vHnyR37UNSvuHf4
	2Kx0d7VphFn91WfxaFElLYsTbl4PywRS1bSGY5MCmNo7tIlkbgzJ7I9zx7ORqC13kiSU7NT7Xpn
	rGjtgO19ycmrnW7SyR1kOmD5fs+nmv/K1uGF1h1ae7xzVdzIVHQq8KArieNpwOtDFBsh7g7/0OZ
	TNpQGbBVVDbFMAvxJMLz04smNvtjYsgYZyK/SqZLr4z5NDXx/IGMd9PeKoWhTDS3I0qt7Tgoe39
	4jTOJNGgohZNqgJIQQd/SaDoA==
X-Received: by 2002:a05:6000:260f:b0:485:8be8:b2ba with SMTP id ffacd0b85a97d-4858be8b4bcmr22749936f8f.49.1788786406401;
        Mon, 07 Sep 2026 06:06:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm28717743f8f.26.2026.09.07.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:06:46 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:06:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Jakub
 Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v9 01/14] afs: Fix lack of loop around sendmsg() to
 rxrpc
Message-ID: <20260907140644.18dba619@pumpkin>
In-Reply-To: <20260907113743.1453210-2-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
	<20260907113743.1453210-2-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 12:37:28 +0100
David Howells <dhowells@redhat.com> wrote:

> Fix the afs callers of sendmsg() to send data through an rxrpc socket to
> call again if a short send occurs.
> 
> Note that this is also a prerequisite for changing the way rxrpc_send_data()
> works to return a short send rather than an error if some data was buffered.
> 
> Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org
> ---
>  fs/afs/rxrpc.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index d82916657a3d..a80b043d36be 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -412,26 +412,32 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
>  
> -	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
> -				     &msg, call->request_size,
> -				     afs_notify_end_request_tx);
> -	if (ret < 0)
> -		goto error_do_abort;
> +	do {
> +		ret = rxrpc_kernel_send_data(call->net->socket, rxcall, &msg,
> +					     msg_data_left(&msg),
> +					     afs_notify_end_request_tx);
> +		if (ret < 0)
> +			goto error_do_abort;
> +	} while (msg_data_left(&msg) > 0);

Is there any reason you didn't change rxrpc_kernel_send_data() instead?

David

>  
>  	if (call->write_iter) {
>  		msg.msg_iter = *call->write_iter;
>  		msg.msg_flags &= ~MSG_MORE;
>  		trace_afs_send_data(call, &msg);
>  
> -		ret = rxrpc_kernel_send_data(call->net->socket,
> -					     call->rxcall, &msg,
> -					     iov_iter_count(&msg.msg_iter),
> -					     afs_notify_end_request_tx);
> +		do {
> +			ret = rxrpc_kernel_send_data(call->net->socket,
> +						     call->rxcall, &msg,
> +						     msg_data_left(&msg),
> +						     afs_notify_end_request_tx);
> +			if (ret < 0) {
> +				trace_afs_sent_data(call, &msg, ret);
> +				goto error_do_abort;
> +			}
> +		} while (msg_data_left(&msg) > 0);
>  		*call->write_iter = msg.msg_iter;
>  
> -		trace_afs_sent_data(call, &msg, ret);
> -		if (ret < 0)
> -			goto error_do_abort;
> +		trace_afs_sent_data(call, &msg, 0);
>  	}
>  
>  	/* Note that at this point, we may have received the reply or an abort
> @@ -912,8 +918,12 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= 0;
>  
> -	n = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg, len,
> -				   afs_notify_end_reply_tx);
> +	do {
> +		n = rxrpc_kernel_send_data(net->socket, call->rxcall,
> +					   &msg, msg_data_left(&msg),
> +					   afs_notify_end_reply_tx);
> +	} while (n >= 0 && msg_data_left(&msg) > 0);
> +
>  	if (n >= 0) {
>  		/* Success */
>  		_leave(" [replied]");
> 
> 

