Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455B480344
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331195; cv=none; b=AtCPQ6NZgTzFtGbllqzwq5TO+03/WS66ZaQqIkIaHepfxGw4VxEgFuELRvOhiB3MXw07I7EXUwVpsYYLl9H2JinFiLYYOYkXvkbJTRFENhE3shkVuVucUkCdb8uayoSUGqquSOgHg705fIh1I/tzO9tmRvXcj2wj4er7Pqk/KOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331195; c=relaxed/simple;
	bh=rr8YEWc3HSMWJ/APxhUFP/anlcCNU5lJQeizD/PJNI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwxcgKFLcD9Y6tN975qK1IiBlpxhqsAiK+2HOoLFzg2gtdqdqdwBlxztZGIm868rcWTw2VuIQpVs1e+K11q5SIkhLZsc7Vx8E/6SxljvOsNDUgfKdLOSGNduFZ1/CRNzoODMb+FkzEnh95uTq2prjdnZoH3RkGf5Srx+8IokDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzUY+S8e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW5DtgIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzUY+S8e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW5DtgIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gG4+OnzKs4OXOyTaKQLNCs0RTVMvrRHDvkvXHi16iz8=;
	b=KzUY+S8etMrGPWh9aNVEus5Jh4VW7qZt5SB4IaNBdH404gu94WIJWQzXTnJjXulA8VjLMx
	WnCEEHEr+Y7AuGNYhwanLSikXegJteT7SZMoSEKUqFuLGiBt7FHaax7PUHswt+7Qqm4DvQ
	COhlnUyR1iTGh8oKdBDecvL0JpiLjXU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-UWhL9wKAMe6zKkWWJgvw1A-1; Wed, 29 Jul 2026 09:19:49 -0400
X-MC-Unique: UWhL9wKAMe6zKkWWJgvw1A-1
X-Mimecast-MFC-AGG-ID: UWhL9wKAMe6zKkWWJgvw1A_1785331188
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f81362fb1so623548f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785331188; x=1785935988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gG4+OnzKs4OXOyTaKQLNCs0RTVMvrRHDvkvXHi16iz8=;
        b=EW5DtgIy8fkYNeUyPdK5SRDLSG8seyqlZU5Wx9klZKjpqddBruhe5XlURBoeNRzV37
         Sb9UBJiiy3UXMoEXd2SMCpiJj9InF2aG19uuomCL5RU5ZrKrM5x1wsWCB5EEJi4hszFI
         9SidDxYVMVmqeW/DjYkHh55FlvuT2xANBxglKygnUFjTqh+8AkYSGhcvWMmkee6SBM5y
         Ty9YulKM+4AXfoe2UhoXghQ3fNbdtwwl7+ZFxnHM/TQierRKL2L3zjhEzTswA5Q1KXis
         qQgaBfeGv7DsUv1+j8jCBpPvQT4FyLxL03C3fbSYCt0CzJQW3YF5nvR4JL1gDAeDR16O
         Jylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331188; x=1785935988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gG4+OnzKs4OXOyTaKQLNCs0RTVMvrRHDvkvXHi16iz8=;
        b=Pe0nEbkmJIqfRO87xDPGAXFh81iqwB+SiWGHEttyz9c98uj86c9JKdFDmZDMVYBxjL
         XSp3TEqbLSRcEb75tG1K7RRBL6ksCRey7TeriP8Ri+qdoq6r2X2Ye5MA748uzm3JRPKf
         ShrCoV6aufvfJI8nUYzQlpUetqZ7hWF7iQdfjILrfVGNCmKIsXrHs3CpixhS3At2dXRP
         m5whPPPtM2lElcoe/oUK1i1F6MReItl+987NkQeZ3gJ5n4jnj22p4QLOzS9rFLaNxYBi
         aZu5LmJWDkDx4ObtpySAIPNiBqqKOpyxtgMthFltfVepPKTv08XxSWuTuqwE9hWeXjeU
         fFvA==
X-Forwarded-Encrypted: i=1; AHgh+RqmtOfcyi4kDhd3pRsvHvpPZ3oFO9d2OrrRNHzXCdslFaWCXKig+BKDkx2ECe0K55JIlsSel5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkg4aznlPipnbybxQ80Dom7kO4w3/PLMv3BUdaPq/HzhxvP7U
	pbhSqv+P1OSSQSHDMsb5Sagf/lvpTWxRMXA9m7keHUKIktlDUjwlYLPUVyqGQPiT8CKs7lHx/d5
	xkkypxegGG8hOBtJnnmTvTz+kMN/v9+76bfCuqU8zTkf7iaMf1DQFJX807g==
X-Gm-Gg: AR+sD1377mxj+xphMSL8iLMnXKwncSvbv5GMhH9SntFuHPIxguu/KO72OxyYvrxqqeD
	nxr+dcTje1B6hSZgt2a+F0hF0vQUwnLpOYL0mzK8G5SoQnGWZr18v0CK6Y9vuCwlRwusnqh0cgC
	SqKyo2eobksYNM5xpYbpNidlHCaafETD2+dTysOVhboHp4gidlSC79Yco3COzOuQMPYripZIGy7
	B5mx3rW3gBpsi1+puNhCt7VyD1+QjJYhldXQEr/Sktvyw2kRmTSdJ7QbNma2Fr6zFHXYugMJ9iU
	CY1OzkdXC9GYrBBpZMlSiQFy7m6VaECX+oz8TRJ+Ih/+2XaZRPYnkrleFwj8uVz46cnSN6FlrNK
	4EwGAqZqdsYZZDydaUVJRlsGfeuUGH9z3yZzDZalWILY=
X-Received: by 2002:a5d:5d03:0:b0:47f:9642:5cb3 with SMTP id ffacd0b85a97d-47fb1f2205cmr8180296f8f.43.1785331188250;
        Wed, 29 Jul 2026 06:19:48 -0700 (PDT)
X-Received: by 2002:a5d:5d03:0:b0:47f:9642:5cb3 with SMTP id ffacd0b85a97d-47fb1f2205cmr8180221f8f.43.1785331187616;
        Wed, 29 Jul 2026 06:19:47 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm8208696f8f.19.2026.07.29.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:19:46 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:19:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	Dmitry Torokhov <dtor@vmware.com>, George Zhang <georgezhang@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Message-ID: <amn7W3hAIEC7kcQO@sgarzare-redhat>
References: <20260727071305.45826-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260727071305.45826-1-phind.uet@gmail.com>


commit title seems truncated, can you check?

On Mon, Jul 27, 2026 at 03:13:02PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>Syzbot report an issue which can be reproduced with these steps:
>   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   bind(r0, {VMADDR_CID_ANY, PORT})
>   connect(r0, {VMADDR_CID_LOCAL, PORT})
>   listen(r0, backlog)
>
>   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   connect(r1, {VMADDR_CID_LOCAL, PORT})
>   connect(r0 -> self) -> -1, EPROTO
>
>   listen(r0)          -> 0
>   connect(r1 -> r0)   -> 0
>   accept(r0)          -> -1, EPROTO

I spent some time to understand this, what about changing in this way
(or something similar):

     r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
     bind(r0, {VMADDR_CID_ANY, PORT})
     connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
     listen(r0, backlog)                     -> 0
     r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
     connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
     accept(r0)                              -> -1, EPROTO  (stale sk_err)

>
>Basically, it creates a socket (r0) and triggers a self-connect after
>binding it. This self-connect fails with EPROTO because it loops back to
>r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>incorrectly dispatched to the connecting-client path. The unexpected
>packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This listen()
>call succeeds because the kernel's listening path never inspects or
>clears sk_err. Then, a new socket (r1) is created as a normal client and
>connects to r0. However, vsock_accept() rejects this incoming connection
>because the listener's sk_err still holds the EPROTO error from the
>earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to
>never be freed on virtio or hyperv transports; only the VMCI transport
>implements pending_work to revisit and clean up a rejected socket
>
>Fix the issue by using sock_error() to read the sk_err to prevent the
>rejection branch from occurring  in this scenario.
>
>sock_error() atomically reads and clears sk_err, ensuring the error is
>consumed when vsock_connect() returns and cannot affect subsequent
>operations on the same socket. This matches the established pattern
>used by other protocol connect() implementations in the network
>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
>V2: Add reproducer steps to commit message.
>
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

Should we do the same in other paths (e.g. send/recv) as well in a 
follwup patch or in a series?

The patch itself LGTM.

Thanks,
Stefano

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

