Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE414883F
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497043; cv=none; b=OtOwPvkCaYgUNWn4HfBkxzLice0FUxqVMlAnK4WHrhi709ZNV6zNadagtRJGIygRd+QeK9+57o7Kq+Of1y3g7XBzxYt0GlJV0ttnrdWkQXC0T7hX/Vr21yfw7L+ILv/Yu/fKUUU1ETeYfxPH/Wiiy/qmYP6bsQhSSDd1KJXfzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497043; c=relaxed/simple;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gRkpAHzmmtBFEov9z4gdhdBQtM9YSoIsfKg86MSkLc4/FqMbSHFKayxSh+/hwCg+pwg/mq0+vP20ptnE40IDHHNcHRQYjbl0TIM9G5oqjUnc+pPWrn6NHuJcuTvuIr/AGwU+nr201shzuUdzkLaK43JmicLxZEMwWqjnyPCwXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pq9sMbma; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYGvMWAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pq9sMbma";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYGvMWAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780497041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	b=Pq9sMbmahTkjRB7vYKl0QfrjlHd4fBSDmQoLTTj3QyiLr4ptPDXezGJgzTSI4jdHtfZKex
	HaMRApZScC5FFYlcftBHmkZU8zwgwX0YbKMfrHwuWk61iCu4x/5DXm5Yh0SitWxvquNCkA
	ate3/6mHbPl68SMZB7iDMTjDBqJEzkw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ili7TdAnPOCphE6eVWxoLA-1; Wed, 03 Jun 2026 10:30:39 -0400
X-MC-Unique: ili7TdAnPOCphE6eVWxoLA-1
X-Mimecast-MFC-AGG-ID: ili7TdAnPOCphE6eVWxoLA_1780497038
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-beba94353acso393355566b.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780497038; x=1781101838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=XYGvMWAHzxbqxodDhF4yFJA3LuTyj2WPi+OIJ3yYrtqfSKCkJmtPWtU551KYpKXaw8
         aXMeMTuDVCOCv4ZYs0r1vOebyaNogbZj196TXm5c8TVMsQ1716EfMUt1CGUzi7pA7CFa
         SrUBdC5MxuqMXsYUXyqMk5V+E9CU5EmeEXQy1m21XS82sopTUQ7rh5ggItRExTDITeCR
         jZySHEzudejQYeFbyzs9vl07X8Tg1P207zE02htVYUMdY3eySAAiyw807KWyC44tkcXe
         eezt5lQf6cifxhqgMby6f1mSIKsBlzov72eE3c8zMrLrsba55wp9DsEO1RqKdO9ZDZvg
         orSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497038; x=1781101838;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=SftUS6B+mXAUemJdNZDkeExVh9XPnaSVsWK+cFY+Qi/727B9YyHSnIhN2RcIPQA50T
         691GBTsY5CzbB1Nbo2tlb+oQs0PFygyBl6BBlQDFwqVeXBiDeR9jLFAcLsFm0wQykjNy
         vlCBYTdxvL9lSm9L4qQQb+o1mCjbtrCobLHJS4qeSmvY8rbFJVAyLZnmPyzpQdU3qt8n
         8GsVE0ySkPvuYp1I+9WlX7DzWRBuzucRMI33znHEwPj5lVsI9WOXQm34CfQO4z0kcuR+
         gtCV7Rrgh6sNWRX9YyM+14RdIvvh8ntT2zcDhv5fN00jqGi22ycX+2NDTGeiSsBPZH3v
         8cjA==
X-Forwarded-Encrypted: i=1; AFNElJ/uFfgTFUWQp1dNq4LrMJoUbcnwoOPmGVnepM8MvSIk8xjZ57Wi0zMUpZnyGOAC35o1aI4igjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2npLtT1yid6mlhekHstKXStOPn4Z3VtGRf2GfxOcuq66CzlZY
	HyKGeums96tZnCHR/BW35I5dwBidGh3+nK1dM/x6SN87h6YBRoBPdc3D02RKOHzJuJXsYnBkrXB
	rc55dnuKd8byX6HDyE0k7176CHzNanbd/4zRaUfKcqSAnB2SN8Y3GJ6GcOg==
X-Gm-Gg: Acq92OHu+S1hngdn6Y5f54hP/y2WMmYTMZy8Rf00cssW8X4noXQr/LQjrmeRKe8xwu1
	EXEty1IELwHmmv1zyyAEg4LBekg8CTFBz1uI8ij4S0kV43AQd0GSopt2fHIbqJA90sMuDrba+fm
	6xsdVsgnEGZhUQjwsqqygsR6rRF2HDACjR/P4U0SjyXI6AIkXBnDKrEYP44kJyUhugUj+GAhlnb
	cskVf3BDZaGE8XqnyTub2dlMn7/Mg9pZ3QihkoP+k6lZa8MJhZcY9i3YTtDPwugPVxH2G1iLMsS
	k5miL/np4tHiwunpAOgK2q6zxCpcf1+SPk7I/mBIZZ81nylqyf1EADZAKO/ErcRt8gDdroAxJK9
	sc7w1NT9lKQ/dEz9fPkpe56ZuiWRSnOFISC6E8FjsdUkXfHlHY/sTMMFG
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58335085e9.10.1780497026994;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58333875e9.10.1780497026156;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm68311455e9.0.2026.06.03.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:30:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E15C57BAEB7; Wed, 03 Jun 2026 16:30:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, liuhangbin@gmail.com,
 yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 zzhan461@ucr.edu, n05ec@lzu.edu.cn
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 03 Jun 2026 16:30:23 +0200
Message-ID: <87v7bzbssg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone the packet for all but the last
> destination.
>
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
>
> Reject fragmented native XDP frames in dev_map_enqueue_clone().
>
> Add the same restriction to the generic XDP clone path in
> dev_map_redirect_clone(). Generic XDP represents fragmented packets as
> nonlinear skbs, and rejecting them here keeps clone-based broadcast
> support aligned between native and generic XDP.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

