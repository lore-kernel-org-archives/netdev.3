Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA138B12A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355799; cv=none; b=Qk0fBkfSEfITbrm0ZQe+cmG8M/TgXmcN9SUZ+GXE8JSYiy2V4FbDWETZgo+/Xyaz+Ne1qejmbr2obDsivz7k4uqk6EDi/2tUvblhcSMyVKjtVvH2PDF2uEMT9Y8XvSZC8CgVE8pxQNq2vccVnyhPzGBsJEXzOWKMPvkpPyvdlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355799; c=relaxed/simple;
	bh=X2Kii5dEPpIGSKl4rtxnre0C8366Gz5L+2PnSejSm7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvzWX+ScAvgi3m5VjCSGMUBAHUu6o5ap0LsbiYCx0DjzQqiZHThbeo2G/wXV5VKfiNNJ6alAvwmoN6tHB1AlOkp2sULTJrwviLUwLmHMz5sbOVXKN8psXwfgVG6pWeJIlsBhEGgwnYzLjCVbnBBVazr3P+sAxJSZschbUKnvn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t8JI/u78; arc=none smtp.client-ip=91.218.175.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t8JI/u78"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X2Kii5dEPpIGSKl4rtxnre0C8366Gz5L+2PnSejSm7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355795; v=1; x=1791960595;
 b=t8JI/u78TpoM0Yvv5jQnizKrYr/0j5ilyheNdTIdjrzGRbobxnCHTTS/JiHdyKHtE8/tVdDb
 wltJlbUrdmjKpqqX8YCVnj8DSRPBX36EoY6wKVed+gSZge+BuZWAtbu0n/V295TxpmSIuGcFU29
 e95jiYlnk9GXKJ40iL+vY6Ck=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 12565de92abcb202;
	Wed, 07 Oct 2026 03:56:07 +0000
X-Mizu-Trace-ID: 12565de92abcb202
X-Migadu-Flow: FLOW_OUT
Message-ID: <8a8241c4-0e41-4ddd-aeef-b9ecb4f55d3a@linux.dev>
Date: Wed, 7 Oct 2026 11:55:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless
 loop on bad module params
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
References: <20261001112948.322463-1-jiayuan.chen@linux.dev>
 <20261001112948.322463-4-jiayuan.chen@linux.dev>
 <20261005171227.2014f26e@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261005171227.2014f26e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/6/26 8:12 AM, Jakub Kicinski wrote:
> On Thu,  1 Oct 2026 19:29:43 +0800 Jiayuan Chen wrote:
>> Subject: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless loop on bad module params
> if the LLM Medium severity complaint is true maybe also update
> the subject? I thought there's an actual div by zero somewhere
> but the commit msg seems to describe the inf loop



Hi Kuba, sorry for the delay.

The LLM is talking about (cwnd * beta_scale) wrapping, which needs
cwnd >= 33M packets, way past the 1M limit this code documents. So
the loop fix is fine.

The div by zero is real: beta == 1024 in "/ (BICTCP_BETA_SCALE - beta)"
and bic_scale == 0 in do_div(), both at init. The new range check in
this patch rejects both, I just did not say "divide by zero" in the
commit message.

Want me to spell this out in the commit message? I can also add the
READ_ONCE() Eric mentioned in the same respin.

