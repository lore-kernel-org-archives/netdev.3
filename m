Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B03F7A87
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084500; cv=none; b=LEMfcwemzKyw3FsRCmBvU/BQOov/aoGCwtsfe83bu0w21TgFpsKor/4MEXA+lnkVlcQ2XqyjIK/85AfNHsgwK4m/V98v3mLm1CLdeBohCXB0z1mX74N1/05v5coDRegg52S08tiTEEBNw1Kc8NY5S3BCL5Saw1kOqSi0Z+fraGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084500; c=relaxed/simple;
	bh=xq0ncLQqbBgMKmiqv0iCAyodq62iUAP3pn+orp6uLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTGRyUdx3ColnGqj1uurzJcU9lFZKW9u9KZuXSt4kC/Xrmaz1tdsB0wZuYs3LrXk1B6yOeleU/Ap/dmJ4R4KKZsAcD44C8rLO1a6TR5h2mOaIkeATmgT8zomzgaDt9atY1CLYDZUctpyPU2h3Z+EV/Ictpw9Pit/oDuQa36KYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTHr2St8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTHr2St8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so42476065e9.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084497; x=1778689297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRMNJQwpy4JLabii5FgqNhMAFtCk786EvStmSIccUWs=;
        b=mTHr2St8Br0Kfq1WYhl35C20KtE4sj7z1HFpFiD7uXDI34QiKIwNcf4yhReyWPagT+
         a31KLi6Mr8yAdJeSV8rUfaGAWRCeEIv+0xoUupIHKRSK8EfHiur5nDua3rM5vogDUzQs
         DjKg/XBvxacZYQsUDfYuOhfIgPPGCNQX3VjNrGhBSszI2mv/7nngQ5DG+KxgBddb4PJ/
         GdxsZ6ItB8J7ie4spA0aJyq5mQpxhsE1lKMf32EYtFgkVENR2yPQh8lgfp9ZmpKsTe/s
         OAmkFTHiUqTLTHUf1/5Am6VeV5RbnOydb+G/P5mwx/gAosCSzuTKQ0U9OjmERe2K/RX/
         /mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084497; x=1778689297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRMNJQwpy4JLabii5FgqNhMAFtCk786EvStmSIccUWs=;
        b=phNzMqQ42Uz40WSDEGp8mm29qt1eTGvkocBoPuDmsgvdcX133RCLOR9dm91o6vXOEC
         L3MPsRKNYsrEpbXsxVAwVAMMJA+utonMBgoX5LvaMyDrXUpF2avaviBa2cVWU5dUgUQM
         226VYsz2pglUjYVeCu3fL58GhYacD3blMgpo6CQ90UlnI/a6qxVSJ0eTaqmKJ0xmBoUX
         Hnck7HNu6KCvXbVeTxLX0VCWQlHDbKZqMN7k9Tv6JpDsx+SrP6/uDq2L5WeXZyDMbAG4
         IcOwwYKDt4oC6mMIICgQnZYWafJkaYWZ+4R8HzyCg3mHXVHFZgiZcVRpKA5amIVPW6s/
         /wLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NOrU1SjA2fN8KLTy+JEF1FPw/youjcgwcVVpudeQRQfCiLl78R2EjiXBqVfV1cAdBVOQ/Aqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw812fwGoNHWeA+sUAFqLyuSp/SK2VX9Zm2N7eugeQ+wS8AezEP
	hCKPGV2XRPVQo5dZfvFLsFTRKRybka9QfCz5RTFREEeBCbImxceuZ1HK
X-Gm-Gg: AeBDietw4hrLffv+QzCv7iamqtth+FMQHDi+DUR1YxXuJZCS1vyTgqjeiJw+6hYZily
	nMcogkwkHNFOIJXS0Ivb6os12oDoRTyjVrGSy9dU8SeTpsQC+08TLg/cEUYgo0cgO/o0jEN5ElP
	YObqL7S86JSr9kDXXfFzoYSdAjKFClvIbQYi0SXtswiD41S0CCGMT1ENEIseSEuREWrXa68jgvW
	VMftuaRz7SGdBaxv9nSFJoZWXJcYqwwqZO5mCQ7drUAlw1TpkJHAGKK3xeZth0MDNwKbBs0h0+i
	/gSQkDgdQMMN13QhsxE8d6CGoe12QKioPfC6upzujd53kWsIkhr0zm2JuqnseizLzx7YsgNW03t
	5mwR2WoWIahFPuvmUm5zte7etKbh3v2eEQkqUIU5G1bnhRLzBOvNHtpSzce0ou5Qz4V+cs3ZBdu
	X0oH0GQWIm8NxjBnw9BR/fqYMF0FCWnWykLJA=
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48e51e097fcmr71523485e9.3.1778084496987;
        Wed, 06 May 2026 09:21:36 -0700 (PDT)
Received: from gmail.com ([51.154.251.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505285e765sm13179992f8f.10.2026.05.06.09.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:36 -0700 (PDT)
Date: Wed, 6 May 2026 16:21:34 +0000
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Joshua Washington <joshwash@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	John Fraker <jfraker@google.com>, Matt Olson <maolson@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gve: Use generic power management
Message-ID: <aftqjk7YOQJGh0e3@gmail.com>
References: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
 <CAEAWyHf3x=sCefMKkUvRq6hq8qd_ALM=MPvnN57xmyE5VCN+CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEAWyHf3x=sCefMKkUvRq6hq8qd_ALM=MPvnN57xmyE5VCN+CA@mail.gmail.com>

> > -       .suspend        = gve_suspend,
> > -       .resume         = gve_resume,
> > -#endif
> > +       .driver.pm      = &gve_pm_ops,
> 
> Thanks for the patch! A minor suggestion: could you wrap this in pm_sleep_ptr()?
> 
> Also, please include the net-next prefix in the subject line when posting v2.
> 
> With those changes, feel free to add:
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> Thanks,
> Harshitha
> 
Thanks for your input Harshitha! I have made the suggested amends, and I will
send the v2 in reply to my v1 patch, as I have to include the review tag of
Alexander as well.

Thanks
Vaibhav
> >  };
> >
> >  module_pci_driver(gve_driver);
> 
> > --
> > 2.53.0
> >
