Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F0306B3D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225056; cv=none; b=T67ld7pmszxoDYmsW18nDq+qb1MTXIJhsaBTeL48xpddpJlJy44O4Tq//vlKXXBuXwosvL0tWPcgn7JpERg85Mb8K3ruK8tjpBSFMfLZhIPoR5Rz91+0nzIYZgeuxgsd6zJbxMhm+sPeeE4xwomMMwt0ygdzm/PPEv5Fy7KMz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225056; c=relaxed/simple;
	bh=LHMwDqlcXSfkxv44u/ZvcB9y/jElzy1xDWD2jp55OCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZDgYeYYyNInz9QDAOqmyQnu9KLq1agG9aaV4iKUWIpK2AF7bW8D5yaOSHBk49nI2kYixtuZu7W+F2Hd1FK1ok6miL2E8EHgobKQJCyHASagGguZ4F4BOMeAt8ODhYeLHngAj+ym8xtR0b90CWDHg8ND9lQappgUr5Wai5fHUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjsuemS/; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjsuemS/"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3a7adbf1b3fso373080a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791225055; x=1791829855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xS5HF65LoVsFRjbOhyoQkdS88ZjBoG/dqtGiSK55d78=;
        b=cjsuemS/06SA9o9og9VYoXpUdF7N11RNYrc03KPI9eeguId1oKSnC4J2OfMVE9k58w
         zdpm2d2YueSBAEHkfIyQYdYByVBzF/gxIGM+8OUkk2VbjONVB1kEQwQ3T/F6MpufvJzu
         DYPTNEDLna5aAAk1dCOMxfm8R1VknOoFwfJGmYQhov4LNFSyUPUdbKxDqqmAiBAYOFHs
         9ZTuNFRpfkNMl8lgoRa5ylpZcxVmHfKNB7MQJWPzYZkyuwY1+eHp/G8jh3GxhdzUzyzb
         /wK3lG/2I+D3pKnIiUCrDfQQudw6wilOsJMENmA2r9sfIuADXKy4FGde5WDbpCAx28RA
         vqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225055; x=1791829855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xS5HF65LoVsFRjbOhyoQkdS88ZjBoG/dqtGiSK55d78=;
        b=Wpu8fQPH+DyBw4tm1CwNpQ4U15wYF8J04eDtMgIe/OCD9AyLJU/xhZcLOsctkqTP8h
         lWDrJEBhIIX4+bi2tvpPzJvLOzbG4HoSbYxd+djCax6qgJ9i2MKfB4yllEAC/THWdB37
         6hrKl6kAJDs7sKFvJBpY/WD7fH2QIliTSQ/CI2ANBCsmXPD1VdMvYN5G+y+OT2lW3Kwz
         jLqy9yowDqOfOxf3SOPCP7xaKOOqNW4e3znRpHzFOArivM3gijEZOej+iHNkP7unTAXK
         q38SCPYoJ+lQALSVFPhpWtZhXsOTBjd/Qx+nCZ1nVZ95E1lwbXb0aRp2gfKsxyD8a7j1
         XaIg==
X-Forwarded-Encrypted: i=1; AKwUvBzjPoC9fsGYaX0uCLrryxvDRcuAfC+wogJIHPPQeLdflCMhXqJFNZ/6brxtMkDAZvyEh8U0IvY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpr+lo/lFaj4CZKy9qRpAY6ZTiklKeETZ1aq5B8c5A+EFw+1EE
	MQmQivytJIq7H1bUIt4wXBCakreJUzh8xoQ4gyM0lrzz73tS+qUgu0Og
X-Gm-Gg: AYBFou0+i7Jx9YXNTx0302uou9zmLWNmRy48ROa0bTdjkXNqGXCBB0Ux/ouxnmGsW9j
	4m56c/kn3zK5qta7nsC2l/2r9w7dqbX/FI2UyK72LPF8ZS3oY7yDG0okIImax/+4wziIHvcmJNd
	sxVIqdxFvQej8BTnFl7JWyGFbWqQo7RFfmhLD4zyfSYKGCXtSWb7KdSaeg86KriYkPJB7enK4fn
	6DSdHD4q0Im1rVkJFdbhFnFV/zN3W/MH5E/GQy3nKPzUhaC632w5KFVNGrqRi9S4XyOewH+qfJ7
	1HJDLcXOYYhE5+dhgEe2V1COUuHPrO3TWexFL+Bn01WLiR838opDztUskVc3/8X0GBwp6M19n/M
	3kcnlOtOGPaiOmxSJLft7OX3zWXgADqh8sMIZL8xza3qyUNbxaVoG/w+JoBlzQKIH2UQlZn2OCo
	gfVchv+WJRinF3UKEQwOIbiIM1/kI9PeOEGryiHZ94VbJqOaBAA6Y7FlDsvPWs7Kun
X-Received: by 2002:a17:90b:4a86:b0:3a7:da33:ff3d with SMTP id 98e67ed59e1d1-3a7da34065bmr4683519a91.46.1791225054557;
        Mon, 05 Oct 2026 11:30:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cea0f1sm646225a91.15.2026.10.05.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:30:54 -0700 (PDT)
Date: Mon, 5 Oct 2026 11:30:46 -0700
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
Message-ID: <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
References: <20261005154533.4147685-1-kuniyu@google.com>
 <20261005154533.4147685-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005154533.4147685-3-kuniyu@google.com>

On 10/05, Kuniyuki Iwashima wrote:
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
> 
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
> 
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
> 
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
> 
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
> 
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)

Can we return -EINVAL from these when used with sock_ops?
If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
bpf_tcp_ops_call under the same if conditional?
