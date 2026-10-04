Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97021FF29
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116562; cv=pass; b=XQJstlFHEFreoVGb3H4Qpg4BAaY8TFCj1pdPhNOo9lKhM2TZlP4pkaV7JgFIztXVZqnB71LrxELvcxYEyvyePwIrXPQxLWCd3Y56PT3bpoUcDIZPbhwZMSfeOyWr0hvuml43iq6gSL8VKNQcnnDhdEGvY/EcKaSc5wGTHSLc9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116562; c=relaxed/simple;
	bh=x+uHHtoltat7u8MXTqDYPaAi9h39HOLYBDpqzqJ1pOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2G422kDkFsnOhMrvViMRIBeCrt3X5uHZ8TiuS5Ls1m4ARQtAZZpKTYqlDMfDZGL0Kg3oYs4PgVpvMQz0FsymkCAcJTLWRZ2a+vs6g/5k5EwS3MtrAhcQYVhNBH23HR+KnYsmXcbiJ/D+IrRwfgiQ3pBtFGkYrhY+m249Rvy4J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh5mfiaD; arc=pass smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh5mfiaD"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9178b9ca7e8so13149966d6.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 05:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791116559; cv=none;
        d=google.com; s=arc-20260327;
        b=rotqCn2iFZ42LgPQ6rddGh+3sdj5zYTd8LKrAJtFp+6T+THOB/2JmcmevZmTGtpX3z
         NpObMvyaKOrZX5+lHfrSV25oUi2QF3m8tLz9e3f9jQZHnom2CLe+Q8YlA4s3IEBTr5kN
         KMZo50DmH+bZdOeh9yOBQESpUr+QE7GRvTBHMejs9rCj+PrOhetmWzdkcxZdSdeYZsFL
         ayhLYaTiuoJeQTeEia9+zkVHJFkoMTJ6rzuDcFMWS00C5XJgZAIeUK9vimUH/IxJzfT3
         bmZhKysWvv9N1AnW4ESbCsYTqUYbVUioM8jICElZ9rzAhcZP6mkc7j4+yGmW4K7AYvJ8
         8WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ZYjx+1r5vp0THNJehBxeMIT4m4dt14EorNdO1/i8AY=;
        fh=WSOg/i9LxeUtfTM/ZFjb8/gaKNoLoTRPYpL5N4dXAlE=;
        b=DsrovCUGMYAfboV5FbpWjThFHNV/eXf+CmSeEND4liVPVofPF4fcP5KWJ7KkHPMjbH
         siC8qvmSUE6iG9rzsrCD1OXAPNRVj8y6267CBdWJm9Km7VrTjISiLo0uEfbRAl5px1Wf
         0rYC9JAIFVHFJABCzdWsPPrx/dJEMEa4xH7601Sop4zqWD5YheA8HHGaOenc6b25zzF7
         CrAJdsewWVhDx7z6xUMj0NtK25WmNoXS0CMQPXdp1KCU3d+g1iblz6s8je5XJHzQOHbZ
         uSQ04xpowtpeTVIEL7KRfT5TbfSOyHncK5bDPhM1EWvNXqXcbbs928pHJYr6dRcg0gcD
         jJrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791116559; x=1791721359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ZYjx+1r5vp0THNJehBxeMIT4m4dt14EorNdO1/i8AY=;
        b=Qh5mfiaDcqtxEX/KZtpynwRFQmrG0zBJEOeNnEuCR+t7DZE9LVGpj+1eNNH94tJRkx
         RXXjm/abYMuhx4nKtovXx/zyOEEtr3v+Udc8WAi0NhdbBvE/la+ekTzNDsuUXcCWNPs5
         da0LXPOYhYSJCiDzaBwpZgi/aPi2rF8tIR/rwajwxUUO5EnrLxIt5DLfhIR2TzkbMs5p
         u1DFyPhproPqhclvIwelV7LrtQ1/SS8WWKOPYGsRbo9YcN6LFh5GcYaiSxRyK5gVpPu4
         EEppiKX5d4bauzbOYsYgiXOdBCXyw9WHxz2mSQ38IuQAWnSQHdw5MQLc8+ajuS36WYRI
         iHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791116559; x=1791721359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZYjx+1r5vp0THNJehBxeMIT4m4dt14EorNdO1/i8AY=;
        b=oAYk3tWe2iwbfyTMI4JBKq+r6xMtUX5anrLcJwZ6tZ2d7Axa3vwqgfMo9LtbYUKAj2
         V9x6aJJafkJZU5oapPrV1yZwLUauZ50p2ae66WuQVX/9JOTyFsDGWixfKGOJ7wC4Ddsy
         JhWyjyTI+fNNuRCVVFd0TkyodqdvEPtn/oTnFTkH1ayUMKqSi+bXOAHRrnN5PoupUhnL
         HIYdaxtV8ckFk9wfJW+Jfj3DLe5aV1EHc/aSwTSp8lND3GqzuHuYQcPxYz+yDBMlDWlv
         8HR1Vh2YS23BF4y12PcVH/zY2Qhx9v/TvCxY2DV6XfMlvI0JX4OM3rvMm3/QdgVdTLyD
         4mig==
X-Forwarded-Encrypted: i=1; AKwUvBwl+g7kDUoc+SDPZ4y04rU2XaDLwgB3HnawVAk5Nhiv/JFXQsfsHWzHxYFO7p2TrqMFPRPz3Us=@vger.kernel.org
X-Gm-Message-State: AFuF++lmX9ZBqtkfEmIVHi/ZhJo/E22unLc5ljtsG2YtHXk/Oan09rgm
	AR7/XG39Up8giJbjeZGXEQju5tgmCQih9qy1ny+oepUZahZGE/FG639mut6Ve35eJnUkA5MH8oa
	3CfzNsxmIxdEWbQkapBsYUR4blcBxJjk=
X-Gm-Gg: AYBFou3y5y2tSUZoMUmHe9bDgPP/EoN5FsZqdRjHyuA+GzbsMYocA3v/z59AmStBjEB
	jwdzTbLHBXtiwUFMmIEp79G/CskYIl8TcuGmZt5q12lvrbaXIlEYCRDWmlf4Ktj4NUKi95HcDfE
	FKBodvyEnuv9EnJ8awHIA1qdsmQc0HASdOQR2W+Qgq1hm5W6rk/UGSByeYI/gBVHtfHTdeYHnqT
	nRZa+6vyKHmTY1va2ALYrAtC94GKxkx6c6IIdkgqo0mfdubPInPqvHkaN6U6TxpRAnMXo0KsR5A
	5aOqwNp2q09063wtCWifeB0E5/XsbrKCj4iATfqwhZ5LAbwt+Xx9GEDz+NnNKhZbczKv
X-Received: by 2002:a05:620a:43a5:b0:936:df48:d507 with SMTP id
 af79cd13be357-93ce94ed6e2mr1355623985a.18.1791116559566; Sun, 04 Oct 2026
 05:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004120526.2728564-1-zxyan0222@gmail.com> <179111571610.1402591.377888819234151971@kernel.org>
In-Reply-To: <179111571610.1402591.377888819234151971@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Sun, 4 Oct 2026 20:22:27 +0800
X-Gm-Features: AclHuK9jrfPfFj8M3GL_Owa_kw9zKNkIad5XcOnkNjdlIpwCoWA_TR7BFvZBUXw
Message-ID: <CAP7veTLPuO6QfS89b0VuKSBYDmQkgQtPO94KEhVtjNTNLoYNdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
To: netdev-bot+sinfo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, richardcochran@gmail.com, 
	maxime.chevallier@bootlin.com, muhammad.nazim.amirul.nazle.asmade@altera.com, 
	rohan.g.thomas@altera.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 8:08=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
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

- How discovered: Patch 1 and Patch 2 were found by code inspection
  during review.  Patch 3 was found during development testing on a
  local DWXGMAC2 board: the PTP clock advertised the aux snapshot
  channels and PTP_EXTTS_REQUEST succeeded, but no PTP_CLOCK_EXTTS
  event ever arrived - inspection then showed the XGMAC hwif pointed
  at the generic stmmac_ptp ops, which read the dwmac4 offset instead
  of the XGMAC register.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

- Actually triggered: the EXTTS failure of Patch 3 was hit on real
  hardware as described above.  The races fixed by Patch 1 and the
  OOB index of Patch 2 were found by inspection and have not been
  observed in isolation.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>

- Tested on: local DWXGMAC2 hardware (not Agilex5), for the Patch EXTTS
  issue and basic PTP operation. Agilex5 has not been tested locally.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
