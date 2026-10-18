Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C31F30BB
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792283978; cv=none; b=RXn82doQoTLv3SeETWetNnLrT3HYDD8845WQrf4ztbJmCWAYSX7nwxOIUK3TI75D9Iy5UR4MtPYp9sBZ1zdWSuXpfyCtgBOPPUq1Xyosqt9lASW5/NCWIw9gFv6TEPW/2K4DWln7M2aBYutVV8q+Cb174AHX5cRK8F8A25wXOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792283978; c=relaxed/simple;
	bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=LBx2TnzBub4A9uFu748VGn5v+8wcH21+jpsrZZJPZipl70WR1Ax1n/JscWulFNqXOx6NUZroe5geqZgB8gVH7u2jvWkACsxW+j9nJH0tkoJ5jBcL6CRzBRmGGPIihMbRKevxqUk7oT2cqz6LcPGS/BndXT+I7jtlsIw/HfZAapU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmo4Dn19; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmo4Dn19"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab98332238so806247a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792283976; x=1792888776; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
        b=Cmo4Dn19cytcEOaH2PSu9aPIrniI50UyM0l3T4WYI4uQBMNvvPI3CFHAAU4sgRtJBT
         yI5YG8XnAdAp9YYU40VD5k1J9N7SxZh9WkHXRfY9FmQ6lAlemIj+Gr9IDuHyqbGcI4g4
         dOz1PlM108kLuKMAnjByl4gJuG7fbO+ZK0YYScp5280SrcwZHJ8/VKLikRPTBHQ7UxKd
         aZyuUCPfRlJq2sJQpsHvxakZIVn26Ped0mCCssPvsygnUK2h7aGI/iqxcx17851qxlxU
         wrBnAD6LOP22dWwVPm/biXexSkablRTbajb+MFAYLpkp0JKOZFVPI3gGcqfPm1L80wL8
         Y8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792283976; x=1792888776;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17jvRmZBNnCl47JZ4PPW7VGtVpPr+tXsZAopNeXWy8g=;
        b=uW8MgwgJAKtKzA04LV7RCZKWydgTEBbm0tZFVua6hndxNw2vqMggDR1o8S8tCZUPzP
         Vjr+zkRZxLmpAQXpkBBKaJpH8lsAMSHw9+rGQwPiHvs7AH92Lc3jZgvuRnX7+rOg91tr
         QleipPCSsUBzOj3kWIarS70r0pbLMH+YM5NJ1Q9RnkofNZsl7yg1ehHXLYJUVII5jE/J
         kR1qlal4TG/nxCaoJk35fHVwl3KgmuLPtyQd8R3HMfY4p8bqIPHFrE2q2OvGJNXvl/kw
         bUDhYONPfX2CSKiS4pkH18JINHYpDnF1CG4LVzjN1PxKdu/Z+aLi9kIJF7ZW9wcolWfD
         eNEA==
X-Forwarded-Encrypted: i=1; AKwUvBw/4/3UOYaEsKWkKKJaGi+/1MTvn90xW2ClRTStIodRFH9aSBpPGiOwLlUdKlFHj8pT4oDuHIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0wvXdECu+DQ5A1CVP5HG3wpX36/9tyKeyWLBe+NKlm5KhcgWE
	mZe9Jzo8MK+3Xw9lfq1dXmKSscAYbp2jS2iqbTB7u0OPVOkpedEr8YL4
X-Gm-Gg: AYBFou3muNBUSYLAY+doLvUo7VzRJEqJSxPj6PmfbfSSOYlqriwc5Hw3JJvKUfugreE
	8vcAyPRYWosBhHsqFuabO4vWmHAJ/LcBgKDC3dSAn7zfIKXpo38avyBy9VRaxckS0F6pKgyaQGB
	po3ehyptC8K1HsU2bmcd0L1c2MHB0+HJYtoCjpkaJZV+gbfFruWWiUrmw1HNEJD8Qq1fSOlAdSO
	ppKnLhda28OnYkcdluQGPOdYFLsJtHQg+Rd1cIHw2cwGOXZntBu7SJukOSOse5/QvP7c8FBYz4y
	+GR+MBUhhwBLitPjDU1wlfMbJffyjQ+kMJKwId9tmNxY9tCJvaJDIWZoJM8MkKQ6FS/piKyRpaf
	h2r7pbUsJqxi2+yP9E0Ns0ls45FtgS7d1q7UFQkWVjrzcy1B0Lgb2Lyax0vM4Qakgp78C8+o+bF
	TbQfomSDJxzMjIUZ4pzjQ7WAzmSOo3Hea+KEMo0oufJeSppdfXZ8PmIJKJnLVf4OhKugIDfpxbj
	OiJMmV+PH9i5Nszd061PEwfflTuZ+GKdnwWLE30QhdxuEwJWspQmlQZnEDvFBgYDf3EUowlGatQ
	AUY=
X-Received: by 2002:a17:90b:1cc5:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3aceefc6164mr3175867a91.13.1792283976186;
        Sat, 17 Oct 2026 17:39:36 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm14753771a91.8.2026.10.17.17.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 17:39:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 00:39:35 +0000
Message-Id: <DM7JN7JVMJFG.18LKSE7N5TVFR@gmail.com>
Cc: <andrii@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <josef@toxicpanda.com>, <mason@kernel.org>,
 <memxor@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 26/43] bpf: Don't take an extension for an
 iterator program
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tyrone Wu" <tkwu@pm.me>
In-Reply-To: <20261017220550.1661-1-tkwu@pm.me>
References: <20261017220550.1661-1-tkwu@pm.me>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 03:06 PM Tyrone Wu <tkwu@pm.me> wrote:
> Hi, I originally reported this issue a few weeks ago

Sorry, I missed that report. Both issues in there are real.

> I'm hoping for EXT to still support ITER progs for my
> usecase, so rejecting all extensions seems extreme.

It never worked though. As you found the load fails unless the func
is named bpf_iter_<target>, and then it's taken for the function of
that target. The patch only closes that hole.

> Could `bpf_iter_prog_supported()` instead have the `tinfo` search loop be
> applied on the `prog->aux->dst_prog`/`tgt_prog`, and
> `bpf_prog_ctx_arg_info_init` on the original `prog`?

That's a start, but not enough.
bpf_iter_get_func_proto() goes by attach_btf_id as well.
The iter link checks max_rdonly_access and max_rdwr_access of the iter prog
against the map. The extension has its own and nobody looks at them.

At the end it's a feature, not a fix.
Send a patch and please explain the use case.
