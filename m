Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1D3D332B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954464; cv=none; b=IdT84oOxIcuKxQxn49lTtrfgXHUBfc4p8F/fqmwnbKicNUHowSCmMDl7+Od00+tsx3L+v6zecr/kn9t5Xo8iyG+RbhOo6cvMK/SeFR+y++vkkPzXW4PawjYA2ZjMbJri60moeEB6wPACUeUvLeZL+5iOflJe5PFTU0r1ghqqSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954464; c=relaxed/simple;
	bh=D80ENpUfW4QvugcwsDaQo9rQ3VT0nERraW1zaHCo3FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZ9TypXIqpTTKSAtKr0p2M8bjNBYBZo5LiiVJkMHFMe8BBljiMQSOxQX5ddYoKLVUpRCswyHDSzXorHMdbYmRmK/5EDMuNPFugMNcV7uEJSfk3AgevjBZNbvGt/vzfwdhKaNyRvMjmPCkq5NPI7F9SmYTMTc+ZLSBLrddQ1FCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XGOr2sCj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XGOr2sCj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e2dab83eso217407866b.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785954459; x=1786559259; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RQvUfHBgP2cWCg3xbn5qxeCgrthmPBmHR+/z9WzFaXg=;
        b=XGOr2sCjwR1DuM9tHgx5gyZQabR98pBqaPwKy7xuE7UFnCL2N9UUMCktzkLnPndFei
         qkXz5BlMaujSEvZMiXoUbkR5Vn5wNn02S7Je+3tYv30MJKEodBfkeqzP7K/KboO3vyXJ
         PSzPAJy8GT7uf+m8z+ZomG3vP4MwbYPeJ+IsWmUKnOn3R0KPAtAEl0s7kMQNvP4XqJbB
         uDkHiB77bF7dh+tpEi40BS7rffe/cRBwHa1G+nLUHAI4n2KQHM9yuMlLS+iPPC/5DmH1
         P6ejA1iMS9MFjUkqhPApFvNXGrdTyJAWoO4BJfYqt2lGrcQyQURg+z1bmiEktSi6AxIJ
         sfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954459; x=1786559259;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RQvUfHBgP2cWCg3xbn5qxeCgrthmPBmHR+/z9WzFaXg=;
        b=UQg9FWM8cOWEd85pvYiM+W6+bwY7gMv7T2NML3OouGnri4/qVwRPncQd7GB2A4et1i
         nMjZyQaaL/QUGh3UO4GpL6KmpXsL5a4i6iK3EHZ6/LFtsFqi0LrJNhXBoMxQte757sq+
         Z01n5HSmcnQus8BRmh6KcjnsSqNcBvU3N1Cb/B6Zj4dwGDjynWCjNjvmIjUyeVB2WKPa
         wOOixSGbst4pMWSB8hzCKfiF+a+9afjLeJQ+4M+Gowgst7P4apgiEWd5FI4dzDVgQCKn
         hE8DkFgtu2aew+uLwWhz0if1cp2kRYMUUnyhfZhi9cz90xQDB+l78c+rTA/kimXBujOr
         cuUw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8NKZi5FBoZU83TMLJP8lO7u29lUWA6v4fZLsa2A0YPpMjaS0WdYVLK/NFi/QlT+IkcST3yyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVFewfKxdJ9YLoR10c8FZuy0LQKk13ZJOjbZsh+DmhboSvz/J
	sad834EJZpMWzOzqPG599Rq2p9kFyHuDOASBaGfg5zWUbnBKnVKUzCF6bX7k8QJ/hPQ=
X-Gm-Gg: AR+sD11dUGFU0Xf21KaRBEfus2MKDnprz9ixk9Kugd/+E+3O7JFNUV9uXI+2OClDoFH
	1UaRADamfRSIVFH4k3xlUtXoSM/nLFBBVuLKPdbsfc1O8ZroSWycJSOIkpHQf5sV+4a5w42chUe
	JK4b0bM24VQGPX7j9u7GjVfjxPC8Wf95Q1h2KVLESoc0vc22WfTFGre08flKdMysTbkdka+NbbU
	MAR4E+6HuIqjLX+2PjiyjxpunJOl/BopeqEYvCps9XWEsJNjoqMyw8ByCw6wer8S2QTujd1SYY+
	/9gjVe0aALX6jn5RAnOqw4Moon/7hNrDKjYyKfOcWbPwFwpSFPo6xV7eJi4Zn/NdzA8OTjwV4xj
	XSx8TIEdKDgktJFnSTZVpELLoPLePAv4FUw5I1LqMTJuqzhwjRCvGpiPeqgm+Fbd8aWiIv3QazL
	UjbuQqpzPGwY1fTAVKAnIMZVlAkvZc0D1cwCIEEIIgDARsSQh99VupUdOQR1OkPT8/
X-Received: by 2002:a17:907:9481:b0:c1f:c061:569a with SMTP id a640c23a62f3a-c2039ae6a0amr437892166b.7.1785954458887;
        Wed, 05 Aug 2026 11:27:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036426ca8sm149119266b.50.2026.08.05.11.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:27:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Willem de Bruijn <willemb@google.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  Joe Stringer <joe@wand.net.nz>,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references
 in lookup helpers
In-Reply-To: <f131ac25-24c2-40b7-ad3a-f5a283b39e7f@rbox.co> (Michal Luczaj's
	message of "Wed, 5 Aug 2026 17:00:14 +0200")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
	<875x1qyyyx.fsf@cloudflare.com>
	<f131ac25-24c2-40b7-ad3a-f5a283b39e7f@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 05 Aug 2026 20:27:37 +0200
Message-ID: <87o6fg8lt2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 05, 2026 at 05:00 PM +02, Michal Luczaj wrote:
> On 8/4/26 12:14, Jakub Sitnicki wrote:
>> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
>>> Lookup helpers gate whether to acquire a socket reference on
>>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>>> then reads sk_is_refcounted() == false and skips the put. The reference
>>> leaks.
>>>
>>> Make acquire and release unconditional and symmetric: always take a
>>> reference, always put it. Adapt sk_select_reuseport().
>>>
>>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>>> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>> ---
>>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>>> destructor it installs) re-checks sk_is_refcounted() independently at
>>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>>> socket here too. I'd welcome suggestions on the right way to handle this.
>> 
>> Can we make this scenario unsupported?
>> 
>> listen() could return EBUSY if called on a socket that is refcounted.
>> 
>> WDYT?
>
> I'm not sure I understand. Isn't a freshly created socket already
> refcounted?

Yeah, it's just me not thinking this through. We don't have any state
today to check if a socket was an established socket before.
