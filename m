Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907E4D90C0
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283805; cv=none; b=rgXAWCFsrCMRPzQ9/pXvemZkq5dA1yWc98fc+QQ1nmabadALyIuJzq8Kb9d4qik3JWRGIKuqRXlrlQKZo4BImIw5JTgFN5xpUcHzuYcKIVV2YDK5nojJu+/ZaRER6ZGYnknlAvckWsm+y7gMqEDHqdy7pi6dUqCBkzru2VX5c+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283805; c=relaxed/simple;
	bh=wWhkspSvuUaP79UFlg0tjhLS64ZcoVHeFAMlQFnyJeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHCdcLT6sBlQFUr3tUr4WL2EU7BwdobKI1w+N1bxQqBZF80fcPPS3AmmM2Zy/9d6Q7gnHZZFMC+UgtNE49o/XkIs51Rz7kPsBFVYR+cA7X2gWoNsgLwWPGQE2LbMwZFJr/959kHRZPGN7EUkl0p2QP7SRBjo7Gf/UweGKpXs7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KY35iQGf; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KY35iQGf"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1a631f6aso25121866b.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1790283798; x=1790888598; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZUM5CMnMFQnOGiBLbND2ls6ZG2NSvPjkHob8MA8y/Y=;
        b=KY35iQGfhU29+shzq7Z/HzTukmzZNZlwyhUXdb6H/WLiiEOhPOJaWqU0MZoieOShRg
         6KLQDx8ML05LGOhISezKfHrQswv6hEWt0nBjrkjVRmQTKZPuoBmvxfBHRvuRoMPFoGxq
         WFAA8COImXNh/0BDpCO+wKx2/4PUF+DhuUrl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283798; x=1790888598;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZUM5CMnMFQnOGiBLbND2ls6ZG2NSvPjkHob8MA8y/Y=;
        b=EDF6yG3BtaCNKebovlT1nYota9OHheKZ5JDTp8XrYgns35Zo+KgdHjUfNzY+PJhNDD
         zo7P8IwP4b+3XZc9G03g6hPtpCILI/lMZvEGaIcKbUN3rn49+E6stUeuF38Rk6KSlQu1
         kjaEKjHpk5WFLmjqK8aBhvW6aK9+y0/AGKe/43A1NtJas90LQvh+5gGc8P4WdYbyTCPj
         wdPd0yqZ52ZbETyHt8vU0MsikYTou7ONyNUN00SSajyd+RT7cAtckiqqbR1IlY/vvOzU
         kZOE6kvhMWKjtfMJJQaH4js17yeX6uJrHUgD2eQyXIifgciyozhthCLIs3XAppfratBI
         svQA==
X-Forwarded-Encrypted: i=1; AKwUvBwBA/VZkjh2qxLc0Fw1xA0s3LyraQSRG7xSC6Ti853++3msdpJxRrfepn0F0SOiX2s3Kna3hRs=@vger.kernel.org
X-Gm-Message-State: AFuF++kZYsVQArOG4ekmMTJW6x7uMPIuVAEeiE6LwMi2JmgpB1PxuhCf
	EXUeumoHUiXZkbwQYYyC2RwVKrxOrE28sXqyqwc9GNnpQxDu9Afg+3ROHKod8cOV7uKw9sKgNal
	9ixzQTZB9nA==
X-Gm-Gg: AYBFou0bo/7sJgLJma7sX65PqtWxDFqM7nnDX3Eer1zFud23zFeU/uPJHnx3zNAu74z
	iQ7stx1zjbRlkAIAb0msyldsYVf5v8Cx5u/iL3qdr7XV+fHigCTn0tAFsRgp71cEKKJpfX0F2w4
	Z7HALsJXSEbUaPbqGQ6wjxzz/YJHvmuZqtDFQVsN7qWYXQzWJ4zPvhDJ/zzIZL0/rsWZxld1PFz
	o0e59lyGRGM/569sneguQVjU9luWHiWAYZjMtcO8JJkmTR0Hydau3S8CduKsTWpP0na0W+vnJMl
	0D3ODAN8xcY9a8laHAtduPE1DgBFbWtfoFO0wdgyA/4e4ubq1ud9HKErTeimgNI4VIqHQR9paVc
	08h70iTVaQZ/JAv8MLGtdJE7sIULLyAMilQ+ndQGM3o6rD/Jkk5KExzRGOFnWI9uW3K83RHygF/
	MA27MqnX21l8lOCLumqt+nOUeuy3tXKWS87lv+nEE4Zn7AuPwZFZkb5AVCo9xBYaD5c6Khxjd3F
	aGizbuvHdrwfDzkP0YulI1JkTRwDz6FFNKDbUmQ2CHstwNVjg==
X-Received: by 2002:a17:907:c78d:b0:c2a:8d00:f8d0 with SMTP id a640c23a62f3a-c2ac22d9caamr318236966b.4.1790283798503;
        Thu, 24 Sep 2026 14:03:18 -0700 (PDT)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com. [74.125.228.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae735737csm14756866b.11.2026.09.24.14.03.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:03:16 -0700 (PDT)
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so38656266b.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:03:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzq2vnRJ3i6RNTI4UP4uufAQNfKUPnq+GZfSacQw3dK+clpx7GeNxpPrD9K+pvI0RXAXYyl1QU=@vger.kernel.org
X-Received: by 2002:a17:907:7242:b0:c29:f5d5:5a95 with SMTP id
 a640c23a62f3a-c2ac23ec443mr340930766b.31.1790283796794; Thu, 24 Sep 2026
 14:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924183257.2700506-1-kuba@kernel.org> <CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com>
 <20260924132743.50090cf5@kernel.org>
In-Reply-To: <20260924132743.50090cf5@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Sep 2026 14:02:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9KzKG0EgVGBXB4njb_sO2Jtuh28M8g7y86ge+z2DgFA@mail.gmail.com>
X-Gm-Features: AclHuK-N49J43BUn0smXptgPxT_qHCVXiDpg9getC64BOZbVJUhn1rST0kTDE0Q
Message-ID: <CAHk-=wi9KzKG0EgVGBXB4njb_sO2Jtuh28M8g7y86ge+z2DgFA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v7.3-rc5
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Sept 2026 at 13:27, Jakub Kicinski <kuba@kernel.org> wrote:
>
> At the same time I'm very impressed by the overall code quality these
> days. Regressions are very rare for us. Even mindless slop that people
> send is an order of magnitude better than code we used to merge 2 years
> ago.

Yes,

I do think the AI stuff is actually being helpful. I mean, it's a big
pain *too*, in how it adds to the flood of patches and puts more
pressure on maintainers. But I feel both the generated patches and the
review really does tend to be raising the bar overall.

               Linus
