Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9E6457E53
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141230; cv=pass; b=Ev31y+Uy5hsnucxQkIQCQ38mirCYeIEU5aIGQCoFSypmV9uALLjV+r+KQCCy+1pPWlrIC4xa8CHS5geVXeXEiit25IK0WD00v/g1RouGZuAIQ2XW7ZUIPwOdHN/zEwLDaKWqlF4irLFSIhBTjq1YG93dppLx/eiL8696FVFaiJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141230; c=relaxed/simple;
	bh=OVzfRZdbw7s/lzMKC8M5X9MPCV4GrzsQdddsKbt+Ujo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxHS4FlUpR22+niVzUwXmgTkZ350LXjJNGwUf6n87IztddfyQ4P0E8gMV/Q5FVfRVgm/rMlW8dnYCYHKTjg/SIjss2U6FOKA1cvXHANSQAwuQ8GU9lE2AlV8Wcp5cj46O5yeRKpbTQorjl0CwPI10/SeFxzj1vAWeg/xddPCCe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=RhPXrHLB; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="RhPXrHLB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1339776a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141228; cv=none;
        d=google.com; s=arc-20260327;
        b=cKeZs5DBLPh5gIotWV1F6m6wHMUZ9G1EKTej63MSo2qB3nsGzwvanmbDdKyARBaEJa
         S+bn5IrQW+EL/9a12Xl3V2Pxpizos31eNJ/FO4aUl0AY3E/U151n2YzQzhfWSBo7Y09+
         D60Zfo1NHXptuMlfzYK2iZPi8kkrKeI8DnWORxRYpO97RB1RkvoQQbHqACe+sqvrKH6Y
         GsaOUPpcofy8YPw2u3qthAoDs0OnFVay9Xa16R2s0OLxT52WMGp51rnJwqdLt5zzv0dd
         gcHFMSoUuN/ZL3sh6ugE7wEszQUYx2VAImvVwL5M15jdZbFBwhfhktRzqUD78eElsuVP
         kbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        fh=b8MgnORbajBotlBoQ5JOR6JssnmBYsa0j4ibZvTV02Q=;
        b=UFnVrvlxJZcQmDnoDL88jp2Qh9wN1ZBHjpNfh7XlKtTTAXijsVuUNfajWchnJXlxy+
         zqHrV+D3MUryQFbpLvEd/FM+sce84FPEhcoUTsooOwEml1lx8UUkWFeg7njUxKXY/dIi
         sapl9uV/PUgU2iC36SI3T9jsc5ifG9te1QkVclf6+iKxtgyx/A1hHgfWxODMDeEWPXEN
         jjv8PVetxSHSfOQLdQqlv0eBPoCIwcsFuQS/l7+A5/OS53Y/p4D7HYGH96zFHs5/4cw7
         HTcCUPErjH1TsWy63SJLlXUw+iWXgAZDHnwdTzTZWodXw6xNmhL7qQMt+FhjgveZ8J04
         aalg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792141228; x=1792746028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=RhPXrHLBCiDBBEYrYBTNlfmD/QQlldceZlMSoGT3/57ifVzThp17AHeWKuBZNcvvFR
         ASYsFIMH1K+DkMf8RfRP+GPtUyx1Gzs04E69j2T1oXUgnexFwEXwIe0FaSyXHH1A/pNU
         udfXZqlt/dwy3t80CKsQ0YaGKES+JMKUEl7aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141228; x=1792746028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=OhBIGAVsrSADA7Exbp9Pz8zg38NrD1ewneY2rEYbF/uEbnZzPsTvWPpxo+grLP4MSg
         fuA6jFbXtyPr6R1cpAxUBr7RjGwAmFeb4GvGZUK8A3sRBkwUJ+MgC+4+tti/AaMD2MYs
         j+3MP8aS46CqerwMGSCrSQQwD20U5KdUBRe94kEiPNG2IW9DEau9ksl6rKAwRpTuywN9
         1yi+ZljhzEE3BnJI8cdv0ej7I7pWCcxepoggYzgq9FtmnLg6D3BtJFBAwwB/8MonvAaC
         fKgtpeSw6tHCenbfeD+sKaevaFvMQbZ+imG64k/yi5OqaGMUIHVg1qh2CML/Vw8ViLBZ
         v8/g==
X-Gm-Message-State: AFq9FYLkCb1IXrSV9EmUKrB/xoAbnZENU+OJjE+OOM46QV8UmplKwOQS
	nc+I3xRn9VLdypse9BIjur6zJlplUDKJSnHKK+5BZHxmuqYCUfiA6pv6tauMWQEfTSytht9vxgE
	ZR+Y6vwmN6QJVxwnCrDhKaGhKJAdupDTSZBXim+rf
X-Gm-Gg: AYBFou16VFybKA2e2jJY4uo2D05h5ythzQ5KjjxM7tEjU6OZcSoYXYepbcysDz6QU1n
	lGVRwr+0OQ041a2iqgXvoKieGBpdiSyGy+IRYp+D6kh7ZKxmRALL52012XYm1UHGaR7ZtweFcwR
	BB5s9wdW2KD0hSBlDhXuLdjTJcN230ac1RaUe7aexm+wkxOeZscCxL/1km/FhDiaztc6vlkVIo3
	hG4SnCVaXOHkUEwrCXEyiBHp39w+Rm/xZBNfB+XdaacL+nyFSr1EdqBHeTpCRt8zYxzP+7nkYL/
	BmLq3rl+5YJ8vJdVdhOmG0Na+/ori7Z+je5dWAEVcTjeogUlvzfCJ8ajenI+u8plBsRVTdcOR/C
	SFSE+k667yB5fkbIf29uSk3dfXI3qLzLpgbYNsMzC2G36
X-Received: by 2002:a17:90b:4ac9:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3acc005d046mr2346529a91.42.1792141227770; Fri, 16 Oct 2026
 02:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com> <179214079109.408196.5152796723435821487@kernel.org>
In-Reply-To: <179214079109.408196.5152796723435821487@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Oct 2026 05:00:16 -0400
X-Gm-Features: AclHuK9CcjmyT6uSXvsASMcDVgH1hUyqtUYOnWylPW-Z9sshIHj2VYWrJCmAPrw
Message-ID: <CAM0EoMnb78SoNwrqgH5308B_+Mh1sBtm+wJ=SFXtMHS-L2zfXg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Patrick McHardy <kaber@trash.net>, owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org, sashiko-bot@kernel.org, 
	zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:53=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>

Patch 1 is a followup that addresses an issue discovered by sashiko
and proven by our system.
Patch 2 was sent to the security list - likely from a drive-by AI
submission (i.e found and produced by an LLM). I am not getting
responses from the OP but have veried the legitimacy of the bug and we
have reproduced the issue; and it looks serious enough to push
upstream.

cheers,
jamal

> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
