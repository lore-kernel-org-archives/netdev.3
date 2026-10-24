Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792852814;
	b=38BEhIqvuQwtfwhRVWNOb1wKnIxB4zFxqUqbZsYbydRktUPMWeQ9XSEC/YpdX3CJdrds
	 YRCEgWgwmv7g7fGufGo8VVxXF/Lf3KwcxpVYUTMxH+ykBuxzEHdOpBhPrMC+nky/PNSsD
	 t83deZKz98TYecLsI0GCoJ+dPMVozIQuBE42U1WSAPieSb0XYXQvwyNSp4RaNUfppChcV
	 nm0v+QgexUSLNdbH63eT5OxRWxHvfO3HGsf3tfYSitxPFhmnfDLOjbhxXZrWGf/vGq069
	 EQEqusrWiHNNnCk2hFOqg4skEYhXYzICfzBVDjJNkKfSod7Ihv5w/ygXU4GTSRq9bzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
	b=RbX8MKPVVgZVjoIElk7y+HWJYOXohXy+edzKENMFFGsA7tPT9QCXeNOqddxspwHAhrv5
	 6h67iKpGeRHXvf8IF37dCg1Yy7eScHYf3xgnYGnyA8hEtlNtey3UoqO/vnqyAwy6g8k4u
	 Il/urR6fPWEQFWWQEuk65k2j+i+SBEfSqeB1Yyn4lur1DsSnEKaq7KyyZAtY/NKjXKPoV
	 akp/QaqxuiA1dvgd2VnZ1439wzm38tm0pjE1yo+1xRqzLTsCeYgrcszyr3dkYRwPKOiOn
	 RnAlOJRi7PF7Gi/LN2OPdwLFYYOLVoGPlGhLhK6v8UOxUnecOD9Y/1gS61o2l/as36g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xgzv37X3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B94606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B94606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xgzv37X3
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f85edd210so555190b3a.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792852813; cv=none;
        d=google.com; s=arc-20260327;
        b=W2PSaeK6Sv2WUMG6XNEh7StE7vdX1wi5CWzgJsx56A/EMrA+OYy43SVhfQNr8/5NAw
         UYfMuUsUrDz/nLwOjgo9ucCBjK++hToU8cxTsDWFr831t60vvapPCHhAo2Woy9gHRBWE
         tpSXiMLjWRcOCINL8u7fEJRXLfA3EfJV4+YQ4o1Pby0tJcDW2hodlNilV4BApMlQpf73
         1B+aMOH6dykIwVDd+lyxD5Be5ye8GmriZJZwTjmCRp80AtSfyCbNAe0gZuXj6azglK5J
         Tu1MuxnYs5poIIAzjCwrp4Qmab+YIVGGnQyp0O9prgOslxGbMFvBz0HvImbr4/dN/LL9
         ku/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        fh=/v+4B7yZfHyrs8s0lWS8QvgN56EpqqZUizyydsWRFJQ=;
        b=mw8m9efjMlZ/Fw7RuWIh1r+GIOjqe+AU99yYMWuJMVMURdYznffJGrQltcdClYEpD2
         7Ce5qRWApziz0LMN4j6wwOoeGKfK/KRlt1eKHBzOgM8WcAEAjuCBT1i0RgZ3yQjQkp+C
         F+FoNRJKlmOr0eTHXL80TkZhVcn1x8GdQGNl29kO4Iagw3wJ8k+qO1xMxxHwINS6ed4m
         K0hhqT7cc6TApqDKlvf2U6qXRGKNAPq+KTzEiA/o/1qhvr/aJvXkTyUBT+BQyO549CIq
         1SrEvyQFIfDAbIA2aTURIlM83NqGze0n2/NYh8c1bV2zVBIkIs4437IipVum+EZnPQJ+
         j/Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852813; x=1793457613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=xgzv37X3FqHjQKvsUmsU5QH8GxUc7mlpOw67gMqK3Zgtz11opM71SA8FV6cjvpaFBj
         ZzOgH01PY0IJmCwp0gD2Fn1KTExPslSXQAoqgnbwaLuzIAakYfyEYqUyTnvOZ5zNR1Qr
         K+XDi/np9LeBWOScutPJ9YrRXZMWzqGO23XH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852813; x=1793457613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=521MBfk16OaOkHeWnu+57WsvL6IjDdbIpPxbjAQEqUA=;
        b=NjWM6R9XjhYXcX7TwKRD9jSK7G758l0kvhoH4ROcuWjy1DdJ9qsX4o2U2DxjNSaX8B
         AvPx7L0Qng+pU7RbjXXD98QiOpuJekUHkilxQUzQq3xAdg5Md01nMGY7XLggmeLuEsVL
         Bnrh9ENCKUWX88RnutKBJNCMM8q8HOo9buikL5qKwPyoSOtYO11pXGUzVnLuTHNuzC6X
         ETxicC/lkjt+5RrWJ+IFRsglfoyzzzgAmdQnspVkaLaQSz+w2QHIQTCwouvLacu6Gj6h
         3eyp3dPghyjZjjj0kdtUAwu0kFCV+ynljFC1tUDGansZ1s49H+hbKnmIufhfJD5ngI+w
         hmjg==
X-Gm-Message-State: AFq9FYK6B/cTz7pbr+XFQIVfbk6LZFlwJVKA3H/PY661iuq62PSuBL4p
	WENBgjGc/TfZXA16Fie5R85JkkO+s/uetk+JQEdFs782WFMfV0xc+UmBuva8VihXjTl0Xl1yEhv
	2V5tbVWbFvbNtHFAcF7XUXFryUz7PG9p5porKA9HO
X-Gm-Gg: AYBFou053j99RaTTzlFLyPUJoMnJ5Y2r1AAOyHAaX0Q9hmkitYZnDdjpbrpv8mIz268
	sxX5cexAjT2z91E2PtVkqqpeFKdEMPC04U7RmXlAvFO1xT3I8UA6I0sCm53iaU0Pe4GydnaHxO4
	sIaOVZAE5p7JjqD9hwTo4ai+DSqv0o1EgQP8a/4lcq8cGxisxIbPiY1PMbt/SjvcGn4OcPp5Slw
	//C6VWkXvLB5hrGi1PyjmE1R9RIcf95u22iB78INcjz/4w4+L2+/adFeXFX3g6vPNoxL0GbASTv
	zV8BNtdpZbIMVjGiRg+adVUuyqGlzadhEt1RrGZWJ70SfMliUXjY+i6yVkDvWGpf8Bg7qd3IGb6
	tV7VIIkgWnqQubWnAmwNaY+asOfUpZjECER5EAbcZKLvZWzW4hQvfh7N8WcOux+LLIHeCWTjcwR
	9kM8zaIq2J0G2ifcU=
X-Received: by 2002:a05:6a00:3d0c:b0:89e:5133:d98b with SMTP id
 d2e1a72fcca58-8a36689cbb8mr1693557b3a.24.1792852813080; Sat, 24 Oct 2026
 07:40:13 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com> <179285257342.3327.7748817772985184863@kernel.org>
In-Reply-To: <179285257342.3327.7748817772985184863@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 24 Oct 2026 10:40:02 -0400
X-Gm-Features: AclHuK_IPQcN5_Ds5eUFIjDiEWNIuOK2ju1JXDTN4ajqveh7Xxel1G0VGM3dksM
Message-ID: <CAM0EoM=yCSeB9+Q8gFsB8sjQhddM9qWh8DOfSqqNtp6byubv2w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
	sashiko-bot@kernel.org, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch 1 is a followup of a report by sashiko and  two was an
independent bug reported by Owen that our reproduction system verified
- i believe they found it by using an LLM to look for similar patterns
of some previously fixed bug.

cheers,
jamal

On Sat, Oct 24, 2026 at 10:36=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
