Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792866091;
	b=rubADA0cq66X6gJ3xA4oSk1z9fAz9g+tKLcI3TV5Q0cOP+mVbgLIXb7ZZ2K2o2OMVVvq
	 LsKhYQ3JXUF+IezFAOPhkgeP84+Qvjyc0T27t/qnvH9UkQ51Qv7rbu+VzJM9lvxASNe4e
	 ITMi05gxT9cEsNnznXtmuCN7y0wYbp51I8vkFCuZJW1ku4Wb4CoEFiZUoAgbItP1vm3rX
	 c4llwPcCW/EZuv2dFpO6yvqxJQRCtslXlJ/pST6CzVlBy6u6I54HtAesno0onOaLwjW3C
	 /bIPnds91AMEgyGYJvRWV1s2YurO2wM2vwLlwg2ojHizjdC7NXLeLjkKePE7ODbeSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sE9T+23rqSR/uL0cEE3JGokRaJALUOJfvl8GLVOXXYw=;
	b=TKiFn7WALuaY/1s8SY9LdzEUJc/6eFRMS6LYvbm/EW/0hxhlks5SuvjfSiuktDCcZwSG
	 qs576frZK1SHNJZr4ENTln723M+HWAPtRd93CbQkyMPwYIT2XtGE0Z86crPqQnvRggI/P
	 BIy2aRjcNYkd64C+AKYCpbURp0qeCsNbBI10i3lGoTs5I0DG8fPpNvBbCgUbj4iIKsjgD
	 curpxinXQj9B8kW5Qu1IycwUlUziJ8021T2o78yE5mH5AfGhKL7syo+PdqCYzMt3ooJUx
	 H5MTlohRB1v93mYWoeebXO70sLhzdtOjK/KRdAPvygewVtySzkLuoRV1GrZENBKl+yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRKIBgID;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5A606A322
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 18:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F5A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRKIBgID
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2202954c88.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866090; x=1793470890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sE9T+23rqSR/uL0cEE3JGokRaJALUOJfvl8GLVOXXYw=;
        b=pRKIBgIDrstUhL2irTAdk1XZ5sW3G/0L1k8cyVk1GlrZC3Z4nxj6eQoSmc5ZQEaeK9
         TnY8VMIcqWFwyyCdLo85K/Em3hr0oje8RwiWImT2jOB2szuJoNl3n/stfbd4SE071sQJ
         xBUYdcH3dUSv+U2t92V7EejJeMsXT86D+5jFY1T6GtmxTmpq3SXq/tA5IJhuYqXW5Mev
         wOBzuMT3i2kKdeX8IJIxno7IJl3KE5uUilD+Eue10XRVA6BcwoaBUlZ17cxNgr3r2CD8
         ei/IMt4+P9CoR+qniSjvDOmmcrWVp2SDIsoq5038BjLdjZNa2Cm4VmbY5XDrQ/w9LDwE
         53rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866090; x=1793470890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sE9T+23rqSR/uL0cEE3JGokRaJALUOJfvl8GLVOXXYw=;
        b=omVkHgKc1s1ji8yoiGGY+5y9Bf+uoQoQY9/j8gbVx8utFoQd0SFd235PLoN69nmTdK
         gukN/zxNLXoRel9twmPwDhdyzzIuv4LNg+2OxuclN5a0Of905vTLki2mEbU/65JbVp9i
         rfi9qNnDMBhD6+V9RQv/eeEfNuF+G3I4FTqe26GYqJl/tHTFL0GG4BZNRFy1LQaaFqjQ
         MA4lnlzNwS8Bcfku4Gs1eJheWWD+M8cUYEo3F3XqK7psJALc/SoNmasdBb6df0zIXqiD
         XlcfuFNtLhuXZuarngctCBl1V+6reb30CE2tYkf2LVTb28Sriv+LJ1ACR8f4GI6+b/g7
         BHCA==
X-Gm-Message-State: AFq9FYLXJzhV80y+hHAKodXzPfv3TVMiVqzXZ69KYB65gLXDHJAzLORb
	EEQzjUUHs1ZUdxdyHOqIr4Vx58vxakssOyUVXruboQFswF216akJy2QoqAZGIidr
X-Gm-Gg: AYBFou3nekZ1HI6MSJs4VqcUOJK8aMRukd7xh57UmYKC+UxBO8QLn/rbAL0c+TrsO8o
	okn9ZwVb8C0DMRumclag+wBiFMoTg/fOCKsbJdJ0cGTtCYJj915w0fEPsRu8TLX9tC1z8usXBCI
	UVbzHYxik01TIvvKXQw//moXiB8w7a0bughhkZc29aBZ0WfWKl+DM9JivGS1y1rCtTbC+/Lbuyx
	8qfpbtzi8ig7sX1g54jfAHbbVV2X9MxQEtI47EhCYzo0rQ8Gn6YbppCkbkJ2LuO7P22A7WFZsf0
	Ci9+29Oi4kRRtxG0M/zhSmbbfMomXK5Kx46Q/7JCQwzqCd6N/9yAfXVW/0JWGYN7GOai+Agz/8j
	+8RtPaV0Gx10i0OZfrMWvMRw5KTCGJNZpLXPePBxO7SEEjzB5aoiI9x5Gt/pRAsNYg9heV7Lpc6
	ocWV2m3BGqAJgWLehNKf+jA8rTWzvSUZj0GaxV2eXiSXVjJZcy/LKbjbU2O0XR0SNa47M4tiCFK
	faSZI06XPXsfdST2hyoJxMUxVLNehK98LZaZysk+D3c303aPV8eWws8GdQjmIBjtGRfdA05X4Qn
	75kpEA==
X-Received: by 2002:a05:7022:ea45:b0:19b:7b7a:a61e with SMTP id a92af1059eb24-19b7b7aa68emr1432682c88.26.1792866090404;
        Sat, 24 Oct 2026 11:21:30 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm8174893c88.21.2026.10.24.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 11:21:29 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/2] net: dsa: mv88e6xxx: fix 88E6171 statistics type
Date: Sat, 24 Oct 2026 11:21:24 -0700
Message-ID: <20261024182124.296988-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024182124.296988-1-f.fainelli@gmail.com>
References: <20261024182124.296988-1-f.fainelli@gmail.com>
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

The 88E6171 uses the 6095 statistics operations, which advertise and name
BANK0 and PORT counters. Its stats_type bitmap instead selects BANK0 and
BANK1. Since statistics collection started using that bitmap, it has
written a different set of counters from the one advertised to ethtool.

For this chip, get_sset_count() accounts for 30 BANK0 counters, three
PORT counters and five ATU/VTU counters. Collection instead writes 30
BANK0 counters, 26 BANK1 counters and five ATU/VTU counters: 61 entries
rather than the advertised 38. This mislabels the tail of the returned
statistics and writes past the advertised statistics buffer.

Select BANK0 and PORT counters to match the chip's statistics operations
and restore the filter used before the bitmap was introduced. Tested on
an EA4500, where the two-bridge forwarding and multicast snooping tests
now pass their hardware counter checks.

Fixes: 5595e3613ea7 ("dsa: mv88e6xxx: Move available stats into info structure")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 67daf3b9cb48..ebd9f69a7ed7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5960,7 +5960,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.age_time_coeff = 15000,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
-		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
+		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_PORT,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
 		.multi_chip = true,
-- 
2.53.0

