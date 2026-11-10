Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331772;
	b=zgfqrfnLcCq9GN9jzypi/XD5bmj/H50/BC+6Vc3S4XbkeORD9Lj58KyrhqVKBieZud8S
	 +3M50/R9SAEhdxGRei8zqEFCef+nePF17eaQXeiJFzd0bNnEyVD2XDSFoK+Bk7Vg67vHx
	 nfYDnplLhjtT8WqU6Jm83cJQhBDoydLRduKFGa1MCINIUDCtjKYiEt8DmGzNtp05Haa+9
	 9Uc0V6lkuHQg8+ff21d3vRcHclPenjoKfy6hxpr2tWy9Nmk4lTFNFpVB8FKaApH917h+L
	 I05nrEDxoZjvr7aT8q6PGBX1M3n0l9gUpXfeT51KWATFP+yqzHlsKbyGjk6RVxXtzmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U8vekOIgDj5lHshrVu6+OojGjUuLqlW9D9EqkiQsI1A=;
	b=MOqJfx+wSowtWBGbX5ehnlsU8E4emHS1vPK6LC8XM1LyOn12VJBDefWe0ut6WFeTjz15
	 WYfN0XNXJjnecylI7o9kG18jQdilw+Kcvoi+4q/5JIwChQYreFwBv5PJiruhvUksUeTJt
	 che8VyM8irTS85LGdg79oHI2piiG+VMAWBBpnt1R3/oQkff6e8hBSBoo4Twehn4h5CQ/2
	 np6HHlX8bbCKcK0vjDMUNWgQSgQYUZPpe3dmYHr4spn3PPKzFJPlOKPkoAHOg6Ro29JSX
	 5s6bz8U1ksBLpGt5/+jRJPLizqHErtbI7Xu2Q3d2xDcb+C+G3t3Us5KTMyBf9IjXMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c8oUNAyO;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B71606A334
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B71606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c8oUNAyO
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so1378314b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794331771; x=1794936571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8vekOIgDj5lHshrVu6+OojGjUuLqlW9D9EqkiQsI1A=;
        b=c8oUNAyOAS1OI9ImuewfKiO+OK1ksCavl12v4VTWFcQGJh15hZlG4TAZGOXSI1BPEL
         8lCEqG7myzG6euUva5W3NAP2wOng/6KEQleZb+MiSY6ieB3LrDBrIaBNyg21bb/czaUs
         P+rxa3fWNZ50SqFdayY8fsqJqu6pJXSJ4mMZCwUNITsQz7fuFnTqfl0ybZGXIfL5Yg3S
         SHw4YyEM9PtEzFztZevvzKb7bP6mCP2+LJ5DABubyAs2gWOV8+t6FONhG2wa/PFiBh1b
         hF3WhSOHw+ndoFMpMw9Q3yKq/JU2F0nD/JrddB2WX69mdiarI0v/3sd6B/RHJOPLQ36t
         /rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331771; x=1794936571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8vekOIgDj5lHshrVu6+OojGjUuLqlW9D9EqkiQsI1A=;
        b=FZc9gulvIoEALsqJrE+lt4Yy/maWYrqSQTpYUYGjKaepjQ4aqzFWPilBlLUlycQotf
         I0ErqK90Np+MBLmckvGu/v4IWfweJSUBacBWTf8GQKR/S850y3swn0FJUrCSJMGpXkTg
         3tu8OdZipAZbwCUsk2moLgXN/h5b5AvIReLJxnYYWQevthEs6ZRqmTP2ajtUf/XoxRd1
         +GMrD4Ik2f8UgRAwYjk2CFF0KxaNXl+iZ2OvEBIIir/l4BRGEaKBeIRTcDkKQIbP9IYS
         3nlvDCk0b0J9TOU5o9iasKRbrZkqZ2cbnR8XaVDwKgfSofiosanXDJOTuDKmNbbTn/LK
         yywQ==
X-Gm-Message-State: APuU4Z+ZujvE7VO46n0iNPQiX8rioC9TQ5LWWxCBHHIIhfP24MJm56Oe
	IyYtLKpuIuYRqutuI0IoM+J5lTGBocduAt9qJgbnV3VqaXU+9+KvFUoxJoi0RsaBuz7qg4Hjhgq
	Ny23jq60=
X-Gm-Gg: AYBFou2Rzw5RacQNwX6VQQEBDKN7pp3uh2omULmBSGhvlAk4DIhMbWRAIIY8/TKRxna
	FOnnGJkEe50ZWp74aJ/1ikfH0281BGmy+ozFAx4V/7ys+5m9QVOyVV+ex4i4l64uAUEaLncE7u7
	p3IlgPV8bpP0bf00f/qCBz1VOQHpu5OidaaJIVhC3IRyEV50103fR697cxCgCVhZQ1W9nBcKVN9
	bavSfWhV61O0ymuw63WlwLb9O0nHX2Ph+8NgnkQsWQFHWogKw59hgLCBqaYXSxVknn5ZzpdDrgH
	XhUFwA6SrN0eorKaTOfImN+cmYFtz6SU5hSRMYmp16OoPCL3OjAmswpQeAmawRxEXZsPF9R3QLz
	k/QPZ9ktDb/W2WxtzOlGjQ+NakjwfTNhov0D+0jlc7PH27lqF/1V867QY+YkjFkcnhlrU89LLnh
	5IgJyZNKCwD+oxUPuUxYBEFsQaWEzz8JH1QY65rJpbjE+FjBnf9nZ8cTmZDilk8a9SK4uWtBZBH
	88naVOM/tUAyxx8G98oJ5hLbkjtBTRcbojJL1jghmTfZHcZx6PYPlvkSHitfmXeniwTUvyw5gcN
	6e5vvcY98VD3GD4dm91wNVy+8GjbX875JkBSwA/0ZASKzbTx5FtXeHtlKuGfRz9y8zBy
X-Received: by 2002:a05:6a00:9502:b0:886:46c:8a1f with SMTP id d2e1a72fcca58-8ba8735a042mr3412188b3a.35.1794331770936;
        Tue, 10 Nov 2026 09:29:30 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab5f1effsm1197939b3a.49.2026.11.10.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:29:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/3] ipv6: return EMSGSIZE when first route in dump does not fit
Date: Tue, 10 Nov 2026 09:26:17 -0800
Message-ID: <20261110172925.3293312-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110172925.3293312-1-stephen@networkplumber.org>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a route does not fit in an empty dump skb, fib6_dump_node()
suspends the walker and inet6_dump_fib() returns 1. rtnl_dumpit()
then returns skb->len, which is 0, and the dump ends with NLMSG_DONE
and status 0, silently dropping the route and those after it.

This became reachable when multipath routes started being dumped as a
single message with an RTA_MULTIPATH attribute; a wide enough route no
longer fits.

Return -EMSGSIZE in this case, as IPv4 does. This depends on the
rtnl_dumpit() fix in the previous patch.

Fixes: beb1afac518d ("net: ipv6: Add support to dump multipath routes via RTA_MULTIPATH attribute")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/ipv6/ip6_fib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index e1d49897d6ab..1025267992f0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -755,6 +755,12 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 
 unlock:
 	rcu_read_unlock();
+	/* The walker stopped before adding anything, so the next route
+	 * is too large for this skb. Report that instead of letting an
+	 * empty skb look like the end of the dump.
+	 */
+	if (err > 0 && !skb->len)
+		err = -EMSGSIZE;
 	if (err <= 0)
 		fib6_dump_end(cb);
 	return err;
-- 
2.53.0

