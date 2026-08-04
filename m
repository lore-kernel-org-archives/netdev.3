Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993240C5D4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827681; cv=pass; b=dWZpAiQeaJHCZdazeV8UDSma9zUr53hxS7dzdPTIgwZP+xsZlm0xtEtQ/xMbQIhTDeEiEYGKiQNEs7OrjPErg4cOcy9OA1KyKp/i9CC08AzmUzLIk3mbwVhLEzQJY0gj0VUOSdxQWtNMUsBdOvAUfMJSzYmlfnuVskvTQB3I7N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827681; c=relaxed/simple;
	bh=kICgOv5/2iXexPp7bGaZdZg6kq1kQTHrVyw4nr3vLtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6HyB2g3ErlfaOY7LMGRLnEn5chHEt8s/tbX1SbQubRGzJLyESOGCRbY4DQzdmuQ3bp8uzmJ5Oo0rHphy6FbKH4mAExuf5U+ZlKNZC7+j73einXZQYqBs980WHwiVqDPq656coToITTikU8oTABuSFkLap6TMibpvmDx4uybzLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN+6uH8T; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN+6uH8T"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so490386566b.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 00:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827678; cv=none;
        d=google.com; s=arc-20260327;
        b=PU/tl7x1hk3e6Jo5qpHSEVT+Xmi9U9zYw0ecQOdlhOLVeajbaBl1a6t5h8Wtd9+Jsl
         Oh/q7Fv1YVWwe68RXk7W5KPNPNXkGLjAlFD1+ZUxMkShADTEohAmTIzaTFya9YQb+rsi
         9zC2nwACErnT3rsrz4VVM5q9bBYArRVN9XyeAQWgJHZRkYIqsAV1P9sFh7OP2fYgbr5O
         RCPzMu07xxlMMQzd7xwfoZBuAI1lK9sNpWLUIeOkLX6NJpnsvptaHWuOXhhriZVGpa6A
         HZjtxLubhbX7pejcfMJhcxLkre0Kma0NGtiXGXziVeTn/LPv7lonODmWPzB4H8LHctLT
         0BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kICgOv5/2iXexPp7bGaZdZg6kq1kQTHrVyw4nr3vLtI=;
        fh=QPOUND/uVXplYCsrGmL2GNW815I5zpWOlcfrdt7yIfM=;
        b=HdN8Z/iF2x16799ICGWyAw5EAxlcKMSPc3FV44Mr3unB6seLHCsk4l2bPmqsfyQrGm
         hKPDzUzy90v3IQ5evGmKYw66HuRiDfmS5FK0h3ocDJwFpA5zyuhQfYlJd8UTAdzG4qE8
         JIFaUvyvef5u8W9gXmUcmLRc/u7qLrX1mRqktdJSnYb1WZOv8wjDo4eUiNuiJfwAew7e
         7kMafo5tsSBcvHyr7tB8v9Bi46DRmUqmSsLTV8CWHwGQOO63fE2YoF/VrqBPYOAIOlhm
         OsvDas3y6klvfmm9nMv8fwmKE54U1uIHCRXZPFVM8ozOjOgF7xJLlpSZo9U+evMlbwyX
         wMiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827678; x=1786432478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kICgOv5/2iXexPp7bGaZdZg6kq1kQTHrVyw4nr3vLtI=;
        b=VN+6uH8TrFyO4fxC57spffa9ggzdgj+M11JwDhZZE62BUWUQGI7tuFQZCNCBS2Lhe4
         n1jkXQuIIm4OsK2CAyAQSuQNLnkOXhPCP3APpAYbolJutGjVmtkPSWrYsAR0K91gc7VH
         U+h6cT1G2i5qQRYBhsKSQrPiCA80p71GrCVoCwxRmYPPcfQNq+KCVGnFQ/mhUHQUhwkI
         DfPzoa5Fsu+RHU368uvUmBrAvlundmUnU1Zhoieex9J+NX8kGAdPDDzAf7esoFzxcXJx
         XenDDWl2iFSjlWZTr2RSRp9KyZ7injfNT+gOzlIG8hFYhOE2Xvzib5dWZO4plNIvTHY/
         iQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827678; x=1786432478;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kICgOv5/2iXexPp7bGaZdZg6kq1kQTHrVyw4nr3vLtI=;
        b=ipgWZKi9kI0Dnq4ljgb11FUarAd4RICqDKHMH1XlX1SVrZd/iHPM5b/NgtaDgnC4Fj
         7J7CSCQVNiI5lV22FhNwHDBehD5JciPvypvGXLJcxk8oYCCn67X+A81+IjVPUltv2RNL
         i162cBAwUpIZtpF1ODsRQSBOjVRiNjrU8nQ08b7Drn/ABse1vqVIeFKaPzpx6121Ss2k
         6rfJNOja5Co5OML2q0QZIyv4R6hjGBJqXcd7JJcn7AAQrPZdMZMTz57IaEBp9/k3bEC9
         Q4eDHRf8/cRn9x9OJ77dpXn6SblWhk2Bz0HjTejXSQ3emxA0PcOCXW20Qm+bduVPRD29
         K9hA==
X-Gm-Message-State: AOJu0Yx0raoAvAu0aWqr100YWleJXDIDJ4PsKKCx43FENpcmGbD8kFk5
	C7q4PQbBccFfed8umpri6phxGJeQ/bFGXHYw2ZTA+98JKGOa1fQhGvJw8BQpX3Z9bUrFU0VatZE
	JuuWfNLbITcWhwXMo9CkNBSzdH3mb2Bo=
X-Gm-Gg: AR+sD10hSQNxMGuIo3gJlM3gCZAkuDxIvLPgoiOouI7pZKLGyo80t8Ohc082cdlFmhb
	tlOIMiA77BaQ/gmspwDDYN1gY3NOZDftUOrFgp1mit8J2PvdRzKZ1Kd8NSr71EbNExRay/7nCQQ
	2/e7XDI/O/PBNpG57YgjeFcH7txmbrlASDolEfZiok3DypRKecKCwIxb6uYw/6L3itNzYSQb96N
	ZwyYSVGjpPR1JovBYUeBjMW+sqQ3y53/ycY5ZGLeq+Jl+Zp8Iy4i5FcVdB3OpEqZ/rPh231RWg2
	0s3YVqM6AnjZ/YdojWXiqDk3sD3IS4dTP2q7nQanaymsUGVWVcfZIPcJ
X-Received: by 2002:a17:907:6d12:b0:c16:7414:4c29 with SMTP id
 a640c23a62f3a-c1fe81e0d11mr1024079366b.25.1785827677958; Tue, 04 Aug 2026
 00:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-2-a.shimko.dev@gmail.com> <20260804-affable-warthog-of-contentment-b3f09b@quoll>
In-Reply-To: <20260804-affable-warthog-of-contentment-b3f09b@quoll>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 10:14:26 +0300
X-Gm-Features: AUfX_mx_eWsELjCGsOWZC41KbKW65u5Y6L50ulKMLIBcNP7R1jvdMrvS-GuB200
Message-ID: <CAOPX744=Bo2LqT=jSmO7L4uQr3eMuhZ4WCSVFkvxz_dtfTMUTA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: vendor-prefixes: add
 Guangdong Dapu Telecom Co., Ltd.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Aug 4, 2026 at 9:46=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> So the prefix should be dptel, not dapu.

Got it, thank you.

--
Best regards,
Artem
