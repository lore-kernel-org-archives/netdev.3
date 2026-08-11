Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F642DA23
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445026; cv=pass; b=ev6areQBIKDJJF/ZL6/Bhb4ZPxN1nE+tnhrPKo+au7OyHd2pLJPz8G6VGz0nW1x9tmkrDc04WvxGXG+S8ynjQsIpe+/F2g4WlAYXVOa8U+7Y4nhHIR/MeQO+O+2aAO+LmY7uccEoNC42iA/pwYMGVNu6WYu5bKv+IaWIGmAzslM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445026; c=relaxed/simple;
	bh=1Oc64gMDjytZEdqM1LZNVQuclN2jmmuxKaJUiRRW3Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON5Vaescg0LxrqxtUn5CN8hJz8gEwWBd3J05nGgnof6M11GpzaTSZsTkanscHtmJjwekzAd1ozcHb9Av/QO3ak5lbu+GdLeMgib3q+MlycXzrxV08mK6Nm9OavIb58ZecI16y8TcipncV2EfhLfQPvcT5XVrm+O6Dp7Xr+8nSQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mz8bpy7S; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mz8bpy7S"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84874b52eabso3668773b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 03:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445025; cv=none;
        d=google.com; s=arc-20260327;
        b=bzBy10ULdJfTZQAMdhNFfJbOlgArB1X+ka1xybkgtouUuqSleYTzifis+rmCfrD478
         UBalQ2flX4h6RxXAHyt4FH3qLBOZSZYbqywaYPIbbeqdnhMM0ANIz+b5VnY03RjS5AbT
         Yxx63KychxsBKHUB1xe+ngEST7kr6vRBN5drZAUsFX+hSMjyLU4z2O/BRuC+EO4rbU6d
         Y+x1PfvC238nv3drfrDJcsInNagfjC5D7eiwgNe07hJtxRqMQu8Xz+u4gsixMqyaVozi
         MGG14CPlGcJLHEbo8xYR9pmeTfVdOev+BYOFnDwcsBhj0FTsaXpKTX2s8PHOfWM7FZJZ
         Ru+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        fh=aBWm6Mgn47ZMPa4Eh6fbLEEeqexrTiHBigRWjdIxmUs=;
        b=NtiE6LHJsrXqbXLOCGz9Mhr6BQP/dhADkLnpTfU5VxTIKuEU9fK2nS3Zo96NrW+oVA
         3Frg4O6qQtsT4O+xEAm81X7a9IQIlVqJaEJ4tTG3J7ywJzuYz+7CGcThoR39cDJkQipI
         Qb2sM7u5dXSc/5q+JzJpsUO4MlBPTicUPTlrBOjeP8X1WbHHu9QpKK23pPvDDePhkShp
         iY6zfSu8sMYi06QcQi5bFaL/ji6jLi+NkhxSCPfN5W8v+AtawGlS03LJLAHAUyifH7Rj
         g3znvOkAknD3zcRm+WqeEjvPYq+3s5IhfxgmsU98gWnhbZzkzdBHDVllEcABOtS5HZIo
         lXJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786445025; x=1787049825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        b=mz8bpy7SQ/BawkPlsDftz+2e1doFV35K+D+Vc2MiDjWCSLqR2dfIT/IWlbvozBxblb
         Q/MSMkKZcmGpYOWCTG8kYilRNXYfKRYhGf8k2/2rlnbly+reXVERdR1fNwPxKduiVjJg
         XsiIayyn4lBlmiG0hXSxmdaXtJERTVZLI1H9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445025; x=1787049825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        b=JsrQejcDXl++yLO6BYmtnBDuZ/tEXEUB8adDJ4jqkNzHffgkzWEnf2Mncv816O/3zN
         o7wE46qngtyDMhd2dyXPN34DsUmDGTYOxKWTvAbsZX1h7Jo1GHW+4ikDNgNuzDFgqjU6
         05l5AvU4S0KiB/Diom6Td4Vr/BKuYQRHCu98ZHkwBbda8kkCRQJAWdG/61ZFuId5WH/A
         7o1H8a/45jGFmL7ApvnxlKPjHcGQe5qpr4r8g9A3T3pZC1B312d0KWkYOj4yOZjtMghp
         X34XRw8gmHUhEJXH3v/opxxckq/viqYC/zOOQGmSBwR4A/ket0tG8Y2M6mB8vY4SXKq7
         yJOw==
X-Gm-Message-State: AOJu0YywffE5Jfen76U1qEQTRPC75wDwZD/eBE4WJr1HWUxtd415sr+V
	wFV9w9/xNbUS3/WYa4UEW0pY3iC4gT7bDyxvJMh6fQpCE1lrSItUmBIXsJyKLkVOg03IZ2N8xRa
	nxbXNY/xAUwkPw1qOK9P2GInZyOEIR5II2xjl9wZF
X-Gm-Gg: AR+sD13I4fWrRcM+eIIF31kWGNdfhzG/xCkztrn7MOJwoe8J2dpH3g7s9lF5c3jsGX6
	5tzyNVi3SoxEoBmrxIMG4Uk1RVrx3UZAbl/Rmt1r5sn5fHbEqMtGG6HsPIntylTPWwMB0llPKCa
	U1UK6UO3Mv5tJWI/MhMThLtsvIcPhx5KVceKt7InKpxQn7yqbALKbgsah+aM1uEMAO7/CuvH3w+
	LA6+T4bgM7xrILozRYPHj+GIHIjf7XsJ8NWA13hrqduJeldUYsa5O6AKwSUWdzYewOJwognKc5B
	KRDaTs1NxK+Tda1ma5fu+zBQYSD/JOjj/DMnhElk+0XURGIbI1MNLFiH
X-Received: by 2002:a05:6a00:6ca7:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84fa8835fa0mr2386611b3a.21.1786445024406; Tue, 11 Aug 2026
 03:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809090928.868186-1-jhs@mojatatu.com> <20260810164536.6ecf043d@kernel.org>
In-Reply-To: <20260810164536.6ecf043d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Aug 2026 06:43:32 -0400
X-Gm-Features: AUfX_mxBhfFT9uL0lPa7nUNDw1KGFEjh2WkLkpdbKzuwbsC0f1NhAk7n4JjYmS4
Message-ID: <CAM0EoMmQi03B+t8MyUsXp6-QOcOWRJvbji2etp9jjV1gU5V=XQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Aug 2026 05:09:28 -0400 Jamal Hadi Salim wrote:
> > tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> > rcu_access_pointer(a->goto_chain) and then calling
> > tcf_action_goto_chain_exec(), which does a second, independent
> > rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> > chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the ga=
ct
> > replace path) can clear a->goto_chain between the two reads, so the sec=
ond
> > read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.
>
> FWIW *shiko suggests another tweak but looks orthogonal, LMK if you
> disagree:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809090928.868186=
-1-jhs@mojatatu.com
>
> (the patch is "too fresh" for me to apply right now anyway)

The concern is valid but pre-existing and orthogonal to this patch
(and a lot less severe than the posted fix)
I had this discussion with Paolo: When the sashikos raise a concern on
"pre-existing" issues, what should be the reaction?
In general the conclusion was to follow up later if worth it; however,
sometimes we need to make a judgement call - if the pointed to issue
is serious (and yes, the AI bots are now reading what Sashikos are
saying  and constructing bug reports) then a v2 is needed.
In this case, I was planning to follow up. I will start more actively
looking at sashiko reports and analyzing if worth a followup or a v2.
I dont know how to do these pw signals, but in case i see it as "needs
v2" it won't be worth waiting for one of you guys to comment.

Do we need a written policy somewhere?

cheers,
jamal
