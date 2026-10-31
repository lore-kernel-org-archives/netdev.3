Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793473981;
	b=ozQ38U4YFjebsD0YQdGKFOrH1pkTiqtjZ8aWD4y4uxv5Yo3lzZo8m93OCDBq/1F9xmaY
	 XESBd5M1vIdLWSJ7FQmrF5dpr52kX3a+Dv9WP4aLGugydoQbHrp5oYPZoncFerfzItack
	 SBPm9S3VJksT/AkycL1PdcJMhpFck4/ofhtxMYP1tnasgp/PZmw18dy5UYFYmJyhVV8kF
	 5avDb+uQ5LQodkMs9+SyDPHgj1DDuNXjGpMu0oWtyIJh8Dkbi+60NLkx+DFWW3tVacdDt
	 FS3Aoxu4wemywuQYkd8fZLtFmsrDtn5tgPu7BfTN6MwLpAXKLGh3sKTIQJg0fFrE04A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=axLc4hThd98toFERnEK8/2xtxUTHU0DBCagvAmEnenE=;
	b=0/fC5N2U0M+OIMubvwZKN3LTuB3+6mEJPwbRXNpBz3HMEhSofnjiKhxBnoNET6iq+Gcx
	 kZTmboX+0G9OKjCieq3ll6AfWWxi3sRaUSJrTyIQ7l+WS02A/UomXQQXIdCdHxdeFWm74
	 9+zEmVMmthPBzTpT0lE5sV5yaeI5ZKs+DXxNPGLl2RBHmN4+08RIOypFJTgV1BtAQ+fUu
	 cXuSC5Lf8zOjPaIM1eNvV1vjtkvJXLI0byCO5OXhW3/DkVl5AcKMo8oiFzGD1DQzMFSGg
	 Jyirt+hXtwPQQnY2tgbvDLNdaxxmJH1ivRq8VfYfEZw6N0jEz/x78vAZGxpnPX1ajxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nRALHhvK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7897606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7897606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nRALHhvK
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso4567a12.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793473979; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3O+1pYq3675gZTR1R0El1n7BYhMRvPtVH9VaJc/KF1i6eaz+GA/fMqUMqgrs0SF2E
         u/i+bzJ8tmrSM6meW87RGQoctfgg8WLpcYTF6Z74ZDJa6i0qGd0QK4jiqg9qRkJ/le0M
         1ylrNgIAjHtFNAcVVjHZXps0lpythzs4hhKFpPITLHfgUS5g2XwwTNWdHFdYz1BrSP4w
         wdT1HM3wNAKxDZguzioaH4ZSBIKBvZdyq0kbCJPZZbjPaSSu00HrNDiNnc26hxeBy4bg
         /guB4KTedOvELnZJPShJpfLL5LQbZXzbas8sS6yG+tRz6tBZegidtgOrXTr2qF1u4e4x
         GQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=axLc4hThd98toFERnEK8/2xtxUTHU0DBCagvAmEnenE=;
        fh=URlmdDKXmNqZ2D/xGhcjq6DmcsWA27sJiewCLXIYGJ8=;
        b=AUBqjnFZ3dzXWOoAyVVuAcpwuLx1Qu/lYmc2oxXYFMiEqFwP8WJsE+MZOGY8xNDRWo
         GMBSxk7mO4R6DrTySjzGGPFeSdTLEmnselst/Xy2Na3fGQ/h37sDhRyepRueO4xBaUxc
         QcR2iMvzRPu7x8mLUfgl0udFR+cYW2Mg9Ww8ALsqo4OTUjr//xQ781eco38oXELuiYJW
         KFCV4RydTdVcYmZT/r+bueI54Cro3is2k3k73zdPv2wqW6iewTuN6no/DHeQzEigyFD9
         OPt6bjNpQi+NnFcw8RcjmmVYfnRoSI+SxiFL9pdQov0BEFUoudY1eZjyvFAaM1ZNG1Y9
         pZUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793473979; x=1794078779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=axLc4hThd98toFERnEK8/2xtxUTHU0DBCagvAmEnenE=;
        b=nRALHhvK5EhJYbHjlXVUttUWdDKNNysqUsDmIn3jP7+HkDw5kax2jrebrX2CGf9+3W
         jrPEhE8AZ9XDYIQWbQBJP/4T/GTY68x0eZCXwBHkuhHlYTZ/KJNJtxCoYbgVASFc1QBa
         dLJZJxRbXAsl9kKL793uRVMGpWSpY/FQmSyWRKq2+duI8cDs5caa9p7+pb7CGE62dYvN
         ByAnx9oWxmMz8AHl9tzzkAUjRQsA1mF/wAKWmNYsEe8jfigwNlUuYJ5LtE4Ue/k+2uuu
         8jYCAWoT5gVT37C5JIoBynn6XDkv1yTzZ/1S+ULM9Qbb2Y8xOqHxfT2D9gKIjdKee8N2
         E+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473979; x=1794078779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axLc4hThd98toFERnEK8/2xtxUTHU0DBCagvAmEnenE=;
        b=MA6mT9JkJ0NpjJUDgqEynu9q4ZNSgeJCTxcg3TyvV+3RH/vQwobp7HxE4fA7Rp0Iqy
         lDZMOg++sLqHDHmutnwfxf6qXvDFIm8ZXCBwii3F9aR8bxOwDXOkbyYdW5BjHcwYt/BS
         1k0G3gGRvP/RCen+4Ajx+y1CJwNQTXfE8cMZIYCALd5qnpqIzwPXoVpsntxeP4aPD+0l
         MaYBkjSO/u0f7TxhcDGS7dNG6i0BJFJJhwXgmHlfu2ycoPoyL2GnVRg7iH9Piz3o71pW
         xLnHfXQx7l99QXfcLSbEbLrK9g1IRCwK5KMKTuLv/f3pjUmihLAx4pCNOrfcmB1rAXXW
         jpMg==
X-Gm-Message-State: AFq9FYL4gurrvnKHZbojqox6AVI8+R9jlIij6p2F6Z/bn5wDjWSMjItE
	MnJ9JHQPWt/JHS1JrRT64KPw81Pzpa8d1iNp+x4q5d5cvlMGwgeY2pzb9P0aM3+HLfJhD+uNDij
	P9ssewlnlUZBSPRd0J/lsQUTR6idkzC8gBa7fso2j
X-Gm-Gg: AYBFou3kIuCnodvDiTDLjFu0RUWJSVhd5Bwl3ZJYpHk6T/honItnnWp2Y1Ydevap/sC
	xtzLEVYMdiHZHQOKC8eYaY1i38mRE0T298TCFTu3doWkjQm+FT06Vgoip09CvVMKDqJOKvvo6de
	ZxbavBUGYehiYLASPIwvf30tdHE4HPCoujWborUdpHE3D1657zgDgSIUjflcwxaFNObegM1l0af
	rJxo8k+gcnr0/fhqbDSWS1YqpNjiRY1Pc6L2szKr1o88UpEZy0gnEYxT3eAIPg4SnfnRQ+gn+vc
	KYNXui0B1XGIUS8IRRJ7tk+QlVtY1GL2UKCFNU+0E1F1Ux7O5odssu0cKz0jMQbELU35wHwUDsJ
	2pDShqI9hxZjDVasQtwygtLbkEgpJMwDXdSt9jNo=
X-Received: by 2002:a05:6402:3247:20b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b4b10d785amr228016a12.3.1793473978761; Sat, 31 Oct 2026
 12:12:58 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031162804.1893-1-maciek@machnikowski.net>
In-Reply-To: <20261031162804.1893-1-maciek@machnikowski.net>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 31 Oct 2026 12:12:46 -0700
X-Gm-Features: AclHuK-OpPYwSTlSlojNE59RkkicDzbzvgwnUow5CCaQlqWbb0Qn4Ecbm1sP6rk
Message-ID: <CAHS8izNQzFyDs0mJJP770xWYXppEQHGKN8LJ-HrfD-f3Q_T5bA@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 0/3] Implement PTP support in netdevsim
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com, 
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch, 
	vadim.fedorenko@linux.dev, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 9:56=E2=80=AFAM Maciek Machnikowski
<maciek@machnikowski.net> wrote:
>
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.
>
> It also adds the selftest to verify the hw timestamping functionality
> running over netdevsim.
>

Net-next is closed, so please repost on Nov 9th when it re-opens.

But, more importantly, I'm surprised this relatively small patch doing
something (I think) unobjectionable is on v11. What are you struggling
with? I looked at the diff log and it seems to address only
micro-bugs. What can I help with to accelerate this?

--=20
Thanks,
Mina
