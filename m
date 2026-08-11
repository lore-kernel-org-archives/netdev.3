Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A441BA7F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438076; cv=pass; b=j7PavZF0pUzUATOM9/WkAG8+ihbM/J3mu9gyXsSgUu88wsHV4+FIsA7rdcfRhNJJyddaZ/725pDiVe1XuretaePgYz6CslHeNowwnEKSNh8ssI/1hb2o8aJWUWkdN0IhwWLY6ZOihpdZrnDSN+6KPmqv9xA65VGjzidxGcGqbTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438076; c=relaxed/simple;
	bh=cmY7eEyYF6vjOlY8jV55jXYeB+U3K3HiPrbsZtztugU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3lTOvte/D2Wq3GAZwTnRA/uUyVU8FZBnmOxaihAl4naDyOMPaw9I8yZOfc15VApfyJ2CbuXhoalAucBw6/Z1np32A53Nm9VjqMBX8ZsjynKSKeeqhPQKkTK7PdXDj5/Yn594jo48Fk66f0lSTpAJdGHzXEa07kU9ZhEy08bjTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzdmG7lU; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzdmG7lU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52b4e988c77so17498941cf.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786438074; cv=none;
        d=google.com; s=arc-20260327;
        b=AivsGVE5zAwO4AkNF3ALjfNbw5aWWFcmPFwPpTgsg/CuTkAYR9NkEhPwWzoMxXfH4u
         Qyg7Kjd2C4o1ybttucx8cVJ5RYBhcA2RwQWcNsLQYtavcSaLmgk8hI119SAvTgAj0u4e
         yT9LqTwklncWGjzHwx63WKad/Hbejv6RVaObH+pkxznz/teo7w53sxHyRv2svBNmlu8l
         0nYdtT0ceixxsQqjfEk13Svl5e461txcUrAGnf/OkUmesJ7kxWtUtdLKo+IQYX1Sabno
         /huukI59gLsoxshG44bhT5sRrYqGy0ZbijaZj+lFCSjvIppIGtZRZjfLRisbSy1wcrE9
         mUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmY7eEyYF6vjOlY8jV55jXYeB+U3K3HiPrbsZtztugU=;
        fh=DmhdSgjmWwqb7QNGUlQJUdPP6W0kTtMw9/BU/s6tnE8=;
        b=m5tFjgur2fhBjCUoBqUMi/E9sf+IymrUYubBVPcO9oyrb/+QvhFIS4Lhgf3N8Viq+E
         CNupsvUfwBRVdKodwg3nCTtbTnGIifnyZ56RAM6d4wQteOSOPptbkN5qMKT6ZBwPN0on
         LSvbwinBxnVEJJdkb5Yx6d031L5aZroNL1fx03FWGxfS2d4d7rbe0TUDfPRdYa9TOrss
         VdULnV15CiYjuIMS65NJqqWByirL/reBwveVHfQ0g0QaXqEoI9S3uNTLAHW+M2sWIJJq
         8bSml9p66Wv1K3/f1IS1hqhVMYJpu9yidnjM1j60ZsDvGrro2yNqgUGGSuc0LxeILrrg
         OCxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786438074; x=1787042874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cmY7eEyYF6vjOlY8jV55jXYeB+U3K3HiPrbsZtztugU=;
        b=RzdmG7lUqZQVPIg3CnoKkHYYxWa21FlM8p6pyNKA7+GqdCBMx84/ks5pHnL7BCAuqB
         Ix5ER44xDgHBwQU3MNcFM6mXgsBN29AELvFmxu7ePSLiQl5oRPn4KcwlC+BOlvyLypGc
         Sb347OirXGXc65tE6vPNTOu24UQ3QZ+vCqTu5sajJqU7aeJLO0JT6lCx32ENdX167E3D
         bGRC7mtOC1hxSxY6tJxS/HgqSlG5xwPR0d+uRCJN0P9uu9NytxpZ3HeobIb0iWvKP79V
         HN3HY6xCNyXFr155iqW8crbgfACq1CSoef3dszUySpGRLzGMxJ09WnUCDoH1q28Lug6v
         B50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438074; x=1787042874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmY7eEyYF6vjOlY8jV55jXYeB+U3K3HiPrbsZtztugU=;
        b=ACEdz1Kdj2PB11it6eaTOoVeGHNrLJ3oMdUM4A1Vz/Ves0XL1VNDSmtbOi0v4MjqJI
         zU1jDPAKQpch6Fct0XEVQZf9ynH4FZL0Snav5LlcR5D2/QhuFHVyzlmQQLs/5K1xmaHw
         fluohvCcrkTEu7MkiamJk+jeUU2JI/fYLJks2NyFwAsjP/HoX5+erIuAHOR6bBNpphHG
         Xg2ReIKkQX1ZcJZtdZ86DcVN/KFcPNo1a15uDpJ/01KIQ0OBC+sGfFus2s3kGz8AlPDk
         hCtFcsU1ZDd0tg9VzwKmdPwb0LwJVpz5lj1lshp4w9tPEyN1OyMNZ5A1z+LFquP64rny
         NoDA==
X-Forwarded-Encrypted: i=1; AHgh+RoO8htjoKf54OVVq+4mB5L2ZvSl6WMO6eTjzJPm7516yS6Z6D1ZS9+OCyQM5CGWymPBh2OiR4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GYMuVBRUq9Ae6phg45WaCQKa4mZNAfTi9lF/1+2h5hdWV7OL
	+XTIDdZWfHmpcdTi49CJmejcdweckwt/e/98dJgH/HXSwX83uLYCgmuuVh5pwojbeB+HrTWg/VX
	AMHPy4mh8g+lTx0g4n5dmzmPWVF/deup/F1sREhPS
X-Gm-Gg: AR+sD11BvTJOZTv+ofTaz0t5FaTR2oKJNiidmPAyewmd88XnThbgl+Cxj9VDTHbVNJv
	u8AphHtLJTU2zGK4bvAf5cdE743aKIdt/NRiLqiHLc31xKsxzPc5DBmsm9SVKj5JG63LpbvqtFv
	fkmqSJHLj0kyl++XkI/tR0Cz1KYQQ8bYpL6kzVRocl0R/4VYSWeFcUu0MWZIpt3QGCQtxyi477k
	oANALg5l7kFpGWiRhtRpgkJ0O6XRj4C0TpSrvmZIy/7A4agZGgJS0B1aXHA8edigWp6kGDbe3Ug
	0MMMHhOPXLlSR9ZYsTWD2np1kvS2im2+MHAgJWoPXFVzTIYoQvDe24RHG9kfjlSxj1wNpZHqChy
	MfNYP7cmvdyqaw8GPnEn6brnkI0y7fQkOwZ/Yem7em40pdE2Ge8ZAZfsOipIHwvCxobjJj6HTIB
	lCc1jtarolfVhDEQ==
X-Received: by 2002:a05:622a:c12:b0:527:7794:6115 with SMTP id
 d75a77b69052e-52d58624efbmr13532241cf.29.1786438073271; Tue, 11 Aug 2026
 01:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724035419.1473174-1-edumazet@google.com> <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
 <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com>
 <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com> <CANn89iLO_STTESJwU-shGJGZ7BbrFaePb64ePfr=J7bffV4WXA@mail.gmail.com>
 <b00519e7-9c43-4867-baeb-f7ed1303424a@h-partners.com> <CANn89iJWJD_KXpeDOne2ujeznOADV8O=rU5+jdqQF6YMEkNkJg@mail.gmail.com>
 <e857b453-3fda-4457-9c93-9eae376157d5@h-partners.com> <1c4aed7c-b323-4793-93a6-a43a679d8f12@h-partners.com>
 <CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com>
In-Reply-To: <CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Aug 2026 10:47:42 +0200
X-Gm-Features: AUfX_mxb218nKA8tCe3Bpx8zqmhl6F8SrgeHElgWA6gMQSqk5aL8hrYUwWnUhLs
Message-ID: <CANn89iKME_WX7TRgxgJe8PLBNKDqjF-F-8fQ9+3jBcD7hpfCDw@mail.gmail.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:57=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Aug 3, 2026 at 4:37=E2=80=AFAM xietangxin <xietangxin@h-partners.=
com> wrote:
> >
> >
>
> > Hi Eric,
> >
> > Gentle ping on this thread.
> >
> > Just wanted to check if you have time to post the v3 patch,
> > or if there's anything else needed on my end?
>
> I have been on PTO, I will send a series soon. Thanks.

Prereq patches have been merged, I am sending the V3 today.
