Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AB2D73B6
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825447; cv=none; b=QYzisxIWSVwqS6ffXU/Zxy/xlnpFQwPqsJC2n1llih9XZYDfSsQijWU8MmPm36Oq26mi4Rh4gBFt5V4i5UiNH40rgEJUgzRUqdKdB44kRf53jT4ByJ7OrrQYJfyUR8Zk0MzCXYEFg74WUkkh9iW8lBUkLYw+voxw5KkJU83Pp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825447; c=relaxed/simple;
	bh=JWrGbMudcKzw5HxCbyCgsocUjzBFrmG6zFPSksWLpQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAR2K5CD57Tdq/EcSJtTTfPuNh4qZAecUjxazycILq2cm0fu9/izYVSG/575UV/tvqCyFsK/0SiQUMqxhN13ihqyIwN5DvATn8ExMoz8dQtz+tU4AUzlhAHtCfkWzq/asBDdRGV7uuSKhRJOsX0mNg/WtvvuuIGOLEAHZ05QyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m71RSji7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m71RSji7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a49a40209dso15614001fa.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825444; x=1790430244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWrGbMudcKzw5HxCbyCgsocUjzBFrmG6zFPSksWLpQU=;
        b=m71RSji7bRr7dJ9r93a0vwUy3TTOaHbogu5Piw5Ae5BNx+gfadF/GiT8/tIfWhRh1K
         SWVOFAQvTsbh88u0PLJCjEQfiSoHwLnAJoM9HsUD+kGTE4doENUyvj8nOCTYHS3n2isC
         /N15lWBQtXQ93VZEqGlD6Ygomb0/yVtZ3DolPjevostei+hlqGuFkHuuGErtSLATmaeg
         bLy8qxKf6vxGchRiohXIs3tmHPmRWUKBppK25BnpOWfU4Ozzd1Gyoevtklj/OfX2uMeP
         zjbHukO1D+Jmtt5FXIzNlWUTCMWQ5l8h15jPTer3m8rDMcK1zFS/yKSojeCn5yzQDUu7
         W6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825444; x=1790430244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JWrGbMudcKzw5HxCbyCgsocUjzBFrmG6zFPSksWLpQU=;
        b=npxdMchhqcsAeMcFn1bNbzgcMU9zqwjRMTQFTDt6YhtBTKV4o2/b2w0CPzYtLoIDKv
         Nio71AdnQjR1OHHciuVZ4qVofjY3vXX4TIBb5CvUmBT6aC2VWElOvaFtuj2nydGcBMME
         Z8qVZYRL0ZOJ5mWGo/bCB7FKBRUvrTjc3J3fO7PgH4f32cUdyKZY5Qt8BsKpYyqQ4W+E
         DNoHCHOKyf6cwaiHf42NvrAQzG87ZJSPRHVkhbM+k1TlZ3afXZuKBMa88iPAqXnW9IPc
         w3iSfzvXtAip5QqIh50r4crgMOJjEhOaVueNF/QpRYe5Jv7TsL0Gv3q7OOG6qGOYmzIg
         dJMg==
X-Forwarded-Encrypted: i=1; AKwUvBxSBZoYglMVkEcWTutD4Jc55uBs4NFuDSgijdH/ECGcVOXEfpeyQI1+MzyK7ooPGKOUDG0XO2E=@vger.kernel.org
X-Gm-Message-State: AFuF++nVe7C6xTd330YgjKhgYeriPu+nE8xYmhuNdisAwEOp08s88Kd1
	B1t1oPxVdbT99hGCTQCIXEVA+ztJ2yj+L9vU7H2FjUvQ46swv+CQdR/+
X-Gm-Gg: AYBFou0Gp0mE2tdgGNfTYY5Ko1Hdw4vraNdNESxKb4sPO8YozkzqWR7DY06ke+VphtD
	ilaGrcL2MFLWkV9Fpp0fmFWQ2JBVdgdKoAmLlCOKa7slTc1YPYrJ0amE90C9LQ0ArWh03znrkX/
	Wb+uxlv/8ugM4k1nztv+3RkZ34rGkruCI13e58/l2YiXcAcfWSem0Lylb+yeF8hpLN/b/5pTyNP
	4tPsAO8s3cVHvisiWGyd1MHd/p0WpNZDLoLim6aOZ4IW6Co0x5Eu9j8A/HTmeqZwjpG3EOf0OS1
	wwGQkjh6iZEEyYRNxyW8zo+VSBHwKoDFi4sfuiBUKvsa/bj/DoMIxC6Nv013+h4vhtxlJycif2R
	J6uAMi//vyB7yf638wAeE5c6KEMTqi1MsxmEPnmvN/42WOLyqfMsmNPTKSDE/Q/qLHGo2/QTUGQ
	3gX026l+qRgbtCj65Y63AEuhH+mBbi8jAc3BfAyPWh9YTCGs7P5NwKurBOqrOA+Nxcjgybjdci6
	AbGf53ZrOpgbSfeQDlSDtJoPNTeI+y5/oV09uyvamRNehxHH88w5dLX6CULkUH0NJVR0CQ7+1lm
	YJU=
X-Received: by 2002:a05:651c:a144:b0:3a3:61ec:43c3 with SMTP id 38308e7fff4ca-3a5e739ab72mr21799041fa.20.1789825443859;
        Sat, 19 Sep 2026 06:44:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a6075dec9esm6021091fa.20.2026.09.19.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:44:03 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ren Wei <weir@nebusec.ai>,
	Zixuan Chai <petalzu987@gmail.com>,
	vega@nebusec.ai,
	dsahern@kernel.org,
	idosch@nvidia.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v5 1/1] ip6_tunnel: snapshot encap in xmit
Date: Sat, 19 Sep 2026 16:43:50 +0300
Message-ID: <20260919134350.51793-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7a67cc6c-9b3d-4332-b9a9-f63d959d5e58@redhat.com>
References: <cover.1788778433.git.petalzu987@gmail.com> <ca20d8addc2d6b01cac83ed9661e465c47e9b94c.1788778433.git.petalzu987@gmail.com> <e651fe9e-2d84-4320-99a1-6fddcfc00889@redhat.com> <7a67cc6c-9b3d-4332-b9a9-f63d959d5e58@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 15, 2026 at 11:20:56AM +0200, Paolo Abeni wrote:
> As noted by Eric in v4 the solution would be convering the encap
> to RCU.
[...]
> I think such work should target net-next with not fixes tag.

I have ip6_tunnel and ip6_gre converted already, was waiting for v5
to land. Will rebase on net-next and post this week.

Artem
