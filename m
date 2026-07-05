Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F239EF11
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275483; cv=none; b=KFz/hgHKJ5x5mMUviFt6XN8E8a1aRnxjE32zhIOkP8gEd+yOKPUUPDw1j8MmQPLSIHsSUXtRuLQkxDaLWQYRxsRxC6ElSDfa05fbwf1nSNUygEH0jY7W3b+JjmwnOYlMzKMB5f0apCbJph8mAKWvBDv/3EhbYW6FwUrbOAkcbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275483; c=relaxed/simple;
	bh=8qkaK9CJewoSBHJsNGqdS9I798dwSpqf9f5A6hyIKWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dv1RN6NiuIgYdTYfxamYOgCZ96FSD2mszpjzXY4X+vUZaFfoq81aoKDaCrJGR3ZHNAgrX2c1I1/+mx8IR4vOTjZhLFDib9df9Fb67zCtykfbyD9Q07tz13Vz9sZvmQIGr5Xp+wqAY49tcOf4cl5TLLldb3qwsQiOUxbALLG/lyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+zyHLWc; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+zyHLWc"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8efc093d7e5so19331626d6.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783275481; x=1783880281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOkxqmtWVMJorKeOZAzUaMm6nv2RJ475cStWQHNl+sc=;
        b=C+zyHLWcPbO4dUFm/JYE0Ht1EArpAKtdRpSs2Pfjn1N6XtoCTdEZ5U2mbY5BHHrgoZ
         ox4VcgqFyHYugvHau6i5+fAhr2+sQapqr9UuY2CLd1XzHvcq/SRuUpYHDJUxtwlMXSBS
         9kKb5gU+H9tFD2Pt7c5+9+wt0UAhzrcFrXqcmTJuv8dcIslT2Cjy6P/4GdVoK4FKFbUk
         b5TaoWwp2iFJS1etIqb8mwmVYaNzUhbRMSQKF6JM05He8dYX5ReeczQZBAJmu3L/uOyP
         sVRyzOinohuCvAc7HXhzOBMHVqBQBxPlDuaqxvBfSlq3Vl5+5W7YHwNX5Lr/Y5vWo9rQ
         h6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783275481; x=1783880281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOkxqmtWVMJorKeOZAzUaMm6nv2RJ475cStWQHNl+sc=;
        b=oFOiX9b1sAuAsUwE6dug4vKhO+zCPnVR9mUYLIaUHDYLbm4jC1CG3MRq8s4fPZua5v
         SV/i70g/1Lbzi8131IbQ74o3PWGLE65dmZwSg2fjTbQ1rP8GJuD90PncSUlJ9+nIKmbj
         uGxE5oCKwbFRZ5+iYg4yWr5Nw5LPPme8+JidKkmTcpBTAS9mvj4hpM4090Tzt8ro73pA
         dz4/4LqCHl/4XUDJrT8hsYAtnmG8lOa+mIiibbFL+q9ZsL10Xt6t4Fi5D2Iu9iM92SdF
         qOEZmYFyWl68NXQnfsu7vJS5yk6O3gEIcGifcxxtrvpk+3dSfvMW8kuJDRwJpLp6gD/z
         eM5w==
X-Forwarded-Encrypted: i=1; AHgh+RqJMYREvzuN+0OSigLJ8Tq0gmPTAaxeNrnGuPnk4kCdrutBpPkl/oa8OpYWPabONBj78s0bPXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeIyz+PLsJkdX8lWQQXBrpux/bvDyL+6eNDlk2TzUk7nnyBL4
	FrgSZPYsx1YAAAckztnbxF++SrVt82KGyZgQijox+nC2tzop/FG/yRJi7n1rHxc9tCx0RcZBT/m
	9jfclNxjc9fSRPA==
X-Received: from qvww19-n1.prod.google.com ([2002:a05:6214:80d3:10b0:8dc:9073:dce4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5f86:0:b0:8df:1814:3a1d with SMTP id 6a1803df08f44-8f74a519bdemr118689006d6.22.1783275480484;
 Sun, 05 Jul 2026 11:18:00 -0700 (PDT)
Date: Sun,  5 Jul 2026 18:17:54 +0000
In-Reply-To: <20260705181756.963063-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260705181756.963063-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260705181756.963063-2-edumazet@google.com>
Subject: [PATCH v2 net 1/3] ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Content-Type: text/plain; charset="UTF-8"

A race condition exists between device teardown (inetdev_destroy) and
incoming IGMP query processing (igmp_rcv), leading to a Use-After-Free
in the IGMP timer callback.

During device destruction, inetdev_destroy() drops the primary reference
to in_device, which can drop its refcount to 0. The actual freeing of
in_device memory is deferred via RCU (using call_rcu()).

Concurrently, igmp_rcv() runs under RCU read lock and obtains the
in_device pointer. Because the memory is RCU-protected, CPU-0 can safely
dereference in_device even if its refcount has hit 0.

However, if CPU-0 calls igmp_gq_start_timer() and re-arms the timer, it
attempts to acquire a reference using in_dev_hold(). This increments the
refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
Since the in_device memory is still scheduled to be freed after the RCU
grace period (as the free callback does not check the refcount again),
the device is freed while the timer is still armed. When the timer
expires, it accesses the freed memory, causing a kernel panic.

Fix this by using refcount_inc_not_zero() (via a new helper
in_dev_hold_safe()) to prevent acquiring a reference if the device is
already being destroyed. If the refcount is 0, we do not arm the timer.

A similar issue in IPv6 MLD is fixed in a subsequent patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inetdevice.h |  5 +++++
 net/ipv4/igmp.c            | 14 +++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index dccbeb25f70141982160c776f3cc727296def2b7..6032eea2539a60d0476d85667bda3bfcad8f1425 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -293,6 +293,11 @@ static inline void in_dev_put(struct in_device *idev)
 #define __in_dev_put(idev)  refcount_dec(&(idev)->refcnt)
 #define in_dev_hold(idev)   refcount_inc(&(idev)->refcnt)
 
+static inline bool in_dev_hold_safe(struct in_device *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 #endif /* __KERNEL__ */
 
 static __inline__ __be32 inet_make_mask(int logmask)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c1418589bf8ef31e00fd98b6187f5271..f5f9763895641bf86bfcf9fd7fd7b06012fa4ece 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -248,16 +248,20 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 		return;
 
 	in_dev->mr_gq_running = 1;
-	if (!mod_timer(&in_dev->mr_gq_timer, exp))
-		in_dev_hold(in_dev);
+	if (in_dev_hold_safe(in_dev)) {
+		if (mod_timer(&in_dev->mr_gq_timer, exp))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = get_random_u32_below(delay);
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = get_random_u32_below(delay);
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

