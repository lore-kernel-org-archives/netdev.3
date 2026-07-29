Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A453A28
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336724; cv=none; b=Yq9mMOb3KRAEWzPC5BdM037TH9AwMCpJFmq8bUX/qWQmpc1iQIEe/r9QzhQvVF/9yti7G30e5zdv4JyKmsXr0rk9tvAkY3bpZVQTihaWCoXECK0Tea+bpMQVMDQo4TOVj5YKVOEDTcELC/arC/EAZzWTjpVweROVSsrErmANXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336724; c=relaxed/simple;
	bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=nI1jbsHDtEJPYFuGi5q7REkhP7Xa9eARMHSD1fdRc0U4EbzPD2V0kvkLdL7+yshSY7U366UcOORloAWkikgg67h9YF1wXhC6YMm6c/hcWYbBYPaw8OK05uHbVkchSchOON2l2Nyk3Z/8cllaafHjMOG9Fow/UVm0/p7mZwYY/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=jr7qJAPP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="jr7qJAPP"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1568981b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785336720; x=1785941520; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
        b=jr7qJAPPhIbXWbswPVfoSKSAdd0quLmOe2Fyej+xg74/sBFhCeKX65iJVBQ7gWJXf7
         WSnPIs8MYiDUYozMMvvwhesZaqgkij59ALnA7ZK/BzptFRsY0WzFzfBTn8nqZG2RAqgw
         4E+1dzZo7Qv81OvtimbydmozTRa+pw8qeBNy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336720; x=1785941520;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4A9ljZvg/DonxCLhH0BMsyCR0SqJBPYfHV381hA4JWw=;
        b=KYwUSl5acRyw5W+eaRgeIEzhK5XNZAkTXDu8fuNmr1nM8XnOwScVJXmnUY48Ble+z4
         Xt4T7q8/ha8FXmJtymo0Oxew6EHCd49n3Bh1sXe/ogq+7CKGRyCiDji9MPY9zVB6zkS5
         OfxL67NBVsMUvEm6S/bzldEOmFPSQs2NMLEyIwrf5i1gjvt7K8inC6SgvqdihasvR11R
         CWJB+aRshQkMjWIWichPLsXQEk1Thm6AunxAUoT+F9KkhdQUYKvm33ZAIGuVs/AMaibo
         iY2II53/pE+DVwCDrcLnoQyCFT52+oTlCLLE4FVucPJRlzVIHHiIO283Jc+pCCwbIzKC
         vOZg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/4rGj+X3Q57r19Ot8oFEr84nQ4YtOKiJpWfFcpSyhbC+wB3mpbSxhbwRkOzpQY/8iGIxvjwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8ruWuyLUCDh96dfpoCV/YnOFOKBj/obbFV85LcuVPmJ0Dp4+
	KxuUKWuhxfr0XOqHGg6GXDndf66JxRqW04NRpi8GbK9D9ReW3kY4tFBR3wRtWJf6CwH42rLj7As
	GiS9ukdI=
X-Gm-Gg: AR+sD12GLNVGogSyUfc0tkA6+TuUaEx1Vp2zVMZ5ANTWWhdgw/K+p5MYeolmo2Vk9MM
	2/h20yZAq2T3CijhuPgM0fKmWwRNWFV7tsMHzjM5vqumg5g2slMLP8X3CF2hL/q8WlRYFT+avRp
	frLXLDm+lCdFDJlTOoRO1QPwIZfcGmBo0/MPmoNmxec2LfcPpTlzvISS/Y1JBIIgdzRUyAk0rMN
	Ou+yXOdwGJzutkMblhq1xPSZ00mSbBbiJDXlzsFXzSzuf6O0kaabYlvMTP32DP2MkYamwlsgrsc
	cBnwU9yQyXkzX5qmJWpkEtVqu44bh21WR7UgfO2S9gKn7jv94XlHhvQAGWml0wgfrzQxWnB3jnj
	t/yBT+VqOW6aMGFj+EIyDXTwqJcu4RM4DJzCtSBl0VfZlNHOgylczZgRbkt3M8HCU9IKtQkH1af
	VnTw8FKc05fVNvO+E6r30OOmy7g4yNp6TOQSC3egYojGWT0wWqeP8PQiFrikN/Av7Gs8XlTSlpz
	NJ1SqD05A==
X-Received: by 2002:a05:6a00:2e28:b0:848:2f77:e2e2 with SMTP id d2e1a72fcca58-84e933abf71mr7498955b3a.75.1785336719840;
        Wed, 29 Jul 2026 07:51:59 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:11d9:ccc7:1d44:fa02:b04:2b65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe24e6csm1540056b3a.5.2026.07.29.07.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 07:51:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?wq3tmY3shLHspIA=?= <hsj0512@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] e1000: drop dead switch statements in configure_tx/rx
Date: Wed, 29 Jul 2026 23:51:47 +0900
Message-Id: <38144712-66B4-4580-8B9F-708500718E34@snu.ac.kr>
References: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
Cc: Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Abeni Paolo <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB59025D22F4D0A00D5A8671ACF0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
X-Mailer: iPhone Mail (22H352)

Thanks, then let us keep the switch statements.

> On Jul 29, 2026, at 19:07, Jagielski, Jedrzej <jedrzej.jagielski@intel.com=
> wrote:
>=20
> =EF=BB=BFFrom: Seongjun Hong <hsj0512@snu.ac.kr>
> Sent: Wednesday, July 29, 2026 10:01 AM
>=20
>> remove unnecessary branch
>=20
> Hi Seongjun
>=20
> First of all commit msg definitely needs to be extended. At least
> start with capital letter, finish with dot etc
>=20
> Once sending to netdev please also point target tree in commit title;
> net-next for this case.
>=20
> I see the point, but as the code is quite old and its extensive developmen=
t
> period passed long time ago, i believe value of such cosmetic patches is
> rather questionable.
>=20
>=20
