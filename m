Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754305;
	b=qF/KMlVPV4QpIG/lmGd+apspJ9SvgKxaEVe1s4dImJbabYkacn41eN97oJURvon1WDmd
	 1O+JCqSGz1X08lQyJkuioR5trqpODUKpych/H32FtGBtKqIN1n52hon9BMPem1wLsRJ5l
	 gzuozjJW779UsBIPTyCeAa5lIvZAiU+1pX5qwlSR6EcK10Daui7Tlow/hQDCCUBqvnDtE
	 rjg2GCcNOZm+kYJv4+lha8ywzVeCrfxg2JcBI2Uqz4AmfPEt+q0AY2bEGMylBzutdbTGi
	 xuN4Va6gCttlL8kLKjq3koNY0QdnQ9vdffFUhSw8LCgcqDzBkIcSROhs5yjq9YnQnBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PIkt9+Fx/YCYAbZPoTX6F+aKXP9x+sAWjt1ugbmEx8k=;
	b=DFlxNPrtpFmiUD5wsbfRZNk/NPc1K4LnQ3U3+SSraKN7WPTIvUFabC9hr1egx0WwI+xh
	 JcGptLrPdoF0rOhgzqa8Qr4uJTLX7422XN2dKUORDZ4Fkc8Xw244bfgWt/k5iAMUXYQXu
	 GN+S1IFeXm92Pn21ol+B8UcSetVkrbNR/4rDKElu9km1f0nVzGCC/4a9tF0UgSiypIgaP
	 tez6ibRetW5qdlL17jgzaSjrXw1pH41v4w/6qx1JqdSvpXQ4z8r2v6Vh8J9345eGh2BkX
	 XyBtiIh5+5NqWn1IEXUOAOO5N6BTKwWFBQYKZp/SouBCgon05V5OS5/gSdE63Bm9Lbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhzd2UlF;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF5606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FDF5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhzd2UlF
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso406819f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792754304; x=1793359104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIkt9+Fx/YCYAbZPoTX6F+aKXP9x+sAWjt1ugbmEx8k=;
        b=qhzd2UlFNglAdwJNuwK1g+JNcFDsL1dmaLYPEk+opN0WEKigikFeo/zmpm755GJJQ3
         IzWwxzdbniPhW/lWe+vPXzOzcoFYU4MKGwmWUcrH2Us+tzA0nWnmmno0zPxXPixqQJN5
         o2zHtNtRRZSKIixfMyHog55mdzLH6q2/n/1OTdgEVT1octFwAA4xoXCLwRM4YjB/ae1C
         MOpNiRNfQYkuE89ksvt6mKAuVBW00k/uwrWm47v+iEUl2DKHIKQ3fnPI6wjnKc6PijTN
         XGtr/G6G3QSMw7/mcHWQu3T610Fjbrf9cGxwrtDum6+brOmt5EWAZAZq7ovfJForpGa0
         tKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792754304; x=1793359104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PIkt9+Fx/YCYAbZPoTX6F+aKXP9x+sAWjt1ugbmEx8k=;
        b=VBsqeYW7Oplx2OjQHJDTIAfRPny+v8+xcM3CI79D/tyfpR0dG1W5dhwzUtSVXG36N8
         oLQb8FQQRbBrEfdNQidZVSWLKlub3LR6YYhV5099fUFTkaT/l87If9trtsqcO12P1KLN
         Ros3SHuf2Lkczm9cs2s+30O+LgSAFo+6c/em4Potnp5ohwCDQh8RM8ydF5KRYHMmQdOu
         6P+hH0V1+7sdwKUyvg+c0eHqqqRATDT9Qzvh+22ZGtZaswueaVpuHvTg5t8lgQoZXn66
         aN9uV5EH0K2MYsvUrxyofCeoKsqGgijIpdqqcQFr2bdpPA6LzntRur+/MgIbMeEM0rR+
         SasA==
X-Forwarded-Encrypted: i=1; AKwUvBw1cCeykl64/mLsP6Hk2y/iflsLadd5pROxnWO+WM4s/gcPMuJ+M5+bYRzGU8M6stamW6/DkNo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpMqTCqxgHFwuM7T8PpwsstSkXmXTEHC8OIReNIL4yy4YZfBmD
	Hlx3nQsDiKSRIsZmFpBN0fwtkxCPzUCnlOvWat7fEzPOwYOcb3duwBez
X-Gm-Gg: AYBFou1OONG1+NXBNetDkCuk+9M33IWnZO745rcmr4Z9YRhQK6H73KwcNjWXtA1Cnk6
	V9V90UMD7gwtSko+7cM2w/gWhFmCf35gTSXdz7avCDcGAew4OaUWf/YNXjpuQPxfs1PlxkBn2ZX
	CwKyo0vDfTUujuerXo35f05Ufcc3zx1ENypPplUFz9XaJETwBPcGIGE994DpZENRZFiUdm7tQAw
	RJhMh9b50NZVDA+XyxJkARBhs0PBC7YFgClkc+ONkeTmU2mSfwkQtLRHwVdsfOs4aBx877vn/WK
	abEM9et969yr/3J0p2WiB+r1NJg4DM2OtzABV6MRCEUAALlG5HXzP+4k9vWIaLTp+vfq77Pd2BD
	mwNZcaJEljgmJyeXGkPGcFhZeO45IeCmnvuA2rDP04JS1DDkUBAO5zmBHv2NY+Z53t01R33atSf
	YCbGk2fEiB+rW4htmiHSx/b+7jrEF7vgXN1/LuqGUd2yPjMzbiw40eth9h24NaWHKqAR8r1Nhe9
	e0SwpUnWcYnyFhF7Aa42eUIz6xL37C6pt0xZxUpRwzk7gk1yHIb1BLfe5RBVAHy+YlQl8u3+suh
	Xw==
X-Received: by 2002:a05:6000:3105:b0:488:654b:ccd8 with SMTP id ffacd0b85a97d-48e3854cdb4mr2949659f8f.6.1792754303172;
        Fri, 23 Oct 2026 04:18:23 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:3b23:18e7:a7a0:65af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38048ad9sm4621612f8f.35.2026.10.23.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:18:22 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: dsa: qca8k: serialize register access
Date: Fri, 23 Oct 2026 13:18:20 +0200
Message-ID: <20261023111820.10630-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179266392377.3135.12848522239467347386@kernel.org>
References: <20261019191137.307514-2-kuncy7@gmail.com> <179266392377.3135.12848522239467347386@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. The issues that exist in released kernels now go
to net as a separate series [1]: the regmap locking from this patch,
with Fixes: c766e077d927; dropping late autocast frames once a request
is over; and a length check on MIB frames.

v3 of the MIB statistics will be rebased on top of them once net-next
reopens, and will address the points raised on 2/2: requests from the
poll and from ethtool sharing req_port and data, 32-bit deltas and
counter resets, the register fallback on link loss, the teardown of
the work, and locking of the raw buffer.

[1] https://lore.kernel.org/netdev/20261022192933.384898-1-kuncy7@gmail.com/

pw-bot: cr
