Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6A511E8D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595851; cv=none; b=jetPJlSy0y3HBW6Sly+BhQLieFyle6TlTpLwb97suWqyqt1a5+MeA1KMe5zUlaFDqXWWg85Ce3PRgMSKjimI4BgA/ga3t9LW+bIjQl2VysoFDtM91TkELzJFQ8VU7dXyjzH0ti//TXinccICqrw/Cql+zrsQE1cZRyVBTMbENHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595851; c=relaxed/simple;
	bh=r2huojaIA0LnZu4Tl80T3zwgfYPivrD9nPSDp+67hkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI28oHmAESwYVXasm+KWnw7Vii4wcfX1yMBk4qfBegw0SMURs/a3/G5G+7JD1eswxGS8Seookdfxi5hzSTvBNBcYY1RUxBL691wC/Ze5xq14Vpr5uGUzBUUHZICN0PFVngovmIqtufwmcoORzNKiLS91f0pTefFmkKYHidYuYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWUNV5Nx; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWUNV5Nx"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e82ea30faso289945e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789595829; x=1790200629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
        b=IWUNV5Nxlbcs8aA7X5OjQ2vQad3/VDLyoPXltbPPFo8IoA3BbLuO8UQ6d5N9MnD/i0
         6WvGBwOmiNZOBOsl5z4ypzAsPtr5OVaE3VTss70oegwJgjuHlJTmNCVg2OQoIydbyYKC
         KNHt0EiPOOpD5agUGw44EHmX2NAtGeOov6MuDp0T53nQAY/BV681j/IofRzgH047Y00t
         j//FcJDnJOIkvjW8aoVssTL3pX3lKI9IEGUNydyU2hJogAqGXdcSnsBDjaNFDs6LGHxJ
         b1yIix9/JYMLp99YDKFBsZ/LFIauNlCjZvWeTJRDzIGwScyOv6uho/5uo2k4/DAifXiZ
         bMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595829; x=1790200629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mpm+rXQ1nRbGhGlarYrHhDYEJtHCvYuH4SNSCHxwBYg=;
        b=eJBTPQSU+k3nIxv4j3eI12QOzb057tj7dbaEkRrF6QkXnizJ2kvqte5kKe5bZvI+Zw
         kA8DtFzbh74InWJG+5Sdm5cT7CMHgYmKg58Gqh8yNsjWlEgoqIb6AfPwDAPLNKCQ02Ww
         q/m5xFuSf+Eayll0L66ITtO99T8DDq5HhWMC9QJQzfLGlOGYMsARGt9XhLKPoMG4Vlej
         /j0OXRQcRViLZH2BsxKHn2DqFRg2lEUrUiur4/zjzRX5w4XIl1QkXQoIIVgt0QfEJ4V2
         i7vQg4A53nf4iyrSuRQc8vbVOSQgQFEJ1/OSm50rY58uZUle1CkR5LeWGN230zoHp6oy
         zaQA==
X-Forwarded-Encrypted: i=1; AKwUvBzJiQY3BFzv/0DUyWntIqyYSstAzdFZ0e5GQNkCJi1kKqT7HppMBUlZosCDLlF0cCeR10N1T5g=@vger.kernel.org
X-Gm-Message-State: AFuF++kmj/NrUIYBKm2BUjYO5atzX6cCuMNsJnwb9CyX2B/7RRaDMgXV
	IcRQ/Ey1ZWONwjnO+rcd35wm/NLNQZCSfejS+D739a7amvVamm4vvh2f
X-Gm-Gg: AYBFou0x1i72xzwP9RC2yqQup4pcliuA2Jb33BLj5AmCZyaFriSJNwSIEIM0i4g336T
	k14hQwKcVCdkmlpusdpxcS49QHwLZKmYwt9ssbEImj4MVAj5AdMO1cLUB8PZSloys5CDpi2i/4N
	EalaUDnPm/m3XRXrbzX7UAtA0X8pK4Jijv0ji/l1Qrri5juonXcR0lzoLLnmqEZaLV3vhFvDHuX
	DrIaM5/JDbbHND4v+8Ieri7c2ncrc/+thuXunVzHUfq7549icSxaf49BRKTTpM0ov6vxuq8hPxN
	CGsSxgGJ5tD9Ju1L+kQub1hZrV4n77QlG4n+vLnp0/fFjuUll5dlmBBfhMqRcYsMGx7XjuRCuoK
	TQ0V3gx9S0e+dG3jG+LSlw3eGYHVzEWq4YvK6mA7FTq6gilO0OBZiCKaKBh2ri3Vo6yXTdXo5Tp
	cXaXjGFAfoea4MGYVwcDoosO8z7EIVqHG++ApRl85COlu17mhaDVGBAOfccFdkwGBMrJIj1SqOv
	f/VJYS6Ay8Lt4/Yx6Q=
X-Received: by 2002:a05:600c:3492:b0:49e:7c8b:fdef with SMTP id 5b1f17b1804b1-49eb7329b2emr42924465e9.2.1789595828416;
        Wed, 16 Sep 2026 14:57:08 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.73.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm35546005e9.11.2026.09.16.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:57:07 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: rdunlap@infradead.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	mchehab@kernel.org,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	tudor.ambarus@linaro.org,
	bvanassche@acm.org,
	emmaonana18@gmail.com
Subject: Re: [PATCH v2] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Wed, 16 Sep 2026 22:56:46 +0100
Message-ID: <20260916215646.23185-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
References: <f0591ce9-2e8f-4777-90ab-b9159b7d8f20@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Randy,

Yes, that was a mistake. 

I have now sent a corrected v2.

Thanks,
Onana
