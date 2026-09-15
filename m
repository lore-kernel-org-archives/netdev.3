Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D45359A90
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493471; cv=none; b=XNZVmZ4kj9VdR4ZCdzASeeS1Yrio4XZcKjUKTOphmb2hIlNHa5Ny85uWmKrt8bbzA1KmB4rm9jkBe9bv9FZ2TWwkIx1u0cvMd7kQKs/05BxHmjB6raIgJwv2dTqsM/zYh8+aa2ec2hnmUtpyanCmHzj0i2m36n9Q4OQFtEFEX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493471; c=relaxed/simple;
	bh=1L41fDFcwJhnqwC3iHJYWgVyCIQZycnmy2yM9XthIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezXCqZE/owoigrjzT9kT85ESzIwf12SlVr5OJQgbvwJyvMIXXMJhxE9qASNOrZAkpBdxNv8/c8gxRScmiHQ090a778pX10qQ4Oa/+njUiyjD9BziVM+zKrBDowAKUUAj8vlTG1r+98pFs9vtrAdXfU8YJvlqmPXoCjYWCq89RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxIAC1a+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxIAC1a+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e9d8a796aso1901241.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493467; x=1790098267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=oxIAC1a+UZ+J75VEHH2IzFKpwEeCcYfBwKmlierodh1vG/bMJaGH+qLXPFhFYmiuJM
         ldjoKSl5YcMqxQN5f9E8jr8po7mTnEeUBgAJsipixKbs1/vMqf9rdqyi3llik5emzIFa
         gqHDrXymdiU+9xxhfgTWBt6dqxfKZKvCU8mdH8v0pjdQPTLp1wTwj9xFiRpj1EBbOTnN
         vsnZQUv6mAFWE7KrasvC/EGfKCEm4VMT/yE3mZzpFCFlM8V0/2/aMP588NuVQm96o5L3
         zRU51FI79U4ZJTgO/B397rPcWlIXg+ide6sbGxB+1aJkNRVDwampwZ04P2IuMSFx6Nio
         HUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493467; x=1790098267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RgblY6L8XKeLM/vcFnT7fWo1z7GUneU5Hum0ZMmOcJE=;
        b=TYHV9BGF6V/gzag2imo6ioKfL5C48vJCy1cK0kuVSsGap7P3pEe/XsFRLKStsBwqTU
         qH6E/Jw0PFx5wJoNK4aL9R8S40iaZCafQJfBB46yPkN/BfIuVOnmYdbzkVIpi7TlaBDK
         8Geb9YUZwU4Ixu3WDIAfiS/4KFYJNtedocq001hKYEj9rO8vaemxN/dD5tGZ75pJCBnv
         SX0WlbOBy0lE5bijkPcE0eb4Wh7VBNXktROuvwBhDlfB0Hmu6uvToL151PbCicWVXItg
         pamZZev2dZC/a706U/5wqTDUPSxpUeJanFk2FyPMOOnM+avd2un4zk0lHJ7pqQ0ndhjM
         Zj4w==
X-Forwarded-Encrypted: i=1; AKwUvBy2OQ8tQCANbtqqLEym8wxvHkC7ABX5AQgxOWTvLQjzeg44RdbNSV3mus09FzHZN15rjtf+sMc=@vger.kernel.org
X-Gm-Message-State: AFuF++lEw+C8LWIfHMw6TnaRihCy7RzmKSsHpRx2FcyQj3NLgs+Khw2J
	l92izUZnGmOgBTyu1nD/hwayz9KY74npatBtTRv4lC6x4/J3eTd3qk1m
X-Gm-Gg: AYBFou3II0OygdDwldw0AUHKU48Gnv5qAUwYOJZy6FZXlD0mXwOvRzTB+gfMoJWCtiM
	qwQeY0dfR+IJG6rl3JjApzx5sD2c8Ims5uE96d5JxPpjegdq0HJjNo3odxNjtTlDtPRc9CHAl8t
	StKhertxdpdw+jc+Ka8xNosmcwFYu19LOpnKrEviyjz7Sdne6+G3Jw5qidxfgfS5Ut04KZ9k1se
	exq2/+rsMNtZAwU1T0ylMoLtYQzn6ONoeqTT1/n/sFWeyEOsYtLLb+ixXSyTiXxpItwwL9m4pM8
	d+RcC2WHCdJFwQx9I+yfrKvqdauVeOJMdF0rFx4vV7cTjN6g8Jso5/FknHvwLT0+xhT3duCliXu
	+U+lLXEg1JECH/L4dWbU7Vaf8HifLZF3B/WxFNHafb7BDvFpx3CydGBFcNKcSodk1VvcqSEBmwY
	22gO81eWRU/ogoZnpW7iszKLh1XlNyRJw0WwuvqHCVwpp/EwdOHaLC4CL474erZqBL
X-Received: by 2002:a05:6102:8687:10b0:799:f608:79e6 with SMTP id ada2fe7eead31-79d2319d752mr2295720137.1.1789493465871;
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb104b2a6sm310677137.3.2026.09.15.10.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:31:05 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v3] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 14:30:50 -0300
Message-ID: <20260915173050.3176344-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the transfer length is zero. Its caller then reads the uninitialized enum
and may permanently store a stack-derived value in the write-once child
mode.

Return before calling __vsock_net_mode_string() when *lenp is zero so
that the helper is never invoked with nothing to parse and new_mode is
never read uninitialized. This also prevents an empty write from
locking the current mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v3:
  - Move the !*lenp early return before __vsock_net_mode_string()
    instead of after it, as suggested by Stefano Garzarella.
  - Add missing maintainer CCs per get_maintainer.pl.
  - Add Luigi's Reviewed-by.

Changes in v2:
  - Return early instead of initializing new_mode to the current
    value, which would silently consume the write-once transition.

 net/vmw_vsock/af_vsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..XXXXXXX 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,

 	net = container_of(table->data, struct net, vsock.child_ns_mode);

+	if (!*lenp)
+		return 0;
+
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
 	if (ret)

--
2.43.0
