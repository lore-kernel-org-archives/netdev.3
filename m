Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11348B367
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815437; cv=none; b=IKmLouI4b4zZAeHlhwaHKIlbeWC1MESZ+e9Sq4Bd3athmjMWi0ERr159NubWFdyUZSQYwxmLQerXNSswmiOTTbnl1cpQKzBM/BQhlWfYEa0r2AbOTwCHrRQ8rWas3cHyaKCJEujSp6Fh/zk6ZkZrVi2Y2TErQW614Ka6z+5nhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815437; c=relaxed/simple;
	bh=I8p9bOzJeqZgehGIA+FcFwpbNoVWUs1LHPhtCD3/XTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB4DdZOMN7+9tb4v8JHG+AlhmmUuEKODyEFh6DvfaXhVvtR7bCa+JmB8bZ15LpVBoAdQyzWr/fSSu781PHU0jq9Wxaef3Wy+q+HTSoUOCTxapw0lMsP9h2kmEIhup3M7ecbSI49YySIEpgT7ta7RsK4LsJKOu0+nU5MZ9T7KriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ali+vb6f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO/3tv16; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ali+vb6f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO/3tv16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
	b=Ali+vb6fo+EjqIRgx/QkSh2GZxRhKerHb8WDQz9rXM8pTeHyYhCBwaWhiWFOQO6iQjtVjh
	3hq0GtTH0SkEVORujh6TLXrt50rl1mhL4rkBOOSxBTw68ewfFu+3Rdkn7LFoaSfeRLKt55
	8kKLBLDc6tFTDMCqxVKHr0qGsGOkuUQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-_TlfHsa2MRKmncOkoQ_Igw-1; Thu, 23 Jul 2026 10:03:53 -0400
X-MC-Unique: _TlfHsa2MRKmncOkoQ_Igw-1
X-Mimecast-MFC-AGG-ID: _TlfHsa2MRKmncOkoQ_Igw_1784815432
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so719028f8f.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815432; x=1785420232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
        b=KO/3tv16pfFv5pQu1rjWAhgDLfnh13UEIs0/ZPH28PISxmBk0Y4bHuMS2adBzpkXL7
         vJw6N8DzR/yqygZu11FdQ3n+orEGG1IZUyuV9n6voCQI6tE1KG+G2abhatFQB2KlHFeD
         LjUVrunQroba4qukRL0Ujh7xlAnhX/VuF9QzrGXwOLuLhcHSmoP9QW5vB8+S43rjZgHQ
         PzSedtO0x7piZNSbuG0b1tRD+SBUYWzIZvzxXcOSEHyez28UFhJVKU3PQJgucTq6stDj
         jx7R8+wHsaffaejbM2kt9/Sphr+VdTMV3iVRcYP5IIPZXtEllMG3tIG+IZruZrBia+ie
         gsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815432; x=1785420232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRQoiSZqQYWhmB4hOxbp1x8OExK8dTCSnSeELl0NdnA=;
        b=lNeddtWJpmKhCq/X2X06VBDOpSzrJrPU8vnKtx9zZbW/075D1CEIIPef9cdqBEyBWA
         GRdWjHjYmrLnahp+/S2Q2cCqhVROI7PRecgDC9nXiORkGIv4zprZt4MBYL34aTGj2iw2
         0tqsIht7lRxgGc0Lpuw4wrZV1WYWZuQU5mCIGlS6S+O2IhxoYv05vNfoHlB9n/40wD7h
         qhPhxX8hLX3nf2TK3ZJp2vfjDnWBBK7RnsNsYb+zGckjghSd5ma3MKFEovUk11FmaM+o
         /mbFgiYotqahOoHQsA90X8VgPIiTP40TYXzlh7AjNEuBqD6mMF4ZelNQr5Q1l8eQNUgp
         +WbA==
X-Forwarded-Encrypted: i=1; AHgh+RoTgsN/aMLbzt74S0XrHF/Lh3mw0nUyod7FXOnzP0Isdg5WvTxoh9STuSnUqjOsrA/UUV0a+6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuofwldVXMX5SGk0ygia0tcuJMqzOCxOTueXt0rqbP2eR4qER
	T4Iba92mkENfUaep3lOJEcsiFjSivRa0LbFsveU8y1BRz5jL5LdI1gLaYMjowyU5JJwdNW1TQn2
	yALqcgCrALXuKlNMQbty7h5i1EPvPCFKDFIZWWqulImcFMgKmGh4/9tXutQ==
X-Gm-Gg: AR+sD12k/b5yhSyhTPDuznGm104+3BZ1ociLR06hoQ3Lk4yKjqpbZevUlGKQFVnd+Co
	1J5Gt9Lim37SKZ2145AnfmwCjNWW9EtWuUuW71WsRz9wo48/XDPi/UL+/mtTdYHjY+rwvN2e7dv
	tjxzOjewB+FoDCKrmwLrSJbS86aP3P+iolnxv+WDSrzqoTcJMWNkGlvpn+8LhIhajGFUGwQ6/a7
	TF1Ord24F/XHv8q8LeKcGOYs+JsIsDhDSEtphgim2rY5WT1Bp2upGo3acWRzBiUPI6+syYFpuEb
	OhuZiwbuaDCIAGRDRMGOZkIw+/vtpdjIW+dR7Sha9sLN6yq5HYmx1t+3KUJhDmoktF5M8PwUYdc
	dJNmr/fpnGieGyQChKoLgLyjwSSCCCeejP4FjYOv3Bgit7xkxig==
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26176f8f.43.1784815431641;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4029:b0:47f:9464:86c2 with SMTP id ffacd0b85a97d-47f94648782mr26074f8f.43.1784815431081;
        Thu, 23 Jul 2026 07:03:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm15087177f8f.11.2026.07.23.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:03:50 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:03:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amIfNOLGeKubXu-2@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>vq->worker and queues work on it.  vhost_workers_free() however clears
>the vq->worker pointers and immediately frees the workers, without
>waiting for a grace period.  A caller that fetched the worker right
>before the pointer was cleared can therefore still be queueing work on
>it while it is freed.  And even when the queueing itself wins the race,
>the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>future attempts to queue it are silently skipped.
>
>None of the current callers can actually hit this: net and scsi stop
>their virtqueues before the workers are freed, and vsock unhashes the
>device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>in vhost-vsock keeps the device hashed while its workers are freed, so
>the lockless send/cancel paths become able to race with the teardown.
>
>Fix this by clearing the vq->worker pointers, waiting for a grace
>period, and then flushing the workers so any work the last readers
>queued runs before the workers are freed.
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

