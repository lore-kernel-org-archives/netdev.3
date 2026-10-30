Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362196;
	b=ACUUP0rQVs6wq3b/gBG95/kGKNX8v9zAi9rYFCOG9CpSfDihuNCn0sbQn0+50VqCsxHu
	 dE1xrApkKWctBriU6Ewl51nMmx9kJr0vRzh7IgkQL8xXJCLsWAA6toi3B1pWRS3OCCFCK
	 yQIgPCVGKq2Z5orTQ7rcbMsMN2boDufYt5Xn3daWLVDWaMbDi800AD66lLi19FxrBtKpD
	 npu0lEekR6jfsVLZS/amDOLiBZc1SYGIRTjYbK/Bbnh2IV5Q5rownlwpvjn+dfHJY4Bk3
	 dW1nwSIPa8NE18Ze6kYLQRstTT2qudBZIPhieKeO7sXN5IOSUvqQ/mpNHGE06F3Aqxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362196;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
	b=At2vA4QOD90JIUCoZ+jayavhDDSw/dJF0lPUnhmOYHROk6k4BPOuVi+hBB0n6IRG2HhS
	 Iyf1DoS0JSzBcCW0KpNUmVJ8uaJLz84I/Af+CAPGF0PeJS/bFz8iB2oUbQViXVaPtrvpD
	 ylOtOPfidhQWxUlych5ooDK9cUjBD0NrIP1D72JdUC6PTm5IrS3QmPi7gfotD5P5wZ1lb
	 LbARJx/2ErIXQqKIqW3wHE9vmvWQbLXP9shwOiIV4S9iTFoFjGrogUi4uggFvLeJrP77I
	 m/uJD7JZESvwYsbFH49mUL5xGTRQ1sOr/jeBoK1sT71MwWTLwn/jCxt7xETS4faNenw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VkPpGI5Y;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=btKxDoL3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9C606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C9C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VkPpGI5Y;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=btKxDoL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793362193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
	b=VkPpGI5YLusMynXLLODRqddWkbmOjtDJvTCEG7a8HIwqP3DQRw9LcGGJHv2YOYppc0BT9z
	7ncJKN7X6IWCDIgYONJDyyeHNJdw+xD8COLyY5V0lu4fMtQVPO6cz0QjYbk5Xz33QXZyJm
	IBNZqHyW1W9So4xKcnfP3jiAp6FUvEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-NDdBwtAXOWWAjnastZd8BA-1; Fri, 30 Oct 2026 08:09:52 -0400
X-MC-Unique: NDdBwtAXOWWAjnastZd8BA-1
X-Mimecast-MFC-AGG-ID: NDdBwtAXOWWAjnastZd8BA_1793362191
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so5881535e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793362191; x=1793966991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
        b=btKxDoL3d9ODnAsVLbkTV6f/9SYd54SrOrF1/xXSp25TaA9ZWhcjwjZSRsW1A5ckhW
         zhrBjJpLOl30HHyx7wze1VjvU8RxxQ6mh7jRDYkwQwlooRp46PhgxM8JuIsilmVabW9f
         D3+g3VTI3YiPF3lDjoNlxk1amcS6pnBC8IcBlwqi6gXh4uGXv5Jkm09LbqbDa5Ih6IAp
         aBpibP1l+NfW9OaNF23sfkW65ry6RjJsngStBHzByIo4IN3+f8slPaM6OmI4QVw9/I2G
         Vd7Yb1zLXcbOY4WErusHcAUIzC2Ivls5jyh8vG89XM8a3a1iEzixclCPontDridybVw+
         OJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362191; x=1793966991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdnZT0z7davEfnf6scqYwmgfFD2zK/8ZHhv4LP8xp6I=;
        b=lUEYn3akV5e16fF2mkLIwGrbqvzvsrJAWFM7pXviJNzgr7FFvC5epfD7BNhDSuP9C3
         3ltxZi+hu7xn037p7shM43ES9l2XqsCOUjRappmLcJcPzxAP8c1VnsRC0ZLEx6hcVwfm
         cmkc6ZexenTfrAFEz/BY3dM0EEbHdt20EHAhD34Tf4P4VfbDUEAh2Z0rBNYgOymaeFuR
         PVJciHOKveKDLg4zBpXm4OUFTsl3pVSGvch6H0tocsm9O4i4NNNciwBZPb7RyedbDxqt
         7ZeelsaEbHdLN0kUExjT48nsXYWBCdxMpXF7vrhvrUuqRSjyjobRDG8PklRLFLTmdWp7
         Hk+w==
X-Forwarded-Encrypted: i=1; AKwUvBwDhst8zyqeI7vFyWGyMQqqEjlDGRGAfykXBj0JrJ0+VnujWKDTtI9yXpaUY+cTUpetlNLA6cc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZbo49jWVQFqbZDZTsAM+Cj/nAWsGk8rDO37xXTpAL+v7By8ii
	iuyZPohkpzof/kG0vkRfj0RtgQpc4V/zZn6Lyg/5LSkZlAdZUb5nmle9fGxnIR+dQ3oZCrRD4ls
	eKUtFEBCUFmNRkqK5ZenfP/d5kj+oapomJ/mk9w4o3I/yC6usDqfl87gCzA==
X-Gm-Gg: AYBFou0hoNG7I0Bojxi1tR7ILyznS0m5NxwfOxRe/h+g+YsTu2GekgZ8AQTPWlssNAL
	DH1wiOwkC00CzNPVq5ROo5BpRBTkzLTEyWOKZKxzq/+Hv3Fp9R2VDjxmBllrz7Mm3WGJOmE4mls
	Rkewqwujo4Q54+pZcs7o/3fXrVSJ2TBq670SJKz3CpsXPGv2qcMkccVWL8HEdvw+cvlIoetNrK6
	CgNgZ4Vf65/j1c7hCN4Wi9Dwd1GtLjMuPDMPG++vbooMyDDtse2U/iyf8loOtfQf+B5ZkELqyZh
	VAYOO8tT6TcCdARrCQlYHCi/P+S2NkShPPXQWrMom4dti98lTShG3Ts8dWkYRC72lKDrGp9qtXU
	jloFUhjLxwXtTNhQyYxokR1iuQ7U2THbdP2HgF8NWulnUUPFU9ikKoGsKTRUTBCSGOOhgjq1JZ/
	9tdYuiJINBky6Gz6Y=
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr47054035e9.6.1793362191520;
        Fri, 30 Oct 2026 05:09:51 -0700 (PDT)
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr47053415e9.6.1793362191072;
        Fri, 30 Oct 2026 05:09:51 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm54507825e9.8.2026.10.30.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:09:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:09:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: phind.uet@gmail.com
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
Message-ID: <auSIGIZctLp1oOhf@sgarzare-redhat>
References: <20261030064428.73930-1-phind.uet@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261030064428.73930-1-phind.uet@gmail.com>

On Fri, Oct 30, 2026 at 02:43:50PM +0800, phind.uet@gmail.com wrote:
>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
>The timeval validation checks tv_usec < USEC_PER_SEC but not
>tv_usec >= 0, so a negative tv_usec makes the timeout computation
>wrap into a bogus value, later tripping "schedule_timeout: wrong
>timeout value" instead of being rejected.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>

This blank line shouldn't be there, maybe it can be fixed when the net 
maintainers apply this patch, so please wait their comments before 
sending a v2.

>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d0508887a2fb..1d7d53542724 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2156,7 +2156,8 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 					     optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
> 		if (err)
> 			break;
>-		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
>+		if (tv.tv_sec >= 0 && tv.tv_usec >= 0 &&
>+		    tv.tv_usec < USEC_PER_SEC &&
> 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
> 			vsk->connect_timeout = tv.tv_sec * HZ +
> 				DIV_ROUND_UP((unsigned long)tv.tv_usec, (USEC_PER_SEC / HZ));
>-- 
>2.43.0
>

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


