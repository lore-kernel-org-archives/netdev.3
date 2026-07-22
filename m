Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5C432BD3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711703; cv=none; b=IWkMIAj+NrCLcHBayMzw1yR63jNITRzCkaPRVOKmqcNrY0dRoDeoRTQk23I0uNIVe8im5kIrEhIva2UmQbIzQl5zDtVLH8cjfeh4NbAZ2Qi5ywyQpZ511VuO2Z1JL7H+ctNkm8kbmCpXVITiVcuIDyGaZvf+E77rwlOEHvFtt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711703; c=relaxed/simple;
	bh=ij0mEyGqqpAB+MTW4VTiY1ayxaymUfWl8B5riM+q6+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOKaSqIn1/oMKrbRpR7bx5Ora2kgWGFbCCpcRyE46Y0fPhXU5RVqAf/nxb5GnLQKgi+rC5/yl2VWhSRQVWzo07wavAqxVfUxAYDiYeTVW5ni+L45k832w5VgJZVNIf/1sISP2LRZTO2rTo5McK6TAemXJwziqyhWP7aRB1Jf5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDXmR97/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ju3Y1aLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDXmR97/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ju3Y1aLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784711699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIWmYsirlfTwtwLrg8PTuYInqgKC4lp7bGK8C3SZZwk=;
	b=bDXmR97/02T5m9tfQoKol8Ijy7/iXiPZPZd8sBTNeu/rkeyfr9MMw5YZvNu1mcaW+hDXnE
	aDNGzg3v7A8Nkn7NMjPFkmzjW0DTmU0GOzQTAyH04hfA2BDtoi1um5BDp9aHe8/ODhTiJ1
	/+oVJr/PSCgWzh+acSGsP84UW8grTEE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-MW-0hASQPkCOPQbHZu96sg-1; Wed, 22 Jul 2026 05:14:58 -0400
X-MC-Unique: MW-0hASQPkCOPQbHZu96sg-1
X-Mimecast-MFC-AGG-ID: MW-0hASQPkCOPQbHZu96sg_1784711697
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492714d002cso61736605e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784711697; x=1785316497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HIWmYsirlfTwtwLrg8PTuYInqgKC4lp7bGK8C3SZZwk=;
        b=ju3Y1aLawBaMMVfs/ZLzxOnwO0n1saNR4knTivWHhkgJYKxDWmNa/O2oltXez9JxzL
         t0sZXTMd0CUz6f7Ok0o78sjY/251lEP2GcshHK3sXsnhxzaSy2UX98nGjZ/xHYsOgTtI
         WU5PrZTpkyrldUw889vCpaBkG0madjYOGubeqNXoFjozVE2+V0MvJ8FJuXoEpCKaPP8Z
         9o7oc68ZehDRRZKFsLqU9y8otG88Gj+azOJfllUi26Rsa4AJuKrMrYLqjxImCHdj0S+A
         KxVEt189zOLN+W/pWFayYicB/sjzcZe0Xxpup9MFYEBgmjddfRsrUIwgY8fqKGrTC/ti
         AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711697; x=1785316497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIWmYsirlfTwtwLrg8PTuYInqgKC4lp7bGK8C3SZZwk=;
        b=ZHywHTwwyzBHIG6LMKD0Sb6OmKm60Xiz74BUBrsPleENwaVuCfWyc3DXJATw6uqrGj
         yNj46wp9XaVcLVdrA8Z6cOFcexGDNUcokY7+++ahygfTI/paf7ZW0qXqzCySsQF32lxl
         /HhhCcsXvp+5ZdFJ7fZgrRt+S78pMepLmCWAvryjQtv3tTvCK4yI/3sH1kP1V3tFq+FT
         jYlcpurAcSXxkrl8Lqz+pD9Au/fMEYiTJ6S4otqeHLA3E8c3WiOs+LOMxKXehJhANqKl
         bmG/jui0oOpuAqunyqqv9JBgu7rB67WWYvUxLe/6yA78mMilF8QjHkVCm82QnAxIaUep
         aDWA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6RJojKmWXLLdFkHeVX9cb20yLaYXpJMwmTQ9dIu3YNrRf+49pAhUK3UorivMpK34+yZ4/3cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7gkDN4W68ma4XpqxXKm3y38pRrndUVj8w+jAjpTGv9E7slO/
	Ebf23lGZhDMN8Q83LV5JW4/xIgnQ02GN9GWq3r8v1iZfQE1uVhGQcPQhmWVZXLyIb4zI1K1/oqK
	SYHIWRbeXxcbkpi4Zwy1SB13zPFi1QnYX/TCq8eAgBfGvXvKfzvT2W/Ybmw==
X-Gm-Gg: AR+sD12hQv4PAB84Y+kdvYzlDkPkMZXeABIoJY0ls55BWRrdbGl1FwILnHiaFgHBob6
	Ro1TAUI/L1HlVYIr+BnUrN71olqfgrtrjV0Xs4GTr9dZB0JF/8YSBj2pU4XgqWiM1Sum+k+3NZP
	8/hi4jK02U0Lj/rJ9ZrMDiDETrIh3nVyBWvDWVbYwErAaxpg9spHGZwgHGnp978L1gwRTEBkf3q
	1HbYMUQQLm4nuQmM4sa9J0iLinBO06DBdfFMD8Bo3ef6n+fZ2edQSEj2men58VtEGAibpwBQTlm
	rF/o++K9WPYitKEGMeZUMyLmh7hzglPB3vz14qBcEBhEGoBJ/uibqodBs0mrbI5NOg/b54l4aFp
	KM94/qIshMKtk0znDXbx2DuLLD2xYYDiKYN5vt9lYtvpLTbbjdw==
X-Received: by 2002:a05:6000:178c:b0:47f:71dc:d848 with SMTP id ffacd0b85a97d-47f71dcd8d9mr16850979f8f.12.1784711696918;
        Wed, 22 Jul 2026 02:14:56 -0700 (PDT)
X-Received: by 2002:a05:6000:178c:b0:47f:71dc:d848 with SMTP id ffacd0b85a97d-47f71dcd8d9mr16850922f8f.12.1784711696414;
        Wed, 22 Jul 2026 02:14:56 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm4619604f8f.7.2026.07.22.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:14:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:14:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 3/5] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <amCKAp08S68JWXRf@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-4-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:39PM +0300, Andrey Drobyshev wrote:
>During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>keeps running while the host drops and later re-attaches vhost backends.
>If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>and the next vhost_vsock_start()), then the kick is delivered to the
>vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>kick signal is consumed.  The buffer is then left in the ring.
>
>Then upon device start vhost_vsock_start() only re-kicks the RX send
>worker, never the TX VQ, so the buffer is processed only if the guest
>happens to kick again.  But if the guest itself is now waiting for data
>from the host, it will never kick TX VQ again, and we end up in a
>deadlock.
>
>The issue itself is pre-existing, but it only manifests during a device
>pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
>during active host->guest socat data transfer under multiple consecutive
>CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.
>
>The VHOST_RESET_OWNER ioctl itself is implemented in the following
>patch, thus this patch is a preparation to support VHOST_RESET_OWNER.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

