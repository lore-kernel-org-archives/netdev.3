Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703970;
	b=SMFvv8ohPj2O92G41NwkS3v6ub4hcvu5YMqTjjW9bM/dr6WBgiajCfifMqsfMLXC4/6f
	 xnJSuSvY16cN7o7NCV4SvL6F9RP9j9fqdfx7Jzrw5yw2kKZSN1QBgPkoUHruMzFbs/SRz
	 BpGR2XeVmbdrI5v9aSfGPJHMxzLBFcEFGDyfUMOpjA7SzJThDfGjsihY4gnvDei3aQMeZ
	 A+lYVo92cPm7a/9HOa/B5Yhtfzyj/01U18W/RDKn5IKRj0yaGYucl56EvTsfZMVc7HeSe
	 qooDxaN1wxwCOlwJBHghUG3e9WUkLws/nKOtjqbGLyA+4Hiopkz8B3R441XAbUaaVag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703970;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=2NBUlF2vMqdkR9YRYyGzFoJ+5Fd8CMZ+Dei906GMItY=;
	b=3O74q0QvgH2hHqKnSUdXS9FkIqDeE8QxoIzMz3+aiOG1nj6fR+PCQ3SHzEPq62hvgzyi
	 g69pEI0bQyZRgMWJnHmrRLeb5QNilRbpVfMEeBPXja1EaF+o6ZsSgJdr6lxjTI3oe2w31
	 l9rnuWHPR+Ss2JH2oJT13rGaJZkymyF3NXwJPUbt5z4zqmrmrfJrBA97f2FIcddGzCrcD
	 /fTfq+FKI44CEfxbSL5w5ypU4yJNW7vBNKdaUWJnAvzK/SFY7lcbCX/fwWKhORaZH9GNb
	 X3MUgLkba87djxeyMBsbWAK5F6lAf8P0z2QITOKkv7+vJYps+dk7AGQkA4Cps41Iqhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=PsilCqkV;
	arc=none smtp.remote-ip=195.10.208.52
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B6606BF9D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67B6606BF9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=PsilCqkV
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jJm2t5Z29zLmGF;
	Tue, 03 Nov 2026 12:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793703958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NBUlF2vMqdkR9YRYyGzFoJ+5Fd8CMZ+Dei906GMItY=;
	b=PsilCqkVn+2ZlZ5nVytALni9FLjJIvuwJNPPyJENYLQVuSAs6eyzYT5eZfG9tDimJZUOiz
	uYPbc+7omktr59JRYy0gwUEkAFYuOsLQRDbDwzPxi2E/3evDtxBVuAGEJnIswr12gz8B5g
	LL7SzLnJbZRQPR7gDns4Czd9uQmnuFi4iNujv5N4VMn6c6BPV1c4yzZG9aTlqv5MEZcLmV
	PBZOl+ppw3DuA5oFz6EYUv5k5H6cjgGRNmj+DEvf/nfCftbGOrsoByRL+zuBSq4KOL+okD
	VxoHbWE7Umd52/taOAoVppeIesNq2hXrA3a1Xi+oL7aoCoHVF0Hm6rd/rXXLWQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <763512c9-e67c-45a5-82f6-580661e79771@mandelbit.com>
Date: Tue, 3 Nov 2026 12:05:57 +0100
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
Subject: Re: [PATCH net v3] tun: bound the NAPI receive queue
To: netdev-bot+sashiko@kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20261031231444.1528758-1-antonio@mandelbit.com>
 <179357538131.3131.13550708149751579907@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179357538131.3131.13550708149751579907@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJm2t5Z29zLmGF

Hi,

On 02/11/2026 00:23, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new limit does not bound the IFF_NAPI queue in the case the
>    patch is meant to fix: a threaded NAPI poll on another CPU that is…
> - [Medium] The new full-queue drop paths return before NAPI is scheduled,
>    which can leave queued skbs stuck.
> 

Sashiko raised valid findings - therefore v4 will address them too.

Regards,

pw-bot: cr


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

