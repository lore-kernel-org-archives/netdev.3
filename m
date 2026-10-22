Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792644292;
	b=x8KnFTCo4dIbmeBmji8zCPXpERhfO+zjVryWnlycCy8OMP9+xCGbRKf5pyOxWooRHtdE
	 ezvulfAQ6BazRihC+AScsKOSiVOexVnFbdN8cTmlD/yyk0lPXKAvfI5WxhvJ9ZVRdiBir
	 OoC6a+WvjUm2t8RtccdbWWn37oa3/ULSgUqSNRJY+ccdHklzWqQg+FB4Uv601iRIDVKXP
	 Vmu8vSNNlUT8hLjjyuEa4OPbrJXPbf3LSR9HymfiJcL9Cxi2LTouvqx6pJR8lXVymIk6y
	 OoxuDwV+6dXuK3vqEjsn2rFlxuPfWFah02BlAKwQ06lbima3ooQ9PFoq33pAGdWoPag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=6Vdvfj7PjOF9e/IKwErjwvTRF7EhsdglZ5lUmlromm8=;
	b=vP752WGI9H2gJRdAXCrxqoYAFMwP+7YNAf0bDCltRK5f+f8TRSgdKbdM+qt+V6yllxBa
	 Pf0Fly5CsTNK5j9hjP+HkpTGAjExI9EUbaeGhMRdtWb4UQMAxfX2Zzf/cejxPvER2FlXQ
	 SSU5GKfS+FsqrCgxfRmR7YxWzWzbpdaSd/AhVpL+yVTFtBeD75QNqbH89Y9loX9Ps5laj
	 7MkOGc5K89X6YGWwghB/u6D7AnLn3uok35AVFUvcaMHqx2ltTEwtNjAD/I/uPlfBASJ0C
	 AK+PqNQnwkaVVj57++gYokaivnrJGXSHbsoNdtPPuUrRhH9oGF+6Id2gissz+uLIZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lxk/TRbB";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A69606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15A69606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lxk/TRbB
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1203747a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792644291; x=1793249091; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Vdvfj7PjOF9e/IKwErjwvTRF7EhsdglZ5lUmlromm8=;
        b=lxk/TRbB8HXbMJDtJMrqsqaioeYtbPhmHv70lTkK1gNv8f8m8SpNA1JNraBQUg1j+F
         Zdx9c53e54SdwJhyH3aaMN5poaft1W7YG0XmU1ZftkkgcT3FjveRqItmCb6qdnjGnR31
         Zwi4OggNKF7V44+IseoR6JaxAxRCEwtrPRTGv4pB/6olOaAJKUSOVUmLp5XnLOttAA2A
         fukjaUTlqvG9rg/OGX9uGoBCTVOsMom+BQYQhE9CpUbHvP7MTdyihPF8r+Ibma5OMN6n
         TcLUSk1YsmqwC6WXxWCQNi/6fNPUi+RLO1ExBpo3yZ/TERhWpvfAn/a0nnDERQNGLY27
         TW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792644291; x=1793249091;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Vdvfj7PjOF9e/IKwErjwvTRF7EhsdglZ5lUmlromm8=;
        b=yuG0XOHCpauYDdonfh2Dbyk+l0A2KGG8x3WJIxGWNsvF7nM9Q+8KvebDDzwdBxpBkV
         Hv0U5qv2yGzBf7C1lYypdTanDjQOM0ecPzUsXHuhlrYighHCzDE4i8FsRV4gRbNdayei
         OL4aS+uZofikCGzdECisY72NjAFCUc8LByFj6WuZ5dHDRYLU8pfeM2KVDgBxmZLHioAi
         aqugZjrzjqvKEWQzB5ZAq4l04mNeRBmGKKaMcEkIx+sg3uD4HOhjuYQgWFYdyodZpTGD
         NYe7Zq0OOoZrqmjiQLkz/QdzrXmdx+vmx+ft8CODlPvmRpeURpykF+vCYaoF6Cu7prUt
         6CAA==
X-Forwarded-Encrypted: i=1; AKwUvBw4VeX2rjFEFADT+8xPWLkUMWT8fJk8HyPfCfY2B8jTIjQpOnKL9eBapV09CPtQUusWMcE8mMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIQoHasuQQXmq6z8kHDqF7DMZXz84+qsJBuqD59E9rGZ2W7E/q
	zrXm0AsaKfAhjdawjjLvJf7uNWbhlfA97TzuiSDUxvnAknZxytIVlwNnVKmCgg==
X-Gm-Gg: AYBFou0JKASQGX5AfvFl4Evn0FCnBgi4WeZFk/CVjCxRhrVRwS/uKEleTAHEOwyqDuI
	Q5X2fxsmnh7z+rimbh1i1dQzYI3/Z9oN9OrRQQioalRXPK3GbC82KP4U1wBmmzrQRvT1QCrC0MB
	bhiZfc6TTdvRDTASATkY6PkofFB3lB86GV4dDvrO3ttNXRZczTLdZjxcR9ivYebj3/z0NKnkwsF
	tlyg0xnRYFjgblnAnhXwXoYFUnDe8d9VmCTGt811ixFwo2Un2L4uvTy3lWycJ1htR8TzmnknskM
	9u1z4PfoSR1BioQ75hChK7UCiSda8kdV23Wj+JgjB7oD0vJvAICAT3d5ozNlbO96MNmUwXaGTVm
	uLDmKTx2Z7YrV6gI0BPF++IwIY29TuB8XbrXj4u/9umjaqFa1BK0/zAxf5hjEaJkGY+ZbZPNs0E
	0p+nuDC5QCSqF+jJ9tQ8xLDfD1gSJ+VhjPwkVjuSRzTw9qraHB+dIS+8AQTRiUSG9AnNK5j8gg6
	3LYvLDNn9TMcPHMcPvNUramJ+DdOzn1wufBmvPmHKHY5b3qP6Ra9Hhjlt3q0QK2tV3xYJMxLoh2
	fMJAoOVDdEFusESzA3+iP4hxxvNDDEHhZwcb0COqKHppOy66FZEe0Xuw+gDD7+D2N692FBGHLAt
	TuWRdm2UNZ06dOcrKS+ZI
X-Received: by 2002:a17:90b:5810:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3ad87087a43mr3144148a91.58.1792644291402;
        Wed, 21 Oct 2026 21:44:51 -0700 (PDT)
Received: from smtpclient.apple (ec2-43-199-181-133.ap-east-1.compute.amazonaws.com. [43.199.181.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada495315dsm2456582a91.15.2026.10.21.21.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2026 21:44:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] net/sched: etf: initialise the sock_exterr_skb before
 filling it
From: phx <phx0fer@gmail.com>
In-Reply-To: <179259828981.3290.1199435370807230530@kernel.org>
Date: Thu, 22 Oct 2026 12:44:33 +0800
Cc: vinicius.gomes@intel.com,
 jhs@mojatatu.com,
 jiri@resnulli.us,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3438CCAB-636C-4B21-8EC9-DC10CC55414B@gmail.com>
References: <20261021155401.65997-1-phx0fer@gmail.com>
 <179259828981.3290.1199435370807230530@kernel.org>
To: netdev-bot+sinfo@kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi, The issue was found by LLM-assisted review of this code path (static =
analysis), not from a production hit or a syzbot report. I then wrote a =
reproducer and ran it on an arm64 QEMU guest under KASAN; it fired at =
the claimed sink (ip_recv_error). The "Assisted-by: LLM" trailer =
reflects that assistance. Thanks.

> 2026=E5=B9=B410=E6=9C=8821=E6=97=A5 =
=E4=B8=8B=E5=8D=8811:58=EF=BC=8Cnetdev-bot+sinfo@kernel.org =E5=86=99=E9=81=
=93=EF=BC=9A
>=20
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

