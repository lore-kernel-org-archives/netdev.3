Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03038737A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242648; cv=none; b=ZN38j5ZMrpe3rob5CHGcefM1OzapZjZyNTh54reHHp6BasJn9j8nvlYWfD387h7PJTjrvEUTM5t/ppGpTnMTDYHFJBCoSluoeQtxMsJth9m1+to0mAeExR3n9wVdREo9GbV1scXeTlSzxYcdYtLrvnx+H3I3gnL+91tzBjpuN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242648; c=relaxed/simple;
	bh=SCZFziJfhM3sSH+v1I0VJWjE3vDVKuxV54ibY41MNXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJBpZb2ZPmm/wetagPKVwzC0cHL0Pr9X/qFRqveYKLUvi8qe0Zoz9z0LJ6LkRsQYJPoaWbNyBMeofPIk20X/GpZ4U/qiS4kMhsORmJmNVNuFOag0ASlmgmn32cW0efcyKH4GmTtk6cX/BMURA6joAtBIi6G/BTp5A0B+qZ+fIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3cvdyl2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYHQh6LR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3cvdyl2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYHQh6LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776242646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Jlpf/eQTRkL8uF/L9yIIh+DW6QLr+31vOBk1rhLbAc=;
	b=W3cvdyl2+trgFehc204GrTCa4uO2dHhuPy4LCgehJFIEwjUQFB+9kO2pJOUkmeEmlq+b+B
	PymhPMI55p7rYHd2u4a6f0cQ4My6iXVkl+NUMg6IuN4tO7VFiXvrNOeBsSkaGMkP9DPQba
	y+n/8DLbMkJ6cBGuJaOO+QbwW3g4NCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-JqODauZmMWuteMjbGxZihA-1; Wed, 15 Apr 2026 04:44:04 -0400
X-MC-Unique: JqODauZmMWuteMjbGxZihA-1
X-Mimecast-MFC-AGG-ID: JqODauZmMWuteMjbGxZihA_1776242644
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso1989578f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776242643; x=1776847443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jlpf/eQTRkL8uF/L9yIIh+DW6QLr+31vOBk1rhLbAc=;
        b=TYHQh6LRvmiPnyN98QPMyWspwiOP4BIr/kZFg++0KfiXpKbnmP3mDADxycxAKdJGQx
         EQnKMf1FIYqbTUgr3CEQ/SYpN6F7IBgBL30cUGuPwIVWP+kdpqjcdTo+I5WL3ys2vm0F
         iDl0MQzoT4KSIDz4ItYLc97CHgv/EQSuWxUcjKmG6+V7TrKzxjvEkXw3orWDOI9EeI84
         w0hh6UbX44C0+ZmMQWjNG7vkXUXAIZaiDv/DdLv4oeQNfKk3j44BAD0wrABEJ2fBJaVt
         4QOcAADIGLmPqfY1BOvn5iuwVavIPeFdTjp6MCM93SvrBwPExmJLvhbwVqzN2hktTpCk
         Q0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242643; x=1776847443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jlpf/eQTRkL8uF/L9yIIh+DW6QLr+31vOBk1rhLbAc=;
        b=OKW7uFenP/NjDfzJIvJ9UsFSXYgsc5yoxEOtLWUFvQOwMVCXxWFpNUAjGNv6Y5321D
         RcpknTYKuax1iaCNT0Z1iE7DhRsCk4OvjJP0PYk44U7H5hHIyKB2D2Xz6LUQndau2KIc
         ltVbWf+Gp58Va5BvPQPEqLABP7TiRkIJ65j1qfJafJ+JTI5wM0uub5vMLZLVnRPw9nSU
         kLVjvdSI/fAwkppGXbYP+QIq6lEEKw7t5MowojRat1meOoDjJsxQgwPisyX4pd7PJL6U
         gzCAfNTH7xAaRZFzx/hPh2TaSgKeS0oDUJwKa8KlPaql6PtV7KajnjfDERomeCkwVpvp
         Y/JA==
X-Gm-Message-State: AOJu0Yx6k9ugQ05z8XNcYi/jimbenuRdCM+cAro621Sk8RlitMuiBjxj
	7ZpPkCQIH+8xaUkjA0hRV6H30RmrU3s3rdE5VoygrE5rZ6VL/UX43Oj9UMFg6cqq9nyHdgAa5ub
	npbZQ/iujnBsqiDtlBE5obC6p1KWT0lA3r6oqlJEmQNgiFQYKS6Q0jtFaGw==
X-Gm-Gg: AeBDieteH3Qfa9For8AkO7DJuHoawIVmG793bPtoObbUpIl9DlnzElvJQY1OpLpJTPB
	d6F9j1xj5hjOVmEtYdhg/lSehTguepJtFAWFDnI9Feo8nwX6dRQLZfjF7LoWo4fDCsRJr6Yn/tQ
	QKT+ap1eHcnUJ8cjtPZtfabeV7/mLeeN+aK9eU4WhON5tkx2raPtw+8Fe6URrJfNJ/8zwK+I1R/
	+6Xrb2+YZnSBSG+np96u4EnDM/vjmKl7l1FJ+4IWRQc+Xt14U3DXDArKjgpoUm6Ez8PGRg5QRUX
	aZcm5l5nclxtA1PthOcN7UjJUL4nRN9L36V+EZKfb++cFEBGpng57miN3QTaZEOz3BdGyC6krFv
	Y3lioutfOAxIGf/v/1pWuOdD/tNA=
X-Received: by 2002:a05:6000:1847:b0:43b:4f0c:aefd with SMTP id ffacd0b85a97d-43d642b9e05mr29433827f8f.23.1776242643510;
        Wed, 15 Apr 2026 01:44:03 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:43b:4f0c:aefd with SMTP id ffacd0b85a97d-43d642b9e05mr29433775f8f.23.1776242643031;
        Wed, 15 Apr 2026 01:44:03 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d670sm3463681f8f.2.2026.04.15.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:44:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:44:00 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, sgarzare@redhat.com, 
	mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2] vsock/virtio: fix accept queue count leak on
 transport mismatch
Message-ID: <ad9MG6fN6z3fdHu1@leonardi-redhat>
References: <20260413131409.19022-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413131409.19022-1-phx0fer@gmail.com>

On Mon, Apr 13, 2026 at 09:14:09PM +0800, Dudu Lu wrote:
>virtio_transport_recv_listen() calls sk_acceptq_added() before
>vsock_assign_transport(). If vsock_assign_transport() fails or
>selects a different transport, the error path returns without
>calling sk_acceptq_removed(), permanently incrementing
>sk_ack_backlog.
>
>After approximately backlog+1 such failures, sk_acceptq_is_full()
>returns true, causing the listener to reject all new connections.
>
>Fix by moving sk_acceptq_added() to after the transport validation,
>matching the pattern used by vmci_transport and hyperv_transport.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>---

You forgot to add the `net` tag to the patch.

Other than that, the code LGTM and testing passed.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

> net/vmw_vsock/virtio_transport_common.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8a9fb23c6e85..e01d983488e5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1560,8 +1560,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return -ENOMEM;
> 	}
>
>-	sk_acceptq_added(sk);
>-
> 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
>
> 	child->sk_state = TCP_ESTABLISHED;
>@@ -1583,6 +1581,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return ret;
> 	}
>
>+	sk_acceptq_added(sk);
> 	if (virtio_transport_space_update(child, skb))
> 		child->sk_write_space(child);
>
>-- 
>2.39.3 (Apple Git-145)
>

