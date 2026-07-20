Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C2423A79
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553700; cv=none; b=YMEh3yM+2B+oqhCT71JR+uwnEKfm6eP96kmUFWNJP7vwXx0140j+WuS7SCF4GquvXegKJzZPHRnBBpYYDGLNb7lrFjc5aiOMN5QGWIsg4JXayVi+LUp+F3e2wGOAoM1oGDkmWx8jBtn+4YRkQDpOUKaHB5G9+I8jfTfTGaoQiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553700; c=relaxed/simple;
	bh=q/i+h1xLBAMF009p2KMCeNBKzps8J4NXn33rD07ylA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usaahENV8W9oXqz4IphSh+AITqjCjQPIzavJuLLRO8Y2/Ifb+iaJ6QPaF1NT4pFe01B1enza4GmeHj5vXZm4njFKEoXgwK5QLyafP+QEla/AlXlKhHJCXV37APtGg5+0jweH/5kQceu3lRSU6PlwINfGw/lnJJAdV2/F0BjT0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=GxVl9uIf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="GxVl9uIf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49558ce01afso11701115e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784553697; x=1785158497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/i+h1xLBAMF009p2KMCeNBKzps8J4NXn33rD07ylA0=;
        b=GxVl9uIfc3wggrB6zdYUthPXLOSiAarqT58441WgUkpw02w7lAkoOUuwzNp/OC+1U5
         dq7WsyekZ2BkBd4pDh6Vf0y/mXsB0JDfxnwZob80UdPvh9ytPUAzdabaYCWa4ZSNbZO2
         EVbDoovGMuNEtTv0Zzl6kqh5QqDLbD9tdwQzFrMk09B+Ltad3bU9fgl5FBh9k+ErUhWR
         CLPP+7bGt9aWifSCJdcp27w7l91drUhAG1k0B1nFiEwyGfL9ARoVEr+qKjyZl2JgZIja
         LpO0EQSv+pXMdt0qCjTpllxXeccZbXLFEASMZL5dFdCdvac5T+fjjVWnIQjNDc/EvOv/
         ykMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784553697; x=1785158497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/i+h1xLBAMF009p2KMCeNBKzps8J4NXn33rD07ylA0=;
        b=CecdCR4WNlWb+W9tV51AFfZWuQX28EpLRcFk5HHhP4/WEJDS2IYw/6CXqjBEvwpBma
         UuI8O39oz+GE20kU/lT8ch1po8+1KBTkAc30X4kYZ2nPcacKDaKcVM2nry9b8I42UBOL
         Efpu5/44vIUiAQUQCFzhQUG9ajwiWc006t9gHyqrC1aINufHekl3dTIrygqi5OwUccyt
         ijzQ7BGNXdS+6U06ba9/aYU/y1J6cPA3ZlkVKfUdNfV3bTnc4LSBF/D2vJspWdQVfX74
         WjBRjQEKNmDfmJ/vVkbSFRa2W8b1H7TC1ks1KOAzChx28gCvlNaKaPAlyJQhIPAYUEJB
         +RIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4/pDMyppyPUj+DPgQhLXKLn5oF7+bmzuKPq8n62yxf6nxn3cGSaRMGO0V1X87hxNOw1SlJg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjGXt3xIUl+QTS/iGpO/kR/CvaSzdlkM1OmWKBHsG+MaiZB3W
	9EExPqA4n6EVUowsfrRd2YQlr/EbjPisFnW/dHHUigYlrovx+A4NWVp3iZN2GB4akx9c
X-Gm-Gg: AfdE7cm+V02AQYXH1eGmWIPAeN7dzaa4bzkMEKhSiczADNjumn9cIHhGBERSbytK9bQ
	fCt+XqI5RcOi8aNDKtmJhg54BDvkktlCVUI7/TyFwF2NwgKyv5f/dMPtIVMNGLG9kiXKESGMSPD
	yIiXuJ1+dzfiSX4ubC5yxmD1Z5yqaqzcu/2HApwtaLZuxBSqQG/Riw0wwsk9sMCXakD/2Lma81E
	zwCEC3SK6NM2tgrD92xnWMTOCSUZ3EWH4XwxN0UtWbT4Wn3BW4PvaXK5CjsDqId+EURwEJ9epBR
	cMakYNrXuXd8nsT/h8K/xl8bDWRao/AVvT1Npx0p3TppSxgO4CFIy3bekkq3vTktXWtgtLx5TkV
	lOgbx3b5Zmh3V2Vk4CcJnBBgd52/G6Q6jxUV9w6jACtCMczsX0rGU84SFUlLhzcYFoJjanZLNCq
	K3DZmEy5k8jNy22EvXq4csYnH+kXS/jvYIrN4rAGLLLy417NEn2VaHrH8RqB0VcQwEr5vEj7EX6
	Q+9rqJA8RQkQ5admAUDDV1F
X-Received: by 2002:a05:600c:198a:b0:495:6478:2dbc with SMTP id 5b1f17b1804b1-49564782e0fmr3937485e9.6.1784553696132;
        Mon, 20 Jul 2026 06:21:36 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b87c6sm509642335e9.7.2026.07.20.06.21.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 06:21:35 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	horms@kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	hexlabsecurity@proton.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: fdp: bound the device-supplied read size in fdp_nci_i2c_read()
Date: Mon, 20 Jul 2026 15:21:33 +0200
Message-ID: <20260720132133.69635-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <879ab436-043a-450d-87c0-70e7c6f4ff8f@ixit.cz>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 20/07/2026, David Heidelberg wrote:
> I agree, I was looking at this patch yesterday and the current format
> feels unfavorable. Please send next revision with Simon suggestion :)

Will do. One heads-up before I resend: Bryam Vargas posted a v2 for the
same bug back in June [1] that is more complete than mine. It also
rejects len < FDP_NCI_I2C_MIN_PAYLOAD (the lower bound Simon flagged,
reachable via the u16 truncation) and fixes an skb leak in the same
loop, with a KASAN reproducer, and it carries Simon's Suggested-by. It
looks like it just stalled.

If you would rather pick that one up, it covers more than mine does.
Happy to send my (narrower) v2 with Simon's suggestion if you prefer it
instead, just let me know.

-Doruk

[1] https://lore.kernel.org/all/20260616-b4-disp-b1f8ab4c-v2-1-2d1fe5955325@proton.me/
