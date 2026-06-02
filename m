Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79C34C9A6
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434774; cv=none; b=BWLKwFIQWwplJ8m1UJDH25xY6m/rWGAhwJXnta93gP44vA3HWUUqo+00MNhB2epFonjc7Hfa/nBCvS7DEtwi0SWE6ELLnIrfsapv3geL/QdWHBzRikiCJwNtaLVvOiGPdF+XRs5KDxmwVyOPB9L2P5w0Pd+Qa9/pgQrZmnUZB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434774; c=relaxed/simple;
	bh=uij0fPrYXhiLn/hkkJMC6Jmrz2271TCJpQyuyCz9648=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+bJdPotSOct0lVlffZ9TqsodZ7nwy6SyjeBB2wAZpdnipZOCcybq98cM0uEkBZA1I0VAMfCB/iyD4OU55nqi1EVTae33o+Wd5tFVQVKPUnpFuflmM1+5WwWvexqmg1+Cb7kXBYXmlPQLUv3YNH2RB4ZPLipzvktRUUOMSxgiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBbMtFsm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBbMtFsm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso65915e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434771; x=1781039571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9XdL0UcpSaON9fzpANOcoqtpqZ13Zvjis5WLumIDqM=;
        b=PBbMtFsm7wChxpUx03NtaBWtFJn/EfXqGpb/VEcyERZ2iLqzHMNLMatuyuVR7QWPfu
         8WW8Km1XEKgRVtRqCtPHN3gEyqhtnScsvDIixgY+SJJkqmbpV3efaZaYV/MpDC8bTm8e
         gYdss33U+liT52p6RMSvYoxy2QyNaXnuzCa+sKtK8nUIqJ5pYU6Cy+mxQU8F5dPVe7u1
         oNwY08o05liz3y3GSjB05k6kCEfRohwJ/l9HSMdThLORfytOf2+NyxgPK2L06LQokybP
         6i/kZCzq/KcwJurNssCq+GZzk+85sMQ5Y6AcSdxc6gYMOO3mzAywpIfUxoG+CJ/gzeha
         1nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434771; x=1781039571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9XdL0UcpSaON9fzpANOcoqtpqZ13Zvjis5WLumIDqM=;
        b=GBAGafOBGLTtB4VWu7TopOKn2Ss4SMz0Chb5kH/p+JxxES0zWojzYZlQDMw3hQibtz
         TGZsFSttXaNozZOU7ehDWm6mrLlwJm/3xVtGwToVztq2ExOaO/1Yva5zBsLiehXj+/KP
         ygng5XXc7AEBxGZyTa297flRo+I035bfBrZ1BmwfYQlAHULjH15xzH0EiJWHbht0/vN+
         ZgmzxOLXmB1jxfVIbATbhXi5ahURO3Av1nwra+7WL7l0jWM8BJj5hp3i0jJE0gyvEeHF
         grohM1cesKARp7aqElOyO5ypgsQ4eTfuhDeKNsTELPTKpS/6wIoQRpLAmO0OJds7MzSM
         zn9w==
X-Forwarded-Encrypted: i=1; AFNElJ++qo4hjVlx5qtMQWTdPHlXoVUcW2yCxJdI/qI+w3Of+kOpXL2aGGVPkaHGWwq/hXrLqcPT0D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovFLL9YQ3KFQsvK5LvX4O3STdQI0J930cjFQUBWiYlj9shSll
	wMjFvs62kCMdldv/unLO+nYxL6c323GiEJt9FKHEQIoyqNkyGhHfqtSS
X-Gm-Gg: Acq92OGKfRBOKjcSYnjXW8qGIlnOunu3a5n0aKX2HfCyO8KmlSyeu4S5bguBP0ysfbL
	QiF3pcJ9cldF02xcfule0Yt5BmAfhdpmbq5CBzHosHXQLEMB39OM8B6xV5vLWfj+HpY3AIhekxH
	3GQ0tojuSRH1eHsRe3LIqsikqc8KqoX/q14ynX978RN2enCW8jAlvLEM0+9XaQ9YQ14RxQAopGk
	iSmeBpIPkBVW2jiB8t+QrEZ0EeZwsufOrHokUDfUT/X0GtUXBjTHI4b5I5fPB8BnJ8ylYdP9nTH
	aZ5RbzljgtSX2gZgbByHB8Il5STS38dyL2/hnFnMo/vpH2F16SMkQ9iYUZpG7f8fZs5w096acg3
	NRVmZ8mQC8v59oxvU/ZFtQiDg1bBG61LU6cMFuDDbNdCQKeXjI/zw2F9bonOVyzKrYDx7WPnNmj
	msns1GEHVHfdmOUzvZG9aIOyMlVwgOtw==
X-Received: by 2002:a05:600c:3b98:b0:490:b11e:e4be with SMTP id 5b1f17b1804b1-490b611105bmr5959595e9.3.1780434771026;
        Tue, 02 Jun 2026 14:12:51 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b0e13f91sm111429715e9.3.2026.06.02.14.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 14:12:50 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 00:12:42 +0300
Message-ID: <20260602211242.13870-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pedro Falcato <pfalcato@suse.de>:
> On Sun, May 31, 2026 at 01:01:04AM +0000, Askar Safin wrote:
> > See recent discussion here:
> > https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
> 
> So, you took an ongoing discussion with an ongoing RFC patchset, and you
> decided to reimplement part of the idea on your own, as a concurrent patchset.
> 
> Riiiiiight.... I don't think I have to NAK this, do I?

Okay, possibly this was indeed inappropriate.

So this time I'm asking explicitly: is it okay to post new patchset?

I want to post patchset, which will remove pagecache-to-pipe splice.

-- 
Askar Safin
