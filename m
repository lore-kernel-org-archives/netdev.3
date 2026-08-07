Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C33C2774
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087637; cv=none; b=p/tsDrkUGf7RCbEQXZbgglzm5BpjD+1j5FatpZ3y4BTggbxPgJujRdKm2KatHonJCpUmzTwoT+gaF4aFs6H69UuKEq2yI1aGWDwFe/qkiHYsy1WXHalXSy9p4KAp4bAWEngt0kbW96viz0m97MIgtbgnYA3ACHMs3Vkh5lqiXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087637; c=relaxed/simple;
	bh=aaQBxhwxoC3TuCYBfXsNCKv9PiZ3tCtK32Dx8/UNoa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwYrvF4dXs74uGgfCPWkjbVhNpove7UmWHavCkgRRoCP+zyCvMOROT2xDxXfjNS7wLAdZNWPhfUPogDvh3996vUUHDy81/GlJvay06Pv/h98HQmOZ2YyNeDodyAjk3pUcfXKLeXJWoE8HwNo5L+CybsbXnrA1jXuzMosZXylfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbaNALSq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbaNALSq"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so3055966e87.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786087634; x=1786692434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1raNmBEOmz6ZINnfoRbXmauBepPzo7RH3URyysnOXJI=;
        b=YbaNALSqtcp+aXYmncCd4HRfSiIEhEMSsff5ccvGw7G2A5L1FcO0guHgNvcP24M/mK
         W2LT2hZ2GpQRpd0zXHpcG3xM4KNiwn7V+kY2oI6+ucNgVXivP7AHnCOg5aMMb5DGt3XH
         KpP8VbxyOklqhbiA1MNQTG249uy3QHHDl075ODoB2xcmAMf1zoDz3Z2fACSG4Tv8fyAp
         iR7GUbWQSp/5pH55AlUPOFwYHj46QQ9WxkoEBNERVyeoos2omHVukqN0U8YfHFrGYMwO
         xJn/dtmaJg06tfsr/R79IjaC1q1NIsKXb8DlE+BNuYXtWfsOCjradLySUwN0p3N3s4bd
         xEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087634; x=1786692434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1raNmBEOmz6ZINnfoRbXmauBepPzo7RH3URyysnOXJI=;
        b=PbrKRut/ACCGyFjVqsiPbKd4h8BcUj8ng0B0TpPfiBRLJaH3gd9wWTOqJtNbTGvIsK
         fvtKDlA72m6P7eUMO2f2UstleRdt6hliB82H5Hap4WgO9dioBz942ajpDs63envXMATr
         sUGt4w1Pb2SEQVWchWYI1mPmaT3EzecBAORXKRpFa0yf2IsLk+/uEgD9dZVDkWLWpgnU
         bj1kakfhhqdpAJVa8eto8kbXAzvvOTpDnDPA67QF4JI50czuMWSJZPXH9fs4MMn6L2Nh
         0nnnuyq1/0EwBbWyehQ5TDxJCJV/qn459HlV5u0IW+qAIE7qBdYhgxe2aItyA5A2V5yc
         dEEA==
X-Gm-Message-State: AOJu0Yz/B7T0yu+0LxTKjyChF+74g5qpwwdmCrB113Rq91rdU8MaCs0v
	Lcp031QYE0u24Ls5mhCsBHUVVqnuw3QgDy4y4XumyG7cE0sJNRWPJRYVwWGoQ+dHKw==
X-Gm-Gg: AR+sD124HjrxSI2Hlb0TwPtHgsmY1ezgGiYt6Muqex01bzskV7QbF3se0eSLoaynW5u
	s3wVI1y3fLfAGc76R+Fuy26YgwxuLjPrq12gLQY65EfPCkknkvZai17bN7UUSV3RMoRx+JI6QlS
	nhZwI7UThRtKJxCyW72XFUeFE/XxoAUVvoSJD2HCvZ8lutgXT1/0SH0sKXtfU5OLq/wuhXsn8Xt
	okXCr9BnnPtAINLoy2u2o0b4sC5ZTcIJeQqjrwCs7Vu47WoHslaHbrsL5OgeF5XQYsBMJ2CR4Ol
	bqsZwApv/rX+jNwFgAXlok9cdO26MECrqAEqRXir/POi0wM+8eJXLnTlFeEcTaclfkP1rqkw4ZR
	m+pv1BwgH9L+9Gja+ZYEf47BSl3k/JkpO8VeAA2KDKoXRElLl5NkH7YPdsSQXA1j8vEJ1362BP9
	oJwTJ1bSCvVfk+Mp+fJLChiejjWFvwY1Lt6gbEu/tmv6JhXGVlYXc=
X-Received: by 2002:a05:6512:3a93:b0:5b2:a21a:10e7 with SMTP id 2adb3069b0e04-5b2f4ccb4aemr2641992e87.25.1786087633471;
        Fri, 07 Aug 2026 00:27:13 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f1cb0sm317139e87.64.2026.08.07.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:27:12 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback
Date: Fri,  7 Aug 2026 10:25:30 +0100
Message-ID: <20260807092530.46853-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807024125.434055-1-sochnev.v.74@gmail.com>
References: <20260807024125.434055-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  7 Aug 2026 03:41:08 +0100, Vitaliy Sochnev wrote:
> request_firmware_direct() sets FW_OPT_NOFALLBACK_SYSFS, so a missing file
> is reported as -ENOENT whatever the firmware loader is configured to do,
> and the deferred probe path works as it was meant to.

Prior art I was not aware of when I sent this. Ziyang Huang described the
same failure and proposed the same fix for OpenWrt's copy of the driver in
March 2026:

  https://github.com/openwrt/openwrt/pull/22697

That one predates the refactor which folded the two request_firmware()
call sites into airoha_npu_load_firmware(), so it changes two lines rather
than one, and it was never sent here. The reasoning matches what I arrived
at independently, down to LEDS_LP55XX_COMMON being what selects the symbol
back on.

Recording it here rather than leaving it to be found later. If you would
like it in the commit message, I will send a v2 with a Link: tag.

Thanks,
Vitaliy
