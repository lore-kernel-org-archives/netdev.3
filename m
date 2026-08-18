Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02583B2FF6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046100; cv=none; b=CoQW3sFyGfY4mCp0qGJ0zXyLdJ+5BaHqZG9gGvA0q30MI1QGPPG78KErvkd9cbrNaRlgo+7XQfkIFB9KKLEfDODohJcIEDKXKrRvzjhnKqGuIMWxMRpyqcKgo1RMdholyPo6uDh7noNIiVdaTwO3UMafP7vAXejDu7es0u1ow4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046100; c=relaxed/simple;
	bh=vfgng9ZglCJyc3E7838Qig9DkDZ0/h5KerSQ7KI9jwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrRIhuA/KjlHJAopm2SaMd4O5ZzAUS5A2yRgYk2pCvOczua8cqGGl+45ztg6d6ko82KlOBlKyC1vhTAFuQIdt8k/nUlFe2J4z3mfvbf8u8IJrtzSbnPBtAZ/4PKcBE8IS8BMaeq2ZP4yF/gYHkj2BTJV+iVIMSEvx9UOSM8y4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/D0UhfP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvfdYv0h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/D0UhfP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvfdYv0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787046097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C2R+ScqNpagejYF3qSRkLBdFoe8t5Vymo31Lzc0nJA=;
	b=E/D0UhfP6v4CFyqzGJPzLS9HnGfX8Twcj1p2y341PAkVymE/vJDVlZ7iw6UxbXn7bGYLzk
	AQj1nYXceoaNyNnODpyp/vzy50jtDLnjeBqA9X9Co/vg0rFxIfHQs13M3WkBAe5+0GPUZE
	cMGuR+qcXsV2nrZKY4fqxduuXUwVV1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-GeMgbBiTNiaov4OzSPrUpw-1; Tue, 18 Aug 2026 05:41:36 -0400
X-MC-Unique: GeMgbBiTNiaov4OzSPrUpw-1
X-Mimecast-MFC-AGG-ID: GeMgbBiTNiaov4OzSPrUpw_1787046095
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so29219525e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787046095; x=1787650895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1C2R+ScqNpagejYF3qSRkLBdFoe8t5Vymo31Lzc0nJA=;
        b=FvfdYv0hbJYReaQ3wnfLUqnzsg0ygZfqfShlzRmzrnrrGyqoq2GX9vheStkvTKEooI
         QTdLhvXaW7ocigMTGxGmyG3V1eLJP4vtgANmMckym2Sov1SKXtZSzgf34GZGQrXWoEFw
         0V52ihXeScAm7Bwinmngq52QLZ44lWUuS3ktcTcl11Ig0GqhCs1zyBenOhxUB69icjuF
         CGCvvYjaS6njnTCHyoRq6SZWjksJZlFJATcrsQuXtq74YWRf+rRBrRrka9lIHDh9b807
         HxZ5MePHGReNTE9rkrLPsEmtBNOwj2FgNTfJM+k+4z86Dw49eXvQX3p7Si4Syfs7wCJm
         E2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046095; x=1787650895;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C2R+ScqNpagejYF3qSRkLBdFoe8t5Vymo31Lzc0nJA=;
        b=SAbdgg1h88gINT/dfMNluTqGVyE/bSbgdGpLBLtEDWbbxpLeNTmlbQZur3xeS0etiC
         IoAxSFYQn5wUl8YSsDLfomUI14dVBxbP48mlOR6I1woOupMwc8jJJEy0Pk8T9IY0BT6+
         8iRA/sfZ2Fxj7OmcUS9Wt0baE+HKT0dvElkoc2qEvgcZzaYwnnCgw+233PkFKEWCvD1V
         XE571D52yuW8sV0xpPpxG1st15pwMlR6RRtT7nWiEpV481zOos4D+AhktOB+STQsi6pg
         Y4e49kBcEfhE3NpXNypg7ZksFzgGs0Lq/w0HVWtdF62W+rj+54pciw7VX5QGCyhfiTb+
         GW+Q==
X-Forwarded-Encrypted: i=1; AHgh+RouChskvUl+kc1vQS4CnkX6dFqU8DjWwjVoAXwh+FomTvTYTMDD++ooz6oB61ldqNnmeE/B1J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFvAA82y16UBGCbfS63+3sVLu+DFrcBdIlwIki87g6ceD1K3p
	d1dBzYmm+RnRIcGRULyR9bWhvFBh8974joJWboTmROZ5xBIRuAW1gWdl5WUAdzEM9Zo8RXB2dHl
	5PNON1mEmL2o8CUGnisdjQLB6L5h+kPuKG9v1/tpwMWsuKWdBgbwvQcYwtQ==
X-Gm-Gg: AR+sD13oVOn5dlaQHpR3Tx7mPNxWuPqLho/iPHVQBXznlKJQiADLrWn0LD22Ft27WNs
	UxX44KWh4CB1NrWimSn8ZqdBYSGPPQMjMrsDIkSl78i129R5bhQXLAl6RDo69mTRQyn4Zv3ZyWw
	HhQ8JVmhtvT6UB6xM0Y/YoEKgVeqZz6m8YSjPlENykh+y7992qELjGnYTiEt15S3Y3sVFJGEihw
	44FoarMLb6AySfcq/IUOE8Qs3tSQ6+Uir7QTXMGSyNHDcGfP9yA17uySNQTclSwfhWKGZyRwQqv
	WZY399g+bQRXsDkXEonYI7kMI/cbnyZI/0wRi5RMx6jkJIN+AJd3T8OyJ8Q+buP7UgBGlyzaRVS
	M+ug2ncsPvxZEXpTlYbfFcZMzXuapFAYU9yaea4EiSJS0GtfuO/sphhR2EcPiqcqS/N/DQJqkjK
	0=
X-Received: by 2002:a05:600c:3491:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4999fb3be75mr127179815e9.11.1787046095193;
        Tue, 18 Aug 2026 02:41:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3491:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4999fb3be75mr127179055e9.11.1787046094827;
        Tue, 18 Aug 2026 02:41:34 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b278fbsm216576185e9.2.2026.08.18.02.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 02:41:33 -0700 (PDT)
Message-ID: <83a768c4-1200-4baa-bdc2-9d20960dc6d1@redhat.com>
Date: Tue, 18 Aug 2026 11:41:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/sched: cbs: perform rate conversions in signed
 64-bit arithmetic
To: Jack Wang <163wangjack@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Elena Salomatkina <esalomatkina@ispras.ru>
References: <20260813060256.28748-1-163wangjack@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813060256.28748-1-163wangjack@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 8:02 AM, Jack Wang wrote:
> cbs_set_port_rate() and cbs_change() multiply link rates and slope values
> by BYTES_PER_KBIT, an unsigned long constant.  On 32-bit architectures,
> the multiplications therefore take place in 32-bit unsigned arithmetic
> before the results are assigned to s64 fields.
> 
> For port rates above approximately 34.36 Gbit/s this wraps port_rate.
> The same conversion turns a negative sendslope into a large positive
> value, reversing the CBS credit adjustment.  This affects software CBS;
> port_rate is also refreshed on NETDEV_UP and NETDEV_CHANGE notifications.
> 
> Cast the first operand of each multiplication to s64 so all intermediate
> operations use signed 64-bit arithmetic and preserve the value's sign on
> every architecture
> 
> Also reject a negative idleslope. A negative idleslope can arm the
> watchdog in the past and busy-loop.
> 
> Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
> Fixes: 397006ba5d918 ("net/sched: cbs: Fix integer overflow in cbs_set_port_rate()")
> 
> Signed-off-by: Jack Wang <163wangjack@gmail.com>

No empty lines in the tag area.

> ---
> v3:
> - Reject only negative idleslope values.
> - Keep idleslope 0 accepted for compatibility with existing tc-testing
>   defaults, fixing test 1820 regression reported by Victor.
> - Keep the timediff_to_credits() overflow out of this series as a separate
>   follow-up.
> 
> v2:
> - Reject non-positive idleslope values to prevent scheduling the watchdog
>   in the past.
> 
> v1: https://lore.kernel.org/netdev/20260806155253.50252-1-163wangjack@gmail.com/
> 
>  net/sched/sch_cbs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
> index 1c93469c56e3..8db98d7c98a8 100644
> --- a/net/sched/sch_cbs.c
> +++ b/net/sched/sch_cbs.c
> @@ -335,7 +335,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
>  		speed = ecmd.base.speed;
>  
>  skip:
> -	port_rate = speed * 1000 * BYTES_PER_KBIT;
> +	port_rate = (s64)speed * 1000 * BYTES_PER_KBIT;
>  
>  	atomic64_set(&q->port_rate, port_rate);
>  	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",
> @@ -392,6 +392,10 @@ static int cbs_change(struct Qdisc *sch, struct nlattr *opt,
>  	}
>  
>  	qopt = nla_data(tb[TCA_CBS_PARMS]);
> +	if (qopt->idleslope < 0) {
> +		NL_SET_ERR_MSG(extack, "Idleslope must not be negative");

Sashiko noted this isn't enough to avoid the busy loop timer:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260813060256.28748-1-163wangjack%40gmail.com

I understand that a 0 value must be accepted, but I think we need either
a better solution or drop entirely this check that does not provide much
value per se. I think the first option would be better.

Also please note saskiko has more comments.

/P

