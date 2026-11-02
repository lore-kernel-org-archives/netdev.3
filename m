Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622142;
	b=ryj52CMbGpli/z9i+9epKokMPEQZUBjVDSvMuYWfWP+2s60mO7HP7pEDcgpO63ulqY7D
	 N5s4shPcK+cJxRBBWW2+VkB4K5c0b7zkq8QGy5BlyQxmLh8j1fsKKPZMopDSpLuD4ndJy
	 2GXyolLyTO6shHcv1SMXctWv0nH2YfXP5wGUQyb67tn4dNkMSQk00hxdztN+TysH9AHxP
	 XCIvLqKkDKr77qQfjqGD1pNkFa5gT/Y4ylITZwEaexAan47DT9rm0xsZmJyAl+dP+DcNV
	 cNOisHM5RFkKds4Y/VeWlyTH82eXGZ4bIZQtRwh/Cxe6Mj2lOEp9HbsHTuB61m9XU/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622142;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yRhonnuWulb9nJUYMN6C0bXSFCYYNiwQsgIOBZqwxCw=;
	b=DP9hjou/50vLxWyGT+1LruUHV5dELyCeXXL39z3ZCRe02AX67l/G4apatgo3UPdEmXrF
	 jiPEHcond9RRmIMPS3fW1INW9A6t/Na6JkMQAzibRvFlMQjb5XLF3HNljql/R64Vkgx24
	 Nrol0TpF6S5xk/vlaHrz9l3BPltWf8yv23nKcW9nKZm5OZM+KH0GKv/TK2Ng0pK7Z7tfa
	 xXuJ8XnlU+6QXrU55ed0EAbhP82jSzcImxExDQz0RxbckxhaJYHDeg0C2FAVGx1qFHJhV
	 lowm67IqIcOwPqgirDrQ3tTWmlTgYvVf0hQOgjF+QXk66uImpYvtJSjQxuByR1OQXWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0Np0AuS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=alL9DQK1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C633606AA2A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C633606AA2A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0Np0AuS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=alL9DQK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793622141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRhonnuWulb9nJUYMN6C0bXSFCYYNiwQsgIOBZqwxCw=;
	b=A0Np0AuSYXSXRp/1iAnrcwUo4QMRgaqP+nTzulzClfYghoL6EOqPbNi7380smQ4jFso7Rv
	0ouXb2yj2hfRmocOyb2j/qVmYs0vyLx2yJDyTG09/NTwpolllUyLTDqHy+rps9lRw3sKMr
	/1AQpnqyzrotNk7e+AN8q6gQTi9poes=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-rdfJ8ex_OZicpe9PK_C1yA-1; Mon, 02 Nov 2026 07:22:20 -0500
X-MC-Unique: rdfJ8ex_OZicpe9PK_C1yA-1
X-Mimecast-MFC-AGG-ID: rdfJ8ex_OZicpe9PK_C1yA_1793622139
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c293e604f0eso309106566b.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793622139; x=1794226939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRhonnuWulb9nJUYMN6C0bXSFCYYNiwQsgIOBZqwxCw=;
        b=alL9DQK1bqOjDwENmXZe+/Hfzl3CUQoNlryIx1GLxQ+Sh+1scRvLWIcbEaEC8PEddQ
         T5qAKh1wwOgKIEuBu4zP+e3WJgp3x125YvsUoz6hwQ90aJkJRwSuKFy9HSthwj9tB/Il
         0sE+C2Fu16qiWhP0fxjFxN+pRCWNzIG+qLEEP6o1spWpw4BXmW2B3afH0KhAIOoyxkUr
         yVcYwqypndEMlsuZOxsf47ZVG79LFs32f5ZZMIQkW06vsbipqL8K7zQW6XjV3WTCLs2O
         zb1jMKkXFg+8R1ovYA7Iwzxes14bFyAEwmkQZRxsaK50P8jf69H9L0Xz85PvhYMhIEpI
         /hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622139; x=1794226939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRhonnuWulb9nJUYMN6C0bXSFCYYNiwQsgIOBZqwxCw=;
        b=omCXXiG5xdXdp6LWK+nzct6YiUSWvRm5lx46aDtS/s1NCzm9Iz/8COS7t1+ZgOnMgd
         JvWMR3oWXsgC6jPPQyuvZAKdxCMmap8WeSfSuniKKX49CezIi8eCX43Enbp3JCpB0Pmd
         A+tQpXg+z9MzNi0ei7HK7xHCh+DPHhCJO4Q1XjNidFeJzXpUHk14zyMJmDAZuq7M2Krg
         Tvn+6KSBrGBIxZIduJGNSfM2Cf3SRE8440aPeuKiYXS2xV7yJJ685qIYLxaK4osffyKb
         4YrICN9JntYx/3+agGKm/rwI7FDtMNWyzeEbdZTzQC9+5R8OoTlY+YJfqcEhX/qiPWcy
         X/QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjcN7ny0rwGxhg5JEDJVTH+BPQ9TuLgSYdrWosnQ3DcDFgJRPAy9ffCC5L2rsP20V/NcYYf9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm/Bd67jWi77+IEweNdM8EpVQowDdCXEOitIXDN2z/7hdEbiws
	ToOvIZCdJ2KaA/CjPo0rUtU++rjuzkdgfW2JjQzO0do+aOw2l6caDHgQUTmLQulveMG3eFFfdL8
	zkwFAcWxOAi00Hmrxsgta6Z/gn4MyiYc65uwR29+mZTg7VII57lhkV/TtWg==
X-Gm-Gg: AYBFou194aWtg8VdkTw/mqRU8mLfzG+1zQEp+I2uPdlGmPGjz1LyjQseKvQx10AKLIy
	zi4gIqO44+in6HmvwiXZL+IEic+tb42sKpJvQHRMtG3PqtKlE65FqT0F2q1E+6uxe/9DnDZAaJo
	HU+tumm3YTu2SLFtjUOf/bda1V/mE0Vha+MSsAISeiMq78rzQouCSHZqjTcTO3vHOACVTDC8o7K
	xEFgTuNHj5T10IjSHMRMJl7ii7FYlo6B6ZxLOeF6sqMvXtbQBpP3CZd9MKDf5AEvOnwPqsPmev3
	CTcV+39lG3P9uv5GdfKNU1xqc7yR0vYhjPiaxvmF/LB4yFezdtBJCtN0o+bHO4L9EmzSXSUzT16
	Ob6ngVVp50N/TwCjrYpm008/jnfvvUyZ2iEBG4RYkicudLC4SdaKcjho5n05UYNRW+ADSHErjJS
	bMi+x6wV9hbJ4TAQB1/fxxXtXOeZbvfGm24Futpx8ixN4=
X-Received: by 2002:a17:907:3f1d:b0:c41:21ef:26ef with SMTP id a640c23a62f3a-c4ca7a49ec3mr810908866b.20.1793622138788;
        Mon, 02 Nov 2026 04:22:18 -0800 (PST)
X-Received: by 2002:a17:907:3f1d:b0:c41:21ef:26ef with SMTP id a640c23a62f3a-c4ca7a49ec3mr810905866b.20.1793622138220;
        Mon, 02 Nov 2026 04:22:18 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cb092c042sm355638566b.82.2026.11.02.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:22:17 -0800 (PST)
Message-ID: <81db96e6-f6f9-4bc5-abc7-06c76921b4fa@redhat.com>
Date: Mon, 2 Nov 2026 13:22:16 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] hdlc_cisco: shut down the keepalive timer
 on ->detach
To: Chengyu Liu <19290937@qq.com>, netdev@vger.kernel.org
Cc: khc@pm.waw.pl, horms@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch
References: <20261102112807.1395951-1-19290937@qq.com>
 <tencent_B29BE3462A7EF2A8561B6A7C05E857FDBE05@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_B29BE3462A7EF2A8561B6A7C05E857FDBE05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 12:28, Chengyu Liu wrote:
> cisco_start() arms st->timer unconditionally and cisco_timer() re-arms
> itself on every fire.  The only deletion lives in cisco_stop(), which is
> unreachable on the protocol-detach path: detach_hdlc_protocol() calls
> only ->detach() (never ->stop()) and then kfree()s hdlc->state.  The
> cisco hdlc_proto has no ->detach at all, so unregistering an up cisco
> device leaves the keepalive timer armed on top of freed memory; it fires
> within one keepalive interval and cisco_timer() writes through the dead
> cisco_state (st->lock, st->txseq++, cisco_keepalive_send()).
> 
> Add a ->detach callback that shuts the timer down permanently before the
> state is freed, mirroring the CVE-2026-63803 ppp fix
> (timer_shutdown_sync() in ppp_timer_release()).
> 
> Initialize the timer in cisco_ioctl() when the protocol is attached and
> drop the timer_setup() from cisco_start(), so the timer is initialized
> exactly once at attach time: attach_hdlc_protocol() uses kmalloc() (not
> kzalloc), so st->timer is uninitialized garbage until the first
> timer_setup() and ->detach() must never run timer_shutdown_sync() on it.
> 
> This bug was found by static analysis and confirmed with a KASAN
> reproducer: slab-use-after-free write in __run_timer_base() within one
> keepalive interval after rmmod of an up cisco HDLC device (allocated by
> attach_hdlc_protocol() via cisco_ioctl(), freed by
> detach_hdlc_protocol() via unregister_hdlc_device()).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Chengyu Liu <19290937@qq.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
FTR this has again broken threading. I guess CI could still trip over
it. Let's see how it goes, but please fix your setup.

/P

