Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D844781C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364321; cv=none; b=i3vR1kROcKTo85w1aN45rFeu/LMfBPgF27iDe6gyMC7G9CEOxLNIRHA/+o7VKDmxPFdAmdU1RQhwcHMKy/IDcujFfIa5bgEFjkfHb+LLm2oFacV1HrkLE0ZGpmmZ55E4qYGUNm1UtxG4rRQwRsMEyY49+glLWXsqj6pC3YBPUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364321; c=relaxed/simple;
	bh=j5Njce1R2CzMDzpSrCt4D4C2yKngQ2KuqhBpl1pHhmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADug/Xs6s+7kkVgjkmvmaUYXc5juOr2LzolZZbaEG8W+ZfL5XUi+QLs88meHyGgxeKfhOi6m5J7A6JsDLsltlBBf+fDmUoMDSaqgRpJsYCvRVhtGLF8nIn+v8jx6zxVVXqoDrQcNcYjnX6kVhxxSZr6FCpiI0V8XY1xrj5XW8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZEVauiQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZEVauiQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so792005f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364317; x=1790969117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G9E+sqsbctWeMKlnS+UkV61JpHdXQmDR0/Cg9hJ8tHo=;
        b=CZEVauiQEUUSshI568NztLVATBws7TXi2Zw2Ovcz0GRj7cZIcOjkTw/jvIL0WGzWWj
         xXqQ562xEWyLL9IB/V/wskVU3ZTAt40Ct/mbKk8IDciQB5KgRsspOo7hDmuyifpfzlMM
         82SDqR+l/ZiUn0JtjFPjUBD9STlJQ9/04jpghtw5DVJ4r+meCYtstNRrelvNPluixHx2
         O7WFyvaYq058kl33hPQ6czuFj7cnF3KmnEP/JpAqB9ialZPL0BMCXtYNPGv0JVYudldn
         iGZxbUC/9kVbn+FcWS8Hun+DgiNDV7e7J9tuPjptgKynbzmfTBIeBskqMQ3YKWID4sjA
         kzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364317; x=1790969117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G9E+sqsbctWeMKlnS+UkV61JpHdXQmDR0/Cg9hJ8tHo=;
        b=CEkHibwz72NL682eD1ibdnCuDiewO0emvllLejKuIAlWwzs6gQJjYZkOg3nvKNkA/D
         u46E8bH2dconWF88/jL+wbas2+aOEv3MMafXcr4ODI2tphuygYL8hRT9LDN3J2TyJrNZ
         KLPwkKRzkbhAnouCj5hs8u3StdLDf0/RRNungFFCsKogHb8M9Th0z64J8GS2Q8J1VhRn
         kuKr3w389UROE/yyvSDo2SdboGFPM/axkS8CBKrGKjg7a8sqYKvE9e0nfXgJffvDVBV/
         8AHULTwnEjllA9+fg99sVdonb+s7QRh7Eg6zdPzvBwkUcUM4BG3a5KI9RyC5okqqn0sX
         tcOQ==
X-Forwarded-Encrypted: i=1; AKwUvByxYQzI2RD0o00+83HPVk9K2UB7UxUVcSTfBEFGCEbtXTvQkckTP7IBZGzdKwsm+uC8QfmXn1k=@vger.kernel.org
X-Gm-Message-State: AFuF++lS6sj6Js/FRHTeDNvGi5wsTT2MDoptueY2pVEBWzSR2vHkpF9O
	/qFMLwEQRrUCawVtudFLG88pz1wrMLHkXDECF7hKBesw4iT3nTWIh9ms
X-Gm-Gg: AYBFou2LaHtqEneVWAZeIPYgOZ7ERt3iym1G857dTptzp59+Jo3Xp5K60iFASUUKDnz
	v+mf7tmaQ69RroC3BXBLSoKHIboxbwykirULJdDjb11Dw9KLBbx1PQh+A6qOzXhXBt+m3yDc9N3
	1cQPJ39pZj0ysg8GHxn51dPZDznCLg9QJxL4qQxiIWN5onCDTNsZbhciJdpMMZ8kSTr5UZ9OkFG
	K8KUVSMn+dNBIhnq3nfHfMqMBXW+LvcIFnwhdWaIpFzzU3JzBkXc4EdWQ2rBU4E3v4E1DCXqCnr
	rnZG7L1ckV086hFYw+gJ7u9nhaemzqXf+nX0galJLWuVkTAYqVTCho1jYSt1y7clzE1eTm52Ye3
	lug60T+3KSTpPrwp4PIbxabmHu8mZ0uiEbZj7wqcHt51StBb/8PcTiD3zV9N3BcrIGOYg1/C+Tx
	F9VLu3q+qymjejwqW+aQk6ixKwGr5PE6jcGQd6OGQQt659EaWRBLoo+QxSQ7XyAt5ldRsv0ujdh
	IByfMuTBsC8ziPmWPiBsvb8QwJyPADYv680fUNqohNXB2kAA+/i3AgXBHG+3iLpDjwTnpx6Bhqk
	Zj5J3Nd4hURVX1qkZ3TXsCItAlGW8bnYYUCo4csuLFPu21dE/OVVDyE0jiH7mfG10npPX23Cf1k
	o7Q6tq3o=
X-Received: by 2002:a05:6000:26d1:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-4887d9fa635mr5543814f8f.12.1790364316713;
        Fri, 25 Sep 2026 12:25:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adc6-9c01-89ae-b145-8960-cf19.310.pool.telefonica.de. [2a02:3100:adc6:9c01:89ae:b145:8960:cf19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35fb05sm10205982f8f.20.2026.09.25.12.25.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 12:25:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mctp: Stop selecting flow support for KUnit tests
Date: Fri, 25 Sep 2026 21:25:10 +0200
Message-Id: <20260925192510.93840-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MCTP_TEST selects MCTP_FLOWS, which also enables SKB_EXTENSIONS when no
transport requires them. Remove the selection to follow the dependency
rule in Documentation/dev-tools/kunit/style.rst.

The two flow-specific tests already skip when MCTP_FLOWS is disabled.
The remaining tests can run in either configuration.

Fixes: 109a5331143d ("net: mctp: tests: Test that outgoing skbs have flow data populated")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Validation on net-next 42a9fb3382fc: x86_64 LLVM builds and QEMU runs
with MCTP_FLOWS disabled and enabled. Both suites pass. With flow support
disabled, only the two flow-specific cases skip. The enabled configuration
uses the I2C transport to select MCTP_FLOWS.

 net/mctp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mctp/Kconfig b/net/mctp/Kconfig
index d8d3413a37f7..3a5c0e70da77 100644
--- a/net/mctp/Kconfig
+++ b/net/mctp/Kconfig
@@ -14,7 +14,6 @@ menuconfig MCTP
 
 config MCTP_TEST
         bool "MCTP core tests" if !KUNIT_ALL_TESTS
-        select MCTP_FLOWS
         depends on MCTP=y && KUNIT=y
         default KUNIT_ALL_TESTS
 

base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
