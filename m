Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521049;
	b=XTjejob3n+m/MC1BuhzpevvTo5YyS/d8eHgE7I/STl++nHLomKxmkmM/EstGjMhd41al
	 uB0VEPgs5CUHJmiXQuPsZIa/kSB0HnalGjtc4y8S+DokV+Vpyn+2L7xwIJFzQJTz/z6np
	 UQk+REsEQtmplUV9N+b2NtO/frlwEiVDYYDJELLxsJVX8ePvv5BIRNoQtn6ijEjJkBBO8
	 f0VucP/yrvSMEcfL84jj6LeCNL7xDFdXC7aptGuvTJ/1wQHckGxS3hQqY7NbMOeWerhp4
	 CEXtJ5l/2gg+9BbYg0TjYZK4A2I/HhHY1jJ8RBelc9MrvX+mAI+keeoqWRmgKwXseSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l+hkzwCpvpQgrUCpeG4tt9OeGdPww69ynoVOKpj/83A=;
	b=j88zjnpue0CmK6OYHyAzKbOCs4GVteGwuviHgpEk3XK129SKQ00HZVv2N/jf8pBlv/SY
	 MMsdX1KbPrNyOQigdPn4Qh6HIOFbtOCoPqsZ3QahPB+pt6R7tpH/XIXmVrJ1Qm5IxTJ+k
	 3gjAfZaSYzGmsPS2A5ZR4rHxpd43PiSY3BZXpmcRC92nwejNaAiih0KkBR6lPkE1TivKs
	 bC/thE7keeO4JDPkNn6b0uK1xnYx+a4QZ1L8MnPcER0x5o5ul3OsZMHzyYuWDkIkS0Ln2
	 duBOy9/B99Mpm3BHS4yla8al0YbC+kp6iAUl/9PSNtA506ODA5VCHJPT8kN8MyqVP8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1O5o+j+;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10196606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 08:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10196606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1O5o+j+
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso696211b3a.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521048; x=1794125848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+hkzwCpvpQgrUCpeG4tt9OeGdPww69ynoVOKpj/83A=;
        b=r1O5o+j+DhaI1igvj1ETrTNrpYZ4cW7jYwzRRdbtVjVWvaxG4RWlyY/0yxooMG6oTM
         GhBDtLjgO14j1yftZzCs7YZ+HAlbiKgM3P3rqT9J376HwsADT6SCjVzOQXqFRRk4s8mm
         uj0Pj2m+g2/VdMprvzlKdSo+V8fGXPY8aVXSyghBHBje+0X3+oMZfquTdCMesEK5H98l
         SRiiWtYUoHKSZKwQCgc3M0WxmwYWnj38TiBcxOPN7v6XyVXIEiXci/Esr31TMYUnVBYx
         AoFyn9XAZt+5Al8DUvymg5xtNNNtZf2WWAjGPCTqMYmNoLPFzGxvf7bjLnv2gw0frPaH
         8M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521048; x=1794125848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+hkzwCpvpQgrUCpeG4tt9OeGdPww69ynoVOKpj/83A=;
        b=wysxSZEM++RvmBqVvohRxnntMxC1AJYPQxxFGXXwPrUCE2u5Gnf5L2fkOKRxFnWEuN
         DlditWzJzb0urJYE1Iid1m4ZjuFwMRFTE7hLpxmOEf/51lpdSAubxXu4qtO410hP8Cwb
         2wESWEl6tP8bs9gJNp7Qf4gQMavf2MxuEhVUUMZxUU7AJ5mUqm6FfYAWWxZjWJsv6P41
         3eerEe606U/WaAReu1vGgMGf/Q0a/Lf98xPDaVFR1a6O+4qkidYSZgIK95d0y5KCNhpJ
         hL2nMOLTRm7OzDldFn2r05jWkYEpdbpmxP0wWX0tO5s6P7kqG6Zd5iZnCWUz+Hi59wb9
         s3xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCXd3Lzos8nJGGYVkryNmKrNiw0YOEFPEtRnGo7JHUysjTYPXu/peePORsZogVnXLJrql0JEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIL13j6CZZpYG4J3jRgInC8Mr5WXCpcnz+r+0QV7r9IPmSKGaAn
	sqFVJuHnaiVQ4sUTxEY+JGuav2QwjEp3hNbEtnWoWpi3BYTE8dNahbuN
X-Gm-Gg: AYBFou0XP1QZgYjmtNXUtGFF9WuvHHpecoFZA7x9zlUBCCPNB9d5dEPnO+VykhZ1CZX
	G//9i91j6upehGfPZMOEQNZTcFeYDG0DN+8vxzGtl98lcLlAQE9mskbztsuhtfowjQVHN9nmi+E
	hwRv6kQMP+JklbbBo6A0g5lzM33nc0bHmQvWIbvgicogYgdvUMLnRzGXs6EhCQpUpAKZgrkdIQu
	L/rfTKgUYQKWYWLzyWPEXsDYpANBsU4dsqYA/okxIrPKKzfkYnhaQmRrzeKSO3/+KNfcOwzNpZ8
	wiYMUXVq9/rQMsPaO1I6EQI0ywJfS+5nHcse/DKXoFw+W1pfymbHFIT5WybtPmz098AfG7F5S0B
	NgwYGNYSuhuS+7GTp3W7vVOCOQsBVTqqlcPinP0JlJtZPMrHL7xJGCg4J5JMa2y2Pl7HB+LIW7a
	edIxRyFAyCxk+hUg+dpLTWz8Qg7jD0yq3cjtt51m4+hY5TiXwavGLRicK7pNSUlUqc9+plin+/K
	NtOYYLtX61yS1v4svAtwL9s8jzI/smSMlww+Rfjn7vWk98NK1u7VKlAb+negZ5blotFGJrJbCAH
	TopXgo59PTs0ovyjtMLMJVABoeQR89gLVEarYQDKDLCHHA/+JlCiigXm/eTARpH8NqfMCsCbjoy
	G2QqAVZ3FWVWaRJEAogExhJ4=
X-Received: by 2002:a05:6a00:2e21:b0:8a0:20e0:b131 with SMTP id d2e1a72fcca58-8a9be490997mr5082579b3a.19.1793521048212;
        Sun, 01 Nov 2026 01:17:28 -0700 (PDT)
Received: from LDYT9Q2G2M ([2a09:bac5:cad2:3228::4ff:28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d067cesm1104467b3a.29.2026.11.01.01.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 01:17:26 -0700 (PDT)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Finke Lennart <lfinke@student.ethz.ch>,
	netfilter-devel@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] lib/ts_fsm: preserve token types when exporting patterns
Date: Sun,  1 Nov 2026 16:17:19 +0800
Message-ID: <20261101081719.51784-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031202211.22f18bca7819dbe2d107d17d@linux-foundation.org>
References: <20261031202211.22f18bca7819dbe2d107d17d@linux-foundation.org>
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

Hi Andrew,

> The main user of textsearch appears to be netfilter, so please let's
> keep the relevant developers in the loop.

Thanks for bringing them in. The affected userspace export path I verified
is tc's text ematch in net/sched/em_text.c. I have also copied the tc
maintainers and netdev. xt_string retains its original pattern, so I am
not claiming an iptables-save/restore regression.

> Zhiqi, a thing which is missing from the changelog, and it's really
> important, is a description of the userspace-visible runtime effects of
> the bug.

Agreed; the changelog should have explained the tc consequence directly.
I have added it for v2. There is a runtime effect: restoring an FSM text
ematch from its rtnetlink dump can change which packets match, or return
EINVAL when an exported character-class mask is not a valid token type.

The additional automated test uses a tc basic filter on loopback in an
isolated ARM64 QEMU guest, a DIGIT/MULTI token, and four-byte UDP payloads.
The original rule matches "7777" and rejects "AAAA". Before the fix, a rule
recreated from its dump matches both; after the fix it still rejects
"AAAA". This is measured with the classifier's evaluated/matched counters.
A PRINT/MULTI rule also fails restoration with EINVAL before the fix and
restores successfully afterwards.

> once the issue is out there, LLM-using bad actors might be able to find
> ways of exploiting the bug, so please discuss that aspect also.

The trigger is reuse of an affected exported pattern when configuring a
rule; dumping alone does not change the running rule. Creating/restoring
the rule requires CAP_NET_ADMIN in the relevant network namespace. Where
matching selects a filtering action, changed matches can make the restored
policy differ from the administrator's intent. The tests establish the
matching error, not a privilege escalation or memory-corruption exploit.
I have not established a production deployment or a wider exploit path.
The test source and detailed logs are available if useful.

> : Related finding: BM/KMP also export transformed patterns. With
> : TS_IGNORECASE, repeated folding of 0xff changes it again

Thanks for the pointer. I have kept that separate from this FSM series;
I have not independently validated that additional finding.

> : One small test improvement: after copying the exported pattern, add
> : KUNIT_EXPECT_MEMEQ(test, exported, pattern, len).

Added. The updated suite fails 13/15 tests before the fix and passes 15/15
after it on ARM64 GCC, with 15/15 also passing on ARM32 GCC and ARM64 Clang.

> And I'm thinking that a cc:stable is justified here.

Added to the fix. I split the fix and KUnit coverage into two patches so
the small production change can be backported independently. The matcher
change itself is unchanged from v1. I am sending v2 as a separate series
with the v1 and review links.

The additional v2 tests and revised text were prepared with OpenAI Codex;
the recorded automated runs were driven by Codex.

Thanks,
Zhiqi
