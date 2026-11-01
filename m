Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515461;
	b=UIVzwsuPIj7MRyTECTo/eufrjeEbgac5NlT88Kpixwee7aS1ZVfaqsrrGMWz8DZrC2Q1
	 e9x3Y6x5LQeKX8L5ZCFqmvh9PdLluMmERMGv5Sc4S8Hbs11hMwhWTdStLyyy30kIs6pz6
	 eoO1B0ANR4Je/NjC/9afZ+SHbspkuXO3zjDuBVk93KP6LLrqam+cBYvnxund2N1Voxjkg
	 4nRJmY2nZaJgYPx0Zu70jBaYQZEgeX/k8FNQQ7OIV5zY2/6UG+9xBEPWvX2oWhGIhKu2p
	 bMkG0XV0vknpS+OLZ4g05i5DEKOItfvrQZoMalISbFZ7c9p9eVIt7IGXfzyngtmLLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Xn/dXYzBrvuQP1GZ8ltxb6g68q6hY1g6OiFET+CRn6Q=;
	b=X22lfipVmG0vV+Hzm6j9KAmvq6LJsiBEboNtOiKkLRpAqON3FBTkGJjbdkYm3Lqz31+0
	 mxNQutKd+4Ond64hcKZ5HcH+1ZwTTkx+nHdoaK95qp389pKPUhwahOO8/VgxAFC2CKfg4
	 WiuuEeTTzE6wN++z7VGD+MMWM5Pq+aBtFFB+4ON9vkadh+UzXeJi9K1sTaezBdg67iWgU
	 mcAAsrQxSF/nqrNDPXpLwrC5M9fSUK/0aLexOMBAacKQQXjs64hiR3azv3IWatCglLX0W
	 hMZkZ9zOkC+8B49L5o/OfPQkqxXThDLdzPFxw86jpCQiTsXeIG7kZ+sCp4YI8Zoh0xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ULul8JzV;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB420606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 06:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB420606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ULul8JzV
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so2964986a91.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793515460; x=1794120260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xn/dXYzBrvuQP1GZ8ltxb6g68q6hY1g6OiFET+CRn6Q=;
        b=ULul8JzVvdzIqV5H5TRx0zquhZgZJeTT0sJdwiM6+Jn6KMIk2PS0ZUv+JuR1eASBoO
         6jWMR9w8e6uLOIujE2Jf2j3uJI7JdaKewt9RhH1kLmI0sPDkZ64wlY9lMPYZUnaKlHuB
         62kYU/bJnxJdCQtVzZuaFQTOMCGRQurMdxcCVq+EfUSe3A3IgEFEsbGm5sZ2dlc8H887
         657Mi8XmaftsRtmR+WKK/LIhVGB1CsBpmbnqCxdym3+jSL4D1MDG3pbhTgyV2TmMdmRf
         jbRu55iQLt3InSqZQ8rs9mm5UteWKaeR3BFubSodJOMK0Q7qcZIbTke9AlvOW3QG0WH6
         ob0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515460; x=1794120260;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xn/dXYzBrvuQP1GZ8ltxb6g68q6hY1g6OiFET+CRn6Q=;
        b=vSLE+CY4zbzO4ywE6dXEs1Gcji0NekDjCRKIJoXINnVjmF4gqmiU7gBoo+P8RLrfvu
         Oe3uYoYVNM8foMmfQv4dfYDX+O1cCp6Tk9CvUuA+MI5ASc+WgRb87hIeT3HAwMS4MKNN
         7Pg8L08yDRTqIp6OVzpNVlUcEj0aIzE6fYYYT3i2U/EiG1C8qFSGfCMMhJXkRqThGXNi
         eicAL3LENelIg/3LXYI7YNNQxUXikmMYg8vZSxKqIrqfINyTsh+IeHwwQVPbLkJ0rvhf
         BwRPfArI8x6HGzbxBDRlccWBiNS3HzyCRfP48AuGZdu7auCK1EYtOCjjf0EmqovsHjOr
         blrg==
X-Forwarded-Encrypted: i=1; AKwUvBxz2bmoU9UrJ9Zum7KNqM9aSbHw7q1ARnc82gnOFjOIt5yleDCbER6DIJ9Z8+XK2aTtp1usivE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DG2qTVBXXjUsWK53g/CkQF0XjPdNEyax7TPcLKetsIAPG4NuC
	GERAg2incacnDAr4x/zVbUzAigrJIPgPkuQ6a4OAXzmp5uRneathOV1I6XgC269/duNu3j+bnzw
	umsRuGw==
X-Received: from pjbsr6.prod.google.com ([2002:a17:90b:4e86:b0:3ae:1810:840c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53ce:b0:3ac:7c52:fae5
 with SMTP id 98e67ed59e1d1-3ae89835706mr5373011a91.50.1793515460125; Sat, 31
 Oct 2026 23:44:20 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:35:21 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261101064418.2055158-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/3] ip: Fix route leak and unregister_netdevice() stuck.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jason Zhang <jdz@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jason Zhang fed commit 0346ec2f080b ("ipv6: Prevent
rt6_insert_exception() for dying fib6_info.") to LLM to
find tricks to cause the same symptom:

  unregister_netdevice: waiting for gre6 to become free. Usage count = 4
  ref_tracker: netdev@000000009652f190 has 1/3 users at
       dst_alloc+0x14b/0x490
       ip6_rt_cache_alloc+0x27b/0x670
       __ip6_rt_update_pmtu+0x572/0x850

This series treats them.


Kuniyuki Iwashima (3):
  ipv6: Flush exception route while replacing nexthop.
  ipv6: Flush rt->from in rt6_uncached_list_flush_dev().
  ipv4: Call rt_add_uncached_list() if !do_cache in
    ip_route_input_slow().

 net/ipv4/route.c |  2 ++
 net/ipv6/route.c | 20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.56.0.317.g454f8302e1-goog

