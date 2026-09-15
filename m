Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF047F3DA
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491054; cv=none; b=Ybo+P/ogclO4cAPSTVuBECXE25XusRMf2dY+qpVPEFXVe7IybQEG24LZI9MAWbkmyaHfn7vzNu4WJNd0f6vip8DGEuXDVpzAzht8FM/kVrgsRV2uAsj0npq8wNg3zkpcqq2O8g1/zRCrL6kIK6UxWsG8Yr5yFrIJi1fW7TWpzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491054; c=relaxed/simple;
	bh=O4R9PW4W6s+z3xFlBUuBjGuMFpMqVv3R2aRzaj5ablw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/zpH6fKSK7+bGrrdS+VeLUg7LqhM4AgxRJaA/Vo4eFbBfyhDgxCytTf7H9Zv1uQnOU4c8QZaGm5yFDMEZ4LKTDu7ODpfnJOjr87++CDYWJg+6ldO5lIjROaDTQK4wC0r4gU9LK7hZQuwiqQI/jjRZM+7n3s49bp2KAFOGaQxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo3qjnrW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb2CXukN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo3qjnrW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb2CXukN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789491051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
	b=Yo3qjnrWKr99mEatN67oAZRgZnsKy74bmLDSvAMWFV+g6gO1Mj9NLCuBDJs80bHbxBvMqS
	goU93OBe/PYa1E6prwl+TWh1ENnM6ZiudcB69cypWSigO8YMN92JAARCAHvqn8StQmwyP8
	SROSdR5ZicMyPYlKBI5Agidposevb5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-VxxKx3UjP8CaJZykb0hysw-1; Tue, 15 Sep 2026 12:50:50 -0400
X-MC-Unique: VxxKx3UjP8CaJZykb0hysw-1
X-Mimecast-MFC-AGG-ID: VxxKx3UjP8CaJZykb0hysw_1789491049
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e661c6440so28073265e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789491049; x=1790095849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
        b=Bb2CXukNqEDNspiy7PlKVZNJkmhveoi5oV+4qxuDDtsjk0/Yx8Ax9+ZPrYcd35CCGM
         Jw3tbT9tbilrUCjTlvhc3P21/+GfpAHCmcTXJy9T/zmdeO9b9MccpPN5wWrbFJRJjY3L
         29Y9IKeXBD7uVKOzNNZ2uWPK7Hsh4ygb/obOnphC19i9b/zCfV0+/A1rRgiI3vTUvkQ2
         HrradPGXV1uMNQpveYtInc5svnUN++uA2zAB1U7a3bW3aj+MfJQTXZEuVPnwucNv/Rl2
         /BIGXyQ3ZLnYWSHc6qgv0G6lEAubvRPl/CGUbZVl4K0TIFcXXQuiIRXBjA9JWY5NlAJb
         gf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491049; x=1790095849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
        b=oh1LxgA+ORRSWcAx5TBh3fSnYO/D68FdMnF5Or+O0AtOIiYxlDUUXfzOUfBJenDDw4
         YiifpaWaCxAeBhAj0Emr1txo2LZ+QxZYLXDr89ZN6do1EPBjKuKZ0pfMViVgUI2MwrZt
         bWypwogwyVV6LlXkQLgI3rUC1V2blL/cWEDUhsCrLgLte127Y0SBLoQPtKsUP6yOloJS
         zmxmWh1ZtQts3uomuWoiKa6GvOlSAqKVvgoq0e1PHFNrhUKu8z/1voam89Xd+xQp263b
         R2yiKf1WavKe0XUnSvrmn6dyihU1PE20EFcFi1s8+6h6Xrk7967zFOgV10znKss6D3sK
         RIPw==
X-Forwarded-Encrypted: i=1; AKwUvBzFVOqR6UVG4YII3Wl/lPPn2od0ObuId92HqK6B/oFW1uaBb6/NqMfUJZmD1NdTILgPGFB3tIU=@vger.kernel.org
X-Gm-Message-State: AFuF++kExrAsZyiM++RNB9HdEzohD79BIjns/Q3AOnk+I9CJypcSvfe3
	MFjbxs5YRsCnTN9yfe/StwNJSbdDGPk41od45V8V1CCSWk7xoMbYmpSTtkKg/GI/WFXs8J1z2lx
	TvM0RR8lF3Hx9yExBaxMix3VH00I3rQkjwtddovc+j8DcYvGxEJsyFgCaIg==
X-Gm-Gg: AYBFou2nCHRFluZ3lOyve8/4+0b7yzpZBwOTh3ukaSe61Z6jCvOVzH7cA5m8qbq5hFA
	ota1FqgI6caKP4mEXJml0v0QaI1nev+BT4izzu4wsAyXRU73l7Ozpz+zl2zE8vfpytpExObyv9l
	NQMPz46nDgwRayYOYd7o3ZmYUCyKh95U7d4MVQacv3NAG+7dgg0zqVKh2M+zA3aApcu73n+lULD
	XlxoU+7bFf6My9hstyesvLQIFpHKBd3ZWeq5/Dy1ksiLuhwVcuyeuhjTjobxIC+GlHiN0LsjE6M
	ZKpnxEwC2h3H3xp3KllOe5vm6AgNAHouxb5iellwIRe4226XRbDPx6xBvo53hC82S96iBxqa0eb
	dGcsO3GIN9JXodJZ990cFKA/+c+L86cue1sfdZxJe26gN8g==
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938395e9.1.1789491048812;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938035e9.1.1789491048354;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83f43ed9sm1438985e9.0.2026.09.15.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:50:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:50:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqlo-DLHC39UlmgE@sgarzare-redhat>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>

CCing Bobby (and I guess you're missing several maintainers in CC)

On Tue, Sep 15, 2026 at 11:15:47AM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before inspecting or storing new_mode when no bytes were
>transferred. This also prevents an empty write from locking the current
>mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)

A changelog after --- or a reply to v1 to explain why sending a v2, 
would be nice to have.

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..816d25b314 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 				      vsock_net_child_mode(net), &new_mode);
> 	if (ret)
> 		return ret;
>+	if (!*lenp)
>+		return 0;

Better to move this before calling __vsock_net_mode_string(), no?

That said, __vsock_net_mode_string() needs some cleanup IMO but I guess 
something for net-next.

Thanks,
Stefano

>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

