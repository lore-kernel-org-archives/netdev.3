Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D93CB2D4
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455973; cv=none; b=YpWYnJ6OhgLyNjM1PgtMuEhrRfmuMTzVWP5KY3x/wTglDWWer19bZpCsBGXyD+vE6a1Jjx+rMCz1Pj9+JSYZ2cn6LDEr7ALp4uBizj0/cCOTvG5R7W+5YNIIJdHKPYA3QYCNfxw3RyrliuEJkheYTYWoVKth8EXy2Nx3t7aCPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455973; c=relaxed/simple;
	bh=QBPX2FlNZdNHfPS9xAx4hnsjicFqelsPaGbARid3Jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgVuk+uHN6D7VgzBlLqiC5WSpT4kuf/iJUC5ZWFSrDSbgdAb7MaqacHJzH1PX9Y571yVZlIGBCnNU+T8z8W0tYdlYuGWC6ykhGocjKFzm5Gw/3LwKnScPG9xMNek4J7tp7bo9w6huWoekXKqWlRwXRo5PyRWTNhAm6O+5clCipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0GezcAx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkpE9nji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0GezcAx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkpE9nji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785455957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
	b=P0GezcAxKGDukjbQsMF6/OCO19Z1qXsM7CUFMKO0h0oVyZ8Gj9NuieJD6T3qEkPKBMaA4p
	jqXsmGMJWGGZ7xF4+xpHsJ2hxwSNQ3Q8HKii+BPRwKKBi0Bem0dcpKaVs3sN61SKvleR0o
	9JflElbYvOdMHgTx1ImOntt7bCuqkZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-R-Uan9HsMC-wulaGZo7ejA-1; Thu, 30 Jul 2026 19:49:32 -0400
X-MC-Unique: R-Uan9HsMC-wulaGZo7ejA-1
X-Mimecast-MFC-AGG-ID: R-Uan9HsMC-wulaGZo7ejA_1785455364
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f9ae25143so263392f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785455363; x=1786060163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
        b=FkpE9nji4wxkpUe3Ffk+MOlVK1tC0jcQ6whLGoly6zFl1V+YfNevc96l2sQ/ze3Sbm
         /P0ajtlK+Wc9eD/02B5NibY0itmzNXSraB9ALjqF96uCR5lwpisCTHozLbVw9g18bJxR
         g7upksgpvxHK1awXbDb09M/7pJxifyVwBkntBynXJ/2VEAYyVhPXBm4MbqMwQ1aW14y5
         xZeAUp3+fOKIQR5uXEUF6XQa9zr4nVvO/Pb3xp09TCjlGbcw9+lObIOWusDcx4RxxurS
         MDJkuTQXvtt5LJposciLGDtaJO1FWuO9Jv1byHaULiLN41Vs36l1J3844vuW/e/PoQcX
         RYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455363; x=1786060163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0imh//Ln8azssKsT3gHIO0joG70m1DE2os+hdd9glB8=;
        b=Re5wX2XKKq3lbvZiMhkcDcLV+LUJe3ePyk4xTCxxvU4bvL92s/Pv7shxlruqSboEyF
         fq/gISj9isYIww6R6KGbW5tGPDp9MLx2pY8e01RxTp7X31DIq2FeYf3sLr2DP41zkMOA
         gbua4q/278YXtOgbn3BMNeIWP96P13b+F59UtRdMqGWdYgP3kDP4PW/p2oxcin5Ofx75
         GD1p9ueXdaVCF6ADar8RPtMaCyyKRk8jgK3Kofu13r/QmgI5a/c/UbDAxH8gPaFc5gbb
         yrdDKAV+a3D8An3plM9Hv6eoGnY8r8DTlWQ+CtkGvHgDBPxVtMRQa0y1ilNJPrVtHR34
         NBWw==
X-Forwarded-Encrypted: i=1; AHgh+Rol1PuitwGOPridVOAuI5WV2h8E+KdadpJv9Ip7cex1fEQZn07RUz3QJKhW0cJbKmI6i/2A3J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdC9F0hUEjn9Yl8snOQY50LQQaCmcBfoEYeg9k567kCya9OyKY
	afGxoHOmmuSWBWqv7+zkcWVxxInjimnMHw4OIZf8vt6KVV4LNfLbXqrKI2a7FcIPY5qVFK8Sk+4
	Pky+7JwcO9GmOyG5H2QlFXP4aX0L2Y23hPKJ3Qmddla8hPtohtcoazhoDEdr4JoMXNg==
X-Gm-Gg: AR+sD13tzWhxyidFpvf6uX7j0R5pyku7Nde5ZWfdqaM4KBgiJh0uthImn/ktg4mPvsT
	JKS9CPw6dYKvF1vgxA3yYLMUB9gFoln8L+vpFg3d1HKbELnN4mlGPN1X9Iqsb1UFz4/7CEtSzGF
	61PCvwUCzPkun3fnbEOZ7lPI5Z1z+nkVI95dRDD2jyR8zOLWtbaExpB/mfoWzfv9vPRYw5IjX6u
	uiyi1feMXP5DWFyqa2LIIw5vpXIhmH3Pf9sh5GLIgAJgpfSqGQY/yUPessstbBqfCtx5hajHD8c
	GpN2ExRPD3hD3rmWFc3gcX8rvtD/FLFNu0Q4Yckj3FqAvmjn6kCWoMT0w8cPfNl5ypbEvYvVxqP
	Ew7DsKpYveYM+hnVkcG8SYX8=
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660268f8f.41.1785455363407;
        Thu, 30 Jul 2026 16:49:23 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:474:cd60:1154 with SMTP id ffacd0b85a97d-47fc8200021mr6660223f8f.41.1785455362999;
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e3c73sm10792795f8f.10.2026.07.30.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:49:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:49:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260730194858-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>

On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> v5 -> v6:
> 
>   * Patch 4:
>     - make sync+flush conditional by adding a bool 'sync' param to the
>       chain, as suggested by Michael:
>         vhost_dev_reset_owner()
>           vhost_dev_cleanup()
>             vhost_workers_free()
> 
>     - reword commit message and comment;
>     - drop Fixes;
> 
>   * Patch 5:
>     - add 'sync' param to vhost_dev_reset_owner() call.
> 
> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com

does not apply for me is this for net next?
in that case

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Andrey Drobyshev (3):
>   vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>   vhost/vsock: re-scan TX virtqueue on device start
>   vhost: synchronize with RCU readers when freeing workers
> 
> Pavel Tikhomirov (2):
>   vhost/vsock: split out vhost_vsock_drop_backends helper
>   vhost/vsock: add VHOST_RESET_OWNER ioctl
> 
>  drivers/vhost/net.c   |  4 +-
>  drivers/vhost/scsi.c  |  2 +-
>  drivers/vhost/test.c  |  4 +-
>  drivers/vhost/vdpa.c  |  4 +-
>  drivers/vhost/vhost.c | 26 ++++++++++---
>  drivers/vhost/vhost.h |  5 ++-
>  drivers/vhost/vsock.c | 89 +++++++++++++++++++++++++++++++++----------
>  7 files changed, 100 insertions(+), 34 deletions(-)
> 
> -- 
> 2.47.1

