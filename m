Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F023A1E7B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258450; cv=pass; b=XJKlnlEh5AlEx8s8LVuE5d5KST85TPnHrPPgpDaJu728fbwYZv3C4+8OxwaZb/NbAGd9K7Ua14VTq3PepwT9D/398EhbbkprJFyJ3K8nzmffPR/UMq4AzMJUwshCc7FuoGHCv9YpgRB3MAr/4JZvVodMRfPljOKb3E9Ut716JBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258450; c=relaxed/simple;
	bh=OpvGMPPdpwakZE/P0kGvTKMXnb6F+tK5SIa7Y8guqiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6vu8JSWnaWHVeBHThanDkrK022ORKcZtoyF92Ie2tJgCsQdfDE382igXJNg9H5Fe0ABC2kHGUIlgDlSx+QxOZTvo702uLIykR+VKdqiu31RES0o1txSgsV4kNuO6biYcYbOGfvEPr5LvZlMY7IYiSIcuGuFXTcdsMhudW2UQWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpqMNJen; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpqMNJen"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so674215e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785258447; cv=none;
        d=google.com; s=arc-20260327;
        b=opPigRQjjOF1cmZh+OGgmLFrkpihYNXPYKoCNRDSvCD+uW/AX1Ei8j+Fpj80VeteRm
         nVuA7unQG6kd/6DX2j2cKXzeiZVLgf+DUz6dV7smvQR9oCcXTSUic1JR5TWZjBclAdeD
         whs0T97Uk4YWZMeR7sMyQ6EYsCzRtFsEr+8od1nOCCCBfvtJOsbaXPWpVpF7CPg6yLqo
         B2rLTZBr8c1/o8omDJ79jyUnbDFZ/SIFqmsCH8sn+HgeufAxGgvLrvLIL79d//MISldX
         fJxvxwRqn3nGW/hBPpeId+6uAK5xtl6XinItEIZS3Wbma7vkag5ns1e7Ccz1ilbTcAqP
         +1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OpvGMPPdpwakZE/P0kGvTKMXnb6F+tK5SIa7Y8guqiQ=;
        fh=fiSwMcQhW8OnhVlM1sgNPUVTT03ld93tut4bDj46WPw=;
        b=A5np1Nv6DggaAd9FBTUAm/qp1YRyw/y5qQPon87hAZG5Fk7xWHUqD59SfYMS1zwMWm
         VR+z2e35u9UFkNUVqrSfmahvDWKt8x8WSFPz8RdB1mMjN3snxkVOiOXvFwVY7gYHom6Z
         7ufn1WX45ENEtO4+84Obmh+4tw6lOf0AP2+uRZnkMgOpqCyI1N/vSqbQG9SQhJhnvlYl
         H+BihVq/SfOP/Xph9q19s+ikR1GUdhjV9CCJAMXeiBaGXgrNBNcMX8I29jUXaeA28T7w
         OIr73IRrjLeQYK2UcfzqzoNON2A1EF5VkKa+mX0MwzYokmZnHIMBjyAuA26cECYUS7tO
         d7OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785258447; x=1785863247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OpvGMPPdpwakZE/P0kGvTKMXnb6F+tK5SIa7Y8guqiQ=;
        b=GpqMNJenHNhDpZKnd/XNfFc8dy2YDkweio44AYGXEZ+jeZvUVQmakH53MtHnIYvoXd
         4D908KDph+RZsiMFqx+fNtKIo2QhzmP/h1KyXSYE1j4VA9ozFL/z5pj6F0ypRNi7Urhj
         2w39t2WDDFBacIfC+QNUyr7KuL78AMuZ7v1lb9bbJyROvMdQApiW+GmXwhzPuEXATmXB
         F8oXs/RXMxaV8wN8p+z3Jz+JKYJ6ZKk5UXXGbUXiEO4+a3wzRT/u8mNRGcbu+uQNpNVg
         kpZFgmSX0WjA8lf7WA5lnhnFAgu5xNa+IgDwh34xx2vebCz96ANSRigG9+5e69lYd6FP
         SVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258447; x=1785863247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OpvGMPPdpwakZE/P0kGvTKMXnb6F+tK5SIa7Y8guqiQ=;
        b=diXRSiDnxrvEkbbhziW9VaMNq534/GmA5D3VhIddlIvPOkGRgC7GS/c4YyoFNT/wT4
         TUJ/xSaVffIc+DBWt7RyUq0XMnQGaY8nhhPWMPGIee6QjLB8oYUqL/ThCW/7Nk7bdx+g
         YHhumc4p85VavQt38UZhL9CZaz8Q44oGXtcGoLXByksb69WNUyJuXMaLVoB7DwYbgHbN
         1XjG51wSRlDOi2/qP0r5cfsuS9h/dmeHRig0eLGBAPexzk7OPtcyDODwdhJ3xhF0wDpD
         L1JwALXWxEksyCP+z0bSX/nub7APp9on8Mtt9072+RmHJ3tQoRyQYuuQFrkZ+saBaOfE
         /Hxw==
X-Forwarded-Encrypted: i=1; AHgh+RoRmqnD7FkQ6JxQg/BBwa+Zy76mnlARHdsasx5KeaWl78FWEgzIm0hFasG0Sy6Bt8Y+NnUJ7xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3c8vXgQlbnPlYit3zefKdIjpE2mc1LmlveIIO/Ano2DZVmmw
	HR9sDZU1+KSg7GFMN4oO4IKFPOI1Yc8FybrUF6DqhRukRpGwKZWHsvQMwGKScJ01wEtSf3Vlp2k
	FH6s1/kLQhGCoKWj3kpEX1xHobSbiNp/eWl/5TwM7
X-Gm-Gg: AR+sD10ORfykDcjs3zUC1xz6HobbA34PcuiD3nlyE6aH09posUVT9NzNrIu7gdeJtpQ
	JGpaiCC/xoMKpbECrqSZFtwD0ADnNjopTRiCoH4vyMNTe3GI0RkdD3oeLEjcfAbmgVcyvVDpe+G
	DXS/zK06YcYr9oKc4Y9qy/HqeUFV8HZ98p6RrbUJlO68XXk20GVa8Qo1rbAjAQQNS5Hk7VptZIk
	K35EQFSOIdLnPop9N0zXbwbr4jmSbTvrcu36l2H+x3K4d2lNRsJD4eqH4hNaTUDygY1WFshwDHC
	ZHObN2sdPVebdaBX
X-Received: by 2002:a05:600c:548f:b0:496:ca1f:a428 with SMTP id
 5b1f17b1804b1-496ca1fa4b4mr14861095e9.19.1785258446141; Tue, 28 Jul 2026
 10:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721063829.7d9e6c7f@kernel.org> <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
 <20260723103607.55debff2@kernel.org>
In-Reply-To: <20260723103607.55debff2@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Tue, 28 Jul 2026 10:07:15 -0700
X-Gm-Features: AUfX_mw0FxqWxVhC3oN6qw1VF4156a1CWTm0Pt3PrcByvw28u1eYcCSyExYnkrw
Message-ID: <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
Subject: Re: [TEST] google runner needs nested cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

The recent updates have been merged, and the tests should now report
sub-case results.
Please let us know if any further improvements are needed.

Thanks,
Sheena

On Thu, Jul 23, 2026 at 10:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 23 Jul 2026 10:14:20 -0700 Sheena Mohan wrote:
> > Thanks, Jakub. We plan to merge the changes to support nested arrays
> > for sub-test results by next week.
>
> SG, please ping again when you do, so I can check and close the request
> on my side.
