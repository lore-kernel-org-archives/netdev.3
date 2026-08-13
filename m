Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEFB44CAD7
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614262; cv=none; b=CmtoQpKWu+50WuLoMnMrPOUIQ9+zAhZDJHsJTUMVo7II57aiReMOhJ2+jNBK+OkVHqmeo/3aHxhHrbrVhBnLPwqIjtl/pHvMXvTjprMd6jj7xGMXB2r+IjJ6Ei7BorESWWZPGbRi8yOR/gVIvzwKBT725o2IxiKe/G73Q0sB2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614262; c=relaxed/simple;
	bh=vgzaF3qPw7XT8z3S/p3BGnzqBFJxnHBrEI32qQLtUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX13KflOjWgFGx5ppnmiT+Af8Y/ZgGpXXFpph06lr92gauqm50mC4izllgtLPz5fODhF7KpX9xqaWjzlsu+Yb8SiRUtj+M/Joeps5YhIqs2OVV6MT1bkuBdbpH/0CFXoUFlbj3cD31SRlLbT1pywM7JFvd/RxtWP3ekGaReM2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+qTY/T4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgj3RKT8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+qTY/T4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgj3RKT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786614259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
	b=c+qTY/T45n253l2xqvX6Zs8tFsHgOT9W7sgnQZie1fxOIjlMsGaH7LXS5Dhpmpr8mXeEUw
	f4b6mrn6Cdl/Fyd/nXrYwYbeLdstzADjuNB8t0sc+aLfxHteyyswEzXaXr38/PrM4dxYhe
	WJpago84638Mfyw/IZSl8hTwg6opmrU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ZFCDBcHgOKmDK8nj6oU37A-1; Thu, 13 Aug 2026 05:44:15 -0400
X-MC-Unique: ZFCDBcHgOKmDK8nj6oU37A-1
X-Mimecast-MFC-AGG-ID: ZFCDBcHgOKmDK8nj6oU37A_1786614254
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47fecbb7f88so1379677f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786614254; x=1787219054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
        b=Hgj3RKT8yzVl0dmnvaoJ/RmOT0bVF1Ag2CrcpvBBw4f2fUriA4pkgun3v+mxr/wTGC
         T0dGKFLEZ34PyMcatkvf3SHl532NhNNL2R+YHj7PvJUsr6RO3N5xCRVLDabcNHScNFWM
         k3xNADqAbxlUgRGvTp4vmo8aIO/eY8GnJEru78EO8VIC5QvACZ0VmG7JUc7tais5HCii
         neksxOLUN9MmJ0OYHTbw2BrUSDXuf4XxfgrbSPI4G3xvl8dGYUL0aocrG7UqE8Mo8FYk
         XNrzRuYC+d22+FHAFbVGmhZqQ+99WNuPk1q4s9R+wB3KzcVnBfn+3K5+zkh/smarRBAB
         RjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614254; x=1787219054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
        b=CscnrhND1MbtOrYTvUBatwyfu1kWUixOrppkoot2YZ+l2t4ai6hD7dwso26ka1NKiK
         2xcgx1qTEzJJja60OlSblJu/IFL3DCP2HaKtawog5EcV7huXDoNahyT+lFjn0zDlcsHR
         R940a4jbWaOBBvktviNL0baLtQyhNKQDHKuqQcRlWP+3jV1uSVqAzhDWyMpIDxvaB4Rr
         OR3Kf8UbxgpJhD/qAALXLvd3q1G0gFTxNkWIVLpC0Iw3VhZQzeLZicQkKe6L0UGPcj9n
         30SD8HtivQLGDbU3gE0v7rZvuzENr9pUxtuefI9qKQGl3lO/mnwI4d+ndI8QYGS9oi4h
         2Tfw==
X-Forwarded-Encrypted: i=1; AHgh+Rp07tePtCMQNOHHMCk/Qd+/Dm11WDtREzN/q3f0PQjvOU55BQBW9GMTC4iJ76IC+baaiNjHL+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUj/K9DJi8mXJf3c2dcMHhGxsew+SZZUfKosVaQnykZTmnw4p
	W9/3pG7PTuVZZbKq8dKkw6C8uc7/zm1dT2hh50t4po7Ldm02hv7ke9soeherMxZsUvoPJS7v8gv
	9s6/R1koLpKztZPyXx557OezFdhd90ruPYSWhTGVIoxelnmlTdndrgGX5ow==
X-Gm-Gg: AR+sD12zzgPaHJQ7is0K1E+JsPNl7B4wUsXdwrf3YHT/dpst37ImB8wW5wFZaYUPr2i
	EdlfnCFQX67tBxmeHUsYsACVqWbXChE0OcLoDX0uuMOoBqVwP9Q45ZXBCG9EDNgdq3p1e1vkYdG
	kRCNhRi0RTCImWqB41F4tvkpHfESUsryyyuUPor4IsDm6mY3DDnaqRmswjld0/xqFxTgRm7xujU
	S2w/sGCyQ9n2N9OntSlCqfnSbTSIvoCRQKPKGkVMe6pUMncTA0UjDcHkZvWZbhD/ad/rSlYQnbm
	v5mXt5q9KftLj7v4Uktqhk+JflfosnGRqeNK0BLNRA9YilrSg7qlZBDoks9BBiIgvHcCDmJ/27K
	XeFMpfH8W5QS4dfotzeZ5tQ88pX1jtnbjGVNBN03MiUKqDTcuIJTy
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877713f8f.15.1786614254499;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877650f8f.15.1786614254041;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6594939f8f.6.2026.08.13.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:44:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:44:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Message-ID: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810134018.143973-3-physicalmtea@gmail.com>

On Mon, Aug 10, 2026 at 09:40:18PM +0800, Jia Jia wrote:
>VHOST_SET_FEATURES is also used to update logging while a device is
>running. When ACCESS_PLATFORM stays enabled, allocating a new empty
>IOTLB on every call drops valid translations and forces avoidable
>misses.
>
>Initialize the device IOTLB only when one does not already exist.
>

Do we need a Fixes tag here?

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 7372c22691de..1beae7f5b9a9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    !vsock->dev.iotlb) {

Do we need to do the same in vhost-net too?

Thanks,
Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
> 	}
>-- 
>2.34.1
>

