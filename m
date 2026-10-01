Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3356388E74
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829600; cv=pass; b=mS72B5xd018CABV0KA49COtb8nTlSuKMLil/OGCFHhjSX5BhowGtiYeMYVcNEx94OVTe9CgiVZmmHYAuoe3YflAVyKZjSlQGT602Dsrp5o7C+lrfCen9QpBdu3ridriSzTCmOWBe9lXYAco6UgpggqyuJjqWUShBhUAmrWXeWvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829600; c=relaxed/simple;
	bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A409VG6wGD9UPpo6e9Ck/RF4Xrz0Kt/hb9FCrzN1+1BgEJ3hGQxk9XlIbLUhKUWIgHT++OgS0TGPqLVzTXe8XfGE1eqY0Gngzdo/8lAWijN5UW5q8CF2qP1Zjm8k7TN6tLGGaVI6Wiwfz6V+bVy6ZerTcY6aBXWGinkyqK5yjRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiEcbkyV; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiEcbkyV"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so3175570a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829597; cv=none;
        d=google.com; s=arc-20260327;
        b=iovseSlR/FS/NMooiUNrMbJpWQGN03x5yi0hIKQx/jTo8uFxlzrDn3gPM8mtYCEE40
         F1tfLNnrCu8DVSG+WhRpkHXhMt7/IgNedGwcEr1OcOFhNe77EDV+UDe62ebMGX1FN+D+
         Twa2BEOdLBjo76GgdP0MnW6JWWnpUiTUDF84zCJs/j7t/QZZlPIp7GYavZzJyffdPUZI
         QiAUTLR9fCb/Xbj/6+3c7O/OWrf/0YvqV828Mmg+N5Vvi1PGrz9hNBQs/syGLIuUAoCT
         ZKgeKcgpiCSRpdY01QMSh8tbmKfhIRnswNYBoKHoj0To0ck5hY/fGPabtVy8Wn33/9Gs
         3xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        fh=AFQDwqaihsI3Wxr7Ao/9bzNeQ7fJcGQxB7JTqi0pKIM=;
        b=AQYM7VqcCo12K/qooLTQ5y5fbRJvhol8U0ckV2uRWERIesSPreEWYlrX8cxxy5C+ep
         Fk6o1PlbnsD/KENYb6hMM9inU/JnCeFpCDkYeMtYUbkfpsJjtdoqWuK4ili4A6PqjSmU
         iFf/mfRRNeZzEeIpT1swqBn0x6yh8QaTTPVoJpYHw3z9sFI32kWgmODY/+/AVoE0eibe
         5HqJLm63YHVhricgGT5d/wgjdE+MjpedBrpBp/JLz9HKSwzzb4ISFdpEBXOKORornF4c
         fl3Y3FpB+QkgkRxAHZQJsGvSguFXaSpmswwbWDOe3Ab8SB/cILAdN+yZfy2Gy5pXMX8c
         MZ6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829597; x=1791434397; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        b=UiEcbkyVNIUMhWJVyn+9JG0V7GlKzWDUqST50o7uZbjD2aP3yc1bGkMz3mv3rlWMri
         ddG01q47E5ZAaz0GjpeO4mkwku5DtuP1CCndIEf3hNB8ix2tQZFtJsYk7Q5zEDB5pNso
         nILZBHRjr8bB1vieZEe9QiHf4qDwCUdrfD5CKuvNXEOH+WXjqwqYGtYx9J+ImxAcgn3l
         AUzMFApvIVTiZ5zpZF7hcqWrgrMyorV0WxntmOvWrKoKCuzWkAwmR3nQHEBA/cYwOGcA
         /yFQP25txJiyYT28rPGPYqnzpt5BmfexCyC4lPWwgG/WQ4l+pPHoJAJ+aelDJbdP9hWs
         OgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829597; x=1791434397;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nDas30tPSxRmkTZarnFIxktE9WqOwZyfqBZjaJOotF8=;
        b=yna5uvo+qlBZYIy28POD8Ahns1e6L6jC+4jyalPkOp+Nsu9kFYTqsLW+Ii1+nc64cn
         qZdmHlEPZltYOKUZGJyCiwFFOaNybn/BaxDEGLuK9VQjyENrEkvqPHtse94Eujzkm8Lr
         W6DC8+LOCa4cMDtK8QkRKaQ9jxc5C7mJWDu3FbHquL9MVGl70eM5jwofw/Rpc0TRXuxe
         +EaB7IfEkJlbEbfcFv4gA/CsltY+J2wUPrcWNJSFgoyZ+SRcBXsYv0Jl2CmZedFz65W8
         j8wjqPlZvaBJiSCXOJDDhH3Oz1NaQoE7SQcHwkWcTP1zZRza3O0t8OWw8qYXb5xMeNTf
         NpPg==
X-Forwarded-Encrypted: i=1; AKwUvBxjnFM7NF8snNdKmXJ25Q8+Mx5I7Td95erh8ArCrgj0cd9DgmlK57G6Mx9v2ICTNr2V1p64pME=@vger.kernel.org
X-Gm-Message-State: AFuF++lgLYgZiEpYv65wcwwtWU0RW2LgQacJlSfQn6EzZNf6bi0HUoGu
	dXgkfbaKUSmSttG8caTUlVkIzTWtTsw/r9bsURlAlWohVMOBeYOnf86lb4w93TBba8S78oJ6ryZ
	f7Tf0W2wOkd+W9kHhQFenszIbgQMeGTk=
X-Gm-Gg: AYBFou2DRPs6D+mKwYOV+rntr07xth0mGVah8L77b1ijItykNc3II0TYSvJ4AHgCKIk
	PLTvj6zHjynzfXYYXCnaZVy7xKLwqVngmcFLjA9lIrZ4eZcvYRDWJaU5inN23Nv/YX3nB4CqmKK
	DCIxBMDkB1Xc0OY2s5fHqy2jl+RdKaXsDgr5CC3O4chNK1lgVOrNsTmF32HQ0w12SZcC5RrCIIJ
	KajT0jERBe18eA4RCtcXLrkzJbYjsc6bQCBW+zb7PqPO6Km4AsgEhKLUzhzs1ru1IVf7q69WhuK
	FXYofUymavIaZ3kfCYjH5fpAL4bx1RvVe1yclCgwF3IbByieUr+vZdTk
X-Received: by 2002:a17:907:6d25:b0:c2d:c739:30e0 with SMTP id
 a640c23a62f3a-c2e23e24b86mr265473566b.38.1790829596884; Wed, 30 Sep 2026
 21:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile> <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
In-Reply-To: <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Thu, 1 Oct 2026 10:09:45 +0530
X-Gm-Features: AclHuK-y1tLB80ZNINzXQ6UtPI8XoZSzzsSAP0Y8v4QLKDC9gVJNA8sSucY42gE
Message-ID: <CAHeizqEqOx_bTJdNaUYGc1Mc_dcWbY6ybJNmo9uKMcyBPVLS1g@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Subham Pal <subhampal789@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

Just following up to check if there are any remaining questions or queries,
regarding the multi-vendor testbed I described, or if the series is
ready to be applied.

Thanks,
Subham Pal
