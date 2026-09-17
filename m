Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BF42E43A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640375; cv=pass; b=igButfl7gbD3vjv21b5lOenCh+vB8ccxVjtPKH+9rVDOO5dB8HnFZD8Gn3wuoJ6RChGJQ8G5jxCYpKWHl8Neqvq0NxFEGNi/zurAdCzj30qaIrcEpVQdbF8xLK63UsVS2r36vXk6fvylgb3M+EjueJ0Mu/7Q5jM0ruUtGcwmlu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640375; c=relaxed/simple;
	bh=OZZkcQcQRsLs20mpGwyMZ6wsHq8iz3WdUZYZUnZeC3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgcJPWNdFD+6nU0OQWzGMtr2gTCxh6fJTFI/393x1cnW3a5lEV8pdoW+ebXSuMEXdIZZbIfEf4gTDTRiE3GY7nFRT1j4bpBfAoRLmux8aKylgxgq0iBSDSklhMQoH+GWUg4XxOzRxKAfyo9vGwrW/7ysgJdtO70YwM8MQiFGqZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHpewDY9; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHpewDY9"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so986020a12.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789640371; cv=none;
        d=google.com; s=arc-20260327;
        b=T88+0eKmgYmm4fBLw33+8QDaVlHNYrKTRlNiQVHCvpaE03aF0p7oFJf9cXmmsD4yKb
         ZQB5p3XUkdmObUDXJfcDoQzRiNbK1VeTwhfggJZILw7DatTI2Hv4ToL0TTB6bFOkKPyZ
         uKHnYKw+mTiM0RJ0qOPyWLCBSgDe+cU8Rx5qZa1NuFI42vdgjxcM5GYhjABfIjwnyqea
         MjJaj/ULUdzuVgbkCtZ7FStlRDq0YdQ+ICk5nkQkj9SZvOA7kMwiAIdUWGfClPyeSwXt
         vajTIC0M6GWv42iEx+8q6MDbztuLinTWPgFYFcc58WOzhSNSi/cAonjNmq41D4qGUF2r
         qVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OZZkcQcQRsLs20mpGwyMZ6wsHq8iz3WdUZYZUnZeC3Q=;
        fh=2/2UIJJiGgFaODrEcGC4N/TcD65yZAZ9SVSG0sh5NfE=;
        b=Yx5Ow8AxMKI83NwMk4s3rUFVw+Anv2uIUeIAiyLViHI7x+DVnasHVewdsnnX0J+jPr
         Wi712eXb67/S1vwH1+rRkl87YN7/askjWG6Yx/9IPl6+DxHE+Lzg4YNLchCBFTzpk8Uz
         AZdtCKczZYjAV6t2n+lm3wk5ps+1HJma4pLDh9+PZ8c4PBpWux2C08mM7rJ03NosH7SF
         4KaU9Lw2i2O3rJZk/hRlNPqgPWxGz6vN7zRB+O8XJVvRWgRS8kMPMroEWt+208454iC/
         99VWPG3TAsPNrNVeZFqrhpAci4n5les33xOrPZJ5KwZ86ZfphhzX9nNVE+l/bjTUfQAW
         dK5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789640371; x=1790245171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZZkcQcQRsLs20mpGwyMZ6wsHq8iz3WdUZYZUnZeC3Q=;
        b=pHpewDY9ga7vzKTLTLziUlUeylKGYEflAxCde929lTHRmhn8wdE2w1LnAorCY3AD8F
         HVM/WfRoZQ4y61UMsQNaybX0ER2x3zQm7pbU4LhZhp1p+2xDdt/KtmZ4zObzozw6LDHQ
         zEs8+CPyKsJtsuI8vId+ph+luXX1kmIlV+Y57oE5pFlKCJQmdtGDneh+yMtyGdxZacBL
         wv/fEFWYpWjskYUhaQN8hN+lkWCH98bFVJJZkZWv7usfvfF3CuCl3dpk16O+ZMl+4pNy
         ouryxVIuihO9Vtm4qv71RLexgVLJrDDY1j3FW02EE5NgwWsitRGp4SUZVVSGJPX7LSwO
         Lw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789640371; x=1790245171;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OZZkcQcQRsLs20mpGwyMZ6wsHq8iz3WdUZYZUnZeC3Q=;
        b=JDWO5kY3Fe76YAEcevKBpiK7PLNc7eQ1ZbOUEWEXAuYXBACu3trhfE4Ehy3mS3HgLS
         mmXHdurwsztRoUrPuXwXbT4KLvpVgyWLz2d3doBbOTojPAO7LNtbEGXZWix5hLGDRvHm
         cgsylPZ6mimdZkOhN/z+nA48Io/F/p+IOrVZIA2kSenp8bfEUtwdcYDjfZkbUAynHvOq
         dt3o9M0XD0Fo1/GxDXWQo3IjppvcZveLehCM5tN94rkEGpbx6GqqldDIspoqGjDAXP05
         7WyR+ujHICOU+xJtRzD32A5pyUa4PhfUKxHz+H9LHoSqPutAIM3TecJUmeL5UnVBs4Iu
         BBDg==
X-Forwarded-Encrypted: i=1; AKwUvBxirIeOWiBUoS/169MS3m+LdunIqkPvK3YLIbH7wIvyBfPELB7wA0Oi+kJvfnZTrnoRpOcjE90=@vger.kernel.org
X-Gm-Message-State: AFuF++nsyyDXMFVPxbuQ/8DDEIX/pegfz6gHjZDIDIdla21tcB7/E4YL
	2FWmtEnTPhPCoR/X8XWpZKlCqKy1U3TW+lM/w6zQ3cQEIJ87WAjOyZqc3XaGLwGg5RFQt/LYxRE
	cyw6Xj4oOyqwWCVOabNe6MmZFUEmqTLo=
X-Gm-Gg: AYBFou1daGblzC3PmwkOjZIH1f4k/H/YMBSLdsoENrA1doKXzrSJpmTqfiffnq0Ztxr
	oJb5Vor8HYDWJLbhwRxM7Y5PWfOPI7emha5OGaTQsy5mpUayXIUuJj7Uf3mA8YOdeH7pTYH4t1a
	SvRcpdKr++giViItb/2iMhPmMfoqp4qdTxYzpn/ObmWD1VdIqofu2o/ZBvFWqA+fNVLkPTkOYlK
	wKXppnGrpeW/fknbtMJXO7BiGBlDA+lZ3CQ9iQA6Pnxm3vonlpRuV6wQq8dhIr6HWBPyiYgl2VU
	h15J/mjK9mFnionssi9KfUjVsBzyJyMrzxH5sk1hZIuhL7S34Jvx/g==
X-Received: by 2002:a05:6402:5d4:b0:6aa:1cf5:6076 with SMTP id
 4fb4d7f45d1cf-6aa222624b5mr8986431a12.1.1789640371205; Thu, 17 Sep 2026
 03:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902042827.87534-1-running910@gmail.com> <178851771440.4131868.15230379075689542594@kernel.org>
In-Reply-To: <178851771440.4131868.15230379075689542594@kernel.org>
From: Zhixing Chen <running910@gmail.com>
Date: Thu, 17 Sep 2026 18:19:19 +0800
X-Gm-Features: AcwNN1WrsHmCbjMBAWnrYk3-fOh9nGNBlZhLhY3ZUpEyCRREtP0htlI31C3PcWA
Message-ID: <CAMyuFdV6gvHRhGQYbzcnRhpTs4fAwbss+MyHfKA_aXwO73H7Qg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] pptp: validate available payload before
 parsing PPP fields
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Chuyf26@linux.alibaba.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

In the v1 discussion, you noted that a Fixes tag and targeting net did
not seem appropriate because I had positioned the change as a robustness
improvement.

In v2, I changed the checks to use the bytes actually available in the
skb instead of the peer-advertised payload_len, and added
pskb_may_pull() calls to ensure that the fields are in the linear area
before accessing them.

The v2 Sashiko review now suggests adding an impact description and a
Fixes tag, and targeting net. Patchwork has also marked v2 as
"Changes Requested", so I understand that a v3 is expected. However, I
am unsure whether the changes in v2 alter the target-tree decision from
the v1 discussion.

Do you think v3 should target net and carry the Fixes tag, or should
this remain a net-next robustness improvement?

Thanks,
Zhixing
