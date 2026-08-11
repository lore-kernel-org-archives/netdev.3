Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD4331ED2
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465947; cv=pass; b=JYDa89isknC+dShbSVkkJGBU1rkUHNyRT3tfUD8c+CUlaXPY5xSVofngrAr2IGEpxPhBR4ulkyCYdM3/Madx8ctstRQDzkVbDfGrjqNOwL/OX7/DXty/C09McEBA6bG3B/Ossaon08wiSTlUFceRUJi7qSCbu0ocWfB1SmqehrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465947; c=relaxed/simple;
	bh=mf+KSmcxtgfXYW6Z9QcWxbnUfBBM00iSjX1HIUD9v3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txNDI2N1PHr8uGPHgfemMB+tpPxXGrp6oybKRGZxckWJI+pT5GH+BVlsK0eD+BYPCFI1syJ64Mt58H86IsY+eIBQVhDZFik917WyGo8Eu+hOik3/DrOBduiWVlqe/7nESWKh38so10MFaW9PU1MSIdeT1XNDqMigJYRRcf6PbPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3qVJYhB; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3qVJYhB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso1095435ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465946; cv=none;
        d=google.com; s=arc-20260327;
        b=loukP0HhULP9Wv5XcH6w0Co1/A4zQ6Q6Gxb24Y8f9tTs7GI/IXMnBDMttJw1Ei3Xu6
         37PREckMz3moLLuCyRaRBQMHXuQ2Ob2wyECfQzQXcMIk7zbBc0S4BAhR0AqqNoPaJL9y
         oNNqF405Msqh/NdI3OFJTQ2vIMqqHi8V5P1ZjxaBoQJAKlBht23jYKQeEXSUjXZJGb9d
         dMltuA3J8URjniZOhjQDWYKMYuZkCeuBXHFh+F3rJzBZwmg9GEdBmXT5JxdRIDrIXq3c
         /+mVqwQGU0f0itBAW2O0Nmx9dMmDXOqk16XK4FiM1a6A/9ZLn7eSrjAtWV4W6kzSzGxU
         oObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0cTW1UgpeYqfbodN7bFCdd1XBNTuMUSt3nEktmTyI+w=;
        fh=xuIUr00ZQ80YVGnFjZuc/vC3rTjMH9HKoLE8/cPR2dw=;
        b=UVzjjeKxEsnSdBhgvs70ZLLEQIZan/KMUqGUvnRFZyxRxsfR5NLSaEoSFkAhBY/Fm6
         PMqzoy8xZrFJTGdLSugdQIQ0pcXzpB8xXPr2rNoU/Xu6oXbBXHKGFIK9AWAOIhwOTWMH
         qdcKyyiwGtoqAGTuxJE7s1cxe7LiCgp3oh48mbPdeFTXwfBj4vtYRkj8h9MTLlh6FyYz
         zYIXkKr3jd7vm6GoJQyblqAnnq7WgGgEka4sDagGQIlb7g9YMMN4PxevWyt6/GhLp2yn
         wDsXjDOzdtwTQkanPLoxpJ1eN829g0bqwkJYCzzO4/ok4uP8KY8+a9upct13wi4n9fle
         t8jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786465946; x=1787070746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0cTW1UgpeYqfbodN7bFCdd1XBNTuMUSt3nEktmTyI+w=;
        b=o3qVJYhB9fVqijac8mVLjVe6dYd3f8WsEHpPKv1E80fa85lp84TQeWfhXOQbre8EPe
         haewQzQ1tn16WaytGIP22kemZIjC1c6ZzxrUC1Ta+iyAXksbUIFHomCwtkHmLB/82BJF
         So1l3vJFqv/wJ2F0WpqxGfNSLF+zFTuq4DctcdkmjIXCvI6GLRNd8kW1qIxebH0PzmCY
         JwDqRHymZyoYW90gn5XTCT04inMJ29bDzRCh+mw7hMm4UC8FrsNwpm3VCo37XqeV0aO3
         q8AEQ1JHglhFMeuB8pNM1anazG5CK7nztUtMprcMe+Ra4zlfEVQuEAKniW3/nKWyOSke
         EgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465946; x=1787070746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cTW1UgpeYqfbodN7bFCdd1XBNTuMUSt3nEktmTyI+w=;
        b=Plsa0svIO8wnnZbbP2MxODO3kkQsdCfA54KVbld3JSgDkLOGm/V5XIBvwEVKiwrrHu
         nbrWPZgHJAdV7zeZda2/VLIJ2QxPGTk8IORhIa+iFX0Qwyvv1YGXmrudA0mCQsKaiicT
         ow4OlTDEklcgfmJgEdlOd7HWFFgCCDOAXgteCTzInX7ixN8Fw/eFGcx7k3ixr9T1wv+E
         e5XODVIeggivV/yx8gPVK/YAm+e92EsFftqoApxLYVmboc6l2b63+NWIa8q10vNy6tOH
         RiG9BHpsFc9MtaIFGa/1DJECZuRZEKyPnbBN3aQ3dA3QxkxzEeW2Dva/vr5dOg83Dt6m
         R1ng==
X-Forwarded-Encrypted: i=1; AHgh+RoYaBo2XWyBZ+HrG37xw6LbUOf74Kd/3DQIeq9Ge8/oKUMzQ+w05U3b9k6lWkiRu7oKPcyMSmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5HZFgBGfRBlOQE3Y/Am5cEHznzMFAU2OMTuwCtQmbA6CL7ma
	b7QciWhnIj3w4/gINzIFJQTxOksKNE2t4iaNtXWoZ3MRoXvkItEu5/YxPpGxDoiWMJkx+XrxftX
	mJC7y+2vdg4VyMxnnOje3eAYk9/R4Und8pmBP2XoIZzaJjWGDiuyToTsx1AM=
X-Gm-Gg: AR+sD11WnyPLMnLP0u/y+7egMnUV8YrRkhdw2A6F7nrilXGhghJa8OfbqUR0b6VZ5WH
	P6DX0OK4rkyAY1UVD8/yFpDItKVFl9Adxzh2GJWWuOKOoA+peVDohB4LKpATgkriDaCMT7L2Wli
	BmYBQD9IUVestS91eF8irF4rScKoC7IiCzyyp/QyBCwaBqKJ1ZCwSUCQVTxqQ3UVvOF+wIs1t3G
	I58NWZsLg/8xfJUfkARBDx0Tev83ztVaEXPUHf2ZlNjsn7/9o5bq7tBTVLKUEOkvRYGCiKi+65Q
	Vu0ztyvWn2xvstbMbBDzb0kFEtQ3Rm9bqF8CBxr9kQccOkLTh0w9QamU/lW+FcQFWKRq+gUiJ6K
	oNcjfAxpnnhapObePo0K0C2TLlfNiBfy0cUlQLDt+zhiZWfd4GLteXnUZ2R4jh9qvHNVK7IEV8y
	xKDzW+3smpf+Nn
X-Received: by 2002:a17:90b:1f92:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-392f483bfcbmr1312239a91.14.1786465945349; Tue, 11 Aug 2026
 09:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811022448.116235-9-kuniyu@google.com>
 <ee6e639c-558c-4538-afdb-3ab6c1c3476f@kernel.org> <CAAVpQUATfZAif2brwjaqdWTH_JzKzRjFdZ+Yrj07TrTkcYXQWw@mail.gmail.com>
 <0426ecca-d0e0-4329-b47e-6e281996ea28@kernel.org>
In-Reply-To: <0426ecca-d0e0-4329-b47e-6e281996ea28@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 09:32:12 -0700
X-Gm-Features: AUfX_mwFCF-x0oFV7PHpZ0SW0ywz8hmErYZrkTGrOmTEjA3iMwOjdv3fO1LAcAw
Message-ID: <CAAVpQUAB4y+DrjvAY6PDNnH2Eun2spZFFfYCRT8uXNr0ZGjxcA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 08/15] ipv4: Replace &arp_tbl with arp_table(net).
To: David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Edward Cree <ecree.xilinx@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:25=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/11/26 10:10 AM, Kuniyuki Iwashima wrote:
> > It's still bisectable
>
> After patch 7 (before applying 8 and on), data path and ip neigh show
> both work correctly?

Yes, net->neigh_tables[] still points to the global arp_tbl and nd_tbl
till patch 12.  Patch 7 ~ 9 changes how it's accessed but does not
change what's accessed.
