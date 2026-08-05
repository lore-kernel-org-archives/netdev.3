Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC93DAADE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918884; cv=none; b=W8bdEX6m+VbkLbnvUS9q2vbA2Ua2KXjTg+S5wRZkBtGTADek8dp9RPgkNhy+e552wWNB4CYF5NbbWAObRIeg8TXkD7ouSxdnmGZsQmH5nk30y6gPlDuoy9BM4lzcQE6d3+j6uZNg3ReJgV2MqFZxVDzdCe/pcZ5nAUe+O7qMdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918884; c=relaxed/simple;
	bh=evmo1oE/Vlvct3s4qgqbQDVtD/iQ06qh/0KgEWFw+kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYAwy57yL0yVZFlv+r/potMRIQUFnkhMC5YvWX8nchnt5D3Vx0ZjRuxw8TjpdC8/G8kKM9UJTIgXo/UETw3NjWrWn6UchNIDebzci0cZfTTparRKvmEJXcsIRXcYUtq7LynY+bbNnV0vTbP35bpb8C98r3yDJn+2pNhbKMB5yr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTts97Jt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK9JZkp2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTts97Jt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK9JZkp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785918881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8JKU+udkyyWRXOR82LNQUo+2Yg2NA4KZG9ohOJp2T8=;
	b=DTts97Jt/g0snwaKUpG/6WOvbj2237btv+xg6P2ByIHEcNS+vuwy0phwrtJjnkytAmMo8O
	Nc/NJBhtDj8UdSzdkakSpgVhZZPcgdGS/QtsBcRMs0+Dki4+jFkm8sT0gvxF0Y95ahvsJ+
	KSIvxl+ZGXEKONxnRxcIfT2UMxsWTcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-T2IWdJT5NKSEtOC_YsDRRg-1; Wed, 05 Aug 2026 04:34:40 -0400
X-MC-Unique: T2IWdJT5NKSEtOC_YsDRRg-1
X-Mimecast-MFC-AGG-ID: T2IWdJT5NKSEtOC_YsDRRg_1785918879
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496c06ba017so5353985e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785918879; x=1786523679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W8JKU+udkyyWRXOR82LNQUo+2Yg2NA4KZG9ohOJp2T8=;
        b=eK9JZkp2ZP/zBMaia1Wa9VvOrHq53+hcodJeVeZoDWzpvKffsLtzuJbK8021bd1Mon
         +7JxD7S0vvlFO0QYn8gGXW3VOuiCmSJl3eaqUxdhXhIPG8DxFqArxTi1eMuJEe/0ywdQ
         jtw0gMDJOXsLPIL9/w0a4BEBsKC2/yZjnwfQxjqFV+aZnsFQfynzOrkt4RQWOvMwMWHc
         NfqtTRzyb1A84DdRWXGOjTmTR9R1gjShGBwHqf0dz0AmDcx99UFEyayOt2oGD0QfkTt3
         P4MNwdY0em2jH3brpfxTTbUByfTAgPcQYSwdMoLKUF/7q7/5eXNssCnXvrNM9MKWk2HV
         irgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918879; x=1786523679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8JKU+udkyyWRXOR82LNQUo+2Yg2NA4KZG9ohOJp2T8=;
        b=BWm9TdOcXLICCu8ZHfxDlsj2ZR6npINknLhl/HZhDfq6BOIM1CV22mbI5lO6vRqu3F
         AYpFOiVsB6xof3bM5g+wx2S/Bfr7SB52GI6599zuBBWF9ngiCmW+vFdLuxX7epGIJ4JW
         j8a01RtN/CBzor6qddrtuf2OZ9LmLvruggTm1kzHj223xh7mA6bHzQO9LiskGLo34QAh
         djOLlZ3LNyEcnKA24wti1NaMbOgJkRGQQu0/fbCEZPxhj1MIp3IFB37mC/UPff0YizsI
         RMjOsuxhD7MyCLAW/kZUlMfKyf7cFquwEGM8DFR9CkcyyFAR6iK+dzbKyHEUi1VMGXts
         MKlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7twBlfPwDNhaa//b8fw6XkZRYebXCQkYIKFY28hLtQRi2YcVJXhWfS6i4euj6/turafkx0w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAdnz4NYYzpvZJttE0uP7dWxKhhXek86Ue2Gs1QVjd9YtVGhx
	49V3NAqWiAz6V05cy4JlpEWiGRfTOcRGmMaecint+PvAmQgesKT4p9vluiYxgZvov3uwU3wsQ8V
	3hvcXIUbuHKCKUniQ2YH7zj6RpkaOhpmsnDlLAw/I8ToHI/KoQPEZ4uB94Q==
X-Gm-Gg: AR+sD12QLt+3ew7QrhIIFgb9qmowFN+MD0RmLJqDfDJ0X4wPIECCvQOl8Z1lN4kl3yw
	46/mZAwmpcLk21ALFaQuR9BWcSI36GJV5GEybDhYo7B0VUVhLqy8JSkoQA4YEBwVuuD/gi1InmZ
	KCRRnuuaRT9ofOefS13vACPy14PmBz1io2oHYVir7fmcqIFDUXoYK6zJJ+0z9XCcUc2FKL30Cpd
	tP20pwRNBPP9gfVEnSKTI7W8WMqmZLnRPw7aLyTmBIFDx7ByjYTQEpD3H+bUtVgJs6dHGfInfb/
	Ztq+u0Qq1JoEUg98gNZeADa7QWR1g4vYrsZJr15tByDZ+a253wI+BzkPxu/ea0rucRAYkaLo8el
	vAn0=
X-Received: by 2002:a05:600c:190e:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4994e2c39f0mr61976845e9.0.1785918878883;
        Wed, 05 Aug 2026 01:34:38 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4994e2c39f0mr61975895e9.0.1785918878332;
        Wed, 05 Aug 2026 01:34:38 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.121.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm82077995e9.15.2026.08.05.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:34:37 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:34:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, Wupeng Ma <mawupeng1@huawei.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anLuRE4ix5-BZ7-t@sgarzare-redhat>
References: <20260804135238.386417-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260804135238.386417-1-phind.uet@gmail.com>

On Tue, Aug 04, 2026 at 09:52:36PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>Syzbot reported an issue which can be reproduced with these steps:
>
>   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   bind(r0, {VMADDR_CID_ANY, PORT})
>   connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>   listen(r0, backlog)                     -> 0
>   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>   connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>   accept(r0)                              -> -1, EPROTO  (stale sk_err)
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
>implements pending_work to revisit and clean up a rejected socket.
>
>Fix the issue in blocking connect() by using sock_error() to read the
>sk_err to prevent the rejection branch from occurring in this scenario.
>
>sock_error() atomically reads and clears sk_err, ensuring the error is
>consumed when vsock_connect() returns and cannot affect subsequent
>operations on the same socket. This matches the established pattern
>used by other protocol connect() implementations in the network
>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>
>For non-blocking connection, vsock_connect_timeout() may set
>sk->sk_err after vsock_connect() has returned. To handle it, we also
>remove the sk_err checks from vsock_accept(). Nothing in vsock sets
>sk_err on a listening socket, so accept() has no reason to inspect it
>at all.
>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>---
>V2: Add reproducer steps to commit message.
>V3: Fix truncated title and add annotations to reproducer steps.
>V4: Remove sk_err checks from vsock_accept()
>
> net/vmw_vsock/af_vsock.c | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..594fe27d2ebe 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
>
> out_wait:
>@@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+	       timeout != 0) {
> 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 		release_sock(listener);
> 		timeout = schedule_timeout(timeout);
>@@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		}
> 	}
>
>-	if (listener->sk_err) {
>-		err = -listener->sk_err;
>-	} else if (!connected) {
>+	if (!connected)
> 		err = -EAGAIN;
>-	}
>
> 	if (connected) {

Can this become an `} else {` ?

Or just add a `goto out` when setting `err = -EAGAIN`.

> 		sk_acceptq_removed(listener);

		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
		vconnected = vsock_sk(connected);

		/* If the listener socket has received an error, then we should
		 * reject this socket and return.  Note that we simply mark the
		 * socket rejected, drop our reference, and let the cleanup
		 * function handle the cleanup; the fact that we found it in
		 * the listener's accept queue guarantees that the cleanup
		 * function hasn't run yet.
		 */
		if (err) {
			vconnected->rejected = true;
		} else {


Should we update this comment too and maybe remove the `if (err)` at
all. With that change I guess `rejected` is never set at the end and
maybe we can remove it at all from `struct vsock_sock`.

Looking at commit d021c344051a ("VSOCK: Introduce VM Sockets") where
`rejected` was introduced, I can't see any path where sk_err is set on
a listener socket, so I guess that path was dead since the beginning.

So now I'm thinking if it's better to split in 2 patches (both with the
same Fixes tag):
- Patch 1: "vsock: remove stale sk_err checks from vsock_accept()"
   Where we can also remove `rejected` since it's never set to true since
   the beginning
- Patch 2: "vsock: use sock_error() to consume sk_err after a failed
   connect"

WDYT?

Thanks,
Stefano

