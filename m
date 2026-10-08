Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8101DDFE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438296; cv=pass; b=m6l7rCCyp6CWa6ZdAEy6jLqGjvgVLwj2zP+giN1RNRVfDCVF06+OhTmsBohG3zP0udflQpIB7rkvDGA/Nd0Gv8rxWQvWGHYRBJX5R3lQzmYbGfBDRec3Qq5BDmqiyFBzWDDjpx8Y4jGNIQlvtdrjTHTQpR6IiChq6ahEVIuDAsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438296; c=relaxed/simple;
	bh=53QEL5FlHYldrY+O+EBlAwOD3koq3J0/3a83a07SPFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcDxAEeFjGFW1QeL1Bx+otpLA+bEu4O4a+xTmKpsThKWJ8JLm9YWQuA/wAbXTjKTBpWhhI5XtPEAQOjzNrW/cga9hDrKvyz7kmopnwQWHAy+Q+O/Ci6MV2JcQqLMbuDAVtRHvmonRSNIGdkCn3dq6scrIcnPdvF5v7jZB1D/ZjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=FnBbSRKY; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="FnBbSRKY"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a9787a156eso20023641fa.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791438293; cv=none;
        d=google.com; s=arc-20260327;
        b=D5JqW33mTpzKS2nIo9S6q3LfeTvFoFMdYNgf1yIfCyrVKvB9BkP8I3hfxkKepI/qMX
         g5gsh28vs4/boOikoMUqJ1aYEBcgqwI3Ksrt0VbWZh0GRubDtMHJI6mNWuxdZPQRYjLA
         OQ8jmywhbEVrvRuQ+kgaPJaJWxFQOFGpjiVnkbMAbYif2QQGUiG+hjeHGLATV5dxQgP3
         yIRKbY0ranWRwiXXVYGvWIbHxOTb+qBUw+gZLPlOA01z5EGmt+WirCe5hYQHBmnvMGUD
         Pyikc9ztdFRTncGGRr4TD4xMJXUCwJkqzCzjLzhEc6CxG5HpV9jL7Vc2Yr1jkMBR095C
         Ddpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/YdTCknd/y9LBwZZ4Idqr3OAkwQji4unNR9hm/IJ5Q=;
        fh=Q0scokCh5za0crGJIUjaCTy3V1OA7Td3ZeKuAINdtCQ=;
        b=B9IrDPoncuLqZKUR6oiSBmXzErh5v0UzpNwfZ4oZq9bmcZ03LqTZUwlQQWwDPxV2Bf
         OQQW6sNwVYs4WOVYTZKcMM+o8K8WySuN5aWWjorraCb5Juj4gZo2YX95ofpV9oYEXJLf
         JEQN8WDyfxfL4I1OEgKDqbI31h4ekTIYs7ztdqGGZ6lpaTYTd83Ta0stX/Rsz6MaS6+P
         CQ3s7lBs3y0tYRMxz8hmlhhNd6Arjt4mBrbrJuXAjGfFq6ni0oL0E2fmJMW77hjlt68A
         mFO2MiL9Vjq+NJUObDDxtBUYD1hXuFo/ng8xOCclIrpHq8T+grsbTJHqnFh6T0HQtBZ2
         y93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791438293; x=1792043093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/YdTCknd/y9LBwZZ4Idqr3OAkwQji4unNR9hm/IJ5Q=;
        b=FnBbSRKY1A0+CSt/IVKZTsl17iZYp0+zOrBeQq+aouKUi6ZPfnDOxBygrYq1x88weL
         +vXgsgPCGBJbfD49D2Y1lIR37Q5GvToovIkR//AdwSwOvpiedmH/hEqXojVQinGPunZL
         dkp9V8o0Q4ktn3KHCqvi9pfUpm4mA4Er85pUO0jQr5KdeF+BOIgERnNfIDeFO3F6HeLH
         /cMYf0We+yJmhCkHhpnO+R+vVkp0xEj719xZuLX4ob6mESYm+fqxR8kYj9uxuQs/pLB5
         ByvDlAV4bgfskFhafOh65xI4tAHci9m/THnOzudVr04wlKnmwWrrcj/skdAvVo2NRIK8
         pzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791438293; x=1792043093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/YdTCknd/y9LBwZZ4Idqr3OAkwQji4unNR9hm/IJ5Q=;
        b=uvvgDR44vV8K8fYkZo7AgXaFXy40pacivvw8wjWjvMrZpAHPI4NjQxC/vsf41cI5L+
         xFfaypIMFO+2Gd8pRYil14aTorEfvBxPkzsPspRL/2caAZZdtw1wUmSFpawH4mWf6HF7
         ku7MxuZu8K2NIyLyonua1hYm99etORQj5KRFCIr8WscDTdsVujg9OH51n4qgGOqq6n4e
         9hZx1iY5acEDYBPdS00RptEm2+i0+6Cr/UZqoXnjIYTyi8baHlY/pBIZ680sgp8ffzOU
         xpYTybKjWkXYuGLYpSbtL/6Zbl24ZiLo19zfOXpM6yI/08uJ+Txw1tSKvWH6im8rPtOt
         xGCw==
X-Forwarded-Encrypted: i=1; AKwUvByy0HG49jkU1haP4i3eQInc/Zv1zS7zOncaXXliMAtXJf/XKyYNNcjMbcFAgsYQWUkyq/DVom0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkp08Pz9wuISHXl2VeNVur2SIlFBahKZVD/YNGIyqaI56xuCmT
	XAZ6dV/w+mtzSsfT00WuEZybhwsy7RrVrY9Mx6beTbnx9QGsWamqH4T1RHlO5D8TBcXnpxRu4hj
	31j7+yr6Y4N/a3c8ayiNgLMJlL+Gd6Qs9H/2R/cfP7a6YfzsgXczwI52oCM93zgsl
X-Gm-Gg: AYBFou38oWuZDZKZNKHkF1/bQYPLncSyx3Qxan/k+T0gzlrUj3AsqsOpi27FlFggAJH
	2C2WRMKkJSkkhbvNouJJCZqih6GwP7oj/bI2iwhxAkgDVm6AuKjC8TvKUuYBLIrxCBSjIZjRThm
	XY4jQMu/+P7lvXVVWHbIUQkAByC8T3/Nk9UlzfgMOCQoGgoSjpmdPj1HdExsuc5pXveLxs+P5IH
	nGc0Cb8BArnXIoSynN2qTKq/CApHwGNHvYRwdv6CqHZDyDafqZ2i3v9HebuKonPtdsurbhnvmh3
	lVuGWb9KuJBGu/oTq0JAi+NziZunWWW9qpJnuK0JyRCnGiHdCVf84reSWS6HLLtGAuJYu5wAtIt
	YX7P5u+zqUOrTWAd0sTh6pQ==
X-Received: by 2002:a05:651c:1505:b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a9a2ce1f6amr9868101fa.14.1791438292745; Wed, 07 Oct 2026
 22:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791428529.git.zihanx@nebusec.ai> <179143775146.2527009.3109321224299351978@kernel.org>
In-Reply-To: <179143775146.2527009.3109321224299351978@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 8 Oct 2026 13:44:40 +0800
X-Gm-Features: AclHuK9PM6rrZWC-lYdaDOm9j9ga74MK6LO5rfiyj0JVErtEtMeHscoJk0C5gsY
Message-ID: <CAANe3eQvA+A6wubAbL1nnQ_ZTiqgfjRgGXkCDzgLTq4ygs0r5g@mail.gmail.com>
Subject: Re: [PATCH net v8 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
To: netdev-bot+sinfo@kernel.org
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com, 
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:35=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
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

Hi,

This v8 is a rebase and resubmission of the same patch. The detailed
information requested here, including how the issue was identified, is
already included in the v6 cover letter.
