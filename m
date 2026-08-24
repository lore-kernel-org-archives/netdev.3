Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7643AC0ED
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549618; cv=pass; b=Su/QRMdza/qE3h5Foxj6eKOWsl8J2YEcKtXZwQcHx1zm1bk/6GGjZ4Qqwl/Gm+8q37KAIh6bYu30LldYpjSUDnWt6HLYEXUtOPDmiPjqCkcLwE6xOdrgbJ0S9pNRvzIZ7ZdeUoWTiUkl5fuiWdZrXrLTpo4TxTeKu7q5cPZ7E78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549618; c=relaxed/simple;
	bh=u2pW4wmygR3dXwagq0XV8Bt5dlVjxbvb0kFPeZrpFfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2gv4no7KygtCP2V+Xf4yddWlAAWt4XyhwpMv2oNnwwyZor80MPI1burnp2OLNznXrLxkeievontEUcG56AG0sqBTrp7cTjbq86YAKjtfO70sqzUwMV6H2XAaDrKKP7dGmSl96EdyZJapaMl7GC8mqyERuszFGKmjr4M7xIeFQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLGUhJw5; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLGUhJw5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cedda2ce6fso17633895ad.1
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 22:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787549598; cv=none;
        d=google.com; s=arc-20260327;
        b=N8RkFwKA+xf8qdH+vNMnrsEP8jJNuFXROEDI9S+fHhFrXK9pGveJZhuROR54S46kLg
         W+al1YDASQhWMexcwDQnrfa1OjgDz8D5gUNHsili3u5Ur3rIJQbauZnj1FdmPYFVmIn8
         /Qt0C5UucMiORcK26UnGS98PXtA2J/+dtvebsbr/nkmrNN15Okdf1TLo3UYZnWSosK4c
         QpY0vmOu+jHb5uIuEo/+mYqAd8TxGVmx/0EFFem/Nur/FPqWU+sCUfWOwQv9AxKa00nD
         uOQabljZIRb1YNvYe+eSu/Iy62q/da70xEFALi66fm6iWhMfslXwqr0iJLJ6+eV8UKlA
         /qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZgWPo/d4mM1nv1nI4JvnZPf2X/ppKpeP+qcWytdgVM0=;
        fh=OOsRr6sJhyf1oS8Psz9Ryn8uOUv9f5n5EA5CtcfehCI=;
        b=sBNb83vLMXQkBxBotfQyAkNEWJLVq27/3EA3qQlPbg2yxjPbnEvVpsrxl01nizD3of
         9BjxGs+bv1KJ1EpIP5YQ8VWZkJDw1gNhj58gTyoHJG1IXIFZ4dZxz1PydQWTGlvCisgO
         yo1roy7n0HacZEKZGG/dFgfku206Md2uhDkrOirhd4JefFnM8RqgKMEjpwr+1xXxUtQv
         VBCbIQbXehp2JiPkSOyQCAbGo1XpgpgY/ZEb8vXwjN+A6COt3WTwyYO4vaB9PHrt3Rpr
         ZpABBz/J78tkG0iOk6MDqpKAeI8QuubXo8BCmydIMujBCc5Xa5yTF49vWoDhQ8EA4EU9
         Hhdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787549598; x=1788154398; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgWPo/d4mM1nv1nI4JvnZPf2X/ppKpeP+qcWytdgVM0=;
        b=ZLGUhJw5+c9fF7cFSCNVNH0eZ/bat7iov5i29RHgmJRgLe1IJ5VCUqZUl86q21iElX
         i5VoWMUk9esXh+EPbnOom9KK3tppN+F6GGdWcU+Q4XxEobRTnOE9NA2HdySey9VAnvVA
         aUB1j8cL+3IaTMHNJPGNcIJueT5yqam9bhuQ1joohvhUVEzIEukOCUJpZMrQAH/iOJ5v
         1pyIjDNh9r6vktjM+AuLH8SbbpwxMoBvUgOmchzst8VeRcWYPAxuF2o4y+wzVPe5C9WR
         N8wKQywJp51+aeglVsA1QM+WWxH6xVs9ySCqoyTckUX8impBWIegDyFCelNoRFbre7xh
         t0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549598; x=1788154398;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZgWPo/d4mM1nv1nI4JvnZPf2X/ppKpeP+qcWytdgVM0=;
        b=VP134TkEGsFrOz8vmjC/Wp5CXTJsaaWOEVvblcrhTZZLXXl8TB8bHCZ938hEwQ+Hm+
         Ayi/nATOO515Wly+1DuNe78vF7qBkbvPI1KHo2Fb1mNQSE+1aNzFAmLsfynsPSNRR0H7
         7MeWP/l4yptVpyFUoJAHMmdgWOxjh+Hn0BMx2BxS8vIFAIInvHMH+ajzdfOYHYAodwDT
         6LIYW7S/Br3H5rXywZDujAw+Tlib5P94YLlhxDUxM8jukTLPwWTDKoFuy5I66pUo+Z1y
         +V1oJtZ2kiL29Do+BGjiboj8nINuvgEeRPVtJFzacuhwKbC7VtF5dz/5Xv3uYh3QzluZ
         QegQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqAAlhty2sIBFkcAA0g8SoH1o1Ym70ruyRgPMHEJdi7qwlMABw0hAgHvTHVpeV5ViZoIjazhg=@vger.kernel.org
X-Gm-Message-State: AFuF++mCs7VYhjJ5+3ByN3VckPSR/UPpa/doKDYv1CDxcKE6Hvpm4+3I
	Erbjx+Z57SvpKHNylUxhYq4VXxniVoOh1ruOVty6HJgWViijQx1DnKZRe82/8YM+um2oK48Y0sf
	FJ84kPGDKv5zHfsXdRFWlymRNC57n1sM=
X-Gm-Gg: AR+sD13i5Dwv2wN2FJsWW3kB3N5kqNhcF/ClaauLmx18GhH90rawtmozLRszDZlBL9W
	TWFkdQe7/wXR9M9fXvGfszwreOPZMwDB8KIKY5BfeToBvzNy8EsE9Dh+IS2pfAWVs+DahMgb4r2
	RL91SPu5eSBtQN6GDk+CfVvUIBgmkrOji5cWbN0di833UcLT4M9V2h2kpQoV7GX1+A9wTrCou0n
	K7aCZPqnRZyhs3al80g9NcQns8i74Qvg1ajMvlmat+H9DUEZkno8guHIQ6LCBKVfi/hLoMbIn3q
	0FTY8MQ2/13XX6dtgN/ZclX2ITQBKOwJ6zRUEsHil11nzqbV/HjhbKAovImqkv2L3YVEJBsrZ6J
	AM7wBu6bwIPuZj5/XtgX5YgkmRCRHewHNpzPzQ8roX7NaW44xjQ7tQhU5
X-Received: by 2002:a17:903:2c04:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2d64ae365bcmr463958495ad.7.1787549598357; Sun, 23 Aug 2026
 22:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820111416.97917-1-phucduc.bui@gmail.com> <GV2PR04MB1173976A5DA80B2816493C84788A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFeaLMzk=2_HGvCktZwU7DmNWsHV-vHSBGwbWU8k-TLfg@mail.gmail.com> <GV2PR04MB11739998877A19F8B8A66587788A02@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To: <GV2PR04MB11739998877A19F8B8A66587788A02@GV2PR04MB11739.eurprd04.prod.outlook.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 24 Aug 2026 12:33:06 +0700
X-Gm-Features: AcwNN1WY8iIXJWzCjnoHwJI_F0gxDEnF1n15W42yUutj6_q6MNOAJgV3r2kC6lk
Message-ID: <CAABR9nE-THE0eDv9Shkb8ukL+4Tzh7XAwRndc6iM5Y6DPq2pJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: fec: Propagate PTP initialization errors
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Wei Fang,

Thank you for your feedback.


>
> You should add a separate patch to fix the pre-existing issue, and the
> patch targets to net tree. Patches to net tree are welcome at any time.
> And you need to add the target tree in the subject so that netdev
> maintainers know which git tree the patch should be applied to. For
> example:
>     [PATCH net]        -> net tree
>     [PATCH net-next]    -> net-next tree
>

Thanks for the clarification.
I will split this into two separate patches: one for the main issue
addressed by
the current series, which I will send to net-next after August 31, and another
patch to fix the pre-existing issue, with a Fixes tag, which I will
send to net soon.

Best regards,
Phuc
