Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747A2FF652
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252120; cv=none; b=IzWuDN42eARI/cNP3wtZAVyZdwYY90ILuCMfRSzjkk4XgBazxbIYXVDUdcDu5iMsgzpt8bqMvXLEavH3aMU1xoZ/SDtDZ105rzAZipV66n21iGRBJGxF7kstbyz40gGZyBtsgP5LwNQdb9Kfkb54VP5KlhQUjHWhW18+yW0otZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252120; c=relaxed/simple;
	bh=23Wx/y6bgdBrY400apjtuFh0NVogwhDYnUBUv8jggws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oVDCfXeCYh/i55A4qzX4OWH2p5LI/5F0yUYee0yuV/3gWCSHnhN+8xH7sYuxghrCH1cf7PeH2VBJLgD+zFaIJ4n0SLLNJCPzARd/y9HrOKJDn/g4WhRgpLadSwNgmm65CGZBerUGCFNQlEgRdyG4E9cXemeEhC2CEjFQop9gyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqsQ5+54; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqsQ5+54"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-897021ebe91so238621706d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252118; x=1771856918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmT0jCSsZiu79Mxe3PzRsOd/TDg6LxSRmVQtzochTmc=;
        b=eqsQ5+54uNLwfQ9X333eQ6urcCa6qZ1GsZ8z8F1VE+48W+1/flwf73h35S1vJHNYUY
         I3N94OkdWhzQCaqinN3qYaHRjiOlVGwK17I+E4MGA/gPmNcR0wU7rsrhlYcSpysk5FFb
         T0uT+sL2Teqt9Aki2JmufS8mACLFE/1+TbIkmlmQ4Sv1UP8Cb0d+i8dygN9OTCD2mqGd
         upXB673TKRDmsDHqC3eU4AVeuznYPkydqm7GbpRyb2+10riHfAv+DJU+m/qRBcMqJAMz
         W6RxW7dtYoq9NGbEoX0Tnw7RbZB55Y1AobUhqfCuzdpaInqfM+LVKaTw+gRZfy0hme72
         d5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252118; x=1771856918;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmT0jCSsZiu79Mxe3PzRsOd/TDg6LxSRmVQtzochTmc=;
        b=g/E/OgfiSV1saEKM2x86mscyh+hJZ45xwxeJbU8VRl4Zxovu3U8frVzAPYd7StSu3N
         Pv5q7hGchTOdngUIU+E60Ue2v9bTLFRbB0aWTFszt0ONBK2Sx/nY9L2YVAhyI7rNdYI6
         0wqhju0ckmLoXgFsEoVeqtREgbvsz4iI/PFN1yjfMXtJtF3wuClfoZrJ1let8cLZwnGl
         G/Xfp548uBywogpWscavbMIbGikK/JmC+eYGhHUba+tYVDHeV5il5rc9jjJBIUiQ+18K
         yn1ZdQPSp9FdfviFLvERcjsMXTk9m+FWziLy/U1RZy5uhQI15sS9ERW3xCnqNH6pjmsX
         HeFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZTwQKMT2jX9rhxKazOKYpW+/ACUj2ScziIFk1r3+rD9HVXmzxXnzDb/GN2tuRAQGDbHqgiDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXrczKJkRF8+yOg5GPuPLT0Mby3jERW06zSVYGytHphWuxjl5
	9wei8sd8YSVhI5fnRFkFrOhLql4bK/xzvQ7n/mCHo7Eld7xl6c7BvWzGe7TwiqHn+CgtNseZ+fg
	RUeYRb2LWZgFq/w==
X-Received: from qkcq2.prod.google.com ([2002:ae9:e402:0:b0:8cb:1bfb:38f4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:ac0f:b0:8cb:4cb0:8d51 with SMTP id af79cd13be357-8cb4cb091d0mr822127485a.61.1771252117712;
 Mon, 16 Feb 2026 06:28:37 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-1-edumazet@google.com>
Subject: [PATCH v2 net 0/5] icmp: better deal with DDOS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When dealing with death of big UDP servers, admins might want to
increase net.ipv4.icmp_msgs_per_sec and net.ipv4.icmp_msgs_burst
to big values (2,000,000 or more).

They also might need to tune the per-host ratelimit to 1ms or 0ms
in favor of the global rate limit.

This series fixes bugs showing up in all these needs.

Eric Dumazet (5):
  icmp: prevent possible overflow in icmp_global_allow()
  inet: move icmp_global_{credit,stamp} to a separate cache line
  ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
  ipv4: icmp: icmpv4_xrlim_allow() optimization if
    net.ipv4.icmp_ratelimit is zero
  ipv6: icmp: icmpv6_xrlim_allow() optimization if
    net.ipv6.icmp.ratelimit is zero

 Documentation/networking/ip-sysctl.rst |  7 ++++---
 include/net/netns/ipv4.h               |  9 +++++++--
 net/ipv4/icmp.c                        | 17 ++++++++++++-----
 net/ipv6/af_inet6.c                    |  2 +-
 net/ipv6/icmp.c                        | 15 +++++++--------
 5 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.53.0.310.g728cabbaf7-goog

