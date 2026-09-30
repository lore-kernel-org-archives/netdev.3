Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F424772B3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760268; cv=none; b=C7+e1/eBNLpSD0ZtLT60fyxcKolFiNcX/3usymdz46vp5pI5byOM89f7rCVfyMzNJuajp3P3b+la02CwsdPW+u/nAPadN1AF7QaHqDXjU9CdMCkNsBIk99Ulxv6FeeRT4/6AWe4/JcigFmmJW2271cyuFIHJQtqvJAMwYqRiIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760268; c=relaxed/simple;
	bh=CgKPdajqhtSYylupqHJTybBjAIiLXNiqOqyoKGQx6Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HamNMufQvjt3XdXGl8hxb05SEChCTvzG44pD0//RN88RMar07lgN5m9+YbJOQ4lcw8qJaHd2kTbfdd2tzOBrKLKTesr2sdcblgyb6oimMkhwc+pqwLCxWCJanzmg1UXnSk4VROEAQVhTACIm03BtdZq4FFXV5L9YEeWqRJVnQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwcBtf36; arc=none smtp.client-ip=95.215.58.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwcBtf36"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CgKPdajqhtSYylupqHJTybBjAIiLXNiqOqyoKGQx6Ps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790760265; v=1; x=1791365065;
 b=dwcBtf36QDTxjwd9eZf9wfFmLky24hLdcjpM9oJZC6F0MUDzEWm5/LxfzmV/zD3QJvanchpB
 DVnKsZNbI8yAl9juMRK7J959LUrbVukZ57sQM1w/ubSRhxLyTMrvWTPz8l4r52d2OycBMzgMHPw
 gTbaZZCAiE8gkqepz7ZHIlKA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ba59fb9213cd29c;
	Wed, 30 Sep 2026 09:24:25 +0000
X-Mizu-Trace-ID: 4ba59fb9213cd29c
X-Migadu-Flow: FLOW_OUT
Message-ID: <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>
Date: Wed, 30 Sep 2026 17:24:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
To: Sabrina Dubroca <sd@queasysnail.net>, Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dave Watson <davejwatson@fb.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <arzStIrdizPp_vbI@krikkit>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <arzStIrdizPp_vbI@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/30 17:13, Sabrina Dubroca wrote:
> 2026-09-30, 13:26:36 +0800, Qingfang Deng wrote:
>> tls_sw_splice_read() returns 0 after receiving an empty application
>> record. This looks like EOF for splice(), even though the connection
>> remains open and more data may be available.
>>
>> Consume empty application records and retry the receive path instead,
>> following the approach used in tls_sw_read_sock() since commit
>> 3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").
> This is similar to what Chuck proposed in July:
> https://lore.kernel.org/all/20260726-tls-follow-on-v1-2-99bf4cc1c729@kernel.org
>
> but Chuck's patch had some extra bits (handling of the "released" flag
> and of signal_pending).
>
> His series also had a selftest which should be included too
> https://lore.kernel.org/all/20260726-tls-follow-on-v1-6-99bf4cc1c729@kernel.org/

Thanks for the information. I prefer his series.


--
pw-bot: cr
