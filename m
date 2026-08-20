Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B53E0096
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217202; cv=none; b=Yg4BqE/KoN+sBrThAKs6gdJKtP8Asx2Tl2TrSila/N2s+jdDBglI4U1MKD2fHNXN0BABb+QlkpyeEP9JnPTwd9vPqr8qJfwFaCGCkiA2GNdgHdi8AzlWAZT/ZcYr2XvWMv7rkcJ7AEFfdJ68uacffj/gDjKrj4Bfu8XTZOX2j9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217202; c=relaxed/simple;
	bh=hPrJc7tLhkydvuvGvf8xRiI2Fvb0aBBPRteZTc4WY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCXx4F6ZZTrV2cr+i/X5Y9lr9U5ldey7jdAYhYiYuXRVuEFUUrWTbolIJ+g3BbybVNSjIgxhVjSlwlD5jlws50wHW+8GYqfGPhYWvytO5SxSOIWNVbO+FoHPL6yFh6uEm35sT/eEfpDrB4nHJ11BqXeXJZTokwgc1r0sEgTF4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L08s7BvN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N59eC3mC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L08s7BvN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N59eC3mC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
	b=L08s7BvNYAdHTuiDhaiW5zeYEhgJYatSb+1tfSXMbKUpnomk74x3Xq5AtPJfw2/u3xZ+my
	w9q+ql2m2OHfsi1NHJQOVHx2FdqNSgKIR9025sJR0PsKi9sVOtqmaBTX+2ADUVGD7kEBlX
	Y//474eXMdbQwtUrdRnVVzATNb4knYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-5Lg4cThUPeCT8aD00eD63Q-1; Thu, 20 Aug 2026 05:13:16 -0400
X-MC-Unique: 5Lg4cThUPeCT8aD00eD63Q-1
X-Mimecast-MFC-AGG-ID: 5Lg4cThUPeCT8aD00eD63Q_1787217195
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496b6f97676so19439465e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217195; x=1787821995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
        b=N59eC3mCXAMklYF9sZ4EJKksVRbp7AFM8jX118dP49W+Ub8CQNg2d3HeJy5MdUlJ40
         h4Jpjo2XY5JS8ccSaI6qYO9qS6oMdfzqj9js+WRC+iC7W2fw77LMDtB7JZ5o7zBbL7EF
         I+db5Oc0KHyyLK7jrYw3ilCeABIV1+MjvQ0Y10PEGQbut1BkJVUEupAFj/pI0TBtn5yl
         hLyS3vKWtOxHjYc1ddLsC69knx3NNWq84p9GelJFiGHux0IH+wqWsctmDsAjcTP8CLYI
         bryeYJP5iW4oQZvuAk3CFvnRYAx3aJPPDY955xzMGC6y7aqE+DKMiWcKQ8Kqre6pSPsD
         kXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217195; x=1787821995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
        b=mhxLEN0LViUOCm7iqLtpQgqRwmysrda+DrIc5RSYjZLzVQT5te3+7eJ+/0enb5Nt8h
         +Y3trNoITrHpVZ1YP6sI8RhnC8CzA/a6D4fBRAEdNMCQ9cVoXo3nxv1XJfI++sJSL0x+
         oMbi/xpd5lQ8QFCWtSAr/93/EhmfEbTt/fuD8h3CENWPO5dOkagqo+Ptmkr5lft1hfhJ
         RduC6sNaeMWlTaX9dP801H/0hXuI3G6H7WazORfQ1qJoY28/lahG0VzacpcM6XTAl/63
         EzKWssCpzG5n6jiE5w6VVFLs6Yc8Vk9ar8GyNaR4fyyXi0H9SiSg6lmeL4beDvqnTPgb
         3ofQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1wk9ZM2B4QqUgbMmx6DLz948iUtY8xLVQDQ7SFIX0ZkIMYOuHGCDlbq9vx6tHkI/0+aO4BiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxORqBOqviIj3wBaFmH99OlzTlHCzILV3/oFN8VTptGZmwAAKy
	eEOnOQkToShgug8r7Ee/DToWMFINutVRJbMWBRsM0FwqOWHjnQv0OBkEiacp8Fu5vj8U5XI0xsd
	PJAIahND+zZ8YXbegaUxDRWzJ2q8QRuB8sng3M9jeu0hTjLxCP95SGwN+1A==
X-Gm-Gg: AR+sD10ZvoPMQvlIEOh/LCpjtZRyaSd5y35tcMbUk+Xi7zpz5Og4o40plzn0XnsCDUN
	sP2yvU5ODi/MFI+Tn9mGtq2HGUBwGCFKAIPH3Y/X7jutdL4WKT5whoDumfYpJ8Pl7ulWeMXVAe4
	yjDj9eZ4CragA/nbtXIdJcvwo7I5cyv5J/n8piUYlQ+GVICrY3/fGD2WqlfPFL99rN3WoN8PkYu
	KLDEPRN1fHgkMflEwUWHLKj2LVramH16lw3i39wntDk2EBEkh+vpyLiscTaJMngJdt1ib1wlhzn
	VjUqPS2I9Mn3uNHy0MZc66ON0yEz07fVs2zwOEEXqOAjgJw2OxotK65azc5P18kPvzv5rQagSM1
	LAhjj3QLuQko2vlt9x1ygktW8fwUl+agT+n2Yd+VZ1wngledZ9dTU
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209390665e9.10.1787217195330;
        Thu, 20 Aug 2026 02:13:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209389755e9.10.1787217194814;
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd7a9sm164548055e9.2.2026.08.20.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:13:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <aobEwtvZ2WELwX15@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820080332.313933-3-physicalmtea@gmail.com>

On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
>Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
>Otherwise descriptor translation can continue to use mappings installed
>before the feature change.
>
>The common helper invalidates cached vring access and applies the
>transition even while a backend is attached. The backend remains attached,
>but userspace must configure the vring addresses for the new address mode
>after a successful live transition.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..e1e9d002d6ae 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {

Unrelated change...

I think I've already pointed something like this in previous versions: 
for a patch that fixes a specific issue, these unrelated changes should 
be avoided. Please keep this in mind.

Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
>+	} else {
>+		vhost_clear_device_iotlb(&vsock->dev);
> 	}
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>-- 
>2.34.1
>

