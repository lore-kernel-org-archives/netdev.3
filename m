Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC25304BB3
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620019; cv=none; b=Gy+8Y0pbJhMLTnKR2Z++fY/8QwPOV5pM/Re8TT7N4NzohW9XebEPv6Apfsc2FNvFTTdt1u0yP7UNxys/IiC8eqx59ACT0XxXNxYBcMb7oPlnHu1I14fx+A6j0CtBCvfxuaBXO3AIDsZisEKFuieSmGPks71Q6eGs0M26O+cB5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620019; c=relaxed/simple;
	bh=+0AJrwcciyplcwEV9pWiYWOy0FhAYa1rWOLN8c1/P80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8D0qo2FpJIMWNw+tdRB2RZgmcyZr+s0XdpPPPVSiakF8f0pWdky3bpedByMFvwNXDBVoXjsr8jQcEK0gxg+zWz0koIHyZs7z9EQzJgk8XvWjt8CnFxx8RnYamoGO40FoHRTDWoQ6tHv2uy9c0ZlFdA9YYzCF9ngauu5q2qZXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGv0S/mV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGv0S/mV"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a44a3b66so2203637e87.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785620016; x=1786224816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zl3deXJpTEpLGVmA801R0WemyMlV5n2MzzWnIi52BN8=;
        b=RGv0S/mVGhjkCR//ZEGXw2Wt1WOoMQlhnkGm8vc/l2qjiU8ytYarAJcFbmWafuH2HJ
         SxomoZMbhjKewrWFrqxn1noECzG/wKSjqTeMehAuvpNIzqq3craHg6k1M4b2oCCyoCM+
         hUlNeV+g8MYWhLpKucxa42ztGwMNFvMPQXvfaxsCyjNLd9at5TAgNWJwvQm+rSCdm+rP
         MmeDjJtZS7Z7AKHccjmBSskfCZjyAbjenwzkPY3zw9Uw+O2UzepmLuNqL15U2qUWFFTB
         DM5kmTZi2JjTdUhaW9bXP4Jhdz9a77uptpmdR99Vhu8BKNqB4clhUHEJRyLbogdCOUKX
         ZsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785620016; x=1786224816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zl3deXJpTEpLGVmA801R0WemyMlV5n2MzzWnIi52BN8=;
        b=fMs0/j92hx8nCn8cvSvzjBXJIh+E3hcagLlshe+bNfPKeXnxjCoDl5ja+v7ZrzTc6o
         +Rayq7f6hkUauXANlIV6jqG/C3Nqgar8mPDiZw1jMC0bbkMv/zJQhB1voixFng+N/BdA
         bjhcKuha/T6ErQ8qJOEGrLgBK7VPN6mKebwFR/H79z2fhsA75DhVaUNfZuoVm6vOXTpN
         gWJHvjUr/PC8Szzp1knnGvXtqWbtnnXpK+HvAlV4GcXA7Io/Pua6TcvMwBHFelQNte8X
         hL4XOpTWyhUDRa74rsRGnvxpnlvjA717rAI3G2loiSc6nDzofNABUAvfZNaSSKkFlF/w
         arhw==
X-Forwarded-Encrypted: i=1; AHgh+RoaJjZoXQP1CtxtShkZ8yBGzbjw1izLu8FXwIjN9jeCXojW0aa6c3/alf407hxvs7SYVFISly8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmcV6reQP/bCNJv/KMXc4edUa/cNa0j/eKq0gcQ8P9MOaVOuE
	rzoFJ5hqyXtxGUFX2txdAIpjatfH5NhOI3aodoAaGpjZc41yV86NCcin
X-Gm-Gg: AR+sD13xUpVcVNeiPL0Wr7H0eQtQAaw0y2xPlvvnCiQPDEUnzAKEJo7U1yKB3Bwh62W
	SgAmDD8+vSaHD/sVO6snaVtHGTeajnI0HM21R9GI4oKm6PFd54UG+vYMW0+7BzGE2i52JdhWVVk
	j5w3hwWBic3U7Qpp+3yh3OSTmH+525j/hUMhro5TVQUzQBr16GDkWms+eJ3GznIufJmSylp5/v2
	nSXrKfFYOMcyNzxwBkNHIkxH0HELwiTv8lLwIrU61ACuZMfKIzrZXK9s8PEyEXUhrPXn25pLt2K
	1qIShNxl2KPAZJW7AC3+eyMUEXEdPH+PTedkYfwbJBWGKQYlH5yOYFdF/t5adaB5y66/ZMMfZMD
	R/pBU4cbzHzyxF0kp9UjAzesa83P7Eq8uemfaIzV8pa66zKxpIKdZ52AI9L6p41j/L3Jh/ferEg
	s8/+c4PJQsYsE4EUiuErDyG74GYQ93x9zC2BhRwmnCK64oHTJ96AqhWa2VxzW2h4+SfyInaEifA
	5XHsu6kGSoe9NmNSdgwsODDl2lJiLfvANXP8wEvefQI
X-Received: by 2002:a05:6512:68f:b0:5ae:bbe4:f4b9 with SMTP id 2adb3069b0e04-5b2e4f8e4a5mr714351e87.55.1785620015827;
        Sat, 01 Aug 2026 14:33:35 -0700 (PDT)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e23cb687sm1117475e87.19.2026.08.01.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 14:33:34 -0700 (PDT)
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	krishanmohan298@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: sfp: fix hwmon_name leak on hwmon registration failure
Date: Sun,  2 Aug 2026 00:33:15 +0300
Message-ID: <20260801213315.536335-1-janislacis06@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66ac9090-fdb6-404d-aa75-bd3adf8578ea@lunn.ch>
References: <66ac9090-fdb6-404d-aa75-bd3adf8578ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have looked into the code for sfp_hwmon_remove calls to the 
best of my abilities and Andrew is right that sfp_hwmon_remove 
is called on every sfp device. 

If sfp_hwmon_probe fails in hwmon_device_register_with_info function call,
it leaves sfp->hwmon_dev as an error pointer. When sfp_check_state detects 
that SFP_F_PRESENT has changed, it sends SFP_E_REMOVE which leads to sfp_hwmon_remove  
call. In sfp_hwmon_remove sfp->hwmon_name is not freed because
!IS_ERR_OR_NULL(sfp->hwmon_dev) is false therefore the whole cleanup block is skipped.

So, as Andrew suggested, freeing sfp->hwmon_name if it is not NULL
and it is not an error pointer (hwmon_sanitize_name can return an error 
pointer) instead of freeing only when sfp->hwmon_dev is valid seems
to be the correct approach.
