Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096043;
	b=T3xT0Ns5p6XoQml8hnYmGqIenJBIPfuoAhY/lULmMM8TH2X3hYgmwhrQhGAZpAzhWe4k
	 1sxwoxSmStcJvXu1i4vgw+xpO8h8gZdDkKJOqUZMnE00tfWG/CqUY6Y9PZ4oAOj14phSw
	 m2svvRtuGPhH80rMdTuJG0EC7vRNZoJLtWhst6TewONC1q2ICvzHB+pcRzc+WVAT1bCNy
	 8Jt9R/+n9eOqH3Lr0VtPNI0kJC32iP6dawvn9QLSuFCcGXSR+9FVfFLke/HmgbKAmXpr9
	 afCAV2zI1UoQf1pXS2bvrXjW4bmsFwYzukbrU3+dxjXNNp/T7RTosRGxvHfyDAFY3IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=w1G++s9vXm09WS11CygwbQvX4YH6OudJwiFpCrR5LmM=;
	b=DZ5SPk1D+oWJzhOcC4bo5AuOiCr0C5/7T9I+Net5Dy04zoBGMyDpqAFYvyfzVTe1fcsm
	 BmZXaczgeA5ospEhgPRIgcmyIDufPkWewKgUezOvTljsUHhbnapgcdHbBoVpmj87Ga4Lp
	 +iFrRCwxFaO1uhp43TPOyO3oSftq+BuS+FDPOg74G94f4PumHSObpF3x6kPsG/C4wyZw+
	 G3wy4rhT9yRvPb1iLb1VEWBkYJBZy88h2YF7vp/UOZupaPQWQ1g/1mDO0MIPLFLHITslq
	 85o05pPAdtYEphDF/0SyIL/RH47rRHVd1+M1lUMa3OC0xZpBN1HeMac/pUxV/Mvth2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UyCcoE0V;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A86606A32E
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 00:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A86606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UyCcoE0V
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ed1fbae872so1354025ad.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794096042; x=1794700842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w1G++s9vXm09WS11CygwbQvX4YH6OudJwiFpCrR5LmM=;
        b=UyCcoE0V29D0+WvF+zsWufPX5C8Z8DXymFDtcv8QAyqBES+fmYXKtLqDv3XPrQ3tIh
         sgwNpiiTF1tuiviis121bucGyhVnYscH7zFWgfFFi+uVKOi1YuqqLOfE2IvHRe6TbQPm
         UM5e6C2Ab22FfJALDj7BwVYKs8xUAP1nFNc1dwTVXV13fGxch7r4rZvSjUkwvFCHE1gZ
         +zcjE+IEFozi4CNm6wIC1x+C6tvn69zxVzaMerdegeUNDoCPg8NRbCL+Sh1MBedAlLvz
         HINL6ZuYc1Ep21bxmM0O4mjDyzJiiZVLvQAXCTsZv4mcC/ZrA8NT5GmCYSVStV2nSq9y
         lM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096042; x=1794700842;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1G++s9vXm09WS11CygwbQvX4YH6OudJwiFpCrR5LmM=;
        b=or1yjbn05Xb7w7LiUGw8GM3VfEwVL9//kJhOkXu3jJwXBoIB1rtWH9iAJOjAmQo2Id
         ctW34QWmc23XJaE79fMqkuOP4HvpoifZzDqdaCugGHQG2ll+sLC4/gn5kRRO5ztf3aew
         XxyzYARBFprS2ysv4vn6+NBrFJs4qWL+e0RsS0spzEjzylMTYigXILjZqYgFJ9t/TSM2
         zPGqZns3OsPyjAzwC5GMQsDt9Q4zkQJbhhkkO0AJKThseAMVoCt8kMehrRCPFY1SGSeK
         cjHlA52yVvp3tXEXQ64NgogUaEsIi6A/YVbsYg4OEb4+/AKn4zR/RNpcgVlbh88kdCui
         JXww==
X-Forwarded-Encrypted: i=1; AL+hErGoCnFHWrNwwz7F85B398Ampe9QXfPwyBn0/uBrKIuY3bcRRdJ3gTwPGXlxJ/PXQvJrzJpwMAc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YHkhrbuj16OvCMjMN1nRoxTFPnisYjtczqe0mWibPwXdkZeaa
	LrBr6IftX21wYev4+f8izb+BBJ9eTq6W1aPrc6E4EfgTW/q/1f4gxnr/dBBMWQJFWxAgjMAsFP1
	pCxt7Cg==
X-Received: from plrd12.prod.google.com ([2002:a17:902:aa8c:b0:2e8:774e:e582])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e742:b0:2e9:6645:e9a6
 with SMTP id d9443c01a7336-2ed837c5df2mr1275865ad.59.1794096041686; Sat, 07
 Nov 2026 16:00:41 -0800 (PST)
Date: Sun, 8 Nov 2026 00:00:41 +0000
In-Reply-To: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107224733.1104094-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <au-7VgkYOwx7ec_q@google.com>
Subject: Re: [PATCH net v2] tcp: fix authentication bypass via unsupported TCP
 auth options
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "=?utf-8?B?SsOpcsOpbXk=?= Jean" <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 07 Nov 2026 22:47:33 +0000, J=C3=A9r=C3=A9my Jean wrote:
> tcp_inbound_hash() parses both TCP-MD5 and TCP-AO options when at
> least one of the two features is enabled. With TCP_MD5SIG=3Dy and
> TCP_AO=3Dn, a packet carrying an AO option reaches the disabled
> tcp_inbound_ao_hash() stub. That stub returns success, so sockets
> configured to require MD5 authentication end up accepting
> unauthenticated data. A forged AO option skips the unsigned fast
> path, which is the only place where tcp_inbound_hash() can return
> SKB_DROP_REASON_TCP_MD5NOTFOUND.
>=20
> The inverse configuration with TCP_MD5SIG=3Dn and TCP_AO=3Dy has the same
> problem for an MD5 option on AO sockets.
>=20
> Note that TCP-AO depends on 64BIT: therefore, every 32-bit kernel with
> TCP_MD5SIG=3Dy is in the vulnerable configuration.
>=20
> Make the disabled stubs reject options for the unsupported
> authentication scheme. This matches the real helpers' behavior for
> sockets without keys. It also means that kernels with TCP_MD5SIG=3Dn and
> TCP_AO=3Dy now drop segments carrying an MD5 option on unkeyed sockets,
> as kernels configured with TCP_MD5SIG=3Dy already do.
>=20
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
