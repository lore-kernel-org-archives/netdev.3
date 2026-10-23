Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784199;
	b=vEiKs/fiVqSgKMyg1aQBd9QA/TkkbUaNkoqR1LpHwliQkKBYPJ/TkBSKAUgqUipruEC2
	 4mTCLgpMd4mGlX88sEOxGooQtQPTvfHrN0nyJ7IybSJChXot02FS3q6SZ1RCb4+8ImMwy
	 xvwmFHv7AfQDejAPh1ufDLT5K+IM9OJan9CSwiaVYo9agozoiGSFxsh0nzcll3kNrmois
	 t60ReU3WT5ApecrjBIHCukxqEG0qVBp3XjHaQ6qroE5HN/miYjRTzQoyQTAVc76wPe/Sg
	 Cw+J2h93SE/6mwYLzaEcOwfYBt8ECzGvN0xtK/uosJ2LY18DsSIHSeJ2vygIX1vcePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784199;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=F7Xq8j2EI6BEKwkkHRErMC70kKdur+rTWQ8y+nKRD4U=;
	b=FwWQYqt4B/Q0TOpgtlL10BX4v3XGKFHc74CuMCncwE9T3OKMkTol42VQyuVAV9Jw4zxf
	 0VAGJwQw/AYk3MdiWF9k54IG0ApcdDeQFj8+7GRnZV0JLWjREsVNkZvJ6Oo/AHjivreJK
	 YTvtWG6lQcUx0nD5iCTx1ci0PKujCeQvAxx+NWLBBOrjUq5vXe4b28YvpQ0fGKMQ/YYzv
	 u726bTFB8I3D4gzbqAgrdqbAgrUhhF4Prx23QuZmgDZmxoxg/l8pNtpWIq9d5V6UeQgTu
	 bkOtAh9I4UnA12KQlQgXV/3mGUM5fKYCG27qeRKKZTslZYSiURgCHz/ds5RunzAXimQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLDDOtlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C97606A31A;
	Fri, 23 Oct 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLDDOtlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039291F01825;
	Fri, 23 Oct 2026 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784198;
	bh=F7Xq8j2EI6BEKwkkHRErMC70kKdur+rTWQ8y+nKRD4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fLDDOtlv4RMGKcq8ufhAHbQBYArY3h5+Jr8oMJwaQaFTqVHer/L7s/Ka6sHd9wxoU
	 09l25HzSXSXtSbAuRX58b2f10QYYyGXRXwY8HxkNOJuhiwt5ikOsbwkGtQDPGiaMAt
	 H8zgtgC2cD7qAtNsUpt/M5HgIEyfGK8NUabCpZqmR35j7+Izul0TJ9lzb5uoIrPWMR
	 dbAmvm4zQRSOD7nQoNLlLO1K2FiqjJLh7QxEmX8b66z+k7MYvrkEAJAUVz4Vv/g/Vz
	 /mnWh86WHq3HFcZ08xlrxda1qExXKc/uEnwpaGFBLfoDm3jwV1iQXdRLIIv56Yqafq
	 OLzx7bHakQV4Q==
Date: Fri, 23 Oct 2026 12:36:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, =?UTF-8?B?UmFm?=
 =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix
 Fietkau <nbd@openwrt.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
Message-ID: <20261023123637.1aba3995@kernel.org>
In-Reply-To: <CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
References: <20261023005313.3946390-1-rosenp@gmail.com>
	<179271707120.3327.4775409276963055481@kernel.org>
	<CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 18:00:53 -0700 Rosen Penev wrote:
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.  
> I added Suggested-by in the commit. LLM only used for the description.

Suggested by is for suggestion of how to write the code,
if Florian reported it appropriate tag is Reported-by
