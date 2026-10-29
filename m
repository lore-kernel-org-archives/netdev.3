Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247782;
	b=4cyV7pyHZ46aasvq2u/XmPo2VcHqvc55CcsIF6/zxI4/QYizulBziISZOJfQPWVfQ9zt
	 p7tl8bnfJNAD7/DGq3vUxtNgjhGchMVA3yiBKcGrx3fHobM1Lvn4z6twFvf7tIIi6Ael2
	 4DnyF4MaxZ36mGRxsK5oHmuFyS88CPwqlJdHjjYxQqOhYQPoDMYrZtwGq0G1hKcyQUlE5
	 /hhHpB87KZL1Pj/NXxyPrlJ2mK6Xxfyh/0S+F4vM8J3nXypdS3Go/DC+jMGlNpbNJ2kqT
	 jvCo6P0eeqCd2SqVQy3EbjR8MIH2Gp3MpaQmYfhy6H8pNq85sypnTrz2GHW6cHJio/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eSVM4UdbxQEAgAAhFhVlTTn7tui5ZWBcWAnIAXfSeOU=;
	b=id329GpgchH4+abAmmJVklBfyWps8a2mZ4hzPRFip5p4QVTepevizP4gyLRzUMkJGnvF
	 OcbzcqSF6epcWKCfStp+Fe6nPs0QuusfEa42iQNHW6fEOdaxwmnxy0xwOYYcZT/kjeKje
	 HvkwzaNtzDPGSxmHpmokuORXS3W39J8p+ZzxGcerHNUy5wNoI5uRX0PPh4xxvGHD1dmVk
	 LiDq1lBpEQMISVXAo89hxkjDrxUSQJjJS/Q603WZ3jKMYiRhFkmoMTOS2uN3xqurWEnDf
	 wYGqS6dIlBBnsRRZL++XADLBJTUIjuyNll7XT5upzNYQ9ZkgLBvxjdpxNU39ruhgoxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgJUx9vJ;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC5606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgJUx9vJ
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so816998c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793247781; x=1793852581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSVM4UdbxQEAgAAhFhVlTTn7tui5ZWBcWAnIAXfSeOU=;
        b=YgJUx9vJ06xniI+mXR+7ovjTmGyo+6gBZdNaixZ6LAwOW1u+lGyrjV9ABqnq5WE+yK
         M9UTRirA4Qlm23cfuD9r7dv8GcQRhQl93IjZnh3YZ/Xk0ReSBzppIBVsLFlveCD6R01a
         VxPKPgoTWt5riVBO9rcnfO8bIojuiv0y4BXKEX/i1QRSJrvOQoCAX2bqurRZGJJxY4q1
         UNi3Y7tEbInVyCtokH9MBC3AngET2whxQy3D+Y38xu6MO9cM1JfK89whwbhfnLMn8S7i
         lwUmvw2tucMXhoEiDizcXYyZzZPZGo/ZgIDykYy+cTpwrkhu/bQ+Xv7h4vZUlNGBSK8m
         D8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793247781; x=1793852581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSVM4UdbxQEAgAAhFhVlTTn7tui5ZWBcWAnIAXfSeOU=;
        b=Td3RcmDDCGknnv5mdP1B63bIaKJyNwuI9Gn4KgBzuoujdwuVkplYzWLn3IFgY3YBzO
         30KGprqiLWX8hdB5DPdydoW7mU3dohdR3ocpcWob4TpbicoAzIABI7YoYWqOmdQkr7zp
         qBoWSf+chxQonAtBUz4ElwsziXQ4C0UmTStVlaNm4/elIPjfvWAItCWSRz7LZBqrk0g1
         YDd+TvA5Qwl7s/KI/gHoLyvmwm0bTaU7WuR5r7ZsyssLiCHAP3zJHE/60NcLw2jxdwPG
         SUBjpnHiSZdrHBBesOcYVKk+NCob2A4tQbtbIKCqfckR2lDXqlrOmj8D7sRxfPfIYjpl
         gSrg==
X-Forwarded-Encrypted: i=1; AKwUvBwQDVl5YORmD18GmIShWql09x+02m3hld6PPWAI0EzvZLZvtz2UJ8Hf0QuHlmR7fIsS5eRhH08=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv30Dm+imLBt+J5faoZ6uqyQkxt4lqxHUBQZeEhfuXG4UOTXYD
	DuXnDkYd0bKvjCIOuimW3BTS4B/3Jiwa0QhyvPeC8Oc1+OPoEdj96fufxpSS6Q==
X-Gm-Gg: AYBFou0A7ai5C7YvBngw/ici1kRvFrRZq6bRhPc9qDZ4oLqcgZZvb0dFIKBRVPUpFPM
	RdTs9bK061HgHuXXXSOBj/gZmAQ4OpWXnq3ZddHvZCa6Yg7m0zr0LlpkUGjHLGd5wYwMO/Pxpo0
	urQQESnYsXexlcZlc9lIqtaCWL2g75cGDMIP05Mrumobk4bwRNvDZXjTplUCBkWQOjM1RdnMkB4
	yDi0nLFIfU407rQ1woBOLwskA6XL6AGzvmmkUBJD8iqko+8Zimvy6lvgP1s4nj3MFq6E9NtvSBf
	4YYanix5Yq0xCacWAg3Tnp9jjzRHrDr1wIiwzacfSGPnyKOD2X2cceUx7o5nht2ZzMZ66y3y7xI
	0aehwnJ8FBZuduKXNrKSTC6x1vFnNgGKo8Zol36Q7ODfzZIDMtiuFLUjF+y9Dn7OfyKPWahLeMz
	wU2uI1HE2wARiAuPcrUggG5PZjOOH6IPTg2QbFkRA4SWM02HY8J73wHsLnd6rgDRSdmHEWLzWAe
	GxKdN1JR1Z6S5Q27p2MvwpsH5biMSELpZVMpbqllIsOf6RYNNlGTx+4CVOyGmIrJe4xCvG46cbT
	nsb3C8uEInrziraYNKhLVAu8vg17Hg+tjBd5OUiMqv3kH46ClTMW4alDEbzRlZRNfdJ+v0A68g/
	nmr5kogMP23VVBc0ioI8nJVMyCTm62ROWakhxYvid8anXe1qyd66+M7YoAEU8tXSzuxtLoynxo6
	O+THEP9oeCHrElSo4zrxs=
X-Received: by 2002:a05:701b:4549:20b0:149:cfa4:9b3b with SMTP id a92af1059eb24-1a6c800e40cmr6244006c88.3.1793247780458;
        Wed, 28 Oct 2026 21:23:00 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d85f23dsm9418601c88.11.2026.10.28.21.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:22:58 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group
Date: Thu, 29 Oct 2026 04:22:50 +0000
Message-Id: <20261029042250.3341738-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
References: <20261027130623.3136658-1-anilkaushikwireless@gmail.com>
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

Adding Donald, I missed him on Cc. The patch also changes
Documentation/netlink/specs/gtp.yaml.

On Tue, Oct 27, 2026, Anil Kaushik wrote:
> ---
>  Documentation/netlink/specs/gtp.yaml | 1 +
>  drivers/net/gtp.c                    | 3 ++-
