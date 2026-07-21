Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF83FA5D9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646002; cv=none; b=ZMT1aUZfB7lKW8wUJQq9fIAjI1BVEY3zJSoEe8ApAVKnlid+TP6yeiZ3PPEJxoPxUS4idfJ1HmGh/P/eGdCVUGV7STRSMHVEmXs3G5k0/ktgBpBahfYmUKIM9DhF1YWGkDLd7b18c7SljYKU815Ei7w+REWYU8AmMJ55ZX1Do8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646002; c=relaxed/simple;
	bh=TcK76ifJ0Z4VlXfYbMDVybg1ZGOuiCooobYCZs60pk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOLDGU4NbzPD+BB07tGU3giCQk22ggl/Y0BHoy5gDCtPsFgrO/ONOnj3x2nf+aAfHQcl/O2ScLd/R+9tt0aO5jWoYU/GoFarYaB04GwTVV9ZoPbM49dWmYq5nPiqcbW50RrSwe7gjNKnwVt3FOW2/lrlq9gjvD13H/piF0KTNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2aAvV7Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mdMiUoyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2aAvV7Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mdMiUoyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784645999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ceRTbadFpgJqwcQ9MpntM7cuc9uc43skQEIpoL+u/ro=;
	b=c2aAvV7QeMuiwbqfhTqU5hJF/SDwpqWP0GCY4tjZdjSURHwxANZAbMf7c07YtceBfWSPiv
	Q/Y53vLc6O62eFlR04QI1K6BV9UMKv1ucWh2VSO4w0EqDu+P1xkzM3ZTq10dx2bQQOkDVM
	BC6Tn3C2dyqJH5px691P/C+2tKLOdEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-PkShOkkjODeZynhh8kg1rA-1; Tue, 21 Jul 2026 10:59:58 -0400
X-MC-Unique: PkShOkkjODeZynhh8kg1rA-1
X-Mimecast-MFC-AGG-ID: PkShOkkjODeZynhh8kg1rA_1784645997
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so59898045e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784645997; x=1785250797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ceRTbadFpgJqwcQ9MpntM7cuc9uc43skQEIpoL+u/ro=;
        b=mdMiUoyHxPNdwYohE3tulXfHfpt/p74civKcTrj+B35cQ5D+C2QTA6d4yAIoQTzQd8
         C+cWGuEGSYFJG3obBt1CM3TSCChascDQuV2ma2hapjMcqzNvnr5YsChVMy1WnpjtJQNm
         Azf/t+pMkYYDH3MsOcYDFYUK+Q05pPZASgPeb4whQ2gEtHcFcd5Y01hMl5iLLt8Cb1bZ
         I/+S1PsE7DIMyxQqDFM7UySNN0pf92B6enM93Tuz4ltzez+mRk+aPGNjFDXUnRTkWcxb
         x+rjMDLeRIhm6m4ulOmc13k5GLKFNyLbJgJny2YsqxhCPoPj4hKz2lltaW4AAjhZ26AA
         2UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645997; x=1785250797;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ceRTbadFpgJqwcQ9MpntM7cuc9uc43skQEIpoL+u/ro=;
        b=dxE9Ej4P7tpk5XQ45bwJcsci20mucaEbD5v9PRKEzROiwSHgo4tBHr4YGoClmumGAe
         BXAWN7RppVuOLuHVXRUFxjdsbOxsJgL8RuLu1BgVGbIW6zddZXW876b892vdI6N+plbO
         qeAUMHcinlfAoO4Fz4vAZpf8ojFDnjxsBrhGKeB3Vk2hBiVHPFjzdTnEjYrdqpKzMSId
         EqSBEqkdNXhDD0VMKTkOcLSTI+72lEtpIiXnIKrwi1Y3eEX9JGRqTnEqUap39ZSYuLLg
         IYSV8AES/FfwcfZYoqoXfEznozgq4XCbkkmPY+BBrX0xlENr1cK8ojs5/Xp9/9ormAnN
         pWFg==
X-Forwarded-Encrypted: i=1; AHgh+RoCpiF3htS4pz+WZwa6b/OwW/CPi5GGKapcp6Rt/sumuGlY+naBr9Y9A/FVJJGPEFa/tRGjO9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkN0eN6iuaHRnLecXnsfZTQNmv5qSOxYj9mi7tAawBZG+mvRJU
	+ISpnsIw3BiqBhTmsw3aslXfghGzNojDBcohZ+TMWjSyfjLznXZmF6cjXrECONB6D7bIOKp3c26
	n57r/z/QAtMETt5NcolT1uMzOn01J7i3EOgxdK5vHb5z1W52N/wk/IYZ0Mw==
X-Gm-Gg: AfdE7cnKjynNME5DDTVUxvS8a/kUdLfsAYA8fc5K/dsQgs0PO0HwIpzSZ3s4NokVWAP
	nDQ+E3T2SF9s4pEU0UjtwCbPoBgqc/beYhwK4vXDquiwGkLZj8oMNFb1dZ7GDwIoIWBz3ihuTLp
	4q3+1q7apSwMGea9+yQcdPM5nU3V7A3KIfs4p+RegGKmuf7VmmaklFEVyX43OuYzIDAqXO1bytb
	QZepxZ3PUf/dWqlh/dwgCg/yEr1ca4uig+LJfcUNOQOgiKwe2LRuLVxEuqu11cdoTfCXRNPyE1P
	E6fmGP0CtHwGlI446wlzsUV03Pz01LJk64U+0b6H69L64xcfYlD09yOqhmNT3lNfOrmZmeX+oML
	6w++MjsCrOt5qSH8XmRp50w==
X-Received: by 2002:a05:600c:c04c:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-495648fb143mr40821735e9.7.1784645997163;
        Tue, 21 Jul 2026 07:59:57 -0700 (PDT)
X-Received: by 2002:a05:600c:c04c:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-495648fb143mr40821295e9.7.1784645996584;
        Tue, 21 Jul 2026 07:59:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e496afsm41604679f8f.1.2026.07.21.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:59:56 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:59:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <20260721105853-mutt-send-email-mst@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>

On Tue, Jul 21, 2026 at 04:04:33PM +0200, Simon Schippers wrote:
> On 7/14/26 18:50, Simon Schippers wrote:
> > On 7/14/26 15:40, Michael S. Tsirkin wrote:
> >> On Thu, Jul 09, 2026 at 11:55:11AM +0200, Simon Schippers wrote:
> >>> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> >>> when a qdisc is present") did not show a relevant performance regression
> >>> in my testing but on Brett Sheffield's librecast testbed it shows a
> >>> significant performance drop in a IPv6 multicast testcase. The regression
> >>> can be pinpointed when multiple iperf3 TCP threads are sending. For 8
> >>> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
> >>> the reason why this patch makes the qdisc backpressure behavior opt-in.
> >>>
> >>> One option to accomplish the opt-in would be to set the default qdisc to
> >>> noqueue at init. However this may also break userspace as users might
> >>> have chosen a custom qdisc even though most of the qdiscs did nothing
> >>> for tun/tap in the past due to missing backpressure...
> >>>
> >>> This is the reason why in this patch, the flag IFF_BACKPRESSURE is
> >>> introduced instead which is required to enable the backpressure logic.
> >>> This means the stopping logic in tun_net_xmit() and the waking logic in
> >>> __tun_wake_queue() are skipped if the flag is disabled. Setting
> >>> IFF_BACKPRESSURE makes an attached qdisc effective by stopping the queue
> >>> instead of tail-dropping when the internal ring is full.
> >>>
> >>> To avoid a possible stall due to disabling IFF_BACKPRESSURE, the new
> >>> helper tun_force_wake_queue() is implemented. The helper safely wakes the
> >>> respective netdev queue and resets cons_cnt while the consumer_lock and
> >>> the producer_lock of the ring are held. The helper is run in tun_attach()
> >>> when a queue (re)attaches, in tun_set_iff() for attached tfiles, and
> >>> in tun_queue_resize().
> >>>
> >>> The documentation in tuntap.rst is updated accordingly.
> >>>
> >>> Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
> >>> Reported-by: Brett Sheffield <brett@librecast.net>
> >>> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
> >>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>
> >>
> >> The patch itself is fine:
> >>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> What bothers me is the timing: we
> >> are past freeze and this new interface hasn't been tested
> >> much.
> >>
> >> We can either apply this, or revert the original patch for now
> >> and reapply with this for next.
> > 
> > I prefer applying it, but you maintainers must decide that.
> > 
> 
> Hi,
> just a gentle ping.
> Has there been any decision on this patch?
> 
> Thanks!


Hi netdev maintainers. Given there's a perf regression otherwise,
we should either take this or revert the original and reapply
in next.

Thanks!

-- 
MST

