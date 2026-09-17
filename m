Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57742381EBB
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669916; cv=pass; b=XzgTxdsaOjSfhjODLQQvKzjszqtB6HAUTwtLaKrSx2M/+sMzyXo/jgmAG8IBHfzoD3lCNljpv0uC2N8PrXRfCls+fornXNnuDxHHxagxURawAxofnJGiDrGQJHfqUf7SB+b3CgvzoFBfOX5lBKAIxNE56g0mKysLZR2VRRMNrTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669916; c=relaxed/simple;
	bh=2x+yw5g0wtGzAHqf9c97xTTZUBeD/+SGjsptoS7GIZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRPh3+PPyLkbdTes5bzTd1KWKU6NYBYSoq6ZGc7juCZM7UYI7fyd8zteUc1HI8A6HAwadogQ2oN3Gy1yLB0V2pn0DG941IDQIwtPio1UwnTQc55Yn2H2jhCCkfPLUibogaxUq1zl38IxQ2K1BfLh/BkVvGu6Fn0jukUFBGhyOoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwgz73I9; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwgz73I9"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so2116129a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789669913; cv=none;
        d=google.com; s=arc-20260327;
        b=Iyeo5OFCWK6EbEo01cc0JadSxob+TFhQPwhJAGth+o2Pcw33IPkI9dR7+ZvJ6y7wOS
         LjJxvYKZtMnGKTE+EOrPhwRWjHcQvO0D2MXdGXCO7w4lRKVSirHk8rkdGi+d9HlROdoM
         XuLOAo5sAEfAYOi26PeQqhvvtM8nJ/tY1IYWu1W19oMo73EHd7xMJ/Bd44OA0viOdoKa
         HaNvYKAj1CWmvsI1IdokPqpVphRV64DNqgFUTn2M+5klBdhlgvpiRl3dpfoW6Yi1lmxn
         DlHS2smwM9JKO0dLC6gVbHCrYTnc9tjFeaTyfCnF9Trl/iR0nSUeiolmGoqB2EbdIORd
         3eKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQ+sUmlqhUqn87N4bdeRG5UOUAWagngN3VbfJwHuCGo=;
        fh=Zkj5yckrkwL05HEsuecPUjm5AjWb3FX4rbvgh8QsNuA=;
        b=R1pTQT5lsuvmJgqYl0dtGbMm+myfuNGkf5ugfAynlixoPNYLyLLO+AZmVEAgBWNj6n
         nmVSbFUHdbXsO7XgcNnZ1HsU2IHPR0KWSggCYRUbYHR7/RZt0gccz/E7xqQboV0jdG55
         9CAoo+0BaX8IqbPAIG5mlTOx94Pmv0uofC9mT+zdbKkJptHg3pLdDBAVq6k2pOtMyClK
         /B1JGaz7iuUlebIDlKCLqSdLS+o72fkecVMsvXEi0KgwgBxYwEURKjGmmuP7eo9klZGd
         OBAOSlEAMCsO+Pwo1f5ZK8va1iyXlrA1U3ED4sdOotzbR7ufvAxTEvmliH8zKfQj68Dk
         iz3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789669913; x=1790274713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQ+sUmlqhUqn87N4bdeRG5UOUAWagngN3VbfJwHuCGo=;
        b=kwgz73I9mXpuj3X8GV04n+4GHB6KG+Qbr1cbzQKlSLCh6NXPI2uR08U3373PoVsETh
         MfjfBjqwNt8cPuk/eMFWvsu2x9BTHMB4otTHN45bAEhhYEsL3XP+sB5SVqbgBxcQgOOO
         yGiG+e6VwkEucTJm9BULlmU9mM+GOWZwPinTXikUI4P2V7gv57YULLGYhvkisl8rr1Wy
         Sp3ydZTjWIhg3n7pxC2zigvF/lScVcavtOUA/ACpWqgXOO9d0nDtWk+wJqQD5uZ3RFLP
         Xh8tZ698FtN+rChJu4hWb7la3DGDhp4YGZIoKL5iC2DgKvVAEfSS/Ys7iSvyrQ8npfQu
         iYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789669913; x=1790274713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQ+sUmlqhUqn87N4bdeRG5UOUAWagngN3VbfJwHuCGo=;
        b=VNIbnn/Q9NCbOrZyYXt0evjsNMfx+eaQDuyxviMQmbZh/hPDidzWu5FuG/D4lK9Gcu
         1VlzaS/8BcRlbXzr+o8N+m7PohgfK7pVgfts5jwOzMXrJ1yb2HGU6M1x89Rm8XwdfVro
         Zt6TkHxJuBHWPpwHhnoy3BDznVuaoqToB9rFgPfni+j8f/EABMKoYy0oiF4NmHQ98Jul
         GeyjoQl+QdXHNVZaBxbL5t3TR7bhYRwhD+ltXj68Gz2jhwZlk/wgfEtnU/Te6LP+tnys
         wR7GEKXAnVb7novZZerANf3T6uFmsR+UBAm1obS3f9Mx5OdR80yVM9uR+174cX+fcPbH
         6olQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0vRF7S7zUDVpYP1S6xynZMW20dVaRU5A6dTaSFdJtMmC3wCXbN10PzD7uXXNsEsfpNwWez9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lrqJBSm2mqJsEOSulzWsaFsvDS5YQImppTEKqcQjjTNEPLofsQ
	kSA7eZO2rMDeN4RIldU+Sv6yEfv6KrwCXi2zGDozBqX5Le/SsrOj5W2Fsj0JnTz8qi7yEGvIi2d
	4pqqZkPp7vSvvsV1UeMJdbDMmOOuZUA==
X-Gm-Gg: AYBFou0eIfVOrr72OR+pRNj390joWkW7LmoN82oRiaDO3BRn2wHCHFUYRXGNUfwSyIX
	OeAsU35wUWUVH5QAzFjII3lV7zuXPBY++ABaw4T1PAFPTLVfvCJsSZbA1SUq7PZC4YqlxXrG4AV
	bC0WexaSXTz6aUPtMEOkvFjuzk74Yvm01m/Gwb/Kv2M3V6ULTLguGPBxaEEv5lPs6whX+qXYwQO
	6FtNI4/Ia935aBmZHWUDWY6CmMbHYEZeBNkO7Ad5iePwFSPbm9sGI8FDUcjo/q9r8TdmkmkelyG
	+kv+XWe4ng9PNYWGgwIumzcnCBUr2RswNCtyRlvQDYz5uu5mzroUWk55iItqHS9ITq59kIaXt+u
	1CDJVHLnSs18cuHYrj/icGuxO7UaV0LBU58Tt29V6fyKJQDZDSCj7E9x91/Bt1O9+zPqp
X-Received: by 2002:a05:6402:390a:b0:6a9:aff5:c6d3 with SMTP id
 4fb4d7f45d1cf-6aa2241dc23mr6037165a12.34.1789669913202; Thu, 17 Sep 2026
 11:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914222246.29761-1-mhun512@gmail.com> <b8973293-8132-47d7-be28-972ec87b72d4@lunn.ch>
In-Reply-To: <b8973293-8132-47d7-be28-972ec87b72d4@lunn.ch>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 17 Sep 2026 14:31:40 -0400
X-Gm-Features: AcwNN1V88cYMprNxaAW_uHgP9rlXIsWVzyJMFFKuADNeskCbAvhWgvPcbfZiKaQ
Message-ID: <CAGEsz8Fe9yxLrLBGnQKDU1_GONF9KOEtNRVxY3X2RBfw-WVRwQ@mail.gmail.com>
Subject: Re: [PATCH v2] tg3: clean up PHYLIB resources on probe failure
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

Sorry for the misunderstanding. I will restore the guard only around
tg3_phy_fini() in v3.

Best regards,
Myeonghun Pak

2026=EB=85=84 9=EC=9B=94 15=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 11:37, =
Andrew Lunn <andrew@lunn.ch>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Sep 14, 2026 at 06:22:46PM -0400, Myeonghun Pak wrote:
> > tg3_get_invariants() can register an MDIO bus and connect a PHY for
> > USE_PHYLIB devices. If tg3_init_one() later fails, its common error pat=
h
> > releases the mappings and netdev without undoing those PHYLIB resources=
.
> >
> > Disconnect the PHY and unregister the MDIO bus before the remaining
> > teardown. The existing IS_CONNECTED and MDIOBUS_INITED flags make both
> > helpers safe when initialization only completed partially.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 158d7abdae85 ("tg3: Add mdio bus registration")
> > Assisted-by: OpenAI:GPT-5.6
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Remove the redundant USE_PHYLIB guard; both cleanup helpers already
> >   check their initialization flags, as discussed with Andrew Lunn.
>
> That is not exactly what i said. I pointed out that tg3_mdio_init() is
> not guarded by USE_PHYLIB. tg3_phy_init() is guarded by
> USE_PHYLIB. Generally, you keep code symmetrical, the conditions you
> apply to init should be also applied to fini. However, the existing
> code is not great, tg3_remove_one() is not symmetrical. However, there
> is no reason to make it worse.
>
>
>     Andrew
>
> ---
> pw-bot: cr
>
