Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5F322C73
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674003; cv=none; b=NVfGIoNqJpfK6rfd+O+y1gexrJHebhSonK/UsfzLViyQ1C9MIZvX/Ny27/AzAVAzqdcmDKe5I0Tf8uRa8/xAvrd1H/wuVLPQol3UqHroOaWAaaT7n/whS9sdz82eoxSHz7xH5Mtl3d3opEzzruDWwDTDDskfESRj5m+GbPUdksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674003; c=relaxed/simple;
	bh=NacG5cTLZnMoTFMKGkXUWS21Go8psLbEQUGq1hcBAqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVj2Ej0MgYt/zz1yYiEM9KZ91qkjbkMttzWTZPnakI4PdE9RuEP+LCJVxSqRQfVDqJrt9MKoumQHfoXfOmjPSz2Nilt1FJpK19YRCfrNysiCQJqEPc+qAQHlPLBRIxMTSKt95ZlbBcuEmzYetC6NotFM8/UOIKGYjQzdxs4/u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acv8midS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acv8midS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso157555ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787674001; x=1788278801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+LvS30Zd8SOHdLDywqVL5DIS5PmAcQafkk5iXhWMGs=;
        b=acv8midSTSYQpaIJNaC3X3n9MVIh/yqTMq+I7rqHNXWJ+3zmp6tLcNqgulfN1rzEfZ
         CFFipcHnc+uMyV+Ay2KHX9veRL1URwvTz6orHtAM5l//9vs5+YYAOT84J4RBk0fZSDt2
         YuQtLc2v3A5HgncWNdOnDcMnG+6lhXR/MTeC9497N3RkpW27wIQLQfd6S3HtggDbeCVk
         Dt8g19UTdN9w761u7YcqmXbc5vrHMRCR9/aDCl1mlJ39UGeFzsNGsPGacxkJNZgPXlUH
         g0r1LPC4wLC32VFOm0VJFCk8XR27+S/7z0DDmC57kCt7kWA7xzZwFXyQ2g4/okB9i6kq
         Clyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674001; x=1788278801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+LvS30Zd8SOHdLDywqVL5DIS5PmAcQafkk5iXhWMGs=;
        b=XYrazHy2ORHKP4cG2dcMwLoZDHwCNUVYr3LyQkSPDNCJNRcLWtmiKxmWrUjKPJ6sJq
         VReJByibim8ktlzNAMNwOpQ9x7h3sY5WlnGzfqZEZV5kRVY6IIsJD4Q9L2mAAxDKnCUm
         DswbTWelnzdogu+dZUm5M5W9fKfJt0KRgO9wkBSpd7xWV6eyYJbxmPgq/dmzoiVwCClm
         xbIOfT++a3eh2AaYqprwcGKAl8ZMZHdmu6CRkCgDr6lmXm4vWLNvpTmnqhzmrnIbRBvA
         GixiF3CaSm7kKGg2DSA/Nsc3qPhdsSzo1BiTFfQc9UccvCQflUPxmZlDNASsZrZ6Aq0v
         +SCQ==
X-Gm-Message-State: AFuF++muK+cfBRLLgljDrfNq98Bmz3zF+k99zHFypECkHeHsFt19gV2H
	cDBa24DfxjunuhRSbeRh/A2zUzxUu+TifoG144TsYMiDnBPsQB71kSjT+F4CJg==
X-Gm-Gg: AR+sD10uHUkQ14r35WIEwD3zqnav59VHfNRkawGxZqUenrNfAL0dVnhN/+rj1vEGXJz
	7mFkdoY/OFfurUgMTXvms79ggBJq+UCnrzjCCGImaAT4WkHAWmKrIe7LsupSk6P855JhxQIZQOs
	cTzhW7++fYZyYYT58zVJIkxLtNysBWFDSu0D+3BU4xfrQ59KIToLvFJlwbzUabvOexeq/vHVU3c
	ATzbBN1Vvv9Whd1MKlvHDjddC6+EIpkOlXwmZofVFHmtEGTNC8kKMmvzBp3BDyn63tTQoyUewv6
	wwfi80zzHVFVE7fxSzU0lGoRawwN6yqDbr7IAyh/SWcQfQU09KcYTp+FVRNOwPxpswHY856Lr3A
	nKPHgbiuV1WQ70suTGAGO7jR4PUTsWBFNk5K7twtfGmBos56Erwy29IOVmxwCA1PWbbwIp3gUH5
	Iw6fGEIJHf8hURH2XwU9yVI7/VlzGYAAALXcO5291i+FNTls4y/JQ/R0b2YoTfHpPbNPEzOR2G
X-Received: by 2002:a17:903:986:b0:2d6:f988:398f with SMTP id d9443c01a7336-2d6f9883a06mr82994505ad.12.1787674001396;
        Tue, 25 Aug 2026 09:06:41 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c25c2asm387245ad.70.2026.08.25.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:06:40 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] udp: revalidate socket family before publishing an IPv6 cork
Date: Wed, 26 Aug 2026 01:06:30 +0900
Message-ID: <20260825160630.1888866-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udpv6_sendmsg() prepares the IPv6 flow and route before taking the socket
lock when a datagram is corked.  IPV6_ADDRFORM takes the same lock, but it
can convert the socket to AF_INET while the send path is doing that
lockless preparation because no cork has been published yet.

If the conversion wins the race, udpv6_sendmsg() later publishes an
AF_INET6 cork on an AF_INET socket.  Uncorking through the IPv4 socket
operations then interprets the IPv6 cork as IPv4 state.  The IPv4
finalizer writes a 20-byte IPv4 header into the 40-byte IPv6 header
reservation while the retained IPv6 dst routes the skb through
ip6_output().  ip6_finish_output2() consequently consumes the unwritten
20-byte tail.

An unprivileged reproducer triggered the mixed state on 12 of 10,000
sockets.  KMSAN reported an uninitialized-value read in
ip6_finish_output2() on three fresh boots, with the allocation origin in
__alloc_skb() through __ip6_append_data().  The same process recovered the
20-byte region from the TX timestamp error queue; one of three fresh boots
contained recognizable stale heap data.

After taking the lock, revalidate that IPV6_ADDRFORM has not changed the
socket family before publishing the cork.  The existing error path releases
the prepared dst, flowlabel, and transmit-option references.  With this
change, the serialized controls retain their existing results and the
forbidden mixed state occurred zero times across 20,000 sockets.

Fixes: 03485f2adcde ("udpv6: Add lockless sendmsg() support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/udp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index fd875908ac0c66..566c634a5a5945 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1716,6 +1716,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	lock_sock(sk);
+	if (unlikely(sk->sk_family != AF_INET6)) {
+		release_sock(sk);
+		err = -EAFNOSUPPORT;
+		goto out;
+	}
 	if (unlikely(up->pending)) {
 		/* The socket is already corked while preparing it. */
 		/* ... which is an evident application bug. --ANK */
-- 
2.54.0

