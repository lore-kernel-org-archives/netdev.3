Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503231E822
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787438225; cv=pass; b=kn933hZq8pRbVes4TBn3IOPhV/UmUrCgrHryopJwatj4NwyPYA5Q+jC5A5ZW7vEcrmbKc9z2QjAB/f5zZbl0p7Lwv0LWuj4+leXhf+PnPEVUReHN65zo1xBfug57frdFuXA1H5zYtVxZG4xrW/0+Cqrt/2ioshym7bL5guBfI2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787438225; c=relaxed/simple;
	bh=POBb41hMSzY1caDEN4VAGdVyeL6t9zbft7UqUCEzIuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZHAPmRgrqSfDu3u7KccTJZ2gPEK1EJvwNLSQd7+yuNA4xerxmfgOJQqcalRneVg1Pv/YWh3oy4jnsTdJ9rALJvbwuUaATsjRU4yHP1NGFdgMijm1LR4h9VQkUuCGcR+sRp2L9iIAxypjkltvdhEyUsUBJiZFCW/bkn8n6EopMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwaHxTIh; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwaHxTIh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cab973140bso29311215ad.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787438223; cv=none;
        d=google.com; s=arc-20260327;
        b=WZotOZLIBqSlse4ErH311nXyDrk64NJjh0EisaDPNfAHuKznN8UZ1GFaMjVPaJMvmr
         RiPSzHKtl4Zy1SD/wrcoZ2pw8IhMkUsH/J5BgSMWhi5pTXjRQ21kMppKXKNYMxjhyPrg
         aaMqVses+dFjbnlFiat1LaVeD1jyIBCKmv0k+vJknBw09wbIMAcDVJHNvaJjlyVrl6RS
         hpbsKlQacTMuHkKYzdStw/EXRaZk0vYPX45t1IOpZI7jIReGZUQ/6ob+bA0AMcwkO4Eg
         Xj5rY9hdBrCjBQZ953ThKAZ9PpqemgK9Gcgnqg8H+B5TjqUI8LCsdn+5Qug6ML1L/Jl8
         hTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=POBb41hMSzY1caDEN4VAGdVyeL6t9zbft7UqUCEzIuo=;
        fh=bkITgScllMBn0+4oCZbFQG+7axv4nTvYwfrCA7KOlHk=;
        b=feXkzXNw/H8GU2u5A6+9Ve96OlK8dL7UcFCPajd/ad66teSsQyoQthuj6NhoiPasp+
         d7yOBZJR06B58J/AswxQ2LvRB+SYyn4I8KkXExSatBJg3PMt3E0gwRgCM0DgHzvh9sd8
         jxZk54t8ihBroQKrCscGFcKrQcO8rSxTUXUoDuCG81cUMfjMRAl0xOkAZ1QY1oUDU9uj
         vaJkQ+pwnwd2Zoz6sn5z2+bjR2P0dsz2w1wb+tX4XCf0nMhAF1rd7NSFkSFlSAg0MGiA
         FTklNluFVyiRl4n0BeoMMHJqD8i4I1PKqvu6C9elajpSRDwb6n9KbMsc+ffA/9HhRdox
         3X5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787438223; x=1788043023; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POBb41hMSzY1caDEN4VAGdVyeL6t9zbft7UqUCEzIuo=;
        b=qwaHxTIh03fj0gvcPrQUS8w6mPkVDE+aREegWiZUyfC8oNh/35fndQhk/Bkv/CafnS
         Ffrx0kPK0uihrDNJ/7F62jU2pJab+3BMFYKSPSYlTdYXk3aPHSgQh30FUaOIBg8ebo1u
         68SIG72+4gUqBlkTOuhmarGsL9KOIVW46NmZKUwIz2YAWY/bFTMNUrErLGOMWdw9XSSb
         xxcWHrB7c9yE7pFPsrO7gZlCp7e3dXuXdtdmX4Vh1Fov01aAN0Dy4RwKp2NEbxKt18+r
         l0eZgECyELB6R5mOPF4Jc5BHGQXwSV4TA3kqQDuuoW9soVaD5kKCj4mDIDRz+oF0PmKy
         0+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438223; x=1788043023;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=POBb41hMSzY1caDEN4VAGdVyeL6t9zbft7UqUCEzIuo=;
        b=mLKRW9e0OKUBvT7yP2teneWMB30yNS+rFnBrZCRJOiskgWICmICmLfMMxg7x1OnTgS
         h0O6GLC4vEbLpbI/SIl9Jf2H8oQPjAA8guNEne47JV3UyJjGLkzui//er7U37V8ts5xU
         A65dLoIzWJRdx77VoFkSTcVe2QE7iHx5OA3TgPzodd4THjha4eDSiy2GjvQ1ZqzhQVtz
         AWn7OQ59PZA4WJymabszQ+j399FjFxC7m4Jp6nKFkT9Ws31sHSpK1AdwUsXhx4wvv2TF
         1VPWdqhI36V21Pktfw9zPR1so3GMehtvgMSV2gXXDbxFQJSNLFIurCS3+F9bZEemRahz
         u5Sg==
X-Forwarded-Encrypted: i=1; AHgh+RrmuLefJs32sdq9+NOA+nIb9jUAUgiQbzPXI1Hl9fmK/TXOviWCglwfAs8+sdQeURPDkFLXJmM=@vger.kernel.org
X-Gm-Message-State: AFuF++m0qWPVcNos7eniNjBF2F/hjdXnHPBALZhqBHVVlOsCVql1H+bq
	CM6bcyFWTxGD7BTPxA+ADnS9zfGFEUFFHRc+vMruE/sju0F0lhHjisfTkcwTLDWMwc0fN1hUqXi
	FT1wk8cZueK7kRCUSqy4r8hWpZIOYSy4=
X-Gm-Gg: AR+sD13lAghqWHUADUYZ5CK6SNyxYueUCkS7/TJ2//pONMfIB5oKt25VYjW4Mki1ata
	wXGo5g2pcmY4NK0gyvIeyowG+Ht31s64LmHy1q5S1LeBDx5kpDio5iw0O8e//IgV3cvlTcFYDSb
	1pJZMLfY5RyDGA8z4j7BKgpIfi/s+hu7wBJiKXCU8tOfOMQHglY7SldEiWoGCJa4nH+VwiZ7piZ
	3XSJWU/J0V/M8Jb+EVDNOdWLmVKy1XMDIZNGNYb7sacbUqxDoUkYks9jBZXUlrRz+BOsDe/9KD4
	5ZQntK3bCf0ubyK7SX1r9xm7wrUkxORYZha0Ln9ja2uemFNFUaNnHQUNf/NI5DrI16k18T/fHp2
	tE7jKA1fcHoWbbo0AVAydV1BDSoMOUF8KoePI/U92YvHAqI1rCD6Ckq7ZTcWk8nVjj6BW9Nwfzu
	U2hYSLHBmyfqi2tBo=
X-Received: by 2002:a17:902:d552:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2d670b85ea7mr162565105ad.5.1787438223003; Sat, 22 Aug 2026
 15:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821123249.41527-1-phucduc.bui@gmail.com> <20260821123249.41527-4-phucduc.bui@gmail.com>
 <e225c560-eae8-4487-be66-f624e5e215ee@amd.com>
In-Reply-To: <e225c560-eae8-4487-be66-f624e5e215ee@amd.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sun, 23 Aug 2026 05:36:51 +0700
X-Gm-Features: AcwNN1WrjE6UThXJFzEWU5wxN93h5aaiCp90Hxp9q8ViHfzBnLWUh1xBoSjqiDo
Message-ID: <CAABR9nHwTFFGVS3Y0MXsBx2ubtexaZ6hqcZYQ5au1UjxEjb+qQ@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] net: xilinx: axienet: Fix IRQ error handling
To: "Gupta, Suraj" <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Gupta,

>
> ENOMEM is a slightly misleading errno for "IRQ not found" on the OF path
> -EINVAL/-ENXIO would be more accurate. Since we are here, better to
> correct that also.
>

Thanks for pointing this out. I agree that -ENOMEM is misleading here.
I'll address this separately.

Best regards,
Phuc
