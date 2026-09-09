Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BF339395
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972428; cv=pass; b=rtEssPWiFEN2Asyu9RPij57LyFScnKnJ7+APcRzJ9tYnGMEsUMtHRt+deerXUPmfVnK+8LsXCP87z5mZA+Yy6e481qJAhVlK7ofTvE/pySXRXFgZHySi8D2lVwH8IGdglDZaHYmGkZf6hk+ZMB9P9svMEIGd/JYJc4NhjKcVa2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972428; c=relaxed/simple;
	bh=/e+BSNmPjk9NKfQGG7nIfLhJ8jYKrYUiYyiNqBMdcXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt8XwhisWUYYhPSRzz3QQvRl8Jle+RXMJJX8vNnbaZrA7sJowZCFesXFQOyPiHFUSeZvtXyXzGxJ6PtHwgIC9IdHJQK91VAfUuxGyXJvDnvFjo9NBM2qeu5sL/DaHd81SATLAr3dCEnpAx9cgqiVr+D3ccvZAzSTf7LLsAsloaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUcO40Cq; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUcO40Cq"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso68255a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788972426; cv=none;
        d=google.com; s=arc-20260327;
        b=ibXHrbn00XqL0cMYEgTwnBVaRNCE/a/ExbIE93thc0hSO4Ffez2CAs7ye68q9exqrP
         3nzo6j3PHTTVl/wLxuZSXvpEGuYXuF854/liW+iGPE3+FZok7zDB2HUkFcYqqdaljUvb
         FZY0I5ceclFjmFTj+3yai/ghlAMTb0epfuAj4ekeRN6oQ9OwxbkWVM/P44j4zXijgRiy
         OSeZ0NpG6UbKe/PnYxN33CD9oXBeNbCPFIl9VEm5inQA4U/NQghHdqjCXaPiM230a3u0
         V+nk4uuEC3vxK7HSo6P3vx7HXC4if/2O/x/8Sx4VSRDaO88QDLA6FBlr/FRO3SRqVReG
         nAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/e+BSNmPjk9NKfQGG7nIfLhJ8jYKrYUiYyiNqBMdcXI=;
        fh=KKLm5v898ln4N/Xt6SnLneYiaU/rl3U1/R3Xri0bJiU=;
        b=fsPP2PG5mKPR1PAVnRKMRm6BExxvC4vM4EFxVtTb5tEmOAisv9Ri4QCfpyLVE+uI2w
         D7Ee42nEWGkZwwdRvCbDYRbsa8GAWchvVjI1E2Tqg1c/WbxbA0St7O0OxRyVL0oEIULq
         scMjC7BU5NK+b+O81Y8WhP2LPEGGmlrKC2npVM9q2e8cOepNOmBd5VifgHfK+yVg/RZ1
         rnOQMQDf4dff39tV8B4izd08QlUzmrcyG8YRj1rD8ocuMK9Is4XAmxk3cMMUVBnWJrY6
         XMz63W6KGuzxiEy8jC9fopG3YRfv931cJwLVJTZFGNfkmm/0Na9Akt4ocLXC3g6OhCFN
         Av+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788972426; x=1789577226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/e+BSNmPjk9NKfQGG7nIfLhJ8jYKrYUiYyiNqBMdcXI=;
        b=YUcO40Cq31Psm+Zmam8K5YksYcPPxntug+M/D3Tq/VwQF1DIH2zJZJSHQ1d57ALN1h
         yi79KldDWNA++V8/0DsXAHo4WwP8jO0dUx3uKP7od7E0z+cRazgaRLCcmC2Rgb41aZQ6
         NlmDRudJcWRUdkvBG8VjWrayQVGP5pJUtGvTvJpyO/1IpWT+XHNevRBd+CHlEvFuLq2w
         jZbP0cRPnt/SjtZfM/0nIlo57HT/13CAxQSGRdsbwIO2WVaOyG7O+xuUe7O3uN9DTJaX
         pHyMC1fAdy9knAPWWOeHUvtpEpyi7U+KGzeSTV1x4XkUHXZn9w2kIFXUhksxfnpJeY+1
         W7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788972426; x=1789577226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/e+BSNmPjk9NKfQGG7nIfLhJ8jYKrYUiYyiNqBMdcXI=;
        b=HwIdTh8Mbctoy2kTsd91vZ2Sk6U2x5KJGCB+jPZhOHVh9prJTfMFu1D2Ru5YqoKLRT
         vaMAkNdmxLfJuPvgJIY+4lJgHUTUX1HCFNJRfWCVLiiuRud0V2QV7oKUrqUN+6whyb56
         AgIb/BSmGR+Q1ycM0ISBXbpsd+Wds5qChHK4DC34YNgQNml9oC/bu09ukiT1V1Hy1gwZ
         5qirJy7iVGWAL/9SNfnQbe/FxzqD1LSDH5u8TIN3zNpNnvAje2Es6hz5+A7Bjs/hs4pQ
         CnTcHA2PyrOquOWbbbCNbEhjOq49/9I/6Bz+B0Pm1QJFWfvF2dE6wE5TmBHfLHwjugx9
         PVIg==
X-Forwarded-Encrypted: i=1; AKwUvBwf+1DA67k8Vr8HYlsfu/bRHAsUe5eqPqmKlJ7GT8gbWtNQSN3AYNJIjfUqA+a6Qb4BSExF8ws=@vger.kernel.org
X-Gm-Message-State: AFuF++lzY69WRfWyT0VOgP2QzKnLK6QV/5nHRNI46x6zKqawR31Mo1oI
	TUh193LIMq10+vSgiPZ14UDdDF2P5gWJj1K8DiYzf18nk8FmQUJ5EuFzeaw/xyvQkE17HW5mLkw
	X+Qdexi2PX8IO6GTBQ2YNadGQ5NSHx3mLxigoSBMM
X-Gm-Gg: AYBFou25GfnFSt72q47NpBrpmzXVB699NkFCitdPOVvBq7+kA6PLdVCGYC61i9zWWdY
	R6EYT1YOWY/cjdYkxfc9a5WJUqpFT7jf6/HTgSpAN2a5Uj0JHTV8N/L1LK+zzlMF/X/00uYK3mN
	gP29BlchxCs/1xdq7BkGTvQOxaQ9o/+lm9bE/C6UsReW0bbtxxtU5rzl4+5Rzn3YeTI+k1PO4Ne
	RVUuuPdliGMYVhHtCK+4pA+CnXkGIWwmnCTeVBn6PIeCHYtHrzEovlnTOjSCdgft29Bi9pZvcBs
	/3PbbWqM+b652bNOod7DbtAi3eG1rWwff6H1uXBvKl/Tg6kJ1KbV6d3lSOa3HEclQjZmv3Zdg23
	oPu4/OAsROX5jsuDqQjkC7rhIkF1a+yuC8pnSfTKJJCbjwdjbGG5lapByYLeZKkaOR5j4cyYW/b
	sGM36ptv7dNQd8XLGj0kcD3prj
X-Received: by 2002:a05:6a20:d0a1:b0:3bf:8a0e:dd99 with SMTP id
 adf61e73a8af0-3dad28a3ea9mr142626637.17.1788972425771; Wed, 09 Sep 2026
 09:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908205537.863484-1-kuniyu@google.com> <CAM0EoMnFTMQPjy1kaSmgcaFzRsHHgZAH1zTGn4RvrrEzy62Qsw@mail.gmail.com>
In-Reply-To: <CAM0EoMnFTMQPjy1kaSmgcaFzRsHHgZAH1zTGn4RvrrEzy62Qsw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 09:46:53 -0700
X-Gm-Features: AcwNN1XYZDG25sq9dto_19K2mo7n0sMnAgXHH7HbxqeOTRYLrllK7acn9JgY1RM
Message-ID: <CAAVpQUD6KVE9WmX442cazpF+WimZrN-kv_aU+jxqxCV_NXcA4g@mail.gmail.com>
Subject: Re: [PATCH v1 net] net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:01=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Tue, Sep 8, 2026 at 4:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > If a netlink socket sends RTM_GETCHAIN requests repeatedly
> > without recv()ing the responses, tc_ctl_chain() hogs CPU and
> > triggers Hung Task splat. [0]
> >
> > As caught in the stack trace, netlink_attachskb() could confuse
> > tc_ctl_chain() by returning -EAGAIN when the userspace netlink
> > socket's receive buffer is full.
> >
> > The replay: label exists since commit 32a4f5ecd738 ("net: sched:
> > introduce chain object to uapi") but was not used initially.
> >
> > Since commit 9f407f1768d3 ("net: sched: introduce chain templates"),
> > the label is needed for RTM_NEWCHAIN because tcf_proto_lookup_ops()
> > may release RTNL to call request_module().
> >
> > However, the replay logic is unnecessary for RTM_GETCHAIN.
> >
> > Let's apply the replay logic only for RTM_NEWCHAIN.
> >
>
> The patch looks sane.
> Can you send me a reproducer please? We are automating and testing of
> all tc submissions.
>
> Reviewed-by: Jamal Hadi Salim

FTR, sent the repro offlist and asked to resend the tag with
the email address.

Thanks !
