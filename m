Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C13DFC8A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610318; cv=none; b=KuNgmvWuD7Nv/QJI/ZDjykA5Nkk0bVN2bXUm2xoYjQ9JfikFc/hhwEa91JQwjDSH+zRGtT+wBw5Kq8bSTixbLZtidFVdw7H7hsEnugihFJ+n6Zc98SJ6/N79U4KdkUTOZu93hws95Jt3WdP24JYtg2I0SuEd9VbqaV6bIdAC1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610318; c=relaxed/simple;
	bh=3A1TTzgx3HjDy337B7QEOqwQ54G9OEVp/xDl3QsWJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLYSrxvLUO3t8fFYX8bkI/2BWrCUlpKDQAlZ82QWK23/vi7olTuCr2uVFzERciBoeXKWEJxuJTWjIeoJughkYb69rtoJsHKzaPdYZR/j2n7gM7HBYug2oEmT3ZA7sQ2416N+viuKTjwUcNAzbcp58Q3gEWtIgpcOce/LJd8Oifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWX7d7kI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mKeS6Li6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWX7d7kI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mKeS6Li6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786610315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=smAcv540nFYZlu+sSf+onJiRx1q/LBaPc+nj8Z/q0is=;
	b=VWX7d7kI06grmSAQsoOeVpI+U7SJqINHFm6u9Q1xwsdY9GrYfJTB7jTFFe5i+uOBSppkv2
	/iF31dIjSHAEdiuA6oObxYr1ujSFwtCtxy1ePsATd94nMd7a8nmwCetQFTR9ZCulTAQaRH
	ZJjt69qzeChrdSsYliERx/Kau3JGx3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-OIL9eGasPtWIx8tUZBe-bg-1; Thu, 13 Aug 2026 04:38:34 -0400
X-MC-Unique: OIL9eGasPtWIx8tUZBe-bg-1
X-Mimecast-MFC-AGG-ID: OIL9eGasPtWIx8tUZBe-bg_1786610313
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4996832e7b4so4641255e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786610313; x=1787215113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=smAcv540nFYZlu+sSf+onJiRx1q/LBaPc+nj8Z/q0is=;
        b=mKeS6Li6vhYVZRLmQiueiPSg3+WmvX1XolOqnYY/XnSOZMmO8ybyMRbsAu9jYTBNSB
         sK2SEQz3BsTJmFsAiCExo3xD26g8jEN1rgP931do2ud9lGVzg1TE+w/XzQkSK/ix4TLp
         7Cc1IAXzM4dePfvx9mQlmMF3S/b7ATexi3AOqxg8aqodNWx9NRHv8ZgVSvdfK/J/3mfU
         Cviz+dKvtIOkWVXHnAJyE2WyWJJ8vHh8qk1hqzRmebzye6pj4ixLYkLyJ3NKc0Oi2xKW
         6sIEG7jqx90+1UNccja4/AzfNE5yiAiXEyA6XXm3Fs4v/Tby0O5/HRtA1WUTrbhtfLGD
         qilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610313; x=1787215113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smAcv540nFYZlu+sSf+onJiRx1q/LBaPc+nj8Z/q0is=;
        b=IDDxPxxmpfMVt1z2msk/CYInV0t8IdSC1Rd2s0sRD8e8cHwnltPFpLSbgsKOh8x8XV
         SC65NlqkWCPP+474QeS90eWyAQpnjYGEX7+8K7Hahcj47/G1hOBxkTKIHpxL4DqBs7ok
         nUNWK3lP3f7w6aZ44OGScOuSMjITQEzpGZ4nx6p6nr1ocQmFF35IFw1yH1ywSNg70g47
         gcboIBgPn2IfrAbvUPf9uP3DFQ337Bto+SiNm5ED+MpmXMKs253b0EPLgwQ4WE6J6ktY
         gFQ1f0ExUxNw5cbaz2kRT5dsuH1nAinDAJeQW6P8NHSxh5pFgy8qc/Pf+YM/r2cOKWq1
         GEdA==
X-Forwarded-Encrypted: i=1; AHgh+RpOE+gD43tIz22InzLgxU+QbAYSxskOLaICs9PS3n6gcZv0B0WGXte4M0Hm1YJIY6xGqVWu8a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREo9snla5l2oJsO7LpFNXAWf08GRIeyJKTynSmVuj4Cl1xtNw
	nYv8Dd+0LvLrdA2Rggq01gZDhiF2MwWhWpU96etLMB19pdD6ZgArFDoy6omNnv/C8TAK7n+g8nJ
	va8aBPH3mA3Op5GtMY38RC5yekG56aSoTu+IX1Q73M3mx6UddtfysIQjEzw==
X-Gm-Gg: AR+sD122C37zuxfaRNAZroK4r9LyWEaxZEAJPuVGLHC+ryZVHZt+4yB9VKvqRJU6hGl
	ITfvxVy6qkUeOatx3FPkHsXIsnX6BIb6I5I6Zof+BRZy9Svj/X7mfRGqYXtKBPvQKXEiZ7K2qQC
	LDTJj3ncELwp3Sw1pU/HVusyGRjQD6xjg9WhNqWxULCzw16R4pmJ+FMzuE4c2oQB03Q5MHj72PC
	xVl0ltIx0Uw7ocj4lr3WyI6L5kQw+M6ppgoFn6RkaV3c6ycpBr+Plj2KPqoDH2ajlyZUqjSmKad
	TbQKfisJZAr2f/rcU7n/YB2fmkJp9P3VhlKQhZGEicYRvwvDKTZ9zHu/g2FYvMmbBZjVxmKjxhG
	RRuGpHdbyyOqoO1hxFLNv0zMFlApjCQi1nzbzoJPns8rJP7pMfWnl
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr2857965e9.5.1786610312816;
        Thu, 13 Aug 2026 01:38:32 -0700 (PDT)
X-Received: by 2002:a05:600d:6409:10b0:499:84fc:4548 with SMTP id 5b1f17b1804b1-49984fc45c0mr2857405e9.5.1786610312345;
        Thu, 13 Aug 2026 01:38:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm46251145e9.13.2026.08.13.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:38:31 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:38:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] vsock: remove the now-unused rejected flag
Message-ID: <an15JxACeo30Owo_@sgarzare-redhat>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
 <20260810170935.2242314-3-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810170935.2242314-3-phind.uet@gmail.com>

On Tue, Aug 11, 2026 at 01:09:31AM +0800, Nguyen Dinh Phi wrote:
>After previous patch, the branch marking a socket rejected in
>vsock_accept() is unreachable, and nothing ever sets vsk->rejected
>elsewhere.
>
>Therefore, we can remove the `rejected` field from vsock_sock structure.

I'd like to mention here that since commit d021c344051a ("VSOCK: 
Introduce VM Sockets") where `rejected` was introduced, we didn't have 
any path where sk_err is set on a listener socket, so that path was dead 
since the beginning.

The rest LGTM!

Thanks,
Stefano

>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> include/net/af_vsock.h   |  5 +----
> net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
> 2 files changed, 16 insertions(+), 35 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 30046a3c20f7..3357ee62d10b 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -52,13 +52,10 @@ struct vsock_sock {
> 	 * The listening socket is the head for both lists.  Sockets created
> 	 * for connection requests are placed in the pending list until they
> 	 * are connected, at which point they are put in the accept queue list
>-	 * so they can be accepted in accept().  If accept() cannot accept the
>-	 * connection, it is marked as rejected so the cleanup function knows
>-	 * to clean up the socket.
>+	 * so they can be accepted in accept().
> 	 */
> 	struct list_head pending_links;
> 	struct list_head accept_queue;
>-	bool rejected;
> 	struct delayed_work connect_work;
> 	struct delayed_work pending_work;
> 	struct delayed_work close_work;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ff507761f472..b59890bbd217 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -38,10 +38,9 @@
>  * pending socket.  When that socket reaches the connected state, it is removed
>  * from the listener socket's pending list and enqueued in the listener
>  * socket's accept queue.  Callers of accept(2) will accept connected sockets
>- * from the listener socket's accept queue.  If the socket cannot be accepted
>- * for some reason then it is marked rejected.  Once the connection is
>- * accepted, it is owned by the user process and the responsibility for cleanup
>- * falls with that user process.
>+ * from the listener socket's accept queue. Once the connection is accepted,
>+ * it is owned by the user process and the responsibility for cleanup falls
>+ * with that user process.
>  *
>  * - It is possible that these pending sockets will never reach the connected
>  * state; in fact, we may never receive another packet after the connection
>@@ -49,9 +48,7 @@
>  * future, after some amount of time passes where a connection should have been
>  * established.  This function ensures that the socket is off all lists so it
>  * cannot be retrieved, then drops all references to the socket so it is cleaned
>- * up (sock_put() -> sk_free() -> our sk_destruct implementation).  Note this
>- * function will also cleanup rejected sockets, those that reach the connected
>- * state but leave it before they have been accepted.
>+ * up (sock_put() -> sk_free() -> our sk_destruct implementation).
>  *
>  * - Lock ordering for pending or accept queue sockets is:
>  *
>@@ -774,11 +771,10 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-	} else if (!vsk->rejected) {
>-		/* We are not on the pending list and accept() did not reject
>-		 * us, so we must have been accepted by our user process.  We
>-		 * just need to drop our references to the sockets and be on
>-		 * our way.
>+	} else {
>+		/* We are not on the pending list so we must have been accepted
>+		 * by our user process. We just need to drop our references to
>+		 * the sockets and be on our way.
> 		 */
> 		cleanup = false;
> 		goto out;
>@@ -942,7 +938,6 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->listener = NULL;
> 	INIT_LIST_HEAD(&vsk->pending_links);
> 	INIT_LIST_HEAD(&vsk->accept_queue);
>-	vsk->rejected = false;
> 	vsk->sent_request = false;
> 	vsk->ignore_connecting_rst = false;
> 	WRITE_ONCE(vsk->peer_shutdown, 0);
>@@ -1912,26 +1907,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
> 		vconnected = vsock_sk(connected);
>
>-		/* If the listener socket has received an error, then we should
>-		 * reject this socket and return.  Note that we simply mark the
>-		 * socket rejected, drop our reference, and let the cleanup
>-		 * function handle the cleanup; the fact that we found it in
>-		 * the listener's accept queue guarantees that the cleanup
>-		 * function hasn't run yet.
>-		 */
>-		if (err) {
>-			vconnected->rejected = true;
>-		} else {
>-			newsock->state = SS_CONNECTED;
>-			sock_graft(connected, newsock);
>+		newsock->state = SS_CONNECTED;
>+		sock_graft(connected, newsock);
>
>-			set_bit(SOCK_CUSTOM_SOCKOPT,
>-				&connected->sk_socket->flags);
>+		set_bit(SOCK_CUSTOM_SOCKOPT,
>+			&connected->sk_socket->flags);
>
>-			if (vsock_msgzerocopy_allow(vconnected->transport))
>-				set_bit(SOCK_SUPPORT_ZC,
>-					&connected->sk_socket->flags);
>-		}
>+		if (vsock_msgzerocopy_allow(vconnected->transport))
>+			set_bit(SOCK_SUPPORT_ZC,
>+				&connected->sk_socket->flags);
>
> 		release_sock(connected);
> 		sock_put(connected);
>-- 
>2.53.0
>

