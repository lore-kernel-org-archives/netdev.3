Received: from mail-wr2-f26.google.com (mail-wr2-f26.google.com [74.125.225.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE5242D88
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233139; cv=none; b=kujuRTHKa+v1/Nu4rjEmWdqjY5nShqYjBDMFw2bs1L8/r2sgBo0VVaiEszOyM1gUuYwyWJnBwW+oF9HalWeDkDmABpUacJIbKEX1TM6OAb7LiP5ChatQ0I+oTaQFtHgbTy20x00KbmtDcYLLd2EuLXN7pvuK09jgWgHFJLrwYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233139; c=relaxed/simple;
	bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTHkypQPnbVffCvLth55oQMWYxsH1veywy4UnC+FwHSUHbx1EdZ94L3CfN7+ThJ1gIlLdLgnrOIQkbWrOJ93dBEPLIZoV2P853kd9MZUR6+pUPtWtSfbFIVvVC75vbmQOBivPw2E+0bUdoICO+M/5A+fwI1PeVKgZ6kl9ocQG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGOnhn4N; arc=none smtp.client-ip=74.125.225.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGOnhn4N"
Received: by mail-wr2-f26.google.com with SMTP id ffacd0b85a97d-4843f22dc83so1294810f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233127; x=1790837927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
        b=YGOnhn4N90wa/GdEq792XaKn9/RwfFLbvYYhaDFzmacDRfMLflPvAF3TOa+p5LGTKL
         pJc6w0x24SiikWUV7njX4ffrIrTsP4qfRBh1mX+3c0OW9ytT4IAqEcns3mVmFor3Epbe
         HYk1XqICQnreXHJlkvreq5+xK1Q85JELWmiD2Ma90q4EPYMeB8wwFMpuJDNaOsWX2R5E
         6IVtNVfoxLfmXgenYREPg1WC2ZsHBWxiCtx7r3R3ulPv/dd0cHfWrTF7tz0dQ064M1il
         GuUvk6HfP91ge+R+Mw1UF4cos95L37/sQxJ36jOzp2A701je+PBEEyBR1c7Dg4bK9bDJ
         DEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233127; x=1790837927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0udDt59MpBhkl1PfoDwulOFVVwnC/G5KphRMorcHheU=;
        b=PUGiRrw6TOqP3lhJD2aEzMTg0JD7mU3c+p24hVKr9A6kdwqDXG5Drh5Wpt5jRy6XMA
         CNLo/KpoB+r80uzQfQaDUw+1OMZiLuxpAi9ktaeBF/q4qUS1dknHu9WF0ZArEn8Qs3QL
         cFmqwi+ygZ33lEPHe7KKDXmRlOsGGKKTCkNiuNunA7+owV/W1kha+9zzn+ziKYJpkfnI
         GpkQoTA0tzMX+ejWc9//Z2WFVgkn+Tiw+K7hmhHnHBA5ggHtqHiaokeWL8SXYLapqinA
         hkO1mwDMGplfGo2oaSJUav7zWzfDWtbsV5S3J8XfRT4rDF3o0H5pNiUgrsqNlZgaFGYN
         pwvw==
X-Forwarded-Encrypted: i=1; AKwUvBw6Viq8RPIG5VD0f7CbvtviY6ryfZB1K3/JX35hNVhBF+aWlijm+MSge7LeQQvxOZmZnKMXBEY=@vger.kernel.org
X-Gm-Message-State: AFuF++mn3sgcMR2yImWyQHKef1gnSzJrsNXdD8tnass1CDX1QUecP76P
	kwlmdPxFShEDHzqZNbWQpYIeooRY3ERd5tDS30hB+d3VhPZFDDBqgFrV
X-Gm-Gg: AYBFou1bMMlcojdSHVmtIWCdMT5FyQiVq15R5QpAWego7AgLLEVjtUcQgn+iqDg0/IQ
	fdbDj5Qqd8UX3zl5xOh0qtuVKIbOrqnx158vuWFY8gWEAjFUJG+VShwBQq1UyBSYlOhkJOxZoGc
	XuQu5+FwNG545JWtiQCtqirlZcBg8/lOmjxUaCv6wEaSHuUMWdnKr6Vl+X8ATu5c4EQpdlNSOyV
	u2mOWZCBElVOy0vNqMVldj0OIkPY5deXY86Gs8cIjF2+1tSwKreRA6UpwtMhYOD9JxSK90hbLbU
	tsWRx+LBrzPKdGSaBYYBW+lupx0lg976iyRLAcX7CL4751skqjsxRrx1rYPEFwysiBZz9Urwt3r
	z+yYnNXDwEIaPM2UO3inhwMyZrVQsOwlErafmSZr18WOXqjXysxTgV8nRNkFE3Yow+EYqu+v7WL
	/zpymA6VVH2z3JKWj++gnh/Zo7F9OrL9SHOmgW/b5fMn2a2NWZk+R21NezIO6H/dT2mHiVXC28Y
	jkGZDI74pEQBkabH/YpkSzT/6PtN3yT91u+KA7ObXpaQREtxV2AyxgoYK/b3u0NPmV+68TJpEQI
	lHfKKna6sD0CIBtwjV6nZB6qCAPAbQyknY+9i51jEIpq46eI3U9mC55fbiFx1LriFxIzPIRbrQV
	nIurd66CUFaxs
X-Received: by 2002:a05:6000:703:b0:486:fb08:2353 with SMTP id ffacd0b85a97d-48872abc9e4mr1788836f8f.31.1790233126966;
        Wed, 23 Sep 2026 23:58:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adbf-6901-6c54-85ea-c6d5-a48d.310.pool.telefonica.de. [2a02:3100:adbf:6901:6c54:85ea:c6d5:a48d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm9893819f8f.33.2026.09.23.23.58.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 23:58:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 129/398] net: bcmgenet: convert RX path to page_pool
Date: Thu, 24 Sep 2026 08:58:39 +0200
Message-Id: <20260924065839.56793-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260923140646.783275824@linuxfoundation.org>
References: <20260923140643.441954610@linuxfoundation.org> <20260923140646.783275824@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a small objection to taking patch 129 into 6.18.y only as a
dependency for patch 130.

My LLM agent helped me running these tests.

On a 64 KiB arm64 kernel in a custom QEMU Pi 400 model with functional
GENET v5 DMA, patch 129 increased the socket receive-memory charge per
512-byte UDP datagram from 2,752 to 65,792 bytes.

With the same 512 KiB socket receive-buffer limit, this reduced the number
of queued datagrams from 190 to 7 and increased socket receive-buffer drops
from 810 to 993 per 1,000 datagrams. I obtained the same result in five
bursts.

The page-pool conversion otherwise worked in this test, and physical Pi 400
testing with 4 KiB pages found no correctness failure. However, patch 130
was also verified on the Pi 400 to work without patch 129 after a small
contextual adaptation.

I would appreciate the BCMGENET maintainers' view on whether this page-pool
conversion is appropriate for 6.18.y.

Please consider omitting patch 129 from 6.18.y and applying that adapted
version of patch 130 directly.

Full test details and logs are available if useful.

Thanks,
Karl
