Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D719363C40
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967482; cv=none; b=VCpV219AOXQKFK+magbNV9wcMhkQf3rD63HSJmLQugx2IbEIs69uhhRs9JXxXgFwUYVu3JMcZ3lBnoRYs1prcUq2PZN7l0lRqQ4WGQdOCcykxjbntyVkiTEfumFKXEYcFZ36NfpAjgp66J0wq8AXiZEX7xgig8vJ4Fjumv2f2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967482; c=relaxed/simple;
	bh=D96mh5dzi2qAbx4ftRCq5skDvPxDMgl7lbS2fYISxCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HrSKgWVdXwjlR1P/rWtlJtSo9CjzPdPTbtzQMi0L6wIpjbN+q/RgdGHbbVKu07LNOlaJn9aBv492mrC8bXGoXY+1tbrKFBc2xn9MeEjJESkwDssf1vkXP/jLiZTiQvp/fgeS40Z/Igm/KEpF77vLH3fXn0FzrtpJ/R2Si5MPnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPY/WDfb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPY/WDfb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c987913b08so18219985ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 21:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782967480; x=1783572280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LtZb58Bvu1YGiZlt5/wwq3IK7PwiIYPxor9dQPkVCU=;
        b=oPY/WDfbjGmER4jt/1A19TRLXyurgLOepD7Qh6dOesel3vka8WdQVP5lG4sf8q1gy3
         nBiHUJn42exJO2/ufMV2NtlIrWhhePWmAQ9aytr7R9jrqdj3XKaq31+G+PqBMCRAvhWe
         2lGnK8E1IXuqzsehCRdJ+SNXSP7UO9ta1J3M0OkkN0/Bp2VflWo6K7qRU90bQOCmJbAZ
         Zx1tgv8ZxGMD9SQt4P20/HSg/I79ZJhz+tzS7/GjSI0plUfVpxi+YPDXuVpiyEqMijyp
         JBDs7+slbgZnMLKWVZ5ULz4N7/Z1DBguSw57cpWrrH/qzmviyZaP7RD3x3B+WM042Rt0
         XQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967480; x=1783572280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LtZb58Bvu1YGiZlt5/wwq3IK7PwiIYPxor9dQPkVCU=;
        b=b0groXrmOm//bhHUmZNSZ8R07ygwqDav0JhlDPMdJgFs3NiLowbARS+UDiMeK1397H
         QF1g6HS+C60fKr6+o/kaLdbWrOt0DiHWgukCvIsVbUfQ2s9Nxyf4jI0z2ueT5AZyBjOj
         A3oOHg1vrwkB8pRF0CJ5RkOUqKPE8jxTe4wSsNUx81u7I82Zu7y9Yc3DuiClCW7xwSTZ
         Rx7BhKNGL6EAELHOIcYgOgnLzLDs7r+zoyClUYs0k5ofDxa97K8n7aIKI5jmd206VlZu
         LKsDpydWFMpSxFt9b5GLaNqa1J3GCba02wHLB46ytGSn3Y1Z7JZF0cYPJtomAZI8GZkU
         1SkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwzxMeeFNPvwBRpyuWydFmEpjiUl4P/nth0sIFKJhYHRTIvxAG0yoy1jzPDMq7GCc3xQ65eOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0eK5A5wvCVNxe/3QLEksl3Rxf6jKMLMW4/R/d/XI1Lvni+Fe
	5g5FTsq3jKlJpl+4w6InUU5MNq4eJx76lkgtovJj46YDPhPX0BWDyTAHNRyVQ2DDZpHmqq2F2Ay
	kL9bd7A==
X-Received: from plrx15.prod.google.com ([2002:a17:902:b40f:b0:2c9:d4f6:d64a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ceca:b0:2c0:a555:80d6
 with SMTP id d9443c01a7336-2ca7e6f4565mr44758195ad.2.1782967480080; Wed, 01
 Jul 2026 21:44:40 -0700 (PDT)
Date: Thu,  2 Jul 2026 04:44:15 +0000
In-Reply-To: <20260702044437.591864-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702044437.591864-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702044437.591864-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] net: fib_rules: Destroy ops->lock in fib_rules_unregister().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 8e133ba99cd8 ("net: fib_rules: Add fib_rules_ops.lock.")
added mutex in struct fib_rules_ops, which is initialised in
fib_rules_register().

Let's add paired mutex_destroy() in fib_rules_unregister().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/fib_rules.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 22e5e5e1a9c4..7df216c17c67 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -203,6 +203,7 @@ void fib_rules_unregister(struct fib_rules_ops *ops)
 	spin_unlock(&net->rules_mod_lock);
 
 	fib_rules_cleanup_ops(ops);
+	mutex_destroy(&ops->lock);
 	kfree_rcu(ops, rcu);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

