Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7D380FF8
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126585; cv=pass; b=FTLWMkStJskjVUgENkdaRTW3CtqGYAueL+oVywpDtBZVbENt4HD48Emdn6SR30gMV3Mo5p6ECYy1GT3c2qd+ZyMF0cI5E+ycRdowp9AQ59v9AZYBYGo2o3rt/lkAvFxia4v1Z64jx/G6lxxPiyOvfvuf488XR4xEeTHNOvSl5n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126585; c=relaxed/simple;
	bh=dlYAfz8JIaoF6dqy0I64LhGBYYDTxZis2ec/p8KwdX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLTXrjfPg3kOyPnQ8MYY+nQu46KiyXprUJmDHVR+tnBkfRYOfjj17E4mpjMMQnVOqWRjKqmB7iEh+nefPUnGl38GWmbjFm1hauzafjEAhduH7ATbnsoK3/zklszWpviAM9TDD+D5HjTtobdWOBXzFx5d3KzajJWSChAIeWCqRKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8JPui6Q; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8JPui6Q"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53091987029so11416891cf.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789126582; cv=none;
        d=google.com; s=arc-20260327;
        b=QAMck1TRWlBIHL5mB1AC7aHBEFLivL/2d/RxEQ3lfnrcnn0HU5EhWZ+L1aPsOt/mP9
         ZZ5QiiFnwrAsjBMILYObQQ7B8L9165khR9JCdcZcyX4Im+8B0PCEJ4ttfkeMgLadZy/e
         p8eMyj3Xt9EpjRp+73RppuPL8iwPWb7xq1/QMTV/x6JzgonLe+z0nzSTyqJBTzACfZn1
         DMEKeasML/7P8/1x6w+Q1Li6WpFGN9D7zmLUQMl71z6edye8aE7fL/i6RmdjJy96eor/
         fqEIlCoql5pjtVI8IGxntEW+lGTSF/5nsezow69VoHWspCekviDnLpLaB91s8BkmPA7u
         Fnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlYAfz8JIaoF6dqy0I64LhGBYYDTxZis2ec/p8KwdX4=;
        fh=WER2jA91bZsz8XJ57jegGCvF/dk456I5QoPeB3xKftA=;
        b=R1nSt6CPGR+Xz4s0I+rz/fNbbRLNoRLDbGMMQCDQ5vIrPUowx9IhKZnOdmAc4sPo8Z
         zxJlbl+MF3CRs+a//4VOi4w12thNl/4zljrfg8K8rv+lIhoNWjwkSsaBTvx/XhCqEYVV
         /43ZuS/OltgIBlG3wIHN82ArmS6rr2BYLF+h/RIRD35WsA/JHUp/gE17Omww4O9EAaxf
         bymCrWx28hJ85dqyH8PUB7lw75eXLCGZcZtabhm8+vRcDsEIjQZVDFZwcbppoj/bH+si
         044ZMUFCG53gR6ZUPci+J21p1u5AMp7+PEla9tKyZAPAhNHrG3FtC8YcKJCARZrvD43X
         UgCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789126582; x=1789731382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dlYAfz8JIaoF6dqy0I64LhGBYYDTxZis2ec/p8KwdX4=;
        b=l8JPui6Q9knAzxSpvb0E9vDv8FNnDdkpu/EFhIW4mtLQO4YSFFDCEDH6/Zx0CwXmDm
         pC10qmedzOIGUG5JI6iFGtEBa6AqeSy8TISE4d9wvdTzHB+r7pQLhuGiFN79rnid20an
         agWPtRgWCY/3uK0BpwNBz/hRf9k+iQNgHBawiyhD+J6PeS+yMleTyxbilUKkOVb1ghnY
         pzMMXCgrjgk4kDm78GTG87DH6ipOlcUSEp4i2ayGYv+XCzVuF8/jHm8YHnBMD1zD+RdT
         NoFVWC0OyqYe4vtM2yaN4kj3it1F2lmIiNFc2bqo3s361vqy+MDU+1yBx2jdOMXtGivh
         os2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126582; x=1789731382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlYAfz8JIaoF6dqy0I64LhGBYYDTxZis2ec/p8KwdX4=;
        b=MT02hQ8N64ocX4r3cWKET8qlOecCgINvs57buYU5DSaNNZ2tJiNUQUcm210ELIQgtd
         iBk95ejXIxbDnFLw47k23V6KqeSox4EcvpukQgEkJajniYh8+RCglnBbH+JcXBNHcnB7
         saQKTh8icJWIFonoeb4eDCK+bOTCVbW5zKXNzYkoMvXmR03KC/+yzLaDv2J+LTj4LSVQ
         ooXT/1Cd5hHrI9l2uNtVbXGrsy9l7c8StCfJNmTzRvdUlmSx8q9lR1kxAyl7DSIN15E2
         i15TmbQt83Be69e4G3AIQBZ8e2ky/dD6ZKA/t03bgwmjzRc39aTUckR1/hvEq96HuZWH
         nRqQ==
X-Gm-Message-State: AFuF++kbQbXnVN9qBbxXM7e+WiD9veYeFsorpOU1fCw/pDsJfqfdNrDR
	24ws/tXq96yPyeWyCBcc4EF6ZgWQ6EARsKEV/ggcrhZ16mUk9jE44AQy78BA8ai3zq2Fdlan+1Z
	c+Igymbg/wyyGCTsbMwtSZqtX1ENLBOc3Ty7cdYrbNYWNcm3ReO8mzsWotW1npw==
X-Gm-Gg: AYBFou1cLY6FH+f1ykY6U/nNtR01YDLYeG5jce66c7f5JiBtu+h6Vl6V0h4t4ucMvyv
	nlasGDPLRtMlTs1ENxijtnLdQ8E4H4Nn/IHTsYq7JkLVxzFuG+euA3/1D/Wxni8VBhg50RsUlAW
	pfOv2LvbRxA1a1OwCECBejFgV8Osa6lXyIfUT24HMg7WQ+bKphUnrDGvClKlErU28S3+t7Io1hX
	DTdeIJhLIKPh+8Y9+Fu4w6roSYb5SsZ+lBZIl2NSAKsWQXVA1v2yxJnc3ltPBB001c7nDgSI57+
	oit8irONj6BFN4UX08L/kQHBGPpgqAzskdjZvI/Ipl/KP8x2tjOQCb2oAdDE6lO5eR04GXH4GwE
	K+WC0Irhyqy5T5rRW557+JeQEKufcyl2fKG/qwA7nUXupvn9EyREZR6mgbNv16V9vKP0=
X-Received: by 2002:a05:622a:598e:b0:530:7e29:bbd3 with SMTP id
 d75a77b69052e-530c8239c5fmr56322481cf.0.1789126580861; Fri, 11 Sep 2026
 04:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911102418.157071-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260911102418.157071-1-xuanqiang.luo@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Sep 2026 04:36:09 -0700
X-Gm-Features: AcwNN1VlD8vfT-AQMygbfiq5AMX4J1WQ9HGjOGKXWFyqcwIWdH1u7L5bOueS0HI
Message-ID: <CANn89i+GwOcPgGLv-7uWEhh4ZG33s251UGOjJmGagzYiVqOAAg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/2] ipv6: make IPV6_FREEBIND and
 IPV6_TRANSPARENT lockless
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 3:24=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> Move both IPv6 setters to the lockless setsockopt path.
>
> Patch 1 handles IPV6_FREEBIND.
>
> Patch 2 handles IPV6_TRANSPARENT.
>

The changes are fine, they simply align IPv6 with what IP_FREEBIND and
IP_TRANSPARENT have been doing in ip_sockglue.c already.

However, both patches touch the same switch() in the same function and
do exactly the same thing. Please squash them into a single patch in
v2, no cover letter needed then.

Thanks!

pw-bot: cr
