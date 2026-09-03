Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EA4052C5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430920; cv=pass; b=dnUviVkJih2vdPSVsDuA2Cg1ZvRzlgMuCLyQKO8KGxER5DVYqB1MPqUWF66m99vMxB3P0dlvNOcC+Rxtnprpo0c7Es/W5ycEmHieq6JUodqNdKkx2phPzS9voDCO9ufZ5jgMuYTA+l6xLeJkrlJIzttUfRJ+OPQIFjPHsPnARUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430920; c=relaxed/simple;
	bh=P4+9tq4vAAjVPRHdvKBfHH7h2AESuICOL0EhPXygHGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kulMTlkpI3ubGKd6aJmbu+/biAlw+tkoBLemNBfTqz1ge+j8DX+i8N3K9+L8L3FTi1368c8sq045c/PQFCksClHNX8a5iN8uvpSlruIhCOWR9kdjYJSnn1aBRY+0IgjBzVj2qFiLKDo1dpOS1kIA8RzrEOns9PZsMCN5G+YxSCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulyfsPV3; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulyfsPV3"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-530187593e0so12467771cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788430918; cv=none;
        d=google.com; s=arc-20260327;
        b=HuB8aYqLm2LlC2K3c/gh+Xylf8git4/JZnrUrOMbo/PWB+2fpcBq29OPNDl7y25M/Y
         66DUzBX/vileWSgUmacnp7ia5g153NCoBE149jYrZySbAlhDcTJx7jp6senkEeHKI4Df
         eVqE3BD1qFvUJTUoDuiYjHrOO25n995jrYT2wSHH8oQ/Rjyn7sREcrtoVsSPRXzcwvlO
         3DMmKfuwlaxmZ5Xr2/Cf5HU8u81wIMj0wWnDcuRSiGd0HYugmFQjgz7F96KdmIiWH4wg
         TFuzNzPU7dLFxfZj5s5XXeaKNxkQh3QrcUkPdLvfNTBo27SBs3mUIakuUGUDJP+uhgnv
         hobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4+9tq4vAAjVPRHdvKBfHH7h2AESuICOL0EhPXygHGE=;
        fh=qDFnJkhpbYbI0xJw8sR3JxaRlyZRm2IqFHd0vZqOQlk=;
        b=OYbVv6RS/etuH3WCnJnDLVFJ/r62anC1Fzt8hjJDj6+vdV5V+SYa/9x1nuPTEdFtSz
         eUUv4XuaxZAPJcePwZrR9NAKUKRMGefHCVUffCUxYC4twBKoq/5yj1nDEjRIzjdmlODi
         sHAw89Nbi4MJ4QG2QIlA+R08BGGvJ/5CTdLFbU/E3v7Q42eR1jVf1eWnckq2f23FYAku
         0SWVNxH6JrIGIvQS6wPKM2AAZrc2cmi08LCvHNuJK2kYroPUcTTrLiodRrnr2JpzNfQb
         ggvsDcgzZnDUTx2sNKEtD9atoo6JpwBzUrtiff0MwLAvuLpQ0ymrsFKFun8enCC0LwOF
         gfzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788430918; x=1789035718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P4+9tq4vAAjVPRHdvKBfHH7h2AESuICOL0EhPXygHGE=;
        b=ulyfsPV3w1UNrdg0uBAfp5j1RJMh3ZmWDgpfBF1v3h+Nd/jRwefVdGOWPt4oEYmdxM
         EwpKZ5W31aBHdncElFkMuDxp+7K8jiPW7def32iIiM4a7w/3Rlj+/xFj329rQ9OaHcfG
         HM+pGFuVMegaF7GrbnANXoSkiAvKF9uX9+hK2Soc8MxMyZWRQZloFfPRj+uZqtUvO9bE
         p3HT7KSppMxr6MXOk3KWReTS2g0WYOLJ8a/LrIkwZyIhF1Q+eo9QL2mrUySoRwjkb12Z
         niTg7FGcBXNAvcD4mww9UDevR6sg+lGhQm/pI74ZNUj5FUNvufyHe2UJ6lnqTKI+EEZY
         g9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430918; x=1789035718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4+9tq4vAAjVPRHdvKBfHH7h2AESuICOL0EhPXygHGE=;
        b=l6td1NvwcfsP84ZMbYS0KzzUHSDw+s2kNSnRyjAskrAKbg35xWWIpbMT0757tA+oKw
         Xv50Y/zrB9gWjJoGjaElXj2RSJaAl+znnaaBRs/FBuBjvFI5bORmbevFXEggG1TR/Qmi
         NteiDcDhOjxkRiW31vFArBFmewYYA5ghTnNuu839oTadg3tv5WyuraPmCuntJhHJ2IiG
         1tEfHSrT3Gh7C4kI/k4ND34lV2z5MsZ58kPn8jpxpjt+butajBVZxFXo5I3zB9o8tJ7+
         RMLTNe1URweZIsxyf/jXTEoXRSpEIsOmnT96U4JwnfVNkHkiNfPgQPSp0DO0Thflo/LY
         McLg==
X-Forwarded-Encrypted: i=1; AKwUvBxLYSlsi4wLK47I8ggZPOQQPDjS/dvlQGsnD3MB4No0oSHL1jiRmGBnJ4N/ktM6Jh8fbmYh1v4=@vger.kernel.org
X-Gm-Message-State: AFuF++nCb3Sv1l2ZHgE2gtClyAfISMTwD5h582+YReI7uLR6/I5mnLnD
	USvd/XAwjuw+0sYGxYnaegsnjbJn823iW7sC2GOWbPXjhpf55JTo+j9GZJNGQzE/TNToLt5TwUb
	x4m+ljFKrBsrGXJdP87MDlFqwdTX9QiiKUCKsqiD4
X-Gm-Gg: AYBFou3CqL+sOQQNahHPCpHrofMXO6wlwhWc1c0nKuFbgSS0qKNxn2mRT3/f4KiQ9ac
	iMO9y0hjDBHq88bzBe0mhcY+1V4N9w82C+S6JwI2MIrk6pgvON8P/tZBH27wAtc0Cj6sASiUmVX
	I7SvJ40llJutsvSO1cFGPomRffvDoA7E45xWxNkGGJ3lMFhV2AZxucgZj03YfEo+N3rBpb2S/q+
	vGQQTILWlXlmsvh7O8xMIf9RwE0+XytlMEGzKbZp3WLJ+5kwwtbvxG+Erau0qFWSsQHgbM7/Cmv
	8ZbdXllwHsf5cif+L+RTUJK8/vLZdiPToJfzAeOJ02YPF8PvxvYR1+1VVaV+Mpi3PihfCDKOvXq
	ItgNNcPKniSGd6RbUs8bx8dvZHcXFLlMsxEmGRNHBWjYAMxTiyqlszUzqWg==
X-Received: by 2002:a05:622a:50a:b0:530:42e5:f39d with SMTP id
 d75a77b69052e-530480b1408mr19378771cf.25.1788430917133; Thu, 03 Sep 2026
 03:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903101256.8879-1-zhangcoder@yeah.net>
In-Reply-To: <20260903101256.8879-1-zhangcoder@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 12:21:45 +0200
X-Gm-Features: AcwNN1UaxWHjBGorfpe-qoeZHxV6U5nAMpcdRNcRwFemhMVTs0uB5zgu4XYySUY
Message-ID: <CANn89i+LS8aefxHe7MvV7DZ7kSWrLPQpfB-OHa76O_jm8_fbYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: fix mdev comment in tcp_rtt_estimator()
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:13=E2=80=AFPM Ziran Zhang <zhangcoder@yeah.net> w=
rote:
>
> The old comment "mdev =3D 3/4 mdev + 1/4 new" only describes the
> common case. However, when RTT decreases and |rtt - srtt| > mdev/4,
> the code applies a finer gain of 1/32 instead of 1/4, resulting in:
> mdev =3D 31/32 mdev + 1/32 * new.
>
> Express both cases with a unified formula using variable
> gain g.
>
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>

We asked you to leave this comment as it is. Thank you.

pw-bot: rejected
