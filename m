Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFE3387375
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052939; cv=none; b=T7O3eyEUzwqiZwhrlkt+1MkUwaTG7P9cTVOFfh52bT7kFwiAWN1NzB5syOLIFRVAXvAlViv0hY3NpjZmBTCyf2k+dMdRSdGo+l8UjGrUi8vS2ec8TLig9L34InwoffBRS6ngXeiQSybi09Rini4pvw9okZkYOvA441G/GBZPwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052939; c=relaxed/simple;
	bh=DcxHkkjowzjjQfxCs0Tz8a1UmmA9KOa5xk2Zh+Krr0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BmnhNRzkymG6F5hezbxN9wLeAsarkLHcBXl1r+TpDi4Of9LCRPond5t+aVOBznkbecSkSRVSSszDeyp8a3L1BB25VTxYLaTahb0sYN8BTwUJiOnKeoDCLpMIzxE4fjQnVckpAMPbgFmiefonAZ1DoZumtUmirrR+SUNPW2syL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3BB6B6t; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3BB6B6t"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ac9d666d4eso4876307b3.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052933; x=1791657733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ymzk38tiNxzMGTjhcCuavqN+NmrxJFDts1CbeHFNODw=;
        b=K3BB6B6tuKDLKo7yX1ysnI9hMBQxf/qGMGPqKe81M5MiNzRYe/ry5MrekVH+0Hzw34
         Ah+B1AJ22mkG5Z0gKYTJcNNw1kALnjhd26RDDXXCYYaCyrHlvEpJfLg0PexWoqkXCJMA
         aXD5t3sW6jiMSgeY5yua8pgPDhXYYyHRXe9dgff7BMIQW+s6fVeVQqnYGF5/IJKBf0Hk
         fS+6HvoabuMLk8MbOGjcQwxQKkm7N6uOS+tfsEZR2RH2Hgi+/93Spk+HMOaMn3VBWYM4
         2mWhmg8u37r3XbLEng5MAUy7bKjPz5YdhgKwKew7KtLIG8SZhAIPDyqTITaCdSQgy72b
         Cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052933; x=1791657733;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ymzk38tiNxzMGTjhcCuavqN+NmrxJFDts1CbeHFNODw=;
        b=JqY4zZhaDLGaNvY8v0w7biABPGY+8m/K1BsGlX49IwzyhSRA8j+gvd71h9lALus99j
         jFqcBcdPkYJHTD+1lEK3dW/v0fWnwPGDLVXGh0gPJrN78gbvlGxPa5y4Qhht4W985Cw/
         hBBNqOjZbOnx98c02+970XsZEF1vd4SdcdyTilpPiN6crKb/FAEo1F1bm59OAOl/DcSz
         5MYi5oqPyBfJzzgugxHqSJtEKhiiaTgmf2PhB5TWG/lgCChHYxk2r+5hGWc9kNz0dvE2
         W43bcrCpXgnPSfvlprvU3kLjQNooLMp53MuA7bMVmZdDAUxsg4CwRjEdGGrJsq7Ng24p
         Ec1A==
X-Forwarded-Encrypted: i=1; AKwUvBw9rfQZ9DFkq6P6f9nDsRupm6vbtQno/WG8qSYZzVOAQ0R641daetA7vs3kPXGxl3zFOQFq0is=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvKh8nzIwix9VWH2HfQs13UPI7CZszhGerFL+29+lQ7UcJMqHp
	+rAr8IkWZItDa8BqkOkZN/DwyGEFUhJ6lUNq6JHaI/EFn2Hl4n8B1WEo
X-Gm-Gg: AYBFou16QulKJoymdfHt+6DdDRxYSlmM62OOmNv+co5G/HMiRnD5tW4QX2dCQJdIHjp
	Rxui2eCpT19b0XDymHR7ml9HFq1Dtp3HwLcgC//rFtqvgRTkoVHYzPyVkdg3NpnqBlInSNFkxa3
	8fNq2y7/Mrh3Wj49OsVSUuXetW2/Lh82nSHAa2uCLlWLvQIldHOYwgCcy6MQu+00gQblAkcvkLI
	8TxSzeb+EEJn5qEXAYibWdVvuv3tMvVg/X+fQc9uz5D3bqMTMccOlykztif2RKdH2eF4OdzKKio
	8topYWLTcVc6xvS8CG3UfKTTdwT81Mc9HllacFkY6DkSGyvzADpWYFXH52+VjUdxbG2tr0xnz8g
	ZVFUXmfER1fJL6qbgbhlhDHsRaHwQFmyhImoKs/fTY+/Jb/g1FYsZtjRJd9+1Hq6WuxyPX2idwV
	MCdcpwo4jQnp8Q65v4c3nXLxGbN/MnhxeaWNV0jhn2zpceIwmz7yD3COkUFu1f8rxFLE3EiPyct
	R0KaLdgl7K50cd6ZLPfLdmi/Cqq12fefRE1QUaFzNcbOtdbJF2x
X-Received: by 2002:a05:690c:6e84:b0:8ae:844:d95f with SMTP id 00721157ae682-8ae9466a2a1mr11852207b3.0.1791052932852;
        Sat, 03 Oct 2026 11:42:12 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae2ed25172sm22773897b3.0.2026.10.03.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:42:12 -0700 (PDT)
Date: Sat, 03 Oct 2026 14:42:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiale Yao <yaojiale02@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Message-ID: <willemdebruijn.kernel.2bb89b342a6a7@gmail.com>
In-Reply-To: <20261003093822.544964-1-yaojiale02@163.com>
References: <20261003093822.544964-1-yaojiale02@163.com>
Subject: Re: [PATCH net] tun: Drain eBPF RCU callbacks on module exit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiale Yao wrote:
> Replacing or clearing a TUN eBPF program defers its destruction to
> tun_prog_free(). In the device teardown path, tun_free_netdev() can queue
> this callback as a private destructor. The rcu_barrier() in
> netdev_run_todo() runs before private destructors, so it cannot drain the
> new callback.
> 
> After the last file or persistent-device reference is released, tun can
> therefore unload before the callback runs. Drain outstanding callbacks at
> the end of module cleanup so they cannot execute from freed module text.
> 
> Fixes: 96f84061620c ("tun: add eBPF based queue selection method")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

In response to the bot, from the previous series's cover letter:

"These issues were found by a static analysis method"
