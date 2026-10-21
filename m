Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552067;
	b=I2mogzWY3oYNrw+lx5tghivMBuCskfK67wyoClZEfWQbomC+p/Or4J/lGml/p8qtbZ2/
	 0ob1ybNSiXNMYDwPgGRRBjAodf5nISwAbbCaXaiIkjLv1CO8Ri/pkNPBYlRaA81GoX4cB
	 I0bWxMkGhqB8PoL/ybpuw/nk3VxrJyiKlbiBKzs6c9NkG//iqjpch7rxsBt47eATFm6YB
	 7A514ge2LTlvZcpx3MHdRni8fJTzAw4EtR96p8Q39G90NWpOA05tEqyOmtvrLKrBRLRbW
	 mu4pOv+dm76A7RtC/XBfEpF4BsmQ1dIL1WIp9y/X4BeNbEMs9Ik/B5BFrJPiGJvcIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552067;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LXGO/Ihk9N7F64gTwFfu4H1jjMd/4KNmHzrx69idA3c=;
	b=K2a/xNTlUjLgMrC37vY64UX2Klxh3p0E8TsqmXHKPenbMRkMXIGMsr7kvmYtCPGI5uZg
	 hVODYRINhGCAZX6ehnc+kPEf82tmdj6OJY4khAPdoSozcCEGeIMuqLGqDeq7vuRfCCdys
	 frHV3AAfXg6EYBnYGIJrzsRd2BlMrZEHbb65gJ/04L/JuygY+82stq765vqhJEw/I898L
	 Jc5ygn/DjYzrmHxPGAtDASDiU8UXOLDgO1ys4S7bucnQNE8r+b79/fd1G9jW1GkLNMGs4
	 B0/Tm1ILfQOp7DExBREzEPTcrZd/Dy0CEEMZI6VSh2cDxytS5dsDBhj3Kd7MSkpvFVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.147
Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE6606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAE6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/uplozhpt4dcAKvCO16vQWyHQ5FbixVEQFL8xKVM96I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792552054; v=1; x=1793156854;
 b=M8yYgPPoV4q7547aFDcoivPGdL1St8RTKNnolZ0Hene2Htbbwwjd1qDW7l0viyLmAJiFgLp0
 B5rhbkXporg8LeRtmzNXGaTAoM88ogE9KduOGiZNbuRm+t59Y81kmap3BT+J65CfY8humsmfr+b
 HkHdD57pIHvF5ZiJRTpwN3eM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eed8bf568db21181;
	Wed, 21 Oct 2026 03:07:34 +0000
X-Mizu-Trace-ID: eed8bf568db21181
X-Migadu-Flow: FLOW_OUT
Message-ID: <c0f348bf-0e13-4cb1-8014-cd9b7787bfe6@linux.dev>
Date: Wed, 21 Oct 2026 11:07:27 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
To: netdev-bot+sinfo@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
 Taegu Ha <hataegu0826@gmail.com>, Tom Parkin <tparkin@katalix.com>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Chapman <jchapman@katalix.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
 <179255036282.3290.8488375760281728576@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <179255036282.3290.8488375760281728576@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/21 10:39, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.

This is reproduced in a VM, with a TAP interface bridged to a PTY. When 
IFF_NAPI_FRAGS is set, a non-linear skb is passed to PPPoE and then to 
ppp_async_send() without linearization. The packet sent to the PTY then 
contains garbage data.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
