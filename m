Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA936655D
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571567; cv=pass; b=jt9x9/1UK64RQvwW3Fj2Hj0PRkwbw1l5KSnj7r1FOGE+n6T32LRm9WxR7hdGj4rhxFcXvGkb+TBwhg/HCoPE1XhZFUv1Rqdm2cjq18E1VYS1xT65cCUVEfY1PNHrAHZ+oGXH9UUo0DYcHg4/PhjIUr7nxs93X0NlWKbAxBYzwLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571567; c=relaxed/simple;
	bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIfLmFZa0Trw4O5SWKIi6Lqh/bpcY6+Ej75AKGRwsXD71ixW3uVqcWrEQ04dm9AwXcJ4GpW6TrvG5CnlLUwK/Zo/8Y1KDoEATjwTnND/iQAzx/RDFMA8Mcx4zQ/MZotV3rJt8N5ATR2YhJVetKIs3u/KUhN0k9uiJU/HxW34ieY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9rTIKCb; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9rTIKCb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d027b7c8easo6615505ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571565; cv=none;
        d=google.com; s=arc-20260327;
        b=VFh35+aIjI+w+ANmgKD9OAd0M+EcJOsVw6mEjsdt5ZRW9Tqer6/qWIg+uTlvl/9CIa
         VjcKM3GOxf80rug/0UAM0HV0luvDKFR+5OhW5+PRzK/uwkj72OMexhKm8lBZaIcXZoTI
         Hg27Vo5sXfOsvS6hkQcAYodXrCvLCQ1YYmdQaUpv8zc57CVVXiDY74AO/JBEhM0w/9LO
         Ek0dEWbY1aeWZkPkwN6IBq5Y8fRCUHyDO36zE4UQGzzW473YPds9yVpFve+sEJR3IdaT
         oqi3tsvQ7kWGK8GsNNFa/fAkchK0AgVj5oa6CP+TQRS05/eJKjZsXRtCSxk5r4uwZj92
         3dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        fh=gBqePr0/Y9vQh202Mr2/5hXAUD/OqbC7Vs0j+/WYt+I=;
        b=rqby2sbpJ7P/IwKxjDmn1qOxTWUg/0qbsCqad0PTFqZysOY/wQqB4yRaGfX1+3FavX
         GuJvImNJrPzRQ6z5bYbdFbmKcAufd8NWT1r2UQ3uHb47YLbxUG0TV2+nQmEleLJh3c73
         m7mj5l5hyLakNdP9+9BgqMuERkZLb8KAb5uTEBIyZY4FHqaZ0vD3HppTdD9eatGFp8Hl
         5V2GnTC6Ay93Jj7monEuKvZTcj3bxkBWnt6iovYHxGoCY2KEl+bt94UnJd2Lx9h7d8Zm
         25RuaCRkJrQZvLFXWe0U558sLD2fqiZCU4sBzeBQd8V3zA8fYYi9LJNXDxT7cSug41VD
         +aew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571565; x=1788176365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        b=E9rTIKCbiUja8Rm2ds9mmHC6jiJmoLXzhHNYSY9fKwC5g3aRjhjgMIWxtn7h5mtSSB
         7u/O+yPrlJatNt7z9Vs0wPLACBxR1vUMWf04AXN3GM5Smk8oiw8IMz4r5CNiDf56sBdG
         2UTgOMXih+MvJffWJ6rpVokQRVDk/C13WCKS75gY9P5s7sY3VwJTHzUUbaLtQQEQvpEh
         OnYDcxT9xPl7Dn8yXyaYpqVmeHzymUSClV6xksSPzCIlvEpBMS19olb45fqrGdvvlwJY
         JvWGf/8enAqjCofCbsYtdZEezgmtUi/fPa3biGUUOu9QB2szjBuCFkkKqlUZrGn9kH4T
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571565; x=1788176365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IyHVcCjbrLsnikGSohgZ0HEcX226iRTLlWG+U7qEqvg=;
        b=bvM7hV+MYgoyTmSOKQRfy6S1CTviH4Gi+TMYeFea8tDJsj+WEtxEu1xn7skPLd0fYZ
         0gMe4SdD0uQmXtDAH7OAdzN06dAaaW6t0ubKnBBzgVoGMJkZyaDd75kEuYlEvcU74rzt
         VO7h+B+9lV6nOLqnON65HHNQywXCz23KZLC7L0+ni3miO3+Cktb52T6BJIIzicaxXzgP
         IyrXO3x5VKzohMHRi2U5JNHmyEYR/JEn0zk4SSIWK2I/0EmWkjpvTj15UdLvpFrKTn03
         W9wXbtwurHTA45PGZ2ddtpdqQ157ty2HurIms5FhqhVub4wTnb2pyuPON3vJ3p4DVQCT
         YNkQ==
X-Forwarded-Encrypted: i=1; AHgh+Roxi43ChLDWhKippUKgu1T8X73eLJ6qSp+Q8o1GEogeSt59grE+lanNGlyhm19Jqkaketq/+9o=@vger.kernel.org
X-Gm-Message-State: AFuF++l8pnfexJWt3I8h8oGNXIkYHIcFSD1xVmjdngP02Mm+CA2l8SRI
	lu7wND/MCeocLtp6QSY4xwPq43BLuWH8cpydUMfII5OvpfNt5nC5/Q0DAy8s9V1L/VPWkwfWlki
	kgSDQFQOyTMCVUb/YIHYeYFdJPdw/T/8=
X-Gm-Gg: AR+sD11xuCNjo8nZWXjun/7wkC1s+ZD1bPGc9yU0X7q+WxNrnKtDM3khFyvE+qg7rJU
	ISxNhLw+Ie/czqCSR8wVa2B9QtZC2P0+VWswd55e4Ji2ZgJvXd7UGu02RF3RL4dD3rV8oyQK2/g
	1lsFUAcko01eClRmzynX7EhRchrBR9nu34SRdOq5UoOf5Dc93/NTDikzVj1S6EojHt7sUD94lRK
	Hq27ivzO1Zu9ahIpbG53V/Hz7ewJ82z/3jx4VIkkCvLbvI6y4VDZ1zNAhS4B5qt4OD1SXO6jg1J
	vGx5Gm8Jzp1OL378aGnUv5ga9Jd/mXXmWJ4ZG+CiUj1Rs0u5jRwXH0GX2/qiuHQkneF8WKTyb+G
	OR09ks7vZvzWU1WYn/lnB4VDJccYknHpzpf09Hw9q2+aew49uD8ROrl3GXKDvHg==
X-Received: by 2002:a17:902:f709:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d64b047823mr241046625ad.2.1787571565146; Mon, 24 Aug 2026
 04:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn>
In-Reply-To: <20260824111227.742645-1-springbreeze@stu.pku.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:39:10 +0200
X-Gm-Features: AcwNN1V9wg3yKVAh9_mN_zlYKlheXes7kkLSKf2mSnLOgXogC2B09BSq1Bgm5ns
Message-ID: <CANiq72nArSN90SWmPiKxYvnQUxuebJ-W8OiYqXmq2SZEfJnGGg@mail.gmail.com>
Subject: Re: [PATCH net v2] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Chunfeng Song <springbreeze@stu.pku.edu.cn>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	fujita.tomonori@gmail.com, ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:12=E2=80=AFPM Chunfeng Song
<springbreeze@stu.pku.edu.cn> wrote:
>
> Link: https://lore.kernel.org/netdev/20231123050412.1012252-1-fujita.tomo=
nori@gmail.com/ # v8 cover letter
> Link: https://lore.kernel.org/rust-for-linux/20260823103644.342849-1-spri=
ngbreeze@stu.pku.edu.cn/ # v1

Not sure why the cover letter is linked (if there is a good reason,
please keep it), but at least for the second line above: we don't
usually link to previous versions within the commit message unless
there is a good reason.

i.e. if it is just for changelog purposes (which is good!), then it
should be placed alongside the changelog between versions after the
`---` line.

I hope that clarifies!

Cheers,
Miguel
