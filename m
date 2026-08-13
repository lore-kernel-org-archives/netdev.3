Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A35446BFC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615886; cv=none; b=RP9893blUL+t24sooOTTPvfShUBk2e0aAGbvibmuUglP1pfeWJAMeRu5htzQQ48WVfxII1H6HN8a2A7eHTex3VDZ3rZgxOIHNMO/ZSkGEEKqqQzIUqFWFjim7V/nN4WjdsqrUFJgJrzIhDA6/g9IFYzJ5ZH3jEQtRWG3GT5rLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615886; c=relaxed/simple;
	bh=YgsUbLje683fmKSLiuc4F1nLOAKszh60ozLryAlB608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa4WArnOj6Z8gUXslPCHaQi5D2kuC62WI/IP4QdbulhSDSNSzhyokvBRP2EuLzl7pPFI3B9uJsAwF35aOcWpswzAwR8aM7TDtGqzsQ/G3TKp0/o7GhlfXB0HA10d55wzBuaby3lesQZM/4E7MjiqC8ExDjsxkMC6rHcRZNjlD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ris++Adz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ris++Adz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f84023916so1680668f8f.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615883; x=1787220683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vsc/t9j+f4tMpv+gJvijHu1ikwVWEPFOE/I17iet5V0=;
        b=Ris++AdzYgTx1ErH+WXMNOophrhFN5gn7MYlc/ERrrFDb8xJbd64j8GPxkvqIIugos
         ysNu95ddF5Fzt82HmfJpMACX8h6oq9loEOaCHUQZOXXcsZLJHG/H7rGTTWH1yObi84Qq
         4/VHegPEgrDRcdL8u9OCo4z7S6GVjzZ6Q8cug6zd1lr53t/7sXAdFcN8zHmxM1qp44TP
         TRhMW6JxtmednSFvMsIxiyNCNMiBfHgz2RUWSel0DgZ5xI/fgjPLEOIAR9+weLC9jFZo
         b6JJnpGn5h2ynlhiynlEbxTZOq99Gb/mhKT9kFsQHQRlukBnpueavq7zPeUGgikszpeC
         ygVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615883; x=1787220683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vsc/t9j+f4tMpv+gJvijHu1ikwVWEPFOE/I17iet5V0=;
        b=kq51EDBt+2MAOwYcBjTXE03Wdw6/qQaXkmCkBWUI6tmu79qYjl2LkNMWD4Q1pZO4yM
         tMK1EuuSxXp2IO4HMavyy//KK+VPcWDKXJWyEqF1arkyps5ExxvZimt6AlqKprAOcMr1
         kA1LKeFOhBe3q6o4lyCrS/ov4o78uM5g1mMU5ForTW/NBJjnSYY1N8eCuGAst4XbgYeR
         P/Py8jXgSX0YJrGiOSejxLZsbMUcYw7JgvNdWqQFfg9fQxFgAwZuWBWLCcTJZeCFrkiZ
         pqXl8IAqMqFA0s/uZ9iJCIlPjok/HND3SA5I5ce2SsXGwkb2n1yyGuHNEUVavWN/v8d6
         MUYw==
X-Forwarded-Encrypted: i=1; AHgh+Rra9x5yf32+MR7v6esBwiF07W4rmSiJb5WqX49A/ogxVTdqtC+fPgFgucAgbLEqmtn3ZRy93OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/l0KtDAxUSVkfKa9G/lD8Ko5nWjLH4Z0R85wUDYBsCmKmtBO
	yUEzI+oi8YsAtOXS3DuduVEgXm+kPlW1c2L6g2r4GgLLw3PMvqWP3MKH
X-Gm-Gg: AR+sD13DTjzacg38osFmTeHaYQkrzWZQTFDsr37AHid7Jz68l4/4LACvtUO+ZFQHsT9
	RTebX1aIzCXZ2wP24FeSc884fqT0QBCffEiGvSl+j1Gm7LLhhjrTxJapfuBPQxtIO5kp8WXU16I
	WDqq/74FjSeXGVp/tpJRUBOtmkyK6DrW+7B0SrS64mnipZunjllmBKJWFFjZN1OKjeEPZiRiqg1
	jZzru6tgG9iXpnXnwMj+khAI9LTSsgsZr1kog8bg/X0eWBbKp9TnZS96vmuADQc8+AiFlJ7PLXT
	FKU0TjdtTCwFxjLTXzhV3uPWpNLbvk4ILgctwi/2oxvGZhabBhLBUZf2Rlkh0+47yzy1JdHwhNG
	cWWLwoMuaqjohtqwuzBEcHUBZ0ef7Iyx4SwXjcP53zeopumAIcQFKQzHP+oYXrwcMgnOByLMvrt
	jtvyTpuR3tN3Jj1+/mhx+KnRJloSnvlOIBmh8AXPrnDMSRG1fUsjW/mqs+UkhhegH7olam0S6fH
	t8+wR/SVZaQwZECRNqi
X-Received: by 2002:a05:6000:184a:b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-48159cbe26emr7265764f8f.4.1786615883005;
        Thu, 13 Aug 2026 03:11:23 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56123asm5759067f8f.8.2026.08.13.03.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:11:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:11:19 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 1/5] net: Add connect_socket() helper
Message-ID: <an2YR6g_9SPEaemw@gmail.com>
References: <20260812154328.72834-2-mahe.tardy@gmail.com>
 <4a025fcdd177da13b51aa8042d59fa5d8e3a7c022bde50d5cf79c92ed3ad516a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a025fcdd177da13b51aa8042d59fa5d8e3a7c022bde50d5cf79c92ed3ad516a@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a helper that connects an existing socket while invoking the LSM
> > hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> > logic. Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.
> 
> This isn't a bug, but could the changelog note which follow-up user needs
> connect_socket() to be global (rather than static in net/socket.c), so the
> new header declaration is justified within this patch?
> 
> The changelog motivates the helper only by the in-file reuse, but on its own
> that would not require a new global symbol: connect_socket() is declared in
> include/linux/socket.h while its single caller is 26 lines below it in
> net/socket.c. The actual consumer is the bpf_ksock_connect() kfunc added later
> in the series, which the message does not mention, so a reader of this patch
> alone cannot tell why the helper is not static.

Indeed if needed, this could be made more explicit. Currently it's
implied that one helper was missing "for the next patches".

> > Other socket operations have equivalent helpers that trigger the
> > appropriate LSM hooks that can be reused, this one was the only one
> > missing.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

