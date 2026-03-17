Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178F22A817
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709030; cv=none; b=KR0kUuzuCR1z6RMWKdMyhkCylm8E3ZTemyv0W93kfRt/vvWLtXmc2YvQ4PSgjOC+5Bn4iSSkM5O7KpRsqq+BrsPjiNbpw/3ND2pn2nU+OCikp0+MmthcWyzXod594b309niZ9rIgkzoZNYuO4rPun2dMqyo0+sjt0jEXA3+OI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709030; c=relaxed/simple;
	bh=GNdXghjIUPXv5/Ug9r40AmUxdNrpuSB+mchA4uzWK1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqtzmXrCElIMaGiqy2xAarABvJqLA2Lb9GLEUutGiCqaz8c/vDJhJJc6o9fx8I56jL4JpZffYlyu1SUQajYzu28zoeDpHSauSjBqL4UNLalmHd7ATg7Yaa1fsYHa8x09Qd4OX+jugPPWm46GrC3cVzG3e6Jhg7IgMwlOgKAU5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qdtXKaJG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qdtXKaJG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a9d08644so3003229b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773709028; x=1774313828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcVegRA0Q+OmcusN3+FZjnJE53InvZUPxvttB44YyM0=;
        b=qdtXKaJGQpDKqISzoml5L0IjKpnYJQSr1mllnm8OcDcLbFxa1eOrm9B/v3v+Ky8p8F
         OMC0BuEh5K4mEutH89X4cESmuSbZN+KRzYo6Bq4A6n9kKy6YpjcCnacC1LXDQhkfyr84
         qwBOJG2fHFKwys4D2k0+fSLuuXgbOeUJG+Gff7ESWnRcsXZBmz4FcEFkRrs1DwuC9yvv
         Z0YLXb2eOL+Y+QBlDOvxKNgjXviCTsH6bq+iXj3z4zVwFD8AoUAKpyA2qDCoFfeGZVmx
         ox3mxjMJCjnK2uJSvvn2oRx2Cq19PcEil1OC/ob/4MCpsPMBoifP4FKGy5yj/n52UyeT
         jUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709028; x=1774313828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcVegRA0Q+OmcusN3+FZjnJE53InvZUPxvttB44YyM0=;
        b=KjxDaU5Kj0HvPzsU204900606AXL39U1/Y0uDWjEe9kOaxCVhPmZd3TDuwlEdpl177
         f4IJROoH2BPMuGR8A81CkEGt21gQGnKC1EtWY7yA59PlBo4JRmsUuz8EM7+PDBUNh0Vt
         Q/wHepkSiw9vEcd9zjWX9TITXilTpFyynZgvMM7icHj2Fbq/jYAofgsGgtCOSUlC/FIw
         0E0Sc0brqlw+dZVDEkyB+g/PRgmFWJXCm5ScCTwxxkTtzzGKzcKFUYjjysC9ovYYlum+
         vQ/2pRYi0IxvvMqVOJwTmSLZZEJP1QZl4Jjp7YWQkAIgrI70pMKHDYsSvMwFQwBXu3jQ
         GlCA==
X-Gm-Message-State: AOJu0YyyM4r6dBBsI/5+oBJWBJ+dbWPUPJOwpf72KAGBkHpMt3OTYVcQ
	pr0qPBSSEUysDB6s3egu9Y2ZABNfeaDTMY1hpMlT3R6M5N0/aRr2Y5hyQHkPQpm2JFs=
X-Gm-Gg: ATEYQzwo+nzeuQCO22XwpXNCnw2NJihPsrPrloZBbQtx24DhI0/jSMpw5GNUz8+cgD2
	daYN7aDwwiA+zHIB//HIqfWYfAe9oqWDfwebXPN45K39F7s35xu/DJvs67Fd+ZIKk27pleG80VQ
	7RayZIg835jDrl+9HkkY961FotiXQP2W9RxLe4o6BBPClvNBCkpBCJ3/DkiofipKHF9M5OmnUWw
	vlvc3HJuLUryql0JLshMelgnm+5u8mV47CIYwJhJa9/RkKMfMY8pl3kMN/QnYFBdbOCC4eemxjw
	YeRbH8BnGketlLENDNgFt9VIxqMEC+KO+T62qOwupK/Vc6zIC8/FfPe0h/KfV1V5oNQTeDhdvIb
	k75ln6Qs9SdKK6i47MnIxQg91QvYrwmgCwwKglfSmWk4dy9AS/8gX4klGF5wIpiGPIS1yNP+SuW
	emxnvsMGwTMAQw6PVZ3ME3zjPyLkphclRkumKeKvlkBPR1zO4YWHDunkm7+m99X1JJRESlb8e8g
	K2dN1boS8mGMfY5agNYxg==
X-Received: by 2002:a05:6a00:1a07:b0:828:d9a1:c604 with SMTP id d2e1a72fcca58-82a196b5aacmr10581871b3a.12.1773709028388;
        Mon, 16 Mar 2026 17:57:08 -0700 (PDT)
Received: from stephen-xps.local (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm14556485b3a.4.2026.03.16.17.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:57:08 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:57:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu,
 pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com,
 toke@toke.dk, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 5/6] net/sched: fix packet loop on netem when
 duplicate is on
Message-ID: <20260316175705.2ef5004e@stephen-xps.local>
In-Reply-To: <20260316211052.332383-6-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
	<20260316211052.332383-6-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 17:10:51 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	skb->prev = NULL;
>  
>  	/* Random duplication */
> -	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> +	if (q->duplicate && !skb->ttl &&
> +	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
>  		++count;
>  

Would prefer that if ttl is exhausted packet was dropped.
Rather than silently not duplicating.
