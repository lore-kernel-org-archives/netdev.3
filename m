Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A930595B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616944; cv=none; b=eniGwR5AYYxA3CYho1qciw8QdRZwTehQncD02lwx/tuxND1lv+ADgLma0nWfi8ThSbmniDnwTeQ5PLOjOa8z67WNXzmixd1wOP9CwZ1dI51CLEmbwrtf7DW/0HC+qc6UhuMRrSQ0WGIwYImwRPjfpoymM9cMHszbrQBiNy15Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616944; c=relaxed/simple;
	bh=floBdjdCkfcczlUBmvJASMGyf5DyrXJjY+5qz4ctWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pczfxUt1N47Oig2mu2gx1Ec0iRr3CH7VkffQ8xBxWNaN+J8mbPX7ZEcvdviTrY2ooGeD0WQ6HDlATWX9vrVJJ6S8lz0MFH7T5kUwmR97Yj4PpGw+HfAn3SZJmmdfAMSTTAJkAdMEv5OeMOJtL/SOEV+1hCZROrVNecJTne82N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMYWd2db; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUfREJWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMYWd2db";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUfREJWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781616942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
	b=FMYWd2dbyaF/Va9FGSYFHxAKCpEQHWhprGgrHpCcHqHgEBrrYZ03HnCkjv1VqnxxSZT/9A
	7aKqRhDynZ8vaUFxSLlNGprgb7hC7TPs6cEh7DnJlma+lMDbxomqYKx2zBYFHPacHRMN2K
	DYKj/Yc9vkotE9fFmxShGkDgrCYPOyw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SzaYzVCXPiKjTZPGTrMqHg-1; Tue, 16 Jun 2026 09:35:40 -0400
X-MC-Unique: SzaYzVCXPiKjTZPGTrMqHg-1
X-Mimecast-MFC-AGG-ID: SzaYzVCXPiKjTZPGTrMqHg_1781616939
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so26947695e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781616939; x=1782221739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=ZUfREJWMTRBR+l9QwYwt523KzP1Ce/Xm7LU6xVo66PB/zEXnZfqcBWnuBhTcAgSGnB
         HlrxdCWDSK8Px0MsRp9dJ+Kdi5bIFZks7P5xtHJ7T2AxgO/LTXTs6wd9aMBCTxWlm0ch
         wf5qpamywY4zJLvdVCUh1ULSjeGcxnBIpoRYlwafLK83n5uTl3x+G5fCemsu/0KSqht6
         HY5mD3IjwECSYZTUE79KHCxb8ONqukNS2Motq5TWdTKQ/WRhhkndPVtelXs8x5avGX+a
         ppT5aqeCQ1Jjk/+1AiktNmluvXgKh+L7rDhWpXk+gXLgh6FGskEEG8iSSEmFnm6CDF15
         z4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616939; x=1782221739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=dU2FLJhBnGDvctgPbnPBrFLUqp7UuPRnUNVNBn1edrU5x79lHL3MJZ63okIv8Z0yj3
         59vADTgzv3OPm8A39KPYyCIJBQfkZz7QZXwGKz2/QEmN14kqWl65vDU3QYbRimAiTCUU
         VmZM3Lu17U4UC0QsLuYUYyTyctL4O4Cfl+mNZnJFDz/j0MkzTJBGvsI7pkgypJFLSTpG
         vtL+n9CjXoLDH74ACbam5PJJ7g1OVNd7U5mMkywbygp7JjDmOy0fcabQ1cmUw7YfWSAM
         G/lFgDwuHWYZD/4lcuK/8aL4sxpe5+oGY+S+W7nr2wi/0u+8Taxf1Zc5Du1a4WN+ENWz
         ILwg==
X-Forwarded-Encrypted: i=1; AFNElJ/FQYsYr7pndJ53QjEICZg5a6PYWSdDw5qIVrbB7lhmmpSzWd95UjYtjKybSWzn2UUROuIQCP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUEqC7J0qVqmFdXE0YPc0TjOeL6JHxLTD6Bit1Dk/r8GnGa36
	lo4nofKJnCDgDBvfQhK8ZEI392sN3z+YTEmpzSYy7H911DzVDN/cmbDA/FLO3McIkFdnAglbbHL
	aIBpJBj5hFXEpsJuTNCifieFAOHvu5p+3qhbvHKJs1BqlMKnmHZWezVP/qQ==
X-Gm-Gg: Acq92OFRf3LzQNXU2WDu0VTO5H6yg1llHBUoQZqos5iEesuEUY8E5EFo7kKywTb5b8b
	xmbe/agINQtrc7PbjPs2yaZ2yERuOxTrEdX9HEvABLqNy6zngC5dKKe3NOyvcYvvCSeipNDa3e9
	HJyWnWO4hZvziP6HTbpfWDCgzqRkNtzw/iehNNHpdTMup9tV4ythv+ff12S3LWgkbI1OQz/cdEM
	fCc3mt+XdNQlO8rSkD7TIvKk5S1Cv6LWIzI77i33UaMjKs5fa5+qP37dwvPnsDlA/LBOqyOFqcT
	YoI4tdjpjuC85ja0zMiBmOCjkTB0564kNjYYUgtMaG75q3gPKzDoWLqlOf5EaKr0l4m24FZxrbb
	lWHac1BEKod0Br7vJAeaUTqRnOTF41Tq1ZvpC+dNrCmixWZjDop7MC3xLkk/yZr5chKY5fF0=
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168841305e9.0.1781616938927;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168840785e9.0.1781616938426;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa890d8sm89760905e9.10.2026.06.16.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:35:37 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:35:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFLvKcT-A0wvLYW@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>

Hi Andrey,
thanks for the series!

On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>outlive VM migration, since VM is moving to another host.  However
>there's a special case, which is QEMU live-update, or CPR
>(checkpoint-restore) migration.  In this case, VM remains on the same
>host, and we'd like such connections to persist.

In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually 
sent by the device after a migration.

IIUC the specs don't say this has to be done all the time, so we don't 
need to change anything in the specs, right?

We just need to avoid sending it (which I think is what we're doing 
here... I still need to look at the patches).

>
>For this to work, we need to be able to transfer device ownership from
>source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>calling VHOST_SET_OWNER.
>
>Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>such implementation (patches 1-2).  Also fix regression introduced by
>the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).

If it's a regression, should we fix it separately?

Or is it related to this series?

>
>There's a complementary series for QEMU [0] adding support of vhost-vsock
>devices during CPR migration.
>
>NOTE: this series needs to be applied on top of Michael's vhost/linux-next
>tree as it contains relevant commit [1], not yet present in master branch.
>
>I've tested this (patched QEMU + patched kernel) approximately as follows:
>
>  * Run listener in the guest:
>  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
>
>  * Run data transfer from host to guest:
>  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
>
>  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>  * Check that file hash sum matches
>
>[0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b
>
>Andrey Drobyshev (1):
>  vhost/vsock: re-scan TX virtqueue on device start
>
>Denis V. Lunev (1):
>  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>
>Pavel Tikhomirov (2):
>  vhost/vsock: split out vhost_vsock_drop_backends helper
>  vhost/vsock: add VHOST_RESET_OWNER ioctl
>
> drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 69 insertions(+), 11 deletions(-)
>
>-- 
>2.47.1
>

