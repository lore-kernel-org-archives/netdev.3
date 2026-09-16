Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFB4EC673
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561850; cv=none; b=ONCSZGQaPh5fU2vtst4vgwSg4+kuwQPyCXXiRShYSfvsepjO0R6lS6+V8XZas2Kb+843wpG5DUc9ln4btFMRxIJXLFfq790J95Md9KDD0JILPLErryTJgPaIep9/WLgOuyFaHg/VaBbswFeFHFqTsg2hnMEjVsK3oxGKtBUGhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561850; c=relaxed/simple;
	bh=FrcWMoDVbMbpzp4CIH1n1Jf3KfV7MxTjfsHaS9A0FCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzq32oeCzPtkhTtbIK7PsllIj2IqtFC16SvVFeD1G9a+EfzBxt/S/IHJNOuPMv87JK9VV+Wfac1wMfzzb1U3Thnd886aVQBcPwvP67aDf57uwXbg9YWgowfFzTO8W8iz1rM3sTpVvgqT54qbfe3giyDm4D9rjbER0pyGKR+UjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH8sI7q8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAWmEGsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH8sI7q8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAWmEGsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
	b=GH8sI7q8u3uXlnWzND6MTU+GX3dpATMJ16Einyab2uHbiMpC1f/vlwGZAuuga5SylKCOXr
	Q0qReBxRQNggTcIk7SuonRHNMuaL+IQzNvQneX1L6VZOH0Eqg1ThtXmVmntxSk4F4FjSE/
	wxazINgjaWGHdo2v+mJ8XnPCgG2jrJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-9sqcCBDZMI6nvbrXVNUgjQ-1; Wed, 16 Sep 2026 08:30:45 -0400
X-MC-Unique: 9sqcCBDZMI6nvbrXVNUgjQ-1
X-Mimecast-MFC-AGG-ID: 9sqcCBDZMI6nvbrXVNUgjQ_1789561844
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso30675715e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561844; x=1790166644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
        b=XAWmEGsMHw35Ajbokq2rmA08Ye2RzOdlWs1wrp2KWaobTHRosLAizxaEU1QtEgTll3
         IXKvXHL9eZ426KSEI3YaDhH2NXCxT9JlH+3tv2vQqVUv54hzGm2gtMo9w+ThT4ivQyLh
         LkXT99FovFTqb5uGpOM53UirHN1djK7HvN+mtqf/EhT6dtpd0PQ86TPfPcWMSEdWBS2n
         FbJ0Rw8gqME96qAH8E2NVzUhOd9Dsnn7J/QldkzED48MgI5tXEK4E7Kj+aKj8ICcniRP
         dtmCP2i8dyNdVZ5ugB2/3FAVU5KbwuvGQ2uMgTbvJMTf7w+9MLmVGoArq2eels6mBr/R
         z8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561844; x=1790166644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/lsJ0PSjJUTTQP4j3h3/faX0ng/XvkH6X4rWSQ3RUA=;
        b=ZHQsh93vi+yBzJJWiZ4reUIsA3RNgEnUSO/IMsdWvIjq6nPMN71yEua/DIvalOPuWj
         iI5OHirDLIaR6ml4Ls5kuaktfZCedBkFtAcCtG7Pic3xNVqkipKC/20f4fhma4Ij/xD5
         6e2hxtIJUi8O7awhUHR0F+SauUq1fGY+Kksw+Ck5sO8R5yOLgxYH9p/9tF7aN6WAeDet
         tJiwYt/7Y9KBzFKbFMivYqBFD7LuSyLgXZgeblXuDaZ07OboVtoYHpXzVbkkLLZpgImk
         u9EIe029s8+VtUEZWf4B2TSRyjYccddjXqpZgwgwp3Aln0B//kODiDVnM5zmizcip/lB
         p0Kw==
X-Forwarded-Encrypted: i=1; AKwUvBx+yI3eBYF2We0mGRqs6mT+7Uj8chnNC7qqYPNR2PlbARgVvBzByUdHuFzTvQLwMwUfmpHFVb8=@vger.kernel.org
X-Gm-Message-State: AFuF++lYsJcZgGEMLPyKuKxQD/GSPuyZKlDQkncJoOB5gy7cxr7hl8gP
	hl0+aj564s2fkYQvjDMs38zBQvip2rc+1YJKDQQia/rYy3KKWbcX77E0fQx/YUowooZlfmJ1ACK
	3noXGKVO+nu9PWCx2KaYyeOE8E2cRPuPL1YxDSIdBwgnUmgJFj6IizFrhJA==
X-Gm-Gg: AYBFou2+D1xpu30bkgA86/CMUM21gPYxFJaKshyiHoCxNyW95E/IlWAv9ddpqzOVb2J
	AREnXj/sxz32BTX4nh4c8RVhgwxrDw/CTS4r2RpZED2AvTsGP9BUv7Ygr/5EtP2T513gUA1Gv/s
	fuLu2jLqWpaV4okq4x6sfzX1kgwS9zBb69a89+rt1eUR1pS2JHJQbCX/NTsyFXfvzYQRS9hjaOE
	PTdzXgAgqXVRRrOBijzV39RNcIBiNwDL4c2YDIbM9S7/ewCW+D2W/gQ3QIZbgVw0PXs5hfPQjZ5
	Ju+kzfxkI3GMmXxC7BysuPj4uhCnTIzvxn3N4WrDJEDW1sa1U1wCigq3tvLorDt+ufaivOP8B1w
	9DMfnsUa5G0qNh0me+vEM3MISAKx2i0qPAHI6xM9g5M4dZQ==
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25967105e9.5.1789561843688;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49eac463955mr25966565e9.5.1789561843075;
        Wed, 16 Sep 2026 05:30:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83addf36sm76621175e9.5.2026.09.16.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <aqp7CV9DnfsG1GJc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>A non-blocking connect() running in parallel with a blocking connect(),
>combined with a racy listen() that hits right after a connect timeout:
>TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>in progress.
>
>Enforce the invariant. Prevent a socket from becoming a listener after
>acquiring a transport.

We should improve this comment; it's not entirely clear to me, TBH.

>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f840498b58af..499e902becfa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
> 		goto out;
> 	}
>
>-	if (sock->state != SS_UNCONNECTED) {
>+	vsk = vsock_sk(sk);
>+
>+	if (sock->state != SS_UNCONNECTED || vsk->transport) {

Are we changing the behavior when an error occurs?

If we call `connect()` on a socket (with no others running in parallel), 
it fails, and then when we call `listen()`, it now fails, whereas before 
it didn't. Can this happen? Is that what we want?

If so, we should mention it at least in the commit description; if not, 
perhaps we should unassign the transport in the `connect` call.

Thanks,
Stefano

> 		err = -EINVAL;
> 		goto out;
> 	}
>
>-	vsk = vsock_sk(sk);
>-
> 	if (!vsock_addr_bound(&vsk->local_addr)) {
> 		err = -EINVAL;
> 		goto out;
>
>-- 
>2.55.0
>

