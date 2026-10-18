Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC7345725
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365843; cv=pass; b=n8H8O7Sd4Lv+ZweI66o7Xu4SQNO2OV4Cks8kyv0/Ubv/X3pK8rmSgrEwneIcznlitqxM6GXel07L8apJSDuM2LJJCiYt+aN4OtWMhTac+FdQ+9ObE/GsxhgWDvMpWAgsg2b9j2UzJrIQKVtf+du7AveAonFopRb3/bTrkIqcNyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365843; c=relaxed/simple;
	bh=KShYi/fVTCBKlya3MspTCdR63OOWBWaD8wBUta4wq2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISyACcNXENLK/Q+I31QCGh1WjR9h322XLZ1MbiWJWkqAlD0P7zdZxE4PHXFKncP5x7Mo9IFuwpvcgXP62Quyx+KHagQzC1NxDXpUS1ZBmJXyyvKQYpXXihSASR16nhE+Ifg+Klqx9X3TIZvHCxFiVO4rrk0+VVWOHZnoIngEhww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APplhDZk; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APplhDZk"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c418e215671so176061366b.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792365840; cv=none;
        d=google.com; s=arc-20260327;
        b=PBDS9x1H5vEUmnEqdUQmpXhemJhTjkfFnGCSxObjssA5cVHyDJFr4NS799hLCOf1Bb
         AP5pcAR8DQOyFCO5VDqkYxtLEUDTLrPN5/eB7Ix8jM2+h9PYy5hcDn029kFTuHuxvnGQ
         8XMHSqkJQ/KMtT5vWk/Lwm/ouAZWktn/fBO4n4fD8zbeweNrGuLy7qExlwJw1WWW/7hn
         8p54KElnYO6MdyBJyHP5v/CsKqhZZtK0urzaenCaDFL7LuG9aSRpKSfPJb+xRkFakFKu
         LYFtdACcA8ss7W3cCzpreSx2M/rvBkOWDjHHj1xXrYWxyfUXT1EuWHTb24AN3xYYTD/t
         aiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/y5Ibz7qqr2/Gn8YzXISVGzkygivhG6/sV2wNe5WmBg=;
        fh=BahDePRU/WkCF12JBChKVJRYsnchdUMY75iI7qrUROE=;
        b=XD1YG+U2fiIWSXutNO1ayIZLTeJyDlJalcTD88iNP9rtHAqpu8rGjUmsNI9M1c+K9f
         DAsySCPxNCxzFqbMfkjlyxOym0Bw1FH8sidvtFwMRtaW5XyYq99Z1x5lQp+8sNpk23rR
         +Xu1/EdG+37uKJADd6ssExVFvWT79mVYHFKw6GNi8/3lV8bSJvW2tCK6pchD6+Kekpam
         lzvH5gZVwQfwRjRtbOQ83A/Gp6afhSt2bVslwVvDZrA1ftYbuOdOEv2sPtIc0CK4Sath
         k1UxVeyvGwLhoHMKFPbd7wXAc4tW9zKFfGveTJMzis1YIMuv+5dv4Q6wfM02do56xnet
         oCyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792365840; x=1792970640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/y5Ibz7qqr2/Gn8YzXISVGzkygivhG6/sV2wNe5WmBg=;
        b=APplhDZk6qkbaqfQMmY9eNroeCxtaDtrZCBZ/z5o2brtuI8FpfZtg2HKujxuOhesb3
         ZJlFAZagyF4MvoStRG+b4BNqj9OxBRw65AJZyoo5/kYuZn/Qu3+t3m+IcIW3U1M4abLR
         CR9K8Tl26v6XwALKB2P9aiFfCWl4g108Y63oDDtLnDZlwpQxIp2UGMTsNcHe+RTSnt10
         nKKIliHnSIpKc44uOihkm8V6xyoowaH1JDe+kYCxnDEyHb/qdRrJphnBruAw1qTePFho
         Pgg4O2yLvP5X2UjTf/fhs/lSo7oyVWQENOJx8czEaKZRj6i8kioZL2FKHzXIxHWbCtv0
         Jypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365840; x=1792970640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/y5Ibz7qqr2/Gn8YzXISVGzkygivhG6/sV2wNe5WmBg=;
        b=CQKWIkcTlzSTDI9s+bW3bzpMxxRAg17x+pTSeRb0uF4Yx2IP3Z6unfFEqHseV6s8Cy
         4hC9KVbTQWrzPrr0rtmAbxl/v6F1hVeobkB3EQYhUk4ozTxypAx706oUuL5YTYSOA5N7
         a9gZhmDvMNCUGCUpC5RKEX+Y9r5fWl4Ts4bsI6vVA/ZngZnUElfNzTyfqKyJFOHTXf6T
         ZUdQZqjsgnqMfNufcVN2vEEYL1Tnk8ohBLrPKDyj4pkCpKRy3Akl30Mfyf2dByXtTTAd
         Kd47Th1w6Cod9hEZQg7IrSB5+VB/2YyStPn3ZJEq8Yat/ClG7S+IcW4aPLjCquCYJtgj
         kI9Q==
X-Gm-Message-State: AFq9FYLTnjoNRzLAlZSiONqi0qANmOBj2nE8QJGwtEUfmrfUv3IJ+7sE
	086UwVHZ1x7pa/k35DvlF1FCpGFccG8X4NApLcK7xZKmO9MdYqumoL+/WIgkDVZeI64cQMmdgOX
	d4UklU9bShFWO5pi25W3f9mTeYDAWM6c=
X-Gm-Gg: AYBFou3KsQ2EkAtmhxFZULL3Il/YSYAqIS/YJ9x2zraSnMwplCV2BQHjIYJCol1a1IP
	WRQBGKedIqDPC95RbBoDkiDBFtYKLn0D2Sz3ivpTGndzL0sTb5yho/7DA1PHp8XDbXFfceA5dW8
	cxLZE61bOOKjOIpv98D+V3Kp7e3/+5OVLEtVb40GFIRX6oUrDubllXYPagLqvgzzK7OHpMY7ruq
	H0Cu7YeugbU6pf6Phjb2k9AknnlwLiYTYP7Ss96djK/322E6qhHYAiKmDjPC7AWNqgTEBwrO6NP
	WlNcTTuK3ISJyrGYlWQuYUxygxiO/Z7xGsfNIwLQKu0oQzRYIFoCZ5TbF47kEX2/aXleSH7wrbL
	bt3GbDeDp4kI/AJW0C8lu96V/zF9vXZx6R3Tpe/JqNIl+IXd4nGVPQWyVg8sI8/SgfYbzIA9OIe
	z0e52uJ4qKmv6s8PKUg0yj3qLilzt2eZc5j8h8YQ8xZV7JBmrdLOnkPF5co1oCgdcW+hWMp6Ymc
	EpV
X-Received: by 2002:a17:906:ba89:b0:c34:1ed:54d9 with SMTP id
 a640c23a62f3a-c41999720a9mr361332166b.4.1792365839724; Sun, 18 Oct 2026
 16:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018231348.36884-1-rosenp@gmail.com> <179236550812.3290.9443229332836486177@kernel.org>
In-Reply-To: <179236550812.3290.9443229332836486177@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 18 Oct 2026 16:23:48 -0700
X-Gm-Features: AclHuK-ZP5haimlzeCjYliwXiklfpxalvRr6YNlaNSwVnHmT-R9sguD0SlezVBA
Message-ID: <CAKxU2N8rq4bhk-5zAKd3hEWvUh-bfJtntQb9iJ-niZvXgT8rUg@mail.gmail.com>
Subject: Re: [PATCH net] net: bgmac: fix TX DMA unmapping on fragment mapping failure
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 4:18=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
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
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
This was found by an AI review of a related bgmac patch and confirmed by
code inspection. It has not been observed in practice; it requires a
fragment DMA mapping failure. Compile tested only; not tested on
hardware.
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
