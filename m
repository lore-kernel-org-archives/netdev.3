Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404103D6CDE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279921; cv=none; b=hiC1XFNaz9sKhw/482ypcZ0mcachbezgsD52eavSZcZ32iPZmIXAlywKHvTF/BR6vcqBxlbV0AiinqZ4Pm3j3czPF70L8eY4eh1ObSc7m0nb4psjatoROjy+162JpIYW8yDZwj/n4UUZn5Y8o2iYCG6k3TG+6C6YAP5GzXkiDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279921; c=relaxed/simple;
	bh=DdlUt1eugd201x7vA6DJR+IRpqvZ3sWH7bI/bKJj26k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyEVb2qS4t7VWRCT2y7q82cSKXX6COYN2s50j2LSIZQnuQxhk3tSoJO1sltILzpaTfb5U8y9xWN3TZKwVoMJRe17y1GVJDN1FxkPjx/yPcKeKAQrQWqE6J8PoTFEe8WE2cSRTv0bANpPvOiiuHrVxwG0wEIBey/KBm2dq1Hl7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hD02RckL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hD02RckL"
Message-ID: <8e555f2d-c0cf-407d-8fa1-7ea73a2429db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779279916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk8QwP/EJ50Wc86TU+jLx8y++yWKcTQKvwfILz8Qi6E=;
	b=hD02RckLkrtCYnUXhb1vDjr4Dr+oFswQPM/Ny6CLrP/SY1UDtgHmbeb8qfKTVnYZxJpDay
	AlVrW0NbReGrFF6LahaNzHVFQ38Rn+lxPOvrXZBoF7fay64boSkX8KBCitj4YJeN2ju9SG
	Zwp0qB3JY6LQ77QNJhCEu7i7uy6USUU=
Date: Wed, 20 May 2026 20:24:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: keep sk_msg copy bitmap in sync
To: Junxi Qian <qjx1298677004@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260520112327.189660-1-qjx1298677004@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260520112327.189660-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/20/26 7:23 PM, Junxi Qian wrote:
> The sk_msg scatterlist ring stores the actual page descriptors in
> sg.data[] and stores the copy-required state for each slot in the
> parallel sg.copy bitmap.  bpf_msg_pull_data() trusts this bitmap to
> know whether the current slot can be exposed for direct packet access or
> whether it has to be copied into a private page first.
>
> Several SK_MSG helpers move or split sg.data[] entries without moving
> the matching sg.copy bit.  In particular, bpf_msg_push_data() can split
> a copy-marked entry and place the tail in a new slot with a stale clear
> copy bit.  A later bpf_msg_pull_data() can then skip the private copy
> and expose a direct writable pointer to the shared page.
>
> Keep sg.copy synchronized whenever these helpers move, split, replace or
> remove scatterlist entries.  Clear the bit for newly allocated private
> pages and preserve it for descriptors that still refer to the original
> shared backing page.
>
> Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Reported-by: Junxi Qian <qjx1298677004@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
> Cc: stable@vger.kernel.org
>

Thanks for the patch. However, this issue is already being addressed in 
another patch.

Please see:
https://lore.kernel.org/bpf/20260517121626.406516-1-rollkingzzc@gmail.com/
https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
---
pw-bot: cr

