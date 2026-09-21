Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8B46EF7C
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983742; cv=none; b=Og6VUJ0aOi7p7EAkOWpNDbiT2bL/AshjH8Cr9xQim4zBKt8r6Xi0qDxf59YO8rOPues6nKbagp2qu1Cq3R9BU9dNAWX7uCRhfON8GltXF+q0/5mCsw7XaL9mffEqiE4Z/J1vfMcJQlAkkYUHeWRe2KLPDzSupaZe/imdTfRDGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983742; c=relaxed/simple;
	bh=ZVK9IWkzuMit9UN0/IVNL/DUWvScN7/FjTNB7Cagk44=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aS3GhjQsr26FLbDZBl531NfAu8PdZjOxUgA4J/ojdT9BHVq5u1kuPcQIYg27d8NrhOJQzPor+8xb+XBusACibdKCERpRyfyOx3BNeO+t6+5+07MpYuVm+0Cr8bsQ9ZyV+IPgzDW7podr0AJ59tzPTTrYNDZJ5LsEtEKdTOsgk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUCQ33E/; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUCQ33E/"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a0b66ecd9so347723585a.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789983739; x=1790588539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4RFSnOgpwphN7ttl/wFzvxDj+TdLRnGdBDD5X4w8tFs=;
        b=tUCQ33E/sTEQbBFE7HSlJa/oyvY/AdEmYZSCg6RMe3m2qS5/w3jtYXZrXm0Zxf7e61
         4YMTLN3K2xeSp4bxSW0x8hS7jwwHw/yqNyH1fg39g30bQEiPqsJMh8VbFLa8dGSs/L/2
         r5nCjvprDdNBkX9XwkU3BX2XcsDk69jH8Q3hdDHIYfwlDxIp+DPk0pLoQUktkAMGbr+M
         7m0dC4zWU5KVPpl78QSBly6zKQ3Plt565OL1n97jljVLXZenIIdNU6M6uJa/k0G1xYpq
         nAo/QvRmQ4FBufB/krB+iHxNQOnIsv9LpLVuAeV5nvR9wwrwN5yEpYgQf17cxHkjShi7
         m6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983739; x=1790588539;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RFSnOgpwphN7ttl/wFzvxDj+TdLRnGdBDD5X4w8tFs=;
        b=tDii8WTU4Z4+19ZTA5sMPMh7d+kNIl/GxtHTW7tEwdgAvSZIT8MXlU0rZV3ROnfd02
         Hes+FIbetfysP+Ix8KblBHWSQudnMFRWpkcTPWne20TOI9dorUvyeDftNnp/DmWVdzCZ
         EvKkCYWu3wq3tmAEBeDxmSXSAJiBd/rVTlNipEnOPS7Nte8VRzbiceFBP3GxZtqTHstj
         9ShC00bR1MC1a2VvPsGK/DHFzFnsv1UZYFLW3+M4qHJMISWsn1/WSgkJt/qpHROOGGnY
         w5E4NRti3OvfRJGi3/aLAmhIgjimO3/F4ANwrKHGCLCN/Fc+1Vtl5oH/+1i28eUhJS1Z
         ZwlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTVGE+Sq8KA+k0MEMgp7KZlxQx/9kf5qByUP8Y9chaTCreRr/uI3XkEHewH9OVzUNxE8hZnLY=@vger.kernel.org
X-Gm-Message-State: AFuF++m2+dnjn7ZMCrUyQkqMpMZxdbxa+hDs3GV22kiewkSZTYB4UzJJ
	JnMZ5vaXAwWJUU9UnSxWOe58keqwYkhVF2hoxzbw1DPfRvCcP69nkFRjFQ6dgU7ADPzCJOtJ6uY
	XB/zlHiHt+oJFPQ==
X-Received: from qvsy2.prod.google.com ([2002:a05:6214:162:b0:912:422d:6833])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4541:b0:93b:d79a:c460 with SMTP id af79cd13be357-93bf5785db4mr944983685a.56.1789983739435;
 Mon, 21 Sep 2026 02:42:19 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:42:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921094218.483234-1-edumazet@google.com>
Subject: [PATCH net-next] vsock: remove dev_hold() and dev_put() in __vsock_deliver_tap_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"

__vsock_deliver_tap_skb() is called from vsock_deliver_tap()
under rcu_read_lock().

dev_queue_xmit() does not require the caller to hold a device reference
count, and the device lifetime is already protected by RCU.

Remove the redundant dev_hold(dev) and dev_put(dev) calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock_tap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock_tap.c b/net/vmw_vsock/af_vsock_tap.c
index 30ee7e4fe25115cef71b43f335862a09b8c51382..7c5cdceabb2a5f7079faab243ee9de7d6bb8857c 100644
--- a/net/vmw_vsock/af_vsock_tap.c
+++ b/net/vmw_vsock/af_vsock_tap.c
@@ -64,14 +64,10 @@ static int __vsock_deliver_tap_skb(struct sk_buff *skb,
 	struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
 
 	if (nskb) {
-		dev_hold(dev);
-
 		nskb->dev = dev;
 		ret = dev_queue_xmit(nskb);
 		if (unlikely(ret > 0))
 			ret = net_xmit_errno(ret);
-
-		dev_put(dev);
 	}
 
 	return ret;
-- 
2.55.0.1082.g2b9226bbc0-goog

