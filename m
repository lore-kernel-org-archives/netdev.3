Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657392;
	b=X9D9iP7pCZbGkorFsxam847+p4gwzi1f0RxgkauW8Co8G1PYGiK6dq8Uhhzgg/HbjFvX
	 4X9o3DO+ClfgDIV/T+WbBXiHS40Kcjlfamp2hCX2D6GQWxoK1TAKNs5lFPBdKjZPmrYGp
	 FZ20I00xWZTtq5H32nzHd2m8AYjEySy8Ghw0iDYq+pgYrBrLD9HtCJ4PKUSicP/CAEYz9
	 EI1lPKxp7ACXApCJ2oySLBw120Y9dSYv+QOJ+EGQ0RCIkc14gLepgZz/arvi7q2Xdap7U
	 lNX7SXMOu3oWq1w3pkRy5Dc8xhweWziSO9MXcrpvHBOkLf/pFEdZii4Jk3GN/iQRjig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657392;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=4v1BbxP+0/cYZNfnS44GIpDmeplQleUD1cz85eQ8CTqpLAba5zO/L0YCzLYNLt1DznXD
	 H3Bp2CTW3N6CTTVJfsRWNu11SUJ0V8CMCoTo9/aOG4vwQhkRk6zC5HQ3pzfZso73PXZEM
	 vx2Pv9ErC+b/xGue/4DE3/doeG4FubJZweEL71dyR6qpeN/2lZuXYeNnAz89vLeY1wlQw
	 fwIBfaHi++PkOJRwBZDHIVVs+uJbIMyPBAfUbM7N3pq3QxS5m+PCsQmsruKzkyhouY3Y3
	 jmN+TpcIM6JL0z9DyUgl4me0JlxHvRzbWJOR+fyFe7er1elFPeT4mtXVrc0hqpo2E6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Zi9t3Ta/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUSZFVg5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F2606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38F2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zi9t3Ta/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sUSZFVg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793657390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
	b=Zi9t3Ta/286WYIuLbICG4S12UU1PeptyJp4kgXuA/K/8tkb8Qcvq7HFxF+dDQEoBkKY+cP
	W2nlhuX5Uv6knB3ng9T/z/jQ3V6C5HKFCfgZnow9CO/yKBh7GjvPX09CjamIgDC7baZk9f
	kP7PWJOS1C/tVLJ/vz53+ILU4GGmhC0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-C7DIySO0O9eZPqVNmNf33Q-1; Mon, 02 Nov 2026 17:09:49 -0500
X-MC-Unique: C7DIySO0O9eZPqVNmNf33Q-1
X-Mimecast-MFC-AGG-ID: C7DIySO0O9eZPqVNmNf33Q_1793657388
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso10077195e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793657388; x=1794262188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
        b=sUSZFVg5XUl3+rzviIOSe7vTCts9mrw2efAzO2c1SB6fCaIPsBYTUxrAbJMwNLXhoD
         7IVDn/jAQtzEESqMgQgr7EGcvbipwUN08vNkHdvWutKHp1Tye9o7hE/DKvhmUb3I9c3S
         cuw7//8lX77Fx0sL2hFWa1SgmsJ1JZ42uu5Tcxz3ye6fLN/SoF197Se2JIrx5yxbMfNM
         9gNL3dfWma5mLoBgGfBMDukK1uqs4cbdcasvtp1TPaxTXwn9cR5B/XyShzAyiwStt3Yv
         4m8whjhW8uYXKNp96oZ/LsUYEJ/Pd2fJH+JXlJ+tcd6pPhB+HW3ONxnYNtIuPpAqvVrP
         8Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657388; x=1794262188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bwPKqX3Gv7tWV58tpYeJSVI3i/HRCmm3Zim49VKIWM=;
        b=zsTTlOD7VKuErmCGe7SaNQG1QyiGJZPtboTzI8jd9qf1WxD5N/xCqEmFun0SHo58Qs
         VjFf73KK6ECu62x49Q8MROAQuE08+dR+W6d2G8yBNjuupTSKIMq7mOqPYjW8BvQvhWCB
         ck8+FgfNfjKo4gXZyQSdTuCso8UymMlEzdidCJHSysTpoDdQA7L3x8LkvWAOE/9xoliq
         sqsy/QT1JMbgz82oDC6eB71g/TDfNux1lTAFafHaG59YiWBUhuqO8smHgmHZUBEGJJXY
         qZH5rhm9nbS2o0w181HkJN6nbor5VDfg9qRlMRYS7sFu9/Hu2I8r6T/4sq8buDT/JY9D
         iofw==
X-Forwarded-Encrypted: i=1; AKwUvBwdJjFuzVLJOYNqpBD/CobfH+To4t6JDqlQjvACE9ajKMS6EUvjsl8hiu2wfLTY9Sc9n85MXS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCBxqwuMHA4ubJCGg/pi9/7xYFxCZKxBdqYOqzOEuEV9yxYqAW
	WddSIoaLlvilLo7eObXiR5yWMm0xV5SHsei4RsqD5QwB4N/WI4J71sHzsLWwQWUmNfz8yWEC53Y
	V7FiNp6C9wrS9/qQczAooiuwga78SiIttrMhv+UBk22sGijlA09V64fjJLg==
X-Gm-Gg: AYBFou0nuH3PT905tQ3vdr+UE2yzKSbZT1/mR69aue1zCXUO5oOJUM+dHTNNUNtXVAF
	9p1qH/SDzTJno5gNbTOCxLbvYxFsTsTsxV0AAnzvFSFnpxZbM4om2xfgtl36SxRc1gFwSqEyGRZ
	TE8WtMNUrbq46drsD4orz48/uk2dQ9Jk/omxw2L96pw+QB05ZzCGcFbOX0Qo0ldKKthN2AGgQj/
	1w7vvqrAaWw1t82arjbOKh1dpRFfQI5nyTySbTKO5tK99O88//vkYMh7P/2/8F6lqfYFJH8mZ/d
	06ZJ1EKXnZMAyN7nVo4sV6GrMKXrkkPWMy7g6rEfLo9fQgOyWRoQvvP777sm+TcOaWAe/lvy0tO
	Rt/uKV8y5CxcxyUZLm74N/CKhophZXp3yw+FBqaosCQ==
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265865885e9.3.1793657388268;
        Mon, 02 Nov 2026 14:09:48 -0800 (PST)
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr265865565e9.3.1793657387857;
        Mon, 02 Nov 2026 14:09:47 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm20624049f8f.15.2026.11.02.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:09:46 -0800 (PST)
Date: Mon, 2 Nov 2026 17:09:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop
Message-ID: <20261102170928-mutt-send-email-mst@kernel.org>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
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
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Oct 31, 2026 at 01:33:13AM +0000, Aamir Ahmed wrote:
> Since commit e1fad12dcb66 ("sched/fair: Switch to task based throttle
> model"), a throttled task is only dequeued when TWA_RESUME task_work
> runs on its way back to user mode.
> 
> vhost workers never return to user mode, and vhost_task_fn() only runs
> task_work via get_signal() when a signal is pending. A busy vhost worker
> therefore ignores its cgroup's cpu.max, while its runtime is still
> charged to the group, throttling the group's other tasks (typically the
> VM's vCPUs) harder.
> 
> Run pending notify-resume work at the top of the worker loop, as io-wq
> does in io_run_task_work(). Commit 12013e3d4695 ("KVM: powerpc: Use
> generic xfer to guest work function") fixed the same problem for KVM.
> 
> Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
> Cc: stable@vger.kernel.org # 6.18+
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Could you pls respond to Sashiko's review?

> ---
> Tested on x86_64 with a vhost_task-based reproducer: in a 0.2-CPU cgroup
> a busy worker drops from 100% to 19% of a CPU. Reproducer available on
> request.
> 
>  kernel/vhost_task.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a599..7fa96e1b85b 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -6,6 +6,7 @@
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
> +#include <linux/resume_user_mode.h>
>  #include <linux/sched/signal.h>
>  
>  enum vhost_task_flags {
> @@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
>  	for (;;) {
>  		bool did_work;
>  
> +		/*
> +		 * We never return to user mode, so TWA_RESUME task_work (e.g. CFS
> +		 * bandwidth throttling) would otherwise never run. Run it here,
> +		 * where no locks are held, like io-wq workers do.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);
> +
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.43.0

