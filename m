Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5B4611E1
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142482; cv=none; b=G0KDCBiRsWqKCfgZzhW1NziVODVfjYiYGhN/hKzPIwdHb9P9BsRZ2gWjs5zx8LEsvHOmXZfIovaGxizTygA1mgMlxYweX09iBdrz8Ik/qpZe+mCv25AfjrCcQC/mwnyR7pvlcffJS9bvWvd1Mc5H5Ld8Qe/ZVMdFaqhaEbovdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142482; c=relaxed/simple;
	bh=cZD27DXt1R91ac2PVT+j1qVPMFr6TCY4R9pOCrnksyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeDE8AXmlRh+jSBFX1LpUm0hWkjBLPeFTsu/wZAEdvbqw7u0riLFls43+NxniwqH4gHuFFLzyUjLABG4ZFup7+3PU4GYVoV9R6RS/zNByrgdWD3u24Xeb90oCYV4qau/V/Dve10MUPuk6hQ4GOi6p6AKqP4f3SNingJrjwhespU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqMyScjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqMyScjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96E1F000C7
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142481;
	bh=whSYQ1ZtaV6BaBQS7xqIN2emKRc7fqX0Msi6IqWe3u4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MqMyScjq4fOPESEPFJjDcU8acDgmLN0eiOParM9pwUc1EHIRmcMeIzlcFw9kLlqA/
	 tgyqRXhV41FpKcc4YlW47WjFiAbdhAYe9501+30uZyjWbiEleOo/Ou/tSPmd2fDqB0
	 ItCHJrtlGFaODoDPT6t8otyVTsY5oA330ZoW42EOGZ8k3cT9DJZJ7RIFX0jk8fN1MC
	 jGZB+WYJjhG3H48T4hMRj7S5+QGuAW5W0JAm09OPJmUjLlXag9d/pdjiDrQXN7oHpU
	 gf2A7qkZY0304NJqMucRN3g8BT4qCcbQjPsK9t9XPn4SiK0vkpeCcJUhw8VMJt8dTB
	 wBuDY71aw4YGg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-486f013db83so1751235fac.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw1N8rIFHvnf4MFAnJnzR9aNChKXLnMJvr1/2JMSvXkAv4yztDmX1Q8s/2MQmuCfXQ6qQmVAuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXTS8XeepZ/squb22ZLwDdvul6ncnHFMPKTMwpHuMJ7GwT0nXU
	XCZZyJxPtrhQnvYVIIHm8cEK/CCi/Br2cva+fPSdJGY75jmuhvo1f9U6IAm8qya+ZTmx49NzCRY
	4coQcYXb6mIJ5HWhAvD4mUMqhpAgIj8w=
X-Received: by 2002:a05:6870:9a03:b0:4a7:4323:3fe1 with SMTP id
 586e51a60fabf-4a74323436emr593322fac.20.1792142481051; Fri, 16 Oct 2026
 02:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016091556.2750902-1-edumazet@kernel.org> <179214235565.408196.17937869760737531000@kernel.org>
In-Reply-To: <179214235565.408196.17937869760737531000@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 16 Oct 2026 11:21:10 +0200
X-Gmail-Original-Message-ID: <CAL4WiipQG7m5qqraJfWuhDuu285kCe4G5sLcS+Bi_Fa3dhq7Jg@mail.gmail.com>
X-Gm-Features: AclHuK_mtHoPnoJ9F6Bkil63vFulg96xiAiX9WEha-2SVNe-b7obZKXY3RkKmDk
Message-ID: <CAL4WiipQG7m5qqraJfWuhDuu285kCe4G5sLcS+Bi_Fa3dhq7Jg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: account route exceptions to the netns of their dst
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Qiliang Yuan <odys.yuan@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 11:19, <netdev-bot+sinfo@kernel.org> a =C3=A9cr=
it :
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

This is fixing a minor bug : fib_rt_cache is statistics only.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
