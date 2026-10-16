Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2C3BD635
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141933; cv=none; b=J2RdjuB6jesB2tFOU1qFzfkJrC4GzubWntl1JwjzRThDZV7LrWTeDm2ODDKjcxIJRkQwW9esXxpekPyzaAgZIIUBOgsK7NPGxU0/C7XhdXk0u3Q3p8lh0a+sqII4RzF1OEtLZrbwAx2cUrqwEnL6FQgsVyJ/3NU/YkixBh3ozH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141933; c=relaxed/simple;
	bh=yjG06fy4V8hJlDtmMYdOsQrEM5vEVE03KoqlJfzTSg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzVtOMlJz1tb1pUcvB+cPNPdrOxB9TrD2RnQ9xmcc9T+uq6QHhAyBud2TkqWhjEEh7qfCedxqGjhjb5U/DPGlxUzPkyPB0p+u2ly3W4L5/JKJDnVGNPy0pZ6xFDWAVw35KTS7uglmb/d+UM4dUjF/wUaoVgOB5HhuPiBYze6zmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up8mpsbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up8mpsbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190F71F000C4
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141932;
	bh=HxnfRWTEZksyBlAHUbX7yCNQHeCZEY4w6OJeXgObZkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Up8mpsbQXN4jfQ4FWwctGgTbkQiSfU/Yu1rDy21QstTB87n8RZ9aogb4nkRdRzHMK
	 WMtGOV/khqbUyCiapa2V8sz6PGvFMsyQcxIpt19hMTEfE0rR2KIYGq6Yjpj7ln1Rpn
	 PC0VUCZ9afQJfsfVgSBmrP0ngVbKnGT1z99jVhudfWgl/s9llNuomBciO45QRCC3hl
	 hoohpRcNkGLKvN4J5nXBP0GajhLKb4IXli6SwqFXyYLuI0sCwsoF6e7ZF/aKhVyF5B
	 pkdb3+6zLGkUHi7+kjZFXymDfMB6O6Q6rncAdbpMSety98+NE52L4tFLu7fPTNvS/Y
	 r5dee4aMAYP1w==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46556b9e02cso654899fac.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:12:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwsoyvhQvhCncrf65pa0/04ykh4D6pLMxiHLz2kBFJ3MyxOxDDhjHlT9YODiDpm63FgAT08wIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMq1O6LXBa21KD2+/h2aB/qj9dkYGwgy+qDOEj92Tfsj0kFrKE
	aj4aGtwNU58+EFvPEPJr9uVqlxIzFjS2GDjCOmlhUU8f5oFh6G8vht5rlaRZUdUl4JFFWERL6Vd
	RKplOacD+7Yu3yRYsIFbin512PraQ50I=
X-Received: by 2002:a05:6870:6589:b0:48f:3cd5:83c0 with SMTP id
 586e51a60fabf-4a7306e96b3mr1784420fac.13.1792141931466; Fri, 16 Oct 2026
 02:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016084802.2725187-1-edumazet@kernel.org> <179214079911.408196.14833825392033478796@kernel.org>
In-Reply-To: <179214079911.408196.14833825392033478796@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 11:11:59 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqConAPxcd7BNu1Fui25d-_aa1zWF7fJdYperzFTqeHSA@mail.gmail.com>
X-Gm-Features: AclHuK-hdAx8iYY-nRMRuwngrZ0td1xakUrCtph9V7QkVdm7jSxY1wAiIYl-cwc
Message-ID: <CAL4WiiqConAPxcd7BNu1Fui25d-_aa1zWF7fJdYperzFTqeHSA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst
 device netns
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Qiliang Yuan <odys.yuan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 10:53, <netdev-bot+sinfo@kernel.org> a =C3=A9cr=
it :
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

Discovered while reviewing
https://lore.kernel.org/netdev/20261016-bug-net-netns-move-rcu-barrier-v1-3=
-4157d798658f@gmail.com/T/#u

Another patch is also needed in fib_rt_cache updates, sent later today.

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
