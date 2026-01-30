Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A132EC560
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788979; cv=none; b=eK2gSodBZ6AZoWbx12Xr0Ke1KiVvdqbX/J3PemFqWPDwVYudfNpDh4F9goriH9/ig85bfuUXykgv2jBWurLGCSw18judNiJJjKnydNfN9bTcTaNLSRgxWDi1bpCNf+9SoG0+mrVAIA8GD3IiD2DpIPzm/aIFbi5jwfZYPi9xlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788979; c=relaxed/simple;
	bh=BAs1OTiQeuPVX5JMLphFlZmhaIt9zRkDGZ6Ky3+38uQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IaKSuBrkI7wUZlfGLXc4wRGMwyypevbKuRSqo7K+Saj1CW9h159caIC/SlMArruUIKOmHKPLom3s+VI8GyKILzcWwG7CEFBRabr7ec3UAnorvOxJzSF9P4Rd9vIHL1nRGdAfPmzBw+rCtXPXC5GQnPEi0T2vzUZ/FMMAQ+lkepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syUb1gaf; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syUb1gaf"
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6465127b47dso3287218d50.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769788977; x=1770393777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vd38hxDLoNF+6BqRPjQKduGy4cqeZjx3I/eAgDQhGBs=;
        b=syUb1gafVDFF3YkWesOSicUZZ9R+BCtd+uZYDhQbU4a6m2KTmCTxoYKtP/W9Ra9LAT
         b/e+pHsVjzrdb75h/4QnZmn8+c1g8GUMTUniUjDgmJE8C+mQCE3Rbw9mMK9IhXdRMuIz
         RZBfxvjpsD9xQXsREUf/7yJXLllq54v4tRHt+9bfa3mkxGLulIKt0wiFaMQ3Il0OXDdS
         3ZrS37AabdKIPcINPF9GxPCmlrte4PFPrZmHKW1+yKGvhyMQIt14vBhs5qAlprShtX+c
         7dpqLYTqn4YopJEbhJaJilLVBWpHxULodfZmzMyHxNQIqFwted6Odz7oSkmbmkALMpTz
         bveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788977; x=1770393777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vd38hxDLoNF+6BqRPjQKduGy4cqeZjx3I/eAgDQhGBs=;
        b=HEZF1Z00iD6kD8y85bko0b9QmYeIpEdyC9FwsyVSn827yERdjy4edv21nT6GXWY/8P
         RovksjRK+uL+sr69lMeQDD61hBB17RL0D7qpe0zfzoFd7g6FZKHhZkSGtjSt8U9+639S
         uoI/p+eraJuPriPGQOsPJg+t55hNxQj/s5HX4aMV+W6wmd3VEBF1/jYjaK+IKBcINhNZ
         zq1ZlwnSCT7ckQUoja1WZ5vGDwsz/Ep5YL+q24OsKyDH8y0j5akmXjAnejGKB2SkYkNW
         4my79VnR+NqwVNJQnHjRC9WEm4rZcyZei2hvVztU12L0Vo7iD48nq7leBFK0EwinK+GP
         Fiiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsujvlQu2paZY8QrF5AjjZdFxVlMHeHNSDK7A7qFoSFXT6+7llvvpY2WrGdzYOw8HCaHvg6xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwJQIVkgLsfDGieb5lYnK3jJ9RLowB6te9HMnXgXCfsjNRYtc
	+E2XCHnkuBP8btpO+HipHvl6iQpBtVSDZw1DUSo0jaoey/wcOL6KebLbMc68WN8H7M0du0qycQ+
	5C+Gg7RagUDOmow==
X-Received: from yxvt6.prod.google.com ([2002:a53:ac46:0:b0:649:af54:23c0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:14c7:b0:649:ad8f:9128 with SMTP id 956f58d0204a3-649ad8f93e8mr1230135d50.67.1769788977100;
 Fri, 30 Jan 2026 08:02:57 -0800 (PST)
Date: Fri, 30 Jan 2026 16:02:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130160253.2936789-1-edumazet@google.com>
Subject: [PATCH net-next] net: add a debug check in __skb_push()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the following check, to detect bugs sooner for CONFIG_DEBUG_NET=y
builds.

	DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e6bfe5d0c5252b2e7540e1fef9317aab83feced2..8b399ddf1b9bd0dddb37f417ccfa5ea675efafa3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2813,6 +2813,7 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
 
 	skb->data -= len;
+	DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
 	skb->len  += len;
 	return skb->data;
 }
-- 
2.53.0.rc1.225.gd81095ad13-goog

