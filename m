Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EF4DE72A
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359810; cv=none; b=hprrt6DAW1/4epTHwrxp9vl3epMNjn9PqLV/5jbpzaoPM7WFeDBEGzKQlJxVssKLe1rdd5fl45xSfUD8QJ5J4tw+VIrcb6JubFaimW/U+trsxKYx/fg9BYiexWHYgvm6nJxa9m9/+lzHnBnx264zHCw1pd0DveheFRUJs3peNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359810; c=relaxed/simple;
	bh=TMzR+utcD6ruredlhYW/mB7GgCGF9DnuMgw/+gVxnvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSGaVOkWEKGxOebhTpLFwUKYfpaxqjPXy+TgkArBcCdG1oUgBSSv4sr1fB0oIjeNdGMJTU6w3jJWnt90203A5xBonWPPltiKTxSYESt/h1b4f5oKcK7E4TG3VWiuPEegLCQ/RL4HtgCEHkIGisCaFTD+ywuLcnDv+A5QN8YVxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUbWvHx3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjKaAMBF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUbWvHx3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rjKaAMBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
	b=FUbWvHx30PzQBT52aSROprMa5oLECLc3R2B9EgvBcc+MkIJvISOw53WgZ0GyyTUpFMzDu0
	ush7qahXG6Uon5s9c73t1E4bkR3wv1CRjAtaaR8J0/fehW5M7YJmTKJOd8qjmK3s0OzFt6
	mWhRCYdw8iP4tUeFusxpDjIW+QyEi+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-5z1V4zvmMHmLOf67iZx-Gg-1; Sun, 18 Oct 2026 21:43:25 +0000
X-MC-Unique: 5z1V4zvmMHmLOf67iZx-Gg-1
X-Mimecast-MFC-AGG-ID: 5z1V4zvmMHmLOf67iZx-Gg_1792359804
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dff112181so1462701f8f.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359804; x=1792964604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
        b=rjKaAMBFj9BPFjdvSydSYkr/S8Om8rSn2ttMaO0E8vvw0tvmHzjQcwlNFEJ7XTjvVI
         URQaG5qpoLwV12qjR4xvboT8B9MsshtEI8DtKz8xtnmJTJra1sBiTgEfSZZm0l89nJIh
         okgal6Dl4EnhSziuV6bqGkFveG3GeezKLJJHvbJtVuu8UH+/vXYfGyicyOgjyqfGVRqz
         FQqbXZBTdmbI0bIyJcX8+Z/+8ZuKQXCN3Z5JeocQrTCqvcB5dE4rWvfUnMqPYdraHTRR
         NlU7Nlj4vDwOOPSRO2mXXUPlrKIT8eqXb3qC4ujsuQISwwHQYOG8xV6i/GBPZRoaovqC
         ge+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359804; x=1792964604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
        b=Bnuz1IOs5wKNby3jCmj2/bdvrfpiLAkYSVHkmjvQTaO08989mJAmzfsDQYWWgEQJEb
         GaxPaIcnvq4ot3O9L57E0G7kF+igGLyJMNwLczUT8ki5b0VoNxE+EzHUUMjcdoPJ1tmd
         l/ZgGaxm6t34H8ulIxBaeiqRuQpA96XkNfihA26gPrLWdRttINnAPUQnVqSsOA4sz8Ew
         F+N7WxawD3+zqVtQMNHVLcL8G3qMsOZlnMNAYVyEzqyUt2jaDrFAG1go+l8PiLItcIqn
         2JMx52UvvxHmCpM0KUVxaLio3mUxy5G45jmWmOwVrE+eicS+cPj6e+QRHu1oIGP5V173
         97Tg==
X-Forwarded-Encrypted: i=1; AKwUvBzubrQfjKANKbTLa5vQpt6Ch4W7eIvuKH6mPJaFhb9T7jv+HIYJ7VZwKlYshDIs41xLkbacAn0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGO6EkP3e1xqETYvhzUpuJrva8fis3RMsYaBbPDDFp1/N6yTBC
	zuGxhJpbcgqwjuxXBeDkTiaxeXj/IlmghGlbQK88vwXsJZwwwMX6Bi5NNB6rYqBU81SrPQ669yw
	EAx+zHVfucIfFx8AO9MYZ/TdzO60oqpqB4aHOzxXmd+qeOf20dzcW6ultFA==
X-Gm-Gg: AYBFou1es5W5m7qgeiOOmLU56PvUzHoK5woTA7KXGox2rZnXqAnruaqL7TXiTcwfkRQ
	6NLXZ3YGqez1K/KCZ59YyYvMAPGEsLRNNi2+wEQezqYJKch7CrinYDNXBegXHHGJx/z0wCSuS4N
	tqrfGU4Y+JLj5H5r21DdWsdobaZMpMJfqyk17h2RlLE6R0vkSK52ggGE3uAilDx7dKGqcwNqOlM
	jsN9M2w2lCwpmKC8JV7yzZCQB2PH1DZV30pYu5X/ei466dRxRxpLdIhFhbgGsvMkgjiaCE3fkAO
	Jd3i26YNseT06KP5H1wJ+LJmsXD2orKYaAawK/S53dks1Nb7rslni3pZcggx3ULHgQT3Tw==
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057919f8f.4.1792359803757;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057906f8f.4.1792359803264;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdcc0f20sm18573888f8f.11.2026.10.18.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:43:21 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:43:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174250-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>

On Sun, Oct 18, 2026 at 10:34:12AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +               if (!access_ok(uaddr, sizeof(*p)))
> > +                       return -EFAULT;
> > +               ret = __get_user(tmp, uaddr);
> 
> You should never use __get_user() in the first place. It is almost
> always just a bug.

Right, I was thinking of some other code. This one should just be
get_user.

> And __get_user() together with access_ok() is actively wrong and
> stupid. It's slower, bigger, and more bug-prone than just using
> "get_user()".
> 
> The *only* reason ever to use __get_user() is in very very iffy code
> that might use a kernel pointer and doesn't want the access_ok() code.
> 
> Or old legacy code from the last century when __get_user() was faster
> and was inlined.
> 
>                Linus

