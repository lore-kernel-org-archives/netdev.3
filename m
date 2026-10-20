Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481257;
	b=C/CTw7DMJNZrVhokSWxSPBSSG4J58V8j3RHMb037++pWYNSLhpDvPGycsdo5BP5fRafz
	 zidE0v8Q9Yy0srDF45C3gY7KAQigu0jY1sDlPA7wTq45IjWsqJ064Hw9SsA2hWhU4K2lo
	 pPQwVw4j/4XGjcl/xs0hatyPSaHODdalRu+cxBDbI/G6R3zysCoBIa8bkUy1nEo/U6UDR
	 RVlhDqErEMdH6ETBAIiLRk4kAJv5/8RsEkZrjdWM+dU+ftguPfFxYxOCQJWqHKdo0FyAW
	 2BNwOeFzpCsuCzC0diamZMbM6pj6CjnMqTvsPS3S46kDG+EyqL0rOiJVbaG0S6cjLwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481257;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=jspNgJPm6vvNdwQu5Gt7wcuyPqv8/iAos8blz3aMwh+iu2ZsYFZgo6pn539P6vJGC1pb
	 A1yWTeHu8frjS+ZUx/B21GyyS/fjFnD5WGGAEpisZ0Q17gWzM6Uylvj9XNo0az3n7ApZj
	 rQM1Is41oMbhLnZvyRDZ+5SJ2QU1U92TMF+ru5BphDvHsI4z3TsmkyQEzE88fSQJSkCJO
	 7sDAnYVjXFh/pXtDgu1q20FChPxhuDSM6tl1aFLl3h6triP9mvxK/j1EAbcxj9v2w6YO0
	 2097x/5z/tcPyKx+W9Wp+vtdgTjZ3IW8n648CSPss+OAces7DvEdCQS9hRvtM2Pq7Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYD5oAto;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlanOOup;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF5606A339
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2AF5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYD5oAto;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jlanOOup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792481255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=FYD5oAtoFSspugtKabwEumtICqFmOUXlN+BVkrPvkOHtXqIRPFnIMx7tjFweGSmlNyLQYc
	8Wf0+k0r+E42e46gn095oFPMoZ8w/3zRjrxV0jYO3S7e95hge+OD7ufUnMOELy3n57fAZP
	APSLMpFrGqLyrjHdkM9/QtlUsK2RCjA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-IoFlBqvVPASQ4Xwg2Nb92A-1; Tue, 20 Oct 2026 07:27:34 +0000
X-MC-Unique: IoFlBqvVPASQ4Xwg2Nb92A-1
X-Mimecast-MFC-AGG-ID: IoFlBqvVPASQ4Xwg2Nb92A_1792481253
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so29857385e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792481253; x=1793086053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
        b=jlanOOupnmRinGJ9UoP3hh3EcuaDE4JfW73D4J+iyc79nMc9rVkIsIq5kE7GbHKrRT
         pW0Esnh5erpiYElZX9jOHZv1GrffrldlnlVCCGvPcyo+M1PavB2BUgDDste65XwVx8K0
         dPN9qG6IcQTXrwEMwPKaUjGbsAoe6Hn57tiMDKLA8RXojyMaUJZazm2sqjKJgfD9m0+y
         0KhJGjt9AZ66pkoUjru164VsovDaR2GgcRcPEQ4gSgHvFexLxGFYCrb9EwZvjwNZKZdu
         EtZj2G0tAqCJ6Iup8xVePbsh7d4ZKVfMi9jmNc/0EBNJbSVRtNY46mqkKYsa59kWutS9
         Uxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481253; x=1793086053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
        b=sS1bWqgTb40PIHJqe6tJz3oUr4eI8qwFX3J4FjTHs34NqFJf30iMzQvNF2VFChckHk
         hbwxLu4W13W9sUnmUqetyaaIWGjLOusNv+E1o9V4GUATZZW/jemx5jIRJm3zeIS1U6WY
         m99AVj1fznp00mQDE9fKBoEIQLs6gz4DFuSjw5JDUTlH1CsZQfaLGdjPdRH5SpbeRi1i
         5B8ZpV0VMNQ95hcBCsTQ+ZV1lr0TOmhqUwnOs5a4wNO3d8fVrsWGf3tskGVoOhYSeM3j
         5RrgCTvHd5BVnqg81IBPxr2lW2rsajYsj2ri4lTRnJEJl+n9GwwLeFih/OIvxXXHt425
         AhpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwpvhC8hd27o29sfkzVrSfkt9wR1//81MSzMSpEI7WNujXMCqqwqwEYGFJgP9hzX+Kc4lQGOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKwOm+D52qhuqFj69LoC37R4IILlHA/f9AiFcS/FDPhcIjeGMN
	Pu/fdHCu57Ylh0OfxSE48Dh5x0LXtHi84iXPMebew8h7Ee+aTXSsU/CvbEiEgRawx2tv1VOXKzC
	vIsmErOey8DjHAR4RW+BrIDxo+/sSPNt6nXa/ETrkCyDGGrBilhZ9i22MOw==
X-Gm-Gg: AYBFou0Myi5u5NlCF4gQee48rDeDlKZdkkFiU8j5YVjr5s9wtsuKLEw1v7vWrGXzz9U
	9Fp0sFUYL3KHJMEsUn7Grl7hbsAicOt/9m/XfYx8/9DPFM+ZXj/KTuw8Unk0Gbz/Tduraak3Jyr
	aUTsHLtl4+v/FpFYwhh+1eJM497ft/hdmqqg0P+rEJ28skej37Ge8LKbnhP1Iki8SkFOKClISqC
	6WT3L3srjAM9H6bTQ6vk0b698dA/CdkA07v8N7pM6qCkom+VcERuKfp6yNEjvV85AN9H8dOHtAg
	le11t9IJA9KTKpds1D4awGLssoBrh2n0f1iKgI664ujBCNmKKDrJblwG8q041p2yir2Vhg==
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725745e9.17.1792481252768;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725125e9.17.1792481252104;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb8d5csm54348855e9.6.2026.10.20.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:27:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 03:27:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020032524-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>

On Mon, Oct 19, 2026 at 08:51:43PM -1000, Linus Torvalds wrote:
> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.
> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?

At the virtio things there? Sure, 'bit later.

> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus

I can help with that.

