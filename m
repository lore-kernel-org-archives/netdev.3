Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FF3C37A3
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264474; cv=none; b=qcj9FVoxH2TRbn+DgO3x11ljH71HBpztrtxl6TN02lvEMAQ6nN49VDBr63TwZkX6DHofmGO5aO2kdp6C5b/dloL4r9fKdfhtk+mMZS4cwyPi1fkeXtR2iSE1hGdvUstV7ubOlKU6DFjhQ7bRkRJCl1Q0dST4CdBmk7hCLLlPvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264474; c=relaxed/simple;
	bh=eHCQJU9epidDiqSw6rychh/RrwvWwagWP4T3b2XA2T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCdwfwC9t7neVt+oZHtdNIvIL90M09m5u4N7CpMmai6S/Hf0VqaMSckjbqiqoTVg6GU1ry/W7Krw9eXl41Zu3d21K2TL3T1F/s1tEvW2C0vLJou40KIcPYOdlVLgRTNx2z4UGLi1+5aSgqy8lkCDSWDu64bxYktRl3JS6XbTppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BqagkDS4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BqagkDS4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1245992a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264471; x=1788869271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9fGukl2hxJruJMoMsmWQ5mpAQOKInaHi7HfgMgK36w=;
        b=BqagkDS4YtwRjNDrsmcWrOBdSFQcB400MsYMzLUef0Zpi4uK0+RYGaIIlGJiithlOS
         iHqONv+kU0ZydP5nzkfSzUsQCAl8P8fgmQNOoPofA7urdsgxBH+3cgw/akaMjLVyKoZx
         85PtPQuEV3/+Wg2WHkeHDsFh1Uxh6uT8d/eUM4y481vcvwcNQmCSVZut7dEFTr2pmqpv
         //jewxsXgdYAf5CwT71xZ0dTulRZR1QYxr4YVMopxaDsxxvYIzsYRtYVwxUHu90OxnZJ
         TcfjDlAe+CkXvWBa0lyNIu7y5QePmwm8v8do9TGCFtF1+dAXGldJjodVvabIZBxqQZks
         8EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264471; x=1788869271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9fGukl2hxJruJMoMsmWQ5mpAQOKInaHi7HfgMgK36w=;
        b=rt+k0n2J4b6jCWP50p2khecZnBDGWcTdWQGm8W+jiIXTpkF6v52WuL5ykh3dwgvVK3
         0DgDdDV1n8Gw+eHSO7jsPS200FFArr/rjBpljgDmn5Dqvuwr2haQHl2JazZcIxxd2Jx8
         IefgU2T858TGWKPuboirUOuvsEiCYlF3W9kSc1V8cQwqGlH2utFbEWIA8fYW+lSClxZI
         R88Wm+pV7xOYv3UkSPlMLERGGxwPfKADTxrxsPc2pqF13M0q4NPGgNi+diZoKex6wIUA
         oWpJXDqwxYJiE0NcctcemsU8fjkP7WX5R/Hyhj/zBXMV651sH3QavkrrY/zyz7AiKssn
         B4bw==
X-Gm-Message-State: AFuF++llHaRQ7wMgtq5xIgVp+xIsA2kza4aCG1k9Av1xxb9hGNK6pXZ2
	fLnFze4XDnIQBsN9cEDGLWW1e1zmXmop2CF2LrvdXTo7jgi0p+1kQ1My3OrawAu+fWnFzvA51VV
	N2ghLbjomIA==
X-Gm-Gg: AYBFou1kvRkHZddxvFvXjVnbFizgk52CedoefJuznaeZqo5D/S4D7WUZiGAf/gYvISM
	uCXrEr2yptYhJAXLYWiu04JSoJYCEaN2qri1NbmSKXbCPqZEyqarLuIgR2yIABS1g3z5Exrg1di
	reJS74v8DQGjPEjv7J1MVQTucBNBDGtVFUXAhwRHJlG/63vPqOoPzBEXNaNyLIvezAIkfu1qmVt
	YipsxuNxxH/VZLWUrPXBAG+i6/xnpH5VEMXSl88yb2eMBFYdj7Y42X9VGX1b2eewlPc2Ao08FMk
	Hqgyn5EGd8yRs2ACppeNAWYWVr3ChK7p0tEiCMheMEmYvL/cZ+d5f0h++KW1TbbQmhoT+av95Li
	Ofam5FJESE+FjiTPRN8LgbuCVepCWMRJSEH69hRELH0vX6Wpvbh7oMnjHyhBoVWybRvoQfwi9XR
	3bM5DrptNhuy0LSYSYn53+WumHexNRBzZAYaRm8gD9DqRTifkK8MUQzEd5Hfox4nBqkKB6098Cr
	3RrZX9nLqsT7mAQZV5/dw==
X-Received: by 2002:a05:6402:a0cb:b0:6a6:32f5:5570 with SMTP id 4fb4d7f45d1cf-6a632f556bamr12242853a12.18.1788264471422;
        Tue, 01 Sep 2026 05:07:51 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d37ce3sm4518398f8f.8.2026.09.01.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:50 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 9/9] net: bridge: vlan: use br_vlan_get_state to get vlan state
Date: Tue,  1 Sep 2026 15:07:21 +0300
Message-ID: <20260901120721.747908-10-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MST code can change the vlan state with only rcu, so use the helper
to get the state properly.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 95187a607ec2..72b75757ac85 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	br_vlan_set_pvid_state(vg, v->state);
+	br_vlan_set_pvid_state(vg, br_vlan_get_state(v));
 	WRITE_ONCE(vg->pvid, v->vid);
 }
 
-- 
2.47.3

