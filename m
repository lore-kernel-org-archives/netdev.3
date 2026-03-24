Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7A37C0FD;
	Tue, 24 Mar 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346730; cv=none; b=hVTIZjrBq7M9Ukw5r7v7mZUwOBqHmqNxEVIRufyeQ/58fm/ZGfcChb8AmPAyk0QwKK45FK+4S2pkVdUf3Sm1kHUZX9Hlx5W07YrGczRr1KiDROKRppwavMSUJJHCGhJrMzqNajm/umAP5WBfmqo0tfsYi32kHYrnAVakcQ2OzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346730; c=relaxed/simple;
	bh=iOk4MpBw/M31wTnsZ1RhmmaaOHkTDuosSlYoFiRnUWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5E3GHJUHItZ0gztyJrjbFyRT/DuPsF9KYSEJdjJWnMYHr0D5VDmFq2ZGvm6SwmVf9VG/HtLUBkbvOr80IFhmgPmczkQxqADKIrTf1zulLFqBTYkDa3/d4UhwpTQAz4q5BLcHw3DWQyDbAVNRzPKRn3h8OhhjUjVI8cE1hd7sQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=ahnUYhlW; arc=none smtp.client-ip=195.10.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="ahnUYhlW"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4fg55B2S4LzDsCj;
	Tue, 24 Mar 2026 10:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1774346142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGp6oK32+2KYSJuSOvHbkz30Wr78JyXTMl4CwcYEEr0=;
	b=ahnUYhlWJmntdruJTCkVfX9TojiM2SLUWOWMM4qFy5I8N6+vKRbkzh6j1DyeUCE2SBEU2V
	AF61EED7aSB35m93u1ernmXCqLL/I+DLaHyNiLJ2JYR4JJ0aig4NM/jEPAQRrIEflyj95o
	orrk4MvcH6kM5LSZlq8oDyb2bOeIVdoGcnuVOYiFIWwItuog54JqpWyoRFpAZZSuuCkiFh
	8KPGFQa6tYGATZMPXAT7RBAQzLqI0a+jVkf9RSb1OaqNZ3CMUxsR3Ou5x1cuJ9EAC1AA5k
	78TJPzb9n77/ABScSikCgSO8J9m2oa16cTPgK2T+K9Rn8azg9Sh0ucApxMnHag==
Message-ID: <a5bd6824-ef48-48f7-8c94-4a00f4aa01c2@mandelbit.com>
Date: Tue, 24 Mar 2026 10:55:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next 15/15] Documentation: networking: add ipxlat
 translator guide
To: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Daniel_Gr=C3=B6ber?= <dxld@darkboxed.org>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319151230.655687-1-ralf@mandelbit.com>
 <20260319151230.655687-16-ralf@mandelbit.com> <87se9vh3ls.fsf@trenco.lwn.net>
Content-Language: en-US
From: Ralf Lici <ralf@mandelbit.com>
In-Reply-To: <87se9vh3ls.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/19/26 23:11, Jonathan Corbet wrote:
> Ralf Lici <ralf@mandelbit.com> writes:
> 
>> From: Daniel Gröber <dxld@darkboxed.org>
>>
>> Add user and reviewer documentation for the ipxlat virtual netdevice in
>> Documentation/networking/ipxlat.rst.
>>
>> The document describes the datapath model, stateless IPv4/IPv6 address
>> translation rules, ICMP handling, control-plane configuration, and test
>> topology assumptions. It also records the intended runtime configuration
>> contract and current behavior limits so deployment expectations are
>> clear.
>>
>> Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
>> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
>> ---
>>  Documentation/networking/ipxlat.rst | 190 ++++++++++++++++++++++++++++
>>  1 file changed, 190 insertions(+)
>>  create mode 100644 Documentation/networking/ipxlat.rst
> 
> You need to add this new file to Documentation/networking/index.rst or
> it won't be included in the build (and you'll get a warning).
> 
> Thanks,
> 
> jon

Hi Jon,

Thanks for the heads-up.

I’ve fixed this for the next revision. While rechecking with 'make
SPHINXDIRS=networking htmldocs', I also found and fixed a couple of
'ipxlat.rst' issues reported by Sphinx.

Thanks,

-- 
Ralf Lici
Mandelbit Srl

