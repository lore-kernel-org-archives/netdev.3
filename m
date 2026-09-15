Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4A4AE8AC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472891; cv=pass; b=AjimGuF+JTkej2pDgs/Gr1xoBQUeVJhh9K6JTfyzf2cv5sELbVhHzviHmfcBjK1owWOup0lvjwlSpVOMnFXjqfo9f+vbjwV/bIJxBgCOPjn7F2poz4G3N8Y9CTLrVXRk6EY8cqJMVQzi8ayObkCs8A+ifc/cRv+ucRoLHYyXFOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472891; c=relaxed/simple;
	bh=D2u4z1INS3OCbqB0Da0PpeRDNT+ntWIhk7kEPI5aoiQ=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBveXC6I8lm4JGv5pfmZwaoeNJFRnm/zpWa3XGeO1GptlhAtXkWwi3w/+wowoHbKhSi8mGwj47MGpUpAuooODgsNjBKWRsI1PaKxm8vGyh863KZ7TH2NSgiAma2eO1MgSZy+uFrgNXObfWqBa+Y+c5buUpnUW54z99qWgxHyfVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=ZeQ3JBt6; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="ZeQ3JBt6"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so492474e87.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789472886; cv=none;
        d=google.com; s=arc-20260327;
        b=FN6gt2Ivjs/NqfFbWrzpKpLAEn5JV325XAfuRGmRszWnHuc1OsuQIDHOREtp1lo/yB
         USNUwUTh4AyHdUhUIRFQarj4VNEj1aTGDtMgTqLXmsitYEm/2CfB4YxTDbsMmx/y5OJg
         lIWI8Jm4odeTr3Vljw2h9xLO/u6gQ+8bbLUu3IXJ89huiGyi8guAd1+tDVin2e4tNNqY
         bvRI7mXW9ZE8pOgceeNYhgmBMF0s4btdTr8xXDWqosGLcTjVVQW1VNh0BjB8ilzdAIn/
         6EcuU+iRAsu88nBay72/n32q9joLqkqL8gbX8yS6gElSikQHZF5PxfWnojrSihmlf2lt
         Cg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=D2u4z1INS3OCbqB0Da0PpeRDNT+ntWIhk7kEPI5aoiQ=;
        fh=fPYwmXOPWOMFNXxrYPDh/Z+0GOTYd652KC/4AkCQO6M=;
        b=CLbAv2CHZT054VRRE1SRkJdMcKDyxlWiX7g7emgvBCl/03OZRCRKC3+eLJ7N59QWVM
         zneggGwWzqlu+IKULNRogQ9L1WZ0wfXW8ECM0Nrr7fSYDJbyEjICdQW9prRWVySoOwLG
         lXTXAPZHWEgAS2XvLUbd3v67t9iKGJpv7yWcOguZ1ttfAJ3IZAjaS25t4XS/ARYf7IqL
         qFerrjNK/2fNT5zj/w9+YXVkViKLRmEgjrPZ/RU4PuozARyxDjwQm/4U8KlmLjCrKxai
         zcepGCm+5l73MxijJWaKJbZEoc51fPBh8CGPaj85hp5erycOqRl3tFILWbOis59s/7BK
         4BHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789472886; x=1790077686; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2u4z1INS3OCbqB0Da0PpeRDNT+ntWIhk7kEPI5aoiQ=;
        b=ZeQ3JBt6ZL4qtP6A5yHrgvoWtNiSYcveTyicFjb2DzvyplGtnCh33qW4ZZ+OHSQCKH
         N9TMxlnKo7a82h99ViR7psJePMZ5WHxOnKVFPtxLA91eaq9pqxREV0Od32CNvPewrTsW
         LEPwzkhtorGi4yVwgFDBpVQYCIfmU5HxUD1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472886; x=1790077686;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D2u4z1INS3OCbqB0Da0PpeRDNT+ntWIhk7kEPI5aoiQ=;
        b=mk6Q0qYltjEXcGVjW5LO0j0RFvThu2u/0F3OL02jqboGzrR7kHhkOBrRjcZ3s1yNJ7
         sq9Tb2DIlyS3AzykwBf3n/5dBJbrjPDz7Vz0tJt9GLR2NFhVtct//huPFF2Y/FPwcHmo
         vNBd3pDQs2Gh4jIvYPNt/XRnSkU2NtR7CAR00s16OT60Wv0sKQ/nOHyHD4OjVWWqx3SM
         0uQy3tbrGUxXr4ykr9pJAXta7cI3ThCU3SZN6/GpeAGCNQgugNnPuaw14ILMlASN1Jy6
         l55V8IMbLM2w36GkVjIHrmdMJY4tQ3mV5m6P/5UiqxB11kDQPNF2OG9yJaduAjdGg6rC
         /3vQ==
X-Gm-Message-State: AFuF++l2iW1kQhEonCX58fUSDl/kdB9Al0NmNDxtZFkKZI4DSM7xlWkP
	NLCncnhGvZnGCxMqF52JsqMVoE5h3MjGyaiZT4XQi6uJEOnHlLFBQwvK2jMc0dzCWR8lAPxA5sV
	21rk/Qxjw94QfRRnAnKHna45O05FcQCbMZ0CUz8zTUg==
X-Gm-Gg: AYBFou3vOXHDnZkD6fDKwXhEUM+GW7CMEQVLj512joGCMbGNHViQUvGuC5Pv1Nk7Kr6
	UsZmu4LqNVtG/C0nbyfZwCh3B5nDQkKGqMrGoD6Cdfgu1ZXCcJQ1ePol+JRub5LkR0VR5dMkrzy
	86LfzHolqP28mWT9DXM94YiTMvl4JuxnkJ3ki64mEfmiHDkGr/+PDH27p0b+/688HbxW6S+Qq7L
	OSl6j3nw60ZqCKwWt3vir9jk5DTuvw3YPJuqa4u/obmzUpsp/PpZ1OxgG7SQ6BOwMuDf9Nc2btg
	hjCuSk1iij5hGrRrnk2D+R0MiNMxFo0Iq0mn7DemrsvT8iJERmRi
X-Received: by 2002:ac2:4c4e:0:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b8ae684057mr3533337e87.3.1789472886190; Tue, 15 Sep 2026
 04:48:06 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 06:48:05 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 06:46:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kimwooseok <5mghybrid@khu.ac.kr>
In-Reply-To: <20260915083849.72030-1-pabeni@redhat.com>
References: <178911388671.25348.11008812384009904081.macb-resend-2@khu.ac.kr> <20260915083849.72030-1-pabeni@redhat.com>
Date: Tue, 15 Sep 2026 06:48:05 -0500
X-Gm-Features: AcwNN1VuwiGfbvZNynavdGtn7nMsK2YRrftqALvlMAMvDCTcFiKgwLbTrVPs-uQ
Message-ID: <CAH1Bc_zWJ2HN831TjefE=1NHhYeg+8vOO+7aA1KynzjH0n0qkw@mail.gmail.com>
Subject: Re: [PATCH net RESEND 2/2] net: macb: Use all-frame timestamping for
 PTPv1 RX filters
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, 
	conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Replied on 1/2; the SRTSM and resume points are covered there.
