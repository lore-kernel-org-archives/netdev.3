Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF741D630
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694350; cv=none; b=UcCsV2TF06KlLzpJWQjdFV/BRorMaP7oZK6s80FspQWH6irqiwhkjscj+B+EARSQkg7gF18ZBxhkbKb+lM7QYrCph736TIeRJvaK+BmJGRqemKihkBae6huFTBte6VwreS6g4XiEWtSQnW8LF7htEOpQ3ru1ukVFG/kyzM9Zr5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694350; c=relaxed/simple;
	bh=FC1U7Bkume/g43id9Gi5fvJ0O8FBhgcpEYLYobLKUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U04SYYr/8wAv2qAIR00IIWonWuphu8ckclF+ZSyDIc/vpCpaWc0u72fdEykQSUKeIUh0EjScsLck8hMEjZb66TupbFhcv9ch1WgvOlQFq6yHi9TCVLmYK84ERAHXygBzpGsu0W3rKsKE3GXSoKUWUaURAdo+TJbIvFDlbLlSYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZDZIpip; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyNHQ6vl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZDZIpip";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyNHQ6vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
	b=FZDZIpipvFTIbcROU0tsDTCeNz1E8s9vDcqJTpro+lSKsDrDAY5NUDkE83t+kM3MLS00r7
	1C+ps18+wH1IoyqxTl1IYLUUv7+P0tiz/42JQL4zQBGTkYoJIT1KUKee+iqP8V8J3mNgtW
	hVh5L0iaaZodUkesBtsPZLx7lb4/b0M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-0EbuoarPOIi1w080_DrP9g-1; Fri, 14 Aug 2026 03:59:04 -0400
X-MC-Unique: 0EbuoarPOIi1w080_DrP9g-1
X-Mimecast-MFC-AGG-ID: 0EbuoarPOIi1w080_DrP9g_1786694343
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4815b878101so205796f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786694343; x=1787299143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
        b=XyNHQ6vlc0imLuYxfdzQfnUrwkCfguoqg0x3XNKXRiXgLe3XojxKHHoSOS8c6Ez7Ft
         ZsGdbADeFDB3kSQ04Ozj153aJdTCIrRP8LBXZeuzVJVrWdrSfF392Lpqs9uWHDIAeNEs
         toJ7RZ7cupkfQmHBS1t7SkaBlYoGS2PowRYazPG178qiU0qBCR3aOOJARy4dH/YSwrxD
         vOEJstep+E/8kBdowmpEfgDK/ViwWiWeNZyI1yqO9bo7LaFFjJAR6mUXQsVN9ZpK+4+i
         E6LpBuVaAARLemDDzoXWB1Ba+L2LkdqKYZMuMVVVbv8GnAtuwVWo2xRpdCsjQImeMUuI
         ZQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694343; x=1787299143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
        b=lbHr9yodYgZFo+f4J/O6MHGr/gL17xhm5LT/lybpK9jNn/fZneZlgNAdWb7Eel9KBj
         Qz+N2pouyfbCo6lN/gO4bi/cTbRTwMJO19uwOiKnEkPnyB+ruSIWHxWOVvkDMiHIXhIO
         bOzoRLnpvH+4ee1Rumt7NUR/wfJj2UtNsYssAOUyGsHzCVlEYXSV8x8IYt/YTL7Lx/nD
         NTpn5qoe2ewsCjJzDJMnYWT76kJXNtZZziUaPhHL4+5q3QrULM7Gas8tHDw0894pUJUT
         Ms1KdBg8Jcki5DlcH8K0JJ71Va8pyYyfN98reo73VdP69jSkJRz7qv2Fm2zPpO5Zt69w
         3prw==
X-Forwarded-Encrypted: i=1; AHgh+RrpeU5CYtHxR3125mBcywR1Wbwe76u93n4xb7zTyAj2SdC1A4XhbXr350qVAro1XbClM0zDzhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKvtLm1R9n67QTOKcmkSPaYNVP4ZEl2YKRf0DYqjKZTQco3jY
	HYCkwVSYS2GS1V2iNlZVY0yRRpNEL5GvbTSz72uk97t+Jyoz/BA5BqI9jqU82Y6dYWSH+XYasZn
	R3e8MdjPlKEmAgkLg0hQf7w+j11x5xP9WbjRPInLpgK9TuZDSc3WXQ07A5A==
X-Gm-Gg: AR+sD11J2rp9/bIP2U50RHOL9nmWkfXaHspRi8K3YucXwyBvsM8FVD9Ih0LWZUS7lEI
	nsJPbArp4bRMPhhL0vtfPU6A+uRz+ZuXErbLum1Vpfrcv06cRxzIs8qewRy2x4ZH9kl92lsdM65
	ODGqR/KrOffHnbzSR0JuikBKAhVUjWVvcfPA9zpJXZZFfIEt17RJbzttqW36YCzf4QWkSOh+O2/
	201vbM0dJGztz9ZkhWlzi/fGGt91Z5cwOQvU4X6ZMFjyM2ct/X2TzIpYtoJYL+hineBoyU3Z6FT
	M3PpiEp26cco5sg8x5yv9tKmCwiSYx9NjPDTnhoRYSNMjdYV9tFpwkx0TrLmW8k1K7TotpsEMBj
	1nkpzCm6O8ATNh+HNmYyxU6y6RKW5/17s+BXww69vzhSEWpZZJQQZ
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222669f8f.0.1786694343279;
        Fri, 14 Aug 2026 00:59:03 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222619f8f.0.1786694342786;
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm6204391f8f.0.2026.08.14.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <an7HhRxxjv09faBX@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-3-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:02PM +0800, Jia Jia wrote:
>vhost_vsock_set_features() leaves the device IOTLB attached when
>userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
>continue to use translations installed before the feature change,
>including HVAs made stale by a later memory table update.
>
>Use the common vhost helper to detach the device IOTLB before
>acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
>each virtqueue's IOTLB pointer and metadata cache under its mutex, then
>frees the old IOTLB after all virtqueues have dropped their references.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b69c260eaeff 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
> 	    !vhost_log_access_ok(&vsock->dev)) {
> 		goto err;
> 	}
>
>+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    vsock->dev.iotlb)
>+		vhost_clear_device_iotlb(&vsock->dev);
>+

Why checking the feature again instead of adding an `else if` in the 
already existing check?

I mean this...

> 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
	} else if (vsock->dev.iotlb) {
		vhost_clear_device_iotlb(&vsock->dev);
	}

>-- 2.34.1
>

