Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C043F0B0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635396; cv=none; b=buASgju2bQaNpiE3zgDGFMKuzwnBPZeMqLOW9kPI6ZHJn+QV6bMuGfsKiiMSOvgg5wwFcYY+Hz0W6SmejfJpkVQEnvz+3EyB3AcNoUNbJM5I0cu5VSZj3yD1LO9cYjMolGf54TZvNoNrNWBQlV+eBCJZ0ZMpVXauRGR/5bjnox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635396; c=relaxed/simple;
	bh=jIZxgWsE2FlOtVO5376Pn1pyqlZtQZ+iESwhTq8LrB4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ci1ENUlnouUvp1SH9pCSYzPQrPVCWT+3pe0asmQh3rLw+i4wrm58ThVP25Z8Nxmxvf55NMNa/zp7BIH4NXJwjkqdiUdqB/l7nSIHBrBTKrcy++6DusjMCmuIiKUeaQ/AYYD2OK8q8Ncl4DxQCUDu3nqixc+3WZK0+MkeaSSZQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH0qe3Nd; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH0qe3Nd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so1019931a12.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789635392; x=1790240192; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLm4i5WQRLdUidiwhUlUAhZXGo75U8fAy0bx4RwiUsc=;
        b=jH0qe3NdA8XbrWkXqAt5MRZlR+M+nLt1+ZTMQPdG/E/RUfFT8SggkhqsjWTSp+Bu0N
         jPk+2AO1i5jZ0MI9PtPPI+YVb96PWHHAtCAt5LKlVgCPdFIdkaHzih3VuTEGnks2aRaS
         eT2imhA723ewHL9Q/d4OOk1vNwo2NLlC3xFn+GnOuhWzei2m+tQi5qMlPsPbL388er8J
         xPk87n3Z/sDsJ7YWfRz1IsT9Bhq2f4JAqwNIhkT9ABfbsDoxvwaFGP3Vfhe762g2qn/u
         CDQ0FgazWGwdhfqQvd8weiY8sBwM0mEMNYhe4mrcEzvxeMbYynjd2pzLhaAZ8Dfyo9sI
         MgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789635392; x=1790240192;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLm4i5WQRLdUidiwhUlUAhZXGo75U8fAy0bx4RwiUsc=;
        b=fpo30Rm+FNHM8P0zc4C3jW5z9dren08+kR5LcxMAYIjHuRsDWPM9f/t6yNGaoNRdQM
         Elvw2RN2kTrlqU/rqto0rOzaaTmvPGZIY7b5V1PGwjg6PiKsKun1ZgdRC2suj+9w6Mzr
         mgQIcfnqUVhlERTKGEXLqB4yMnk6H+PHCLf0+g71da7h0WbNaM3YSpu1wkMxlI0ewzD8
         Oh9jBiyKD5qwJAu31MRq+IEkFbTIQfTgL5I7C7S5Eg4ph4KgTGSa13eaaapB3HqsEJN0
         160NbN3s67PU8y/Rm2XQlZffLXM98eUo4LlJ9vD0fmIuaBDFMD4iGHLH2QEEOCuAPScW
         C5lg==
X-Forwarded-Encrypted: i=1; AKwUvBw0lMVsMyGzs6oW1mEd3IH2jwIrOmjymVbmE140nQE/Qmn2DUQMjrSFSmzzgFqlud3GKOCZgaw=@vger.kernel.org
X-Gm-Message-State: AFuF++lK6txPPsiCB0PP5D2ieWgLBaWfyiPEUW4/JbpibxfUG7YrxAP2
	ZrHwkiEta7HK2RJV8o2EKRvwEfTYyaDYY+anEoCKPvgrqshGVYRUcD1LOETidA==
X-Gm-Gg: AYBFou1kYfHjkGhKyPi4cW47VS93wZgqmuRoMqEdOmZm4LGGofYDQC1bWjpnOqmPxES
	K/a/Sy2w1jJ/jfKMwjOe8ZWeYWk2TJuCg96NNmZfOrYdmTn5O/rKccQGxJqK7U7FL0eHT+amWlh
	XUVhG/53zlMU+qDEZTqFpUVCDWCaLR0wGupVOtXW7Z35h4tXkDiCaoJeVz5PvADb2Vu9gSTY/tU
	1GBVeX3sAPZVlWS3xglpiRUb+nioil+RygvkU4Wn4VKoS36QygfI0Bx7JK6TUlugl2M58/7HRea
	LS8mdXkySMwbW0lMhcoThl2dsDvJdqpJik3NVf9nR3Ro8GSckF/PJ0Lov03LNTLij50Gyc/P6kp
	FXn45AhcCmUEKzHQ6/ZxNLXOJwtZJOuBBJcgJ0BwnmB6ActYEbxuzQ2xIm9H6bjH2wbgbUO8bZu
	oWlvucm0Mu4XVhZw/iOZSW/t1gPlr0SbYPycVhrXt5Ma4gwsfYOjVgwTb3hlsx7nAbCZUsMCvKL
	YL8WILa
X-Received: by 2002:a17:907:724e:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c29e52cda3amr455367766b.24.1789635392019;
        Thu, 17 Sep 2026 01:56:32 -0700 (PDT)
Received: from imac ([150.228.9.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29e86309a2sm213851566b.45.2026.09.17.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:56:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 2/2] netlink: specs: nlctrl: let getfamily take
 a family id
In-Reply-To: <20260916021516.1701760-2-kuba@kernel.org>
Date: Thu, 17 Sep 2026 09:56:24 +0100
Message-ID: <m2wlskntmv.fsf@gmail.com>
References: <20260916021516.1701760-1-kuba@kernel.org>
	<20260916021516.1701760-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> ctrl_policy_family[] accepts CTRL_ATTR_FAMILY_ID and ctrl_getfamily()
> looks the family up by it, but the spec lists only family-name in the
> request.  C YNL generates struct members and setters from that list, so
> struct nlctrl_getfamily_req has no way to carry an id and resolving a
> family id - the one a client gets handed in nlmsg_type - back to a name
> needs a full dump.
>
> Python YNL happens to encode any attribute of the op's attribute set,
> which is why this went unnoticed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
