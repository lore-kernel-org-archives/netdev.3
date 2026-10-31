Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470548;
	b=WY7H/tAAM1T368SnilofT4A+KPNxazU3o6WRqndkiR7Kz3bfZjWoBpYchVKlSPIu8eNX
	 Y9+1FI+NCEwK2ZyayJ4tFqbhBFmGhv4n0ImJfcY2kd95fIdnFnufvcEngTwFjXsq+aq5G
	 bRUW+S88K6kHtHbGB3zqohJRy9Zm+AQhJjg2d1rY5GZ5rGBCwajyh1CtSUJ8eJ3EEQm0O
	 OBmlWmWsDQrYAuAU508JxPMbHCgK0evr3TN1QgEzEyAKXMe6ux8dzNvj2IZA11GSA+K9u
	 pOMjpiSMSX+WaeDbsZGtDXvNH8vnFV4SqT9rMxnHXZXmIARdF6iLe4vxRbDeijOQWdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470548;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=o56qUFLoId5H0ajPuV+6j0Jri+sA2MWgBwL7BZ4vTWAJOHXQArLSE5rCOOmiZP2Z5lrB
	 WcPgm1fccI7ukT5uXWvTloT3eRNoO82muIT7/MeM75pB9iyc1aINxEdCVyMaQQVoO+Hk0
	 AwFThtoynT4KdRyKa2P8x8m8nnkq//1x7OupCDTC52w8CR0Kpj2vNCO4gjPrZvUA+khKT
	 zxb1TlTrT02vJiDEyLfuGTocvM9al3XukBzQ+eoQUqL5N3fd+jGsQBsHs8S/yms1W+vRK
	 V0uhRPirXntmfXlF0knPyrkmhdCiHWl6IVQAsp/S2nCYifH0MSBfvpik+cWZtv2pSaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="H/fq+Ykn";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C9E606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 18:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIAM12Ao;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=H/fq+Ykn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793470547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
	b=SIAM12AolSq6pTkL141wKgFIS/iF3deL2c3a2tQ5ExQ7nw2lBKmzMbRv7ikb1UZ3CWPo7y
	nApaKKJLMKYkLGv/xEKs8mdJXUqEdhuoajglzgiVVF2f9x+NrBzacxbDuagmB+WOyh66RI
	pqwr577MZwTtT2Nioe6QlS0Az3luPJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-TWofj25eMkqIhIJCaSLf4Q-1; Sat, 31 Oct 2026 14:15:46 -0400
X-MC-Unique: TWofj25eMkqIhIJCaSLf4Q-1
X-Mimecast-MFC-AGG-ID: TWofj25eMkqIhIJCaSLf4Q_1793470545
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso15812065e9.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793470545; x=1794075345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
        b=H/fq+Ykn4OXvibmZ58WSymPH6UkvtK1toNLmfG9r7MHqEuGHzGt0A9ihKTFdMqNtlk
         YDRv1FERKM2oU5FWRr17AhGkbTcViLFILRYTnz2NxuUJqpnvbBL5Pfzm3nxluOBozULg
         IzVt9RaX6KRRqmvWhNmfGrnDYzRlSs6MrU9VyeEweL91zR0TZByaJQiPILB1r7e5TdKc
         7KRPrCNbJPgCi0Ng0pxNBh0v7VU4PcwyTnKM6KmVOsCj5/2gcQyENkZWptsRZhv2QVt9
         WK7nYhlkE6QQcUslLMMBUCcTfFltq8wTNPC98Ak2pfkh5B7aS+BS1XYMZHje1/Nw2rQ+
         Q9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470545; x=1794075345;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eec5Aouc9wFIQO+NM0GHrs+3vbQHhqX9lnMdXV8EI1A=;
        b=QXb+wUfjH/kgpCGhCatbtgf7mkEMf9rBKiv++PbphvS50q6rZRnuhuGG2Cd3ehwd1f
         Bm+WbTw73IAAhw86j55/ilZEgksAsHiHTJwEHlr0Q+MneKK1bm0KUBxDhWD6/EDEvilR
         C67C7OnZEnzN2UoMlFWqyMkUA16ZvlgjBpQPHHY8TfraWfrg19gkZQCQYn36eRxiSXJX
         yyKVuKE/5zb/+NGsVLH31E7bHl49T1hiZZS/qQiWKPqEt2T0U2zW8TXKip6Y5YYC/Rxu
         1q9jPrh/Ia+FAKnRlrS+K2LJnhsPNWPZlIxhpTsw0GrVPDAW8MvTnBr1wXTT/4eA/lIv
         81NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwelTT5VvEfQ9BN0SSFEwMkydyFmq32OD15ARD5U6F2/sxJOTlQXLgNQxpKxo7CRLQzZGjtAes=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIaFHC9Ewki+OLtDBrubNF2Dhut/M5j0E5Eyb7ZMWM5JbbaKa1
	zqrhZaSscWlEsoenbgtCBlMcdrKcx1Lzp9Uw2fIN/VyP3vHllex/5T4tJ6BcgEgDpXFDs/bcyVB
	B2WWu1LwrH61hzDwIPicAQacAj589NVkp11CuxhLEYXcPR+mXmVKYq67B7A==
X-Gm-Gg: AYBFou3xvabF4UB7tLcTRSFpzMzuJpvRNPtqGhWYNlCIj+mRFub71pQddIT45JHHjNS
	WehIB4KUGOI5ReFjanU7B59aGNXdxycv3rQ5wgkJOin1uGcmqOyS7ITfqupbpmk/v0KWobbEuCq
	5Ezq/SHnSYDgcc9w8o2x6a82WNyGDoXz+S1RuVfqockfWhg8Z7grjbOQeFvL3l1JS3Ujvf9y8Qi
	ahrN/bJ3YNps2tZNtYiS/v8iwMoWYOMUgwIJ/Hb2ZWVi1LodmSAVR1fHFmnxbYl42LOsZ/BzQgm
	QL3WDciCV8/3U1Ma1OOI/cLaxKBOa7FefQXggjgAvXdhKqlfAjrSzakZ4lxWEN1NJt5sbX3KDvZ
	lrQEkMHiA4LABzPFPcIbCBHFv//kFiSRyqohF0gjbhNON
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127328065e9.28.1793470544466;
        Sat, 31 Oct 2026 11:15:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4ac17d19777mr127327715e9.28.1793470543790;
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abeb77af8csm210425925e9.1.2026.10.31.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:15:43 -0700 (PDT)
Date: Sat, 31 Oct 2026 14:15:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	linux-mmc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost_task: do the return-to-userspace work between work
 items
Message-ID: <20261031141506-mutt-send-email-mst@kernel.org>
References: <20261031181004.4193627-1-shakeel.butt@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031181004.4193627-1-shakeel.butt@linux.dev>

On Sat, Oct 31, 2026 at 11:10:04AM -0700, Shakeel Butt wrote:
> A vhost task is a user worker: a thread of a user process that runs only
> kernel code. It never returns to userspace, so it never runs the work
> that is queued for the way back. resume_user_mode_work() does that work
> when TIF_NOTIFY_RESUME is set. For a vhost task this means:
> 
> - memory.high is handled at the wrong time. When a charge goes over
>   memory.high, the task counts the pages, and should reclaim, and sleep
>   if needed, on its way back to userspace. A vhost task only reclaims
>   when more than a batch of pages has built up and the charge can block.
>   Then it reclaims and sleeps in the middle of the charge, maybe while
>   it holds a lock. vhost-scsi, for example, can fault in guest memory
>   while it holds vq->mutex. If the charges can't block, nothing is done
>   at all, and the count keeps growing.
> 
> - Block cgroup throttling never runs. blkcg_schedule_throttle() asks for
>   it, but only resume_user_mode_work() acts on it.
> 
> - Task work queued with TWA_RESUME, like a deferred fput() or a NUMA
>   balancing scan, waits until the task gets a signal or exits.
> 
> io_uring workers had the same problem, and io_run_task_work() calls
> resume_user_mode_work() for them. Do the same in vhost_task_fn(): if
> TIF_NOTIFY_RESUME is set, call resume_user_mode_work() at the top of the
> loop. That is between work items, no locks are held there, and the task
> is running. Passing a NULL regs is fine, io_uring and KVM already do it.
> 
> This covers every user of vhost_task_create(): the vhost workers and
> KVM's NX huge page recovery thread.
> 
> Tested in a VM with a version of tools/virtio/vhost_net_test that puts
> each RX buffer on a new page, so the vhost worker faults in, and
> charges, 256M while its cgroup has memory.high=64M. Before, all 285
> calls to __mem_cgroup_handle_over_high() came from try_charge_memcg(),
> inside handle_rx() with vq->mutex held. After, all 589 came from
> vhost_task_fn(). memory.peak stayed at 64M, and the run took about the
> same time (0.66s before, 0.67s after). A lockdep kernel showed no
> warnings.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Is this different from:

Message-ID: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>


> ---
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a5992..f0ab21aa2a1c 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -7,6 +7,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
>  #include <linux/sched/signal.h>
> +#include <linux/resume_user_mode.h>
>  
>  enum vhost_task_flags {
>  	VHOST_TASK_FLAGS_STOP,
> @@ -38,6 +39,14 @@ static int vhost_task_fn(void *data)
>  				break;
>  		}
>  
> +		/*
> +		 * A vhost task never returns to userspace. Do the work that
> +		 * would run on the way back, like memory.high reclaim, here
> +		 * between work items, while no locks are held.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		/* mb paired w/ vhost_task_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -- 
> 2.53.0-Meta

