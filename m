Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE943F8AC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609477; cv=none; b=PRyBF6/zzSU0pnwbcjG5Z5iqUbmmoPZj0ZFcKfjxXrZZIiRYq1AfhK9UAuOXdNHpXKSnN182S8hudtducW6R7CPsQp5dSmvRJmCG3ZIVSgsgklj+QdWvZ2oLO9MknsXGmf+S/DppzWcMdJ4pfsRhwEW2SjrFyvJxt1wityEtSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609477; c=relaxed/simple;
	bh=ekNRTv/TL9qdTGaqKTU3xjKI2pnys6eRJiotTASXKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUUqAIu/Wn/wRJMQFfniAfoLwdOpN/hsF1/0sKh+LBFDfD6a4hBlZbQSMGUavZvLj4WLnnraMhVhWCbMLmH5fye/4AOu3SYJED/g0PQDfmXEcbYMxQmPGJ1+hhEbmxbORcyXAOqYq4ag2JtZf/vHG0ZT6bEgq8MgQkW8aY9XhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdiFwwjH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0m8raFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdiFwwjH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0m8raFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786609475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7osRv4SiTFi2D7w5M5+xxh/Lfv3v0Z21SGPsrlY9PI=;
	b=bdiFwwjHd+aN8/KVq6yrLVcu5XquWZPQrk+DFEXXPg8W/vAAw3zkT7j/E0R4MhdYBRz5jG
	G+YNG5Ck/iGMuiJmZQlpP3/qb2yFM87998aiomp4t6iMS/GZ7pApeN3Rjxag7L1Ck5CFyG
	nk3WBu5zy2WKbIhwR6TJtZMLtMk6Th8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-eYQLp6R8Pj2pcXuUaASMIA-1; Thu, 13 Aug 2026 04:24:31 -0400
X-MC-Unique: eYQLp6R8Pj2pcXuUaASMIA-1
X-Mimecast-MFC-AGG-ID: eYQLp6R8Pj2pcXuUaASMIA_1786609470
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f7039fa59so1510773f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786609470; x=1787214270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7osRv4SiTFi2D7w5M5+xxh/Lfv3v0Z21SGPsrlY9PI=;
        b=U0m8raFn2jBF9BvOnb/zJEvOqiUAoe04r8zfEA76mHGC722BEKX9zI1sStipQ/YXP+
         NZVY64gwe0aBRLkMsTyrtIk1cuUPhOEns4NrS6JFglXk5sH9gsg/EPFRjHELQrypWRX/
         DdlOe9MUq4mlXmX/Vnwn32Hp07DBuOnJxs8VxEzXeEqwq/pwPkPzEKHZjVhcYkGmj5Cx
         GJJayTCAp9zIP+/o8curx/UGeHuRAO1jcntz4UkU0Cu9cWGczb6BFitRZqPpWhEkePCN
         aorv3WPaEX30AKORtWd2KHwcDHPncqyFSkTML0Uco6OyqdSBsXTBQhvc5QPEe68TIxgL
         DgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609470; x=1787214270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7osRv4SiTFi2D7w5M5+xxh/Lfv3v0Z21SGPsrlY9PI=;
        b=ZQvEUaLq1PdFAH5y7SVPnegVvW4uMgbGglC3qQieb1nF0jbzBkONf7ZMREED8iNBzp
         y0YRLgOKEKeHp8t8VITj0INt2qlE1WMYyhOavWmMHs2pV5VIZpC4t1iRUqf8vMemAYYv
         9vpa2ap2KHuMm+VxVrHx1RGqJsag7/u51r48kRJ8niCd5DzbnDCX3xoQreY/SdFCepKY
         GnnO+QlYMrcmDgKTsyKazdilIzEb4nz+PwmbKp8c/4+UnTqupxbUYrSHuDfb+HhFKUau
         AIlGmZJv85yEcWetnzc05jtvC3QKfwVxhsDPsby36AD7pJIDSo1rdEBHm9+LMV4wdMYW
         WcNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8w4yv1Y9kDCh/eLdUeoUgrlSYZANEU1eW/F0B/Er/vLEoKU+mnpe5QbYXUlW+i+jNdrJN8o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUScRvdUqd5+XcpcwkMg/WvlLbKjSQUYq+WnuxlU6zaY2m7iM
	8ePL9kfgyZGXkMThBWUchv84KHCEcK4GmkZ7/DuRtJ1BSEXZFjWtmEQvx4iAmeEAHk7/D/ljl9z
	pZMkm/3k9KeIzxnoZKzMwZVw+Dvo2g1F+ojN2zE1Kd1kUPQUOh/YwY5d4Ww==
X-Gm-Gg: AR+sD13Lx7u0sgq2XJu12Td6zKHvCSdRy3bxm8whwlq1FSnHUJZp2F71uBQ3WYX+bnU
	kfkSiczAUxXmKx7UjTc/LMN9NoVWrVqqvcHMo1a9Zeu8S8AECLLM1smAAhMB4txWxzDs8aC1a3V
	Hh7K6nSFytTHHrwZUTIl4AUSwmjKA1DS4G4CO16gH2Fktv1QQdEdy3xbJ5VxzUDFFNxXAOwJ8W0
	GpyyTG+MfIn83J2A/NEXZzrxJH7a2weRKiygzxpAsVwUIi5W5nLJScLGyZ8+b+pXWzetsAFZl7q
	9HLLr6w3miJLhZsMNkNXvYcOUUZC1UUssr7KbZ1HSwsHAuYdpfXNn/cm1upqU6/j/lrPB/ipzyj
	+yJg3hYhx404AnSJrEqEKQceAuwPOa6glfgXhlmvQzgOISYfIz4Sm
X-Received: by 2002:a05:600c:1c21:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-499821c335amr48238755e9.4.1786609470424;
        Thu, 13 Aug 2026 01:24:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1c21:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-499821c335amr48237755e9.4.1786609469913;
        Thu, 13 Aug 2026 01:24:29 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm57093855e9.6.2026.08.13.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:24:29 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:24:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] vsock: don't check the listener's sk_err in
 vsock_accept()
Message-ID: <an14GupikpFAtRHn@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-2-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810170935.2242314-2-phind.uet@gmail.com>

On Tue, Aug 11, 2026 at 01:09:30AM +0800, Nguyen Dinh Phi wrote:
>Syzbot reported an issue which can be reproduced with these steps:
>	r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	bind(r0, {VMADDR_CID_ANY, PORT})
>	connect(r0, {VMADDR_CID_LOCAL, PORT}) -> -1, EPROTO (self-connect)
>	listen(r0, backlog)                   -> 0
>	r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	connect(r1, {VMADDR_CID_LOCAL, PORT}) -> 0
>	accept(r0)                            -> -1, EPROTO (stale sk_err)
>
>Basically, it creates a socket (r0) and triggers a self-connect after
>binding it. This self-connect fails with EPROTO because it loops back
>to r0 while the socket is still in the TCP_SYN_SENT state, causing it
>to be incorrectly dispatched to the connecting-client path. The
>unexpected packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This
>listen() call succeeds because the kernel's listening path never
>inspects or clears sk_err. Then, a new socket (r1) is created as a
>normal client and connects to r0. However, vsock_accept() rejects this
>incoming connection because the listener's sk_err still holds the
>EPROTO error from the earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to
>never be freed on virtio or hyperv transports; only the VMCI transport
>implements pending_work to revisit and clean up a rejected socket.
>
>For a non-blocking connect(), vsock_connect() may return -EINPROGRESS
>immediately, and vsock_connect_timeout() can later set sk->sk_err
>asynchronously.
>
>Since no vsock transport ever sets sk_err on a socket while it is in
>TCP_LISTEN state, checking it in vsock_accept() serves no purpose and
>only carries forward errors left behind by earlier, unrelated
>connection attempts on the same socket. Remove the checks so accept()
>no longer rejects valid incoming connections because of a stale
>error, which also avoids the resource leak described above.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..ff507761f472 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+		timeout != 0) {
> 		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> 		release_sock(listener);
> 		timeout = schedule_timeout(timeout);
>@@ -1906,12 +1906,6 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		}
> 	}
>
>-	if (listener->sk_err) {
>-		err = -listener->sk_err;
>-	} else if (!connected) {
>-		err = -EAGAIN;
>-	}
>-

As I suggested in v4, please just add here:
	if (!connected) {
		err = -EAGAIN;
	} else {

I prefer the `goto`, but I understand that for a stable patch it might 
affect too much code, so we can do that later as part of a cleanup.
Anyway having the smallest block at the beginning of an `if/else` 
statement greatly improves readability IMO.

The rest LGTM.

Thanks,
Stefano

> 	if (connected) {
> 		sk_acceptq_removed(listener);
>
>@@ -1941,6 +1935,8 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>
> 		release_sock(connected);
> 		sock_put(connected);
>+	} else {
>+		err = -EAGAIN;
> 	}
>
> out:
>-- 
>2.53.0
>

