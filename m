Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046433AAF49
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565539; cv=none; b=sUAOEu3ISp2CS4E5konDvKSf1ivMyZFFrfKH9PFXD/hh+iZnbAe/tAJ6e4SWzvzIjYK+yT5GGJssrqkrjqaEsLM1p8JMNNrpuG9jQ3ojHRqiNoxF+aV/stl/h1EK/CS+RLORIqHLluAp1XqdPgJzRcNM1GGggewrUTu0J6SqRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565539; c=relaxed/simple;
	bh=fkFTQQNYnQSSSsDD7OGhM57lhbiJ5lJKsqadU032ayE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZygbVHRUFTOmdxui2lHRK6bxB4xZI5X7lvh9Uu7Tohr6z7VNXwIeO+9MPU6+Mhw1yf/mLSCcPxC6Hot2cWPxuowiNN9JaYYNPRYYadFNZQHJiq6mQB7t71D2U+F4ZVz397Yo8I2jsMYFYvma4p3OQw3wuun6OphwndFqVK+wB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=OQyiNN63; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="OQyiNN63"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48436251906so1750760f8f.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788565536; x=1789170336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RjaW1h7vZKLdHfo56Q43CxCz+PpDYJcHVHSJB9rJaGs=;
        b=OQyiNN63vU+T9mYDThlN6nY8237tXPzcMLsJtneON3yQ3JEAn5FQGVworkcxBGExTG
         VTxligFfwnhu4FTy2irZ3VktU2Xl0PsnLdIBIUvXQWuaaAz4vy+lVO/nJYM2USLKPdW1
         BRDQgGZE2y55Pol45o1xoU9m5OyGKrFPIDF4r3QpLAojqva+jsf4eyHMWHn5PBQOhAUl
         x6U3WrwwXtYwexxP1A4jD8sbGXfKKBReVJ2EpOdTeo5GqPc3MebaRctRgGHywD707Div
         /WjMFc9LKVF03IVUHdEkO1CdHD2WM8BuqDXURbii3s1yPpJaql/KK4Hxa5z9L+Z8QBj7
         e0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565536; x=1789170336;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjaW1h7vZKLdHfo56Q43CxCz+PpDYJcHVHSJB9rJaGs=;
        b=MR2EpsIvvHWtLnY+5gI3dAaVT8zEZNOuw+Dx1LYRJCp3NnCQ+lWdzXBwZdvabmR1G1
         LEilmrE15oIyUeTLOx2/2R8jAh2m9G1klo7IaXfHlvFfOHd9IyEeIUJUq4Q7C4CfmgBY
         mBxp5zIhPXkj3UGa9POgDo8k21cZUJ7uV5ZQQTi6xghr/BlwqYZmjL8SqNXE3N0NLwQz
         9BUzNpcKgJfK1y2ETANVc/cpnhoauAfHUstTCxUNedo4VSCHkJ9yySLHPXE8TgNKl4zU
         1AsnTEfRC6Oam50IXy4YD+XKNM8BFfE2eTpFg3AHZ4YCA5XRvsbsOIrcHKhDafbx8Al4
         9ZDA==
X-Forwarded-Encrypted: i=1; AKwUvBy91vMraRgr3o4Ov6Wx/cKqacm1y/OTN4fntXKrqXbgzxnyoI1QuNEhJM22eI5x7tZat/4yVdc=@vger.kernel.org
X-Gm-Message-State: AFuF++nj+saixoIHIRZf7+aFN2TlbvT4chKRXxLwYwgDXyLPbXGO5/f+
	uWE3bEblnZcz4UazgvPxl8drdo8wV4lQvTkOBFhA8ZJ2+1/Y5putCI8PZ+ZwdjfMAAE=
X-Gm-Gg: AYBFou3eDzuntAecEgeP8u+X8MbH6kK5MQHHW3oM5gxESnFtzzDJwWvwjgPxOPpmUTu
	fLJT22FJVo2Xvwoa2+AgZJVXB9l6burluUzkkR3r6PDa1dvWae4/e/NP0Ns/U1/zVsw7EmIhUUO
	PViy4xCWOb3sWqwFfPGSiRoYDRk+VvgjBS1FmUJN8nI3D7PS3lCjsvAN4aJnsFJzNHEdEYC23cs
	8iGU/xqFi+LZAzDGEqlIum1aL2XHSzTnO9msm+/QG4REgRLNoY3v2oaMK7cGj7EnmkrJ/k4mTAx
	ppbmvcbF9kicBA6Jlz9hF0tAOlGNyoULQQCJkhdEcenLiPx76U15r4nCfADqW/wwYzZ2iThG1kS
	/D7TPpwdaU1fgaFsNKVijWulRo3ZbD/PM14Jz86PSvu//zbkDyELJWqg/0/H0EgV6CBxW0upCYD
	8CpaTgTNYqSj7K4s54vyrfb/CMQDO5zQ6jJhT4heJ+02WofiNT2A==
X-Received: by 2002:a05:6000:2388:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-48586bf25b8mr18225190f8f.0.1788565536106;
        Fri, 04 Sep 2026 16:45:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a56sm8018342f8f.15.2026.09.04.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:45:35 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: reject an unknown link speed in the taprio setup
Date: Fri,  4 Sep 2026 23:45:34 +0000
Message-ID: <20260904234534.407633-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cb6da9c8-aea0-4740-9709-d718462481e9@lunn.ch>
References: <20260902080528.2211468-1-f@lex.la> <20260902080528.2211468-3-f@lex.la> <cb6da9c8-aea0-4740-9709-d718462481e9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 18:37, Andrew Lunn wrote:
> Can ethtool_validate_speed() be used?

No, it returns true for SPEED_UNKNOWN:

	static inline int ethtool_validate_speed(__u32 speed)
	{
		return speed <= __KERNEL_INT_MAX || speed == (__u32)SPEED_UNKNOWN;
	}

It answers "is this a legal encoding of a speed", which is the question
you want when a speed arrives from userspace, and that is where its
callers use it: net/ethtool/ioctl.c and otx2_ethtool.c both validate
what was passed in.

Here the speed goes the other way. We read it back and need it usable,
and SPEED_UNKNOWN is a legal encoding of something unusable, so the
helper would accept the one value the patch exists to reject.

v2 is coming with the commit message Théo asked for.
