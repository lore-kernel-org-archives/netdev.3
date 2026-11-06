Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975963;
	b=s41rof1J/tb1NZcBgXlwrADiabURAXtnxPacokKakOedIAf5Nhie8G0AJpe6/cAE4B8A
	 8nl9Cfni/nsggtpMRpXcbaasdfrh7jljH3XAPmKdZUCHjsI0DpyJKYTxNYE0DqBWAVI7i
	 fNuPRiwHVGS9cewFplvKfwEouLQNNbpiZ592tNmzEHfFvS8DlG/qFHgyskEK8NSrjgHEh
	 g7JJdA06qyfl6mZGAgYAywB3ElCI2ARi9riZGMOvrM2U7euAysv1K4q/fVHSSRgwgVZ2L
	 fAnKFboIjbQPzo53aaT8G7bLQQ6+sJo6eZ3tZa1KFRX9aVBjv6uqoVEC5gRqCN0GZvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975963;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=sFLntvw1yNxD2UCRFRwpmhAqVMfigYu+mWSctU6ySF2LTRn2l5WDO33h6X9Lfma+SRZq
	 6DmgV6a55URNmRPL8Y+JVrfG4j1xlVdUhfM1ImVv9kRlt/soFkGOpmaMvi8B34CoYfrGI
	 dI+rcfo/gAEsPeyqvixyagh7bA3bjDWglNnNOKLBKPQwXTTeJK03GHpiHchBQgXhoQYhF
	 dyJizPYggHGItqVE/AZpbq1zblSF+nPZaaBJBDQ+AY/7cRL32mvF3a4+lfLPeLS5avaAA
	 M105wUi34+sl356aVpHPB5P7GpW/qONlcWZrA8oa8i9bBTlcWkx1RumEBq0RMwEYwSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LoPcaZ2V;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="fAM6/AAk";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5D606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 14:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC5D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LoPcaZ2V;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fAM6/AAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793975961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
	b=LoPcaZ2VXGIAu5ude8m/HeAv2AXC2qLPOXLK/+aSVZ2B+WXqfcCFzr1udS7ipv6C9hlU0u
	fYw014L8Uk4yzlGQH1Q1FeluVcmVrZS1vPy2vwZFJ7UaI3fAjvFNOvudHa3lBLMNcwKV1o
	vpvMn2ovzPUd8UJmqFFBQdI9TNjVcrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-GoeQrswVNuqjHcyTJ97Quw-1; Fri, 06 Nov 2026 09:39:19 -0500
X-MC-Unique: GoeQrswVNuqjHcyTJ97Quw-1
X-Mimecast-MFC-AGG-ID: GoeQrswVNuqjHcyTJ97Quw_1793975958
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4901562b819so794259f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793975958; x=1794580758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
        b=fAM6/AAkZexi9ShT4PKSlVPSFrda+suPwTL5oZMjGDK2hGpPJqgPhlNRy+RYpqjkWf
         2JMG4IMJl2M34C7L+thWdoURU0kuca/K0IMjZjFfojQT/a6pFbyX1N9e3RnoJBusoB7Z
         4taG5137kJT944e02AtliUekeg5HaJ35thqj769B8rtEN48zv+io8HuVV4XNq/K2CQhE
         YP2VXsnMhq4HWxMdmwfFEkKQLJcWGXoktxmXYwTQLbsfHInpUhQmv2P/Lse9pSAfgr7A
         04i2/9jlTNS6LJlIdG1S9VvJMWEUTLA5VDg0VDhUs6UrhtJNJiRaA+t+SiiOfd9gPS22
         lzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975958; x=1794580758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NLwtf7QYxfGCOsBeRSPlOa0BaKLAPm2183RpOle/E0=;
        b=CCIcFueQY5LxGiCLsFzBFWnkHXsFCLOZnKlHQ+58Tnw5eF2DmOucXlShoU3by0RanP
         E3lwZKCfmZRqUJRfE+1sFJXmquR/HwYEVah7LhlF2McN15zh7yL4l4NlVY/yzNU8xr1V
         VKKHvC4lNrPQxs2FxFC1ARRu5QiDb14fYQltKre1Cvy+HV+/+U2i6JfiEcFXukZe9ENS
         MgGklTqK9mUgUJGv7wqIx5Jy5420fkmrila73oi9qeRItd/f+xA9a2KHe7N04WKPgfiz
         SfhabniGRP/AiReOGz2byWGIr8tOepNm409GARK38njM0j08K5xQFjceAqbsFrFwdZZ6
         kdpQ==
X-Forwarded-Encrypted: i=1; AL+hErFSfy5KeRSYAQ1aoXGz4/Zlo7JpJL80pH4aPfGBkrOqUdCau83rEhjsJORF4KT+96SKhtr9uiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dSxk7emKAelCouQKPT8T3dAVEPoJdeozvu0ETm1isO0R8rj73
	z+t+HEyh0jnxRwbu2j5Wjn/L3bBC/wHobcMaaLDBM8pObqhjVNTWZF9zCKEFvdUUIA3/SuaWhHv
	yadWMA+7yHZKGIbxxk7YYeAUVdIeMCQynjxG3AIMEPHzBaSH1pkbKqSAfXA==
X-Gm-Gg: AYBFou0XxQUCXIE86ewNUfByfHISYKa9MbKocPbXoesBYEWDz1dsuxNJVqNS6px9CHZ
	E2wrIbJoX6WRhkGiWFDAumlyrOnuUdx4cp+e5Tf34GNhhhDPX5+wPA4y0uHKf9aUsM7qod2Yepk
	EiCzSK2IgGXDVOKERY2ixrVMJrqQpOy3Mi5DaXzl8HPmyj2mSe0M1apFF0aeFkL5ppy6/IScd6k
	pjLGiq7hl2BN5JlrZo5oelJrKSvuHBdpK/E6c1dMv8K4Yg50zBJRZYADo9fO7R2TN0Cv1gMw9xH
	+C4Pfbsvl/I21XCUTanjtxm9AATvK6JICTPcWqvVFP5bLKeU14tCYTKzgUFBBcByq1KAm4wokpI
	2h5VA20V2ZL0YH542MsD4IiOp8cnT50qxgswisWPORqoqyBkaGCX5
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363047f8f.57.1793975958185;
        Fri, 06 Nov 2026 06:39:18 -0800 (PST)
X-Received: by 2002:a05:6000:26cc:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-4927817451amr5363018f8f.57.1793975957758;
        Fri, 06 Nov 2026 06:39:17 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ad7sm4518709f8f.15.2026.11.06.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:15 -0800 (PST)
Date: Fri, 6 Nov 2026 15:39:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Simon Horman <horms@kernel.org>, Luigi Leonardi <leonardi@redhat.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3k0TggFXTn6usw@sgarzare-redhat>
References: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>

On Fri, Nov 06, 2026 at 01:39:18PM +0100, Andrea Parri wrote:
>The Hyper-V transport is assigned before the asynchronous VMBus channel
>offer completes.  Its zero-initialized hvsock therefore has a NULL chan
>until hvs_open_connection() associates the channel with the socket.
>
>SIOCINQ can query the assigned transport while the socket is connecting,
>or after connect() fails once the transport has been assigned.  Unlike
>poll(), that path does not check stream_is_active() before calling the
>transport's stream_has_data callback.  hvs_stream_has_data() then 
>passes
>the NULL channel to hvs_channel_readable_payload(), and any user in the
>guest can trigger an oops:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000178
>  RIP: 0010:hvs_stream_has_data+0x23/0x120
>  Call Trace:
>   <TASK>
>   ? vsock_ioctl+0x74/0xf0
>   sock_do_ioctl+0x42/0xf0
>   sock_ioctl+0x27d/0x310
>   do_vfs_ioctl+0x700/0x810
>   __x64_sys_ioctl+0x7d/0xf0
>
>Return zero unread bytes when no channel is available, before accessing
>the receive state or ring.  Leave the existing channel-backed receive
>handling unchanged.
>
>The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
>guest with a small user-space program, available on request.  With this
>patch, the program reports zero unread bytes and the kernel logs nothing.
>Other vsock_test cases were not run, as most of them need a host-side
>peer.
>
>AI assistance was used to identify the issue and develop the fix.
>
>Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
>An alternative is to check stream_is_active() in vsock_do_ioctl(), as
>vsock_poll() does.  That would also change SIOCINQ on VMCI sockets that
>are not connected yet, from -ENOENT to 0.  I kept this fix in hv_sock to
>limit it to the crash, and can send the generic check separately for
>net-next.

Yeah, I was going to suggest the same, but I agree that for net this is 
a better and self contained fix:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>The reproducer is a new vsock_test case.  I have not posted it, as
>Documentation/process/security-bugs.rst asks for reproducers of bugs
>found with AI assistance.  I can send it privately, and will post it
>once this fix is merged.

Yes please, post it upstream when merged.

Thanks,
Stefano

