Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C5395AC5
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295917; cv=none; b=Tj52gGn8uIB3yuwzrJT43CsAZZCYHJUaqwdTE5D7ajHhc53kjLmL0tVUSavOxXNSJ5/oknD/rKBFIariplYeANNm0umi2vf8UqZ9Jbsb3jfOvZ7/a4jJqJGfsTxCVu4aiih5clvAEsWjwb9gqeCpYgU1vL3o4tKtlt3j7oTfCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295917; c=relaxed/simple;
	bh=DmJp/vi+6ILWonYXZkj5nFKHTNQ+VfTuwhZy3v5z5S0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RqiYt2ULR7jmLA0GiNYnMVcqimQEvUw5LRR9KY56nWL7xqPhuqM5Gf0/ak+wH8Esy4Qrktg5o5rOTvuz73uy4xfdUNXV3Xz4EjgXXejwxgiNYIQfNSGESgTE+B6J2BVY24hldy9mADmDe/PvL5mvJ7EH2zYL8KIbTf3IN4seKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLEiSjEf; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLEiSjEf"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930edb4362dso65158685a.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787295914; x=1787900714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zmDvT9S0k3bq8hYlKyXaWcrzslmEN/ZbGYA0GARxd0=;
        b=kLEiSjEffvueavyr8Tf7Y7HkuLmr3M386MARIl4iK8JNYeOdj676PWXNKUYQsOgKBs
         YeW+cDtxVEUSJIFtPmA4xQmr8i/2eo1IPSJ6yl4Ec9aVKOn28zWN7WqzYjGCof/3EDM6
         8UJLI2XmriGWVElj750lTCBgGVbyGKI85jr5YUYOBenR1A0P4r8KVjilEtsmPogQTQyo
         X0TZ4x+1mLe3Xaciw5UK/McWLQqc33zUZ8rIA9dAwuwvkKGL+cU25BXB5Z3wimwodMHR
         rV3BRNxOLVhCZ8Au5q1LPTUtqmBSTk5INB1FpCcb4kLOfN2NP0xA8KrknkJ/wH2lCyFU
         EOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787295914; x=1787900714;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zmDvT9S0k3bq8hYlKyXaWcrzslmEN/ZbGYA0GARxd0=;
        b=VwN55OAHTOa+iGWqpSe0OABPCjfMZL4qLjUbpEgPZsPv9Jd+c0+Q6vtxEeU/bfDLcO
         h5gd0yPiqvpYfgtd602acaT+tsLnXYunwD+gK2APLxa+DRsQk2olcMK/IAxM06vNPEDE
         rjU5L5WWput4iWixFGX2eu0kQF8HdC3fg2ljuhespB66uV95V31Gd8TOr0bZewtEdZ4o
         y30Dnaf6ncqESl4nFmpTLXnW4pkk3b1HnuQQveJU/fYFIb3hPJ4i42U23iVkhMy5+9hl
         9c993oYE/5ISHlo+nvGbvg2LC2fQ3QWYBZW9sJThgho3cVRKkq6ioDRpkkmiUMay3eI8
         05qw==
X-Forwarded-Encrypted: i=1; AHgh+RqwvRd6YLpDCJ8ytQE3F2uDml0BQkX4+qxYqcTiwnlh3AbEXCV1UF34uUFelBwMkNBOMs2Nah8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2LV5LSobdyeh1rB5Y11/QvbmmJGFOewM3H+OVU9E0j5J0ocQ
	KrMo2a0pStPncMk6w6XFi2xh8+AX7Rfj2TGqgB05H1k6rBEaub3aRMis9SpZuRhyPdvUr/2BY1Y
	H3PHa1ifvcDhUSA==
X-Received: from qkjx14.prod.google.com ([2002:a05:620a:14ae:b0:915:7c23:5aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:225a:20b0:936:ad4e:9243 with SMTP id af79cd13be357-937395b1c2cmr243532685a.40.1787295914062;
 Fri, 21 Aug 2026 00:05:14 -0700 (PDT)
Date: Fri, 21 Aug 2026 07:05:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821070512.3122442-1-edumazet@google.com>
Subject: [PATCH] RDMA/core: Fix use-after-free in ib_get_eth_speed()
From: Eric Dumazet <edumazet@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In ib_get_eth_speed(), dev_put(netdev) is called before inspecting
rc and dereferencing netdev->name in pr_warn(). If dev_put() drops
the final reference to netdev, netdev->name accesses freed memory.

Move dev_put(netdev) after the warning block so netdev is kept
alive while its name is read.

Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/infiniband/core/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 86811d31092ce03c8156b444fece47b824231219..57f109c8085dadf90bcc498a9ee64eea3c5f5271 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2052,8 +2052,6 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
 	rtnl_unlock();
 
-	dev_put(netdev);
-
 	if (!rc && lksettings.base.speed != (u32)SPEED_UNKNOWN) {
 		netdev_speed = lksettings.base.speed;
 	} else {
@@ -2063,6 +2061,8 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 				netdev->name, netdev_speed);
 	}
 
+	dev_put(netdev);
+
 	ib_get_width_and_speed(netdev_speed, lksettings.lanes,
 			       speed, width);
 
-- 
2.55.0.766.g2966f0265a-goog

