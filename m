Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650279;
	b=j6KLruLjyoieannD2svK81cxLuCJmHPpbNaoKj7ZiAKO6S5MCAUe2RNhtC88S4SZX2i7
	 nDaw6xYpwO61Ajt5JLRg01uqRen9OFQ2qPjXdLltyH/H11ZtC9szPjgG8Hge7Y4TmCfVd
	 NEzPC0bZo7mVsVjaAu0oqQWChmGeAC4U09H8leR/SzO2V6Ed7QGNr2CIxBoXvyJv78puq
	 o6fhqFgkABGdsUPf7Iw8ah77xOZ73Squikq8Mt8ITt0tt9NssFSH3hY4XKwuRkUlnf6lM
	 WypuezNupplb/F0S244NbUCxTFSStgc57rjtXTZVSwby1V7K6eGArhDUDZJNcdAaw4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
	b=Nl9nuCpt9kxE7xl9USduKjP2TsNIPpi4uqL5fSLirvHD8KJGGQcOyJLErTyuZl2UQ4w7
	 n9svlMlVY3dKO/2RyE3D4SgGoOLOBza1oXCGNI274Yr7IC9AoEzMTUwKGvKp7ZupUuBJV
	 aVvTAKPoxjbFFdKM4WsZyHJixsaXE9AboBTkqlUVBt4Nei0+l0ivikPRZk1CWwzY46gtN
	 AQKC/AHfdSkyHBfoFz93GfJevYMqgXtnD4TSN34+DexE3cBTa/fMwW9MaHcYxqCwN8Apr
	 Fwu2L5ts2IJWL6dj1dLkKT0hUyN7nMMfOUBohaPKuw8KCY08onRIAqRgZRwaNOxTLQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQqHEnFn;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C871606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 20:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C871606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQqHEnFn
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2814343a91.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650278; x=1794255078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=jQqHEnFn+FXMVNfoBrs1W0djK36mh6tAQLBKKA0np19Q1lUiMt4NJL7nk+7gnZDcHa
         puQGZPgqWkCEuwWOeI0MtPwKgP553Mens0+MZqU+Rj1oNBo68oEFeSew3Cv2ASUxq4U0
         REbJSjunXBCew6mlmraQdA0sD3dOYhqSN2uRJrAafjPbp7rVPTI5CQl8npSMS4Nfl3ob
         0BvbBihL+543OtXPr6alPH7jNRAFDG3zkmvzOOP8fkKzmzF2QvGWbpDu4rKzSPRzHIJd
         yDJUU0RHvw8Njw4cV/qdGBTcoDd/p5a+w9HR8R9aoCMvAnYiKZD5aP2h4x86Pj6T+lCR
         K/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650278; x=1794255078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcymY4D4UF/8ph33P0OPdwCWekGZodgPY8AEN9x8u9A=;
        b=l6MgaAOefkZHEuSgkdkjx58kD1JknavYyCOBED4QMplEZBH0eu7FY7WFpxwwpHN7fc
         +ny76HmZ0wbvwj+AarhZnvOxQ/GI1D6IKpYlyIXhSgB9Fdg4Bh+Oq+1xQZFLVCvvNwl7
         17G7yNpS7mb8kjDbRi9GgxPy/sox13YXKhy7iz+nH0Kb8vHJkolmkDZOAQK+pheVQeCp
         fkRIbHAsZLNIuPSEfyTeTg4AdPsO/qhcQMyFUst2Q5C3c6/UcvIHVDngulrV9DTJoGec
         F3WiQDp5RsDZpV3vn7xQ46Ev4i6RCYrqY2VSxizFscHepdM8eJBLamZTTatauXRYb253
         nz3w==
X-Forwarded-Encrypted: i=1; AKwUvByhORM+N70AhdeWFaBywAtZ+U4CN7hsBCrK7zMG4eKyGLT8dIIKlG3sa8CPsV/AZChRzQ3zo9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6s3f78bQE1dNP6RV3qgVqVTT8KAkxskUoXbGNM9imwuPv5cDR
	V7NLD0BRBF7B6GvJYsa5wNkNxiH7wtMIFdKbg3dR66vf9VAm+ql802La
X-Gm-Gg: AYBFou093ArEeMY0jRivO0UtYG00OrTZlgMPAJpKxVoHGAJcSQJIuYCeuBsNF97w6gK
	N9wvWj2e7Ozc/Sb947y/kNhBApBmarZZKXONViLL5RttYK4Ho1qPv/Pkx5au4o6IB9ZvojlJJmR
	iVHeZgnKrMjlXJn8PnWpsjdEy0Sw/MzeK3E2FMkY138TZz567olV2XXz6ArfIqC+/Yula4JdUfg
	C41RjvY0lzUNaxF78D/zGmfc3BX7+eYEOFDKB1Hpk6qAn4I3XmP5RjNBDy37/ltBiY11wG4PPEc
	gDtTBkQUmeGySRCngPK86Wje33YpCRuk7aVt6ekEHgPYA8K8IU/OUVmPLfYzacGrKRGCzVf4rKN
	RO5tYn74ftGiWK/MSackEEWk2jUCaWHdrAE8e5Xg+jhw2oRL0IyOSKgvqG1zLlFHPcNP+6CVwZD
	FWttchfRYnnsY7iLsXH7CsSQ6etxpG7kClPk2t0Dct+zt/qYGdjhKYWK7psR4ZwEc7ud/dJKZ2V
	R2PFQL+wSL3IXiLAT8EnqT9aTwmJH+nusSUAV0rkHHdbYdZeiFIlbEGlZgpOmXhcje4frJrwtxG
	k7ksLvbsLTKIvnSPoHMkoghTDdK2nBZoJo+Ba9jLuqbBeLuMLOwwG7DnPNwWiYcq7+6k01mKccP
	Wv0k=
X-Received: by 2002:a17:90b:2742:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3ae897158ddmr9622591a91.14.1793650277913;
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Received: from john-p8 ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c29e619sm780797a91.0.2026.11.02.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:11:17 -0800 (PST)
Date: Mon, 2 Nov 2026 12:11:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts,
 redirects, corks and recvmsg()
Message-ID: <aujuOJCs5zZyon2k@john-p8>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>

On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
>From: Alexei Starovoitov <ast@kernel.org>
>
>These patches fix bugs in sockmap:
>
>  patches  area
>  -------  ----------------------------------------------------------------
>  01       recvmsg() after a fault
>  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
>  05       the backlog of a stopped psock
>  06       TCP listeners
>  07-08    the target of an egress redirect
>  09       the TCP state in recvmsg()
>  10-14    corks and the redirect target
>  15       bpf_msg_push_data() and bpf_msg_pop_data()
>
>8 of the patches are from Chris Mason and Josef Bacik.

Thanks everyone lgtm. For the series.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
