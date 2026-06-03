Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0839A4D6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471104; cv=none; b=IiykWsvRLChcHgmAJO4y2mlO6iKgMo0YvNVCeIeq6bWP4DHKDg9ypgRylKZV/n3PJkWuj/DodpifKOPEtNwzH9dl1QPTiqYpNdz3wEySpFJi9i4HSPMILTYKbn0iW3dDy7HkPyI9wfCilUSxVMQMgSFgOIRlWecBWA3SsC13tOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471104; c=relaxed/simple;
	bh=6AZli0waDkqPPv4RYfw4UTCBZr6umj22h0dhXR1Jr4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4P4LYaFwPgMKFmUBCD9FCeCy7OuNfPYklExcWFewMEDGWBYXormECXzBdAZDK4kPT7S06qz0IrqvQnEKK8fI3BiZNrZ1DRUqI6OdGs1rpiFhAuRld1RdIvr//6H5kzmoNccwUkw7TxF7NvVP6EyWvhSkblmMyHZYMVNPuTaUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PZo8u9ES; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PZo8u9ES"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gVfDK1zM1z44TC;
	Wed,  3 Jun 2026 09:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1780471073;
	bh=6AZli0waDkqPPv4RYfw4UTCBZr6umj22h0dhXR1Jr4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZo8u9ES/eDEnOLUv4zPK5PT0RYgcx0DzP3CNid17so5QbcNr4mNP3zXV7GzevQph
	 jVeen7yRdabS2ngfW2VxsarG4/o4Uqu+NFfdRrUz685pLJLrlDhsZHajvG1pT9ONwL
	 F14AMkiodK4oLDhlXLdPdowPukLu3HYDYzTvFUEvTfMyrERizr8mBWVR5igbwVKzMi
	 tiQeFAqy82C7jKLXGFEiMG8aR2mvOAVJNuCm4xCPSpBeC3CzG+FHBjCqtYU5qG01yG
	 fWCEwji0RQk7SGUGK+46P7BXUzjROEIkYn+O3G+FTw4sqpFvLQyNtSwiaFhJCSC40g
	 1+Zwi6fLifhbg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gVfDK1FmZz7x8R;
	Wed,  3 Jun 2026 09:17:53 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gVfDF24yqz8sb8;
	Wed,  3 Jun 2026 09:17:49 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E18645F96B;
	Wed,  3 Jun 2026 09:17:47 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
Date: Wed, 3 Jun 2026 09:17:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 Chris Adams <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178047106860.2884229.11167975002197488257@mxe9fb.netcup.net>
X-NC-CID: oXfrpjjwOSKR5sEbKrJBTtL/u+qg0NyG0cVHx0QSERX9DU+6VGE=

On 6/3/26 08:53, Íñigo Huguet wrote:
> Stating that the order is "random" implies that someone will change
> the default insertion order in the future, as the documentation says
> that it's not UAPI. So they'll cause the UAPI breakage that we are
> trying to avoid now. Moreover, if we consider the default order
> "random" and state that userspace programs must not rely on it, why
> can't we change it now?

Because the UAPI is only indirectly important, as it's "something that
used to work doesn't anymore" is what matters; you in fact can break the
UAPI all you want, as long as everything continues to work. Or to quote
Linus from:

https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-what-qualifies-as-userspace-interface-abi-api-documented-interfaces-etc

"I just wanted to point out that the argument about whether it's an ABI
change or not is irrelevant. If it turns out that some program - not a
test script, but something with relevance to conscious user expectations
~ depended on the old broken behavior, then it needs to be done some
other way.""

Yes, he talks about ABIs here, but it's the same for APIs.

Ciao, Thorsten
