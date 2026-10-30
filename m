Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381719;
	b=2knGUNj332qfg7Y9fzN+ID6RNrNQl5qih2RR5ZYP9Zt6JZc95X6b8eAqjmI5Y1Aqkd9g
	 LsyXGkcCIuYT4HrLFewrI6yZexehWVi8P2WQKocrogUQb6mku0jJh4+bQNp6bIpVdA8MB
	 gzhdM63RKdy+ApCmot6cWsXGlgxKu2pG8s58ra9jHYVKjmA76dLYhjZRE3ASbK517N9gt
	 oP4F0GMvLli2g9QmEWz0GUm8Yr5KaaakzJrmeshp4Nn7hcViPAtgz/l7McuDAx+iOjS65
	 NhMDYokOvVNqUwQIMqaCZn0m2/46WmFqgs7VHMb022LrrFF4vHeklapBKjAJg9B5A/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=l/eeNfSRBxI7r1cZpHBU1gvii6TqZFB2r4ECPtzWEQw=;
	b=ta0EJUqSEWvGZ+c8zIY3VGgcSc4SKUj57QHG9J/b+VKYNsjNqSoZ7JQM0C3h/lR4ZKmQ
	 c/2G0Ukujj7Qu2jvXK6jUSeOx41oZykSiIGeYYNdIEiu5KTD1XQNi1ADNxmfZC1qDIYi/
	 FDcp0+7ZEl/l+lltDQY32khjZ8o21E8XJqkL0FmlEGaAMGaUy8XsS8slkWvRdLnCuYmaC
	 p//rlu3rH3zrumKPBUympTqu7IfG8atjERUnlm/u2rY5gB6u4bIzNwarQhVS6G67alUtK
	 0mDsN6iXc8G/qe4bYay/0Xyv30quiZttKfisEtqDvFpsjoO5Gl5pNw9bO4Uirn+wjEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jT13e42U;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C89606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jT13e42U
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6768403e9bbso922865d50.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793381718; x=1793986518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/eeNfSRBxI7r1cZpHBU1gvii6TqZFB2r4ECPtzWEQw=;
        b=jT13e42U4OFwVIhji0zXSJ4pfE3/a4dWKQOAKqkeIeQgijbHtJLL9YQwY9I6jRj3ud
         YiWf8veDgJJDdnzdLyaSOfPGptrhvLg6XSYzOoyl1HHX8CR9D9acKDe99ugeiK2ei2ZX
         zqqjweCm2NWIvjXKKOIEQO9pY4odBHSthTesmfgi4NVTzpsN13Qy7UG3CLpjbNWIEZ+s
         /TOtZWBeVdIi8qY/2Bgjxizys5OpX6sz70Im/fzSnJt98HxzhzF3ptnbE5Ur/qh8rxVg
         zxAbF86/VesZNCQ8yM8X/wWiOYrS/Jv+mPCwEkViDKyvCoBmFJGNTO7f1oMLrc7dc+sy
         em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381718; x=1793986518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/eeNfSRBxI7r1cZpHBU1gvii6TqZFB2r4ECPtzWEQw=;
        b=kj6AGeZoImWyfuxyGQssYe52KeaIy9tqwgYp4/k02k82zxMgPxqkpPHuZwZligJ4tA
         faTB2jT9xdDsq7gJR27vMj592sPJD2zWmaaYOHT41biMtwjek7qHTDDqRkEK4Ywveobx
         NMi9dF3dyKGzwPz1uxv5iU8TRsVKlhlEcUYxHxJahqU4JwiduqLeeskimfFA3kfi2f72
         iJSxaAwW7UPFy3YbA3CKwsegzYwPblUYXlvaHZBt2SrXI8ODmXJPSUQep6MBqs1PUzvP
         Af8W9beRwlBobVNwCiSBVlN+Gzf8Aj5kaSF6FOpEvBAXEsiAgSc+wMDrTWuDwwUYXjC0
         F97w==
X-Gm-Message-State: AFq9FYI0/3sHl7Hyt+lkct40aMSQpzVwoA+KMPT3rdjP/JZHp8LkHnv+
	uAjyeIFR4Q/ZQ83RvCWdNQCvQv5sdM7/WNujG5FEpvfK9o09lcBaUawTNw5WzeYk
X-Gm-Gg: AYBFou1BWM5YrhKuh+OwXjlIhgqPOE9Y6aglzH4XCBSYypu4R2TSSnYKFgxuTOrGiRv
	BcOVqWanKK4xTENo3vfZC6PhO9/AScLlXgPhk/R/onpuj/vg62h3ETKcxf79vXY9i3LPDSJXT99
	XkW482wh/Po1wWA/8/OZO0zR7iw/6OUGPnsLZzv29ZXgYaev0tIses5LsZJ0ZtipwOirV96DM3R
	OMmgggGfvHJKtZqtBkqtsU6w1EUgHmeWCv6+KtwYhhpsyiJb6ITR043AxdFFFpBvAEEwQHYyS1H
	58ySIVjCcKlj1ILpqLVbsGvTCTRnUCZwvbQrLCawSqltObJI73zW8CI9ey4FwXKAtT2d4tGAfQU
	2cPuWLKLWOuJcmOfDbHGen7RCis8vKNpH+fgOR/96uBYDDunvvuCgsSjMRpJkRbsMpHpakAGnLX
	fi8Dzrw/b47LeVKZZGCeo0rISckwRtXxsOuKKtHtk9Mx9e+cTZXp5tRQFZZ0RfxA0y3kKO5dd2o
	GnaLn8WERwipk5rNjaaOH9CgNHa+MHpbMY6lYE/8wbW7cSI7cXIVqg9qUoC77azOtt5fgQFCNaq
	d5NfYfghf1aQvBQ2MY5rcrpM/a4=
X-Received: by 2002:a05:690e:1915:b0:677:aee1:9f16 with SMTP id 956f58d0204a3-67ba4edd4fbmr2440015d50.34.1793381718129;
        Fri, 30 Oct 2026 10:35:18 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:31::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf2aa655sm393389d50.10.2026.10.30.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:35:17 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com
Subject: [PATCH net] selftests: drv-net: pause: Skip support tests without link autonegotiation
Date: Fri, 30 Oct 2026 10:35:16 -0700
Message-ID: <20261030173516.1002250-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Mohsin Bashir <hmohsin@meta.com>

Devices without link autonegotiation support may reject both link-setting
requests in pause_test_support(). On fbnic, all four variants then fail
in cleanup when the deferred restore of unchanged link settings returns
EOPNOTSUPP. Removing the restore alone would report PASS without running
any pause checks.

Fix this by calling require_link_autoneg() before pause_setup() to skip
the test when either interface lacks link autonegotiation support. This
also skips devices that support only forced link configuration.

The issue was observed in the fbnic CI/CD pipeline. It was reproduced and
the fix was tested on a local fbnic device.

Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/pause.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index ca4a55e59c30..1537f88e0e77 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -466,6 +466,7 @@ def pause_test_support(cfg, pauseparams):
     supported fields.
     """
 
+    require_link_autoneg(cfg)
     pause_setup(cfg)
 
     forced = forced_link_settings(cfg)
-- 
2.53.0-Meta

