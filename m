Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADD346766
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863601; cv=none; b=MEIzGJ8U+SqKm+XXuUxcxH18t1GSx5CLFqneRvzB67G+JVrlzLZ3i2bCUPipatR9knNkVWEKtUsuXnCAr/BP0zQt2lwS+JfGxZNcSCdInz3W+gu7SaMZP+Hv6vmSDKrvFaKa04Suo4F3jXAI4Zo9mw6ul9feGFkyKEZTa5AKB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863601; c=relaxed/simple;
	bh=vJukLrPJin6WQ7MQ6oAHUG6atU4bJFbweG5yYkDzkJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeuY1aLoNvjatU5UzKF903cLWLgmZRhKy9nubuOub+JGfYfPMDSW/qR67x5kSQ0vRQt+cdNWAS7dT+6ELNAQ+QLjDZCscVH1iF55i9QY7HhggpyNCq2CL5/VKvY4etX2UQjma+t6uSGEnD1iK9vLufphmgANWtQhGtor4Ana7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ck76VP2W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkBlJ7Aj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ck76VP2W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkBlJ7Aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788863599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLUw/Bl520e8cWV3gwPxpZi8UhE2WkvvwfpwSZkJals=;
	b=ck76VP2WOaLzk2cHhkOwsEc66JleiA2KzWqyFQZrkqeBEl0pTJL8OyzDcWNti9p+X/gybf
	vMXu7LRrgyJLoos7+baFZoHR7j2PZay0OXcXxODF/irJwUk95Olv24CZ2ToCrxN8TkcGWs
	hXQSnPfsejRd82hhRNNVcy3Z8MJV8rY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-qEhQgMwjM0qkUDaxn8eQTA-1; Tue, 08 Sep 2026 06:33:17 -0400
X-MC-Unique: qEhQgMwjM0qkUDaxn8eQTA-1
X-Mimecast-MFC-AGG-ID: qEhQgMwjM0qkUDaxn8eQTA_1788863597
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-484357599a4so3020951f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788863596; x=1789468396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SLUw/Bl520e8cWV3gwPxpZi8UhE2WkvvwfpwSZkJals=;
        b=BkBlJ7AjQongvXc49aiP1KQGox92XlXsSzj/Nq6eK2XlmagB7GncDIkMeIL0HWWS8N
         hscbMhwDgxbZZ+QcjI4GvM36/ZuD1xvd/VV38nN/T1pAKgnkmXFMr1qHPnu/gWRYuBvl
         ynXEaCwPHCJYA8qAxWN7YGi+O3O92Kf8CrUcfXzCUN92Rv9JwK/NEwQpS7qXdrWm0DOO
         r2DfGfhVmuZRv99EywTYuuiycb1JfLLVbHom2dk7V/59T0doLNVGlr4XDRH8a2qYNeEN
         uPnClYj3xOkAFJb28I0MtNSKi56s6an8Zx3hnOey/Ca33dfFciP4ecV5pp8onvqG3ers
         nMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863596; x=1789468396;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SLUw/Bl520e8cWV3gwPxpZi8UhE2WkvvwfpwSZkJals=;
        b=iOQ/dy2vh0JW+/d8soNcEUGSda4bK7+vUpHjfk3UT1zgqu6n/P/9cy9F0u1sBHZ8c5
         GtZlR4uVDy4+pBjQQGl20ueziSklNu7Y3x7OJC0pW+JwgeeFPM0EDIbUSgxtJm98TO9c
         utHC9SZ/YYpi2JYTxAMl+fObcPsP/ObVDl/sHMv2DbQuaMfD0VwPb82dzFr86qlLNI1O
         dnYjNytPs5RP43aE+/SRC5NFWNjmmGrbDu3d8i5YeOhsAxUNqOii/0jf+/s/787ZtdtB
         enKWjZQSX6pBhraXWk7YT5b2v7UUYXsUySK7wM/7ZkT51/GiDJTS4B3gIztWX67tIj7n
         AGIA==
X-Gm-Message-State: AFuF++nZd2oSW6nH/qx4PDe03Zh8LLQ6Qpa5ofEp2u0hKt1JaV/gDeLb
	kQJ94H7srJRqtscPi/loR9MdxpsW8uFutf+1u/KFirMuY3h+dSNaLq1MJqjE6bOOb6rIRGzamrR
	t1D9ixF5oz/cLcVQ2oiJQQKdXvtiGL/mmksJUCjpAluEiWi54P90M+ndfYA==
X-Gm-Gg: AYBFou2tt3k+jxIARgMHy8MMbdLFD5ohSx6/FVW3iKaH18GYIUClEJyB786MtkCYy0Z
	DQHwMnDGZpjooHokmgkGa9DmNhSZENguMrNrEKpAlc58ZO83s+dWmbzZpobS9uxsMfH7TGLJZr5
	EFOkR86U2b49xF6pIl3y+1kpZ0WpWSdzjTG8WV8Ibcrx4aU2AB99eyFpQ3Zcj9YFwEYqAX1FoZO
	h/DwJ5Md7kRMMPjo9sxghoHtSV9Fc+HM1FZ8xQOhWUQ1SamboX8eDbQMTIVRlfd1d/WeTUE7tfT
	JOXIPt7XodgUknuRQ5nqG7wKNR+oY+ZnjiPJw3Ud0SPkmx/ss5I+2vbTaBcJK4XDueFDpTlftgY
	PjyUGuoCpDqSF7OWx8HGJbSIKKMBnFz7IUlfWITEZz2lex629sR2QW72WbnYyl5wgH8FVjI+Fnw
	==
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id ffacd0b85a97d-48587289c5bmr51476485f8f.22.1788863596546;
        Tue, 08 Sep 2026 03:33:16 -0700 (PDT)
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id ffacd0b85a97d-48587289c5bmr51476404f8f.22.1788863596142;
        Tue, 08 Sep 2026 03:33:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm33647888f8f.22.2026.09.08.03.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 03:33:15 -0700 (PDT)
Message-ID: <355421f8-63ec-43a4-8982-01312f79dc6c@redhat.com>
Date: Tue, 8 Sep 2026 12:33:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] net: ethernet: cortina: Fix RX budget accounting
To: Linus Walleij <linusw@kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Joe Damato <joe@dama.to>
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 11:45 PM, Linus Walleij wrote:
> Finish RX updates before releasing NAPI ownership, report actual NAPI
> work, charge dropped frames to the poll budget, and drive free-queue
> refills from consumed RX descriptors.
> 
> Track RX drop state across descriptor chains so discarded frames are
> counted exactly once.
> 
> Tested on the D-Link DIR-685.
> 
> Hi Sashiko, yes there are more latent issues I will get to them, but
> my LLM thinks those are on the top of the list.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
Sashiko has a couple of comments, but the first one is a giant "this is
solved by the next patch" and I read the 2nd alike "if H/W is broken s/w
accounting could be inaccurate" which in turn is not a big deal.

@Linus, note that the current expectation is for the patch submitter to
provide something alike the above feedback.

/P

