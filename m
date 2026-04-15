Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBB258CD9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233014; cv=none; b=P66LoNgZTd5dA1djEK3v5KcZakf31ubmbQbr7p60xmXbmNYdplBqr4aqn4vmsbU1pKcqPgGTqg9+TCxdEXoJayuliz0+As7zFuOLWA27rGV65OR9IpIh99gSOQtYiRKmiHu0inhM/uiYR01VrC3w88RZrhK1aYGt45U0x/aXT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233014; c=relaxed/simple;
	bh=cyjgq35kTUANpRors0UJ2MyAA8YEkpvyucVoJcuXyxI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=NTiN662oVyg1ZJ7pc5cnEA2vNdU3tachng3S9NKPsl21kh+a7WrJ+s53vIZj6wJZ7k5sOaz+kL+Z35hBTsIi1rrQQNICijLvzLdb8/dG2TA1mEW4smpdj/Cr5cWKkTckM6Joj6RFF00zMq9i7dxAkQTK28q9R2Brvv4IAgih9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHhAr1Ss; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHhAr1Ss"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d4f78fc9f6so766843385a.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776233013; x=1776837813; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cyjgq35kTUANpRors0UJ2MyAA8YEkpvyucVoJcuXyxI=;
        b=FHhAr1Ss3JNstmp2wN9mOKvNClfd7PuRcHwfOZSAib2HiXP+sgDVaVa2nhNOhWFBH/
         qkDvNUZG/1Jbnxh2ODSxK8QLTvJVvnEKBevSovP/S6ElQt8drkJEuxeLqfLVFSKLm5+r
         uVEdySUvCyNJf4Ashtc9Pg/vVXPiIlqRILIxAesgIdiEUxsTETHmKaiRBC2oWMe7Ktr1
         KL08VIEBiTQ9bs7q2yCuzwZpOXt4cf30eDWnN3y0Oy9v/iirCiQhGqcRWr2+7zaHRGfp
         j2iKxEoWp3Q1zPfoGOG+N/dSAavinIdSPlnDnwdszSq3KWQvVKMifd9tkd77HkMPCwVC
         7SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233013; x=1776837813;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyjgq35kTUANpRors0UJ2MyAA8YEkpvyucVoJcuXyxI=;
        b=eWFFiaJtMtf5mFXEH6BRp6uelneyo8vNby/ICgQYj8pIjOs3bhCOmRLz7Ww4pRYnPd
         Ci45Sc8MJpxJIIw7Be00SNQdLz+jNfSu72tlctBO1QvrcLEFb0C8BOvCtdfI/9WW8EtX
         go0vI+9LscMXuikLVQE6XZYzwYqw8Ds277ZvNjgjswVGfxW8XOwThB4ORmBYvwb7Oni5
         yAibi1LzAE2fXamCUxnImoJyB2A2UUaJfFo5+XTxkboSqzqrneNAgrcmYzj8A6sJ5H2c
         WflLS4wVl13QqylsQPcoiea3D2NTkzYSlenQFRKfAwWNVjaYcBMik9TSDGEoFMd/Vzki
         u/cw==
X-Gm-Message-State: AOJu0Yy7W/2+VB9D8WhmBWBVHrFrEQTZOo3bFvaYS5S4lJdeQkCIk9EJ
	3j8wQkPj29a51x5J+FxI9GHacNAHS5jd/ZYVsPXHvo3s/pviMfOUvgbB
X-Gm-Gg: AeBDieuHlgnjIORKopHJx7G5mKhh0rkRHZQkQ0GYCfhmRyJAMjMJQCCa0LFPGZvLbFM
	fgmtdWu2Ty1w8FHemaqcnoWKKw28PjVVYhi+Ars95nRaH5V+0TbUsi/awG/48E2yWWRx4/xaXjh
	gG17DbkrmzIpa3MzN2V9DFNRWITRAnGHs0umVqYEPblA46y3a5tLn/P12JC8fdTp1t2eciS48yT
	gjobwgNZxJVcexD9AOTvlDGggMggLfQzSjncflj3wQ0Y1se3WT8qqDi/v92OOtPrO5Kp3fw6HKf
	8rUwtHu1VgULD1nfcQaXG4uKnpt6mtAhJJwLEa0rn/QTcr6DhZiNalRGTygYQ201d8wzlPk+Y8q
	5NAi/NeHjyF86ZQ9wFHpG2eJ2oktQ6LserqYwBlw9T9TKo/s+zOVRolak63Q7EkzkRzt1QI8jBQ
	EiXu8EGMm3MCm8C9Isy+SmLRYaoJrpdZqnjPDpNkpNllYn4YN13uPYP8U+BFHvq1RYnupDyclWk
	UNHPNbZnQ==
X-Received: by 2002:a05:620a:2585:b0:8dd:7919:153d with SMTP id af79cd13be357-8ddcd1195c1mr2907886285a.7.1776233012579;
        Tue, 14 Apr 2026 23:03:32 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2345c3bsm53523685a.24.2026.04.14.23.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:03:32 -0700 (PDT)
Message-ID: <69df2a34.050a0220.2d53f.b61c@mx.google.com>
Date: Tue, 14 Apr 2026 23:03:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7568368645748790231=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rose: fix OOB reads on short CLEAR REQUEST frames
In-Reply-To: <CANn89iLXG5ZMNeHkcLW+Ug9PxNnw_EKtpGVkPw1qeXEjJNtA0g@mail.gmail.com>
References: <CANn89iLXG5ZMNeHkcLW+Ug9PxNnw_EKtpGVkPw1qeXEjJNtA0g@mail.gmail.com>

--===============7568368645748790231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Eric,

On Mon, Apr 13, 2026 at 11:11 PM Eric Dumazet wrote:
> rose_process_rx_frame() callers already call kfree_skb(skb) if
> rose_process_rx_frame() returns a 0. Your patch would add double-frees.
>
> Your patch is white-space mangled.

Thanks for the review. Sent v3 with all issues addressed.

Best regards,
Ashutosh
--===============7568368645748790231==--
