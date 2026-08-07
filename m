Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E648876E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108448; cv=none; b=IR1iW4w6rZWX8slIBhexYb7GBGbapBcsZpQi/dXM4LfIqiHBXoK+Bj5gQ0Y8BQW6mWOHaJqYvhW1MiNR5p3aCgJC+C8Ezq1sVd4rsUlwyBAlzXOVvHAk9g8YiGWEj11LCMQIbExyGH+W/yO/9MeN1XL6oTtEkRLqCgiHH1q+pmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108448; c=relaxed/simple;
	bh=WzpJDU9FbKqDMi0AmEFKjRX4c4fT3hvj8KwBS7N71qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP8u0diaoyxNShZhU+L5Om1GTj3jCXbbKw1T2Ty6lJjcTWdD8dZaOPiN0lZhuU31QJzZIGTnDHjwThHDxYSiqMc+qSq5NEBpFSjTKAIZI6AZQbpK4Y5bMJ0Q0n9VQmlUubpZXjEgXx2aoTp1PUnGzW+086NUqa3fWjZymyc83FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz6sokr6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcrtSkgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz6sokr6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcrtSkgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786108435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUbzS3I8i6QFWa+8ZY5NS44GUz1hHJ0wwcZwZwY6pas=;
	b=Fz6sokr66RBLUXoK2qS2z3V4nqnQpJX+CNbPwYMQPNzOWB9DfaH3dJmhwKFPmu6i7MDyPb
	cFKrJn/z2ab/4b34tRT72+XEuX6QW2dhwTGAv+4jwrzY85X+MNkgKvPgwasNez54PuoMwS
	zPu01FgatN0OY3dLDeRUxO9DGwdpq/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-qluetRWSM3qK0NC1eKvFyg-1; Fri, 07 Aug 2026 09:13:54 -0400
X-MC-Unique: qluetRWSM3qK0NC1eKvFyg-1
X-Mimecast-MFC-AGG-ID: qluetRWSM3qK0NC1eKvFyg_1786108433
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954fd771baso12710695e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786108433; x=1786713233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xUbzS3I8i6QFWa+8ZY5NS44GUz1hHJ0wwcZwZwY6pas=;
        b=TcrtSkgA2/TbopghyqJFH7c8SU32SypS43+27g7ErkWyX/tMNhf9r0PaBp1rLQF0Yf
         upI4T4tAdWp9sjxCQoMmmsGkFkiZpUjycldNbFWnFF4CiOYSUd8QKZCQ8CBtwk87thg5
         IBEoEmIpZ+/4uRsWhXyaK79/zZP67tXS+n20GqmZNRl+FliU29fMX3xQWrPviUbzJt2h
         6M5kC89z+nf6KykQhgH1dNjrc24DB82NKJy0CQBR33hWftCnZrjFtAq4rRfs32Y7zKIW
         xZ8LudmDL3DjufPDkzPmjg/wR/I6BeqdMP5YL0r5jILbonGgMwf8tdtNiyl1wqE9Kt/i
         tVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108433; x=1786713233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUbzS3I8i6QFWa+8ZY5NS44GUz1hHJ0wwcZwZwY6pas=;
        b=JD6NW1eYquDHW4fPYzy0jaNiNpN/yp5TTj7Caujs13UgNBRr+2mUUtrz4s1fB7/2dP
         FseS3vRes7V8KdRLvurvH5E+VbYJJu2s2E2OEjpMbRqRJmcgUx0WcTlp2Mgmn3CDqU1c
         WuhY9hqbI7PXBgqsyWE73df1LP492w/Vkt+Lk19Q++3aaVv1W9fTJrvu9qAZIfE8fcTO
         zrR6X2sjpmmN58j8WMNI0OtI0n+2vH7nBtrGBCAKjBgtDq+2ZXG/KBueEIVkTwa4nIJq
         qcO08eKN1Ng/Qoi8mxT+WUK3DCZvLjBP7n4LxCQAXBbY7643bIDVBWoF/Qf0Ok7xowaQ
         G4dg==
X-Forwarded-Encrypted: i=1; AHgh+RpN0fw8Gavn+QHnUKqS0Eseze4RhsyNW7C9sE9bu8tE/IHwZ19qwjDBLROaFWEsqH3rc+LA8yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KC15phkVXf8+Tewef9P8mphFzkY/bOONJw4mJK5cwDp8yfGa
	XndHDf6M+76siL37rBQVAwWuEiTQq5dH+zwzTD2uQ/pSfs3Wls+Zh7M4Prpk1Oym72hA21W52Re
	PL2MXgQG5UtfhnaLpPdjxQEit5IBPbPSuZLN/QzEKgN+4qatOFXDhUEe65w==
X-Gm-Gg: AR+sD10DxjkuPvXv7qBNq+TJkKClEq8kEXb8gTEOSt3/7mefTr32NxU9yUYU3bFNFL9
	DnJbRn9CDmrC0teljuAcMZnz9NPyB9f1NIG0E1EQ8/cD0VXm2FADjAI/gSOys8rMMBkhF1hZXWG
	9NQrlIQxQ3JH2VKRDHm090H+4cyu1vcaz+PGQb+FAWCeD3MZyPqu8GWCjrBAGfENhV3aDfx0pcX
	XIAllFlAC1nMzugqS8He4kbo5yw+Puz5+sBTVkqeon5OD7PFzSHhf6LiDXeqL3HR13JYSnmUagW
	3Wh455SJnpDNB4Tf8GKlOleijt5Ioh5uMq2ANIsUfhJW86ub81BgwJMK9wf9rkWOfBFwLIn94mA
	JXQ==
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr145495135e9.8.1786108432776;
        Fri, 07 Aug 2026 06:13:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a48:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-499553f4c4cmr145494565e9.8.1786108432334;
        Fri, 07 Aug 2026 06:13:52 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.96.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdca3ddsm51398005e9.1.2026.08.07.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:13:51 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:13:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>, 
	phind.uet@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, 
	Asias He <asias@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock: fix memory leak of rejected child sockets in
 vsock_accept()
Message-ID: <anXZQSE4Bh8ilEHo@sgarzare-redhat>
References: <20260807114804.320862-1-nagachaithanya9911@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260807114804.320862-1-nagachaithanya9911@gmail.com>

On Fri, Aug 07, 2026 at 11:48:04AM +0000, Chaithanya Lagisetty wrote:
>When a listener socket carries an error (e.g. sk_err set by a connect()
>issued on the socket before listen()), vsock_accept() dequeues the child
>from the accept queue but rejects it. Previously it only marked the child
>as rejected and relied on vsock_pending_work() to clean it up. However,
>rejected child sockets created through virtio_transport and vsock_loopback
>never reach that cleanup path, causing the child socket, along with its
>LSM blob and transport-specific state, to leak permanently.
>
>Fix this by releasing the child's references directly in vsock_accept()
>on the reject path: remove it from the connected table and drop the
>references taken by sk_alloc(), __vsock_insert_connected() and
>vsock_enqueue_accept(), so the socket reaches vsock_sk_destruct() and is
>freed. The now-unused 'rejected' flag and its handling in
>vsock_pending_work() are removed.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: syzbot+53515d23498d641e21ea@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=53515d23498d641e21ea
>Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
>---
> include/net/af_vsock.h   |  4 +---
> net/vmw_vsock/af_vsock.c | 38 ++++++++++++++++++++------------------
> 2 files changed, 21 insertions(+), 21 deletions(-)

Thanks for this, this is something similar of what I suggested some days 
ago to Phi in 
https://lore.kernel.org/netdev/anLuRE4ix5-BZ7-t@sgarzare-redhat/

Phi's work also includes more cleanups, so let's avoid duplicated work.

Please test Phi's v5 series that should include something similar, plus 
other stuff that should fix exaclty the same report.

Stefano

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 30046a3c20f7..b70cea7f754f 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -53,12 +53,10 @@ struct vsock_sock {
> 	 * for connection requests are placed in the pending list until they
> 	 * are connected, at which point they are put in the accept queue list
> 	 * so they can be accepted in accept().  If accept() cannot accept the
>-	 * connection, it is marked as rejected so the cleanup function knows
>-	 * to clean up the socket.
>+	 * connection, the child is cleaned up directly in vsock_accept().
> 	 */
> 	struct list_head pending_links;
> 	struct list_head accept_queue;
>-	bool rejected;
> 	struct delayed_work connect_work;
> 	struct delayed_work pending_work;
> 	struct delayed_work close_work;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..2084c88ac836 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -39,9 +39,9 @@
>  * from the listener socket's pending list and enqueued in the listener
>  * socket's accept queue.  Callers of accept(2) will accept connected sockets
>  * from the listener socket's accept queue.  If the socket cannot be accepted
>- * for some reason then it is marked rejected.  Once the connection is
>- * accepted, it is owned by the user process and the responsibility for cleanup
>- * falls with that user process.
>+ * for some reason then it is cleaned up directly in vsock_accept().  Once the
>+ * connection is accepted, it is owned by the user process and the
>+ * responsibility for cleanup falls with that user process.
>  *
>  * - It is possible that these pending sockets will never reach the connected
>  * state; in fact, we may never receive another packet after the connection
>@@ -49,9 +49,7 @@
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
>@@ -774,11 +772,11 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-	} else if (!vsk->rejected) {
>-		/* We are not on the pending list and accept() did not reject
>-		 * us, so we must have been accepted by our user process.  We
>-		 * just need to drop our references to the sockets and be on
>-		 * our way.
>+	} else {
>+		/* We are not on the pending list, so we must have been accepted
>+		 * by our user process (rejected sockets are cleaned up directly
>+		 * in vsock_accept()).  We just need to drop our references to
>+		 * the sockets and be on our way.
> 		 */
> 		cleanup = false;
> 		goto out;
>@@ -942,7 +940,6 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->listener = NULL;
> 	INIT_LIST_HEAD(&vsk->pending_links);
> 	INIT_LIST_HEAD(&vsk->accept_queue);
>-	vsk->rejected = false;
> 	vsk->sent_request = false;
> 	vsk->ignore_connecting_rst = false;
> 	WRITE_ONCE(vsk->peer_shutdown, 0);
>@@ -1919,14 +1916,19 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		vconnected = vsock_sk(connected);
>
> 		/* If the listener socket has received an error, then we should
>-		 * reject this socket and return.  Note that we simply mark the
>-		 * socket rejected, drop our reference, and let the cleanup
>-		 * function handle the cleanup; the fact that we found it in
>-		 * the listener's accept queue guarantees that the cleanup
>-		 * function hasn't run yet.
>+		 * reject this socket and return.  The child was found on the
>+		 * listener's accept queue, so it still holds the references
>+		 * taken by sk_alloc(), __vsock_insert_connected() and
>+		 * vsock_enqueue_accept().  Drop them here so the socket is
>+		 * destroyed.  We cannot defer this to vsock_pending_work():
>+		 * rejected child sockets created through virtio_transport and
>+		 * vsock_loopback are not cleaned up by that worker, so the
>+		 * child would otherwise leak permanently.
> 		 */
> 		if (err) {
>-			vconnected->rejected = true;
>+			vsock_remove_connected(vconnected);
>+			connected->sk_state = TCP_CLOSE;
>+			sock_put(connected);
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>-- 
>2.43.0
>

