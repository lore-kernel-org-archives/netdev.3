Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307033D503
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254998; cv=none; b=rxRXjn9FTZnXslnf51JOjt+GYNt7W+Y7IKe39dlqi0zxW2hNAXuj0o+NnWOlyGGjVO/qQIPUFnDEVpUxRXvBSlvlOU0T5noQSKuYxiTWWcfUsdDIPIU/2dks28PXuWelCfHqQq3RAuRqEoWjS8hId7GTSWJQz8OXMsXskLEDmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254998; c=relaxed/simple;
	bh=dCROJAzjbJ0VyYGg4LuwxJRd4UiBiVpUWkEdKbWJWQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt+moe21PGQN/gf3YXnOw71u5TFLLJzA2eUZad9n4bHaLPhKI7MIY6a2U2EGJHOfL+6aE8pAi78LBPCBamDzdRTUaZNSE2wykvnMKYirjPDHA/mMjb+70yaez9qXoROWXlWBRZUn0uoprJ5XqASxA+TplIh1+zdtULyatnHy/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=s4JDgoLB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="s4JDgoLB"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e08baf860so4247049a91.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785254996; x=1785859796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5LknHu9GV0qQrEEql1FWoKl28Cq0/YJtBdNrVp7I+OY=;
        b=s4JDgoLBEYdSLOfOsbweVAdCcXp8V4YZZTeoCTuOx/McPrR0nel5/6bawaChbL3toX
         n4T0jBN2YbHAimfDqgBjqiSKNwSzBR8NF9rY0Gt/0cgu1RozlOxAHniwksK9zGigcwE/
         Hf8lsMxjgC7KyM+TAyjCd3Pmtx9G7MMofyu/Y7SK4LzOhUQ34ADU89MS9LT1sC7tOBHR
         QfZiWs7cDDDyJQBYn0l3MhhkRv9SL5A8m/5aBVz8OSFV61AFXK/AYgYlRPStSUk6jnLQ
         6NozxX7u8xi4fNOOctf0WKXrVDpRFpiBi3/zAI62Hm0GgbbWWpxG/tSAI1x+2StxI6l2
         PYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254996; x=1785859796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5LknHu9GV0qQrEEql1FWoKl28Cq0/YJtBdNrVp7I+OY=;
        b=czMVuxHHHQklm1HB3DPTdwOSNjNKvQM8Zw6gPG++rKRCun/PVtX2DkD3Mz4zAoRd2I
         FH0d3l2JZZhV9KG8i5BFHzSrUEUFrzWxyHQPLEHaSwf3K3XF+CBvRGuwvXhEE2Pccu3p
         UNiwZGDv6DmkNru/h7RRPSfTM4AlRmNI94xDaj0DmYs6ZbzVVMjnQYvaCxLzzIELUN1b
         4Lx2ijd71n+TXHTGpn+A4FiY+pd2IZ6szNTSLiwMaXmoGhvZI77QeGLJOTbKq84tBqGv
         yniOJmTyfrBZ0avpGe8ReIg9I6mZRILYCLCdZ2YDM0ldEKeJoMHtPAMoHkUpnMGYbOHs
         C6wQ==
X-Gm-Message-State: AOJu0YzJ+FbihopncaZxZRKK2L/U4ODW5hOPwG0TXl+DJmPFpB3NaU/7
	y7SStQiHpenb439iQt6WPYjg4ZZgH8HRE8BfwPZK1IFA4sT4rm1IAWA+ZQCLlxKnuU/B5W6eLxw
	p9oAp3NRBbgW9
X-Gm-Gg: AR+sD11Y05fWn04yD8YSTn961sUvhBdjOHqRFgBK4pJ5JUSHrGEhtC7UQHxuvkhORwR
	bJNdOsFMwwudXGk9ZfSyqCTj7uige0Qc02zYxHHI7AvRkds4aD1EthXWAK9saqQDo8fjL9N9Mz/
	kTPIg8WobhXCKyvX5iZaPujhL2ZvAHsB7pF66yE0lfWYobXYN8fZy7OyAZ3EgEw7J47NYBHMLJR
	SsACQ7bG2q9WLeGyJW1gxQ6NmhWmE6tHfjY5ohSOidGNor7DjcRRxaDTsAFy1Bt742VpN7RaWqp
	RpbwP9ecIYy8p9Ii1CgJX0lIWn9o68Sa4XNbQISc0FrCYvPrJM6o2lwOjrnQrA+Ot4OwfbQRc2A
	gaGxizjCxRJFHlV+75W/ARx3bJ2MQQMX1v/Zq/svx6lGtKDr5R5/PEqbHWWKesSGYK5ixXHOZIE
	oCboKRbVmz9WU8iTunMwGbio92zQ5laZMU4bUs9BFo6Q==
X-Received: by 2002:a17:90b:4490:b0:38e:447c:9a15 with SMTP id 98e67ed59e1d1-38f6a55f949mr3146313a91.36.1785254996618;
        Tue, 28 Jul 2026 09:09:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f12ddcesm172913a91.7.2026.07.28.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:09:56 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch,
	willemb@google.com,
	linux-kselftest@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] selftests/net: psock: Generalize psock bind
Date: Tue, 28 Jul 2026 09:09:26 -0700
Message-ID: <20260728160935.4128982-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728160935.4128982-1-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize packet socket binding so that types other than ETH_P_IP can
be used.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index 3313a15e0ca1..bb9a9cfdbe95 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -171,12 +171,12 @@ static int build_packet(int payload_len)
 	return off + payload_len;
 }
 
-static void do_bind(int fd)
+static void do_bind_proto(int fd, uint16_t proto)
 {
 	struct sockaddr_ll laddr = {0};
 
 	laddr.sll_family = AF_PACKET;
-	laddr.sll_protocol = htons(ETH_P_IP);
+	laddr.sll_protocol = htons(proto);
 	laddr.sll_ifindex = if_nametoindex(cfg_ifname);
 	if (!laddr.sll_ifindex)
 		error(1, errno, "if_nametoindex");
@@ -185,6 +185,11 @@ static void do_bind(int fd)
 		error(1, errno, "bind");
 }
 
+static void do_bind(int fd)
+{
+	do_bind_proto(fd, ETH_P_IP);
+}
+
 static void do_send(int fd, char *buf, int len)
 {
 	int ret;
-- 
2.53.0-Meta

