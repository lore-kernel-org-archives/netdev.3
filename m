Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BC37F8CD
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665622; cv=none; b=m5kQvCNGQv/LNhtaO2lbrBN6kUe6jdtRcudSAOPxiYtgat41xIq20XzmJKsE7bkzwiXudCIZqJxTb/x760Tw7QFg2oYT0L3hp3huwhagoG2iWZSXg2tl7FxV5mpnpWPmx6im1+kUFLG19yrJRCgMZTnnWt2Ml6pD7xX8fcOHZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665622; c=relaxed/simple;
	bh=b1elnpjfkBu0JtZAehyeYhD042b+cAawq85lNBLyT3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxUof3HBQYcbltjcDmliaUCmeBMuQMeH9wuldY0Dm0HSffRyw5jlecJOReCZGPAlR7cwXIg6tOoYLA/v4Px9MHTZD9lgzRjQtBgFTTLg4jjZbPD6w/PMg+IM3ezcCgqiKJ9oQ2jBNAikhLWK49pgnSb6urswcRutuQlyRNG7lkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TZ0KtWAO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TZ0KtWAO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837584120eso55572385e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665619; x=1773270419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t44rK9xj38qm5oEm33J69u0Wi1Wb9BeJbAg95YLqBNo=;
        b=TZ0KtWAOKH3JRvmgaYhg2VA7d6viZ+iycsKIgseKOoY36ZW/6zLNsyLBRW/6Ge92P9
         vmeC59gom+aSJ0VB4/OzFcEvrDQ8BdvZ3hlDQrdgnZ+5IxPU9hcGeF1K6p5wESt5tfLa
         Bwj9D/Z2Qmm2EdhVEY33nU8jlTsVbskMouOlEdLXqrqTJCWaUTOCvf6tGbvpRPFREImP
         eSqmJBAHmLWW5Ss9LsijQ3hvLIBSCWq1zaaJlP9JGxI5Tqbo9XsVXcKPZR/4KGlLfaE0
         Btlos0BOHmLQ9eYENvoRnDGUn2IUGoU8mWoRCLRcRoUc2rnd4QPbq5/NgjLxECCZ7I2p
         mU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665619; x=1773270419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t44rK9xj38qm5oEm33J69u0Wi1Wb9BeJbAg95YLqBNo=;
        b=aUnTg5seoX4XkgpT7TTSXaFGoof/aG7xT8BxaU8L65DmFLMvKPKKewgixHAshZSKgR
         m7OIU9K+PodI9RxMNomTl8Vtq6QnvEkKItRRGopEU92I5blOTMfRxdVY6ldFGhC4WoLj
         j14IW0MJ8n6sgTZfvs2YQUtZKTvdDIUxdVaNa2bZRdT8I1epsO0GVUibOgQADCbqya2V
         a280O/yWpnQaO5BOw8z7mSaocZRhhU+6w55LpTdFFx2KsI+OJP2iH6lb2h+Kn0pa4QEZ
         iPIyZcwwUQCHYvr/iemSXyxnsIjQmZWdSkt1+m7tpS5mR/ckRv4n3jtU8wE8fpBdFyPR
         qHyQ==
X-Gm-Message-State: AOJu0Yxf8akebIVh0kRVlhrtvRXrmJyt/qTyGqB8hbg33mnnMInNvNB0
	D9eEQZ5fUke4pRps3DyatOIlU3k3VHkXf4mq6D2Pz8VNkPGu7/b9OHIf76HO+L4mPXYk9IGUcHH
	wHcHwfIrAYNhS8MIlNzuoEg0TYqLe/DmUvsgTfacnPZqwC9EwTU+f0OAAIhRzpZgp
X-Gm-Gg: ATEYQzzDssQWgYfndf0QEtRlyeijjxEWBlOBMJDV3zWcXg8++XhUmDUstF4IoqfBmM6
	3SEHIyLv1V/AoAcaoRdmRJTmEueaJiWxvHo+SZzuXI72sGIht8kc3KQoUcEeY8MD/u8vibrPylX
	gB1pNQ1lF4Fx7fg+Bprsq7jvEuePH90+nhYq9iyE0xYrBAOlpItMoETpbS4zBhsOdiNuUAxxpy6
	katF1zyZeTMMxy79mFiqeQDwgpAb9FVw9TjuIhol4yIiD9JW1QTaiGDnhv+JkBkscNY0nm2VQao
	GI2vtHrzf3p+0yrHxmghUkSXrvQgy143iO3TOkb0IE9/QUQZFZ9AuRXrcuC+YsJaPG4C83QJG3n
	NgusWFBChpQkksz1UzqUm/X7wMLG3UHcP1qpUIdc+BGumks21Ht1lLthMvbZuRfCLtba+yuQ+WX
	yskqEtsVvbi2dABT5e+0IxXSMpVV/e/RV3A44=
X-Received: by 2002:a05:600c:35d4:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-48519826fb8mr57114595e9.6.1772665618750;
        Wed, 04 Mar 2026 15:06:58 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:06:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 1/9] selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3
Date: Thu,  5 Mar 2026 00:06:19 +0100
Message-ID: <20260304230643.1014-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304230643.1014-1-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbedtls 3 installs headers and calls the shared object
differently than version 2, therefore we must now rely
on pkgconfig to fill the right C/LDFLAGS.

Moreover the mbedtls3 library expects any base64 file to
have their content on one line.
Since this change does no break older versions,
let's change the sample key file format and make mbedtls3
happy.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile   | 14 ++++++++++----
 tools/testing/selftests/net/ovpn/data64.key |  6 +-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index dbe0388c8512..d3a070db0bb5 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -2,19 +2,25 @@
 # Copyright (C) 2020-2025 OpenVPN, Inc.
 #
 CFLAGS = -pedantic -Wextra -Wall -Wl,--no-as-needed -g -O0 -ggdb $(KHDR_INCLUDES)
+CFLAGS += $(shell pkg-config --cflags mbedcrypto-3 mbedtls-3 2>/dev/null)
+
 VAR_CFLAGS = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_CFLAGS),)
 VAR_CFLAGS = -I/usr/include/libnl3
 endif
 CFLAGS += $(VAR_CFLAGS)
 
+MTLS_LDLIBS= $(shell pkg-config --libs mbedcrypto-3 mbedtls-3 2>/dev/null)
+ifeq ($(MTLS_LDLIBS),)
+MTLS_LDLIBS = -lmbedtls -lmbedcrypto
+endif
+LDLIBS += $(MTLS_LDLIBS)
 
-LDLIBS = -lmbedtls -lmbedcrypto
-VAR_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
+NL_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_LDLIBS),)
-VAR_LDLIBS = -lnl-genl-3 -lnl-3
+NL_LDLIBS = -lnl-genl-3 -lnl-3
 endif
-LDLIBS += $(VAR_LDLIBS)
+LDLIBS += $(NL_LDLIBS)
 
 
 TEST_FILES = common.sh
diff --git a/tools/testing/selftests/net/ovpn/data64.key b/tools/testing/selftests/net/ovpn/data64.key
index a99e88c4e290..d04febcdf5a2 100644
--- a/tools/testing/selftests/net/ovpn/data64.key
+++ b/tools/testing/selftests/net/ovpn/data64.key
@@ -1,5 +1 @@
-jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3B
-ia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9
-uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6
-KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tE
-BofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
+jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3Bia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tEBofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
-- 
2.52.0

