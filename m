Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C741CB57
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097477; cv=none; b=OisUd2kJrA9Oq3FP7EI5JmmA1lb4qQMxlR1ONAFxZBI24NovQ6PutziEnQRUPE0hmdKWN8ASdBOCDafgwboNU1GxkYgH5vaBSC+mR4N1AZVnSSY/Qu+gjMonGeMzd5HotDX9yXupyri+XgcQAQYaffhH+mx+736kqmx3ijX3zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097477; c=relaxed/simple;
	bh=PzJAzmMlMAwzz07m1rStOfmSbMehiPpj8jWRb5DmwqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3E+/sjH0wFoi6fV9JbwcbBTZQsKrPbRQAZgElcXrPDNmSyyiNFoeEdbhP94BmBdxLHm7xsS582eXQzm87U4eRwdRO3hRfW0q8c9HUhG6hF5Ti6/7vaUouMkzRuXVE+xAJDdpzrHlg0pw9jXXrGnmAf+bsEhVi7SMkJIttayJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD83MMOz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD83MMOz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so17026085e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097469; x=1786702269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfkgU7jZpdRNXbaepKxMlnZZSP7VZ5dxP7EkmOF/3y0=;
        b=UD83MMOzcyTD7X+V2QlIB9xnMgUmONeRCkdDp41xPEqcQzNmtxI8xqhNprxKHtz5Bv
         kSVTLrG/F7cLh17LbFg7D9lydmiv9MrpZaqX0IMuYJpQBGDUB+Ka2e/FO2k6S/r6vAHv
         k4bGnuHiRe8AvnJ/ag/qycJz9QCAcdRVntLlOrp+5pc396NKxaePv8eYy9GtJ7sgMoQ8
         f2faXryON032p9UraTthfJNrhCmzGmFr6snT9DbEdGI8E/JegqnmXJOLPULWKCt3MnZI
         HKhrNNe8a5PGX4toEkcMofvmZHSmq6IFPTwMr0iMMddUD8EyZhQa/qxyPK9PEhMdR77e
         kQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097469; x=1786702269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sfkgU7jZpdRNXbaepKxMlnZZSP7VZ5dxP7EkmOF/3y0=;
        b=TVzZg+6y79pzTdRAkBQzEuyYoePVqRduU34smRUETUc/99BbptDb7uEnRcOiDNUkvD
         QgboerqWwyg5ORrNGhbfvhK/qV7Xf9oALW/I7ogMNN8SuoHjJUeHZCFZwvRk1MFq/0c+
         v+3M1cSZHjqhIE1HriNq9yxdlWxPHDF6SHLRKANHZwSloGvmlLO+PIkKo/9RxxtCdKCO
         JDO5dtcMRZxlGe+sjz3UaQ/pYDDF0soyzwKkbjz1QqSZCI3Mgz/O3nq1DI6lmtWXen4d
         DcskHYe7wSII6STqScpS5oK0bVA2sjMS1Xqeqpc1r3IHl5Yo8PthN0ibwlaYqKAq+k6q
         +ijA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3CuGUnkQIOOTGPwzIRDLxOijkaBWXdwWjjtj7Eqqaz6EiPloAmXN9aiSoHybqE4/dp+bSXC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZX5UpqA58zwrJ3IpR2DYjPwPrL9JsCGLQ2hrkIBONI60JdWU
	iuUL7uEdKewQGZGKWtZCb0ofNcWnSw4FmQRRv3KcZBk3yyvLIbF5FOmj
X-Gm-Gg: AR+sD108yEwHvJrndzBnRg+l51fiTxKxofW7vQCoODNp2z18UI63qExhhAuugpmB+Lw
	qOFp+nguSfyPXAshKeL7d7uafGRdsW1bbPEeITqwUSLZDDF1FCv8c7dM9CGpZYBk5/XkVhGUB/M
	2812TuBrpLF+7axeRycztI0h31dTcM7WLZKnu3tNd5kH+MfKBRho7oVFKVNXKde1VDgiopldYXY
	DcCOmfOi/0AsSTkm5JRph7OjP633GUqbHPjcdJCqzhEoALlXGT20foxeVTVKv0G+CBuHhf/SnIc
	nFgUJZEom/nW72yMzwcu91cMa4Fg/CsCDhlRSMxgS0xlB9860yyhlmiadN370d7LFdvVqOqQ7Gu
	SDv+r40V75WpHC94DdkOC1GRe21U69HdJl0uBlzL85XysUwETqzEIatbco7MtKhPcrP+BI6DYp1
	FT7ZgYXFwmaFvB8hvf51aXVl12Y2wxyznjoBYmjN47gFD+fWPivxYdfuw7bnvz4wZYMsme0RrWQ
	cy0giLQfTyg3ckksDhnMd0g8b+OKHLR
X-Received: by 2002:a05:600c:1546:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-499553bcbc8mr121186275e9.2.1786097469384;
        Fri, 07 Aug 2026 03:11:09 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995919df87sm90789365e9.6.2026.08.07.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:11:08 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:11:07 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 3/5] selftests/bpf: Add ksock kfunc test
Message-ID: <anWvO7ZQh1eEHZie@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-4-mahe.tardy@gmail.com>
 <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c51bef73-17b0-430d-b473-7744141d6dab@linux.dev>

On Fri, Aug 07, 2026 at 05:12:21PM +0800, Jiayuan Chen wrote:
> 
> On 8/7/26 2:22 AM, Mahe Tardy wrote:
> > Add
> [...]
> > +
> > +SEC("lsm.s/socket_bind")
> > +int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
> > +	     int addrlen, int ret)
> > +{
> > +	struct __ksock_ctx_value *v;
> > +	struct bpf_ksock *ks, *tmp;
> > +	u32 pid = bpf_get_current_pid_tgid() >> 32;
> > +
> > +	if (ret || pid != target_pid)
> > +		return ret;
> > +
> > +	v = ksock_ctx_value_lookup();
> > +	if (!v) {
> > +		send_ret = -ENOENT;
> > +		return ret;
> > +	}
> > +
> > +	ks = NULL;
> > +	bpf_rcu_read_lock();
> > +	tmp = v->ctx;
> > +	if (tmp)
> > +		ks = bpf_ksock_acquire(tmp);
> > +	bpf_rcu_read_unlock();
> > +
> > +	if (!ks) {
> > +		send_ret = -ENOENT;
> > +		return ret;
> > +	}
> > +
> 
> 
> Since bpf_ksock_send() is sleepable, every consumer of the kptr is
> necessarily a sleepable program and thus has to open-code the same
> bpf_rcu_read_lock()/acquire/unlock sequence before each send.
> 
> Given ksock_common.h already wraps the insert side, how about also
> providing the get side, e.g.:
> 
> static inline struct bpf_ksock *ksock_ctx_get(void)
> {
>     struct __ksock_ctx_value *v = ksock_ctx_value_lookup();
>     struct bpf_ksock *ks = NULL, *tmp;
> 
>     if (!v)
>             return NULL;
>     bpf_rcu_read_lock();
>     tmp = v->ctx;
>     if (tmp)
>             ks = bpf_ksock_acquire(tmp);
>     bpf_rcu_read_unlock();
>     return ks;
> }
> 
> These selftests will be the reference everyone copies from, so
> encapsulating the RCU dance here also documents the correct usage.
> 

Yeah good idea, I'll just keep a slightly difference dance using
bpf_kptr_xchg() in the ksock_lsm_verifier.c program because I want the
verifier to bump against bpf_ksock_send() restriction explicitely and
not bpf_ksock_acquire().

