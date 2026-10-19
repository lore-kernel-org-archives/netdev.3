Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B14AA033
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401628; cv=none; b=D8AxyU5qtxWNEoxOe2uuPeXBkbq8CHVvB9PMEm6ngIcuFqBiIsmpto4Kl9jXXDc5lJP5l0MfsVQNSjO+ewt/LZKAAuE2UplXU9jnOg6KNYZyYb7wM6v1BSHMh0pO1ESvdWKIE9vOG7WnmtGi7A4QxEGySXomOoQgCGmNezpvVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401628; c=relaxed/simple;
	bh=23uLVGVu4LenPJTiUbtiHkyS7W5/ZO7Ic3YJWLzrJ8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQsIr7zsADQXfzS/ZMfadSYm9hlFTTPoSOLChyp5U1I/3sitx/3CCtdO8XX6acwxvXi2NJ4plnCSpeXA1HgyduqnBuCkDOVjIcV1MNZFyBpn16MsHcLBvFu/uN0N3nfKKDEXvN4soD5wbvHXTsJXVzDoAsGWJb2RHA/2mle69RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=N7B4PspO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="N7B4PspO"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c441e267930so91074766b.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792401626; x=1793006426; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCnbEw2lvBYbntrA6KDS3EO6vufdqSnBrzMmqli8drs=;
        b=N7B4PspOq9/uakZFaemK5D2GJIoFlyDJz0JsUXxdX31t+m2Dauj4XpS2EkeuQKOdQK
         wh7Nw7ttBy4ELbOtSYNv8tnTYh6+p8NQEB5WFUDhN+wgg8VqjjLwl5bqhs3xCbmGIXKx
         i5QjNH6U6AnZPuLL0e/Y7IC5j52uMt7wcpWCB9Cn5qTDwwoTYn8+DMeTwvi/gKrm1Qby
         RxDIrBARe3ujeUbAo6+zhot+jzY4erZQvdN7Fq3/DJQB9OVOdot7wM9Wyq2W/n3jETal
         u60AD7/aJeGZi9MJ6nJC8JFXUDR+X2dZnTavmhaaE3doRuAzwmg0F5ZgFW3A8pUd4/ye
         r6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401626; x=1793006426;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rCnbEw2lvBYbntrA6KDS3EO6vufdqSnBrzMmqli8drs=;
        b=NMtlAdC1Fu1PD+7SPZ+Zl+HNvrjOZmA18hdhqCNQs3b7Wfw3webxdRcx5eCw90s1vS
         wAqVaO77fp3oHKUR2D2BFNUFBWDgeVrlBUlgpceAfc2VSXbdrWOc8OCf9jPtpYvwuAPD
         9xJLwF4TFrXgcszsrH7v4q37L+8cnHrrIkKmmGlQa4Pl4Lyn0NX68tsBlK4CqmtGq7Xq
         yAZ/Mmok/toUaQK/gqYvwuns0B39pHVJjU4A5AwdQ6xBhoIS2GWgTEuHRxpKu6Tdt9ic
         56U0QjLm0P/loE9VjDS14/1L9ePLaeyMcunpTIGM07cwebXxc079Nabl4vinqDTRfpAJ
         JKBg==
X-Forwarded-Encrypted: i=1; AKwUvBx1JgX6qIiq1sXPtscq5ASkz75d3ueyciDwr5yhlEjF+cVhov2WtPCYgfQUWIq3gRB60+uOVRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI36LM4aURyeNkP28dBc6+jfxOyS7e1P2Qe0THeKw3+1d762iYG
	fBPEnEJwtb5NSHcgu0KBZds/Qk2dEOHQKqADfPXCoV2aBZq51Tf62BcJoMDmkrPPyw4Lnawrfzu
	BLmkXqO0=
X-Gm-Gg: AYBFou1yqXs9gGJQ4/eaouV9EZ1RUGPrs5vSNZgF3NqY/3nt/tE2sOkeFnykYkNtZ7b
	9bD/SWuweSk9eVklSiAtzI4nAewcdhCP5BMdVnnxpnQPMnyZtOM/iU32Pj5yYarTJScUmFhaoXl
	XvQnzV8Awfatg7Q0Qd5zJDcyrnXCd0jRjNUu7yT9cySQD5ToD3cyPnWtpK0WUea7Dv9ul96VFaH
	6W0ssga9dZO0aCNUfBC/sNClGtK8DRQ0PWpsE3ewHFJetKzvvNu5bHTGxVGpPk0HEi3CUHmoyEN
	Y52V/v+F/2wCO9NUOPforCfyaNTn2wiyJiFYJm27s4rqNj5PrbNGmcLGz+b8S8PVZQf5MA8V0pg
	SuAmeL/3K+D5hqf8Gy13MyBGeU5Ryn+PSYHpGGJfzF93b9XrdXXBE8jN3k4sIrZ9jhehvZLaOhy
	1QbU43Jn0mvt/bEjWn7hCHPCpMTf4eccf/sUJPMlMy3oWVfNFONuncqeFOOnER
X-Received: by 2002:a17:906:ba89:b0:c31:c767:ae0b with SMTP id a640c23a62f3a-c4196dac03amr433604866b.0.1792401625664;
        Mon, 19 Oct 2026 02:20:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm342196266b.61.2026.10.19.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:20:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>,  netdev@vger.kernel.org,
  davem@davemloft.net,  edumazet@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  ncardwell@google.com,  bpf@vger.kernel.org,
  ast@kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  eddyz87@gmail.com,  memxor@gmail.com,  linux-doc@vger.kernel.org,
  corbet@lwn.net,  linux-kselftest@vger.kernel.org,  shuah@kernel.org,
  linux-kernel@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next 0/4] tcp: carry a BPF-chosen identifier in
 TSval low bits
In-Reply-To: <atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com> (Stanislav
	Fomichev's message of "Thu, 15 Oct 2026 14:45:02 -0700")
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
	<atFI9vl5hy09Dc0t@devvm7509.cco0.facebook.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 19 Oct 2026 11:20:24 +0200
Message-ID: <87a4oaf3mv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey Stan,

On Thu, Oct 15, 2026 at 02:45 PM -07, Stanislav Fomichev wrote:
> On 10/13, Willem Ferguson wrote:

[...]

>> Questions for reviewers:
>> 
>>  1. Is encoding an identifier in the low bits of TSval acceptable in
>>     principle, given the trade-offs above?
>>  2. If so, what feedback do you have on the implementation?
>
> Don't see any feedback yet, so from the top of my head: looks like you
> control two sides of the communication, so why not a custom (bpf) tcp option?
> Would you need that on every packet and it makes it expensive?
>
> Or any other field you can abuse maybe? IPv6 Flow label?

Nah, we don't control the client unfortunately.

Client here is any device that connects to our edge PoP.

> Implementation-wise, the sock_ops is going away in favor of bpf_tcp_ops,
> so BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG is a no go.

Yeah, we have just recently realized [1].

Thanks for feedback.

[1] https://lore.kernel.org/all/877bjk893u.fsf@cloudflare.com/


