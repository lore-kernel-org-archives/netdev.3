Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255464;
	b=rJR7szLdc3x73+lN7vipiU2UPhhkTNMu83ixHm2w85NStDB01mI6fZ85rEe0B62f6ZA+
	 fu2JuW9xO+EIME5GYERkutcNYndccjOrITJksIXxotFTalQhUMSE7HlNji525EHJwDMwX
	 c4yYZjqsddDJpTZYrD/gTvcXzObO+Sw1wfBwYt2oLAu/1RCsH7TL6iN+IF7gUN+W5lW0l
	 fyxc10fGvSS+GnEAT/iwTwM83IuuXiuXem+o/jkwrElqxBgLZ47LQwVQbtPXXeXf/hg9p
	 RO6lE1Ri4Y6W8UY6GX7jM+ioOSSf0exBrGwb+y+XPswwXxuDUuz4xLo7klvQ8ifMrIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
	b=bsxPxru1/O4+JM9VOC/aKBCUsmN5JqceQK8v1ZxZbICoNxhHldr1jG4lgFahs1jResyv
	 cBPSrJZ/GLdDunhkr3B+aNmrkRVn2+uG7+HdCce7XIYjqqM4LWiXzrbTpPTGmKNX5NUcJ
	 Ba3zMHerabGz+YCKVLXPG1QvqClSXxIfs67Rr/IJwdjBiHCYyLhS87dj3B/gKf41Bmu0D
	 veul8XS2rE8OkAzN7jZAbcG5hSCCriJ0IzIRZT1ZxqI56iBQVWBzacgqp/LFH48MBzKpH
	 n6HeXM/yIBaFoEIBAd5fcZusdDzLVQeKHlbIeA09/UJCtjWrG3JpqllkJgROae3IYjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P0sZXvsq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75D606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D75D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P0sZXvsq
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so42a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255463; cv=none;
        d=google.com; s=arc-20260327;
        b=afCwt0ggItyRcQjYwfeQaoSq2/QyJJtOOGIQpLLhJ0cfzzGEglquXOz+88ODRFz1zO
         Fem5PRv2SP1rnK/DdTyVYoGyt1mq8teV5GEQZXhdid1TDA8ByInRRDPpQNO6OZgHrX4o
         /RfKW28HJ8qR7j3E4a3hMGZCGg0KtEIqMyYBmnz/6CV0mMw0K+w+vVGd+F0wacj40LUU
         NXDH4nX6ivHQ+KpAdeoeOYxcsdbKRm23aq63LMBwlExzYm+zchfhX3WS/JqO1zHkfa7x
         qBCEb6Ijtwm+w0c0uEIJ5iHr0nIkrYE55KjhPS51DzDEofVGCaV8oEzatR0f7KSslgA0
         ya4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
        fh=XoapXtRdy4RzuvD2g2bvR6Xy7dSsyccbI0kaYk4zu04=;
        b=pwhnmod46yjhMrXWDUqZssiZjY+PwxUZyq2c4BVItshuQEHiUBJvwzLdAB6bbnxqIZ
         SLEQptauHsufqDGWbSaee6jeaj1PSDLDBTgWbOolaLphBamx8W+9XTfOcQP0C7Z7nFOr
         hTirWMt4zHUEOrhJ0xpB4/9qHhDf0jTLyXnfqqgpWzzqV6hlUEJKQMKrm6B8gbc0122g
         jF2GVXwkqH2R34mT2h6bBDM2QBO3my8f8/6bsh+brCUrqRTHMxKWVD7ti4ReW2hvV79x
         6gFYwfGv4b+tT6SccMVbMNQs1l9V4mFdvoKKYBHkhlVfv841Z9UReicmN2Ccoy+cWjda
         p+CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794255463; x=1794860263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
        b=P0sZXvsqIohLE8Gp0wvO3DZJR6gUx3reQ55TVmSn9CykBgFrZfrQjaLL4smDuM0j1b
         5waQ6jjkuJjTO+9bK6d70m2Utj/Bo3ByzfIn4qpnN36A4OGr4mTtX+4jwHJPIdtm2UYI
         zUcvRkOzUEgrz0Rkzq4ZKf2kebSPB1+kFy/+FfAG7cS+e78EJV0P0VlujXhU9iu9Hp0A
         8i/yBt+1uCLDsBJyHn0CJe6rqPWpfuqyQiS+hb/gskzYbsqtWwWGnajuRq7Q8FrF6ozZ
         eZEXUqvB8fN1LtEJQnXQhyPhUQZhECtR14nfrxmKUEg2/dcOy13bALzuaFxJftMKZ4jM
         dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255463; x=1794860263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltRfrvbZQq2u14YHzE9ATEjjt/vP6akccZZlMBuYSXQ=;
        b=WERggXBvSVP7G6mQJe//eaZU+uS/zWCBlsEwV2sx5pOIftBahaCWpZhn4hJ5o07i88
         Z5QgJSzFnXRXDhnAGYiUTv8OufvkdhIHA0BO4vMnvBcPW9iyC3Q8opyZfZOlT6p9LZ+H
         P5mC26jx5GX3Ra9GINT+VZcwggqyBcxYiYB/5GaePF1K1EOtw6DvbM7tdwr0XdL7XmiL
         tIVClc237I0drjW/s3EKCA8fwJG92kqzv1vrhQeAbvfv3SMQVXY1fSdaThufUlu/0gWf
         7238jCvByJLu5h/C0QOAFic3QY208WM+ezPmoLSeuQYF1MkBBRf39lIwfmGIR5s+SC5Z
         EXew==
X-Forwarded-Encrypted: i=1; AL+hErFw6zP9J3PCWLAAkokl0o5OB6ZbX1qrPVBi72Nqx8sCwub95bNU+1efKmOI2mfyBfLwWcA53ps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZmFkGvV9H8KQF5D65s6KyHhkT8DEXLiOXsZWSoIAFK3oFkqNg
	Vz/p/fN7POKCE0luB/PpnSgZDiDB1I77IETPTOb+BmTSqeVwfjKEAvrsh9tNHgDZbpdNtq4MJSP
	T1UNwpzHj1k9LkT+Xz10pYL2aNOoxo36JohrvHd9M
X-Gm-Gg: AYBFou0ZfWZvQsh/8w7eMo+f0cPrkc3yLW7ZhAgB084sUpLsOfXL2TiflvC47+6dTPe
	T1CmKdrwls2qrizE6Leb7H5JC3ZRgbOvvEIk0rvPateKX2YDTj3quLLL7uhXWonfwOE42lqTFvf
	4DO82649wikHFTzIEqsUbEr2NClmAFx+FG2bLozpkZV4DiLdaKI6oPof0swg3OzELMqCqITb/Lh
	Ir0pd2kHKc5e9LJPy+Twnt1LoBzDCVmyCODL+CfwCjCPRsgC1hekldy2ztkFIRYb3aXjqEi61lO
	LIj1wLvFYATH5nFceWFSycmqm1fqmsROqRL+qb2k/lToU7XFFn8xVTweWUyyjmbdjzN6jJawTDD
	mt6msV37hL/0hFbjS8qs0QMIMlLsQNRL7PtiQO5z5wtk6iNAkt1YzNLaTccAOUB9CQD4=
X-Received: by 2002:aa7:d7d3:0:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b756af180fmr22485a12.16.1794255462346; Mon, 09 Nov 2026
 12:17:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com> <20261020121858.3b9107c5@kernel.org>
 <CAHS8izPwWT+vbgAe49m5vXsRxT3unbfjLTkVZBScgAPdQTo2dQ@mail.gmail.com>
 <20261021132304.23e0a4e7@kernel.org> <CAHS8izNTbs8ONvjhiw+6cRkZQq+cX3t=BZK9aCr39JNkVbY9gA@mail.gmail.com>
 <20261109104959.181a3b35@kernel.org>
In-Reply-To: <20261109104959.181a3b35@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 9 Nov 2026 12:17:30 -0800
X-Gm-Features: AclHuK_0MFErjqghvOz060hZJCCzy2vAPCeLH5qWi-kHJsJTH_MqHsOjMY4lEMM
Message-ID: <CAHS8izPcFSLdmq16ZrUDKpCqUJf513EMs+Y45brc56s+mUBmeg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 7 Nov 2026 22:21:48 -0800 Mina Almasry wrote:
> > So I started looking into whether we can improve test and fuzz
> > coverage with an improved netdevsim. My LLM prototyped full datapath
> > (with devmem) and offload support in netdevsim so the hardware
> > selftests and packetdrill run and pass in a plain VM without physical
> > NICs. I posted the branch at:
> >
> > https://github.com/mina/linux/tree/nsim-devmem-rx-tx
> >
> > The main problem is the total LLM generated diff to netdevsim: 62
> > files changed with 5,525 additions and 672 deletions :( So it's a big
> > change.
>
> Great! Please keep that slop to yourself, tho.
> Upstream isn't built to host people weekend slop.

Understood and sorry for the bad suggestion! I was indeed unsure how
you felt about including that kind of slop in test code. It was a bit
too tempting to suggest it to enable the extra test coverage.

--=20
Thanks,
Mina
