Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE12455176
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698246; cv=none; b=kv5GPlIG/mVrRjEer7MBdL1CLPfJggT4E9iiqEqloP5hzesE0BrffLf/Nho03r0+/fBcv9Xv5vAx1CGTzhTi5QDWYvjyypijA0c5r4AQX9Bh1SmU62EDXGC9+saMUDzY9dij2fMxT2p6PZDxXwJSm7NG4c6K6J1ysexOtHKzEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698246; c=relaxed/simple;
	bh=BJOf/NYSz5FG6Adem09lwkZwKWp2jY+TOiFmVjNC3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra7qHkvkXll+hmZIDw4CqMkHdUeMxi0KRaD5/mxlyQk5RaFLSKx7Urb9WmtT952xeaEjEAO4dFvuCGa2DgRPcRidkIgO5mk420l9uCiUwfvub57l0GTlAYcTl3rrWfW4vBTvLulQw2AMTxzTGCFcmtp/d98X+8rZbtchM5rXb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/fzh7QJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=idKzYNwC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/fzh7QJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="idKzYNwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786698243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2zwZEotU4Mzq+YNLMdkEnsd0V5EVOvlW1UTGUzYHRYk=;
	b=F/fzh7QJuOReZTYphbD4sjTG3M13ycYoycjbxS2IqAykRlYbfZeaStltHNrlx3XiFq2m6o
	J/QIIfL6Vz1FATdyX+kdNOhluUf3F6vt2xTGHAOVGYaHQMcDuXjWzhKEo20UMGpG+/M/cP
	nd+nbSkrN3azaljw+nhJCiuxXnzV9PA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-R0pDwE9bPUeqiTUZMLdZ6Q-1; Fri, 14 Aug 2026 05:04:01 -0400
X-MC-Unique: R0pDwE9bPUeqiTUZMLdZ6Q-1
X-Mimecast-MFC-AGG-ID: R0pDwE9bPUeqiTUZMLdZ6Q_1786698240
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6d70223dso449795f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786698240; x=1787303040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zwZEotU4Mzq+YNLMdkEnsd0V5EVOvlW1UTGUzYHRYk=;
        b=idKzYNwCrz1JKtKo7fjCX4irhU0xPLN0S/+bjaguGx563rAYYc7g3OmBkjFs37sxth
         yQzG3kENKvWRQp+BWtfRFNBr9HU2Rjsu0EGyB8bLR+mPHlLeHBPpfHdIkHUCU52hdED/
         XjNkDly6lb9dYWZi1gKTsDItgmktVAPdu7GwWgHPWCSP7lLQcUD9oorgC0sp5JJhYd9Y
         vAqnrQMk/vHh1817h9YwFbaN05zvvBlWyYPelw5wlessN+cmiKvxiCc0Ru/BpPOr1jFX
         1lM8h2HZZLsfJvY4Km7rfjBB92VdX0YFGFj3lF7YFMLGPwMR7eFWr81YvVAEw/HmwAqv
         24/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698240; x=1787303040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zwZEotU4Mzq+YNLMdkEnsd0V5EVOvlW1UTGUzYHRYk=;
        b=JixadV8qOeLLEqcjYRHU1lnw3/2+g4d3BHzwrfba8vT7uzZcB7T8kAuEXXDQ7l0UP8
         O67ae0Z3utk2YnLHVZpElpRRS/Ctdyks+IVdOlD5Tfbs3975CnLiaInLdGu0/QqVTZHN
         n43fohUcmlAKx8XUgx1m0qTIjbVoEGe9ffw/pXE700kB9KJquO+BtXC3JsWQUKIta0qR
         O3+vhtTUg8kgel4RJ3BgwEJVFN9uTnrQwkcgWAE3dHdKb6aGq++dw76JjDircFt0NjfD
         aks9QTcRMAa7ze6t1y+LGXI7xKjEGU9mNzkafv3VeG41t+W3m8qVVf40Ssg10VcuvaXT
         xV4w==
X-Forwarded-Encrypted: i=1; AHgh+Rpd/m/cbQNSsuhjYCR5S5QLqJrqNk56DfuzhhoLdX1Vy+RlEULoPChEKbuI18usfVu94bcV65s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2b7opxSeVGwPlHRKw8f/O2teagx2qUtbh4pouTjehBgcnFiQp
	Cy6NfzcS6ynaC6YhwHuN8FMcN1C0IetS5hjM0D1fepF3K/CxpywANqsg7UciC3hXeo3vc9y3FrP
	D1418s+yICsSAo09BE7eNHwGY3W0ahrdaIGzyCQ+Uuit8WrIqtRF6FQbvEA==
X-Gm-Gg: AR+sD135mosyB+xI+c0GTmkhm3yp3R/BWOULeWFQUz2N69MaGMN17rIvbzWXl/ednvV
	LfaIqsdhG0GziidvLd3dnZnAMdDWxlfXki6sBggKHCP0piLmbB8m1qTVWVKJwk7+iqbh03y8E3d
	vylhP+qrXsNxgq3pMaNfrleJ89q2QHl31mGHyAyWn6Felemdh9ym/mcnHYEh8pIj6pHU8F7uibe
	Oj0MBYhK8tpSAf7kNchppjY6O6d6nQTthdbHiUXvy3EpCFvq4ogTJI6aNPz/7VWncWkMTDeZWuf
	H5ABpH2GV0E+D1Jedhubk74DdnfHciAK3XKgmKSMsdgIotvu60s6bDQHveBFetwi9FnDZHROT81
	i+aYfFDYWEDje2DM5RqQ1n+bOHnUZwtVGAbSRKxFPGMDUCXcmkiol
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id 5b1f17b1804b1-49988073627mr38667215e9.13.1786698240102;
        Fri, 14 Aug 2026 02:04:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id 5b1f17b1804b1-49988073627mr38665965e9.13.1786698239643;
        Fri, 14 Aug 2026 02:03:59 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b24746sm58416435e9.12.2026.08.14.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:03:58 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:03:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] vsock: don't check the listener's sk_err in
 vsock_accept()
Message-ID: <an7ZiFM2nmb6kn2_@sgarzare-redhat>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
 <20260813173024.2362935-2-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260813173024.2362935-2-phind.uet@gmail.com>

On Fri, Aug 14, 2026 at 01:30:18AM +0800, Nguyen Dinh Phi wrote:
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
>index 622dbd046799..3cd5c3561be3 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+		timeout != 0) {
                 ^
nit: I think the alignment is wrong, maybe if you need to respin you can 
fix it

Anyway, this LGTM

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

