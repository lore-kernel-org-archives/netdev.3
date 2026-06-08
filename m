Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE23B27D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924310; cv=none; b=nL8Tj3k+XmN/8mjplnrCro2dtkceStbyPuBEiJ8rRPqm94Fkoj9s65tXSmuSQHn3nvXOzit2XcMS3Vnu3dkv4GvMr7A8RsezW0do/kjECZEWUL5TTlJWo9ut3P6YEgECCef3oGCrdfb1vJIm34ukZzTlSYeWFqd6cJXAewZy/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924310; c=relaxed/simple;
	bh=zahU5t1RhrDqy2kwYlZ9w9xNNdoco/26I0R7MMpsG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK9KjJSGUJReCDQ39lq+w6GRUQ1HCkQGBDHQBkbnkgrcAbrXm/2gZnugqJpvLryzW2dFRG25CTrbDMj/x8zkxRyH1ur5W0/jruH/WMHFfj5ftw/fX1Vd3msrrsxLoWD47IFug4TkHYo+anqlk6xW2rTBygXen7ZICWlc6bMR9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0iPmvLE; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0iPmvLE"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef74860bfso263632f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924307; x=1781529107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOgO2fIH4gzuJPh6xZ0IuyezXpRFOhq8G4N3LT7JL+A=;
        b=h0iPmvLE3hVyv2iSWk9tfue3qL4AZab0neAmDMz4qh+cAK5OLienWlsiXJn0xcty/U
         c2Q0Ssdi4BNFK1b5M1DkkshVRTdLhHGB8jfHAxlnuvH/GnHXXpKIISG+CJqQ6NwZJR0e
         s/cqVWrv5dA4VdHfpzFF0IFVa6UQ/COskYs5eKeOgkyo/ZbBsNlrXFkUXQWBTjvGKJw3
         4pJ9KaH6QpwA1Fe9amNPH4i/HnIUgyr2yZYMZwnawSv1TOF5Gzix2mx7ZqtOLgyZDK+L
         OLlDGuQplbVCle8Ln3ys3YLIynKXNUU7zRJa1itdLvSheTgVV23ToPiSXTs4PHQd72hv
         JtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924307; x=1781529107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOgO2fIH4gzuJPh6xZ0IuyezXpRFOhq8G4N3LT7JL+A=;
        b=C1JeopTQTGLeaSFt/B37YD3TDHDuc3/DFCGp57rpWesI38a5fXSsFOsi9UCSg+fvM5
         OJTKyP6SsF4Wmw6d+HboYuxxE++6vwrXUJjy7TGSaPp0bYNTAjUWNmRYrmTQ7QzdrbF5
         F34RcvzNdS053c5O97VNS8x1n+pIWsM0YdvH4d2WzfoQKME78nuhbE6Z83BOhk4hE1tZ
         OKCdx/H5RdazD82k1vMs8yH/dAxM8Yl3fZn12/cFRnbt2bhEsUfiZ5ctFla0iBB8LXt3
         9mqHuXQRJEXEA1s5pnTdXV7Y8Wi+RwKdznMLCf2LbGkwPJ4nWLxDqVpPMPd9DOViRWDS
         xW7A==
X-Gm-Message-State: AOJu0YwIegUNtu1Q6LuZouhdaqPLAt5nMRiIVOo0ZpZcpzL+y3+zgvzA
	xhNPQLhU2+NcQb/almMTm0JyuqSTTpq3A5kFGqY3ECmXJd5o70a2uwRPGMULgB8G
X-Gm-Gg: Acq92OEoufDowLTbEZ5adBsYSfZZKEE3qgAhRInwnQWGtqrP/tH9z2GkZa3dtu545Xu
	zFWzUYze5THuKdlI+4dmuy81iXdQz2lPFkjaNf+ANwRgvFP3opIUHUcm3R1kaVEpqsGKu87WAt6
	/TLMHXj2t6k3/RezZirYMhcBQA3g1PTgNOwbUwG8gJf64+9Vj/LqmKzz833ZIr64gWctp33eV9G
	nyprRjqSFydgVef3YEhc0PWPMRB9SdpN7j1UxnOzS97ASQ/WLaxeVV6NGVgEJNaGyqHFFK4KiKg
	Stdf0zKGjoB6s+Ej9rYzkoAgZ2RfbcjrT0gO5ONlt/ri2CO8FSVxmp3OYrNjPnPAkrbX2PqgoKQ
	MmgQt1ocgNGgGyxaylVcQ3BdVw/NGW3tt1MiitfACXgLmvR/4K7UctjnniSdbUJssj6NGGf1iuP
	oi1LFnRYT5jbpmbjkaLtvCCBo8i0O68/0UNTqaLNskWg==
X-Received: by 2002:a05:600c:314e:b0:490:bc36:9b2b with SMTP id 5b1f17b1804b1-490c258a138mr97307755e9.2.1780924307123;
        Mon, 08 Jun 2026 06:11:47 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:46 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 10/10] selftests/net: add jumbogram test case to msg_zerocopy.sh
Date: Mon,  8 Jun 2026 15:07:55 +0200
Message-ID: <20260608130755.5626-11-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a test case to msg_zerocopy.sh that tests whether zerocopy
works with TCP jumbograms.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 3 ++-
 tools/testing/selftests/net/msg_zerocopy.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 1d5d3c4e7e87..b5df360c7811 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -789,7 +789,8 @@ static void parse_opts(int argc, char **argv)
 	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
 	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
 
-	if (cfg_payload_len > max_payload_len)
+	if (cfg_payload_len > max_payload_len &&
+	    (strcmp(cfg_test, "tcp") != 0 || cfg_family != PF_INET6))
 		error(1, 0, "-s: payload exceeds max (%d)", max_payload_len);
 	if (cfg_cork_mixed && (!cfg_zerocopy || !cfg_cork))
 		error(1, 0, "-m: cork_mixed requires corking and zerocopy");
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 28178a38a4e7..ab498c6ea210 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -7,7 +7,7 @@ set -e
 
 readonly DEV="veth0"
 readonly DUMMY_DEV="dummy0"
-readonly DEV_MTU=65535
+readonly DEV_MTU=200000
 readonly BIN="./msg_zerocopy"
 
 readonly RAND="$(mktemp -u XXXXXX)"
@@ -29,6 +29,7 @@ if [[ "$#" -eq "0" ]]; then
 
 	$0 4 tcp -t 1 || ret=1
 	$0 6 tcp -t 1 || ret=1
+	$0 6 tcp -t 1 -s 100000 || ret=1
 	$0 4 udp -t 1 || ret=1
 	$0 6 udp -t 1 || ret=1
 
-- 
2.47.3

