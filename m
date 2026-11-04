Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793807741;
	b=TQ4QDUQd5rSTUQiUMUi0aLQ6oBhDjYBNZBM/1xXum+BOWxszQqCuAVgmxQgDMGI5lvHK
	 Ktio13TxDCC9005+/FE3O1y1mAF/SvAmr3aoMkWUzyUr2tg3a/jQ+f9wPoeKj6kP/qBPY
	 EvqMF9oPn/YaLUcvIAu9UzZRWPnYqNhBOTmEHZbwFbrRbEOMC4ZDzoS2le50YHiTBQUeS
	 odx4R6sKRb0Zdd2jMk4qwa90l4fENL3TYgRGY7tckS41Gksm5eArJJAaOSTNlYk/w3rKW
	 Fpdm0FSsWWYF+40kwIwNyMvSh/G2IFc/qIM+abBpCyUY8qhCUHYa8oLz6ahCRSYWo4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uG3FhY5enp6KhprejgTETmEojafa/AG4GsoBAEaegu8=;
	b=ralNeJ5FSNkDCIi5OwCXyWAK9EbBoB8c1+bl/VawHKnmqHmXeoH7MwV1nA+eUbzkOgyO
	 FxHLc+8nA30773IGEt7eYn6Oq0OJPUMgV5MRdCv1V8VBgfh/BO6xfNUF90RusTLEr9jx0
	 Y6YYz+B9wAGj1e5al5TRltuHqHLcj3QPs3nRVRyK5VsGrESf6S7yoGazWF9oKZ28vRc9p
	 A+RP8/X3bGKv5MEJa7bfGNa15u4EacZkp/z6VDsbu4keviJF1gmHMJ/8XJ155x54m9NdX
	 gXNRhrqm9z4QnoYtFgpSFO4K1hvctrqaOop1MHvMo7/JpnXch9Eqm2MjhuF31WKuHQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qQwv1PI/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3A606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB3A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQwv1PI/
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67a6cc9acbeso660839d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793807740; cv=none;
        d=google.com; s=arc-20260327;
        b=Jj9E5tAJodbyTEFsmbCX+BP46p9Uaa6sHjWF4n9fbgWKpKzCCmA7tpjh4agCfmWsnS
         Taj5FJ+lNQMR9s/24vs238nY0czph+yqEFrgKKTkWELRB+EHj1gm56TpME02w+DNv2OX
         Tg9MiFFdrbzqoZIJlkIQRpUor3CApltjYQnNVHJulBn6BZhj+usTNAltvuRRUWcmatyx
         aNg1+3pvQVSt7oQFQUOLl8XRwfTn+DGSRtRRMO9frjKqnA+TbwzJRc4rVZgn8MlQSRBB
         m0DbNxTo+KTXQ7CgLs4HPvjQIQCVnWb7iGa/r9Lv1F2Ets5OxPmtuDFuSUTQSXeLzSly
         XImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=uG3FhY5enp6KhprejgTETmEojafa/AG4GsoBAEaegu8=;
        fh=HQJ/9C88Z8tTA2Y98rX85RQSB94oZe6tgb8RHKkaUSk=;
        b=jZI1gWaqAfalfioR9cy0nxd9wIBnVVTX/w0ifPoTangxLECHDxfej+vZq1Hi0QHp4I
         OfIyXerPwu0cqKi+J5vUSHsBUKDaTlxOZw6RfnI4uDGDeaQVaX6M9b8bDZylmN/cuqEu
         EtVt8MaeXL5fgy2iUNSqoqamMhqQ10HSY55T5pWJ0vRnyNiUH1hmxZ3ffRTRJhYwel6K
         BWz70lMTKtNFauK2AbhtrthKzUFxINsMNjcRfytKCXMImh4SAtU1Q7dZChv7ERe39BWH
         UFZPxIgFTAwSVjKRZ9cugsUmdnxWUTGiw3awy5508BD0DI2/y8p0Cl35z+GEyzuBiqkK
         aBVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793807740; x=1794412540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uG3FhY5enp6KhprejgTETmEojafa/AG4GsoBAEaegu8=;
        b=qQwv1PI/1SFi+6hzgIC0tjP6JkbFCVhPoM7AS8YvsTeGGWvyIspG8vDPm2TcEaJRbQ
         NqvlnDyKIaJc780ANEwbrVWytxMocmId/Yd7ffh5CCmW9mg1izYCezoWLCie6FyQ5Occ
         nWgEvA0OqRSZW6qEx326uo5QZ+HubyajA4EuY1IIdbgxR4t/oUdrDx9Q+TScm8y3+N0X
         f8RKq0wwjr7YJkaPkrOOgCypHNg1fRElxBXSfZh4PBLaV/I2NQOlfGef/lO0LcpkaAEJ
         eamnBV848uEAyx+Wp5bJzwmQSQZdfR/LvZZYk6qwBZajRTIHRhz1e6Xo2RV5gduVgCvR
         BvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793807740; x=1794412540;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uG3FhY5enp6KhprejgTETmEojafa/AG4GsoBAEaegu8=;
        b=TZ5/z1iBYrTCO/1BDZouUAURz26zeFCZ0v6a/TJGrFx6HK8bXBd9CcxhwlL0iZ8Bzr
         dRO3add13bLeMTET2/VvVC40c/jk4tsD7eEmIkeAS3ySfZ28ZtBSMdz95RSJVASOwMqV
         fhq4/11QxDA7kBVJL91MaGEMgtYXSv7GZygzKjdssfxuvQGe+UH/HGytpkNH7xJGXYzf
         lBOjuDjqekd445lU0bJ9Yt0YwmLDWfYw1zy6yJ1ZX0IxGZ3ks5BsS2+uJNzjX9olLWCe
         vAKn5z54AhbI6beDMxm8OnxMJY5KANH4Qa/Ljl0b4rlIY076X3e3yIxq8b/T6y01nMzy
         dnZg==
X-Forwarded-Encrypted: i=1; AKwUvBxYMUkZJKh2FT6vBIceEtX5QQmqrNFWUeUkC9VmUiNkcx96HPElGOTDbq8TGoFywpKPr1QFm/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TskfmZ5e4iAtk+TuCaI7yCIE5ROYd+9HyTKbSVWW3nCxDwjb4
	WeOWwiI7//KKpyMTU+aKvAvW0jj6FgMYfBeUY0CJyxouwWSFtyi8hVa6OxFpmmReYM/LG68B5+C
	DUpJlPde4/CmIooz+2tf+nqj0DmgzpW8=
X-Gm-Gg: AYBFou2MCJeQcjRLLJBdijy5K0IRROKMcxYlzOfW77pI2scluuKWKbxPAo4oWfqNr/o
	JBhBaFnk83zYTIK71pIJS6ybK0rDX8S4qY5UOWePPVP0D2+iXJK4L1khJlmL2ZykpD28MGnrly5
	jtlJrvDQ2yAfVkuMr5jGc03O3LCBbpr/YJVb0Kf+pEYiTvammnK2IK2z2a/qUrb8iZ6lqyY0AAx
	UieTpxmzhk+Us3kTsJn4JY6FxSCuBOI+U+QhCjk1vj2Wp25YRR6kZBOB3nZar/KML0dJErS7Q+R
	cvEtWS5hfthhtfhrzTBifka8LCj+f3WbxYyNpOS/MBQgSmLr20rHt/WrTk70fdWSb9iAzut6HsN
	4XNP82bBERKav8qVbntC6idaVlnjffNU5a4bh
X-Received: by 2002:a05:690e:4089:b0:67b:e9d5:89bd with SMTP id
 956f58d0204a3-67be9d58bddmr2433777d50.78.1793807735629; Wed, 04 Nov 2026
 07:55:35 -0800 (PST)
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 09:55:34 -0600
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 09:55:34 -0600
In-Reply-To: <179377433748.488859.18424652819498691331@kernel.org>
References: <20261104063245.23402-1-0xbeac@gmail.com> <179377433748.488859.18424652819498691331@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: BeaCox <0xbeac@gmail.com>
Date: Wed, 4 Nov 2026 09:55:34 -0600
X-Gm-Features: AclHuK-d5MDjuPFIkWxVxOzfz5M0wSMntlCEi4c7058mPNhkapkJn4VyKormY0Q
Message-ID: <CAF2udye3be+BUfJoMoVwM2GC+REtfKn36dxuyCs4NW5eBLAE7Q@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net: ethernet: disable async work before teardown
To: netdev-bot+sinfo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The issues were found by manual code inspection while auditing
Ethernet remove paths for async work that can outlive the netdev (the
same teardown pattern as a missing cancel/disable_work_sync before
free_netdev). They were not hit in production and are not from syzbot.

Testing is as described in the cover letter: KASAN on QEMU/KVM
(x86-64, 2 vCPUs). There is no physical atl1 / enc28j60 / xgmac
hardware in the test setup; platform/SPI teardown was exercised with
test devices, and the atl1 probe path was not exercised.

If a later revision is needed for other reasons I will fold this into
the commit messages.

Thanks,
BeaCox

On Wed, Nov 4, 2026 at 6:38 AM netdev-bot+sinfo@kernel.org wrote:

> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
