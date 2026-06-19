Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9335202C
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850926; cv=none; b=uYNv1ISr1APmo6qOGFQClzZu6KNJhCE7lzDw6Q9E1IDJGARY5VlLGw/RZyEfQj3rAPOE0l4kbSQduTcn2HrnY+IzVnCw21pB+wi8hpnNRY+Y/9ErcYrbcpAS8I+43T9DMao4a5QFIdcud0wRXBB/sxP0mHhLnEpttLiK8a4ZBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850926; c=relaxed/simple;
	bh=Nk7gGUelhztFXUKSbDziGiDeRv/XGtl9+hWpv9VrpXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR2AbARdzvmeXxaUnRsPF1lMgsNRL9ucs4/A2Q6ijLxYhiOUYN2pmNNfdrgwIlj4c4L1FAb+NFuy1wxYpTR9bJZGnR5Jv/OwgZdgB/auxXQum8sKpXCH7hC8Ht2TonV5OJgQnt00Kq5240ff5MalF3EDg4bCgTHulzRN4eh7YS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lv97Kox4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lv97Kox4"
Message-ID: <97e79830-f50c-4d28-a12b-7df0ac1be1dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781850922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk7gGUelhztFXUKSbDziGiDeRv/XGtl9+hWpv9VrpXs=;
	b=lv97Kox4PCDig0KLexZk6N62zjvxk4SJ8y11kk21ipX6KpjysrtPLdIgZ+UIXLNmTk48gg
	pPfKOnXsCeNDwdUeXfuCm8nVllXba1EJHfAZfag6vgGXNDlmHHNObauuWuLsWjb9TbgUxT
	j+u5tG35xU0I4Eqo5ES0uqkF+ZL0kWo=
Date: Fri, 19 Jun 2026 14:35:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/3] selftests/bpf: don't modify the skb in the
 strparser parser prog
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
 <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/19/26 2:29 PM, Sechang Lim wrote:
> sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
> the skb. It calls bpf_skb_pull_data() and writes a byte into the packet.
> A stream parser runs on strparser's message head and must not modify it.
> A resize frees the frag_list segments strparser still tracks, leading to
> a use-after-free.
>
> Make the parser read-only. It only needs to return the message length,
> which keeps it attaching once packet-modifying parsers are rejected.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>


This series should target bpf-next.


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

