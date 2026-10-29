Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308928;
	b=aeN4PFf1ECQNneOl8AfJG1hN2GhcUxqsTOWXuQN+1vjarxw0u8z0wWBbIG28i4k1Jit6
	 CLGRmYQb4de61XYAJZFghjUPLF9/cM2dhuNr9eOjjkbwFaaATrbfLYbFKDPYLWIJatTvM
	 r/iLDYLcPQ01/JhOvm5xVkIfCuVALVcQIPwHe39GgwtqOBj8OqEkyB0f+/vO2PktrWJvL
	 b0ove++XS7Nx4wBuMkLOCc13ib2swLc2omsRv3T/CK9lKh6tugG80XV3K4vWFxR9mAeyg
	 Nq1NtDn0zGT53VMrxYMDSonrZpuRXjO7dpXxvILvIvWHvTzB4cFNAv+Qs0QOdySp74A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LoPnVLFU2grju3RATLnVH/Dnn7cdm50tVx8bnt7Z2pc=;
	b=Y5vy4UxKmoGzH14QXzb1M3iudYjsvqqrUPJNu4r5cV7lwgiX3EimZ24Fj/fdpeJZMiO9
	 KKB35LU9V4TYR18MUoYM6SwN3hmR1v37cjRqe0NWPyOuJF6xJ9sm/Bd8GsDb0emHEGhpf
	 LDxjcfxz4UzCdFDYFkXDRsS1576IKUefFHLWGEQx06LL+Nhb/iDHYVjU9K72dKnuAU9cr
	 5c8vj3a48BWZMqPSbTPa4w4wv9D6DCAcaoxVnYufUDQ9cWW4HhNY500Tz11f6g4s82xIa
	 96WkBImzGEO9nNU03Meqhy8vCSAMh2u4GxIC8AItG9t6EtqqSOartNVImf4PxlPdHwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nuro.ai;
	spf=pass smtp.mailfrom=nuro.ai;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8941606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8941606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a18fc7a38so215922eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308922; cv=none;
        d=google.com; s=arc-20260327;
        b=PlDNxmKMYGx71kkkAPtYk0FyXvo7QRHotvCMCHDFc5p79sbgHKjpJBGocvBcN+QsiY
         jFMYpdWPtU1qiaxCNu1I87GVNFqfpj+xm1Fs4RsRhfjg34obG8HJ+b1ZATwcBRzcsllR
         wjA7fU4xKiSangodPqaocrN0uklHXQA93/makTVTeWneYlEu5qbdTWSYhV74W2sMBZNg
         hvymJLmgyLteWJemWs5lDq8C82hF5fWkE2DcFGLqRTFuMrlBxvpzHNxcCP+4q6Mp3odB
         QfM7VyIEOeaPcH2D0kyTpwwgbly6SVXmr5+ZAO4OITbq4Wngrnv/WGSoRavXrlIvkdHb
         EBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LoPnVLFU2grju3RATLnVH/Dnn7cdm50tVx8bnt7Z2pc=;
        fh=yCSJ9rjq6+qaHvIKdTmGwfQHTQkjj7gnS4vzhN7zWQ8=;
        b=YziPFnr6QpQ0hec+ZXWya+wYYIUtplDBqqLd4wqlT2Rj02q91MJM0tICYdR8EiIr3t
         kztUZt4YGZZtpnjHSEV2C23zEeiO00R0sfYGx5b86tGeqtIjlHslkHAHT4GCakgl69T5
         wvS+bUfojSDLPZjuCiN5WkU+IquKwzOEedgde81cbSmqjR3Yp1S0uhiWLgsUPJWecktT
         DC+SOC/3mcVvQoPEVRWn0UcoyWzkzgolM5U6zyjU1cwKl2/r8cMsLFD44LYzQV0DKJiv
         L0HOg2Wsp1q2FCDLri8Nj6H6s85Cl3Y6X+b/bOWAtx0gKKdL88ja/5bo20HT5AnM8zj7
         LOyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1793308922; x=1793913722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LoPnVLFU2grju3RATLnVH/Dnn7cdm50tVx8bnt7Z2pc=;
        b=Re6vMFfK0sToGoINjVob2ahiCOouBs1MFolZogLftA8wIO4kshs+Vy0hn7J/oMf/+/
         TQvx8AmolIvg08Hx+XsiIwrr0zOKFFCiohx27qaot8re73AwfHaWdb/5pvp0gUoIWdaW
         ikiIjlhwEn5eoa6hW0oF8m84scPmznyjN0B+e9POn3vjj5YP2N+T+o6Yll0A6nidEdzM
         hS3KhrbxSIu+8ofoZxFERoP57pIDR5fLK/VmmbtnUbzdfNK2yHpw+uGiv78s6KvTJVse
         qeoSJkJyo7Rl70OUM4f/wZ3k0nrzOiH6nBNxvwRFw1U10f8qWu12BDP5sF2syXCf9jMn
         6vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308922; x=1793913722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoPnVLFU2grju3RATLnVH/Dnn7cdm50tVx8bnt7Z2pc=;
        b=xxCzdf+e0FnheGJV7ccF3aul4tvhj3ci4qMwODIxdZCZt9ORAPEmuToWp1YN74ZgmZ
         z07x/Kkquxmvni4+7BwdHu/eqf4Pc+Hkt0zDEkXOrDh07E05s9cmlXanoj8zDKl1PEn6
         VshKxszed7YDH650pad4VS8jAk4yQZ1ZvuzbKEB8tqMTnFg7AT7J/CI/rdflFso6tSmZ
         JN5F/1XH8czcqjQyR/qIVkCb+0Troao7sY4I5lvvq+WPYir7leCVBxG5wuloG0YvgBXH
         1Md0RGchoRYDsH8ac2yGOPnmRkYkp3lkuyXsvI+GqmBFkzsSpQyCBMW2aRYCBQAGeSZq
         4Z5Q==
X-Forwarded-Encrypted: i=1; AKwUvByZ452SvTyvm6pWHK7n0rmKP1Xb/RwzDNyztk4mag8y/eFmxC+J4iN67RP9LcdM06lt8ricAp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsMD2ED0p3H33cV2w1F3SQX5Ykp/7y14Y0vUd2CdYiqot/YdkL
	UqdTMOmsQBg4DhSkeENm1Je0hUSsbJy1DASRRw7CeXz9fi93NM3w6Q9APSjnJjRVrOW3RHQl1FK
	p/mUHQ595CiYHGcRg4na1cGgox23ScRtBCao7LjSkXw==
X-Gm-Gg: AYBFou2EvnA4cXVUT+zK5j1e1yKNWzrZpk708qwoYxVv8FobgFTtg0ownamPGEEVrGm
	pcgD/MthZjEPU81Ywl0buwt+7iLLa2mNlbgcLv56/to33JNOv9PMXIXxLpn0RpFEmlO4UdUbcPx
	xivhgdjuzHqnes6MwponOX11PFapzDP36eYIEJnQ1p2hCoVVzli6JNOaTUeXa+NuW8V7+uc0UzM
	eGl1koGN0csoraearqXqB20IEPrNiATYsTC5LaytiC7SXxVJslY4uIRC6PFdnBFkBSyLwmpwNTA
	TevAgE60ecq+bQIJ/AhiUUFnjIKy814hPkI5SLihodqvd0A7/G2svO6gMExk4cP/0lrmtCpOFAL
	NFbecS8OaZaY+SOP4WPRg/+15a49UPorvTxRX
X-Received: by 2002:a05:693c:65d1:b0:366:bcf9:1807 with SMTP id
 5a478bee46e88-36a424410f9mr764924eec.36.1793308921974; Thu, 29 Oct 2026
 14:22:01 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211101.2089535-1-jkain@nuro.ai> <179330839362.3327.16138152744448390378@kernel.org>
In-Reply-To: <179330839362.3327.16138152744448390378@kernel.org>
From: Joseph Kain <jkain@nuro.ai>
Date: Thu, 29 Oct 2026 14:21:49 -0700
X-Gm-Features: AclHuK9aYM6-5o4K0Rc9q8lcWnkux26Xrz1XQhSv4oBKVRCqRI0MctPRzTanSlY
Message-ID: <CA+Y90PhTQ8E9eXrXCNX79sGOu+wczDWA8T1xAmkG7bRMQahjqw@mail.gmail.com>
Subject: Re: [PATCH net v7] net: stop defer_count outliving the deferred-free list
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:13=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


Thanks, both are fair, and I should have carried this over from v6.

Found by manual code inspection, LLM-assisted, while backporting
844c9db7f7f5 ("net: use llist for sd->defer_list") to a 6.1 vendor
kernel.

Not triggered in production. The absorbing state is reachable with no
race at all, and was reproduced deterministically in a VM: set
net.core.skb_defer_max=3D1, drive cross-CPU receive traffic until
defer_count climbs past the old limit, then restore it.

There is no crash or splat =E2=80=94 the failure is silent. On an unpatched
7.3-rc6 kernel defer_count reached 2036497 at the lowered limit and
3995713 after restoring 128, still climbing, and zero skbs were queued
over the following 794847 skb_attempt_defer_free() calls: deferred
freeing was off for that (cpu, node) and cross-CPU frees fell back to
the page allocator. With this patch the counter peaks at 1, returns to
0, and 4282 purges were requested over 797687 calls.

If another revision is needed for other reasons I will fold this into
the commit message.
