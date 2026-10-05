Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375F379EE6
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240466; cv=none; b=SSRS/OoBxZiWCwz09HxyAcMnhJxhBo2BKoKTOWGtwvJnX+HQq2D7HEHtyY/Qt6Jvj582uQuM7Mb7QDvpLs8cONIe/7Z0SXun6rd66BDM8gKbNAPwoQ4jeIeMDD4Cj7js1/FLgdfyRwW5EsCPMt5vCX0tIVCKjjCTIvSGyleJEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240466; c=relaxed/simple;
	bh=XJxAKxG0TBthxZ+cdhPavwBim/EbIiI80E6SjLMFF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbMouM/nsvq+xhg2zea1IC9enEuDjZRdV0m4PmSSFB2IishLwZs8MfMJlcfC3VqTs7xVGQpdgbnD0qyNH3vJFr3VpaUYgh5w8R3ZaG5rwy2qCvjruNa1sE7K3dYHf9Viq4XKQMTZw7SkYzDwNLoYJWNdB6hNBOGTTRtd67XaG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxCYe2xR; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxCYe2xR"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a81335d55aso583369a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791240461; x=1791845261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JiaT2c5cjTe3MsSYDeTAHnzZNgk/tz9XRA/TRKMqdxs=;
        b=AxCYe2xR0dtJrEdyt/fl27MERg9CDWKs2NgtWLAk5QhWFIpjQtM2FntqOD94Iq8rV7
         vvVmrUGp3JueZ65dx8T9kh/ljSH5477WK+OjOqCn8dwEpRKA4GQ/cFJZ/ryYhYtlHzmh
         o6l7nC+oNn5dDUkk25HIiDTt5rbzkJ31AQHnL9pe8iP/NF6vKRqLOl2xPw2IU8/cPTqw
         MsaqAg5z8ZjBwCG1NS8uGnDTcFBLbeLz6aSjR3mhZDWGQAmcyKZmP+ys+2l/SWs6tDOF
         WYqIdORi54HJDIDJ89dObxeauIvBGgSYee0z6C/DWFnfnEnujN/FpEPz2m57+N7K+S/j
         O8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791240461; x=1791845261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JiaT2c5cjTe3MsSYDeTAHnzZNgk/tz9XRA/TRKMqdxs=;
        b=MSrnywJpc5DC0D36nBBGUvCWyboslRuybuaDJx7HVl3LyNdjduOEK38xPKE34x12ns
         p2rCNkBZ3AkqrPxwnpAQf28gYomGlglkq25VgtwUsDp2MxkwAkJdGaC9QZ6jXU9mkHEG
         EHJQY13VJNqFr62oYwIR/sM7n66cPudUmn23oYvrz7BWHXTQrmsS7RPFJZVhHL0lBHnb
         lYNaIxY4g8c6cLitOG3RyCjaJVt7xo2+ddtQ2quVLw64MslLeNpf/h8ghFGqrFBc3sD1
         6kJAP51jjYMoFcIH6U0XqrRHyDQ5BWHf7pn/D41ALhb4QRsN0oXrERiHZFk1/40O8wQl
         WTTg==
X-Forwarded-Encrypted: i=1; AKwUvBxhTz/DUz7QLAS6f5UpDh2U8PpmvrSUgJUNEfGO877TF+L+CD+0KxUFbg+RlDF+vmV78Wx/8V8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvBAqLtFJYWCdYlpthlwupJ16EfKstZcQdqwOwCAXL7e5oE4Hg
	saiexVozw1l7SZQ+XbOfgbLFxV/GQI8zsmhf3NLftmqt5n7i5qRKDOOL
X-Gm-Gg: AYBFou3jgN45vRaboB7tEfCaLcY+FsnLucnFSXJmT5vcZYOmTx6HC181ldB+0CMn1aA
	asz8E2VfpzzEVJfo1MFzYm3p/YLCMd5HzCnkk38/liy/SBPnM93JeaUA71Xdkh2F5FfOLXChsWp
	Rr+2lt/O29i0pUqlidXk63iz2azrvFQVwKxVNIiuS59lNixxGFJsbqCeuHB2jWP/A9/Kd9zuPW9
	b9Okcjahob9MjNq6/74f8UNxBZUC+6Z9UPRxzPPd0TJv4fsc/6KRZlYdhjnZF3yivnWxo2N4y+P
	UrErdT2ln1gtOpNPT8g7l6vwY+4G1eHS7tLQ8am8YKzm35o5ltB3dwyqMzmj98UuQmoN7dBcT+E
	098Nh9bCmf1aBsOjKtjshnNi3UFitgLQiiPC4l5ZorBnY7s2ev1Z9x21Tkz5vXz8SrACKkS3DCa
	HSmaU6RH7n86ncwzaNXHhym5zETcwhcbTBkjiOeBRMTmo7qGlMZGup7FMQmgS1Rgsm
X-Received: by 2002:a17:90b:55ce:b0:3a4:a383:f9cf with SMTP id 98e67ed59e1d1-3a6ce7cea1bmr11382885a91.38.1791240461172;
        Mon, 05 Oct 2026 15:47:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543bf138sm1537403a91.15.2026.10.05.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:47:40 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:47:36 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
Message-ID: <asQoUeoXFa2-ofPu@devvm7509.cco0.facebook.com>
References: <20261005154533.4147685-1-kuniyu@google.com>
 <20261005154533.4147685-3-kuniyu@google.com>
 <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
 <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>

On 10/05, Kuniyuki Iwashima wrote:
> On Mon, Oct 5, 2026 at 11:30 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 10/05, Kuniyuki Iwashima wrote:
> > > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > > tp->bpf_sock_ops_cb_flags.
> > >
> > > In contrast, bpf_tcp_ops was initially designed without per-socket
> > > flags so that users can simply define only the callbacks they need.
> > >
> > > However, it turned out that even attaching a bpf_tcp_ops with a NULL
> > > callback incurs measurable overhead in the fast path. [0]
> > >
> > > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > > 1 bit left for a new opt-in callback, while not all of the 7 existing
> > > opt-in hooks are in the fast path and really need a flag guard.
> > >
> > > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > > update it, both of which require sock_owned_by_me(sk):
> > >
> > >   * bpf_sock_ops_cb_flags_set()
> > >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
> >
> > Can we return -EINVAL from these when used with sock_ops?
> 
> bpf_sock_ops_cb_flags_set() is not allowed for bpf_tcp_ops,
> so we could add a check in bpf_setsockopt() for bpf_tcp_ops
> to disallow TCP_BPF_SOCK_OPS_CB_FLAGS.
> 
> But not all of bpf_tcp_ops hooks are opt-in, so we cannot prevent
> attaching bpf_tcp_ops to SOCK_OPS-enabled sockets.
> 
> 
> > If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
> > bpf_tcp_ops_call under the same if conditional?

[..]
 
> I assuemd we will use the new flag only for bpf_tcp_ops and will no
> longer add a new bit to the sock_ops flag and fainlly we can deprecate
> it under a Kconfig like CONFIG_BPF_LEGACY_SOCK_OPS.

Don't think CONFIG_LEGACY is happening :-D I might be overthinking it..
Realistically, maybe something like bubbling up cgroup_bpf_enabled(sock_ops)
is an option as well? So these (old) runtime checks are happening only when
we have sock_ops attached (and/or separate mechanism for struct_ops?). 
But if you don't see anything wrong in your benchmark, let's not overcomplicate.
