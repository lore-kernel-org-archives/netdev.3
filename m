Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614890;
	b=mvr0/T/vjlY0mRt3f+PG4/EU5e2pjfuapNH3/XTx0g988yOt3EU2Qrta88j5+3vsqG4Y
	 Dy9twvPvqG8kWqN/4c4yoAJBHkrTigehVkcm+OhaWm7489gRXzQxeOsvkcNNOU4M5SB49
	 kzbgbyYZA4+bPk+fr2RfuWu6DWWToD08UNbyLAiGEJO6yBw6hwlwlCyJJ/kiz7RxiNO1m
	 qq2fl9Rtaum2ZvF6jLn4ChqQ7Ia8Jn99/WmNJECFBw+minSK5AexEPNyIoHNdCCkFt150
	 yGliXwajac7BymuoCn1wDdanFwMLgXn/NKykLdQZtYCBqGcSHcSCmRCD14NjnusHHzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aOt0sq+pZmAyDkEBIzNG9M6J27CczFky8001bhUJucs=;
	b=1YQ8FYE1WF/rD5euaGIKcujtYwB/AcgYbwnFuxXDLfp8kTKpqqNBk0XOOWLcxe5KEExS
	 TcBKXp3de/w3lNb4qBhudCbERcf0X6JvyWdSvIdYEwzog4LovnQ/rvU91KHNMrFkmhAXO
	 8UbDW0wlZhyIFgX39/wGxii+MjY+A+23+OApBa3QpHuczfP9ww3k2VFMgUppOxUXRSC2u
	 A6tHlUE2ukRPAdhscn4zBUEQL85TU/blVMrlpVfpQAhYhBCa3Kc8aR3PxmGcmBPkXWYgT
	 u08BhW1wQdR7aJN7uC6GYNsyExkgvnX3tPkVBsof1bPET0BgKtDuhFHlaNj+TcxQYFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gM2UNi47;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF575606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF575606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gM2UNi47
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f55a53898cso1520415b6e.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793614889; cv=none;
        d=google.com; s=arc-20260327;
        b=gCy+Px48A6GnJhPgJcjhjTyDrRf9H24D4T9gDkO6iYbLz0Fba+E/NX9t/qIeP+53wT
         paegNN3JcaK3SlySMXfm0iO/CwICktFTbGE4rpuljTkWRq74lSYCMG7/71AEkIA+IR++
         ZNRI+2vdQNC5rjAxW0Px+mVYUAU3s8tMSJnw5dA9xWUSF1R7v3LQK5QU3oYlC4jI97HR
         NTaLs+0P7GvO+y6YmontJ4MlQd5w/fCPZqH3roI0Io8FAslXWNRgIG7c6U9E0f9+Epj5
         maj3b9+HzDGOque225N/7il+cjd/3o53Va/3EhLm6PWal+FQstptAiaAtnbmGG9SUj/X
         a2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aOt0sq+pZmAyDkEBIzNG9M6J27CczFky8001bhUJucs=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=QHYYfNw1I2rwskKRi3TK9a1Wla598xe6iCaJhvS+tScalwohGYSzYu9ukJ/4pL61gs
         9fSa9uyNJlR2ArZECgJRf/VHhmP6XcSkG7xVpfpZ6FKcgfb9u/QvVThXPd7J3UW7WD22
         o3yVbyy5pmus+2+aY9DNCz18TLTLMZNs7TxBYBdYbyjPQmJhy4vS1QehsP9z9LboFzXh
         soe5l5uQPss+llyaEcaFkw7ttxkkh6kTOmNXdSiZ7w949w5+DGMDYfq7hKO85PNKGdwN
         5PE8mBJAgpYBPU993DPs7EtosSsIp9tPDz1A/ktFDWmWmEvY8UB7jIJycz6Fs7FUvfm0
         9UzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614889; x=1794219689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aOt0sq+pZmAyDkEBIzNG9M6J27CczFky8001bhUJucs=;
        b=gM2UNi47hWHqVFjslloMsktpAOp18sZE8OwAXoH4HiaG/Bf/dmXdPyjSfDpjixgYJh
         OhET1ivRQaCnzycsR/Nw+AJiYgMh/lxWguZXxuYxM8YpbA4YQfyQ7v0llPxFqSRW8vES
         NT2w8+5CdbMnym8LFGf10Hql/7ZtYz1KuNXbG4PnkqJnS8M1uyXjOvdHWEyl9IzzAcMg
         VCAMYBpEwJVisIgSEimY+7dwi6Y8G/LbbWckzJZxDP8R9WKoIe46uWngoEXKK9QUNIUz
         LfTyKePNuCqEc1GoaoKDBlogs9KMKmnCtlkO8vZt5+ab/sN1wa4b+yxX1UD38it/E/ju
         A04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614889; x=1794219689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOt0sq+pZmAyDkEBIzNG9M6J27CczFky8001bhUJucs=;
        b=N8//MHHRZHBDEgteZoTk4+XkTtHjOnsgcbt0OySGohuTRO/x4hkMhlFmUWMByOAHfn
         7anpCHRQ/9msPoJ/AVLzyPwz94oEjbXC7YYgTxkw8fjnJro9S29C/pLjlA8V1WQUG/tA
         2+oRmlM+ysC0f/PLx7u4sxBaAnjmQu8KeAyNLQpYrjX+POpt3ZwhUQtH8dQSRGM80QpD
         3StFEAHR9amVFBgoV0s3nea0ZPbqM5iJypITq+2j6Mn+RQQFjdsApp3AH4JsonnHCusy
         MoXxB0DIhrWAjXAp8X1k9yA7KgQzInUaFfoJsSoZzAonT8qgWHCLTBBLZj7kUiXUJEjc
         65Hw==
X-Gm-Message-State: AFq9FYKk7mj3hAclW9DdR1InGDlNbFI3+PNIB3LQ1smbbxoCG71g70lc
	4Oq2G8DcehT7bOz5w2OGBVlzjKcZG4jgnn8DhJYwrawFR15alrQcDh36/4BZXbhosoGjfVzFkeY
	1LUYRt05Xbpql9+skDWd1AmsBE1Adr/0=
X-Gm-Gg: AYBFou2+8Q+z01KsQj3q2H74OtvCmLxW3G+UdG2JAx9HZIzAhL1T6WUqJIazqn95jGR
	qmXOoxlqzq4CywbTH5N74wxqJe6SWv7wNtxpE+/woRpGv2xRuAtkvOWfBNY6shnE6vI9CI49Xd/
	vvVVmGyyGj3Mk1iYsB1W2DKkc8OYR/RMfSrXQweZERFUaf3dxEwC+p/FuWrtkC6uk5XxpljOo8W
	Xm7tVQdTx7xp77G++97ODTgc4HeTGAhMAF1bWiPnw1HOLys0OBTd/RpIN2yeMc4e8UkHe5nwnBO
	1LG3gYXIL6IDcBwx7N+aOrcOAQDrdIBoNUZlVSO8s56qDT+e4z5TysaH3B2B0KKlUxnaMD0lAnY
	e1YZg0zxfqno1RFhqOZuBybqqrdY8hfACdUu3KSbcRWgqBmtZrODPVhy+YMYMZFdE+VoCov4=
X-Received: by 2002:a05:6808:2388:b0:53c:7298:3598 with SMTP id
 5614622812f47-5640dda1bb1mr6678219b6e.31.1793614888737; Mon, 02 Nov 2026
 02:21:28 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102101125.3523835-1-mmyangfl@gmail.com> <179361442917.3286.13140295265370118734@kernel.org>
In-Reply-To: <179361442917.3286.13140295265370118734@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 2 Nov 2026 18:20:52 +0800
X-Gm-Features: AclHuK9P7nBPkX6lLeAC9VV4ZeQ4ormIESjOoQTN0wRYShi2_dG5oGSmv5ZznC0
Message-ID: <CAAXyoMO5qCcnMeqqHM1CC__FPMnArOadvmCtoAzYT2SDhSJDEQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip reset
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:13=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
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

Reported by sashiko
