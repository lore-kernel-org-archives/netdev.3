Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC234AB03
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535477; cv=none; b=XfeQjDjSHKmrH+y37ipeGvWX8hhOinLOeexFZtUiO332yDgd3d2oXec41cjiVT8OI2xgHydfefjVVEpBFh/OAePeS03hv07oL8moTvJCHkUhQta35OXHCcQIKvTZicQP8b4orgcF+AfEtzrioepgszzdT3JfKoUQ8MucNe2AZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535477; c=relaxed/simple;
	bh=rdJleFptQxOZBI7LMPF/r2MarufA+U1d9dkuzXtOVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY2djBjbzphADVZRJIv5By+DguwIvshcxCdsAG5MB7FLoHsFzXnOuDJ6C8zN4y+7fQ3R5KSlfBKY0e4fi0vzJhycMN5OqvXTi0QPtfgEZr33w5U/MNooXp2iulTjSJwlmsR4e+VbXevKdRJLxi9YXDkQA7VEVSopNQ0Mi4756uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig612kJz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cf67iCWw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig612kJz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf67iCWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784535475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1T/3ILBAZWlTf8F+pJIXj/IvpWirJ094fe/3AMtG14=;
	b=Ig612kJzRSeYc/G/+Pu5UOyL81l4zdhYXhUciTzyqezOUSZ1zUDq9TTARI14r6PZojFhN9
	Klng39IfPBhD1UZ3iVdg/BcshyJt7JafQhrL53Nb3lwZAjsSHomlbiQAe3xr+2vTp0D8Yl
	WceRPOLmD4eDVoS7AZ+58WlFOvLeuh4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-zrqzgIamNt66ZHH0mlb66w-1; Mon, 20 Jul 2026 04:17:51 -0400
X-MC-Unique: zrqzgIamNt66ZHH0mlb66w-1
X-Mimecast-MFC-AGG-ID: zrqzgIamNt66ZHH0mlb66w_1784535471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473bc66c837so8248549f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784535470; x=1785140270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a1T/3ILBAZWlTf8F+pJIXj/IvpWirJ094fe/3AMtG14=;
        b=cf67iCWwtnh9C0Xd7Y//BCfuPNYeBdkK+AmyNjEkWU5wlDlKCX/x4u1jjdprF+nXCJ
         nPYi3d7UKJHPnX6hjavvz51iYUygErCfcJIsE5zmfqZqRZd+SsdU8yOMPYVzQsHDr3OQ
         KdJL8EwsJ/68XIXOCxpaDN26WMTc5KHfC32HaPDEmZt03pKZzwlZY1ZzJEFWco24Yktc
         yEcZhb3KyLcJtP/Br4fuJKuBBm9Fv1YHrCw3vko/Krup8Jl2LfSsHn/W+THjnFzxmSAU
         tGPumDRtJkQgrHIjU4FQb4p658zYb3eZUuNl6Oyab5fciRnSjFCgICs55NCwi2VpqeJ+
         cEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535470; x=1785140270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1T/3ILBAZWlTf8F+pJIXj/IvpWirJ094fe/3AMtG14=;
        b=fxIPDYE9vWZSpv7G6x3E9yfqrbVxX3jKBRF/x29muRAHex8zuHAN2c5m8ern1rswDu
         iqoPZIhqb62M0NURS7dPaCFsS1iLY3oqmIWv+ec81fU5gRuecgbI5D35U7OwFfRaXgNj
         Go2Qr5VVkW7CEZbvm0Vl/AAK6rIyJnSRnJ9U5txavaY7JXFkJTSH68v2Nku+7vmU3Vof
         YqDwV/k77QHFZJ6QlBGBR5d0muZ9ppMFWriqy+86XxWfGNnzzyuDjPuACqONyjVXICbw
         IZEYICRLjusTfNdyQFPLwZokxIxD05rPTZ/IlE1xSsN7H+oD4ENmquSd/y13eUvEbnEa
         RibQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCN0rrR2MxvNFh20pIT/4WxYNLuiV5hS3sg+fWdLZ8k3qKRTLK2s8DEJIRQigLaWm0/ZX4Dq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwedHGMDRePmpDUFJHXRN96bSndz7+ItzJCT98Z9XaD6fQTz4S3
	FumbRnt4QS3ktucEoKWFMKo1uNA1hKpefcQrjbBzdeJ4HnbdsajeGWIbaZlVKXnkaqLo6bwpiFh
	P+o7Wgvp6MgKBzORDpUo+RFH+ecK1niL86Ck+J29mbx/rvJHeQHRxBtiWcA==
X-Gm-Gg: AfdE7cncEpyuC2PbJ952ZtWc7NMPfxCWLRHetC8zIa8iDUWIxEGFQrgp2ebfRUEdDtl
	YahdDSBul5+fvaR0mNILysyJNc1Cj5i34lizQTqKupZlWEdqnJAqAAlAq1rs4Wfzlwsfu6L8r17
	U+Kcd1hPHIYVYfVjzixr0W63EiuZEj8/nM0pAC4uSThsTRCEWJZqnCwrpfGE5h/IxRB7nf3XsFo
	R3TzArbYVxePtS27g2h7dUa8S5ONMp+gwJnAmaahAy9UpvkLcRltiJdGdsIaThQD0NWxqMkFpGU
	n/LmM7HdwaBzQcUVUFCxq53lCqdPkB+4TT4oSbDp6hXt4sHkObSKAIDxywLgl+QZHcGu7Q3Cg2G
	yZZv/eykntWoUd2c8CfILFfQU73PW6QZhjEObqcsHHC290xLtUA==
X-Received: by 2002:a05:6000:3101:b0:47f:776f:3845 with SMTP id ffacd0b85a97d-47f776f3a7amr3706627f8f.7.1784535470501;
        Mon, 20 Jul 2026 01:17:50 -0700 (PDT)
X-Received: by 2002:a05:6000:3101:b0:47f:776f:3845 with SMTP id ffacd0b85a97d-47f776f3a7amr3706580f8f.7.1784535470043;
        Mon, 20 Jul 2026 01:17:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm29541750f8f.22.2026.07.20.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:17:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:17:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <al3UuvBhfxp82krV@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260719220103.684489-1-phind.uet@gmail.com>

On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>After vsock_connect() exits the wait loop due to sk->sk_err being
>set, the error was read but not cleared. This left sk->sk_err set
>for subsequent operations.

So, is this a fix? If yes, we should put a Fixes tag.

Also, can you describe how to trigger the issue?

Because I see this in vsock_connect(), so I thought it was in some way 
already handled:

		/* sk_err might have been set as a result of an earlier
		 * (failed) connect attempt.
		 */
		sk->sk_err = 0;

>Switch to sock_error() which atomically reads and clears sk->sk_err,
>so the error is consumed when returned.
>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com

Can you explain how this patch fixes that issue?
(this should be the first information to be put in the commit message 
IMHO)

I'd like to understand better if this is a fix of real bug or just an 
improvement to the code (which is fine by me).

Thanks,
Stefano

>---
> net/vmw_vsock/af_vsock.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..43eddc33ed12 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	if (sk->sk_err) {
>-		err = -sk->sk_err;
>+	err = sock_error(sk);
>+	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
>-	} else {
>-		err = 0;
> 	}
>-
> out_wait:
> 	finish_wait(sk_sleep(sk), &wait);
> out:
>-- 
>2.53.0
>

