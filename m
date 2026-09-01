Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1C3BE659
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271643; cv=none; b=fSNTgb9MawmEkauIpFjXfyblJr/BxteIhKO1boyLXFJiuaQ109WMBpiK1GsnjFraoAml/xYdr2ZYW89ZonP08JpgBTp9zZBki5z5gqQRJ7vMwAgofxp7/JFf7t2LgFJ1D4xGnMkiiEfnvk9IiFtWD3YRnnlNjLMft7Iy/mefdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271643; c=relaxed/simple;
	bh=0Pwx3Hc37IzwLO80eSQXq/W0rIj/++qSYLDeySdhkw0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KEbWLxIGJEsPYRgNO0o3sOT7+Tj1I4fEaZmbvUU1ZCo/VthbH89tcB1mbzQDJBbK6SUlAj7hmJNUk9EbbLyZu8L5EuzJwM/hEyJQLnRWbc+oCKk0gE9fqZypxQGdR/ZFy6MMaC+9tz53E2H+4QHLfZb6cmMCOL5ocqz+hmiidkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2tUAyQp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2tUAyQp"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-855de2d0d4dso16082077b3.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271641; x=1788876441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZpnRHfRMFzEAWLvemeBKEVpeIxRl4kUoq6EWJEKG1u8=;
        b=Z2tUAyQpjVHmYHIACH2obA1yvS74UvLMNOmzvhxyId/proVm7vacQDaQyP6PHS/zpc
         KhnGCQDErfMSCuVBqdeKDVkTHs+L80Wc3ItPD0Glhb2j34ZgN6K7fu7JKUIT7FTG220r
         VDs+qS2aMgrH7eiKoimErZnaH4ohK/rwgV8ZFSdfRfWECzh5r6RpIyGNXvxA/cRRSotR
         myt0aSZ720HyKSFA/OfRYZngNoPoDtZV1fR6ke1SqPp9AU01V6NUI9Tt334yt7WdO5IF
         N68qD5V+61mACQ4V/VOF15C0Un0w3P1VzvWmAmfqg7PGXnnTqjZeNfPXAiZXca6AMmzb
         5J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271641; x=1788876441;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpnRHfRMFzEAWLvemeBKEVpeIxRl4kUoq6EWJEKG1u8=;
        b=biu/bJcK0f+Stw1ZnW5k1sB1wykh4Y52jIGO+2LtQl1uBYK7NUUVheSCZO7b1kyZye
         ibyn4kWLuilBcW3QwFi3rCyFLXKFdK9rQICONXMD8htAc3ZWsinNm32Mze95rt943JWd
         k/yR5U7vz7N72Z3938i45pUn/ngSslRfAolDppTofZ7iLlagEJn4UYVCtbCsmfX4Eo76
         2YgCwAFikniygMfryg+7Is3hfTswwlkp2QbDjV7IV3Ivq7La4QYwPIyuPfNpR6Ik+Mw2
         o7TjKwpOsP+MtqASwXK7zAJCvd90pZTbiyowohNHCkcmuz3ZhbgiuE8W7vKf8q2iFWCa
         nYRQ==
X-Gm-Message-State: AFuF++mcafTdf7PQUaTbLCEGDlj2XUmTjV2yli3SeMAnbF9cR2REtZki
	+j/FaN3gxpIf5v+5STAS/RmRAECdSHWEZpOOpzfHEIVVu6DqAWKhvvUdKObZ0w==
X-Gm-Gg: AYBFou3U5j2RvqxVmJ/DIB2g73v4pPfZWsGq6eUD4cOd48EZeILBbI34ifH8saiy+hD
	DS4Li3pnhQHwmRN+iWvKsICKoRaflOiPG2gjKQ42/B8dLimgm2r6n0xP7ylhSYHLEUHoIDN1DtN
	DiVPOyjvxmfBPQgWZvA1/MQRB22bNZbMVDlV0SSDvWwfATBAB78xzMGn/Ab3e+jjrAtjqFwtlMW
	TWMzOftV3WjbEER1a3oXmtstHLDzWoLH39yOMCDYtlV5Gr6wb9ntw5PE04Bg3Ry7PeXfPP8aijq
	CprUpmjnhgVMJnD9XAEze+9BMNiHTKN9f3b53d0Sdwq8V2O3QGHWCFU62grQrJJFz1EnwANvnDg
	Rj58/2Hv4i46p9FFsyCBAvn8A0cXMhs90tBPi+XyDF+39NsUuO2ElA6B97bU7VOIQ3Q2QZPVLzy
	0jz6HhuMmWgRVTtw7YlBxPk4lPzyUmaM7GwAn5TOxrZEAm/puMrufTzmMcJ8osaER9fi5TJafll
	rx1/ZuilJb4vdyZdNQ3IOCa1YMa/4VvmM3m9lSmd7SkqUWQ2AK3
X-Received: by 2002:a05:690c:6:b0:80c:16ad:2f16 with SMTP id 00721157ae682-8694a045dbfmr25369617b3.8.1788271640592;
        Tue, 01 Sep 2026 07:07:20 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed19446sm74640317b3.14.2026.09.01.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:07:19 -0700 (PDT)
Date: Tue, 01 Sep 2026 10:07:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nimrod Oren <noren@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1bd3bafef8eb0@gmail.com>
In-Reply-To: <4804ad0f-ff5d-4b74-8285-9595c0c6732d@nvidia.com>
References: <20260831163734.1121891-1-kuba@kernel.org>
 <4804ad0f-ff5d-4b74-8285-9595c0c6732d@nvidia.com>
Subject: Re: [PATCH net-next 0/3] selftests: drv-net: split up gro.py
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nimrod Oren wrote:
> On 31/08/2026 19:37, Jakub Kicinski wrote:
> > gro.py runs its full set of cases three times over - against SW GRO,
> > HW GRO and LRO. It's our test with the longest runtime. The 318 cases
> > take 12m30s on mlx5 with a debug kernel.
> > 
> > We will likely add more subcases here as the time goes on, so it's
> > time to start splitting it up. Long runtime wastes time on retries
> > (if any of the 300+ cases fails we try to check if it's a real failure
> > or flake an re-run the whole thing). It also forces us to increase
> > timeout for the whole test suite.
> > 
> > Jakub Kicinski (3):
> >   selftests: drv-net: hw: rename gro_hw.py to gro_stats.py
> >   selftests: drv-net: split gro.py into one test per coalescing mode
> >   selftests: drv-net: bump the timeout to 15min
> > 
> >  tools/testing/selftests/drivers/net/Makefile  |  9 ++-
> >  .../testing/selftests/drivers/net/hw/Makefile |  2 +-
> >  tools/testing/selftests/drivers/net/gro_hw.py | 14 ++++
> >  .../drivers/net/{gro.py => gro_lib.py}        | 68 +++++++++----------
> >  .../testing/selftests/drivers/net/gro_lro.py  | 15 ++++
> >  tools/testing/selftests/drivers/net/gro_sw.py | 14 ++++
> >  .../net/hw/{gro_hw.py => gro_stats.py}        |  0
> >  .../selftests/drivers/net/pppoe_gro.py        | 46 +++++++++++++
> >  tools/testing/selftests/drivers/net/settings  |  2 +-
> >  .../selftests/net/lib/ksft_setup_loopback.sh  |  2 +-
> >  10 files changed, 131 insertions(+), 41 deletions(-)
> >  create mode 100755 tools/testing/selftests/drivers/net/gro_hw.py
> >  rename tools/testing/selftests/drivers/net/{gro.py => gro_lib.py} (92%)
> >  mode change 100755 => 100644
> >  create mode 100755 tools/testing/selftests/drivers/net/gro_lro.py
> >  create mode 100755 tools/testing/selftests/drivers/net/gro_sw.py
> >  rename tools/testing/selftests/drivers/net/hw/{gro_hw.py => gro_stats.py} (100%)
> >  create mode 100755 tools/testing/selftests/drivers/net/pppoe_gro.py
> > 
> 
> For the series:
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> 

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

