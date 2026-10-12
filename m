Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFA4A5EAA
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820662; cv=none; b=cz4tpLICGJpOTLMU95w3Ll3wTLjxlECyy4uRCw15g9HOoOC1QFRFZgL/s9QCTdypQSTvI+gTHmzIgq/hICSWesF5rLy5D2MGp9nb2iIgytKJ/MD7es1eO2khm1lunHJ1Mbda7RjXPQWNw8FmRxH7dAx1RNmPmzwlVAG9JrZG804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820662; c=relaxed/simple;
	bh=xKMv7zdu/h5menKe8wtJEeGQA31ZWvZMlO5iNYVOftc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZtMWMK0xQt9fH4LUr1UAJdaKkge0AlYPf7NV1h37+qclojpjCiCh6h86rK4ymMlySiwEOS6FJkUFEuUDLaPf01ONX6y4bNHgy42Zifa+8/M7SeXS5ad+gd5w1Q1w+o4mpdgtKogAlXThC8OwF2Sh3mYXw9JLTH7Bwl/WNIQi5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RaWpHayg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RaWpHayg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcb1e5f9so205353f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1791820659; x=1792425459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Idiv+4U2FgCRq4dwCpw16/0Dk3laDwvMdRlPR+5trT0=;
        b=RaWpHayg3rb8ZVMfobSu6V4SFrHKX8Vdym1imBwrY3OJkUpot65j7vjypG5IOmlEBd
         nnVv8GqYaZytFvswBOCm+4W4IHAuQWZYGjSLJJ/kW3tYsti9zgpiI4BXc9ZeD+Z+ubTi
         le73wvDhlMyq9llXPlkMiKGj9TAilWuQ4VarjWodBG3CmvmRdGMZLHnCLilQBlcDMRsn
         T99AK59qqv6OyzCkxuUff8A3lZrDKQ5IgLsfJqS5TVSWkP2819fKhCSoYVZdH4kJCwaa
         Bm6Fgh2fVHiH7+/8wEqHDH3JOvDhocWQeib+j33/sKLtTxn0MWee+T5jZxDB+Lv6at/H
         A3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820659; x=1792425459;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Idiv+4U2FgCRq4dwCpw16/0Dk3laDwvMdRlPR+5trT0=;
        b=xBz4XKJ+/5Wi7OE7szOsE43ilW5aZwYACLvVSLq39GUBDVZTTsbma/PpEhv0PQ9Sxm
         Qb0XlSEWYT+RrdXo9MP7jUnF0RdffRl7iR6uHDrzU6FYDHnhdnS2hVxE7Y6GtU80pjKo
         v8GlRDemj+2mmutTmU3jo1IahBuOZJ7Toi2zaFt/yTBBRd63yL/w0Xi/dal4VQQMtioq
         cbk8ymMzJudgyIV1ZsE9FcHPFVg5KE1bs97iPeThnkY1p+Dai3YZzFGBe/rFyxWwt5Ki
         Uuqig/K0wtUw0sPCznJ1gECzEAXOatO7Xk/CVWLHpVoTrnDlfk0EwZUqIGNscxpJZLVL
         cHdg==
X-Forwarded-Encrypted: i=1; AKwUvBxzvEkpELNca72mQVZQp/7CESQGupKEUtl1JZT3WGs1t0xd8XzXGEnAQTrlGi1/1QMO94QhPdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ0xuseTL9XQ9plY0nklk1ezVISK0imPUEcTabXH8ZWAxDn3d1
	+hWh0ay9tnp8zxHwEZiUM5NB+eHw3GNcpGqjenAhHtZDb3tKUbL3x2P5sv1wk64MV04=
X-Gm-Gg: AYBFou1VpYTuL4SFYj6rGTBHzid+FjBcGf+QMm03HMrCDeoXWAyOaYISXFJWAMkgYR8
	o3J+QPvySHo716hrTefI/d2IlYc+OVXJ3oASf5bY1QOYQAW+cKlcDyOhRFHbhNlBu0GuYOwMEVz
	QKhmKqC7sX8J2Cy0PINchbeLWRtnQlgEo6kO8C8NFYjz1Jm1uLiA3w1EM987RwpG0emK+xLeQQL
	A4TqQcjePIjNMeRHGoJgq5OpXKdD9bNaPgGVohBgT6sUSvczViQ7e/zpBmNuVrhDgJP8FQiRjxw
	ZFjv+iT2kNS6OSyNQw5nXeKV+7Kkbh/wEVtuIiuoyHpS5JVdVtg7dVZMbkVImshiTiMD/MMeNjV
	BMzLq5ErLAXOGEhYeT7iY0000rs/S6Eq6QomtAr+8M2c2migkXHqw4evqMSl/swNX7Dt7kZb6X4
	VKTIulrpLUKtko31zWvi5KicygHLt2nW48zkJh8PUsXAN2WROOil/UATYyfgBcBm0f119w0DuRD
	++OrZEJqiKxiYk9aJGVzShY5EC32g+CJAqYBpdB/udtlTmu7Vc=
X-Received: by 2002:a05:6000:4911:b0:48a:f41d:846 with SMTP id ffacd0b85a97d-48dbaaf0956mr17339713f8f.3.1791820659280;
        Mon, 12 Oct 2026 08:57:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm380597f8f.0.2026.10.12.08.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:57:38 -0700 (PDT)
Message-ID: <b29c6e63-18e4-40f6-9332-204cb151c3a1@6wind.com>
Date: Mon, 12 Oct 2026 17:57:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
 acquire/polexpire/expire size calculations
To: Adrian Martinez Garcia <adrimg3196@gmail.com>, netdev@vger.kernel.org
References: <CACO1+RQUrGS3VN-hrdKk+BK2uuRP7J_Fyadahz1QpO00JXyw3A@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CACO1+RQUrGS3VN-hrdKk+BK2uuRP7J_Fyadahz1QpO00JXyw3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/10/2026 à 16:39, Adrian Martinez Garcia a écrit :
> From 534cb2b5fb8da81677f2955aac8a98d9aa89694b Mon Sep 17 00:00:00 2001
> From: Adrian Martinez <adrimg3196@gmail.com>
> Date: Sun, 11 Oct 2026 06:53:31 +0000
> Subject: [PATCH] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
>  acquire/polexpire/expire size calculations
> 
> xfrm_send_acquire() and xfrm_exp_policy_notify() allocate their reply skb
> with xfrm_acquire_msgsize() and xfrm_polexpire_msgsize(), then build_acquire()
> and build_polexpire() append attributes including XFRMA_IF_ID (when the
> policy if_id is set) and XFRMA_OFFLOAD_DEV (when the policy is bound to an
> xfrm offload device).  Neither size helper reserves space for these two
> conditionally emitted attributes, so for policies carrying if_id, mark,
> pcpu and/or an offload device the builders can run out of skb tailroom,
> fail with -EMSGSIZE and hit BUG_ON(err < 0), turning a netlink event into
> a kernel panic.
> 
> build_expire() has the same XFRMA_IF_ID undercount in xfrm_expire_msgsize();
> its caller already handles -EMSGSIZE gracefully, so the only effect there
> is a dropped EXPIRE notification.
> 
> This is the same bug class as CVE-2026-43107, whose fix (7081d46d32)
> only covered the aevent pair.
> 
> Account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in the three size calculations
> unconditionally, and replace the two BUG_ONs with normal error unwinding,
> mirroring the aevent fix.
> 
> Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces.")
> Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
Please, keep in CC people who have made comments (me in this case ;-)).

> ---
>  net/xfrm/xfrm_user.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a2587c7e..5eb79b0b 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3927,7 +3927,8 @@ static inline unsigned int xfrm_expire_msgsize(void)
>  	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
>  	       nla_total_size(sizeof(struct xfrm_mark)) +
>  	       nla_total_size(sizeof_field(struct xfrm_state, dir)) +
> -	       nla_total_size(4); /* XFRMA_SA_PCPU */
> +	       nla_total_size(4) + /* XFRMA_SA_PCPU */
> +	       nla_total_size(4); /* XFRMA_IF_ID */
>  }
> 
>  static int build_expire(struct sk_buff *skb, struct xfrm_state *x,
> const struct km_event *c)
> @@ -4177,6 +4178,8 @@ static inline unsigned int
> xfrm_acquire_msgsize(struct xfrm_state *x,
>  	       + nla_total_size(sizeof(struct xfrm_mark))
>  	       + nla_total_size(xfrm_user_sec_ctx_size(x->security))
>  	       + nla_total_size(4) /* XFRMA_SA_PCPU */
> +	       + nla_total_size(sizeof(xp->if_id)) /* XFRMA_IF_ID */
> +	       + nla_total_size(sizeof(struct xfrm_user_offload)) /*
> XFRMA_OFFLOAD_DEV */
>  	       + userpolicy_type_attrsize();
>  }
> 
> @@ -4236,7 +4239,10 @@ static int xfrm_send_acquire(struct xfrm_state
> *x, struct xfrm_tmpl *xt,
>  		return -ENOMEM;
> 
>  	err = build_acquire(skb, x, xt, xp);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
Silently dropping a netlink message is not an option. As this fix shows, if this
happens, the kernel is buggy.
WARN_ON_ONCE() maybe, but it should be done in a separate patch.

> 
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
>  }
> @@ -4307,6 +4313,8 @@ static inline unsigned int
> xfrm_polexpire_msgsize(struct xfrm_policy *xp)
>  	       + nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr)
>  	       + nla_total_size(xfrm_user_sec_ctx_size(xp->security))
>  	       + nla_total_size(sizeof(struct xfrm_mark))
> +	       + nla_total_size(sizeof(xp->if_id)) /* XFRMA_IF_ID */
> +	       + nla_total_size(sizeof(struct xfrm_user_offload)) /*
> XFRMA_OFFLOAD_DEV */
>  	       + userpolicy_type_attrsize();
>  }
> 
> @@ -4358,7 +4366,10 @@ static int xfrm_exp_policy_notify(struct
> xfrm_policy *xp, int dir, const struct
>  		return -ENOMEM;
> 
>  	err = build_polexpire(skb, xp, dir, c);
> -	BUG_ON(err < 0);
> +	if (err < 0) {
> +		kfree_skb(skb);
> +		return err;
> +	}
> 
>  	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
>  }

