Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E185395D8B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557209; cv=pass; b=CksQlhlJ117u1m/eHZ9MEtL3yn9ItRhrZgJEn78jNlxyklAV/FrP8S5QKn3pWif6T1IePNZh28Jdxo679jyvDa5GL7oQcRjbTThf9+8PihVwzR3yvw86ITfuX2OMGKpZwffWafhjSEfAQtH/XE79kvcMrsnDqWcLZ1yCUUfLOgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557209; c=relaxed/simple;
	bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJONLNy19ONdNQ6OtodPNkrHYk7+QAFMdlYvDsH2zCxIQIP8rFV9S8Z5ITIexZKsyKzZTfIJRuVF+wdge8TCnlxea9qtEGfw1gVbdcUMxzJ2OkNZPwN7eNZO2xrZFrVWHJNorMi8W1jdIHhbOS7afTvH9awm7tH4bW75uopWoII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EYIwgLlU; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EYIwgLlU"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e8fa1b8d6so16286567b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786557207; cv=none;
        d=google.com; s=arc-20260327;
        b=ZvSxls01dNnGUMdRd3M3br18U92h9rBAZOOrcHh4aU/RK8Bvf39kyVoNSc6eaXbtcr
         ItxW/bR6kGYCjtmr/dulQE5W6ruP/5f4hJtvlacOD+NWSC0jIgrP1Majfnwx7VurD9Z3
         GAQr5vyyme9rIYla8xZ/QzwYg7X5HCJ6so8n4Cr0RDqwq0pdH13fYU0c8T8/qANP/+oi
         sEr3uOOSPpAALWlaWBqk6d34696ltb8i1XFZqtjCS5PXLzJNNsQHSdo40Xiazt9r5Vtx
         UmOkfbxcZhcE3NHiraJJtWrYY6tmce2xtn7ZSNDrRGNBm1biJhdk95wRmNRt4NWudDCC
         RSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        fh=cWSRrQZuwNJi+WnNutvpK3vzQGKRpW/S4G8YS7O/OYk=;
        b=FVteNGH3bGB8qM9j6+iHd20XjHDoH6aUDFkVLMxC7WcjPZ/8oiXNKse4aOANzaucFg
         i0QkWLbOKPaZpse4WzxVXI4E73u+XzPEOJ/8LeTYZGOpY4DUO4i1ZAANtelnACLsyq1f
         8zIVOU5BKJ470PWS3agTRcLRe9dIEh6v/ByeFMTNSJuDmXFPwxNjr/iJX4gtBt5cOKLD
         e0Zk3j7HQnXaNWatTt/S96G+jNQliLOqxdvHnYVhAm5MoU2aLvyajns/hSk7JyZNbxyJ
         DKEEW3Pvv+jjEgTz1rteuYs9IUabU7MZ2IiF4F4uOJSFCQMOx6RiX3wKgXA9CkHR7CQd
         bDrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786557207; x=1787162007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        b=EYIwgLlUScfuE8SeO8qqwvk4aO1mt1gha0eL+fQdnw0D7VRT9gZsgNT4SG/b5LzTw3
         3Ko7cjxTt0FXc++YNf2EiHquf12KduVMr+utSOgzd3IcSRVMV9MMCNoQ99uASH7sWYJw
         /198/nD9VaYKmb7KbcQ/OQqtGEMqKIhfWfu4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786557207; x=1787162007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLW3k+IK0k74p0nI4iirenyrCH4mX1IiCZ5yo7HC0eQ=;
        b=jXMTMIEIqWtt4MeODBnlnr11mwavETqcnpXylEwQyPpPQpG8udOLE5Wg79IrpR7sHj
         7W4fGhoSNkPNsSP/gzxkKRvjwf7lGJYGbXlbE0lWPI3g9wZ8vOKcfhoC+FqiLBTPbV4Y
         1X7Zt+jGX3MFNvQRjkxgv8TlDNVYr5dMG3ahG8LacAqesyhqPWmh91sWHk4LgX9CSs10
         QbUP0LNlw5uHGZBJ5liuYddBzP3BqMrrul0JzTqdF5UokE8TvoRUdERBMMbzo1yjjfbp
         ZmjvYpJchlbfFUzGgZL0dezwoHtg+k2orltc2dGnFuucYhc5/OjvC2AIzny+wiOFGryh
         HC0g==
X-Forwarded-Encrypted: i=1; AHgh+Rq++zzrs/1bJbYEUgdmfH1g+EgXDDmPoEIdz2fnnq4qzkobjfWrvnnlbPxh1x55Hw14k1nF1Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxSdBdA6JQLmUgZq46WMPV15JvFJ8A46GBHpcRugQVplW5sNF
	6T/KTl+tiWltbvFc3O4if1+FIwMHxRJ9TrPsIkxhBEbHvgiP2qgMy4M2UwIqHizrqYz/jutsRSf
	2jU2GG6NqlnbU9DQh5oqzYhs1ldtHvdcIQhaOFFjZ
X-Gm-Gg: AR+sD12xCKFRcrIvSf8EETmuLAOWLWUnUWyF+yi0AJASgMS+lDJ7LaEKQVyEVs7VPls
	bPDKrqKCLDK3RUvgpnPXC8Wl3LkMtmFJ80PcmJwBZpGrfIkebnTLV6wJFzO0ij67Mxj6Km6CPG+
	5fGIy58p12H1gJTZfZpAKrIwLbvBZ5WGXs+FqmQ2TpSBgIcB7JP/diOYTcIum95E0HZpEEhy/op
	gSBnKmXoI/WXeu6KpnbMOHnR1dpbPcHGnT3lR2ZvaeOGXVw24fhVC6mN+9apmW1gbgZmQwa0mrI
	K3xqjZsRu9/IWPdG+zzqijmUTBi8nkhWe1fGx6BuVEkAgpwdLdQCeK1rT9I=
X-Received: by 2002:a53:cc02:0:b0:668:430b:46ac with SMTP id
 956f58d0204a3-66c517bf264mr25853d50.52.1786557207166; Wed, 12 Aug 2026
 10:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810164357.1653956-1-victor@mojatatu.com> <20260811181958.04b42aba@kernel.org>
In-Reply-To: <20260811181958.04b42aba@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 12 Aug 2026 14:53:15 -0300
X-Gm-Features: AUfX_mwlzhtn8BGL44tzbN6geInWjxc0TGROu9YogSdMc8FACCrUgSyvrqbEG7E
Message-ID: <CA+NMeC8cG60HaEFhz1AvbWi+xNYDE3pPwxqk9oTFBwf-mJQDPg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: add get_fill_size callbacks for actions
 missing them
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, daniel@iogearbox.net, 
	john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com, horms@kernel.org, 
	vega@nebusec.ai, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 10 Aug 2026 13:43:57 -0300 Victor Nogueira wrote:
> > When an RTM_NEWACTION request with NLM_F_ECHO (or an RTNLGRP_TC
> > listener) creates several actions, tcf_add_notify_msg() allocates the
> > echo skb from this underestimated size. act_bpf is the clearest case:
> > TCA_ACT_BPF_OPS alone reaches 32KB per action (BPF_MAXINSNS), so two
> > actions are enough to overrun the allocation. act_pedit overruns with
> > 32 actions of four munge keys each,
>
> "overruns" makes it sounds like we overflow a buffer.

Fair enough, it doesn't actually overflow a buffer.
I can change that.

> AFAICT we'd at worse hit a WARN somewhere due to EMSGSIZE?

The issue is more subtle.
The kernel might create the actions, but fail to notify userspace
because the notification message is too large for the allocated skb.
So it's not a crash or a WARN, but rather a correctness issue.

> > act_police with 32 policers once the
> > optional rate/peakrate/result/avrate attributes are present, and
> > act_tunnel_key with a single action carrying a maximum-sized geneve
> > option blob, whose 63 class/type/data attribute triplets expand to abou=
t
> > 1.2KB. tca_get_fill() then fails and the request returns -EINVAL, but
> > tcf_action_init() has already committed the actions via
> > tcf_idr_insert_many(), so they stay installed even though userspace is
> > told the request failed.
>
> Please TAL at Clashiko review.

Yes, I belive it's correct - the code should acquire the lock in act_bpf.
Also yes, the GET path suffers from the same issue, I can send a fix
for it as a follow up.

cheers,
Victor
