Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056D45C716
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704167; cv=none; b=GnaIHHM/hHUcKiTygjxvxDyU5+sjRV/MNGM1oo8rRfO++nsVufT1DfLYKUSC/t/ZdVKmXx7cfVQRRLMak74K6O8OpYLBzum61podANT9xCoti9zSn5GsuCPLdnfcKjwiq9NlNO4TqcaRPQl78MhYe5lJNQ2VVz468+ST54249AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704167; c=relaxed/simple;
	bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+dTbpKT5/NUJy0lWSXJX4zTCyaG3nxqWMlNm6ozgkYOgQWmCiKub1ueI2M5tcczolKYCZZirKTU8Jpo0fC2G2Rb9eFb3DMz20krPggjFA+QhF55VZ/ztwyHpcjGi2RLsiZENTbL+NWeDSrw43d1A73x6SeST0GeQj9OjfrUwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZNcWxW4X; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZNcWxW4X"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1342322a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786704159; x=1787308959; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
        b=ZNcWxW4X+EjxgNmXm8R2cPAWq+NDyZA0BGhSxbHKKfXMLnYgiN+/8mz57XbfkwLZmj
         yYL8enZqSfv1GnxT//hOA4X/UFx2D7eh8qeYYnN8jSfXyHcZxVQMHeS1hDemVIw8DMTA
         VIvUATCLAvGq8yUbkZRQ3nd7HULGGw8uiPtXGHLFMJx5vPmRLQxjPemTDaJ3AUtLDbqD
         IPRp5EciMPfpWqCHfJL5iQ7VhYPMFUHqKEFakkVOV7Fu8dvrgNoMP8n2K7dl3b2OhVGg
         czLtNf1ehT/iPoYKmfL/11FJoFdC8Q/q4jkIMXpEfN54cI2tkIkaw6mINq3Nntx6IK7n
         WXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704159; x=1787308959;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QToTVh6/Mnx9ZpECqcu86BEjK/YNJA8QQpFCROHIGrQ=;
        b=tA2sah+5yQX0rwhgmDg1C/8wYCWHUj8t77hCg4GnYb0MHXMnU+c1MZyet0JFHjfBSl
         9CCM/04KEOw4FkDeATdJLhZvSyfjm7kG3rSORVStrMJiDOh/nnqU3KKawrYXgXsBHAXH
         kS6VEJWLwZzc758/3LJk6Gwx+3kCiJL9ye0Y7gqhNCkVQMt3yZAuesf/IgHziCODH5qp
         O5ahttPi6egs3JyhOcwHZ+PkIRtWaJCG66wfUTWHS46PuxdMZq1CaA/OwO9K7Dbt8XFj
         SUKBUMUFnMeCRlKFkW16yYlx8xdAV5AC7K48BbwfnIIoW9E90uGzXzTpfGw94DPl8QRn
         udLA==
X-Forwarded-Encrypted: i=1; AHgh+RpbRTI5qIMUyRjz5F2Tfo8zwZYJp5vBl9WH39EfgvNEj7wZulkWOiKZ1Os2msoyTBsN8ipZsOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpoYuXFoCrUbCfyFmsDMqhj+1Odr+2rA1MvQxVaYRB/95s8LoQ
	fqLm29W4WPwWIscxDF45YQWGnIJejdvc1lg+TF/aatarkh6+LN1S9RLsk2BOIMsQ6VI=
X-Gm-Gg: AR+sD11iCPPM4CnevA/cN4fd1ssEtTkGmaXMVedqPi2gED1hIFBTWtkSve4XDcX2fQN
	UN6zspHU7KcboRUMSWImXU0IovZBC+aB/jiUgmH3zhk7lQloi8P4COI8tS42DtFEunPR+yPj6SV
	nKu8MJIyRWug9HDymnpNVXM1Qyv++A9FcZH6WT1Pbu3WvBAnNuP4ZNR0QpJ6Fpyz8CmRJEicwPf
	33Yi+6uo9ZYV07TUURX0xN5W0Qa48iH+wam7wp8LAmdhWwtBkag9LcMGe7jGeXNgWNrXIKkNsGc
	kLa/Td48kqTmlo9CC44jLHSHBKsZ8mRFhAS+RG9vAo9GTgnHMhqX3L0swCpY00/uQMna9VWekrR
	5QwTMmFTqBbJh8xZzo0SEICybXGEieC2SLdEyzjihBhtL1oVC83qT+GC0QZ+mhM8+1lRZ9HqKsF
	fxNqJH/0C4yh2XH3AJuaOce/QedguiqogLiRKxk2/h8t9VKB0wuAXOzrPpLwrxqwc=
X-Received: by 2002:a05:6402:914:b0:6a3:691a:9d71 with SMTP id 4fb4d7f45d1cf-6a38a957c26mr2538574a12.11.1786704158754;
        Fri, 14 Aug 2026 03:42:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9ea527sm621948a12.12.2026.08.14.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:42:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Ihor
 Solodrai <ihor.solodrai@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Willem de Bruijn
 <willemb@google.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
In-Reply-To: <20260813-sockmap-lookup-get-ref-v1-2-31f5d55f44ac@rbox.co>
	(Michal Luczaj's message of "Thu, 13 Aug 2026 14:42:00 +0200")
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
	<20260813-sockmap-lookup-get-ref-v1-2-31f5d55f44ac@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 14 Aug 2026 12:42:37 +0200
Message-ID: <877blt0yqq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 13, 2026 at 02:42 PM +02, Michal Luczaj wrote:
> psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
> queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
> entry is unlinked and an RCU grace period elapses. Since the lookup runs
> under RCU, a non-NULL result guarantees sk_refcnt >= 1:
> refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
