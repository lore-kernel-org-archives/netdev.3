Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6295372D7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085398; cv=none; b=LcOdtv0jTwElUnx6P/qfhsvDWslF3023MIXDSaAkX8eUPsltYj5rxLdM/fYZrSGHt1pcYNk8rCyDPMUTYTqyPHIYz3zgcjzv838ReFb9UJjBQkZPkOOrNYeZNZNt/Txq5Z8THRw2MTJik9ApOmM0e0/dn8WyLwZpqj7rZ16Y50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085398; c=relaxed/simple;
	bh=xpzff7gTANmin7ayImKqNSwtv/jMmdVMSrHmqXKpE6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3lIfaz8gtQYvc4xeMPuw63JFp1tX9B5xxzjbU03qyvm7M9ujKoqhP6tYQJ3A1uUdUqR2R8zCRzr5YZ6zLE7Y78HBY1115TImdm2oBIQin5LNXbKw4HxXa5nLWpTj0592Ylsl7oAUP2P6hZJ+KcQ7YAT0phAy/WGicIZR5/oglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7vSUrwo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pesz3oLA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7vSUrwo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pesz3oLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSAJceS2lTxo7RYYkwSiAWcerJGzn5wbrFBMDwrG220=;
	b=P7vSUrwo4CXnq27JHh8T8DHgqpeAEMW9gsUJ55nGRjINrMKTuyrqenbbqZbgFVJm7Ny4jr
	OezWmUxIqKTTw787/z2kEWkWO7dcGHD/HOfjicx2QVza8MM/iIFy/7SOYVFepeoD6rdD9D
	B7ohlkf17xKW2Fvp19uUpLHzGSLOUVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-z3yvnRJhOfK5e75Ytz_ehA-1; Tue, 22 Sep 2026 09:56:30 -0400
X-MC-Unique: z3yvnRJhOfK5e75Ytz_ehA-1
X-Mimecast-MFC-AGG-ID: z3yvnRJhOfK5e75Ytz_ehA_1790085388
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e661c6440so23321425e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790085388; x=1790690188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSAJceS2lTxo7RYYkwSiAWcerJGzn5wbrFBMDwrG220=;
        b=pesz3oLA7oNsGimyIwn6ibbE477R4MFL0Ikop4LsCzdWs3+IaWKZYbhLl8atuJ4AT3
         JSmrKOorR2wJa5par0Xwb6s4nwZxPodWNh8BtUFDeDGEdEdpZz3kSK/DhM0lIOO9Vce+
         O8VeDwCQUMZTx3GNTvTeO1IFengKpfVuEAxYh5Dy25Eu0a1sh+//Sd238R48Vchs5orX
         ZCHQIcV94Mzts17BNy845bnMKLCYrEy307t5BXODaJjG8/hNkyEFWteSgx+lzEDCh5Qf
         iPCUU0yGXbzEOCOTcbQJzU62JU31NpwnpdTjuQC+j6iDYMDb+VO25FQz/pSOzIZGO+/+
         JA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085388; x=1790690188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSAJceS2lTxo7RYYkwSiAWcerJGzn5wbrFBMDwrG220=;
        b=Jdqc6XDINCQOzOSgD876c6kcFUr5wtft/0K4riVSkhjFVcOjT5X5DBU/HFzUyaBBbS
         gPKGaVM6Zp0g/lhy9zKbuVSntQpGoFIGAeZdFIVrrMdUctJu8q2IpNfdwBKSFRyzHvbG
         N8gLITSdNRaQsFBX9YTU9c46NL3rBpNNqfC4Xlj4kcN8YEj19NZkr7L9uWmbvC9CL9rQ
         8aoZ+0kRdYfqPlS7Sa/vBVuJ8fnuWSODbFOhcglOAZVEiIF2HDGMWvNNLJw6lojj7nTe
         GYfIontlXdS+2nJ0lirlBCQyEyX75IgBtoyg2aw06ngeTVRyCYL7F+ydGEHrFz6aa4lp
         WISg==
X-Gm-Message-State: AFuF++ltqS/iVCYwPUyeSJeb3J+TocJx8ULqqPcuc7fIXnVvvHYwolwr
	GZhMrABnKLlx2tORI2gMOSyRxdZ8Li+JHJ22nWU7+imqN+h+PD3N3PAMM69oLFHrX8jPsnRbCYp
	3C8/iri2EvqfM02AxCtD610GtBmSXmkE5M4R2aA2TRMbY+phe+hjFP+MN4g==
X-Gm-Gg: AYBFou2pSxjd+kwNw6iDjQ284VcpjAzMSCgHAdiA+4Ra3GgzCZ/OECZ1uAI6WKHX0MW
	NyxkrQpCR/RdyzenKdYvqMVrz6wQ+XEGDJxZ+xk+yyXKlAfBNj+9nHHn6Uu43nP6z3RPeZjy+GC
	mnIKZyX3WP8OPHdFGCMz2Uoy7eeCix3XMokSDZ7j8V4xjR6mSAamCDubJ3Uo/ScAR19brWIGltF
	kMOo7GnDbMGH1jPCU98bIk7nfRNLOf0vhK+pMW0HUK9SfitbekAFJKGkZTmqEM1RbPyKVxf++cv
	meC5+dcPJLNZgl4zttbNUgc6xOyYcEjuMoERGVbNqfYqgfanCkB5JtIXC8kF4XYnwkKNFlyBEPY
	XI+UmAtP81J2FwZNd+DcvoPkA1s5I7FkVODop9QgysTByu2qCS1Y=
X-Received: by 2002:a05:600c:6298:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fc5687adamr193025405e9.1.1790085388329;
        Tue, 22 Sep 2026 06:56:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49fc5687adamr193024815e9.1.1790085387814;
        Tue, 22 Sep 2026 06:56:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdace7941sm63084875e9.2.2026.09.22.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:56:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:56:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: report pending receive data to
 io_uring
Message-ID: <arKF7P9gqq7ehX-k@sgarzare-redhat>
References: <20260920194710.1114748-1-devnexen@gmail.com>
 <20260920194710.1114748-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260920194710.1114748-2-devnexen@gmail.com>

On Sun, Sep 20, 2026 at 08:47:09PM +0100, David Carlier wrote:
>AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
>IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
>queue has been drained.
>
>Fill the hint at the common receive exit using the transport callback that
>SIOCINQ already uses, and report 1 once the connection is finished so the
>caller performs the receive which observes EOF, as TCP does after a FIN.
>
>A vsock loopback ping-pong with io_uring multishot receive drops entries
>into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
>and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 39 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f840498b58af..63309708c916 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2543,6 +2543,38 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+/* Bytes a following receive can consume, 1 if it would only see EOF, or a
>+ * negative value to leave the caller's hint alone.
>+ *
>+ * Called under the socket lock after a nonnegative stream receive, so a NULL
>+ * transport implies SOCK_DONE.
>+ */
>+static int vsock_inq_hint(struct sock *sk)

can we add "stream" in the name so it's clear that is stream only?

(e.g. vsock_stream_inq_hint)

>+{
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	s64 data;
>+
>+	if ((sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
>+		return 1;
>+
>+	if (!vsk->transport)
>+		return 1;

Can we squash this in the previous block?

>+
>+	data = vsock_stream_has_data(vsk);
>+	if (data < 0)
>+		return -1;
>+	if (data > 0)
>+		return (int)min_t(s64, data, INT_MAX);

nit: IMO we can remove the int cast.

>+
>+	/* Empty but finished: keep the caller reading so it sees EOF. */
>+	if (sock_flag(sk, SOCK_DONE) ||
>+	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
>+		return 1;
>+
>+	return 0;
>+}
>+
> int
> __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			    int flags)
>@@ -2606,6 +2638,13 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>
> out:
>+	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM) {

Why only STREAM?
A comment here and in the commit would be nice.



>+		int inq = vsock_inq_hint(sk);
>+
>+		if (inq >= 0)

Why assigning only >= 0 values?

Thanks,
Stefano


>+			msg->msg_inq = inq;
>+	}
>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.55.0
>

