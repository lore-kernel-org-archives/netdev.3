Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960662;
	b=gDA3qjGb/THHH4LSDuyxLUFlMZixPQEVsA9IYLHNTHmQjZbjCgwoYUjuGaZJJxK9Ogw0
	 D6t6+QKgGIJ51xVDB+AK4lTe/1Gx9hrcWaQYKg25oiRAtve8VpJfvjwQ51VWkANEFQsCD
	 O9LyAflJD1+74B3jwr7DN20qz+/wz53PuvozLvy656LWBYKOFjn2MtoIdslL8Epmg2e86
	 To0v3dHCW/2CO/unlEIqqPoXOKbFjbvucbK+ETfj0aFRHJWFI0ZfAE/aTCW+qhZo8s/Xh
	 +su9uxnJLQqN4RNv4VL/LJsKgE3aiMyAsvaUvyF06F90P+Xuon+VnUpSQVqcvFrRyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hCvngCCmtMWznCnZmouYhzYU8/Rvvngg4bkbOzBf59g=;
	b=mNN7+QWBkErBSilnimS+i14BdUUaSv0V7nfEprdANIPOOPJHBfNympRuPJKKbOJ/W8zA
	 OqSgPHZjg/hsZK4QEj/I2cxzyStHOIJUqLO8VPHWX7F82wuDDqYozTngm3mps3L+YLb7X
	 igEUyiH4JfurvjnfAe0qIWm3n6t4tcXY3WZR25gAotTtfmikOxm+NGicNt2cV3xpp7omO
	 LzMkG8DEFZifBTUiNDHsTrgfGQut85v1Hoe6tLUzR8pii2t9peSohMCsQOJv/OPSrndPw
	 DtkXuUPz0DreodH5vfVaye7GaMta59iJecoxgA67NlJ38UcgKzhZF1zWaeA7FoDF7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O96FlOVu;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BF606A322
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847BF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O96FlOVu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c414e5d282eso255845766b.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960661; x=1793565461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hCvngCCmtMWznCnZmouYhzYU8/Rvvngg4bkbOzBf59g=;
        b=O96FlOVu2AU024F7VM2xVWto+U5/tsLlBuf3bCFhPmRAIuAwq1O+6MMViL+L2q6uWx
         s5vKR732zQ1cYkPLLta3HlOwGu3ednBTGqKoTUnqYYAnawGM3AjGdF4NSXi1OhX+5qMg
         gLEFmlNaidIVnGk8U6D2pIJp0UDItis2XDfpJ6Y4u96MwinFsKtqQgAe+IttrH9+EWjJ
         FH5EeasLZ6FwFQJk80ry92h6j648S9PB0pJpbXxt4U5eRwvM38eEdRuPP9VN2TszgQZb
         bhJtzOtSmwWBZQ5Tajs/zuRpWE/uu7rX/20Mn6PknOSXp4XcYRhEE+aiAbMrCgNECwZc
         MMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960661; x=1793565461;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCvngCCmtMWznCnZmouYhzYU8/Rvvngg4bkbOzBf59g=;
        b=0G12PyWEh/cs6gNCD5BqYno3xu/yysNfUKUyMRd+atbS0tfqwJcIoEwu1f9tIkQYEm
         wTUEpb8Kgkvyjxn4wWJTLzexWmuiUIKKQIpvz75q7u3RZhxaMKQDsOo3SGlM4ptwlGYH
         bhyTB6yrBFgv7z+7AEMKLcaegbfxn9dm57QMpJ2R5O/UwTYn/3GOdsT5Rzi7/tYV6/0v
         dzgZLSHvfo1WvP7asOI4EPLp+qntqFD3FeDrRgRces113hXiaDdFHYyAozKCYlTZzv5e
         kr8jLhf6Iw+S+Jr+zmZM1+rDzruNELThMOPSW6EguOnomEGIbrKn+PSqUpSuXSFqBjy9
         7A8w==
X-Gm-Message-State: AFq9FYIYxmgcLvhzhM63u8ZdSbgAnXcFJaXnSVpooitZoeewjHEFEbw+
	QcEtV1tajES+s8T2P6XyeyIjKmOd76aY78NB2lO8jXskJCisyoU1Nbdh
X-Gm-Gg: AYBFou0Li0ZF6Y3azKbeHkVzDeRmSbqoPVZjwXjBpQTB25ZARF7aTyKHAbpKd+MFNaF
	gVz8PBRiCbiJDVfxdd9qCzcACt1/HyQO6Br9ly50bJPBN1aqDau7lpIWWl3pdcClAnBeaUEubEI
	nhIBXkIYOWXq36bbHywFS4ENi2KamVuFuXvjBQj8BJpwwG51Bc5roNFrPz3EZdBO3pLvfHganO7
	VDvSf6Zr63N9VEdCmkS/zDBzTxzx5exjDrgDZPL7LwfQulwINvUFgDrFhK/6Rw9JA265coIRivw
	pK31NVJPUnOXgMj69ir+fOZfM+9fOH+1j0PFyubahFEBOnf3XAo2e8gQQUJv/yQD1YRKd3+aQmM
	TMbvmDlr2TBGVouGT8OlmS6aixXbIOCVLq2txYMMx/28fxRWrBnKQzvL8meECO43xKqddlwBI9m
	XfRGFb6YS8a6H+94oKeOHyDPt47Y5N2XpA+xXTEsCICDQ0fUJu9r0OlU4edntW6n/D9cJt1cSmk
	FN0wwrTo20Q9+orNJJGblghFaOXbwVsXHYw8de9ynKSwgCmaTYSGyrtshe1fTlmwzz5Oua8ppOu
	3ycqKR7hztlJCebIgQ+roJJ9O5/3rbRQGVn/iCXIpcVxWWmC0d+JObHRYVuuNdCaW0UpESgOch5
	N6SfnpuMAFc53C0J5E4LWVZFrz3m1RbzdgXUwNiYJCXvBMf7U9zFWWHZi6fbX69e84g==
X-Received: by 2002:a17:907:3f1e:b0:c32:9a87:3f13 with SMTP id a640c23a62f3a-c46bdd97afdmr619127266b.8.1792960660786;
        Sun, 25 Oct 2026 13:37:40 -0700 (PDT)
Received: from localhost ([2605:59c1:3500:c210:a19e:c679:44e8:e9a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd664ba0sm238744766b.53.2026.10.25.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:37:40 -0700 (PDT)
Date: Sun, 25 Oct 2026 22:37:37 +0200
Message-ID: <633d24682b0cb4d3c25de871e54f1bea@gmail.com>
From: Selby Mashiki <mashikiselby@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Selby Mashiki <mashikiselby@gmail.com>
Subject: Re: [PATCH] net: lan966x: fix double fwnode_handle_put() and missing mdb deinit in probe error path
In-Reply-To: <20261025203155.455075-1-mashikiselby@gmail.com>
References: <20261025203155.455075-1-mashikiselby@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Here is the additional information for this patch as well:

- Discovery: Found via a static analysis script scanning for
  fwnode_handle reference count imbalances across error paths, followed
  by manual code inspection of lan966x_probe().
- Triggered vs. theoretical: Theoretical (found by static analysis and
  code inspection, not triggered at runtime).
- Hardware testing: Compile-tested only (-Werror); not tested on real
  Microchip LAN966x hardware as I do not have access to the device.

Best regards,
Selby Mashiki
