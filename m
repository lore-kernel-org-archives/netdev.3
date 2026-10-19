Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F73E4C88
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409741; cv=pass; b=JQboBy6xg7S/hZhGoTi5ysRIC36FVQXAuMjVYKGq4RPkb+/Nur+e0Eq1aFut7nFOjZZqVzuQRFvnk/hEz5aKEdm9wiuiBldcKspeTq0zb2or7Zx9/ZzUK4aVX8ACDAt+VvljGHP9sJqgYNdX+hjmQKAjOwAIwip4b5FX9SF9LzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409741; c=relaxed/simple;
	bh=y392TKxI9NxK+HxZju6721gEDX3uifjte7V1FDxyHUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObBygXtNK6x9RKoaohZxWjML6l8FHFjnjK260P2B93KXFmcEQeitG/VnrHHPdJ5+df4Eudk8b3dygFuTAPTHkQvnn7mbJezjAANK+rC2SnfF3oew2KyuPyZTcmu+Bxjz0auznalsKhPkngvM84QYs5HT6ZSTO5y5J1+YI1ch7qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjnXzv+T; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjnXzv+T"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so21506581fa.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792409738; cv=none;
        d=google.com; s=arc-20260327;
        b=ZTa1WZRvkwopwKiDieHt+pRvLoYcOR8I53DgjuDE8JB4W4bk2p0OPvi8pYVvfw2qLH
         pVknE1BSyzQRB05yws3Gzc02aKyS5I4TJWHFWVK/JpSbe5akOs2I6kLrCCN6JPUtSrW6
         xotW2pGxXccAzc0S0qjJF7iZ1ociWYAEqbq7KbIa+8VS+GV3cSbfriYyVY8yWDSSCRRI
         6JheR6lleazK2roc2RsNoIdohneXVmmznMV2QIt0zwz8IkY2KWeTt81QDSO3B8zveIlb
         XdJxa0DtAN9jfCpGKiy0lH6GReixPuGTx5NS4QVMuMu2JlDZoEzavGwj99Vm05v6aNkE
         q/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=koS0XoT+3CWL8eMG9x4Bhcq/7nCXU3LWxtlSg2MxqiU=;
        fh=U4aBjwiHjxm3RJbbm5PoAJlihfPyyI+nAV97Om2b+aI=;
        b=ToU0sUZEl6h8L+A09tpJZCrlpfvTG1a4TladQ+HeLS0ERiBbeQcQRSZIIQRnZqUhLW
         XLX0VtmPYwhhCMCzbZkz9TpfDDCshXVG3BtoXMX36IfVWoyhcORxRhzdQ142gfirBkYF
         Svu/6I6+0W+PArKZDlWeFdOaFGs5KY+fKhY8YW/hrQU2nKQXQPoSL2rhS5nCwPWCLcsA
         S0Kt3SqEg1fxL++m5W0tnP+t7ml0jUmbl1fOB83g0sCSjwIAKmuzOz4FipXNVgOgtDSr
         kDTkuvdtYW2HxyJIWAJpvEqXsHk4S70aeDAN2iBaIdk6B8tqdPE4gskkLWRlkI41V3uJ
         v6zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792409738; x=1793014538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koS0XoT+3CWL8eMG9x4Bhcq/7nCXU3LWxtlSg2MxqiU=;
        b=bjnXzv+TBUQuypXXr0s8Nh4syaUK6AQxcOxTbgcpzk7eY4BtTmAcds4PU7QzhjgPqT
         Oq5R+pnwdzNJZVd7xKhnflqX0RQkJXppWnZtyvfxYY91IEz3iYhH9BM8/Dxn+RhKEJnT
         E1f4AO4RVLsdQJotpERt8Md6niem22wiuEtBwnmVmvRFMmkDtTzELzSjB4TjOJ4KMeB+
         88yViLIXuTh+6wvB+ba97qNcppNg8zaojFswZ2cXu+gSZdpXBDYe51JjzdzOrQgSfpkQ
         gTt6mrC23J5SYBP8QEol9BHPA6JBaQWK4fxODLsfR5b8r6omutWNtP6Vdq+tPLWCZ3RC
         7Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409738; x=1793014538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koS0XoT+3CWL8eMG9x4Bhcq/7nCXU3LWxtlSg2MxqiU=;
        b=z312Ory8o+SqU4Dz1Ynkhur1EZeAxUanaLq/6QWcBngdZ0WJ2Jr+Dsj6oi4kPnTS/z
         4+KSHh1+vzUAIJCg0IDQklAaUCZF15sf/j7G4fxf4zo8KRXAlshLKiiOUYkfWeyUHI0z
         1jXG+RXJ1nCV4wndsd8FLdIDX5lFJlMAYZdnm3Mqw88/o/vWLxbhFzk1Zmhqz27ouehc
         iv2hSH0e8mIuNCgAbzoogq4Tv36xaVMX1jftUecmT45xElCdyJGjkmn5x51DRBGhdVvP
         yJRLOQg930YddPwsA6wc3+4QVaLs7ttb2S4EC9QlFwwXo9gwXHJdiTalfXwHtzRdbzM6
         tHGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsJih3TwX8WHZSe2bW6NVVwMqFtVPQQbrwEX/odEMFtvRtTa0dbDYncfCY5w92d2eWMVJTfjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkbYqMmE1JbBKPUknEOFO2jjhmRDaLx70WbTjP04sItlbC/mPt
	EXepjIYv8Ixl/mbBbzA49o4AqxgiYYQYTAIbm+TFSQL89iOgpVvD0/TrxCDuMMfXk8fLOuUw4fP
	uzTxZvCGTFnXyifQunJoaenzKBdiSlQY=
X-Gm-Gg: AYBFou2SFX4XOijuNHyltWD/lZftxy2WB0CssMtrUFYAvxy5CJF2XEWkR6xE4nMraQt
	mkonDtv4Tg1Yc/l6fuSv9KdLcf8MJmik/q410TJkl62hrFwviOIDn7N3a5GoYAr+Xp3cyMqhpRX
	ZLAFXL1emKkmcYtnBpGFuCWGT3M/GMO11u/BpwqxfbV+GLuT5oIW1PYP9MSIL33YetWQQrKk6Cn
	UdMqcVPx9iVIabTdLLCZ6iOcWrygQ76INV48umuGDEIYGwOiIO2TpKFp0cJLih9zn+qZrj5qGA8
	idU7R3E5dgqOh4syKjmgqCZ7idn/HCfs4ylHvphP+AGZXkseDpIc5lLdP61pvDOPMa7Vemi14Mz
	+uRX5DPH4TVw=
X-Received: by 2002:a05:6512:10c9:b0:5b8:f3b2:429b with SMTP id
 2adb3069b0e04-5be50a96f8amr2627956e87.52.1792409738088; Mon, 19 Oct 2026
 04:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012011707.3378-4-sigefriedhyy@gmail.com> <179185709988.434549.15422498299449004512@kernel.org>
 <CA+7S2v+LHUWXQMD-cYPEzT5-f3Qhw_vz+LEssQH_A_oqDKtnnA@mail.gmail.com> <8dcd9564-e9a3-4b00-93b8-3cb023d68047@redhat.com>
In-Reply-To: <8dcd9564-e9a3-4b00-93b8-3cb023d68047@redhat.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Mon, 19 Oct 2026 20:35:27 +0900
X-Gm-Features: AclHuK9hdAIJx_qrpjOoKdOt12iq2yhV7pVdW2_mKKi8adHB_hqpyRSgWNesDcc
Message-ID: <CA+7S2v+rWYvz9xKPEeM6=3HPz3o7TbX2uRfRKk95f9Y60HnEiA@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/6] net: add a generation counter for
 dev->mc changes
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, ajay.kathat@microchip.com, 
	aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, 
	claudiu.beznea@tuxon.dev, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, johannes@sipsolutions.net, 
	kees@kernel.org, kory.maincent@bootlin.com, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, sd@queasysnail.net, 
	shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	vadim.fedorenko@linux.dev, willemb@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> I agree this is not a blocker, but I think it would be nice if you could
> follow-up on this one.
>
> The solution proposed by the LLM LGTM.
>
> Same here.
>
> Also, still speaking of possible follow-up,  I think it would be nice if
> you could change the addr list lifecycle to RCU (no idea of how much
> complex would be that).
>

Thanks for the review. Since we're already at v12 I'd rather not respin
just for these, but I agree both are worth fixing, so I'll handle them as
follow ups.

The first one is a simple fix, so if v13 ends up being needed
for other reasons I'll fold it in there, otherwise I'll send it as a
separate patch.

The RCU conversion needs more thought and will probably
cause quite a bit of churn, so I'll try it if there's a v13, and if it
gets too messy. I'll post it separately later.

Thanks,
Yuyang
