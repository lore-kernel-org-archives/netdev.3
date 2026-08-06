Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87B2DECD3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021084; cv=none; b=TUezfwDJ9nccKJt53LDlvg0EjxM1Cn8cLCh0i/5dJrTwPkOJz4fD/PVP+Hg7aD6LjhOjBOUDmv1PDoujktzAgB+jl2kSmXPgS2loal6fScc5zJcMOZDa7ZV7jempVGGoVog/H4TRDiX+q4EjVWm2/FsS29vOdJWJanJrupl1INM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021084; c=relaxed/simple;
	bh=3al0HDOqY9ebkA4EOMVEdKxXeaHy538zLs06SWOiaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe6BMECAT2/s1/0Kkt0ZWG1EANbQ4uP0f2f5C4ozkMbokFw94yfAt/23MqNGRVz/QD8Y7cwK3ISIbkeN79sPE9nRqnhWHaMkfDjmrMu+jrrfavzrHrXhL2fUYAJP3lo3AfbszWACAlSa69+fYjPmb7wFW+T5CWIEOqm/oaYqR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnub3ibJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k44Vhiqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnub3ibJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k44Vhiqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kbOMQBVAhPddh1fc9S9hVBoJE1QXhrm/1cN6yecgL4=;
	b=Fnub3ibJib38lBkOeQNoTTXr+eLIpV/QxGCTNl2gpV+PIzP4TL//axXcCf77jvaH8CjdTO
	OBQHKEGEz4Xb7V6UexIk3a6tXdlz9g6VvM5sGoX65g7btz/jTYvibJyYwZ0JtVdwbNMPDj
	qgSrAyig4TXh7acaMr9Lcgm78aVyBpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-VpvJgVUjOA-XJj_7CLceRQ-1; Thu, 06 Aug 2026 08:57:59 -0400
X-MC-Unique: VpvJgVUjOA-XJj_7CLceRQ-1
X-Mimecast-MFC-AGG-ID: VpvJgVUjOA-XJj_7CLceRQ_1786021078
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so1592505f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786021078; x=1786625878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kbOMQBVAhPddh1fc9S9hVBoJE1QXhrm/1cN6yecgL4=;
        b=k44Vhiqq9s5i0LCRY2ja6LZJqKePSKtxsYkZjDUa9Ir36zNzaPcvXHhBoEsGjiqCCp
         zlMURqbjqzaTIsrS5PjoEbw708qI9wTYATo16mufr4CNuZLpILTJ+cWsTUeRHXZw9L5G
         w9DuBVSdqZ5iZrA8bl80P1BxMTZBmL93elNqiRn6RG9NlU8TrlP/TqQM7MTefhBPN47p
         B7ccGEigjBNvOIOF7krRl4V4XgrGm2PZVQRdPdNvB79TsC6bdbS8JRkb8GNJQMFIwReD
         mYgoekzNeU4Qq4IW6ddsGLiiLtgY96HiQCYjAOJjEcbVlLCTRkTeQsR4KzKApwbuxyKx
         qNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021078; x=1786625878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6kbOMQBVAhPddh1fc9S9hVBoJE1QXhrm/1cN6yecgL4=;
        b=fAkNnAoLRXGek3POk7EiMcM73jMBbfAf9E0RWTBoaluAZLEQyJOHkQY4LabeFL3UZ6
         H0ima133jlqlof1oXYSzyiqYVGd43ofFUgkCtf3BgBwKzscNz6cDSufmgh5mlgNecnNf
         X7tqpzS1wkwe2wdtCTXrjbCQvanquvJM5HQ95JFRSj7duRfHycYcFxnWM3d1bcJk46K/
         bPyzE//enJKkR7Obv3xPnqaXjeUXi2gyiU5Fu9kv/7MJa7wnGEfzyFqQzvvx+r7T/bN5
         aMaa/mhyQiu+gxSZ4AxQFQZhpO+uEP8pucDBvm6TOKBQpQLtUrJfdqb1BkDrMna6TsRN
         tutw==
X-Forwarded-Encrypted: i=1; AHgh+RoK8iTyDQafQeOYQlLXKkwuegs2xZcaHnxVtSyCfAMFtHJ8MPoLU6hIir/ipw0gn7Y6aDFAmbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDC2+1ZzYEgm7CcJhWCyCQIe4DopnfUEIWVjsE+qUKX7FnjIo+
	ssT4cKlXa/3xNoP+lNhbetH+7e8dGPPKHQaZskYJ0aiUQdntc3ySs5VctsfBEYtnj4OLNku1vMZ
	L85AjSRG2k+jz1bhQAqgjbwL32f+Rw7A5T6WGJvU5QpyUMYDvZ6BrWHr/rA==
X-Gm-Gg: AR+sD13RhkJZ2FCfrGLAnn9noGRk1f8/JLtELw+Thmn2ldcK3pYbFdqADxNKw9/eXO5
	BcG8dGSD6oT5yWiuMssqtS2u1mZ3oYw7dCxiayzqT1wAsWsfUuiDMUIsb9eMJo3SvNdirSbK8te
	4EnCAIi/aX4ECOYI0r1jYVMgNs0Zn1uIzW/4LimMWGqIBCcSA6rcPKSbMVvhRRa54jgy0QezwDr
	7eYaDUjS9E/AwOxB68xVKjEf+4OO/c44ug5tO9uY3EeSh9gtWhZQjAESZphMF7yVipPfdPDEKkv
	YJH3sywxjDGFvoc7W9IAzpZeAoqVN25rc0nY/tDBfVGLGZ9dGFn/if8iMJ+hNT1hi02mSAAChGp
	lh5I=
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr185171385e9.6.1786021078285;
        Thu, 06 Aug 2026 05:57:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr185170495e9.6.1786021077713;
        Thu, 06 Aug 2026 05:57:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d9dsm70070355e9.2.2026.08.06.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:57:56 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:57:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, Wupeng Ma <mawupeng1@huawei.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anSEfl9bG6HjlMpz@sgarzare-redhat>
References: <20260804135238.386417-1-phind.uet@gmail.com>
 <anLuRE4ix5-BZ7-t@sgarzare-redhat>
 <b64dde64-8ae0-4b97-bd65-14da8d9cb5eb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b64dde64-8ae0-4b97-bd65-14da8d9cb5eb@gmail.com>

On Wed, Aug 05, 2026 at 06:29:36PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 5/8/26 16:34, Stefano Garzarella wrote:
>>On Tue, Aug 04, 2026 at 09:52:36PM +0800, phind.uet@gmail.com wrote:
>>>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>
>>>Syzbot reported an issue which can be reproduced with these steps:
>>>
>>>  r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>  bind(r0, {VMADDR_CID_ANY, PORT})
>>>  connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>>  listen(r0, backlog)                     -> 0
>>>  r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>  connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>>  accept(r0)                              -> -1, EPROTO  (stale sk_err)
>>>
>>>Basically, it creates a socket (r0) and triggers a self-connect after
>>>binding it. This self-connect fails with EPROTO because it loops back to
>>>r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>>>incorrectly dispatched to the connecting-client path. The unexpected
>>>packet type encountered there sets sk_err to EPROTO.
>>>
>>>After that, it invokes a listen() call on the same socket. This listen()
>>>call succeeds because the kernel's listening path never inspects or
>>>clears sk_err. Then, a new socket (r1) is created as a normal client and
>>>connects to r0. However, vsock_accept() rejects this incoming connection
>>>because the listener's sk_err still holds the EPROTO error from the
>>>earlier failed self-connect.
>>>
>>>This rejection causes the child socket created for r1's connection to
>>>never be freed on virtio or hyperv transports; only the VMCI transport
>>>implements pending_work to revisit and clean up a rejected socket.
>>>
>>>Fix the issue in blocking connect() by using sock_error() to read the
>>>sk_err to prevent the rejection branch from occurring in this scenario.
>>>
>>>sock_error() atomically reads and clears sk_err, ensuring the error is
>>>consumed when vsock_connect() returns and cannot affect subsequent
>>>operations on the same socket. This matches the established pattern
>>>used by other protocol connect() implementations in the network
>>>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>>
>>>For non-blocking connection, vsock_connect_timeout() may set
>>>sk->sk_err after vsock_connect() has returned. To handle it, we also
>>>remove the sk_err checks from vsock_accept(). Nothing in vsock sets
>>>sk_err on a listening socket, so accept() has no reason to inspect it
>>>at all.
>>>
>>>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>>>Suggested-by: Michal Luczaj <mhal@rbox.co>
>>>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>>>---
>>>V2: Add reproducer steps to commit message.
>>>V3: Fix truncated title and add annotations to reproducer steps.
>>>V4: Remove sk_err checks from vsock_accept()
>>>
>>>net/vmw_vsock/af_vsock.c | 13 ++++---------
>>>1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>index 622dbd046799..594fe27d2ebe 100644
>>>--- a/net/vmw_vsock/af_vsock.c
>>>+++ b/net/vmw_vsock/af_vsock.c
>>>@@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, 
>>>struct sockaddr_unsized *addr,
>>>        prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>>>    }
>>>
>>>-    if (sk->sk_err) {
>>>-        err = -sk->sk_err;
>>>+    err = sock_error(sk);
>>>+    if (err) {
>>>        sk->sk_state = TCP_CLOSE;
>>>        sock->state = SS_UNCONNECTED;
>>>-    } else {
>>>-        err = 0;
>>>    }
>>>
>>>out_wait:
>>>@@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, 
>>>struct socket *newsock,
>>>    timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>>>
>>>    while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>>>-           listener->sk_err == 0 && timeout != 0) {
>>>+           timeout != 0) {
>>>        prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>>>        release_sock(listener);
>>>        timeout = schedule_timeout(timeout);
>>>@@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket 
>>>*sock, struct socket *newsock,
>>>        }
>>>    }
>>>
>>>-    if (listener->sk_err) {
>>>-        err = -listener->sk_err;
>>>-    } else if (!connected) {
>>>+    if (!connected)
>>>        err = -EAGAIN;
>>>-    }
>>>
>>>    if (connected) {
>>
>>Can this become an `} else {` ?
>>
>>Or just add a `goto out` when setting `err = -EAGAIN`.
>>
>
>I will update it.
>
>>>        sk_acceptq_removed(listener);
>>
>>         lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
>>         vconnected = vsock_sk(connected);
>>
>>         /* If the listener socket has received an error, then we should
>>          * reject this socket and return.  Note that we simply mark the
>>          * socket rejected, drop our reference, and let the cleanup
>>          * function handle the cleanup; the fact that we found it in
>>          * the listener's accept queue guarantees that the cleanup
>>          * function hasn't run yet.
>>          */
>>         if (err) {
>>             vconnected->rejected = true;
>>         } else {
>>
>>
>>Should we update this comment too and maybe remove the `if (err)` at
>>all. With that change I guess `rejected` is never set at the end and
>>maybe we can remove it at all from `struct vsock_sock`.
>>
>>Looking at commit d021c344051a ("VSOCK: Introduce VM Sockets") where
>>`rejected` was introduced, I can't see any path where sk_err is set on
>>a listener socket, so I guess that path was dead since the beginning.
>>
>
>That seems true, let me verify it.
>
>>So now I'm thinking if it's better to split in 2 patches (both with the
>>same Fixes tag):
>>- Patch 1: "vsock: remove stale sk_err checks from vsock_accept()"
>>   Where we can also remove `rejected` since it's never set to true since
>>   the beginning
>>- Patch 2: "vsock: use sock_error() to consume sk_err after a failed
>>   connect"
>>
>>WDYT?
>>
>
>Yes, I felt the same when I was writing the commit message, but honestly I
>didn't know that I could split it into a series when sending the new 
>version.
>
>So, it may contain 3 patches, if the rejected flag can be removed from 
>vsock_sock.

Yeah, or including the rejected flag removal in the patch 1 I suggested.

Up to you.

Thanks,
Stefano

