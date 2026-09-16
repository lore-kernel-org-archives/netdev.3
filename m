Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381ED49CF38
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561864; cv=none; b=ZCZH+lRsmg6uA0v7vCTnAVHyxf8P9g+/4DopqPAlhSoUGcPujpju3MbqkTvli/ksLE8y4n2RTiUorVeL2hrXDHdS6osLZIx066nT40rIP4tnjtrAQOzCzEXUk9bW1veKuV7/YDLbK5KVZHjFsqJoWPnzC7TDpS7adP/6qPaVMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561864; c=relaxed/simple;
	bh=XGXi9MYz+h2MYHPVx7/i/kQbavA7JbRWDIW6+ytE058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrPAbEVruTN+KlW1NUOg+AxpZaYndLsfgOY8OaIPFMvBl6W1dNd64gTPTto+KKbHkMzdST1QDZaK+S0BmkId2bKNRhMKTv47623vtxDt8g3MUbIrkyw8c3sRwVDGsL7APqUnSYsWZkuyImxjw8xh21q3xq1kbWXcz+CVae76vGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO74XkCq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKm+6+r9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO74XkCq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKm+6+r9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
	b=DO74XkCqRa5oKucfYqETULuWcx29AwxpLw+x8C+mCU7iU4CfMXgl8b92rHocqDRcqG2fOE
	/0+gfXG22LTtxxOuyXGV2Ma3LWo2dXmLeM+oxxKlb6bG1ZualsdidBXYYN2jgraklxC9G7
	DjOVw+FatpfUQ+cuwhmgtmw+cn9XBFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-weOqQnpBOf-Y3TquxTju1w-1; Wed, 16 Sep 2026 08:31:01 -0400
X-MC-Unique: weOqQnpBOf-Y3TquxTju1w-1
X-Mimecast-MFC-AGG-ID: weOqQnpBOf-Y3TquxTju1w_1789561860
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso51452115e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561860; x=1790166660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
        b=BKm+6+r9lu3DsJE4uW8J2eBtIfEmodPbvwFiGz+ePabXnBwlL0012AxjbX7t21gP/E
         NUJm/VXNR02u1Eb0VruDf987OWmQrDwIbbT7ZNGe3y5bMY9B0XsL/vDfBFHEULSSLFV8
         dVgDv9zlwmkuHLzT8PZ9QnatBLhYiy2zEWEhQodtQydoEV9/pFh9XyK4Dks8FWbE7gHS
         8Jmka45RT7HNySHWV0cnTXDVbXNmvp/k8KyqzDmEOpJx/+Tzdf+FF7EZ8rU0HrJ7YI9O
         8MLG0eYWFz50aHuSSJLis9mkhrQpcbPtzmxaE+71681wJcIqHRG7casKZuJ9RGsdXgK/
         cCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561860; x=1790166660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
        b=B9F1K4sScnhSAqcyVp2zmWmyPx5s16kXpXKDXNIiLB4xmvA6V7lMrpgMGaRmg2gK5c
         zomfuznIY+m5WOfNUWpIZtU6SeB/FPkRLycm0IwMJB353YW8YF/q04kwNChXzvQD06iv
         /WpmhoG1bQIiyi8gyUFD7SHcJLx3rfnPjkj92l+Zwo1E2ZNtp7+74ZzY4nqU9EGHixmg
         CJUo2xPSLqU2egPcmFkPJHyzDWU0HhcNcd7JpbGc70gjDzpkgkIn0Ljasjb2/3Yj5adR
         a4ZfBCHy9RqZYJ3BZ6WIOmiuDx8VxxDB6llwUc4ZEEROaPwjuZvAxfR768zFgaLaA/Hw
         8C7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6E3xGj3lJW8jRb9ZugH3fAZFaIkxv2MXt6Gi0uJ/1a4KEnL52RiXm59NiK9/hmGVIQO1LzDw=@vger.kernel.org
X-Gm-Message-State: AFuF++nXqA5znZ4nkxlQutxFpyCMLYArK2TA1EBPu+p9+eY0q86M9Lvp
	36SSZzxKJvTwYKHX+Hy+Hu3isu/JfL8JZ9G5HNo8HGaoWBCsO47CFkTZZ5C2IkFXwRqfkq5yrnz
	+77UMzK4IBd9ACvS226NM4hJbKBGLVSTRMdV2lUOuf5S1HdKaWkj9cn9SoQ==
X-Gm-Gg: AYBFou1kmMaEz+qg1fjvGhj3T96Z5JXf/flXVmxPJxjVyPxe5rWqZy3a2+kxYJoqy+N
	/KZeXFZ/6WxhAhNdvlWRZRKUaZDpyUhqe/1O+R9/wqqiIlGlnlB4NU4dZtpGHBbd2s7cGpF58N3
	vqhk2N1o9CYEiMTf0kh1bPCjbXTp2kHSs8uJWrfEBwY7XNPQRBgNG0p+9m2763A9Dp18uH2F1wX
	0U3OcbwNUVPpP+RlE19TQnPtVg0RRmRt2MjFDNHzYT5THe2FLYcl/VK7FSDd5lAR455jVapdQuV
	plY2ju/K/5lMJo/0CtAoPS+uS93FVr1mECKdWqB0sfhZOObf92OHJ7Ozyx/3DeusW7biDUmuo5c
	qpOQ5hOVzIFiQYboF/KRio3Qtdbc818IxooddjTsR2XpqNw==
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61109795e9.8.1789561859685;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61107955e9.8.1789561859097;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d903f6sm72500905e9.4.2026.09.16.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
Message-ID: <aqqFkBYebKK1nZNJ@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:15PM +0200, Michal Luczaj wrote:
>Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
>transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
>loop.
>
>Resetting a socket that is still present in connected_table can lead to
>memory corruption. The reporter noted lost transports for in-flight skbs,
>and I have reproduced crashes caused by re-insertion into connected_table.
>
>  list_add double add: new=, prev=, next=.
>  kernel BUG at lib/list_debug.c:35!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  Workqueue: vsock-loopback vsock_loopback_work
>  RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>  Call Trace:
>   vsock_insert_connected.cold+0xe/0x13
>   virtio_transport_recv_pkt+0x10e9/0x1460
>   vsock_loopback_work+0x305/0x480
>   process_one_work+0xe4c/0x1560
>   worker_thread+0x4f1/0xd60
>   kthread+0x36e/0x470
>   ret_from_fork+0x47b/0x6b0
>   ret_from_fork_asm+0x1a/0x30
>
>Drop the redundant err=0 and the inaccurate comment above signal_pending().
>This fix is supplementary to commit 002541ef650b ("vsock: Ignore
>signal/timeout on connect() if already established"). Details under Link.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
>Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 499e902becfa..adf3f018347e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1712,7 +1712,6 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 	long timeout;
> 	DEFINE_WAIT(wait);
>
>-	err = 0;
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>
>@@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>-		/* Connection established. Whatever happens to socket once we
>-		 * release it, that's not connect()'s concern. No need to go
>+		/* Connection was established. Whatever happens to socket once
>+		 * we release it, that's not connect()'s concern. No need to go
> 		 * into signal and timeout handling. Call it a day.
> 		 *
> 		 * Note that allowing to "reset" an already established socket
> 		 * here is racy and insecure.
> 		 */
>-		if (sk->sk_state == TCP_ESTABLISHED)
>-			break;
>+		if (sk->sk_state == TCP_ESTABLISHED ||
>+		    sk->sk_state == TCP_CLOSING) {
>+			err = 0;
>+			goto out_wait;
>+		}
>
> 		/* If connection was _not_ established and a signal/timeout came
> 		 * to be, we want the socket's state reset. User space may want
> 		 * to retry.
>-		 *
>-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>-		 * vsock_connected_table. We keep the binding and the transport
>-		 * assigned.

Should we keep "We keep the binding and the transport assigned." or 
maybe add on the other phrase, "User space may want to retry, so we keep 
..."

> 		 */
> 		if (signal_pending(current) || timeout == 0) {
> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>@@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	err = sock_error(sk);
>-	if (err) {

Should we add a comment here explaining why we are doing this?

Thanks,
Stefano

>+	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
>+		err = sock_error(sk);
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
>
>-- 
>2.55.0
>

