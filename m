Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1637883E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335952; cv=none; b=efTK3xGM+PyeyZPbKhbXx5FSNcrM2PsUnNYtEowjrEvf9rDmtxxPvAY6+IsKt5N9qKnlq4vdoR8Ix2ueEEK8n+sZXTcNlfxp8OhDZBP7xgvWHMV0SGsftXILEv7UJnHMxGRaD/BY4wItvfLUog4chGQpOVgPz6LMIDZLqk17gEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335952; c=relaxed/simple;
	bh=fGYlAltxedFNZCf+TVR4R0CiNgcXlEJin5Yi8JP6tTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS9QKhMexI25DKpceEClDz4W0QykRgo+Bqi9J+D8CQrD3YNrhmbJ6cPUxp0sHCkca9ToFjrxZGQgxojWQ/r2P29O/YTBCHfh+cTCV5Iaywv95D7X78OYEG3aUioR0ZVSfQQdcNIMVc9B1J+jvAXu2zE+p8QjDI69in05O/q6t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NtHe+UAP; arc=none smtp.client-ip=95.215.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtHe+UAP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fGYlAltxedFNZCf+TVR4R0CiNgcXlEJin5Yi8JP6tTQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788335948; v=1; x=1788940748;
 b=NtHe+UAPegwijOcodU3PqXOMeIfeCbGj53W9PoruNGgRcIY4hqDXrRuhscS+x1pobsB4H+1H
 XnqgSsJFpBuCkSpIANorw5d660MVkvrFCdM/qNmiIZVYQEEdH/H6DbNGk0uwNYqab4SAYKwwMPh
 fCM/aR6+FkXvjraP4XXNmcSs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9993ce1274938f11;
	Wed, 02 Sep 2026 07:59:07 +0000
X-Mizu-Trace-ID: 9993ce1274938f11
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d27bb3a-c92b-46f1-a7c3-b3d9ea7136e5@linux.dev>
Date: Wed, 2 Sep 2026 15:59:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppp: make room for the filter tag instead of assuming it
To: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please avoid sending patches with Gmail Web, as it replaces tabs with 
spaces.

On 2026/9/2 14:22, Vlatko Kosturjak wrote:
> ppp_receive_nonmp_frame() prepends a two-byte direction tag before running
> the pass/active BPF filters:
>
>          *(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
>
> Nothing on the receive path guarantees those two bytes of headroom, and a
> peer can arrange for only one to be available. ppp_async.c contributes two
> halves of the problem.
>
> First, the frame-error path resets a reused skb's headroom to zero while
> claiming to restore it to a freshly allocated state - but a fresh skb from
> dev_alloc_skb() carries NET_SKB_PAD:
>
>          err:
>                  if (skb) {
>                          /* make skb appear as freshly allocated */
>                          skb_trim(skb, 0);
>                          skb_reserve(skb, - skb_headroom(skb));
>                  }

I agree with Eric. Dropping the skb on error is cleaner and easier.

But I think the Fixes tag should reference the commit that introduced 
the skb_reserve() call:

6722e78c9005 ("[PPP]: handle misaligned accesses")

instead of 2.6.12-rc2.


Kind regards,
