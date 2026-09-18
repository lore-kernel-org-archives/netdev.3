Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224FC349CD1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737475; cv=none; b=owSSernW8ftkPnI/rEi+RWRbc5hWa5uAOWh+Z6wvTQ3pFLN3Ych+xqvri9Uvk04gg35ssBWETWDblmIjMooHzz7fMef7dt3rB9Pui+Wf1/gfA7fhLROqwImeexk++m2M05XBnBU/IcUyNmMABClw7OX0AmkJNZF47s9g78WcAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737475; c=relaxed/simple;
	bh=kN5BYIsmhqVkXYrS9tG2zrKZRLqVYGZ8zSUbwhKf4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJyTdhvfrR8gOJ96EpUofe5mF2ebbu22mJnKNTtNLUTrUn6B13/6aGfdwmA5N+ewTI0c3ytN2PaIaT17yDvz1XqsG6QD0mtOUOXvi1Q5JIxJ/tMCnE/79AYMT8lakySnN4ig+SGJHhOx8arz8JvVG88pTzLg9+ChUxpgXw84Lvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgjtVCBO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3mkCakR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgjtVCBO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3mkCakR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789737467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
	b=LgjtVCBO7vRayPQqqOt+14/fn85RtozhMM/L2gyMOBMtmPvPDGhQsofT1UIv+nEwAZdF/2
	DflTg/YZ0Lmd5LWagtttr9e306FnQrmqbvnZ19MA2t4qEO/T80KFF+kkjrRThIv+M/MDWc
	rJZJXChWJs1OfUEYTOM1uXhcG8+Q+kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Lo2QdWtwMn650fiTvIErdQ-1; Fri, 18 Sep 2026 09:17:40 -0400
X-MC-Unique: Lo2QdWtwMn650fiTvIErdQ-1
X-Mimecast-MFC-AGG-ID: Lo2QdWtwMn650fiTvIErdQ_1789737459
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e735659b7so5769415e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789737459; x=1790342259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
        b=V3mkCakROQjZhk5iskwk3U86uF0A9Jhc3p3EF9nbcE0r9TEQ7hIGbgiqhSbJTy2XKj
         1VHe36U7uEjvQrE0IqXjB5jmCXsZuZ9ZTcDqFapYzboUOZnQmw/RrQeFZbz1DKLJg/Wi
         ICR7z8ljoF2aqG2YZeecKHX0/d01j+JtaFlitadSWv37Ir7grHMLZ0Dz4fqE0Ax64jWY
         aksHCuUan/y18PIbUMS12fQS8O17DLfbUpjTnhEHfShbxqCyqGs8/8x6kAgWc7jsXQNH
         c+cvehETLDvSuH8ObJj5xMAZ3JpcfADZR+iv1fTtmNp05VtZbO80K6iRjRbEZt2juSw5
         veiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737459; x=1790342259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nkVFW+VrXNXfe1YNrYXwQ6v387x1mrai9WsSFx3ezhw=;
        b=I/eUiwsO0/OvdqB27ZG/6dzRSoTwpzoZVX6sHkaFOqEeHjqcgeV2UxMyCcW2j0Jjes
         +XhyVeUUinZwGnAVwphgcCVcX1w96AhUPRBjSeS+sMM3oYQ8zD9hemaUoiF1fhjpyL2g
         PIRV32mfwJ//93/toXc8/zZSxJOKu15JVHs03+V4IfotpQYMpoNlTYppF13NnHIJUiJT
         mZVmnr/G0ZajAHqGtY2sc6Dds2ILUzIdWLoSfGAZwicShms02ELSatNE2E3f5/Tg6ndb
         Oer593mba00UPdaFtme/FlH6FENHMU92WlHMy8DKYT72wvEZFJN5+l61A6ikcTf+sS/p
         ntxw==
X-Forwarded-Encrypted: i=1; AKwUvBy/LGkXfgmGq23Jvh7zriMOdgemdpz+dAoMlH7uMSEWdHgIac1lAQ23PumnImIw4sL+104qu98=@vger.kernel.org
X-Gm-Message-State: AFuF++mHXoUJyLCC3EaoP87dOg2qxfpkAQGkZWSCidEN/8nJoK1vs4cK
	svANmFTSvuYpV+hG58XaKjH4rk3LUfCAAc1uWDb4yBXYM9af2+hOOsyeBVSWnSq/iK6U3mkdEh/
	A9Ow822JeCXbrrHbBCe6I445DEGuviWF1WB0icwZlY5r627ScuL6f5yPj8Q==
X-Gm-Gg: AYBFou1vBf7gJoWV3Y5osGEeyN3SYCy3eGueu9E/9sZZAmNxHjHRcNSzpS+4WCl/zDx
	BREfRXwwyXwbWvZnoro/rmPIEm9tpWJGTSkZPuElQ6KMIsENAs4ZvVuFSZA4qxQmnDwKZ6tJhcF
	8JiQ8dP4Uf7EmCVtW/edebWecQkDZdGadrN4gFlkzF8JHV/Am7c6dtukfyGoY8323mdiQM7zp3D
	WsjSlDXO7px40NR7rnjHkJX+TMx/5No2/fKKnk6GPT2HKOxPBXd5053VNZHCYUgKkUDAymPZEtg
	lJS4T0wmq/8fOxG+rGm1MR7+NjHIU1+ue0jYuDGlxvk/6miOICz7Tm7a2nahFzjXSbxTG1y8ehY
	xVCNvM0mUuLMr+9mVh49moUilXUEe60YdG8npb4F4u2pt0A==
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id 5b1f17b1804b1-49fc58500e5mr31289995e9.28.1789737459140;
        Fri, 18 Sep 2026 06:17:39 -0700 (PDT)
X-Received: by 2002:a05:600c:548d:b0:49e:816a:9bae with SMTP id 5b1f17b1804b1-49fc58500e5mr31289535e9.28.1789737458692;
        Fri, 18 Sep 2026 06:17:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm155058355e9.2.2026.09.18.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:17:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:17:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vsock/hv_sock: reject incoming connections when the
 listener is being released
Message-ID: <aq05eT6CP9ns6Cae@sgarzare-redhat>
References: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>

On Fri, Sep 18, 2026 at 12:01:54AM +0200, Bartłomiej Dmitruk wrote:
>hvs_open_connection() only checks sk_state == TCP_LISTEN and
>sk_acceptq_is_full() before creating a child and calling
>vsock_enqueue_accept().  __vsock_release() sets sk->sk_shutdown =
>SHUTDOWN_MASK and flushes the accept queue while leaving sk_state ==
>TCP_LISTEN, so a host channel offer that races close() of the listener
>passes both checks and enqueues a child onto the already-flushed queue.
>That child socket (and the VMBUS channel opened for it) is never accepted
>or cleaned up and leaks.
>
>The virtio transport guards exactly this case in
>virtio_transport_recv_listen(); hv_sock lacks the equivalent guard.
>hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
>race-free.
>

Fixes tag missing.

>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -324,6 +324,14 @@
>
> 	if (conn_from_host) {
> 		if (sk_acceptq_is_full(sk))
>+			goto out;
>+
>+		/* __vsock_release() may have already flushed the accept queue
>+		 * and set sk_shutdown = SHUTDOWN_MASK while leaving sk_state ==
>+		 * TCP_LISTEN.  Enqueuing a child now would leak the child socket
>+		 * and its VMBUS channel.  Mirror virtio_transport_recv_listen().
>+		 */
>+		if (sk->sk_shutdown == SHUTDOWN_MASK)
> 			goto out;

Should we do this check also if conn_from_host is false?

If it's the case, I guess we can add that check in the checks we do 
after lock_sock().

Thanks,
Stefano

>
> 		new = vsock_create_connected(sk);
>

