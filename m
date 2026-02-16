Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B98311C05
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252123; cv=none; b=unzGtdAwfcMckYGVLA9Imka3Zqc5BI6Qek1Fhf/1DfzvZgipihs6IQRfVjN01DQlZpeBJeF+wt4TlJ3l2A6PcDKsL0O7jLYmFvDha8tqSxYl3JjQf6fn4nlZQWWuOhSYRrN2e9IptJ2V5v5fOtnVoKzJDgL4cKzBOWXKBA1d7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252123; c=relaxed/simple;
	bh=+dI/9FDnX1440lXrbnLFSq2mjO8pQz202QM4CSn/XRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NO5kSqYRnH3Ub8S3XYNqZT7wO5MgDRshrcOICkwn0acABLdY5gfm9obE6S/46SSlxI3n0JjUVA6HZcDL+tX/uHz/G7L/N0MqC9t5UOor4iMs5E9SJm63xbpRB1wR0/54ggqX6VHCo+gQOqBgWAPQVYd0YhazADT5IfUmJYXLv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0QbAvtS; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0QbAvtS"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8946f51b8c8so303201766d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252121; x=1771856921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DnX1c7BlE+PFvw/EcmVVW092DOisDIzEzaPvweC4LE=;
        b=P0QbAvtSGfuPITs9ujB0J8jFQs/JUkujlrpHsGoMVYucdOapiYt9yD21Zxuv9UUUOt
         y//F+UQjolTnwqwhwDLpytRSLoBnzPQbLKnq9YtXQjE38j3kdRqGNLxedJdwH1sCWQMp
         QidXEKozgy8UEqriHxN8K2IP59QSxe+PBSgX0/kEl1ov8xJrla7INZCWwm99BiBraJHC
         buOHlw1MXaBlSjx16ge9R00hZXVB9tBlPF31xhw4CTClF97KO1B7ylOpk51RV5PZx0q9
         LXWNJv4vt3b0dtKI8Y9UFnOVdUAxgvmpB1Bd4o6iVXC9LNzibETPCQWNCOljNCWEJ2Yf
         /hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252121; x=1771856921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DnX1c7BlE+PFvw/EcmVVW092DOisDIzEzaPvweC4LE=;
        b=f0qWXIyoZ+rWCS+recfX2m75jIavFJBBqRVarhwfbkgrXplrWT1x6DqyHznxOogEjF
         2R/SnTdt19ORmMBT5N6hWhzF/gbn9D5/0y/LHTrCo5523gmUezjER3kkx8rRoAdJKIqT
         JlMGBMP44hk/A2ppjTnJ9+bDubiWrjQbA2wBXGShWF4ZRAL9CrJfiUSw/v849RRlLqOM
         Ne8CGpZ0ZeXbzlPi2m71yj9Fut1DyqJNIqtO2+U2SNDBx8sEM8UmENK6Fia+O0/VvZay
         wCLK4kBABJaevW1jevCvOqjwIDPSxEtoCyybDMBxsLQudOY7+YalwtxxT04cky+14L/G
         bzUg==
X-Forwarded-Encrypted: i=1; AJvYcCXMAr02oXA3S3rzVUO8uJ9CdW5fx5IeWJtT9nXF6F70YCob49MJNnJjHpC4Xt790Wx86NKfm2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN3TSneu82/W2vaAwnLi2EppNxRxB3p0yztBXDfSkMO4EFY+a
	Boeq9guggBkA3LGM8dwV9EcNReW2PQ0chiOtK4zRWqqmcKu5IiG1cYfwPpOqiRNOVIsYQB/IeSJ
	oMiFMhOXHTlVreg==
X-Received: from qvbqp5.prod.google.com ([2002:a05:6214:5985:b0:88a:3392:f43d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d6e:b0:895:6790:bd18 with SMTP id 6a1803df08f44-897404a24f5mr129618426d6.56.1771252121076;
 Mon, 16 Feb 2026 06:28:41 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:29 +0000
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216142832.3834174-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-3-edumazet@google.com>
Subject: [PATCH v2 net 2/5] inet: move icmp_global_{credit,stamp} to a
 separate cache line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icmp_global_credit was meant to be changed ~1000 times per second,
but if an admin sets net.ipv4.icmp_msgs_per_sec to a very high value,
icmp_global_credit changes can inflict false sharing to surrounding
fields that are read mostly.

Move icmp_global_credit and icmp_global_stamp to a separate
cacheline aligned group.

Fixes: b056b4cd9178 ("icmp: move icmp_global.credit and icmp_global.stamp to per netns storage")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv4.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 2dbd46fc4734b78201818ecf6065237d475101ce..8e971c7bf164642344f40a07e021b0037f27ee7d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -88,6 +88,12 @@ struct netns_ipv4 {
 	int sysctl_tcp_rcvbuf_low_rtt;
 	__cacheline_group_end(netns_ipv4_read_rx);
 
+	/* ICMP rate limiter hot cache line. */
+	__cacheline_group_begin_aligned(icmp);
+	atomic_t	icmp_global_credit;
+	u32		icmp_global_stamp;
+	__cacheline_group_end_aligned(icmp);
+
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
@@ -141,8 +147,7 @@ struct netns_ipv4 {
 	int sysctl_icmp_ratemask;
 	int sysctl_icmp_msgs_per_sec;
 	int sysctl_icmp_msgs_burst;
-	atomic_t icmp_global_credit;
-	u32 icmp_global_stamp;
+
 	u32 ip_rt_min_pmtu;
 	int ip_rt_mtu_expires;
 	int ip_rt_min_advmss;
-- 
2.53.0.310.g728cabbaf7-goog

