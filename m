Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F149620
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777634; cv=pass; b=r3xWK89zN6iYNunLFqqRMrSJVgIvInsqGF2Y6OyjHrzQWSgh1SXz6lrhFxKqiWid7C5pGAUyXPv1NvzOVY1QlTWKvbHtoSJOPhJhYdDzfwJ0HXy+mpyv2E1YITbDeaRjCDpRPKuXPG6EkTVtG4kN3YVWh8hvDLkHRXeV4xOKDTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777634; c=relaxed/simple;
	bh=ouiP/s84DTBB3CgCBBKgMRlCvmNQLtc3ruMbeozhkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8dCIqu03PBniU7ml6NtLYCgFLwKc2bf8CVxu0U96h2It+jF37whhBayTAZ8HGe8GuB9lT4JEeujr5ZJFkXSb22SfYDfNJ+7WF3qS8HhxUmf3TfwtV/4jAtf4ObLrTt/YwKH0U5EIqVJcwwF9dhP5ofxI4G4NDNze4F7FRwgzKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU3JuVoh; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU3JuVoh"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so5291473e87.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790777623; cv=none;
        d=google.com; s=arc-20260327;
        b=MaomlMjAKm2dGI01dtiVZf/AquglXadkQg1ZN0H2uB9KvGtQGQddrTHi5tV16HMZl8
         cRa+7AiECfUHhoCXMTzxRF+NmTs0NaRVYxusO+wjViKZo36cV3yCVENZNOmmY467TzRO
         Ue6u4EHPS2eG4Ywjkh6C9wsQhD5iV/zXA6Nw2NwBOT5aJkwrJL+4lZaCXVdHgSsc2eig
         MLamsQH1Z+Cb0hl++lmM9bnFZl/rLyL6aKqy3fPQo6PjNhDBwZLKH7Sn+HGU4LMFt3yb
         1t7t6ZBzvbcWuUntxNOx/gqDIrYVT6dB3LJUnGgifmFKf14sYDBUtepUC5rTQKbAI34f
         tuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ouiP/s84DTBB3CgCBBKgMRlCvmNQLtc3ruMbeozhkFE=;
        fh=d8t0NBVIfnZkJYWUjO7oZJ2T0Z11rTaxKlTxHuClkMM=;
        b=NAynZ6pdMZMLxV1S6QnITohCg5b14xOm4D1Sh1LV1Ie//ZjKVCNmZ862SrSQZWjYAj
         9DtAhZpUGH9Hmvuexfr36uFuFU9OMcR7utNuPmxOCq0ZRUzqWNPRbSrl4CC39L0fM0cE
         qshLk1srtY1xds2gCjlILVKAkfyJhRQMk+UMIvkDA5Hzz0z45lmL8GqjXivcX+y9J3SR
         CIp98OP33Vv8IdnThe/mlvTodkjAR+ZcA2ELW2A2c+eZrycVQbwnJhSvqBdVxbyDckJC
         gv24zka2iwNiGGCJXZ349x2+g60i6fFj70pMUKWOJMUvfOQKLU9IbJs5A427xCVUe/u9
         avhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777623; x=1791382423; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouiP/s84DTBB3CgCBBKgMRlCvmNQLtc3ruMbeozhkFE=;
        b=HU3JuVohcapnkuT8TmF6+QOx52bOpVZAIps9S3IPbbRkpGnKxCBUKjQ5SbyfqArTOW
         C3tBoIfVqFT/Zgk16U6c8b5ZL0PdV+DKRu03OKT53E4v3wwsuH+s99FpvD05bMUSMQWK
         r1HS4HOk5yHhzYyqNRbXvHUzAKpAr76Jd+aOjvdcjzfvK+GogJC9lRbg5lmmEU5tWvcC
         4g5bKAZP/3taB8vETUKvANeLgTnSf7S3LuSfWVqbTR/3OlYDZ0+UGhkOoK5S1JGyXaVb
         gr4DU4amAbBsMRTFQcDr6truIB2LF7VRMohFAcHkSR8Cgbrdma5dDhj+HmILILEUiNCF
         FVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777623; x=1791382423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ouiP/s84DTBB3CgCBBKgMRlCvmNQLtc3ruMbeozhkFE=;
        b=EdTiDdmqjEINBybBOu2WLpmk+sbUUJJrHixIT+D0oG00aSrVwtwnKqITmP0xBlnVEg
         8JOREe4E0t5MVw3z4GjNSs7iU/PIxGo+32MjdB6nXboLuDh2tlJj8QTyEECPWbM7SqDS
         hFXqELgn1lPsUbcHj8DzQBzmZFNrJDtyuhZxWVMUK7rSXJLKE4oA+kd8oqu3vLOKGDQB
         erT/SnAfje09rAX7UzeRIEb7ZPt+bv/10uSBzM/LcC6541SOhybzBY1epEi6JnSvcmaR
         WBCI7w3wTic1jRTwt7d2ZC4TG+LubIIjqQ6gZzFjdFz6lUt+byL4RiBPlvVS/9NMrP6t
         BFXw==
X-Forwarded-Encrypted: i=1; AKwUvBxSnWr5ZA2IW8XI9FoV/BrInhxd+AiGD7rjJAmQS7bRJYrlkyFUfCGtEGySJRYmu3WvwENAykQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH+3gOXHVyRSCtSiL9oKT/ed54AwZF+VQk0GYhTdZX9B9FcMez
	5yqEmoMYrSGJ86plNBhUJmJaQMlBzvwZC2lIz7pzsBqV4yNBWCEzbVhgP+WZARy3TxHE+TiPrkl
	gB6HBMRPE7Ms2yt7b2ikShMKYzbc/CtU=
X-Gm-Gg: AYBFou1rS083uUI6mY0fVoGPiwQj5YAQOjemN8fxHidiAMtZyV57vmgUuOH1aD832RR
	pE30Nx1XhxGPvHzaW5XWepKjcLnLPy7KbeiyGkle8O8kQnpvBXCCfSEWvzQklPw87A7Lo2KSNbX
	9qME6S6ZoerTs7I7ABY6FL8VoXHZxPkgSk/m4H836m5U+aU+lcbpGRB+D8qzDBR3MegXolZuB3J
	22SOQJbeIbcmk68npJ6/+6OT1XnzLQMnQSWrmfH/fSDNPLgvgWDyVmwhuDSinULovXu1mx6AFMR
	nLAnXeTIWlF/yKPf9FikAQmr5iBugo1V5SStVe7oWBTB0z+2iuE4eKx0bs0oCAH3/I8eWbom5j+
	kAsj0rCYLZ3ndfCB7blKPBzyO29E9Qeg5Wj5lklXiPRwx
X-Received: by 2002:a05:6512:6884:10b0:5b8:f472:2e66 with SMTP id
 2adb3069b0e04-5ba405e9177mr509267e87.25.1790777623133; Wed, 30 Sep 2026
 07:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-3-sigefriedhyy@gmail.com> <235a33c2-7138-4815-820d-793568757d95@6wind.com>
 <CA+7S2v+VaVYksOpuUKzo+DoWZ97M_XKvnMr8cCcgwTkrOxsvEw@mail.gmail.com> <7d8f1378-d5a6-4a87-82cd-98eb794f85f2@6wind.com>
In-Reply-To: <7d8f1378-d5a6-4a87-82cd-98eb794f85f2@6wind.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 30 Sep 2026 23:13:39 +0900
X-Gm-Features: AclHuK-ds-pquglK1wdrfnVLrVe9lO-XLy96JgNFg8PNJqutvY6kezkk22pc8Pg
Message-ID: <CA+7S2v+hEK09FDv4jLrp3yGLxeFMde0j3FJ-TBytLxQ1Uoq=dQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/6] net: change netdev_hw_addr_list count
 through helpers
To: nicolas.dichtel@6wind.com
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Thanks. FYI, please don't top post:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n336

Thanks for the reminder, will be more careful next time.
