Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818F370D61
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261235; cv=pass; b=rI3iaeqREglvYT8YSagjXBnh2vFIubtFpFATXv7ZGYSLih6HQ81OdYhcmENIRFyr5DC2NB+lbKakAlb4HVU4Ipc2E3Qbm/5EKnwNz+aQZVMIXGj4tHDoJVPzXM/QpewyhYq4T5Domoq5dEyy1UhKYF03rrLQyDFNiUzZsMzHlec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261235; c=relaxed/simple;
	bh=iosePCC775N3ne4xUx96Xnhx54wV//EdhymcJwRKPKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSjE6UneYSiWWxoiPSePs5xQyc9oNavi+FDDiKiATF1eSAo2TuACdK3mDQnlChAD/6vAtjs78rkTkNp6UWC2A/lTwbT6s+vk+VUfKsBqofiRD3zPmOtH12bXOvI668H98yyG8wiVSG/aArXj9lEO6LeRNM9U9O/5DakrC1aIvaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgdjWjTM; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgdjWjTM"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so457731241.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261233; cv=none;
        d=google.com; s=arc-20260327;
        b=Vf1BQF90sDtemrH8n/BMl5W/p+rfyX33S0FC57umQHwg9RlU9TwKWTbSiO9uZBVSod
         zKVVB/T4Zpjh6ctfnOVfmitaekhRjv10Sa12CsZUtyvqCLv0xq6DB2Zap+SpGPKXIROD
         KabHBKiN6F9BXW8q+iivGL6SOhupBM10TuvjEo+fu1o6VfVbngKl4+04t0NtqoWnAgut
         adj7mS3jWchENuW+nxyH0C3Wiwy6PKWsNAdau+pI/KGlgUjuPcbU6VUB2mMaeLsY3r+U
         Bu2Fer3jO452bn9tppUL3eQrutLqap0ZifcOWNKI16DVg2wAnvzxfomrEhedcBMhTaxj
         27dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1UnSY1pMfytkclFL9S7Wbx4/5qWTLUFOLzTIY/CjLc=;
        fh=s/AznrQb48SQoJG4QMGDOr/7Ht3TES3eoDtXbdeWytA=;
        b=isWvWE6sCV5o1p7Q3McfRcmoAJZYeOd8GR0k6iqY+5mwodIaplFX8Ny8Ozz0Zzby46
         ZpDsuZG0ZlNprH3waGFCtM5sQnLsM6LG36iiEox7sUQDrEmfUITvVww7xmcWnMTrsKjC
         2IUC6ymO4eJ/skKIhtcJhWc64mo4BVCiB3eGhDi8kVt3Fp/tz9tb23VhiJMFnmrIb2fZ
         6u0F8AeDXTNxJ7sqJVWAt3+Xy6RJqscxcvb0DegBKpBPCx3a/Sduzn4nD6IkZ5oDjkR/
         Vm8gtQ7B/W+fM4RklfQRjMs10ezQVNPffdJVWVrk/Hw/ETGEAgaxizyDEwTOFfSGgB6+
         j/DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261233; x=1791866033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1UnSY1pMfytkclFL9S7Wbx4/5qWTLUFOLzTIY/CjLc=;
        b=YgdjWjTMo8VB1fP6OxHr9jBFEat8DI/aPpwrKYpglri05jbxwAnh+o5L4gWhsSx6tK
         +FY2xfIOt10ZrA7fxvRGs2bSbiSRw6N/KIUEhmIIEuSQ8raRUv2aAFxsIBfF3piqtaBq
         H3DV+MTdn4tNhtm+OgFaH8PzEuv16YF7RZbz0qnbUMwnsHyCf0GVsFJLgV059F8Egydh
         KE30XZ3hxoTUtmUu2h+jPw1s5rXRk2C6QF0fO4M1pmWaF1y0wRDv97zaeq4HHfYJ1yGO
         Rbad80NaNl0MLtVnQCZs5MG10BhWR1/CakrzDftH65kB9ha8HFj/D9tu+juKg9916iQV
         +x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261233; x=1791866033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1UnSY1pMfytkclFL9S7Wbx4/5qWTLUFOLzTIY/CjLc=;
        b=sc1kQ6jCyRnV1oUDdGvoq9TySxpW6ylS1ziogWeMz7J8yg3WO/i0TxWqjBHXi7sRbm
         lkWeY4+gIMjGXelYNaESpH1RKUBzQP5s3oV1yuCS9X2OJI1KwM6EL2TIvercNJ9h0SCv
         3ttxZX+JOEhNkiOhig/+xruaOVs9CznXmRLs4JbPSxQgCeZ0g1HrKInCHucKqp166KMp
         Tq/HNg9BKI+9+bV+U5f70UpMSzRJM5vLQiiBD39Uw9Vr6HC8FLPMnQC0n8Cdu4Cx7dmZ
         l8waKewhng7YA7OihZsVt6aRH8S5Ck9kNKKcGQ1rkznBH7nn05BXJfAgLL57BfnYudf4
         N0tQ==
X-Gm-Message-State: AFq9FYJ/uIBMEZPJvCn45iOc9oKNClqL6SQMCnXapfLXRf8MD/jwiGJd
	ONYvMs75aNoCQxOC3PevC/whYvjhp4iEnQUodriQXMxluhCWLouuuiuEJdMDpdIMogBwanK98+d
	4zMKRhSh8Kmmgo9Hz/NPRa88CMsRxpd0=
X-Gm-Gg: AYBFou1gKhDDKajtM8pU/c5guDi6Z/X/aRsNcUDxhJ3eIK3G3yOhuNtxm6aLmSKdOJZ
	l/RuPtTUZMSt9EATzc97xQp1zY1vvBrKpw+nMuePvXPG5XcMJRoL9bGo1Htl3wIQTM32AlRd1p0
	1+dWDiGEXkRT7+PbXmS0mniHFjIM3W9INOaQUGJ5kf8PIeB6Ml1U+zHo2MxXNJMShWel18aOQVv
	mG7ZQC6s5OGzlpY89S76C9RY0W13EwyzJlf97muQLISY9pngVJgKZqvOHFePKuWSRVz+l/ziJJG
	LqD4maI3GOX1CZc3+QdJgH00njBgFbDZkn+aInqKvpJQAb/Q05fcUijqyKkmgcy2Nsa4Izhhge6
	4k305HKUn7mw+E+lZaWtkVYRJd4nSRZSMqaHvQI2JyGzoAIqtND6tf6pJ9g4ChlBPqBwpK0FLJJ
	CEILZXOetTS9N6dbV37DI/JVwhu8H4IL+GznvfaHM13dNM
X-Received: by 2002:a05:6102:41a4:b0:7b2:508e:3d40 with SMTP id
 ada2fe7eead31-7c244b9b1d6mr2226954137.15.1791261232672; Mon, 05 Oct 2026
 21:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com> <179082917987.31693.16306963663623790870@kernel.org>
In-Reply-To: <179082917987.31693.16306963663623790870@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:33:41 -0600
X-Gm-Features: AclHuK82V5DkOUCqaUhJZE59pODmUlafKc3ZXKL-nCUbjbXn78J9QhKq5piIljM
Message-ID: <CADvTj4p8u0A-6hZ1Z231Z5usg5v8riBHtmskz_ozgO4ZrP36jw@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:33=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found during fault-injection testing of live XDP reopening while working
on the larger stmmac MTU/resume recovery series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Yes. A failed safety IRQ request produced a "Trying to free already-free
IRQ" warning and left the WoL handler registered.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

The reproducer used QEMU with the real driver and IRQ allocator, but
mocked MAC/DMA operations.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
