Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851234;
	b=C5KPqeU9m2xnEzmZOYMMC0xr+cD3RKAHzgMApMmmwkqEvDJcvQZDJHJQNXYtkRg1c72b
	 ILrTSr2Oo1cnURx6W6CjfsV6PDKCvdMXd2EJUDhTqKdO1+b0JgsivJgUYhy7LruI0TVja
	 widjYa6/ZzKlWnPGtNDXtuz2yhMzSffJX7txaTlewRG71ikq8rUV/DIscc5ixQJEOsUOD
	 fXGRlbsMEjJXyr9MH8QTfhhcUeXOZm8qjPINAU940o4o0h7FSxhN2vNz/bWqTz/uC84Bf
	 2H0FK5gqLYlgqDhPDCBwNsDPA+/kxzHqlojo7sH16EeuapkhqpkyX5QHIkNEioXDKoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
	b=rO5NxQrEAxtbl2FBjUHQdX4HTqHBgjUNRClZifTSY+HqRMU1vBfGzI9zZUGZQWevZLZG
	 6AbpZwKnFLzyghIZVzFmZ53SaQ57vm9wzcqmslmwI1Axug2aFc8JO5+QHjZmehVhyjPw4
	 RmwOH09QGqsyS5eqGS83smXSfGmub7ojvtXpMvPWvtCHttvTRSmL9VB6qWV2O/eHeejcf
	 VFjhxOW+UPqVy46JK88yaVWd/QYtvAY+D1QuTL6ab9E4Ws1jIu41ooNKNH0xN4xbrlm5m
	 dInlSoEwfFMaWDfBwgqbHRX4DUN8WJk+nncdDW7Go5lVI7G11XmxEFHQcRcIiG+z8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=kBUV5rEj;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F36606A31E
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F36606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=kBUV5rEj
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4395d31228so259040366b.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792851232; x=1793456032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
        b=kBUV5rEjp0fRCUpZgbFLngnN3udOkzuiE/cPfVhL7V9Mk0Yads2TUBl6eUFj+1LgC6
         vNouoW2H2tzekvc9PxQdtfpjFEX3jbdTMmwd4AE1emaJ1tG5z7aSKT0KTqoZXHSbA4yT
         y9pjERZW2GfpFS0TI7mh4aNeJfm2Y/NpYJQWPS8Fx5FprSX5mLr3kTrYdY2jzS3dE5gh
         ZclwHudEDohfCXwNmd8Vnn+MPKDd2Jw/VGrQ4481B7T6hOCExmh4Q5m02PDlvWau+VzB
         QuerrrrB/0kgHyExwFoEGOk+ar5xKZMO6N6H4/z9cBVNrLJpdDKlMvgVxzM3o+/aDINE
         OaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851232; x=1793456032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NinjwXEZqsyLzVMLGtZx22X19MLQYYpk0oH7D7uxDoY=;
        b=PTUB5XXi3Z4cAgEJs4XU4igwqW7vrOtJoET+vUsetOh3aFm+J6NYqkOypkc3M0QHJE
         OlsnbzL+aXpLtJoLzXsEK1UzF6qTH7sQMsQZgwzcBQKVVw8CwqSo7qY7sqlDNC89xm8N
         a1udOARrp02t9KF1EiM0X5UFQad/13iMCZyCZOy7Dd0ZgObJ9Va6fbepWZdFN3dsOit7
         a4e8Iv3WUW0qZT0hgrU9TAUwM4s/blJM3haIDxEIgHUQEQsBNJA/goqWLMiEHcSFD3wV
         f3Z1Bs1B+rlJ80EvvEYIYXh874fyTOn4Z2JpUA8/AB3l8Gi5KirfnYf6k65YK3DaoGYi
         e3Zg==
X-Forwarded-Encrypted: i=1; AKwUvBy2KdcBIFM43+iD84IFqjz5bhQT5BMnq1AI3aYwPJmvRIYasQ+fL69Vticbpz+tBlv21jpMnYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCYNo0AsVY2hoj5ztpGHbdmB+BE77fvtFQnYHzD+80+BKM0QIM
	mLO9aeq7vLylEEMA6rRtnPaJW+G0KN1Y6/LywwlOP2JjYayg517N2Hd9SzQ/opYVMg==
X-Gm-Gg: AYBFou2ROgCHQGvPy2/kCy6VG7C4dsEbav6HVf+E0ub0VUUCWKyzyUTY8lrv1oiwJiU
	Xc2aXdhw9DxMOZ40Wi3FCkYdCNGWru/0w/2YtjDZ6v0Lap34YlUhLU9WrYGKVBlg3uhAoacIQ2M
	NnIdrCjopBsoRFw50onFltemMMN3DG99UWXZX9cu+qOiGjQrUO2k9mMfPBamo6jL+7gcXO1kVfU
	UoEqUn0L2uxMjhFbwQlVUUnMjQj396JYUTfNvQhr7TUJ3+AdLg7bbzGeF0qVgTikwm/lswq+0Ja
	FJ68WPd5CAbJTh4aUQV7LfERz0W04BIvOtxbzjkMvSAlytbpgzqAKBQDy2S8g5D0MZ5VWSp2SXI
	mNFRbhUqXnH9mPkz4SWL/DthDhpq392OWtmeepDUkB1UmRz7vzXc8+O3WEEyS7IjBtRb5SQz0H5
	c3IiaZl+Kieidq1Pl5k2Mr+TZ7bXz31PEC9c7MINYBLCuYSAHMeJBt5vgqCjoSReVerhwYSiUEY
	pYzJOH4/THIuMkdmMlDsFFhSkHmnh0PmrgXxCE2xvQ4Lv+1erG4wYkYJdUPcoclWNru7OZ9EE3S
	StCk1v4Xb5NQGbqGLf3JzpCQPp5SGuKmtDAQMCpjY/XM3y19RqKZl9vdMRChs+vNuEwpKSCvXNU
	gN2wt3nX+QPvmWDBYSNrsCnxklW/43ktM7CiaLureCxoZUdLmeKsM0SU+XpR+PwMG/cCjNT3Ohn
	yFIi2xVvJotLq+AhQQjOPkbNTJeb1HCheo3Sls/gmefcDzgYwmwcSFsiHNbCoqO/IDdWHhSDtnE
	uo6T9IeYEOfoZ7owg0qFObHaa4ywg==
X-Received: by 2002:a17:907:6e86:b0:c3f:c878:7c1d with SMTP id a640c23a62f3a-c46bddb3308mr236179666b.9.1792851231288;
        Sat, 24 Oct 2026 07:13:51 -0700 (PDT)
Received: from Desktop (p54afff47.dip0.t-ipconnect.de. [84.175.255.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fbe6sm95461066b.10.2026.10.24.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:13:50 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	idosch@nvidia.com,
	Eric Woudstra <ericwouds@gmail.com>,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v8 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Sat, 24 Oct 2026 16:13:49 +0200
Message-ID: <20261024141349.2145994-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017235849.1066624-2-julius@bairaktaris.de>
References: <20261017235849.1066624-1-julius@bairaktaris.de> <20261017235849.1066624-2-julius@bairaktaris.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pablo,

Please do not apply v8. Sashiko found an out-of-bounds read in it: with
a vlan device of one bridge enslaved to another bridge, port_vlans counts
the vlans below both bridges, so the gc looks up the bridge port from the
wrong device and reads past encap[]. Resetting port_vlans at each bridge
fixes it, and a selftest case covers it.

v9 has that fix, credits your patch as its author with your sign-off
and a note of my changes instead of Co-developed-by, and is rebased
onto nf-next. I will post it once nf-next reopens.

pw-bot: changes-requested

Julius
