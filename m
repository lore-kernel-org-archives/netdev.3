Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493914;
	b=V9+kutAPvLglVFm6HV+bBmqVJ+xCfTlSw88RS91e53NJwJSNSv28WuHcJ8DQOiJjcqMh
	 doitglAtuKteBt9VL+faW2WGgWPEMrtDpPRTRK7BGpRSwPsmSlCBEhDbL+kLOFwn7n02R
	 pwRXnHATcbswni2acVQpsbRBTi1DdrueRTxWz0nPwXA0BP/BodXaSaqCZc5Qfqo58+43i
	 OF7eoUC7JIC9T2v4nEhqlqIbUuqdKAJVMwF71GNQEgi9b6+k5OBaicD5VJQ4MvWPuQkn/
	 VEztKCVJ3HR/fia4DgGar4NbdRIQci8+cFyn/dlGZnsQs7qQZlwJjtB6TF4iKe5rLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493914;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9QhabZ5Bs=;
	b=Q8nQLoAS8NcB053MN4zkrdw9OWYLb45HAYXuZZslP+T5GX+2D47siCL/Z7UGdkZ+MY9z
	 OcKDO3Bc3jTXgHj3tFp7kK0eYKQoV+jpHFp5KKQc2mFG5lNYuC2TyMAV2pJo5USXLKW0z
	 RMTFBhvoav4ujCPiyCAfZFYP0/r7UBUHRuZoQfcNJv8l6uV2FuYXE9Ux0BfnRi/2lRfVE
	 FQDbqWM8tAJ56UpfQpyJOh+WVaZNbuhIs0ST4OKZS3OE8PEeX30dS0Iey4NHB9s+TEIIU
	 onXW4KmSWYvCvwMxEjMkSVK7kLLhSpsJaecP29Hg19LzNes140wlRhcvFhwrudPoIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=queasysnail.net;
	spf=pass smtp.mailfrom=queasysnail.net;
	dkim=pass header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=QHcDcOVG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E98saQ7+;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3B606A336
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E3B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=QHcDcOVG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E98saQ7+
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AFFAAEC00E1
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:58:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 20 Oct 2026 06:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1792493907; x=
	1792580307; bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9QhabZ5Bs=; b=Q
	HcDcOVGmaz6vX+UIYmgkLsrzVMPSNy29esctGtRl3AKaDDuO2jWaN4nnjLwD9ay5
	DfB/4MxiX3xFvmlG+D254eyO99egOP+cfTKFWg/5ULUWQuuX+HeHZrSdLPoJycQM
	eFXrJlm6cPD+iOCyAii+AA9/353pbq/Pch1JqDCrj7jNfFJePnnCozCpEm8r77PE
	q8mG/DRxJyFnLq6Lgtxq4jsVul1yVVAxk0Qe5FDYKt3c7F1hTt+vngxlBNDTKQtZ
	zGYHJCb6vExqwzkl2OiFj9LIFFg4m2Ra0w3TUZ7xvrpH/92M2ErI2VxCLr1I/pIO
	MnxXo8YbXOrtu4c59TTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792493907; x=1792580307; bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9
	QhabZ5Bs=; b=E98saQ7+fZAH8jJlZl9BcYICKjf8kdPdj5jUeUx7fyXEVuYuh8G
	fhZUl2EGRFRp/CDiD0T45axIiuQzsqvdspkG6opC9F6Lu/LNERX7y/vYQ/H9ITxs
	wwnr6bI/Sd8iLtpDVy1SFyLMFVzcrCo1g/zVQa16juskBs9zquVPD6urjAB/gCKV
	T9914tdsX+2F9rEdA0dXtWf2VF1KQTx6IycAbCfBQKwlBoBHBedeAhw9AyeMWUh9
	Mer2pLTbxoI7cRa1CgoR0y1xOnf23sllzwEQtNFesx7qzxMiVtOUOmb/l6xhuYEX
	Lk/UAszSiV6OUv30FqQpytcbbcb5FaOoyIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792493907; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:j9gM8dgjZTQIvIo+QkjOzylnPbVKB6Fqm9Dzyb0gksEvzGg
	19pytNqKtD03C7qmrYnWffE9o1MZV6Q6wUVgcWF0/S/XYq3pqy3IG3uZla70taYv
	Wx8JpdE6Vo9VIWlhyFkUNzm9dufJpsz2JN2Pc++rjydQ+VKo/0sYzrSgQzZvNFTb
	Yp/gIMcB9E6N4VQGxt4GhthuLgkdh0HplhmJrRsnBP+26fMewKKJSWsMIY3mqb98
	yFaDu3HGXQYfvE8RvYPvcPFYvfFoR/OjEGs2P69+YPa3p14aNLxqe15jW5+DXfa1
	qzXJ6EwaL+OqE15bxlPgMqwt3SGAeL8idAAoEjw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tANeBEaU9fAbLL8ASsdV+u1DOi7myWZzyDgqpLt22vI=:XWTAZfIddkwVPW+CPsWGSvyj4ac/JppaA8LmC6xSMFY=;
X-ME-Sender: <xms:U0nXapRWPRUSDpDbowHlGwai-6V0MMIPraotzcSy9aeKpMyy4Riwjg>
    <xme:U0nXaq6mVXpJf6-Ke_Aze0jMDT8T07XGviSTZjUYxGKRP1pt95_ngVrOedhtPXaaq
    uvJZwY-GTX_CD-x8YQ9VGfTWro5Xb-qnBopvXrOZCZ7FsrCugT9_sI0>
X-ME-Received: <xmr:U0nXauVZOWDP6mF_50OfI2GjrkxX0KLR8A2hcaNWtGYP6bCrggA2mueHDM8>
X-ME-Proxy-Cause: dmFkZTFXEQN/Xxf/lgfRpKYRYGZEymmhlBHtyrIXr2Z1miJzA+kYdEmNb1kRpKSNZTtE/C
    BQSg16Jh9mnkyfKJ4EBCN3d827zkOejqoLctJnrTGE9/xtf+CrJdPpjktqHbho7FZXcQIj
    fmpuiwCaJQYh9Yt8YLA2tTsW1WO5raYx8WlxiVlUTqCqQtohLa4hvBP7odHQJJWcUPAGyj
    CLOPP/PZbxehPqu9NHQQ/T1fAI67GvTZhjCZRMzSjkHPpJ1jVbFN4VHFK5SFq+uw22nIEg
    SwCfl34WmjPwwlHTR3aXhGT40Jrz7J+Mdrr7zwD7dJwbBjiSiNJggDpKTYKdwVcjP7ugWP
    3H0HP/dYMfp5E76ATFY9r6seTZOmSCIujcgqvJmJKTAgkmA470shzNtlJi/RwnwQxLFpPl
    3OH3/EKqvyBMJ8W6t/2kHaeq/C18Jj220746Tki/1DqTDRieyubVVsoR8uMTena6huD7CR
    V1HwvjrhObXM8iXTVEQH4z+SfH2tUJD31JVJAtllyS9itLkqC+MfcV9XMHjPJgMa8sdY8b
    FRxt3gg283JMxOnn9a+kWO8KEbqhsq9pInsyUJtvQgh0c7MoSh3LQprqpgYle/WYhmpUvX
    ZFNXv2R9MQZU03Hnd2VV+N3vjQK/v1u/TaM4X4Xjk0gXenh/pX0cMG8nluuA
X-ME-Proxy: <xmx:U0nXag-DtUZIhPGhuYHnh_5fuK08SljIqQVPIIm9qs8lPeu4ShAT9w>
    <xmx:U0nXaupozH_5fdrs_UV8GvFBGihwM3htrzlM_HohHnBQaHtAPJvhrg>
    <xmx:U0nXajKHcBnQn6FOCIVnaSZ3QEh0hc2jfwhIx17mOozdzIn41uHyHg>
    <xmx:U0nXahOHYoWbNlvRpS4p0cd5U86RY8-NgkK3GtGa1UReFaBho9rlOQ>
    <xmx:U0nXah2RlhgqG3oDML7_Sm2UFU69iDtaXEolobHIssChVeozJUmTE16c>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 06:58:26 -0400 (EDT)
Date: Tue, 20 Oct 2026 12:58:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, wilfred.mallawa@wdc.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
Message-ID: <atdJUP6Jb0jODBYE@krikkit>
References: <20261019222626.745408-1-rjethwani@purestorage.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019222626.745408-1-rjethwani@purestorage.com>

2026-10-19, 16:26:25 -0600, Rishikesh Jethwani wrote:
> do_tls_setsockopt_tx_payload_len() refuses to change the record size
> limit while a record is open, because both TX paths size the record they
> are filling against tx_max_payload_len. It looks for the open record
> through tls_sw_ctx_tx(), a plain cast of priv_ctx_tx to
> struct tls_sw_context_tx.

There was already a patch for this
https://lore.kernel.org/all/20260901072927.128688-1-jiayuan.chen@linux.dev/
with extra locking to address sashiko comments.

Jiayuan, were you going to send a v3 to address Paolo's comment? Or
maybe resend your v2, since it got marked as "changes requested" in
patchwork?

-- 
Sabrina
