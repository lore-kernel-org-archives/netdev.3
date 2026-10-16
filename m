Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490D3B9956
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181259; cv=pass; b=FW0UpHm1ZcSohNzQysOFUtQLITlwrLLTi4g/gWXK+w9DCj0NcP0bRhWwWmQrEBeFU70bHz37ayxO9DojIK2mQq0+milSW9XtLu5HCYHxY6hB+20XM325Clwdl/td+QDitcKBIr/6OQZ6fh1LBgWBKfIZn+1nLUa6HHAuD46YmLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181259; c=relaxed/simple;
	bh=jbXJpGW85slKlL7BPFx1dXw6TKrNtJJq+8+8FhoF/8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpjHnNHZx6wc2Wsq9P+0m+io+8Kiv9qfoiuCs0jXeUetooymTO4bk45Vnbqo5DU7FFuA35jp2N7G2frNMkdugDmhRxyT6LMwTMAgLeKX3ZSwnDW7xcqw5QWVOgu6CFAmI/kUfOxtXMft+t0dpWqC2i0H2hk4pJ/IURKRjHpfk/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eLKXS8fQ; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eLKXS8fQ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a980c01033so2035321fa.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792181256; cv=none;
        d=google.com; s=arc-20260327;
        b=ERE0rbXRKVCGOHm3JkEZ3ViN2GbNvUAlcJFzOhgxUV+IeosftJd5FT7j84ftzfW94g
         ylRYMzatr/ET/ZfHaIA8vqx8JjFslnYFk8mrJU8ca+xt/cFPUG4Ul+yWhDnxFzEpzW0B
         gJawHtNIBHBLx9houHmx9ZkgoOchbY4T//SxLngjPhqgyG8f7jRdJjPOwxsEi5J4eEYD
         idHnI41o3uVJjVpeW5JaZo8RpVjEl+PiNxinifoZwq6gdxAl1dlgUX41inGbWlIM0b/y
         Ph5tXqq+splJX1H69qXl7my9QUbVWOfgzq5UmjRDoWZ1avLM2Alffs7S97A2pf2812B6
         rZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l5CG3KZvqX4gNl+N9Em/1NhyB1U2ByMfX+j0dq1RaTw=;
        fh=cO8bcNg6dIj9hlrwtkIPwF4rjMcCrTpWtFTWtiiwlpg=;
        b=kwaevokJLMLsq6gEYvy+ivJk6d54i9ReiW0yBTAQBBaH9W7rBF6lDvW5J9VS5zsaD2
         1LbOlsQ4hoHe7qHdBq1ms3fkUTiIivlpBX8FvcO97IyPTnhnimCA9ZZ5mX/Ay5uW8YYP
         FL7nVdNUa+2/Ig+ciAlGHZjKkaZgHNdZzTzriqMj5mzwnHYZVf5ILvD2vJJNU13wwZFj
         tdUe+03bmhm6xrmhBsksbRbT1ErNFPZIJ551FQSMFtO9IDPrcnDyqPkBKeJ2BDxoUzl3
         irf+zJerYn7qJ79WXzgmxEMNhp3TTOS99o/Eh76t8H3hhDoXH0HckIpw8bl1hIoLm93f
         IgSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792181256; x=1792786056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5CG3KZvqX4gNl+N9Em/1NhyB1U2ByMfX+j0dq1RaTw=;
        b=eLKXS8fQZh5WUcAXywz0DYpnlApuJq6r5YWZe1TKbfTTxuM/gBg6DQpXSlCeezoikn
         Kt3lCPk6TlQcON1fv4FadjeiQAeOidzhyLq8y0rLYbc8vK5Xw/qjra4Vv2jv+n2veRPF
         E/9YJcvAD3sgzUBltN3d5ds0JuGmddSHQB/SJgkpbyKpedZk3v2ZDVjBzyvCg+LeXtHG
         LxbLLo7LOqsFkGkw+C7PiNU5VqzL3NMDkd5Zyre0IC/m34/bpGyNVmXkwOXgQT3qd9hq
         IBo67tTcPnb7KqajCXEefWjAs/K0klpL7jNwghdHS3WaVxKHViPV0zZuqIC1yWNprcXs
         MQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792181256; x=1792786056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5CG3KZvqX4gNl+N9Em/1NhyB1U2ByMfX+j0dq1RaTw=;
        b=VjbdGysRFPK87U021/6PNeXXnZBFLbjL7qhSoCOQC/T1x9jdqGxFZidq/XUMchzWT0
         myyBcmso3rNSRArImPbDmFUt6KNVi3rAjhPO3DElcOqGarV90mhfELN+FFWJj3eYQG8F
         8iT70vQeNXW66DZrtlAi5GZelBSXMCRhsnggjoHqqFnGUuxN3hntwrl8DxG/8R9EChdJ
         Njg93KAJHyA2aLS8a2pL363pulJEq6MWdzTPOAAARlbh3Glr6qeYq9AyyOfZC0/vzZSq
         o/CLdngmdTyoPNYfGaoeSJPaR55TOWYbSuv2l41TomVwS4nEJTnx9r5a28zwqq3fGyS6
         7GHg==
X-Forwarded-Encrypted: i=1; AKwUvByy7gWZDt+xvfBU+TN6PMsEtxhl5xcntUYvuUVHyzbi4g3rqaDZ67Lm2Zf7d+3cwV6h1JqznhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9PSsVwuclICyVOOGOIeIc0jfhzWjqmSOLjfgZjuFr42+BIzT1
	+Htgz1q8Mjznzf8S4/4DqtKSxb9lFk8VUhjxkQJ3f4MELu/BRzoLavHyUeqb9GD5O/v45ZV3Jsr
	sECWFainVliJS6zwjkJqW5FfBW4aQsbaIAVKp1pW30NCPJhyxidVBZI/wKQgS8H7f
X-Gm-Gg: AYBFou3A6J5T/CRyFTaXGk+YMNgbKOWki96EmOgVRIo8fEovb2hk77kvLcPlj2x9i8K
	Sv/Fg0Mi24rYQyRiyqu0O/ndqfXTP4/oYhM4i/9pAlSahs09JukeSC33CYDm0CzlGS3oWpJHhjG
	iORfsSQm4oSYzeqK7cnXpyDW13cemjGwt8IrSTB+UHQgh88ztTjynL+kFOBoSV66685MW+FLHfN
	ILAdBbdA4SiRqwD1ONk4WO9jl58bwwF1lrbbpW/0KSZ5Dfs4DAGwstDx+JPavvXL0Nr+fFjw7ku
	vW25IrthXnj+IzTzBvx9q7M9obkJkEBnCcJgXCSHt8hRLIjuY5f5Mw/dJDg8oaOUnHM1HSkbRTG
	0f9cmT9mDKFs=
X-Received: by 2002:a2e:bea5:0:b0:3ab:1639:9a6a with SMTP id
 38308e7fff4ca-3ab2905eb58mr1927011fa.2.1792181256435; Fri, 16 Oct 2026
 13:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792168462.git.zihanx@nebusec.ai> <179218103298.408196.17886596144254819298@kernel.org>
In-Reply-To: <179218103298.408196.17886596144254819298@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 17 Oct 2026 04:07:22 +0800
X-Gm-Features: AclHuK9kHI_fQ2PFmhApHMYTF3zQZ0FdIi1jUxqWYqWDfz5Q2NAym5XVYBBTQZc
Message-ID: <CAANe3eQx0WPB3t5G86XEFH0vbZeV0fuMLmWv+8cmN2u6t_3J2A@mail.gmail.com>
Subject: Re: [PATCH net v10 0/3] rxrpc: fix encap_rcv skb accounting exhaustion
To: netdev-bot+sinfo@kernel.org
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com, 
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 4:03=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

The issue was found during development while investigating RxRPC
receive-memory exhaustion. Code inspection identified encapsulated
skbs being queued without effective receive-memory accounting, and a
PoC reproduced the resulting OOM on an unpatched net/main baseline.
This was not a production or syzbot report.
