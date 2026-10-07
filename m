Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073349505D
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400825; cv=pass; b=emSKNW58ihKVXYHcU+v+XErtq40TbJtelbgUHSZg5Gfe2Whz85IysmOjj0VJYmJAw84vdc4VqjxETdRZiBX9xbVkp6WfLOnEBMULtZQJ4c1BhsQLXjXKmU/3oX6S4KVipQY6wqAAhj1q8JyXDTikXYkC+lSFXbYDLX9omzYbYR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400825; c=relaxed/simple;
	bh=nJYqS1Nl2QTJz4EXZt9c50F0OG6K9nd0VBFPbWscLzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHR4djX6LwD18D7HPJvMpX6Uno07+u2YTkZnvZlQX3ka0dYPNsscOey/fgIzOApAHkpAznl7PZwQEk94635cCNN5UONMRkMeHtUqk5Y85l4eHXy90ppx6B0npBig1qLNqHbRTaXp3R8UXgh7Kbr+3TE2mAey5LlTGlPHicdNJ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvm1YHNg; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvm1YHNg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso7123177a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791400820; cv=none;
        d=google.com; s=arc-20260327;
        b=kPz0VXog55MLHvBhhAeCOksvexKhIVLyNfvGBgCq1zgJeMTMZZ6wNRn9ZPDQe8P+Nq
         Iud5gTt/UFd+2yfy+Pi3C4ilTyAnatjK7mqf+V6rL77yP4p53xPFuwxbozzHTTu5PX5G
         6YRtS8InKUThX+M8rRvGAn4Gj0lpHNSml8s3Kg5muYUao935hmptIZodBcpn6Eli6YOS
         UllihrJmWI7o/svW66Kw1vJq7SYru0ILxTthxLW+NwnjHMh1uuCRQtkB99u5vwY9Gt4z
         kS+SlB0F4+kpdjR+7IwSDeQ4vHfSL63TczzN5kF7t3jF72CezMCj/5ldt2c/k7PdbMo/
         HWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tSJl+MTgxNNYk8O6TTKcnazk3cIP4AhXNdFAYCaKSFI=;
        fh=0xcRsjdjaZWiQKZLTofybxlXD+tnofbmRMhWETHbbe4=;
        b=GRrgHQiVh4S/fNbtMuWYIJa9nM/w1H/TE+llbg2hnxw0lANiheB4XIGJ+EFi+03f/T
         2CQ+Mhutj+9WuYe9pA7h1RiigkUy6cDWn/JLPSLJB64Q7/z+8GNA1QBDAqncm+awBIso
         UOKyhXyy4WYyyu8gdALYK4/MCuh5ZHPyRwkRvNc5HedKe3BTKqF0BWd/P0dyBvP/LDpR
         3Tkanb4EuJ8lEEcS7aTmSL7h14eIk/LZrms7QwYwDkGEbF/oagCQq8uBdfA6nBqausLu
         JrTQArgGpW6ZXjBM7j4ojzX4w3WgxEPcDHZMXFvjmzmE4UYspxIOCZ0xLWHDN1wt1zEP
         6DQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400820; x=1792005620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tSJl+MTgxNNYk8O6TTKcnazk3cIP4AhXNdFAYCaKSFI=;
        b=qvm1YHNghxQCq+ArAKH4XyXdd0+RU9XAO4HuXJisaDdVvrbqbQI8K0BygxpbnjgSpD
         YR3QnagKCrz+cMI5/1SXNACBAunGrvxLooawsqz63D0WuQZXanCNwH12wo3/pKrzOmIF
         Pu1uYP/90IfIPkApxCiJEXwaQbsemBEKb6Iu8H02GymIw1lfdd5VtVHC0E2PjjkL51+N
         Q6f7EhF5U/4p6rCRzLpTfzy0UAEanCstDNhY8DQYRAe2bUYfJY0kKTyXG3fZZC5an5r6
         eT+efwB4oDXS+oUOsX48TeBn2+UsRSrghAB1A9pQs/KP9QelzOGLGcI3eKXUl9Ql0mav
         hknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400820; x=1792005620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSJl+MTgxNNYk8O6TTKcnazk3cIP4AhXNdFAYCaKSFI=;
        b=UfTK74o0KUbFcw1X4eHXGxHAT1ze3ZqDKOFbVq/fT+moY8dzn7eeZFhi3vHwqDmDxu
         MxvwJ4dA11gQzjjahqhOs039yUPU15W/W1qbNbcg/tUnd7R3IIYCDYcmpRWSvnu50uJl
         tspyPulcBnKgy8dy/H2vd21xOUl2ifacrPh38oIIldLwPls1oZktj6wVtrbugerbejio
         jyPdjNfKkwkjbl+nM6VxAuzTOAN5sc3gGGSsGs5maWsuf0aj7HWaXg+ef2i0uTiZE2kL
         5oITTFGLCsDdK1y05QCC4bLFUqZqCvROLbgDgvBuis/E2ODk0bdNZmAoJ4xJ5IiejhGv
         qPoQ==
X-Gm-Message-State: AFq9FYJcu8ifYtipnu9QnCtkoGVH8wWIQju700XU11GzZij5mQG3im99
	JQ14igPJkFtnZMKLS+aB9R/oo50qdHXmQ9QVwNOEt/opMNHWRa2YEr3qnY6qicTVRidqVcW1uYs
	lHTNWG8K+rbHhtqh9W2s0zWF2BtyjOLQ=
X-Gm-Gg: AYBFou1nxYdgimWYXjLxQQ/biecyizQL8KQLm2P8WagFEwiZBFyI6P9p+ztsj9+uvkE
	ecBBF59w/6SmJvS2FGHQz7PHQH8X7yvObEKidKo+44RH2zvzenP3vH3eTsJA7H4UkB7pbWzOzLU
	QtTpMU1AYe3Q0RtbOk1C8vq5jFhZ4a4xc1zsTSP/c/zJGi7rt8zbqAD/oehLxo420T3XAVm+7kk
	IAlrgQXtXdGo5o5OyKOQ8sFFxoXFb4I+3hNfIy9mRskcBYJmtGi8Pysx4c0qJ+Oo2nHtuH9kJkU
	bI7dCLU2hq3L0qW13O5WvCd8KNt9mG4Td3cOzpyXC9bVIjsm4aCVueoiSAv58pZVojFMpJUppRj
	ct3A3FNI+AxXn4BdULqSglgD3lgt7MOS0iEu+9uODyHFsTMhnV5MyLquLmnhTka8+aN01rCbOD5
	xcrR5TRmbOI5eKtxMzNVsVe3Yd/658urC6gdfOl/9W3T5xYyhjRJWp8sfo3hGpTUMabvx2xs8zi
	/bE
X-Received: by 2002:a05:6402:321e:b0:6af:80c4:8981 with SMTP id
 4fb4d7f45d1cf-6aff458ffefmr3001931a12.26.1791400819719; Wed, 07 Oct 2026
 12:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007183821.928263-1-rosenp@gmail.com> <179139868898.2527009.7529803204490860855@kernel.org>
In-Reply-To: <179139868898.2527009.7529803204490860855@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 7 Oct 2026 12:20:08 -0700
X-Gm-Features: AclHuK9iuez7wxa3W6hTNTS6tIr3G2hhr83DCxxqavSCFqKV34JPfCinttQW8wQ
Message-ID: <CAKxU2N8QddjJfx377npH94+Uaw4kG4GkAFh-6wofN9iXO-sNZg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:44=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
LLM tool scan probably.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
