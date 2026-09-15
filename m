Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324E49CF22
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489987; cv=none; b=RK7NRReFYsU2FLxETZXERtI8AWBhLFqvHTVfiunvW2zCRZ4ZoVGiGASBggSSceDcGU5o7jBWiqbXQS7YUHxd3JymvNuDkAT5rKJ3yW6bsQug3q7X66jBpVerWlGa/QdMrrd8+GgRV0naxcbUnux7yJ2t3jvt3OKsb4eeYPHNguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489987; c=relaxed/simple;
	bh=Xzgz+4tsqdIJiJ44u0qBX2B1GLvXUOfXVH0aIZzJ9Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlY6CpprEvf0KFVAszzvDjd5vneyYlQohnFatFLVlJbu1oAnAsrZI6hCAP1S6FM8oojGdeGlUrWllkAnCEl1uU9mJrH5bBA78uMd+YfA5CxXteM7fKkVrorGCBdtAgUP2P+oZtvkK4Mt/0qAVPtQdT237eq9ookPi9OJi4RQflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMuy/4E5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiyXGILZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMuy/4E5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiyXGILZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789489985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
	b=EMuy/4E5cIH/zpPjsfVnZ+f5iluwYV677C8HfFeKeG3iEOEdWFUFD6XYcEO4kVRTG365m4
	tj52mKho/n8mdZIwPPwwDHwU7AxHJQjeaIWqZ4mkS7XEEONP4wlsRoL+EmcSGTYq1blYZ9
	cY1wlFYBiMLi0iA7CLJkoK0mpSb6GHI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-04Xvd8jCOleJ-NgpK0hqGg-1; Tue, 15 Sep 2026 12:33:03 -0400
X-MC-Unique: 04Xvd8jCOleJ-NgpK0hqGg-1
X-Mimecast-MFC-AGG-ID: 04Xvd8jCOleJ-NgpK0hqGg_1789489983
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e65ecd557so30686335e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789489983; x=1790094783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
        b=NiyXGILZXXkYsKiUM8gekg0NdAkMrNWfZPRNbtbyW0Jch4fUcvZyglEloXy0rv3pmg
         fjTxNQAxhRHszyeHFb53qxpBptHq1S+TL73LcZ8Mmprmzjt2kd8xVqN1oRPcw0loo1JT
         Y++A4c5bTIrSGd1vjjI1mIDIRhZh92dXxs/T7TyKmYNqMmW6LBqVnffvpvK4NYQiCncs
         IxjWdBOIfo0s5uB6DyklvFZWg8iXUfenDDoOK7p2jo6YbcAK5XmooCbDw1qLiN6Z/S3M
         dkjLid/MZfcr4KGHRvmdPpOWFRxZ8P7bPMdWByyUzKFIrFhE7p56InXjyfjlNLtzb2oQ
         H9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489983; x=1790094783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
        b=Ev519R27l8DRZ0As/9gJGQHBXrHA3SUZ6+v5OJDHJpRQErFSbHqGdeCS1CnL2DfjUQ
         NDpgVWMf3YWCt/Jd2eZ6HxSVt3hByM9pMgJ3sbmXXWJDO95CMUPd1ZRlnNYFQ/l2rnAR
         Txdo6gnI67lFtDvotg+xSAtEMQxTLd6gsx3g9y1M4n58gUTRp3PeCTfPoc6RyHix8i8q
         l+HOsc5W7AOdh3/s4lFwLqxlY/bImZfADbTyovZaRsHzekE8utwXkpP5TBRuTmKNFQt3
         VfKwAsXOeSc0i6+yGa7FM9rbwxbSXDqmAlQ5qKuwGHLHMGmHBwcfaMzZesFeSv3v1SgM
         IZDA==
X-Forwarded-Encrypted: i=1; AKwUvBzlfbc8sDK964KldBctScGtJfHhvXfHbCjWIFjH4ueLB2GBX9you66a7nLNKGnk2UM3EO8uFTc=@vger.kernel.org
X-Gm-Message-State: AFuF++mzouuHzSuOnAndi7acH1Xa8j0bNJl5bYfYrLmc4tqwCX2Td6vt
	x5X07n175vaEtUO5+FnqyDp2H6dYd4tbfAduL3yEyR1iFYla2wjonGxltmJ2Ma+yXz2KgsOOqgj
	0t7gpjs1WTIgqikeBXCbJlwi/FkVnuFKaNFJ1dc4VstcFO4VaDbcO1xJCWw==
X-Gm-Gg: AYBFou2XBUFkaKOaoSIR2oH6WGO4/aE8AMFbkAeErUiGG/eXwgGnh3hLV3XIAhvkMTZ
	LLRg+iFnoECBQXuN9xcHgY6Vxp4p4LyZnxEByk5NUl8l/qpIoG4xnTI2cxNyDxHGJbXQZm6SnU3
	Cmm+gC77+Ms9gQ1yCMoNADWIlZRQ16nN6pHXfeKy08Q1vDFVtgw9KQRzOHY2y6cAAJ6obHVUmOh
	gDuMcgO8sV+iXeTMT5ZkAEkidsTCovd5++8XQanxQ8BzLKAggVW0VOMuAk4+2oEMiLYFQmBs68T
	gJ4EUBl1y8JH3xVRZ6cIeqiRv94O+A3EnEpo7v6cU2hl4grQ9HKcTEnuF/g5elKAJ8he5YQ+2fD
	Y2pfu8tY0HzOmkK35LW3btxirF/MK9CWKORM=
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26724365e9.19.1789489982805;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26723975e9.19.1789489982463;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83dba8f4sm1920305e9.13.2026.09.15.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:32:59 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqli0Mq_jv28h7eW@leonardi-redhat>
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

Hi Aldo,

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
>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

Code LGTM.
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

To reproduce it, I suppose we need a kernel that does not come with
`CONFIG_INIT_STACK_ALL_ZERO` set.

@Stefano do you think it's worth adding a test for this case?

Just out of curiosity, how did you find this bug?

Thanks,
Luigi

