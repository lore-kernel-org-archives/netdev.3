Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933F31AABF
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096594; cv=none; b=WAQSYG4uTjuX/JkL1MlwkairuozaGvqYHcVfqwjbJM/Ch21mkePr2yui89miNKghZmD9ToVMXd90EtUdUcm4TaAUd+366gZlALxROUCB7MHGgYXPYdZYrpatjWEKS0hZuG2HoL8I1+5QhYOJJoq5rVrS60BlI8UJP1ozfH+MI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096594; c=relaxed/simple;
	bh=pHcKBItI/RhnxUOvGh6d9V055g2u12YM9zksCV64/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd3NEi+0lFzaL/z+Tvv05i0jXRspe9MYyJiFYMjwqduHdY276sY4ywdTbt19nfvXs5Nfx4/JzLMxjFhSzf7RtE8dfTrJyU6P+cllwGYpckC8DMzcvyn/e8dcZOD3PMK/apHcEdLhcUQPDkrZQclbGLqKlf7XnAL+jArb/tMTMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7onI94P; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7onI94P"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476a130c138so2749228f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096591; x=1786701391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=um5pD+hW6W0GLGw7qf+tQa0Ejl1SpwV3n1kaTYglr68=;
        b=F7onI94P5enQ6gjNY1FV8naKACvU2cLTwSwLlRkYtcz7m0wkt+4910Y2osy6Iybfc2
         mmJ7/aSuBkKReyhhuEmutUoBuURw7RQjlSLSawrF/0eXyNXllQPVS2lDvpC4QzqEBg2A
         8abRf6U5I7yc6XR2l9PYVCauifQ8TcTpeC27qHhtdNmkvGmnZ7P3P4V45LnioCyMz/VE
         UQJyAqod02KPJgu7vnUlOsPZfjdrcuGNbHOy8LZDoelD8M1cfwR59ZQy2PLli386A7DK
         k/UFBxIM6CEnQlBIlRSgcm0pjYYkJ6yecePVSA+RVtYIkzxSCijUr/lA9QZDH4PumhBb
         W7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096591; x=1786701391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=um5pD+hW6W0GLGw7qf+tQa0Ejl1SpwV3n1kaTYglr68=;
        b=VqtzTMb8NGfIjO4K6vhx5ZZS0jUtNGWrLQXjyszMk9eOE8aOhzZzMmCTcIRSCRPc2d
         oWIDnvgg5NpBnlPP6bf24jS24khkslVPO5ILJqMi898WnOMThJSnm1RU5bdFqGKyuHU2
         MKl8s+Wi6Xw6EJ7FVMeS8pBJ27RAmswTVrxigAlYl8Ba+7QhoxnILF73+3g3yXhWPMLr
         pa6JH7uE18GnDC/5hhiNzgPzuhyxHCSq2uXaesMLOMPcRqICfzsmXFZaDFKefpfA8v0T
         rEqkHftRyj0yWy5mko6Mo26fAgwcU+7Q4rOCGIy7XKND8UqS7quAOFdB6aJotI0BROF7
         lf0A==
X-Forwarded-Encrypted: i=1; AHgh+RpfmIwTwcCG7uPeQBYVgk4ajAj4cL6DC+XS7AirDJbEFrMPFrsF4m8LGwk9aT7MbnKwbuAxSas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IXwn/Ng0h69wxOE9w0Ejfkr0rGJDgc0xyjAn0TFQ6BJOfvV+
	+cTxfetCZouVsy21cZHXf3PZaWY9RwUPIAw0nbZdZFK47a+u9mp3D0Gj
X-Gm-Gg: AR+sD10kHJK9EzLZFMrAHr2xoXjk9NWrH2HmdPPvmnOWD6IEk+3M4++Y4hwKy0/1d+R
	aXRuXsudDu48PvV3DuM+jMX2u062TLwbbNhrr+026QHE8FV/IGzbqnFEtmh0RIs89OfrtAuSbNS
	iYdFgRPxWGzeO59WBmdamhaXIeSU25q9OccNkEurxTtgqGG7iq5uEVxT3BGKYm/pCODksQPmmz6
	UYov3mKuGgUVCIObk4pFVrRwFd02HRXZlf0wTMlslZpYVbRKrikAgXq+8aYEnWgFMMGXdjR/YgR
	AxWaBJ6u4X6CNEwvvDwBhthZ60BDIHS/jPp/icXxFpzSLPUiVW7FYjGzxFlNG4nufet1mxbPhqb
	LXH4qmuy8zKR2L5ikTDtHH4SvKlYSBRGA2sfg77Pb5JmBCAmOFOsIn0Pi8wPSXWEppdo/789yyD
	uLuYMtGebdkgSPnS+GdXjeCNiuDgqcrk5Plu2K6laNT7Zod2HxifwMH8ljfhCzujKb+7s007TNx
	R+A35XTtR3nTRfV9SoX
X-Received: by 2002:a05:6000:22c9:b0:47f:e7c8:3fe9 with SMTP id ffacd0b85a97d-47ffd15cb0fmr12400790f8f.0.1786096590964;
        Fri, 07 Aug 2026 02:56:30 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm4830224f8f.18.2026.08.07.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:56:30 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:56:28 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Add ksock kfuncs
Message-ID: <anWrzACWnpfAwNJo@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
 <20260806182234.380833-3-mahe.tardy@gmail.com>
 <6a86c972-99af-4e35-9392-8776d57dbc9a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a86c972-99af-4e35-9392-8776d57dbc9a@linux.dev>

On Fri, Aug 07, 2026 at 11:08:43AM +0800, Jiayuan Chen wrote:
> 
> On 8/7/26 2:22 AM, Mahe Tardy wrote:
> 
> 
> [...]
> 
> > +	return ret;
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
> > +BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
> > +
> > +static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
> > +	.owner = THIS_MODULE,
> > +	.set = &ksock_init_kfunc_btf_ids,
> > +};
> > +
> > +BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> > +BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> > +BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> > +
> > +BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)
> > +
> 
> 
> I guess bpf_lsm_socket_sendmsg will not be compiled when CONFIG_BPF_LSM is
> disabled
> 

Yes indeed we can guard this with CONFIG_BPF_LSM as it might produce a
warning on building with CONFIG_BPF_LSM disabled. Thanks.

