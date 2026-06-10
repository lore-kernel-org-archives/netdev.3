Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D288337B87
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064268; cv=pass; b=JBRnO+ZYZK44GQ8uDoqC66meDcvI8SXs1ojDyaCyoJkvP9X0WyB2Dbaw7nXQQekgcRo5XeBKlQuNs8lLcDpeFCeqmQRRcLF6z8Iz87PkTmdyGHugaYBWwk5JYqsYcE+YIaoRIUQn/2+ZPWcdX/D2rAf6OMo8cP2/aXEKP6B1mpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064268; c=relaxed/simple;
	bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+zfyFm7Lup4IbH49+KCkO7z1rBgUKbx1kKUsW19DxWLgg0Du9w1TCDltELR7IAC1ZGfulfhmt1+EgrdL9MhdTlvRldCu4xBtsCalvZbbJknC9wB9lEEm4/3o9g3XwOlULQeJ77NckREZ1wffe271NDBjPb+rFOQHgh9ri60alY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/+gZdUF; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/+gZdUF"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517a5cafc3dso42808021cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 21:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781064266; cv=none;
        d=google.com; s=arc-20240605;
        b=GsIts/t+qkKU8eAIGt7KZNsnCGllb17UfZbCpRdaFwO7c9boGy89cGFPN2X4IW0NeQ
         UgLGhYxT1LC23ScWR/PJcs9vMy9P5BfXePxbb0yHo+3tBkEVBtkYsOTABjcZTSLScvc1
         U5rGhGkH4mMaPrdI/r3DaHBGzj6CBUIrANfUEwrl5XUPqgipU2ZNo2xe537SzSe46Htq
         Z/XR6ANqi1yF8/BP4zsRhjKPSizF115IpeBst6w6FOgObG2uetX9z1mLbfjCjyWBtLWC
         7q+p584FGSXCRqrM/91CY+SuNxIJUAQrk5bSPqgSchaw7vM0pt/Ev0mkMQmJTK5Q6zwS
         Ml6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        fh=tzt+XJCgZgvvHtv6KnbSXVLIEujONp4s+cUXaRggsAQ=;
        b=infRbFXrda1p6ELPYyfEvlE1Or+Sb8ltuRPIJbkPFpL86N/bFd/1yk4Lrkj5BrI2/P
         UFy1+iap9HICi8bXxkggfhyJTOqiLbYdf1NDzvY8UnlaKel7uUAN+BlsvRSwgTYHGbcA
         NZwTVlB8ZOjzydkWRpBQQvHwTDE99jW9mbh2Ce821qAHLK1XAkcA/XCADF+9cSOAlP6C
         TZdEz2FfpK5AvHrc1WX6lBlGj8I9fWpa4PtI0Cxrvq9DMzQabJHFS4kpWNp5Vrl/sL5J
         aPV3QMefq2ITfZi8ErSY6TWEUfljz15MNRRXVIEItsAoUw94KwNdznlNY2XmqZYfE25J
         uX8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781064266; x=1781669066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        b=e/+gZdUFaSnYmq+oa3A8g0IHAdWnnrm4k1lg2BBvufen+jX5O8Qe44w/lIh0z4ws2l
         sVX8WCXZNxZlYxY0RuopKeMJ03BpnOPdzHfTL5CHlzw7gbvVeDaAUWEbDCXjguRJkttP
         tNHkTjt4EXmPpZvBOdzJBRhwB8jwOl2HvSTsHr3UNGuVQRYeVnuakye5XQ/3Awe0eODY
         ylyTxOh+Srh4UIEIWOnqdJsAQtP6aVpALRMzfr2rGvkQctpTuXi6O9Y8SmrFKmGIkqH3
         JNSXGiclPUwwwwLO/097LDZAD+l8Rx1eDx6a4gsM/t71gJ6g3Dg5J0K8WlzSZ2g1TnKm
         /nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781064266; x=1781669066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziLSvpDPefhMh1YLhfgYvQRoU+jpwrEU6vRhvYQI4WQ=;
        b=MDoVSSxOeiTuQFCPFBukkl644pTpykqRYEXJCTufWDz2eNB8QW9hpz+2mguyreDo4I
         EVC0CypsVYu3dEWAg0Q69JEYKg1BT2yPi6dievHfrUzCyVM9CFAQyjKCGQnAuCv7UYNf
         gMvdnwXa3rP5nDH8gPXStmAvU0MGyjYzy6GXSF7qC08KfIIu4ERU76+yJcajRubLWdqT
         hKxyVQBznN+fJWe/coVJmYREYty23qnajY98pk7IyKl90va6wih4VgO+3EYyBy5VmtJn
         xmotDvOB8Ja4JP59ChnLefBAl6QtuJCcCN+VN6XHasy5zgbnCQlo2h/qbnEOHq0j18an
         Z2ZQ==
X-Gm-Message-State: AOJu0Yym3BH1QMCSqYwPQyOAQiya+H30zmzKX0crVjK+3Yr0KVD/jK3j
	agZb+eUMp4dnf3P7zElX2ZJyMaY9IqMXmB2Ex8s8g40c6dqW2CbBMVV+MEm52GIfAsSmLiFqz4Z
	S8zXKhLJYeL5V1SpihqLQnVD0vBe+DEl+xW/HrQKN
X-Gm-Gg: Acq92OGXLtYBu21hekG1Xz9AB9zGUJS+THr1Ydxk+cUTHaw13GwrhpMc6UtDzj6WIeK
	AKpzADeJVbnJRq6SLBIQPsiZ4rQSLbOtugktOcfga64YSsGvyI0sRY66oNKrcVPVr6aZfmHMreK
	qMSlIrrxt0AvqmRJAIygbKEtsw4f5YrhS89fQ66HJeoljKS7zQXjrlOYpNSNGV8Oo+xTCArbk1p
	szuVZo+NTItiNp4D2kRS3JKjtxSsXleOCGe7A6tlf9EYrVaUIYGuBbzSh77n4DhZZIzRB+SuxwA
	gmFWdQFGwm00FJXx2wf0xKtglaca1OBIFtzUpDbO26CB21yKqg8+6eNgU2tr8ydNVSHgVJZqg6d
	gsmr/iM01ZvXpVbFnrLrHGRk8wdVUpGdb+qs1RnYG
X-Received: by 2002:a05:622a:251a:b0:516:dcbd:aaa3 with SMTP id
 d75a77b69052e-51795afe9f8mr282610471cf.26.1781064265597; Tue, 09 Jun 2026
 21:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781013810.git.sd@queasysnail.net> <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
In-Reply-To: <c3c9ae09580a5c1d36b32b5ab3a5db398feddfe3.1781013810.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 21:04:14 -0700
X-Gm-Features: AVVi8CfyMQNdfBxuCedY0XLw0cG0g593wzGRzIZOYWbRpG2SfiMV52ctWCjxjrg
Message-ID: <CANn89iKy=kzfyRKtGt+dY8Fe-ScD95cD=uuy=Gkq79K0kcCdvw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tls: remove tls_toe and the related driver
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 7:21=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> The tls_toe feature and its single user (chelsio chtls) have been
> unmaintained for multiple years. It also hooks into the core of the
> TCP implementation, and bypasses most of the networking stack.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Nice!

Reviewed-by: Eric Dumazet <edumazet@google.com>
