Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CA3C1D6A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906845; cv=none; b=DzYBj2AFwmjk85d+SWnrYqRYIqwMp+4gakzeji1/DGBubznwvlOM3MHQiT0hn6Fvdx2bsX9fJhv2kQnkkMaVK9k5ZlIVhY5xdSm0ER2KIB/QpvX2qV7axso1DZBKWDXPwEqp/nRYdz4MvzWBjycyDGAnrtaRwJoBy6S4RLXLYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906845; c=relaxed/simple;
	bh=vHvk+bjLs682I9QfsEUIDfLsqAAo2RU7OhlRf0yB+ME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m1ugyIh72i6Yo8p68Wk3w19naO0MbNsle37TC8+Ay1ligG6vwGP+pCWU5/waUero7xRbE9JLDHjCrDf49NEpvWNiYkoH9gOdOU9vJnNUD3ENzV0/VXgKMM5UA9ajNTwb52kjrcRv1wRiVk/3yDpU9gOQelvOq4E16xVhkHkSneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjBDfIpH; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjBDfIpH"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90ccbed6edcso77094096d6.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788906842; x=1789511642; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vHvk+bjLs682I9QfsEUIDfLsqAAo2RU7OhlRf0yB+ME=;
        b=HjBDfIpHB0DhMU1TfTOhcF1xXbOH0hAKJJEbmgmShosPNp/LZ8kALRvYEFhqk0y+lm
         4inHS4iRNdJ13sKzo6AWsELPrRVZVAlCFX1z2s3Y0aqukURku0ol/8t1EWJRKCdzIUVh
         CQj7VBLrck3obTG+Yh+kEr3osMu856Ge/UVFwRLoet9U4FtiivEcHOMmdhDM6CmPEvAn
         SmRewESyc4A6tWDWnhwdCiV9Kj5T47M+7SK8NO0mXxiVGkF4cAsjYUjGcBjF47mBeVxn
         iMQPcP7Wb1z8+6GIPELrNTX7OG29Hmeyi/dU2v/G3p0MeYLUsQ8F1FRBpjJbFaONdxgU
         Yr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906842; x=1789511642;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHvk+bjLs682I9QfsEUIDfLsqAAo2RU7OhlRf0yB+ME=;
        b=orNh/bG5NCX9SfgiTnMINnyNV0cNpcaVwngx2nyzNSGwk+5Iznw2EeAG0vhvqli7kM
         MpH9g2zcgvzXV1vOJjCijJq2b1mELu1DhzQ3JBFguC+ZS1umiakYWJ4vJX4HNNCTiv6x
         82EUyWTebBwW9cjV6RFxEJ7fAuSsWnoPnVj2FjnghEd/kAeZSrUjRbkAkyhBoZ/q7Urg
         0U9hfjSqrc1rT/2YKIpFQ7kb1Jw91vJFDTSql+OO6jRmmMnv3D+b6McTvyKyMFe61Vdj
         ZwW4+KtVQDRLLLjfx5TQ3BxvnG1HhOs8j+OK+nl5SnvX7dfNEzR8ISl8a0o/0TGEbcFX
         MCiA==
X-Forwarded-Encrypted: i=1; AKwUvBxyzfYCHTGuZpV2E3d4kT8cSt1d8a7XKW4LYzyPDqr2yNaJ29KL08tv1YHKrlKAKBl4Ed6EzP8=@vger.kernel.org
X-Gm-Message-State: AFuF++mCn/3R1X10zHMcZAU4E1wAHNiA30GOFypOSoyPnOIiyH0WjTp8
	y3h5nqKJJkTTC7Mp5uE/hRPbmtMcIITgSqtD4BN2jjbfAbDfUsD+cFrw
X-Gm-Gg: AYBFou2+uKTmS3aWxxRsysB8MfZ1jU3PJ/JJyypEJWYJ25P77S5m92z11Hlo6p1gjgR
	/bEj5wjLp3LLFLZbuk/SMRPjCYcwJuMW+kojUT9idKPslkoXEnbI9vJCVOgOQF5nsgMev48ngJN
	nMio/fVNGQzTH6qTgrH/38mfdWik0EOlppiO46KK9Wq94AUYWcvcMdrhsLBl5v73pndf0N4xFM5
	wJb/hmMrJhAc1piQd4EuoF4B4mT0hchPNN6zLLKhMTfQjWgOmMtwa06tNvLxXwL4EcWYCQFI5F3
	s/KrRA/SklLHOvJeq3wf0zXqppXpRO6GoVRjtW5hunE9buFhhx+ul6JISPaRRmwMMN9EXNsVkEY
	eVGVvlLe6doWdNfXMOI5jcpc/dsVR7U/v0kd4IPceXYTFo56hxBv5W5sy2m3B6aqdGwO6nCpbjh
	UiM5AlUvqxzKL4i552ro++/8i75wHfCY2Ole5tSv95zJegtCOSuMmi31fBvPju/BUisQ==
X-Received: by 2002:a05:620a:3711:b0:92e:541e:632b with SMTP id af79cd13be357-93980599abfmr3254114885a.2.1788906842594;
        Tue, 08 Sep 2026 15:34:02 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939b39dc1d4sm461648185a.47.2026.09.08.15.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 15:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 18:34:00 -0400
Message-Id: <DLAAJTBDGCKN.1B13MQ3OGWWBG@gmail.com>
Cc: "Bobby Eshleman" <bobbyeshleman@meta.com>, "Boris Pismenny"
 <borisp@nvidia.com>, "Carolina Jubran" <cjubran@nvidia.com>, "Cosmin Ratiu"
 <cratiu@nvidia.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Doruk Tan
 Ozturk" <doruk@0sec.ai>, "Dragos Tatulea" <dtatulea@nvidia.com>, "Gal
 Pressman" <gal@nvidia.com>, "Jianbo Liu" <jianbol@nvidia.com>, "Kees Cook"
 <kees@kernel.org>, "Leon Romanovsky" <leon@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, "Raed Salem" <raeds@nvidia.com>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>,
 "Shuah Khan" <shuah@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simon Horman" <horms@kernel.org>, "Willem de Bruijn" <willemb@google.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next V4 12/14] selftests: drv-net: psp: Extract
 shared helpers into psp_lib.py
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Tariq Toukan" <tariqt@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260908065244.3799142-1-tariqt@nvidia.com>
 <20260908065244.3799142-13-tariqt@nvidia.com>
In-Reply-To: <20260908065244.3799142-13-tariqt@nvidia.com>

On Tue Sep 8, 2026 at 2:52 AM EDT, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
>
> Put init_psp_dev() and the logic for requiring a psp version into a
> shared lib, since they will soon be used by a second test file.
>
> No functional change for psp.py.
>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
