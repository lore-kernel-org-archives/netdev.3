Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3924DFF9
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717821; cv=pass; b=L18zX7aMHnDw4U8TcArjabE5W0UU2iwYUANjWPoxXcEQ/IObXvBT9a2UZCOnE6l9+SNswPQ8okl4ewjyJMRTt2coYaeU68Cn5qVfn69u3RF3zWB+pcyNMMFg2Zj2smtGqbHSh8SOcAGPlnc5ITW8A1yfhwCWaNRxV5YBHRRaAI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717821; c=relaxed/simple;
	bh=6S5nM0TeHpy1xxJuI9ztdTyKwNfI3pGJlDOe1fVvLUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXi3mxwPFw8b4y/wsQradOk1kkvL/AP3bXOstg9uR6iTxssM9kSlwfBxNVBt34guzo7ccyExUxF4nnaGsDwV0DMfYBSVROrhck57r+zb2eGMBtnLMoHy5wup1lVTOaV+VBSsHeaM7zPQ1xjnA2etsvU87g8mAm8y76j8nhPuqEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNM9a+ex; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNM9a+ex"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53440816851so12451601cf.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 04:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791717819; cv=none;
        d=google.com; s=arc-20260327;
        b=PlHWbp25gCwmVdfTyqivWPHq0dvoBDwHC/L4p1ObJGodSZVYlkiHO5dj7ULHz9uizA
         NSOKG/wwj4VTa5vrr+lbvK40/Yf6XjuY27rLwKOuLqZxaGqzCey4qCKCau6EQuIlO5TM
         HStkw2HLzUFi+D3APrbeUs1xo8Wgj6vsIE0WpdmxM6Zs9uH8o5rVoY7dPTczs1tx9a56
         Q2h1ZPM6HFgOI7EkYbq1ofTc1pfORnBnV73R7VBNvcD8oEkw1qPeHcqKivQc7RUskhNa
         zumrNF9elDCkOaCE41KiGi2khNvxiVrWf+1s1nM2KWA139DQ3pYe+Ijd3YW7LwGD0O7c
         74Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQtrELtPHcUM2E6UeVj7fPemFu8C3adgNKDbLbY/Hok=;
        fh=i+4A0kLsEtTJr96GlIGFzRN5a4niYwyeXPGFDvEmfsg=;
        b=D5G8LjE3BFPmVxqu3WN65vLEqNY1knCFSY8d8IowpZHAAlBmb6GxKfpEo4GipiME6d
         zuuJ2suvRHS8TzJvvASDnpt6n8GniK09Af/uoAPR8U+rDa3L/O85mkConzd7C/C4eciq
         KwSYHgaN3KkXBuXB9+bY33ehnVgSLoR4u0vEneF777CEGriUGdTu3iYId2mRwIHhGwNH
         NVmMYpzjwlVKWonjeYe3JUP5/k4RcQavx49q6t3Tuxj/m+rC94Np5jab3sGwqTNBV07I
         FKQH+63Q88abV2/D5RUmZW9lV+TgutN6aD1A8qM8VY0x5PkFw6RTBNEV+SEiMHrlV4tq
         aPVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791717819; x=1792322619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HQtrELtPHcUM2E6UeVj7fPemFu8C3adgNKDbLbY/Hok=;
        b=MNM9a+exiO3VtIzFn/qEN6fePbhN1AQpY3dNq+AnLajWsAqiAbPGTtOb4FWNBtf/DH
         R7gUYrXzzzgLYfgbyTgloJvOr9dKwT1tpVkwvuFw9qRYocCmBhuAYug07WmAAKFzGvNE
         7hBdOn2VWvUdNx4E+MZ0B0auGjlSzKt6dEwvgXKS61h/v2OkmhHPXAej1Tt+FYy+ahjQ
         UWMI2JoUjRBJZPJYKBDSMeoKQJlkux4Hoem3j93cGQsWMDysYDl04Opoxw7Jswkg6Er3
         VtrNdNYh3LTdpsa1NLB5N08+LXA8WUiU/LLxbjJvTqAvu+xQa+W5gFfok0lk41jJmNPm
         7V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791717819; x=1792322619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQtrELtPHcUM2E6UeVj7fPemFu8C3adgNKDbLbY/Hok=;
        b=OFiKFduWvSgDlCrFj6WsqiXVCk8LV8mAdPdw1Fne2g0AKaQ6cfY2bUgpLbfdSLuv0e
         YYuB8CSWTRPsGi0eRse+TUkzdUdo2QnvWdOi74ird04FYrV8Fzb9Y6yXP1Qxvajtq3cY
         Rd5y9pgmMZFXDr96ubNRdFRs7Eszkg3A8cAukAeAp/Kt24YKYIWAXjnSwcYM+uMgk6wj
         cZbQxyYnslVpyLcS3fjuUmarsmCQyY4rGl2wTwTpGP7XxGm88wDtNt+Ot4tc/LlA5PJP
         IYYo10trG5CHfYHTyhZOpjMh1EN2uJuSWsZVzxeQFhacGJLMVKOQtUroxehvyOUIEakA
         sjEQ==
X-Forwarded-Encrypted: i=1; AKwUvByFXR2CSrtL6B8I1Dl6cNTuCsE5SUup5mz/lvXxsjUFO8UibYtBsoEcOkA6ZKLAEaC1yy6p02k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU483Ka9MVaArIcZqZns4W+qdtOP6AYy+C46SKFQvnOVwcsMrs
	eoq5LSfzvOzklE9UdMLND3y19shJmLiffkGXd9w5Onybe6axP9F8c4BFL07s3XseSjz6fWllcz9
	6VRoWhbZcAMMfTi8ut4BgyLsNAHEr+B0=
X-Gm-Gg: AYBFou2RLhu/OvgmLrgkgUJ3vHPWqY5nYywM7ti8lo2XefCUhoQIX5rp6CI+oujkHxy
	5MQ2mXi6lt9OdfDW/r1UhBJAc8qi0a4Ywhjzd/SfiJS3rRV2NasiHFZWqA28/GhQnJoGSLzIExY
	Rbz1XLGYq6fTkZMdlwGg1Gy0sginmGiovPUPChnrkWuDFSE/P9XuNrYynRfzVapPLM9YpaylbWu
	7KCpM5EScWgGOJJSLprWhdyxo4uwk9Y/zieVa67psl7EJREywlYPg9ljAnBF5nJEA2dtwIE5K1y
	bD4SR2o2dg+gWhqYJPmf5LEoXYXXUuZU81Rf0quc+XK1d9m8DChVDNie1woZxRh8rbaxxCXnFQJ
	k7zFopaI8KEppiuXsXYLGYLuBrW46tDq+fE0q09wYrQJ/KGuAV//JtlGYAoI1ehhjPqRqf9NqsA
	Z6JeUsDM/v+1gqB+CSYsjN8l62te9t1JxN7YYfWSye1qrUkKo3ZKYkuXXtVdMaBRW729QG/DU/3
	1cAcfDUZoK5XAbiqJFH8V9V/3jhvf0j
X-Received: by 2002:ac8:5f0c:0:b0:533:d98b:d373 with SMTP id
 d75a77b69052e-5359fae8d9emr116437321cf.20.1791717819231; Sun, 11 Oct 2026
 04:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011111606.14753-1-jain.sm@gmail.com> <179171754826.2527009.561712354727529429@kernel.org>
In-Reply-To: <179171754826.2527009.561712354727529429@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Sun, 11 Oct 2026 16:53:28 +0530
X-Gm-Features: AclHuK9Bae3Zu4tNFkM32AdKSdWX51c1yCKllaI73dhcI0T3jtwCSZvSTD7PBRc
Message-ID: <CA+FWx=nC--v=9KHH-1BSt13EAnCu2hwXQzA_=a3Gd_=RUyrTzw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: keep the route window on the SYN when
 SO_RCVBUF is set before connect
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>  - How the issue was discovered ...

Found by manual code inspection assisted by an LLM (Claude Code, Claude
Opus) while reviewing the networking changes that set window_clamp on
unconnected sockets, then confirmed before posting with the packetdrill
test included as patch 2/2 and a veth/netns reproducer. The patches
carry an "Assisted-by: LLM" tag for that reason.

Thanks,
Shashank

On Sun, Oct 11, 2026 at 4:49=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
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
