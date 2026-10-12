Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69573EBF16
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812083; cv=pass; b=LSW4oWEh1oiKXc3bSy9waVMdpioKWDHtMQ/Ye8yHCs1vUGc5/Y2MG8VWI9MFJPaLPyuNKSvzS2PwWQVgfE5ofMiZlAK88eZg7CAsgnsCohDIdsHHWQ4m+sonXomWh00tUdNPK6D91f6r0WFnCkXUpYjp/iEeQeUrQxWjAHl5kIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812083; c=relaxed/simple;
	bh=Hjh9Sc1Z8WiXuHtP/aanprIfbIR9xjT2RLWFLTycrHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5vWxtwsYH+3ak8V4BYsT0s02lZAG05ityDWXaTKONPufnRwqop900ld4Xb09E0pz6FwkJsF1KhzB2WujBo9DdtMp1dKR44izEbvyB1FtdptLCeTBI9dJaPO6iHCBanm+7IxByCJyjN/A5bmV6jif8XCfJQ+tIr+rb+ImfS1kOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i60sjgN8; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i60sjgN8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53505bc6524so89044671cf.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791812081; cv=none;
        d=google.com; s=arc-20260327;
        b=V+akMNa8l8bYuwacgo5Ll4HXbvy294APwMF1qCqPqG+v8zGYm7GS63Fez2vqdZH2/X
         SwnbN98NQXQO4D05d9HGqmWDgoKBeawPPIiPdhIfezN2jy1x41QKkOk0ACYgUPqR/sTY
         VDTKffmxunRduUDMZYvVBWisUu4k7XN421G1gHmk0QJJrUifnsuk/PmUzWSjP+W9EQPo
         bXF2JJnZwN1wGZgEVr86NsfRUxrxXaaIK4759V4NQMwcWCXr3uhlnnWplTZoBswhqUbh
         hLX9nI7sdZLrpqvDdycWuzmzunkMIKLn/Wg540rc6QMICVjSmDySaRbKpCI2BAwJMb+n
         7P4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pQuL3QRG7ONHZtCsU3bcCCqTHvrsEAV12C8i1xPxyc=;
        fh=kSW/Pbr3b29vtBjeKsUgynNUdoNNvKlvAwAr5G3EsNM=;
        b=JKVYUD2Syyy7rIgeNTIo4W1694apLhqKQG2ausGv1rwBYjx4R2rpRmblVHtqUUoNER
         p7VQUY6adUNqnLEu2eAdFP2bB78UMKIQZ0zboid3hXT/48y7wTRgCl0SUt05wcDxLExA
         GQBPX5n8CN8aWN2DEop9UnRfXekrGkRXHyI+t0osdD0UFO1CU8Irj+tnf9NNh2xv6VWm
         JsqWPDBHXE9/gs5KtFqPHz7q7C+VRHckza3iWkPv65YvL/MaMKgrWChxjze85MBFTdxz
         uWECfqykdKOp79dal6kF4EmHYtH9GUb16OMHM0KhoJrwmvHY/akSAVMLJDZWLnTCRlPo
         PUUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812081; x=1792416881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/pQuL3QRG7ONHZtCsU3bcCCqTHvrsEAV12C8i1xPxyc=;
        b=i60sjgN8Pg2KFoMIbqsgzNQ4h4khD3JMnyQLM7f3cidu4wTAnA9e+9b5egoC50ImhI
         1ccyJGnZFn3LQxSaSDwKedStLu510UnnRkwfD0emti7topz9C/tIo8If9gBVglRBoGqI
         lDzke/3kYan1cHxlIPloNUN6BiqKHj2rrcjYvxJr36+NqeEBiNMg7+/OH5vLnllmOrhl
         M9DHVv9SL9tGNov/bIHVMa5mBEHHgmff5+nBg783OUQCOBRmZuTtku4PgEp0dKZnQydh
         RJt3CIpqBcghIyEgYmasKehYxo2OduK7G4IXnYrljDJDCrE9/lKsqhTSuao7sxB7xKUD
         GTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812081; x=1792416881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pQuL3QRG7ONHZtCsU3bcCCqTHvrsEAV12C8i1xPxyc=;
        b=cWtuKlN2a3dOVYtHHwPS3ik3ZBmy2MDRMowNgBCEj3MwvPYQeZdVhwda7DAk5sA4UO
         I7y8U0GjVZd1v5mLka9dFde37BZexg6n3Tg8LNBzoADiZPnDeGFPfpWEuqXcB3q274XU
         LH2rOy3Jn4GycCTdTf1vMiotVC2Vd0DZHyFFJpgffxKWasv8sfX21R7HmZMib3u7IS0L
         xDKaCoB2VmFh9c7fz7d+9j45Jcdqy+AVQmiLcuDEfUNV23wnedJ1MFZRhMXhvBxaMhhA
         WcCXLKl2EKxwcbryKP5toRJQ/Bhc8klo3RRR/uMFiZQuG/zvJRO2eGqQl6bReKVzMyi8
         INHA==
X-Forwarded-Encrypted: i=1; AKwUvBztovGpnePTEeEimmjEyZpbUN0eALpRf3oacmm59XCSQYcMLM1+LuYbgOBt1dQN71MNn6788ss=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFNojueHMDEzY1XTFsNYVAi6p9ry6YSZD0Wac1/nBhcc5Fghyq
	6mgGR4uNI7uZ59lraPUSIHXQMmNjE/abgo3ytnyE8lVrftEFMZyFBVeiQOp6XxtocsLesjVK7s8
	IjqxF4946mduweP5l+yV2YBQ3yEpGqYY=
X-Gm-Gg: AYBFou1EbME+u2/MKbwHoOeShGGeqrug/4RxvxII5XXG97o+2Gdg/2JDqs8DgnaPpV1
	FQaFJloYMd/MbLP6eZO3oqSt1qDEN/olxLICtuh4Ega+yj9Cu0+zvWZZMkSD3dwTO721fG6Tp/H
	fjWWimLKrgs9yFuQsiSIFVds9X2oqPr9SvSY7j0svnytcmeAC96zYmsg3Il5GxJ8JXKFYeXvRct
	4nm/6ndzVUKEE2G9IApNREOJ0gE0DngoI8KlnPvvWBE9DcerD+TFK2r4tQFu1W36b1qh5nXuXws
	a9XXs4WkqJf0JO+SGkVKufrszGlkfCu4x8CcGiaw08buJAFWam+5upPHSW+uVaoGb6SiSxUkGsW
	125R7kwLQiD2xBfEV30v/heOTCZWjYuhh2no0MaB7dSe0SSnIdV9r7d9eSHU9wBBAoLtOdsbnn4
	iwSAWXVzNZ6JsXHfvIhA6gzvcBrF0bNW2yvIWUiN88qkZ+Y6bylXwwFrmP6NGNakvWYi/B8+XrJ
	LJ6ewpFqG1QRi95uwzAQyxOMXbI4Io=
X-Received: by 2002:ac8:5a84:0:b0:535:1b18:211 with SMTP id
 d75a77b69052e-535a6167c2dmr141612981cf.19.1791812080480; Mon, 12 Oct 2026
 06:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012132622.48550-1-jain.sm@gmail.com> <179181183946.2527009.5855837780305581870@kernel.org>
In-Reply-To: <179181183946.2527009.5855837780305581870@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Mon, 12 Oct 2026 19:04:27 +0530
X-Gm-Features: AclHuK_kfEe-9ObjWtrZZzSOuT5ZHZoYK7KuO9E7Qd1UmZm7snqpktX-gyYDV3Q
Message-ID: <CA+FWx=mA0dsOSopCNBiA_8BrYSDYD7=jxMO7uLpxT1OOU-BkWw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] tcp: keep the route window metric when
 SO_RCVBUF is set before connect
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>  - How the issue was discovered ...

Found by manual code inspection assisted by an LLM (Claude Code, Claude
Opus) while reviewing the networking changes that set window_clamp on
unconnected sockets, then confirmed before posting with the packetdrill
tests in patch 2/2 (SO_RCVBUF before connect with a route window metric,
TCP_WINDOW_CLAMP vs a later SO_RCVBUF, and the TCP_FASTOPEN_CONNECT
SYN_SENT case) plus a veth/netns reproducer. The patches carry an
"Assisted-by: LLM" tag for that reason.

Thanks,
Shashank

On Mon, Oct 12, 2026 at 7:00=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
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
