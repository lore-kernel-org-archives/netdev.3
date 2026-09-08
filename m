Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA113F104C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876271; cv=none; b=HwDkH3UG/toyOqmmspzgiXwtSvkA85Si8lM5pSTMpLQ0AH72SO08NTEQy85On7wHSvmLY1VwI28EAVkAy9NaQjwmXnxEQU2QoDppLoqvZRNS5d8E4lKeMbT8TwB8h9Hc/6YTtS7xXbqFMqvG/0+u2+/47F5aIYFoj/stsyLsSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876271; c=relaxed/simple;
	bh=T6U9OLyO1XxLOwAi7oui+xs/MXoNt7l8Uqjk+PGlDXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr6lZl2JcfCSqszTl0v0dDU781t893lMzsCuCBXCiDgoOwT78lHd2IQdQM5mTooFnYbctdncjF1OZkWxmkxa5jAB8zJjCTenvPKOVfCiBoX8vxXkyR+jGJLBzyt+DJu555o9n7NwOxKwPd1t3EjlNRZFsByI3w9Pqu8v4gFInAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=BndoaZ0d; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="BndoaZ0d"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 273213F633
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788876239;
	bh=oZW+3HacXHXxgA1Yfz0voc7XtCtL4kOFjCa7sts9YXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=BndoaZ0dIIEOpy0aV0bq2DWM5KhbG/oso5uX9szZEXHYObhnUh1zkIRx9XiGY96GS
	 yVUB2Ef6zBJGLUvbsZt256f8HqSJ7xpYR0mY78X5SxexeHxWZIgnrCbcdDxhPlnpqh
	 XPREQvTdxeg+dtdZfI8aFIKetZqREhi0DUkPX65BLCFm0zz0BBgkBTJ3edWM9tm7yH
	 dfMSG6VwiatZcJ9VXBfx/nz+gqetZHbmD5N50YREBSUPFSTVHUvp/YLG/ePCadKcqr
	 HK0VUshdoeD4FzwFdoaAzVyj5evYKe9z+iQIUSmVEpFhEPc+23Tzff1QcNdm0ppHLj
	 YQIDDBe7jNM8LKCQNwbRXd4w0EMjpt2F7NAOOFsG8sZtivuWkSnlC0NcfXKfKeoEbw
	 WZqZIX0/e8soRIYF0Q7WMJebQ0ACbvP8UD0Y9WEP1W/qaodXctNSiMHAmEt22bK88j
	 wnm6WZ08Mff5nsVq8ZNzdagrWbye7jZP/TpPI9ZMDQQ+zJMjD3GmWv/XRpmpbXF3F/
	 Ewvk05aNFtITYSD1s5hu1KV//cy7bRJ6d72jIPIJEmODUlOxlZKkb11YXXRPR4aY25
	 hAcFVrbMosbhdUNTuiG8LTSHU++siUQHc7g4wErfywa5f4L8HioL/5CmZzYwVWd/4T
	 PivGjQAHpRCeX5vmm/4gkFos=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c11f2b9f62fso314020866b.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788876239; x=1789481039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oZW+3HacXHXxgA1Yfz0voc7XtCtL4kOFjCa7sts9YXQ=;
        b=tO519eWsu7qeWo7MM0Hx7Vwui4zkiyBxCn7WzxVYINykIOg75giWRKS7PSa+2KnpAn
         HLfkw4PaURq/MTCyZhnu1SFhSgbjoBiS83wTIZAKhipWYMDW20fJw9MnCbmnwUTNMenS
         cvJnv++wo1uDzFlUVGWk8EMAawClrPhIvlpdKfoGy4nnAfLja+oinHBPkyikniZe5gaT
         n0FLGrp3n3ZoDT2z9LrZ/8qUp6Vn0//4x+X5oYf6Z3mhSiM6ampp5hbKN36u697C61qO
         ORHfJ6hactOlZ3vvPDcPOcFrUK9IhqXikixxLIKA9e2HtQG2B6nqDNkt+VNeKj+Woe9T
         AL/g==
X-Gm-Message-State: AFuF++muAzFTP7cPzaGrrojv4iDPO5neMtw+c3AtiCq9+W6UeLWlaw2K
	5r24xKO8Sv60HL8iMgRHmd/2J4TSJEkzVLVv5fdtTWXA6N5xPjYZFcckojGxqST6KiKuSagdWbb
	sRwbgJaIOE5N2RNYDT8M2xYfUD7Ykcekdv1ytPIIbl+Z+ISnO2mWgFrG4J8LVBjsdFkf+cJLCNQ
	==
X-Gm-Gg: AYBFou3YaVim+KmyLddE6FuJCYieahxeQ3wDVKAQk4h8YbUMWZlSo4tV9oCNoT5+aSc
	WUrUqsLA3nhJHX9sNtRv/cVO7o8RrJNWsNzYEFtwWPQCthwJ9Vk6xPizFkMNU0BYbldcUNYrRz6
	pVHv95butI5Advp1mfpBHTgsBYQQHGd0L8BXiW/2OrfQueoFGOAby48LaNzNZkpaLgDy7+lxgDl
	zUATZux9vBR97YANDnNSW7ET8sT8nGv9jf1TTHnGmlV2IgQh7TguskqzH5QA5IncW+qXQ9yukaW
	daAyGw7eLKVTjsKrlcKU7Xr6S7olKLljxzBiuQNBYr/tXEUFIf+sUbwaABjLIRQkSJ25RGfbeDD
	kVhhptyw18oN2fz0OHmuY8z/nbPmypNADYqyCovQJFEyzXCTbbr4NjZD+a0iGXFHvcQ==
X-Received: by 2002:a17:907:d23:b0:c26:19de:9ae6 with SMTP id a640c23a62f3a-c2619dea7c4mr931872266b.37.1788876238278;
        Tue, 08 Sep 2026 07:03:58 -0700 (PDT)
X-Received: by 2002:a17:907:d23:b0:c26:19de:9ae6 with SMTP id a640c23a62f3a-c2619dea7c4mr931869866b.37.1788876237770;
        Tue, 08 Sep 2026 07:03:57 -0700 (PDT)
Received: from localhost ([154.62.191.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d03644bsm631394566b.6.2026.09.08.07.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:03:56 -0700 (PDT)
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andrei Gherzan <andrei.gherzan@canonical.com>
Subject: [PATCH net 2/2] selftests: rtnetlink: update ipsec_offload expected output
Date: Tue,  8 Sep 2026 15:03:25 +0100
Message-ID: <20260908140325.13367-3-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908140325.13367-1-andrei.gherzan@canonical.com>
References: <20260908140325.13367-1-andrei.gherzan@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch ("netdevsim: print IPsec salt/key in network byte
order") makes the netdevsim IPsec debugfs file print salt/key in
network byte order on every host, instead of host CPU byte order.

Update the expected output of kci_test_ipsec_offload() to match: the
values change from the little-endian-only representation to the new,
endianness-independent one. No other changes are needed since the
output is now the same on every architecture.

This depends on the previous driver patch: applied on its own, this
change would regress the test on little-endian hosts (which still
print the old host-order value), though it happens to have no effect
on big-endian hosts (whose old host-order output already matched).

Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
Reported-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Link: https://lore.kernel.org/netdev/20220308135106.890270-1-kleber.souza@canonical.com/
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index ace3a99023ed0..4843d474538f4 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -932,11 +932,11 @@ kci_test_ipsec_offload()
 	run_cmd diff $sysfsf - << EOF
 SA count=2 tx=3
 sa[0] tx ipaddr=$dstip
-sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
-sa[0]    key=0x34333231 38373635 32313039 36353433
+sa[0]    spi=0x00000009 proto=0x32 salt=0x64636261 crypt=1
+sa[0]    key=0x31323334 35363738 39303132 33343536
 sa[1] rx ipaddr=$srcip
-sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
-sa[1]    key=0x34333231 38373635 32313039 36353433
+sa[1]    spi=0x00000009 proto=0x32 salt=0x64636261 crypt=1
+sa[1]    key=0x31323334 35363738 39303132 33343536
 EOF
 	if [ $? -ne 0 ] ; then
 		end_test "FAIL: ipsec_offload incorrect driver data"
-- 
2.43.0

