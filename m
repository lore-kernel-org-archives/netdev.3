Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB66453A5D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483356; cv=none; b=IUFDb9bRf1rwvpv90esLZQGQa4ImrinfjAz38YD5euddKQYT85J9UH90Jk9T0IejqHoZa7YIzvCwxsGuCf+plyPbkDaJThSncRK/0m0AZ6qTJNj75KUwBa2Lnm6RqGm8b9d2R1lStgsuG+H2clSSXfL3RzITN7Iybg8B5Pp1ucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483356; c=relaxed/simple;
	bh=NdaLGblalh7y8lVJYv0NjjfAvsT9Ho42+c6mULsp9Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlQyk8ufZSvj3aA2kD9b4yBsqiIuNjKEH5nhTguSoVJLsEiiB8f003rSMg6WxYVaf/egBbA3nctSPj/1Wh3j3kQkYWNQxCP05/xPSkzYPD8KLhiPlLsysuFjOb5RDvRdG9T89/lTCVzj2VOhz6YFm9vzQP7NiuRM1vsydZ47uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5TP5iaf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5TP5iaf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so483497a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483354; x=1787088154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hg+Yr9bSAREbkWFulA8TyFK9VZyeo5bqgSMI0IG+zlA=;
        b=r5TP5iafDRspKFczahdfGJLKRRvKfzl9hagc82bQ9hk7Vh6URuNL0fkVTJuWao00eY
         HKLHouLnXi7QNhg954xas/CqncJDw8vJWxVLGz8ZMzc4TSsyOgUTSDZYub+my/QLHagd
         lHinOg4NKlsJoOoWEuxUC66CMZBBMXUKJyikaluDHF1f3dc3hSSsQIL9xJuGmXgSvBhe
         4fm552xZ5ZqmhQ5908lu4oOUIJ7nhxkrjkAtwxG2X/925DRTrA+rUQFxxUnGm8zE3cCo
         pzWzgcK3ydzN40598Fi0FCOXwP2F6QPz57ZCPPs8zfuJ4lAhhXvMft076UjmDBjTRfw/
         06LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483354; x=1787088154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hg+Yr9bSAREbkWFulA8TyFK9VZyeo5bqgSMI0IG+zlA=;
        b=meuoktXWIRPMPKnSlbrlECYbL5quxLGZKVdJ+fsC+33Hrsq//RsmoUWmunOio7k3G4
         AXWiQldJS8++rgM6vs0ia1QGIpz5XgvwmFK8QDwmxd/MbV1uAfjKUya/2tRkTWAwZGBH
         /hu2eY0lEoykVsw97CI3bAje/+pUJqYSUYuv+Pt20ejnsYE5W5/btJKEZd5qOiXcSRV6
         siBFhfYgV8ycbdKyWyMeRvH2TtsQvcKdSp1vRZ7Yd9BZcUPbo/CmG/XHRkM3BEkIycxK
         y+n/x0koIaDR1JYLVTQRgiFB3La9d7PpDHreyP6QNo7kfr68whdxIrTwRgHOZaSQIqfv
         IikA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6n++Yar+O3uHQ+cv6lqC3gmSQiYEQF/yIazBngD5p+90rEOH/u6Gb/ReCiG/v1Vl9Haae07E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzPjVGH5m1inyD/6GP63Qhvqa4m9NsqfOBAGaUvZIuZBrc2Rl
	T7B/87hQkYwnpbMCHM/0oFZwQ6Fs/PhePy18a4ty2KUAe0hyyrVBIJkf4rcuZulnZA==
X-Gm-Gg: AR+sD11t6GbArkCYUpO0H4xUmgaNRtfh+BM84RDhgTSIiAIu0xLJSyLFVvL0II0lLqk
	Amb6zqp8VtRYH0dHdhurpZ1kyg1G5dKUgefgNtFDgwY0AdNMQyswGUjDcq3XEovyn5tJZJvmaPz
	iHD1ANR/TEaszM+aME9Ed6iFJ2r9UGfqlKvwLJ3YZ/+YVKELGpaO82D9MmeX+PFVEJ0sJKbbZYE
	lTQcQyVwi4BU9WeQy3wecPJ6EaUK6nmDokQx5dzZfz3vEWco/V9ZOKmxY3aMJ73UybSTTNT9jKT
	8sCgPh3K7NTOjYeU3cpedfJ4ZTkW8A6Xl9dx3bb2r5Ya6gh77+hDiuvi1TAlBuPyfDfqOcgDQ4b
	xo/NIOweGfgyFmdlvrOhNgO56F0rEb2lK/PiY836elgTF351aPJ794NQ1LvnyLWCvtMT0UXSuWU
	7q1bdkNNRtGYPxyhPUNEK5hM5BMBGAa0/4Lr+c4V67u1y7lWiNgVIOCJyGj3JO4D2tydV5aDwjb
	V1eYWXJAkiDaJSL6ygqQRcyROE70A==
X-Received: by 2002:a17:90b:4a82:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-392ec672d1emr6461856a91.18.1786483353815;
        Tue, 11 Aug 2026 14:22:33 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f85feb67sm1080532a91.0.2026.08.11.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:22:33 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:22:30 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 10/11] vfio: selftests: Add mlx5 driver - data path
 and memcpy ops
Message-ID: <anuSlnCd7NERCp4B@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <10-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Complete the mlx5 driver by adding CQ/QP creation, QP state
> transitions, WQE posting, CQ polling, and the
> memcpy_start/memcpy_wait callbacks. After this patch the driver is
> functional for DMA tests.
> 
> The data path implements RDMA Write self-loopback via an RC QP with
> force-loopback.  WQEs are posted to a 16-entry send queue with an
> NC doorbell, and completions are polled from a 16-entry CQ.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
