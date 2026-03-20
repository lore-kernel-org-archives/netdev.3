Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89083E6DE7
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031002; cv=none; b=YQa5rlkZPWRtivfMb1iK7aTgMoXf2t+nmeQLEH6vHJ/lH74pONAKkVQ8kJ9V6KJZ2e314d5Gr/JS6ShfVFpS5dx0QOQx1Sq+Gf/8E2tvOcJXkow7xA1bKzRrTk5RTsAKzRibEi1FyuK1WZ3bQ/UPYycdBNs99l1uf2AKmmMBxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031002; c=relaxed/simple;
	bh=Zl3LFCk6/4/QAsTrb/eEiKhm6I2+TdCly6roSNPBHdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8fIs4I6FXqfcoCIvjp1qF+8UippBEBnAgkujVo4jCA3ockckVdtvNGGXa6Oyz59kFl3711aEyhXWZbKahSEtZq8FaXGiKOw7vx4nwgLIEk9GqxM6jgKHkhY9ZmjCHt8qA5YzAff32Fpnqi8B6T1/Tnlfwchev/DqBXdx+lnhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=p52V5UAJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="p52V5UAJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so1426393a91.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774031000; x=1774635800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORY+Pl+curMAM2CaIxH/gRimQj9ANQzzkW5iYQh3R5Q=;
        b=p52V5UAJVeb9YpyEHN5qXKGMSsopgeAVYY9V28TpMIvMWj8GnuFJNm5Lzp3CkOpnTh
         VB21Yypb0d54rtT9cM4F+vULWuZfdNkLqN9bX1BxRVjqEBiqjPX8K9bjs//SR//M7yhp
         YrtLVIoxunawTLVeeiKBj0UV27vKtdSPRSAVu+FN6jQu1XY0kA+CwlUp0QmtBziQDzly
         MVE/BoN/lLA/od0EU+QWwSLl7DTjyyELH2eEHwzFLx3FN/QB7r1NX6t/qdGjZiRIzem8
         NfB0wT3oYu+gmyGCe5W2Mc/ZEv1OPIfs/VbZPcAWrXQUYB6UStnwxma/1IvacU7MQ2Yl
         1Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031000; x=1774635800;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORY+Pl+curMAM2CaIxH/gRimQj9ANQzzkW5iYQh3R5Q=;
        b=Q3C8ppPZizAgU9NCny1UE0BzgDtcGUFnFgjaMGuJI4iWbAjfhWJbI62zEk9RqFov+J
         KqNo8elim2AYXWAo4vEjzt9POAlpvdgEehWJRlqM2V3y7sm8bcktZxI0XoaljQlPgY2P
         4D4YMT4Zl5lH0EGpBwuwTfdlWIZhIS1YlQNbPOi+RMsKXA9+xFtv69HVzMl+eFzZLIR1
         TBWbJR3b492j9WVIE2yzdiElfMxinZ5vhF8+sbolc3mT4R/w5Q6kDbNfAZNYRbnUKG/G
         ySoIhY8PMWuS+Dqsom6CSISl645g1Rcxd0uXB4ZSP5gTdoV7tRy/le+0ASsuJP1naQvV
         CDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPshjAW45bA3dK6GcD3Gj8Lc1tW3Xc6ECFk+i/O4AkSi85HuJupbD45HGo2XxjPf2OgSMBC78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDYDmRJMiHR/pmKrTC7IKbNZlYNeKwdSvI0UC97Q9TcxTaT9h
	8rsX4+wVRrDXl/jvFAjlZorJXL0RiGyhySxhm4b+7heHakBSnLef2dRAI7ex8mLD9fo=
X-Gm-Gg: ATEYQzyXHOceN3WDl23QCFe8pvSy9ohUe44HDSg//cdmZ2jBhT5UT0mHe2cOLgnQvco
	rTg/IkqcORlA7apuW8Ztpl2hf1x6aPETnZIEICXJBCUbaXLuuOvEpTYVLg8ol27O44gtXwUzE2v
	d+1cAY6ovbPVOTieEFnMs7nR6qGYJZRv+I1ADTAINCZGUmODEwAlQiYx7o9KqJ2vT6DAgq6+dwg
	YF11puJtQn8ilUz21wTy70SJ/ljk15CSzEuqaKg96V4VT99AIB0A0ryDdui7IVsLftTjr8l+4C6
	psRtDUQlzEYGaKOs4OeiKCltgSpAK+EfCzL6g/KELLUiRwzXicKeWq0w0uJj1jMLAc7zhcRr6CK
	sxf0ZJxXzSE8rOUjX39R4ORc9r6D3K8hSiOqxKADJdRkRb1m7kmcilwfsSc84FQlxOsLoAzLb8Y
	jzG0qv
X-Received: by 2002:a17:90a:ec8e:b0:35b:9777:8bb1 with SMTP id 98e67ed59e1d1-35bd2cb2acbmr3147417a91.19.1774030999961;
        Fri, 20 Mar 2026 11:23:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3f34b2bsm2597828a91.8.2026.03.20.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:23:19 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:23:18 -0700
From: Joe Damato <joe@dama.to>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: netdevsim: correct typo in
 new_device_store error message
Message-ID: <ab2QlhViyiP1QEvy@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Alok Tiwari <alok.a.tiwari@oracle.com>, andrew+netdev@lunn.ch,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
References: <20260319060812.495488-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319060812.495488-1-alok.a.tiwari@oracle.com>

On Wed, Mar 18, 2026 at 11:08:10PM -0700, Alok Tiwari wrote:
> Fix the format hint by replacing "unit" with "uint" in the pr_err() string.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/netdevsim/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Joe Damato <joe@dama.to>
