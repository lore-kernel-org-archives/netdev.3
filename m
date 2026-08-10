Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839ED4048B1
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374855; cv=none; b=KQRUXJ8qZ44Rpr1zrlNYqqmjV52Af80Bpa10KZHjuwliSuei4N9Qwiq5qS9l7pooYLDN73m8mjRHo/4fU1fO09Qc4SfoKvr4pOyaEsCJrs0+/u/m/3p82oLWOq2qGOC0iWcBu1hUtDEMjVZliHe335wgExxlVWaDTkLHtv7qxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374855; c=relaxed/simple;
	bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmO1vmCr8H0sHJ2YJq44cQQtIG0o18pjd2eqC2wRguNPIwus7J4j8E8Fl6Vv+OKJn268GTv174e2Mb++KTCvb2wGEPCULP7BOKkz42VwR/Q93qrpJqVnDMrBPj1hc+6seWGji64GxpDm9qTTrDx6M9WJScI0OZI06n0yJxRsqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvQEfT1D; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvQEfT1D"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so23503665ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786374854; x=1786979654; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
        b=WvQEfT1DwTlRS06+3F3WJFdq9AD6vSebUZKfjobIZIrxU4Wl+OaC4GX437KGrriYTj
         dHSP33J6GSR1QHQDIDOESM5FM+rPJmzKxCB0p8uXYbrRI6c7rMnnMZP53O6j4zXJQxIB
         o71xQ0n45AvxPRprMQpHaKWfuBP4HqCyEPu9Qaik5Zv3XxG8Ne9sRcQrTycqqTvyJrff
         PyPLOvwAm3DSGj8vHfFfkR54sEAahZsFT6qTQ4PDBcv8/JOj9upf24mVtpB4nupgX8p0
         tMw2g//NthHTLu/Se3PRT625VPaNRkj2acXFkzlTVC6lHpOUaa/XQyP1TB0RYJbRrB0b
         +rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374854; x=1786979654;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
        b=tCaur5u+zjE2lFlOtOmnMrmrInqSMqIbFIYfnvtPDS0xa0IEmbUuczUyVqe3lm//Oc
         +7lbunfELNS4gTCPHLpFbH/zkiKj2PrmhAEDT88I8RqN3UN5dvtwkl00c3xBkrG1lSyp
         PBu21srd5sBYI4888+O0ResU/6LOOLxnk2cw6pCfzuteccUqKDBZ7u8IMp4NqqKur05I
         /tUQ7fAhN/2M83rpebt5EZnBF0bfsh7HddRTl2kbhvpQIL0kGZtFcRx9RhrZQXF8jy6X
         2Q/zmFgRKUQmVxZlUx6pmsBWvABvPhJijynWw9wQfa5+yuFlAVbVYnMuj3e38JdkonXR
         8dtg==
X-Gm-Message-State: AOJu0Yz4qz5A1KuQ0vgLfE2amlBJ6Pk4akUr8mhtkmR1H7ghGJ3NJCot
	xrMkkmsJyxiAjEL1wiEg3QnSRwjp66Z6qWbNpCHtxLKJBW2utRx/hQuEcTaw5ZFW
X-Gm-Gg: AR+sD101cVymMuqQvz7MSfbcSdTT0wcUxOKdgDXpwGMjMNmPmbMQHoPvu5aTSUSzjsn
	Vc6aovDCKD22FAPqDBMMVGnCm+yiPW5PorLGNR36CzZ4OvPFpR3xlP///eiLaV46WDG6mca9WwR
	GTkW/5jV1rxt0nSFwc57fcej23cZyBrt5b3EXG6N5DkeYhqoeK+u6OOQIpA+LynxPTML4BIeRpV
	5UyMXLT+MVq4LxnIaSG+2ASZ2j4tNVlMVaC4J9r86vMlGNNJHvifkUq0ROCvAPhPgRUPkESPmjS
	fVqyOor8h/WoB46C3okGebKtEoWfuOJUO9GCIVQ7aLb/C5ESGBGpNNUcQ+PM3rK5+hozuJS424g
	c5opVyiSGIOzhW0EWJ7aIUmnpuCV9hsRRZLoWuEMMTTOA+MzhBC3GoPqjmdPbNf9G0HJ+LEaKmO
	ogGE+l8xHVZAvC6OmLzp2X1NU9uqxscICbYUFvER50Dd0bkaHPk93TkA==
X-Received: by 2002:a17:903:1a90:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d2ffb432f3mr28112645ad.1.1786374853680;
        Mon, 10 Aug 2026 08:14:13 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4ea722sm37764105ad.79.2026.08.10.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:14:13 -0700 (PDT)
Message-ID: <6a79eac5.b8c88a87.21f9a.a28b@mx.google.com>
From: win847@gmail.com
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v12 12/12] net: airoha: add phylink support
Date: Mon, 10 Aug 2026 23:14:08 +0800
In-Reply-To: <6a79e6fa.332d3c56.21a33c.b60f@mx.google.com>
References: <6a79e6fa.332d3c56.21a33c.b60f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Aug 10, 2026 at 10:57:59PM +0800, Christian Marangi wrote:
> If you are ok, I can integrate the change in the next revision.

Thanks Christian, please go ahead and integrate it in the next revision.

Either the `goto err_phy_stop` unwind or moving `phylink_start()` after the
GDM VIP configuration so fewer error exits need teardown works for me —
whichever you find cleaner. Happy to review the diff when you post v13.

Best regards,
Wayen
