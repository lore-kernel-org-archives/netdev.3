Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4074252B7
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007259; cv=pass; b=Et6rwFbX4+b1LHaUlGo2OZX1AomEjlCUOowEi6OtSDqgee/NmF6HrLUiPZlfeSZQDHYoT6UgCeHJV7pT7JA4+xcC0kEJQVvmGhO1e9gOqbuf8XRNxxTL3ev8acA776WEujEWx23rLG/3MPiSr1KgN1a5ZFLcUEHEABSbMe5WUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007259; c=relaxed/simple;
	bh=97rOPPnf9LFesVvm7EtFynTdfrnteKSmS3LA7bTlCDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjBTr3/usuKlkZ9F6h8XO0TpVsRQYJiqyXnubZBy5msNoP7qMk1qwU4pJokh+ssaidmVOxdV+zoVmLK39dFCmchItCEr+d+zs4Hn+T4jXNATfFhhIfaJiONXWpWaXikvYhxn680YszB0/Ddv/VCHqi8rnsGIeqyR/kxYSA5XDTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnj0bn3M; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnj0bn3M"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2022323c37so256085266b.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 02:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786007256; cv=none;
        d=google.com; s=arc-20260327;
        b=L9OlKf1OOG58V7aV7hWWu0JdIPbo+7rvDWF6TwcLgT0EtmJDCW6bu0ZpAcIl8Y6t5A
         ixfKH4djFd54S1kp2wej6Sy7DVHm3nftMqZzQPS7k5Y+1h5+9sfTkW0pa730+wzZeV4e
         5dJTI5VuIQ3HZO+3p18gzo7TXQL/vuw8+jZFsjVJJM/Ws/w1BvXzZ66qqSt4FssiLsue
         k9uOrxlhWK9Enj8LhR/vP+ZUn1JRAzCqY7fmey1oes4Li5LlV/xVxGIdeZ/s7ECK6ihr
         e9P8JFl4nsISwld5a8GF67YzHZ74C8cppt82WI/PWPB2Oec1e9Ueq3b8lCLSSRHkI2kf
         z+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=97rOPPnf9LFesVvm7EtFynTdfrnteKSmS3LA7bTlCDY=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=IFB72QpMHaWXyophPiUgI3G4HWQzA5sq2ToGOAbz0OsR8ehhUoWfLvF9OBmOknZ/pV
         6iCssGp1V6OYZHeJcBm0BwmDh/IcsulfdbwCkpzzDV7sbMO1/XoLRvWPlgQYuy0uDXnY
         fURHYvW/6LlxBf4A4nHrKtkV9GyRhTQ+2z1MlRLAnJeGufbh6kP+UengdOE3uL8qdkYN
         DN9DwZntr7nZ8u3os53Xsm7DxOjPrpF0HF4MPyte4K7i/cNyRwz7/CP3d0ODDyVUI/hL
         IOYf9lTWQ6AP3BztOv+QIVyJVoWK0oYZPscFt0GeYOsxWeoyE79qzQSm90WbLWoGQfFY
         x93w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786007256; x=1786612056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97rOPPnf9LFesVvm7EtFynTdfrnteKSmS3LA7bTlCDY=;
        b=Dnj0bn3MByhFpoQS86b06vX9EIS09gFeERYNig0VADCUI8phflJGHsB9qEHs1eG8uj
         iQhjTDc7gVrKgKHgVN6a/Id6pzDcPQ+6IL/EfKfloueKZ3SGU2MSyP4QLOSoBZYCQsB+
         ULVA6SPk1vehWBsbuUm/lidjUHAaxpYXN1+XNIfm5P2U3CLNkDOxkbE0MOKR5uWnTysV
         4denr8ZyiXHq0r0XLI8CMFg4ujyIuaf8tR++/gbZvSEN0WoSynHVV1+wVWnPI/C/Z94M
         toYjEyfZkW78sABXOkSPSCWVK26qQvBUeg7ffuqCJgnWT5Q1vy3pIfm7to48wnEEgr/Z
         LV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007256; x=1786612056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97rOPPnf9LFesVvm7EtFynTdfrnteKSmS3LA7bTlCDY=;
        b=ollH04IPlq70d0wzqUB/ExpHgcmQBEGE4qrp923/vGcT9L1b6pdj9qw3vLAAzE0b//
         RcOMF1C8bX5HNox8OQoQ1Jhhh73aT6Dig9SYsKM8UWDkXDocB/MlQ73xIA7ZPrpyeiTD
         a1U/UVngBZAQK0fLSoPZsoJ/ka8q4vUR+uxGfytitVbI7T8nzsKdY0I4xmZsujejTR1T
         COod7g/OwKHzg2aompgN987hTa5GIkD5IrUgrto2XphewG4uf49IwCBxfyXsG/TTKKuP
         uG/x0QUwOiShnGmldMgC0nN9tu88DXw5TyrjYrZX8IN2/TsDcb+vhmgcSBcFcyaQjpIL
         5APA==
X-Gm-Message-State: AOJu0YyI+d/S/mcJqhN67gZFzS3BnsZULLKp3PrGkYEapFH8TCI1D9G4
	+FhM14SQvjrkmQgQzC4O0tztMDpDod32B3iLBuCWduPaiJHUL3Bd/lSKr/aoEyx1/AqikLJXP7q
	mnr3pSwL8xvtoF6F/QixOmUTkMNaTra8=
X-Gm-Gg: AR+sD135QG2L1tzBaBCtPUb/y0izD6HEKou54buAXQIPm4U3GSvK0am4QL1p8NwkKK0
	JNxJFEeXcLVTht9O242wmbo0omfALm/Wd50wL8WvuyrQL+YCIEQoewy8pNcQ+IyYh0vFe1tesz4
	42pl21HrqPn/cwnRfnIw8kmDszopjZmqku+avMbRCphUr5GvAgRveDHfgszKqC760ZQ9F15kihk
	YjVbjbSf7SUPAMkTJ9gkd3WVtmpwsd83kBSmbURyVSl7dtaT06PRCNG9jBSm95jbl7RdTnNXgqC
	l3SXsiFIqDau6/vPRQWnwU3+ykKHJgwWJtihYpTamP8dlA==
X-Received: by 2002:a17:907:a0a:b0:c20:2eee:97be with SMTP id
 a640c23a62f3a-c2039d216dcmr646342966b.7.1786007255234; Thu, 06 Aug 2026
 02:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805085540.452260-1-a.shimko.dev@gmail.com>
 <20260805085540.452260-4-a.shimko.dev@gmail.com> <64da17b5-2ba2-4dcc-9b8b-251b208e555a@lunn.ch>
In-Reply-To: <64da17b5-2ba2-4dcc-9b8b-251b208e555a@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 6 Aug 2026 12:07:24 +0300
X-Gm-Features: AUfX_mwuSOKOGcIjuRBsl8lw_MRKN2MonZGRndlFRTqw0YlRneDZ_RHIgO4jI4M
Message-ID: <CAOPX747DY2pS2Of2+ysi5pT7gFmbhOqDPBLgzHCr308jZxtqXg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
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

On Wed, Aug 5, 2026 at 3:40=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thank you for your review.

--
Best regards,
Artem
