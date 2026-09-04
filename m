Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A014EC65D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535372; cv=none; b=Mx/SASCrxRQCudEAF+JZqj0NHiVqMPrylB5dn74d+lrH6GCcMLqXQHgodMxYBWTqrR57gT5mUr8SsdQmigXE6tXs9aVGoI1Nn18YaKa8GQeNQp9RMBnIpLyizxVbQf8w9y937QBGH1cITC49mBRFXXP+AXFPskK7Hc1UguZnYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535372; c=relaxed/simple;
	bh=qkhq2Zft0YkxVfTjLmclBB2vNWWqis40kS612E79pq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=p1wKZZiVkr4kwYO8xVXrpf5DF6BuuVvHlBskVReLTS4PHSSKhW9JgWGFyezcEKf+ol6i3/1DU9tgx5gjWlCMDxnhM9HPVBf9bfiTrSeaE8RA1YH27xoh1yRjPm/K3OXMcdWIQVI/UiIRoKl7Pa1aVdNc6iQrYTYneY2oOrW8kCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8BmLGic; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8BmLGic"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86fbd1a23ebso9469757b3.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535370; x=1789140170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NNII5f1AKZA7qDFJXHptTrmekzlPg2bfpsGdrwM0/d0=;
        b=r8BmLGic+OBliBF9Qmqut/yxorF3NgnF5u7aSGh49308WZVmf+w31z6cqbSap2KuwG
         Cev8jan+QZuUdnp+svfPlCjzAiANWhLGVt+sxyzaZ5jMAeRxOdclONhKfsBtOJqSUFpq
         cV5syk/Xljh0UpJ09kHN/+xVXY1vBNREjWTNM6HHRzGubLT0KiJcsUMZU4TTCf+jiv2w
         TxTL486jf57s5J6m0IAsUAUeYSC5WPUIjyqrkPtyFxo//l7vzTOKJ73F/piFXK7e8MBy
         kutWxptzox6/QNmyQRdwCUBVCjYwQ3SNxuecCwd1wN6IK+lTTXXzvT3z2iol9RbsqFdK
         6FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535370; x=1789140170;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NNII5f1AKZA7qDFJXHptTrmekzlPg2bfpsGdrwM0/d0=;
        b=IKHRTL5wHLdwJ8F7oiViusTDc6wSalPSIuxI3oXS+prwhKvH3u6wOn+FyWRSd7CMft
         mtMiy3VaheNveYRnwPUgbEL+JIMOa4vagvS/Q1Klr+IdzSqW7vR9grT2wqFu4uS2J4F+
         xnC85gEJ8G+ljm0MUIcojjkeb+GfpQCum7Rrwl8tDjKGx/QfH8g1xLNvLYzoPJDj9ra9
         6/J/Raa8ab732M8IE0ZDVkGH+iBIkac9sVa5AmE+OoIBynRYXjzRyWDMolnLX21mEnUd
         dBzaqFzy+M+QJyJMmQxA4EZbKkmLUIbzdiyZfzBDWTeGtzxow6SdwjT64AcwbbRsisUG
         ZUJg==
X-Gm-Message-State: AFuF++kNonztpxj5ambc0SakWL1YV2M2sieMW5RmRlH+V4hNIvtLvfv2
	KuAulGiS2cZ2ORziFfYTvqQdyo+w4C8dFUc+IAji/ViH/kKP9DA+eg6t
X-Gm-Gg: AYBFou3s0XrKPS7x4ca+FFosGb4inQNcPIZMdWBpmRRpPuq0YdGXOGmUwACPoVOXXeq
	3HzmsMxkCDmSB9/LN8LqhknjtElsTcbF3s+/Z5cUs934RFL0FdsIHV2BPsq6r4IiXw3wy8XqFK3
	Hrw1aYmtBiNIT+D9Xfxq4mRBY+ZFNcgP+2hBuLN7gnvHtGVfIF5YiHtf3fRxTQsPOM218SIS5TQ
	5P1sIDlEZqFt3/6CdvvDG6aPa4LB0XVqx/m41c11aYZAKiLiQlQg8ZdW/3jb35uhXv++fOWaLht
	5L2OYWNrnLY8TjkRsSma6/Fi0uJ6PokhSgYBcFBDOju50C7KgLfrHdlO/NmT7cvRAc+ph9eZCgm
	IIGyaNEVF+ZH5PlVeBzH8zUdRHqztOfAvM7Rgpz4Sqze2V6pSv95t+rz3B5F0e9R8+tn3hhihj0
	cWli4u5Lac46pggNo88RJ1nBkUpwcLP0n0OqiCnz/0YLnGGAGYpVfrH7y6YOft+ou+/FLe6+pHW
	40fY/0F1c9LTjQErQjp6bT0xvc7nwUclEz9R8mdXw==
X-Received: by 2002:a05:690c:315:b0:854:b86b:d206 with SMTP id 00721157ae682-871261dc461mr47826157b3.12.1788535370021;
        Fri, 04 Sep 2026 08:22:50 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714931516dsm20526477b3.17.2026.09.04.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:22:48 -0700 (PDT)
Date: Fri, 04 Sep 2026 11:22:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.253530bc7052@gmail.com>
In-Reply-To: <178848118375.4131868.13506511829846201867@kernel.org>
References: <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
 <178848118375.4131868.13506511829846201867@kernel.org>
Subject: Re: [PATCH net-next v8 3/6] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> =

> - [Medium] Divergent EDT state across a hard reset: the netdev-side
>   pacing horizon survives while the adapter-side timestamp granularity=E2=
=80=A6

The main AI feedback to this series continues to be that the
offload_horizon can remain set after a device reset would modify the
max_offload_horizon. That is mentioned as a known caveat in the
commit message. But indeed we can do better.

For v9

- I will reset the device offload_horizon here as suggested:
  Disable offload_horizon if the new max_offload_horizon is lower.

- Am considering a device notifier in FQ to do the same for
  q->offload_horizon.

Having both a configurable dev->offload_horizon and q->offload_horizon
is perhaps overkill. But we need the new dev one to safely roll out
the idpf feature default off. We cannot rely on FQ alone, as there are
other paths to pass packets with txtime to the driver: SO_TXTIME, BPF,
ETF.

For the other feedback, also for v9:

- Will restrict the 'expect_fail =3D None' to the new tests that need it.=


- Will address the few other low severity points.
