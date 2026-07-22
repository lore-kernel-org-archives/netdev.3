Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12E3E9F9D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713443; cv=none; b=sEvMM3ikErzgnGjLvkgXCK8zCwqLsF1flWKrbqAGYp+8rgLEwaqJNfGwo9j/3H04fd3IAQW+9UWPhTuPewQaq6/0V4UeH0uxRmri7jywxB12kX2XKiiv5hrnyqx0c7zR9NTz3HgMhO7EXCqITM7OFO0wzixmJ0JsS0LKcFr9fvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713443; c=relaxed/simple;
	bh=lOwARzZKfPn8sQ+Z5RWIh2PjsWgxiRWHG5/38qBJEHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW/uwzLFQhUvwCc1NpTYyw0lyciEx7TFHl+10UPDi3gNt6Ahvm75lo10wGg7rkf23xcNmiUvblp6EE09ffVIuS1XYnalOFOOkZIDWvmWS9UYfXM5ZcBTTLb75pNXFbHNQYMX+PkNnvbuL/x1G/Xy/FyoN0VKwydREFE6CYYUkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PA92zjp7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lUaSeldw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PA92zjp7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lUaSeldw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784713440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
	b=PA92zjp7tfXYn3OdxQeD79emewlOpO0PD9NEdqlVOKY/e3nfiTskiplcxvQaiwy4A6+lqk
	VuqxT04ukf84UVLsOo2tSmvy8Q2pmtngwa+L/ngvJcfb42M0rwSCiW031Hc6b2n4yLhCEi
	wKVc+BFG++MYQVDhQEN8OvsedivYUPs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-WyMzTIWGO_6BqYL9FwJKUg-1; Wed, 22 Jul 2026 05:43:59 -0400
X-MC-Unique: WyMzTIWGO_6BqYL9FwJKUg-1
X-Mimecast-MFC-AGG-ID: WyMzTIWGO_6BqYL9FwJKUg_1784713438
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49560dddaa4so15314695e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784713438; x=1785318238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
        b=lUaSeldwe+nk3/7oJfPwFP1RUotiGuEBl2au7YaJ/wB5fAcRK6i8JlGzMd9TifetEt
         1fDYb5bIKVQkHPe86k2QHbjZoqiTegLaCWFDBygQJspP35SuuW6ZF0nWhzFTSTWXEwk/
         6l+23ZxbAWQSJNpE4NLN+z6AeewRHUMMUUWoHD8l4/+rkKicOzn+Q6toQ3MqapyeMUMI
         GKJZljx/1Q8lJWqQVJ+OVbRtVV8FSyOI9rTOENnBqitSR0EP2HEHk/8AJ4DOca86ImQJ
         Xhe41bFiJcPXm4QkoYdT/fVAyJxedMZ7G2Aa6acKNTlX2t+pcX5Rlo/a1H3xisnSQurH
         /0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713438; x=1785318238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
        b=B+4PMB5qsrey7g+JobFdTI0/BGGCyIgBW0Oxk7kgHmQanxxFf1/HxmxJeuJJzT1U7I
         nyK4L6oiIXR1t0DJJyQlotiMS71zeh+aPU5CAmwbNq8QFD/HpOyg2XaQGWa89lpGMhDk
         VOEWRK87AiCXPmsfxRztBbABm6esCWkK+oqUNdSOgO0WyAsOxv0W0721psdPSzi0FErg
         dDye0P5VG7dKNGrYOVLt1HjCTYLXCJpawzWcW640hGE7TPdiyONI9ohAa/wAmVPiDVKT
         Sk4JwYAPiEzUzDDQW+sa+hGl3HFyhQhdnmka0tQhGg726u7d60xTpTf46vrFXUlqky5R
         499A==
X-Forwarded-Encrypted: i=1; AHgh+RrPAVArCsABvpGzB6ke9rjJn7x5UZEgQTZn8RMKnKarTgdbqWsylCp7UfN48Zs9DwfQ8PX3a+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjollI2SBW/PZy4+kRrO54+fqGtf4ltE/zZBp3zHWIh/mSmxHb
	zPshRHXuV83MVEmpBXJtT5rzpx4YVLZTpxsiQ2vVW3mQmqJ47sMph6P0zdt/xMdilaVe3mlw6n3
	0VjxBGkIpDtYTv01kR2+9L5K0+9S6Lb/1xstUA9fThmASVcVX8Zqu7BMDKw==
X-Gm-Gg: AR+sD11ijLJwh0aos/Fp2qGCp7qyv3UqCE+DUXInK4L0ndX6Mz5jUDq7XfymAoFiIHL
	SnRd0L/mON72KqfE2aK/afi0UEDoV38fUIjJDJYRG1jj4/9PrThuQZKHzx4ernxKPQgJ9YtEwog
	VBTlQ+5NTvPxH2Xp3EZMzF9cAbOdZXNPH/WQiapTYtY2zn46U+vk4C1WTVUva7CsXFyOssrJYP4
	NvHFfaQD72mwWLEy71oFwrmT88qoSHImKGQOmfJ+C/OpLSlTLMlxEagQEvWe4VAy0UNfzAMjPBG
	zoLYaYeCkZFoz1+41IDt58II4jedRRGrSDIZ4JeUEDzqn4fwfo5sTfoofUwCIN2osTFDJ/TjISs
	29tWn8nepSEqQBgLHMI64nAKAA2f3hJpSpun8QWh8bl+2bP9d4g==
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160695e9.14.1784713438316;
        Wed, 22 Jul 2026 02:43:58 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160315e9.14.1784713437719;
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c6besm124593995e9.8.2026.07.22.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:43:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amCQyzvUwdy9KLzj@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:41PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>To that end, unlike the release path, RESET_OWNER keeps the guest CID
>hashed: established connections survive, and host sends issued while
>the device is between owners simply stay on send_pkt_queue until the
>next device start drains them.
>
>Since the device stays reachable through the CID hash, the lockless
>send/cancel paths can race with the worker teardown in
>vhost_workers_free().  The previous commit ("vhost: synchronize with
>RCU readers when freeing workers") makes that safe.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

