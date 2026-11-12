Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492118;
	b=3b5+FPeyGFioVqSGXe7JY9jjgYUvzQc0NFqMmbjxg1fek2ZSJfd77uTiAKIHcgEgd2N3
	 9f5Pfwgh80uxDaM5OoGDkd+r9egucQQ3R4EyBH2sCJGE1++dNtsLRZhCvu+lYbZf+mxcw
	 CzxiKIA0zsWrAW6dfxdnpQM/amWUhD9Lj9w0gFflHZbUsiUsmdN5kcJTUXfKfFlMahZ8a
	 YwFRTUsHQLp/xyEmglIQSf1vD+bzSsXiolA19niP089o2rTdv1TVlQtyDBVz/wkOMydJJ
	 dl1kSf0c8JEL7TUqEJlHg19AAuuAw3PqmdNXRrZA1eEC0DvVueI7WBI3T8MH7epZpIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492118;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gV8G4W0YWRad/zD6wWzKZizxNuK+W5XaHJDr3NlQpVk=;
	b=rM2QetIYiblVUZtBFJweKA+4g6KZUF6YR/trrUCm4FXfIhFDEv6zv/ix04d5lkGt2oFu
	 eQ1ka/KATC/pGX19tD3fibWql8hmpnhu6iaeb2ulXs4FOyketopaQO14Pa79gE3Wmau7o
	 DYakkle0LCk7SeVadxdrnxTZH9LDRhBUSxb0zg1xOG4eY8YJKp1nrW+cSpRNLpChp3Hyh
	 N15GtNpmaPClfvUXhPY1dMh+bB/Ep/xBSq7ff8mKt06GxN7ilmKw8tikf+vb0qU74Y7v9
	 v3tN+QRzBb+5JLBHGKANmqzPbXrZQcB+SccyUEKK4PXzctb4CBH/K4P/juEQv0yQVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E97W+MMc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0eUc1ex;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E6606A330
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 756E6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E97W+MMc;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0eUc1ex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794492116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gV8G4W0YWRad/zD6wWzKZizxNuK+W5XaHJDr3NlQpVk=;
	b=E97W+MMc3JROV0WYWaXZXrmqdOplsBaZ3FeOt/l+iMP86ompntO+BReaH7sGt+1pioNlct
	WRqJdPGHx5LG1icFH31EK1jCbFY4PyLeETGIHaen4gAciO1e1GWz1twpZbRBKYPGO8stEJ
	Eh4eqf+JNgrYyhCc86uTvlO0vqqsWoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-7LB0usfjOv-Efn801ig-0w-1; Thu, 12 Nov 2026 09:01:55 -0500
X-MC-Unique: 7LB0usfjOv-Efn801ig-0w-1
X-Mimecast-MFC-AGG-ID: 7LB0usfjOv-Efn801ig-0w_1794492114
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-492e3189fc9so3046633f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794492114; x=1795096914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gV8G4W0YWRad/zD6wWzKZizxNuK+W5XaHJDr3NlQpVk=;
        b=U0eUc1ex2c/a2V0k17Util3Hqrlgb7AUG0rw5l9grJjuTIUVCRHISKeS8e3j1fRfBn
         4Ja7O4Xpkb0GOh9heAdUzdVlu/BUwzSdA1OtmvSop1KKVUzWXl9StuXZRFKajoRSZe5V
         o9RATl0Mq6/7cuVvUuzo5IYNfAHVe7Wepco+rPbrLa2n6XYRDj0NTc6g/0t8VdSQqOx4
         WHsp6XXA1McbDeniDyoDdThTzJpM7krRMjVgVPV6m+dt84v//Ko6JU3jymmrhBt0/ViK
         oljGzeZCNrdfC8w3EeDjsxAUCUUCQjQ3mZWVfv3/uGmN/Inc0wB0OU+gcVdFTUHqGAB+
         OWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492114; x=1795096914;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gV8G4W0YWRad/zD6wWzKZizxNuK+W5XaHJDr3NlQpVk=;
        b=2TZCG2PBBxsZqub4kR+23MPz6G8ywjgXuf5xie3TshTYnFn66JmE9vRqyMDiiN4X8n
         3UKjJfJnkePXxxkEBlxXeGjY5KVyhGvFjLQIM6iSwgB1O4Q5Fpbg7EJb2DUktrJgR/dM
         Pt4uFbZAgWkawPrxbpUZAD0c2XL4c4LhdB291aLw6wuNsNvsgIQv1AGhftm1DgqgGeww
         Gnno4EEy50Li+b+Zl7yKe+LXyq174Qq63FhlRbc97dL2FT2u5HkcPa/GqS2KfLVMr7M8
         483Pvmd5vDWMqY8Y0st2GWCmHZOXeVQkQcfYvjTLYYmFtvZNPBy04MU3wRBmnciv4iMc
         2GLQ==
X-Gm-Message-State: APuU4Z9uxJnSiPo70Skgjrn+kMHo4MLJE0fAHS5EB7xy9NVILfTTqsab
	CNS/hrYazHG0V1eEBwYBpoyH189+FJj8zygFiuu2wAR8HiRMYrlC38lAGSRYRDeV3QPVGfJWM1V
	R32EBnaBdRMRlygRaD9Fj8GJCa9qg3FS5PT/fp6rGuRKPAGiGUZKdP0hnKw==
X-Gm-Gg: AYBFou1vNerAlpq/k6vuyu5cQoZc0qBuqYO2nLZKfiuiSJaTb1UXGMMHMUw64AZi5I3
	p0ZGdppAdjZ1eTsNRiB2xb2v2kHiV/Wnyxj6lfM/DcUEzJfq/AYdoR7hQ0nzDISdv3kMALk+zea
	DsCDbT3nClCngbTnowkPDWOmgORflZ0IqpcOKv4f/xkGSbUybhpAM+nxCVbm+TvyOyCMEyzM7Wx
	WjSLcEznc/jZYTdERV6tJwS3MExwvg88szXbAtCcyMfWdqZehr8N6gW5Wt7WVyQFwElPQN4dpy4
	dG1i59IGTqn7TvvmAqDc0jkDmAFv/UnGrxbxdxdXW91GeaiJuYxbIy6HFbLs5lZy8T2eAlSUBBq
	BJ2aIBRvmAL1mrQkgUxxUtTorZMOZUkxxl/0cW1Y70iWlt5Dumg1OrZ3OsDxsVhrYKiOmu0YrtN
	G2UVkTO2uasiy8tZCw2ptLh49z7hhX+6vgHWI72r0h90rw
X-Received: by 2002:a05:6000:4a09:b0:48f:e879:5890 with SMTP id ffacd0b85a97d-499c7368708mr11082445f8f.32.1794492113654;
        Thu, 12 Nov 2026 06:01:53 -0800 (PST)
X-Received: by 2002:a05:6000:4a09:b0:48f:e879:5890 with SMTP id ffacd0b85a97d-499c7368708mr11082383f8f.32.1794492113165;
        Thu, 12 Nov 2026 06:01:53 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c027sm16739469f8f.24.2026.11.12.06.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:01:52 -0800 (PST)
Message-ID: <e4149337-b7d0-4797-8ec4-dab696af11c9@redhat.com>
Date: Thu, 12 Nov 2026 15:01:50 +0100
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
Subject: Re: [PATCH net-next 1/3] net/sched: act_gact: size TCA_GACT_PROB
 unconditionally
To: Linkui Xiao <xiaolinkui@126.com>, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261106064114.3592670-1-xiaolinkui@126.com>
 <20261106064114.3592670-2-xiaolinkui@126.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261106064114.3592670-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 07:41, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> tcf_gact_get_fill_size() reads tcfg_ptype with neither tcfg_lock nor
> READ_ONCE(), and budgets TCA_GACT_PROB only when that read happens to be
> non-zero.  Both halves are wrong.
> 
> The bare read is a data race.  tcf_gact_init() writes tcfg_ptype under
> spin_lock_bh(&gact->tcf_lock) when an action is replaced,
> tcf_gact_dump() re-reads it under the same lock, and tcf_gact_act()
> reads it with READ_ONCE().  get_fill_size() is the only accessor of the
> field with neither.  act_bpf hit the same problem and solved it by
> taking tcf_lock in tcf_bpf_get_fill_size(), with a comment explaining
> why.
> 
> The conditional budget breaks the rule that commit 4ba61bfd4998
> ("net/sched: add get_fill_size() to the five actions that lack one")
> spells out: "Size every optional attribute
> unconditionally: reading the current flags to size it conditionally
> would race a concurrent replace, which can flip the attributes between
> sizing and dumping."  A replace that turns tcfg_ptype from zero into
> non-zero between the two calls leaves tcf_gact_dump() writing a
> TCA_GACT_PROB attribute -- nla_total_size(sizeof(struct tc_gact_p)) ==
> 12 bytes -- that was never budgeted.
> 
> Size TCA_GACT_PROB unconditionally.  The budget becomes an upper bound
> again and the bare read goes away, so unlike act_bpf this needs no lock.
> 
> Nothing overflows today, so this is locking hygiene plus conformance to
> the rule above rather than a live bug.  All four consumers of the value
> -- tcf_get_notify(), tcf_del_notify_msg(), tcf_add_notify_msg() and
> tcf_reoffload_del_notify_msg() -- allocate at least
> max(attr_size, NLMSG_GOODSIZE), and the delete and add paths add
> tcf_action_warn_attr_size(extack) on top.  NLMSG_GOODSIZE is
> SKB_WITH_OVERHEAD(PAGE_SIZE), so a batch has to carry enough actions for
> attr_size to grow past roughly 3.7 KiB before a 12-byte shortfall
> matters -- which is the failure mode that commit 8e2efb3f45a5
> ("net/sched: add get_fill_size callbacks for actions missing them")
> fixed for other actions.  A replace cannot interleave between sizing and
> dumping either: RTM_NEWACTION, RTM_DELACTION and RTM_GETACTION all take
> rtnl, and the classifier path, which can run without rtnl, computes
> attr_size in tcf_exts_validate_ex() and discards it.
> 
> Tested by building with CONFIG_GACT_PROB=y so that the code being
> changed is actually compiled; net/sched builds with W=1 and no new
> warnings.  Patch 3 adds TDC cases for the gact dump and get paths.
> 
> Fixes: 9c5c9c573700 ("net sched actions: implement get_fill_size routine in act_gact")

As nothing really was broken, this and the next patch do not need a
fixes tag. I'll strip it when applying. Also next time please try
produce more terse changelogs.

/P

