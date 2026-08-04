Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22B37B002
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856342; cv=pass; b=I+vPZDMNTC/ZOAOaCvl8qxzKwFqWYvPGz/IPe6MIHcfH6NprRfhmSWX3VVXXpnXX5fCpxoWYVuJvBMYmhGr0DpNiuIkxBO7b+2/7F7Wau6tWF0XwWmQBFDy1Q87RjzrgUUeG6UbqlBopLAzOq1SGRnLvNthC5iJyKTfku9lAWm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856342; c=relaxed/simple;
	bh=cjSC0VBCJlRsHK9Tnc8vxBqu9ttux07An39HyrNLSeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shaiq/NFXzPJOKunKT8wBzXVzxiGcjmU2kUv6t83DxDLfMBwF2l3u7SBXlKay98ZBi/JwC5bjtYrBU2g038Ow00uwq3hYw2L3REI8pqvJvbUuPnCnBWrcRfvzmCIgjSKTmG2Kgc7S9FtsaG2NWL3jwX1gmz7/dvCQPSjr2t5LXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjW25G0R; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjW25G0R"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c197e7e4e94so803476066b.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785856339; cv=none;
        d=google.com; s=arc-20260327;
        b=QpqCa5y4onbwVU7eORz7gqMhTvg59nm2+RNow/q3sSHzpo3d1/8l4CH3rElTt6y2sT
         7lBNr8ri/m5o+IM0IqCa4GZK0/Cx5VUxbwB/mugKD31HONCyC6+oNlktpCAQByLD7jCw
         VCuOo74UY56TrdIbbFnzV7db10gHG1BkgImPZbrL0AWyr2xkievt1/QW0A4oobhMTufS
         NH+Fu9gmflIJGAENsGNTHma9a82dg7b0BvNYDa5C7C0TCJOjy7FL7B/WcfPMyaPOKjzS
         jnbAB6QtGh41JJIFZrQetetLSaRZzBW7CiWvCbCxFB5WLQ92zW8oNLrdws9460PmPjJL
         BKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjSC0VBCJlRsHK9Tnc8vxBqu9ttux07An39HyrNLSeg=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=fsEdQhThGwinnJz+NUrlLL9iDs5NSp9ml3JSXFgm9P9Z5+0shIIuEQVEanVyOqfES6
         6tgHg92RWTaz2vwSS1C252OwOl0i/DN3J3DFftbKFYLiIPj/NiegI3K8a/+k0F/4QkKy
         A0mrsXsgy/qRdQwhTgV4ozo2vk1zlVRY3jG4ZfeZKA4zClDST16QcQWJmGIZum6ZzSz5
         xTHjTSSG2uVfeW0xCY5d5ubC7ounELOcK9mYGAIkdTmaN4oTMkGLk/gKe5MeAWnHNbeW
         fc7yl6C551AqG+lOhlX9FZOUayc4lKI9U/I0IbBBwmt4NSqg27Q25BIwNfUx8PrXlqQR
         9Y+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785856339; x=1786461139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjSC0VBCJlRsHK9Tnc8vxBqu9ttux07An39HyrNLSeg=;
        b=VjW25G0Rss6XwUaVtGx04JAmB4gl7fBIZn6eNYltP4JHODs4BZ0gmWmYmYj258T7h7
         0GOnEO/D67UFkZa0Mg2l5KGVGUoDHbzb8LMQ8P0YbEf1fVmIQxRZ2B8ynluFM1P+Zuhn
         yCj30Rakomek61pPl2uhSCLeU/WMx1id0v+jwJMwxBH6/VNGkpeSj6vZAbb+fv2zzWHJ
         0cq6AbQjueKzUSzo9ZaZsO4IS97Be5eWYClpfaJTfJdyidnK5zhrGm1R50Vm/qotpisI
         MKfd2xjJ6EhXhzt6oWTySIc1i43378aXG+f9SB/d4a3fYxKJKu9JHPncHqWBdU0b434f
         nYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856339; x=1786461139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjSC0VBCJlRsHK9Tnc8vxBqu9ttux07An39HyrNLSeg=;
        b=obZejj2EBW2dMXK3Lj21N9jH7F4K5nN2mDXjGiDBu4mkOkqMyGkXxKKB7shrbXxEO8
         Kc35o3+53fV2i1vlXP0sK3gqzscRjGlyyuN7Vbnu2YLp75Wmz6GoWTJjKGlaZdabeo93
         VeyhxqApWf0jWrZqNts/GmeafuTsuwX1nNZ5r0lelvmDOQHMhx/Nxui3WHXyxb30rYKL
         kS9hfAKFXKYJlJBmafYHmdI6fpkS623eUQa8vCj826xxPAUcddhCN1NLi1sOb4ztq9hu
         k03sBFkFYwymSnM0UveTBDo7fkbJywtGF78gLg/wjT5jstsU4bc+Th3rFq7C9DYtGTLj
         G35Q==
X-Gm-Message-State: AOJu0YzUhUVJDGa/QZAFL3RQ1ILRrTxWxMzj8SOx9WENSrTU8Xy+vh0H
	yVCgnMMuui9Df/KhiEJm2vvTdOCquXlta7KYNK+2qE/NjAsdscLOGCLn/f4WE+XUNxjnWFmtu5x
	VO3WuPcvQ0rkFKKLBl9nAfuCbXbJWqsE=
X-Gm-Gg: AR+sD12G7Ffpje8y7lIRVRU+Qj6YOdsGpHyClU/JNQT8l2PqQeofQretXPaFfZVv5Ue
	vZXN46JGoBEWoRDFXUikN+avL3wyaMio0oRwex/Kq6A9JyEPoOUKBLOg/p15ZogayEHu28ticta
	EvlkKx00YHtBs0hdYvxb21JKxRmstkJ53i0mt1HP98cxjzJQ6ksMyH1Rq5LTH231bZN2Y6sEe02
	7V1Hk/ZlJy0h2nMBH76KrbXhdK+iH6vs2dd0yVIxODX8QKAFGIVIV9jIrH2J9pjmCnTklQLMzz/
	ihKd4Zq7pOBr44Hy8K+uzjCQvM+UGD0WZR6hshf9UpqvkqwyRpZG2J/k
X-Received: by 2002:a17:907:7283:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c1fe7ea3bf0mr1264423266b.11.1785856338657; Tue, 04 Aug 2026
 08:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch> <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>
 <2ccd6223-dd40-406b-8869-021881755f72@lunn.ch> <CAOPX745w-Hfq1k+H0qLWQjsjY-5bb_9N9sw5LBJ0QM-n4j+D+g@mail.gmail.com>
 <5ce27e97-bb4a-4f17-a445-16331af0a6f5@lunn.ch>
In-Reply-To: <5ce27e97-bb4a-4f17-a445-16331af0a6f5@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 18:12:07 +0300
X-Gm-Features: AUfX_mwQsUa4lDAx1alAI_-UYCS_l4QLs7qTpkYy0RJXxYv_OxJOUZPf5jgwV5Y
Message-ID: <CAOPX7452s9D=m0wS7_zwitYTBLeL5aZ=H66nBWe5eXc=m56CSA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Aug 4, 2026 at 5:41=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Another things to explain with a comment...
If you don't mind, I'll simply update the DT binding example to use
the standard 1950 ps value,
instead of the platform-specific 1050 ps value. This should avoid
confusion for other developers. I think it's more appropriate.

--
Best regards,
Artem
