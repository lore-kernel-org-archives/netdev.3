Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D240DFC5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088023; cv=none; b=VWvYRA//OGBzAXFASbnP//cGjrn5K4pcDDXS7kp2s9Mv8cp4puLnZNQOk6TdJHRApiJGs94Uc01b/JPLI5e1eFf6EU0C1Df+tbPJVTxrBtRrD6dL2J/XNHPkCFYQO5NJzSZRU7d+v0jfCTeV0h11X3qDYOJUWwqj/oOv4+OeIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088023; c=relaxed/simple;
	bh=h73udEWJgauBRuG1S9wkDO0gSb/ZY3nVPD/13Alq+SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lql0O8ewTkmf+Z+ceC65R+T8+WumveIQOjUYLtJmxIlkmFGGmQMLt6qKG0nElWqXE5mUjQjz7605jzpPXZo9kqUFYv3LYwX4kPfJknpYiaMQXrx4kUBjvP0JRLDo70Ab65U5Sbfmje3Xq8cTx88IFxtBhvmgu7xZqNDKNs2DRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=sVLHFATV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="sVLHFATV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso911739b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775088021; x=1775692821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2FBTSJSTehrL8OM2HW/3pwKtQw2cCSkPwH3JEpsgMw=;
        b=sVLHFATV2mIG798PvCDNAhg/3FmtfouTJmNQId3AXO3z6Q/lJKWMEe62POsNmo/EWQ
         vTgqDyy5FDjRoumRGaThKZCOvmpNiK0AeDK1x7DSZWLQrEXhzW6kXo91sMDtnBNnhgpR
         Ju1juGtKtsR4eNs/wp+UhSYrOBymHnikuV3CHyyXl1PsLbFGWkj8wUOhXieAxmf1y7Og
         +OeXI8ULNUutujtSxE++MzR58r9/C+gdpY2MoENEDhvTy4uABmUXw1Dh4xu/WbJ28w6w
         gqI9cHvLyj+GBntklhKdVJEFaYJl2DdN96Kta9NGdpmGGsHt/36Oso6h3X8bDQJyIL2U
         DbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775088021; x=1775692821;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2FBTSJSTehrL8OM2HW/3pwKtQw2cCSkPwH3JEpsgMw=;
        b=IMBzaF2e2geFRUOhQqntrgNrhWp9oYWmJIAgNWBTtafyu9CZ9SnJsjxqNemZ2OXf9U
         AbG5i19hSWfR6Dizna3uQVWH4ND2dBx5eCFRRnPABpVQ0flAR7cyySClGPgkENIcCSQN
         o/UmxZxKNiLY6WzLN3isaWoMSmi+AYK3l2nkx0mX40Cr3d5Q4v9jNhoPFca9H1UUV8GU
         VrKpwJDS7VG9/0QBfCRXB7GnerrzbbJOpoP3K5vhvFN0pmiqZ2TRSbj7BuSFnYKPKrj6
         U1N1Sbkz4/1npOJGXgUDSFWLlVKU99OCTyG4nqGq2z/8uM0IPbRZvQPsU/AqrckrPyKT
         pA5w==
X-Forwarded-Encrypted: i=1; AJvYcCVKg65OqU6eGz8t5QSMWTpDhsaY7Xn9wtZzIV/0GY0TmuWQbXPi/3uFTNXMANvpOpWH1chL3tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfB5FEDLdb1f65ezVU52JVthxHF7nTy3OYVHtTsAUDtk/VOZn
	Usyfu+xdK124J17NMGC/uqj2sixwJB1YwTasYdF8yXWsLMM2hzHWYMQwK9Gt5BURgFI=
X-Gm-Gg: ATEYQzy8bKP5HF91XC7wzRcdCkXh/sO44jxOJoa2vQ2fxNxchDCXVtgV1TgzFX+WfDE
	1hta24BhjjhnhrThlapbdmJGuN+q68ypaMnpJRoKtCkgLCLcZWRAd+G3iD4yunqsLewH0hQGL6x
	upLBp4BTV+iTn+vfZpqrvlIpTQlriTAOSos6l+a3/aeGXoOoqUzFj7H9SqQqkUzsf1FKIkVaIHk
	tJLVM/6bCWmmU13erNUBokVReGHhP8q2tFloZ/OggsEUvqEL9AkBVv6UtvPUBHrhpCPNoO7hPZJ
	s2fLwWhQb43MpHDcSxjBX76HUJlWC/HBD5A2iakXHM5/Zcn8E9EmnPsxql8k8F6tDdsu64u1+k0
	8KX1jvnvHdTdDaxwYi2Skq87UGQlGj90zh6TnILAnVo3U68KfDCaO93B2fmcsvTVN1pBxjFm9V3
	Quu00I
X-Received: by 2002:a05:6a00:c90:b0:82c:2104:ccb3 with SMTP id d2e1a72fcca58-82d0031f927mr301951b3a.17.1775088016738;
        Wed, 01 Apr 2026 17:00:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm1381526b3a.51.2026.04.01.17.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:00:16 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:00:15 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, petrm@nvidia.com, willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: py: color the basics in the
 output
Message-ID: <ac2xjwO8Jv24itVc@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	petrm@nvidia.com, willemb@google.com,
	linux-kselftest@vger.kernel.org
References: <20260401183309.378671-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401183309.378671-1-kuba@kernel.org>

On Wed, Apr 01, 2026 at 11:33:09AM -0700, Jakub Kicinski wrote:
> Sometimes it's hard to spot the ok / not ok lines in the output.
> This is especially true for the GRO tests which retries a lot
> so there's a wall of non-fatal output printed.
> 
> Try to color the crucial lines green / red / yellow when running
> in a terminal.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This is a bit of RFC, I'm not super convinced this is worth
> carrying in the tree? Please Ack/Review I'll apply if we get
> 3 supporting tags.
> ---
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> CC: willemb@google.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Colorized output is nice.

Acked-by: Joe Damato <joe@dama.to>
