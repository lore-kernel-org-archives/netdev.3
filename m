Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2F3C10B5
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887648; cv=none; b=BXk0H2T8xxqXVr6NTsqV7FYVVa5E3dc7zEEHyuK6ORcNQMJSkir2mGRwFaDMWCMJ+QtkdFBjKnCXPCQMdoegA6UAMEOIjRoVaDuXV3rhd0CrGHL+PokwvslmXrW14UatfuDSBYYJpRDrpJWz+Ht5JtlYcLrpcrahEteXeIJdw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887648; c=relaxed/simple;
	bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgYW65qHytNNEHUdp3oV8cM65hMutySexc3y83Gj29D9Soq2s5HZSbmhYBaZyI6PKo404EIvPjrnCaL8950ZJcvJhJ4KDORB3QVAnAgyef0epH12BArjTWVLOmHVHVpcmJCKQ2RHLD86rwII+pbLjbUJ6cIqfw8IbaZ/Pz63iZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y24JGD7Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y24JGD7Z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so379449a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784887645; x=1785492445; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
        b=Y24JGD7ZibsNEb6FwF4z4InP1TTEqO1jqJLhwr+YebPL3UCoN5K4rIGQEv5HLJlHqT
         3uJVLukB8KwaSIxdlpyoD0YyDqZbKO+N12MWr3bj5UkGQi4vyFqBFtPQuOBFl4xMSNpI
         6ZLBP6//IZVIr1qJvp5ACFiVX8tcv3ywjUQNuVtEEUo+D498mKuDGm3wX0W36tEHDK5w
         Qd0z8/md2ADzFYVvuvrElhDH69rGQs06Hzlf/wiUfARslnbNGwBN+cpJz+79xDa9sCrU
         YIawR3SzYWFSaD1NIgkN+l6WmtrpkKzm8SgSoBUrOIJGDpcJuA5pc/viYwgTpHaXIAcJ
         oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784887645; x=1785492445;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tTK/Xv4EuhdjSo6QzRV7l1c1SvQdyST6lUsIk0NgKBg=;
        b=lAPWQ2Ybl50bu9odkDrO9fZ1MjBoMzW3O+nmiGICSnr5tSkm74OKqSyU6QMI47Twy3
         W9tedd4BRzHg51/8Ewg+wZGbJ8AMLpfGOCkJAoax9Bm0Um2ICj61mOddzkgyQ3MsmiBS
         N7vs+wNusWq7CodmGUp8AvQJCDaXBke1vKM5t5LYJzmce2CQUPsAG+KkEbkocf6rflmI
         tJMtN+HdcePREAJg0hkC52rTtC2rBoRBcT3c9H0NEgPRnhq7g/1uGMuHq2n8g7VvEF0D
         neQ1YmLgTMicml0yDTa0AdgEzfNivGlKPPEmt3xe93eyeJ71o/ZeuzOJSZXSYf5guhi4
         CHrA==
X-Forwarded-Encrypted: i=1; AHgh+RpxP0GeZHRO6ZvyObA9UiZvU71hkCNJdmjKPz3KbaSBnwNTQ1FT8gRxCWopx6o2zRQcM+Jy1K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVlb47tykUZJItFJ6zLknstbEwz/k0h2zUzNx9jd9e6VzlkFQ
	oa/yfpPyonVJXb4ROLCx34r/1HqY8i3/ETg3lMnQJiGg/P+BpQPudHXxirKZ8/yS+T0=
X-Gm-Gg: AR+sD10FDHuvJxSuKK87/tZhsESc7cXtwBpqO+GdTGuQl2LwNUd7isQWB2f7hwwAoGc
	F+xfsWlRRrVjNNzce124Qdnxibsp2MFD5s4l1dQxbE8zMJKDjOTO89MsevzEBVqZzXZrfdAg57V
	BoRoOF/f2MyI6AZ6bDORjDtorHmlP6FhHrN0V9dosWfbAVAXbgtp41jkN5dUWGEHhFMkKc0D9sC
	3U3M8um/TWu4EcyMON1CS8YcwFRpgtmaoFEmPwnFe1Ad0Mtyknx1zzYjCwNN9++ogOtVl2xl+Vn
	1sotsnR56+vXmMPwu72V9zqnpZ74pcwRHFdbKtP+ehT4/hW1Ux/JFFT+LstEJJUsmOEEzAz7HSr
	y3DxAvDudlqSFRh6Bx2rgZlBbW1IWsup4u448YQfkgKPI1tKQH0yfdFkQ7B82SKcLKVZEhHGDP+
	fekAlPCTtobimoCyU=
X-Received: by 2002:a05:6402:1f12:b0:69f:4b79:6374 with SMTP id 4fb4d7f45d1cf-69f6bf0ac12mr2926275a12.13.1784887645054;
        Fri, 24 Jul 2026 03:07:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b610sm2893839a12.15.2026.07.24.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:07:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Eric Dumazet <edumazet@google.com>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  John Fastabend <john.fastabend@gmail.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
In-Reply-To: <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
	(Chengfeng Ye's message of "Fri, 24 Jul 2026 18:02:33 +0800")
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
	<20260723162602.3275661-1-nicoyip.dev@gmail.com>
	<20260723100030.3eee6d51@kernel.org> <87ldb0lo8t.fsf@cloudflare.com>
	<CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 24 Jul 2026 12:07:23 +0200
Message-ID: <87fr18lmzo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 24, 2026 at 06:02 PM +08, Chengfeng Ye wrote:
> Then please just take the original v1 patch for reference and ignore v2 and v3,
> and I will stop sending new patches for this report until there is
> further patch review.
> If there is a new patch, [PATCH bpf] will be used properly.

You need to resend v1 with "PATCH bpf" prefix for bpf CI to pick it up.
