Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793092069;
	b=YKfDdbOsE71w3M0yjxrNd9Zm00DqkMDykVPiL3bg896AEEVsRwbwpClJS6RRUaSiHieH
	 w6o5oQZECp7zcyxDYgP8gcQXsvn0DUKywtS24bslp5urQT6FFOyjE+eGSEsuhCqYlK/xZ
	 0oN/bVsYHcunjW7VNyI46/TAj/+Z2Czuz3oa8Su/FUaNI5/8P+18igjJDYJAw2OdcJxRI
	 yBgRmhvnn8DrCK68VVcK5Huf8sYVFvZ7NMD1YN9z6i0M0XPakRTzKsc96DSsSBP6opp1E
	 ELvBSd6PMvfTx2SK431uACR8dlyc/5tS1z1JEr81ONGDbnzHNWYhsvhqlvq6pI5xbRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
	b=H0W05fQNR0LsDQxDGB56sXYdDMNU33gsuHSXNEfJ7kHg2rf8l813mJkeViEFkJncur60
	 LSaCstGcyF4S0gjhNeNngTbyPyazlE5E1LsJROjtNrOL2kEIg2AkfZtSM4hMsyemW7PDg
	 FjCvkXZyJwh0Sa9aO/yuQVpZpeZsKkwyrmlvmwoy06nAXwDjighBvCbvJTiV8j8FrSCtH
	 Y15G2itduQ3BOhInyBUPc15ONlvqQCJEmW7/BOujR9t3Q+a7HPpOVvQK++3nju1nmaVeu
	 wi1UpL7mozpTa8kSMK5RxsXOaaNFhfak5dhcKLQKutTYjl8/3NEp7scoFPHSe2b5mZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=G84K39SC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EA606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=G84K39SC
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1605945b3a.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793092063; cv=none;
        d=google.com; s=arc-20260327;
        b=LIcJZb/Jz8Lk+2gLKpufr6kpPWGm7v2KWDUH/1WKf8k2WKaNaJLd0SAKvPe6bIPA+d
         lS0Ewyzwfd1f93FdWTxSH5gA91saofAzoIReN2fU/q7ShyegSrWSHw7muctP9uLyZZLq
         idZLGlO+HgZsF3Y7oJsPUIjKij7z1AbDCaYHidyYsNe//CR4JoAJJG4o3MA4QPdBMxeH
         1Q2PmoQKrEcIt1yITP0cT9tE7P9tRDU+nUZpDppfUvThAkgUEhRWhjHB2ZwWpaLkuyiQ
         LYiZGl8BibG8OOwEycr0e0UnT2aALjx/HpY5oEpCmKZ4/2sIg1D1T/+fODlVUdAT8YrC
         Hq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        fh=5BKlMRgnuhrtrN9pqF3uiOKbHpLsfP+PPCk/2znyjr8=;
        b=L/ebHiDd5jP6CwgLVUG+n7PxtSa0uccAs3GiivpOF6wQP2ZZfFfS3rKMk5qkC9uKeF
         hWDnh/HxA6XMrkR2RPNnvxLHh80/4yHGAYPamICnk4ZrRfXNyxtVlVilDGSUTJP3Afoo
         SR4if5q+WOHYLenDtwWzQqcbPVysEBzQrG8LSOTI5WDuts+WPRj8WCIrksufgZXwCCmq
         7L8YddHj4/qp+rI9cOUEmf9d3d3s4eAt55ftDnOpb7Di1Apz1MTVGu0IJUTkS7q3/w/j
         KBekoj4Z6Alb59giP9O6EHJuuy+aD0mtXYvhlHG4N0xi5B4kn6/pUeO2jSiegUBb3GLt
         i+LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793092063; x=1793696863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        b=G84K39SCwuHHBvc+MO5/wCRtcI3mXN7cKHRkHkiE3pY7m+FKUJa6WEGgo0KVwCJoWm
         34NYLJK07mpqdKBTmxO2iklWV+MJLFe2bcPvJkLLDFYPjLHSNxW3LdCx1tu96RBXVwU2
         O5r0AC2sSHXTH3cBnCNy3pjOixYYwQWexJS1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092063; x=1793696863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J50MjdbeXeR0wrBPwx4kRTNSm8kxLqeUdZkQeCxWhMw=;
        b=mLzeObsLMoPxpyLKOFV63VpSOWCOOpNbVD2Q0uzo2s5FENbmCn2jmxXnN6peNTdp0U
         iuC9I5Cj2ltNkE7M4hIViJSDWrEsmKuw+VDiDt1V07xSp9oo6eY2kDFUotKm2LbhQb2F
         t69IduKHpMxO4T/PMFXfRQ1XM9wCpmW3blXHCCIMYzVD2C9CiaApP/Ik15SwIrqMJR5x
         x3hG0NvZZ7Oq0UUd0CMypySwF2A1FV0xMvY3/bDVDLLuv34UFMhmZ4hTS2kXGRiFpZh9
         xVIAwbEsauyfAt8BMUN+B6/Mfjk78eZgF3fUAKNGp2jf2ZcC8DGKxZAYEAf/jVcKTpMh
         9SJg==
X-Gm-Message-State: AFq9FYK3rBbV/h8WckRM3kJJj6+n/sd55D6t4VklL56W9QpxzRTAPqwx
	rg4GHi2TeLVctytoeGT4hBZhvUxAUFv1w5N+7Xh9hzTWeriLK2UG4DyTImXgu4ay+LbylivDASv
	DmnqE1JCg+uRhgyBt22LpbXh+NFgUxy+7CBzaYMyt
X-Gm-Gg: AYBFou3isbgu+m55/otPR0WMfEzt0xHrw0sQT3uCuGf28TkjlSoppRltwuFfx6aE5CT
	cJ6XRofF3SSjUfLJMEPewbsqB1/4ETwFOAu3oC6nFPFyQHL18Q7rMtQryutIyvrR/kgwcOGL90S
	6AtqkRtv37BwHmA9pEmnXwdOhwM7Ak6CMt89Qk5qj8EbB28HNMM4ewV7L/qoRHBLnlbJpYdE4lL
	rJmA58KzTCOgIeZaxaYzlGDlfAisTGI4X2vmwmVRL1s8MfZBex6s4KtytY5S+PpPT3XtyaAKgW8
	CV7IA8H/do0LDM4rZdBllkZY8c8Nd7aDonGXyRc+0xtR0Jd8yekHPw318gpXLKbN1dJM/11e0Kf
	5pUs1oCvlRYs4x47mJTD4Tt3Zdk723DzONM0+MoQFIGizu9HrotCaK5isQWL3QytQR8P5wrQLuT
	0BTJi7rt7Mri0nGzQ=
X-Received: by 2002:a05:6a00:2406:b0:8a0:3c:a8cb with SMTP id
 d2e1a72fcca58-8a364e531b0mr6883577b3a.1.1793092062949; Tue, 27 Oct 2026
 02:07:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com> <179308810546.3327.8505039495265223974@kernel.org>
In-Reply-To: <179308810546.3327.8505039495265223974@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 05:07:30 -0400
X-Gm-Features: AclHuK_Cr6xryEy8YJzQiqxJYKCJVeHztHClEIm6xa5N_nPm9qgWgpwlRoLVrKc
Message-ID: <CAM0EoMnHOFLc6m3zYS7YdC7ZA8LvwXvGjPg+fUKqCJ-+RrVczw@mail.gmail.com>
Subject: Re: [PATCH net 0/2 repost3] net/sched: sch_teql: fix header-cloned
 write and retry strip
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cheers

On Tue, Oct 27, 2026 at 4:01=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
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

My bad for not explicitly calling it out in the commit this time to
avoid you sending this email; answer is the same as before:
https://lore.kernel.org/netdev/CAM0EoM=3DyCSeB9+Q8gFsB8sjQhddM9qWh8DOfSqqNt=
p6byubv2w@mail.gmail.com/
https://lore.kernel.org/netdev/CAM0EoMnb78SoNwrqgH5308B_+Mh1sBtm+wJ=3DSFXtM=
HS-L2zfXg@mail.gmail.com/

cheers,
jamal
