Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0A17B418
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902517; cv=pass; b=QmWb88SNwm6oKvmKPNbmGWsIsiOBWGiWkNHeuw9bCyenxyUCBGhfoMgm1jfOnz7AuQfEmTWezWMSCzkZ4Isz0fWjuZr9RM1BH43Pg67fEsQC+iqrhtpoMtk3jJvP01/28X60Zha8yGaHVLlKtJca4toJakohkbOpUogz10IZXCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902517; c=relaxed/simple;
	bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpQ/8C9mYtgmvC7vP4TPWoPf2VfXu/D7hTDyfcP+fRmaU6mCN1FLytSkMmF4pip3MjqrqQT21WBZMgkfRSHGsvj66yS8R+A2LMNzZwzlyxp1UKQjFGlhXu0dakoOEMuckTIUGuknz2hebEVrreTTUXchkFdwMz+fm/aHpjrpT7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIoffTVd; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIoffTVd"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb973e6749so572478a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 21:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785902516; cv=none;
        d=google.com; s=arc-20260327;
        b=DmkeaqhrNgWrh/ETHGNpearguvaKgzd98Z5TOCeOTKaLmdu+7d1FzO600PgV+aJl8a
         jDONQ0iaenC+Ozz1Nf3B1vyXAz7Hy6HCft/qluO10oz4CZhU7A+LgK0nJUsG5e1VfyHh
         XBi/NkVxfsM9Ldc6T4STuD88VK443D2I5IxW61M0PcgvcRtFrPNPunV4XSfU11SZXmj5
         StyLCBhjQlF4wGH+z1NH9g3LZ178OfVyVwNYJBXvDpvxze6SQklZToAXUpDPc0f06g7l
         TQYqXa0LSZ6z+NwuXZYeTIn6iiqeF35yMu04+V696LCrdlPSq5JAUflsP702M8iQDd1P
         bWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        fh=82/AXYeyNI/014mRfxbYK9ikpNigVfJ4c9UkiVvEF8c=;
        b=KzUBSvswLugg3hv8b5Llti+Qg5odZ2of2BJPaHyiLSOABmaJzHO+0Tm9eo4Y8gVent
         jLzJQIu3GF6R3t1VRR8/O6DxRJTmnhAQ+F055n8RxBN8xxtIbisocqSauMBqQ072XqC6
         S5e8ekJ8g4Eva1rLYsHEYCL3/f+6CV2/f4YJC1yjj4W+W5agbM47Wz/OEBWw1AN2KG3x
         hObsVScFH+zsR+vB3OgtbRiMDMtkBt7w1PcbRcNs/4xH/h2R8sSPBrdFr/GtL2fiW+lD
         fYaCgKJbJJV2jy90Uk87iF+qWR46LcNzkEpUmVNgjZinTYUwCDaUXSXUjALsCFrfiEd+
         CocA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785902516; x=1786507316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        b=NIoffTVdFMhJ77pNMWsTYmPZbn6mA/sbFneZKlsEbxpKkVT8nZd3Fu2hu5V7MbR1zg
         fHAaeHP6jkOTVjmxDDYwdTgqcRDa/JuwvJRuaLEpGXoH5WV4NfRraR73rhcnVuba+D3B
         xUwcqk+Sq52s8o1D8w/izuyH6RN9Igi/UIDkYpmyce5JFjwohKtBUol2/Nsn8qrJHAD9
         PFj5OzGNAcCIiMwvLCat/TL0alkLkMQhcfNMzGRr/47DFjilbI7pcKRoywpAtgVf03qS
         qpvQvupbvWJyn53HCABHOxcda99RPGDCnRLUyAacbV+BZhxHpVI2Z8v5ngksHWp2fUon
         cb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902516; x=1786507316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZ/BMOGRTk9QQFylaTjhIsATjR7rezwaeF9sIcbZ48M=;
        b=B6+Rvh+xQ6ZSLMmld5Rjv2ucFyJNkpCFGSES4VouygSWR0eNObLkR0wgrD9is/NBVp
         AHvk7DBdVyvunojTQpFEnTQ6fnhktAYcRcfu/UoJ/nM3Jvq6WXDwJqW6ixvI0ABQhzqb
         h3qC9m1dL7Re/In6p7Nttm+eWzKQpjXPz1C7K3SsJtn0i0OPjeKOz/9JCEnQWlq15oek
         72cct8kqAARXAuWQtRh1O11CtAMzuHMU+pMrPI861Mj1XAMhRvKySt9ADb0fxANGjgD7
         8pGMf0fuofKAwgEbxm6ankODJipnXTdklSbq72DBG9Hp1D7L3onuoDU50Sy61nZBVA3b
         ehlw==
X-Forwarded-Encrypted: i=1; AHgh+RrdddDhepbnJ6sIyxTrVh7YhPfITycVAphstafkQ7FIgwqk6hyt3joTJ99LJbIbe9XKVJeWRmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3SD2LoH4uN8d2QmUadSTQcgW7nRi/eXgRvJ3PdverPFD1hCG
	+UuzftACtgZpQSRHMRk/qeDptSYU5bwjxGje0iTmGdZr7ME8bT3MWt9X6tRNM1TWmDd3Oclm9lL
	Wxeg/815l0UeK2JZrkqar4tV7hzu9Tc8VyTSVEE+H
X-Gm-Gg: AR+sD122dFmr7lOjlquypUyYJ0BsheWwfbJd0jLN8eZV2IKWOSl3MGV/GG7irUeBlP7
	Ng2ZtwIZOMFqw+hN/SJbPVy22MKpLn60pZNcTl0vgeGzJ+Lml45W/n/W73mbx/S88s9vMmNwTd6
	uXApkzqPR+/Kh66qyVB2xIpYc85xT/nQtRNjtsteBpDcsK02XXTRbPGOwUN1CLmY2sVkwS9XQCv
	SDKmg0Ou6qUVyrTaeqI1qhOUq0ve2jEhsURET57rxG57Dk5gEvE15fxeUGdPoa3ww9bFERmaKgg
	UDiY4x4TJdmo2MUnw9D+cwL8DJibND/Luq8KC/MIc+XxhLZJpVBV4VPUY7r4yc4Ls7GSgatBy7B
	GBKc14M8c1qqGKuiDwc0w8Fu3jAziY1u0D/9GLDluqMl8n/RgTCmwbxwyJ06idPfZN/MZs6XaLl
	xTLjRufz9hgwU=
X-Received: by 2002:a05:6a20:7f87:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cb85e2a09amr4105411637.16.1785902514882; Tue, 04 Aug 2026
 21:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co> <875x1qyyyx.fsf@cloudflare.com>
In-Reply-To: <875x1qyyyx.fsf@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 21:01:43 -0700
X-Gm-Features: AUfX_myy2ETSSWZCV9CW9muE20y4c1Knov8NIRZlDgbnW6vDiP6t6ClWB_tNSjc
Message-ID: <CAAVpQUBcDGX42Dyzo24U3iMKVyNajgOa5ZD7uX=DhSWf4Nb-qw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:14=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> > Lookup helpers gate whether to acquire a socket reference on
> > sk_is_refcounted(), a check re-evaluated at release. An established soc=
ket
> > refcounted at acquire time can gain SOCK_RCU_FREE via
> > connect(AF_UNSPEC)+listen() before release runs; the release-side re-ch=
eck
> > then reads sk_is_refcounted() =3D=3D false and skips the put. The refer=
ence
> > leaks.
> >
> > Make acquire and release unconditional and symmetric: always take a
> > reference, always put it. Adapt sk_select_reuseport().
> >
> > Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> > Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SO=
CKHASH")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.ke=
rnel.org/
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> > TC bpf_sk_assign() has the same issue; it takes a reference only when
> > sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> > destructor it installs) re-checks sk_is_refcounted() independently at
> > release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> > socket here too. I'd welcome suggestions on the right way to handle thi=
s.
>
> Can we make this scenario unsupported?
>
> listen() could return EBUSY if called on a socket that is refcounted.
>
> WDYT?

I discussed this kind of buggy rehash with Eric today.

We can't make it unsupported although it's super unlikely
that this is used by a real application.
