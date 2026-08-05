Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FE388E40
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943129; cv=none; b=gWYH3qGswnnD+RMRUq8l2KMhGWcc0PmBH50y/1ld9UHx3P9ZDqqCm/2T2dAEtSPYc8cf/jJ/jirQ44gJgfdectVwnP6RPzpk9SexPB6qfS9S1o3117triDeBUHchPcylJssq/t+WAI+0Feh2C6QoWLe/7jP7slWQpKTMiUQpElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943129; c=relaxed/simple;
	bh=ZZNYP0Dgp/aQeD7XlJY0GnewzQjGWhFzJEDtuyuCt4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftYK6PhtXuEEKwVaCub/+wVICVcKRJXCuvMii7t1CXrQQD/3meocO1RHXiAphltCXZ/5429RA8muYOhG1Mmx+2GqhDY1lcfyZDhxyfVa8hcAFeay8OPcY+qai4AnWY+VNp41929wbMbLdGs5KYOjiqGVTUaNF9SO+UdaKhEEqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shpbWh/E; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shpbWh/E"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90004d2f7b7so11568316d6.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785943123; x=1786547923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTY7AKVH6b+X0UAUoNZRDghBXWYJrtfWNLvl0g5pK5I=;
        b=shpbWh/E7c3Ul9g8+bNPLc/bv56FjFUwywxVNAb72yh1phRSCxJHmIFitqFNzckgQ4
         0axB1Akn/lhn+VydYvodNQpYr3KdhOF+FCw8ElX3pFuzJb5LF6b7rE9K9gQ1hDxw6a/K
         10r0G3ayG5ozM+gksejfXoOfvXeVyUjPHPL9O+4h3qE0x6KRZrlDWmwnrZh0GAbuCsgs
         cxEtLFxOKLUcrhkuA6oUEEYKeQ1yUDqJYRtCsPyPMKVYkAKvrQYq2CnY71GlFZcSrr7e
         SrvYMIxkDm9T1lRxNGMYJumzfTkfNT3XPikkVirQhOpGLJCe/z+s92rIyZLcOtDcMy4s
         Wt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943123; x=1786547923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTY7AKVH6b+X0UAUoNZRDghBXWYJrtfWNLvl0g5pK5I=;
        b=JiRzYMjGJVVgwq/h4jfCLWZwJnntFuGul2XurPlE7B9X/NkPYEj3xFClrH/Pe14i6q
         Rhv9hQp+VlhKMvx3Cnhx4jaPhrAujZRx8EbFmj9w66wWUfA/xHmqEH8lfl/M+m7C/L7N
         cfV3MTV3PMz5EkNCCD9+3HNl+M74NhPSvpL3OoQo/RBhiY4M7fSCDCYoJLIGZbbkttIv
         j3zjCu86Oo9LEedSyeigZo121ONaMfEEReaos4/83IIAQx7qn7NXKDtnFRob5bzrcMJr
         Id5RKQhP7Ua+f2rj7mAIY3nsBYrL0MMwGtAc85Q3qEvmmMIJ6mHQvdOuo6kuke6QNM6L
         ievw==
X-Gm-Message-State: AOJu0Yz5syH9QNmUTbXFUiWNzGl5iUhTtpH2ZdwhPrUf8iiI5Cr5YMGe
	4hd9KIOedqhfbcJHhWDl641iCLObI20Wor+hnTqwLDx0DtnDf58DhH4uAWfy7g==
X-Gm-Gg: AR+sD11GDL+v8NI39E135IgnkThc5VmjSli6fw81L9kLivho3ohUOXmB4iuNMYHkUjm
	HJfjkAa4geOhUq81HmUlxLcuHnkSAGsl1e+0FArwDbw9+qiLXYuQsPjOxFmLktucqieFWroWeIK
	NOBD8abmJM3Hhihgx5gmq9wdUWFnwvOdbT/h42Vn3fC4U7ull0hSvgylRUwsBFYkQjhSTuioJSm
	jR204sXgL8uemzMaq8+GUM5BHuhOgXHar6f8PCgB4uiphEPyhzx+UhzlbMVLkmucH5WsIcz0EA8
	KU7vul4qg0h0TJj/hH0P2dt1fe7oOd4TCHTiCrWiFdXfhhNaYC/HdTgnmQ0X/nX14uDmeYp/yI9
	TeAzyc1pc3DJ0SCnhqE2tt4cCE8fvK/ZSR84LbwA4qxbGweSdiWEse2D7BqASUZr+6XcrMj1dLi
	Et9w95/UzFngdZRBw8KOtTlZYyjKRQVUTbd4Ok+JiiFv8mXFL4c3s/PU1pXbrUZyuH6eStqWyKs
	wiltQSRf5c1ni4q6gD5mc7EObwNr0C9t2PXL6XCMJdVSBPGsKWxM94EyAiyKD6tgvbT/N5Lhsly
	p/KuQ56bmQG5b7c+MyDP46uPcwI=
X-Received: by 2002:ac8:5c8f:0:b0:50b:48e3:47a7 with SMTP id d75a77b69052e-52ce60853d6mr82421191cf.18.1785943122785;
        Wed, 05 Aug 2026 08:18:42 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce894e18asm22023081cf.23.2026.08.05.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:18:41 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniele Linguaglossa <danielelinguaglossa@gmail.com>
Subject: [PATCH net] sctp: clear control chunk transport if it is being removed
Date: Wed,  5 Aug 2026 11:18:40 -0400
Message-ID: <7e1168cb722132152a29d47e5eafaeac4a3bf6f3.1785943120.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_make_heartbeat_ack() caches the destination transport in
chunk->transport without taking a reference. When src_out_of_asoc_ok is
enabled, the HEARTBEAT ACK may remain queued on control_chunk_list instead
of being transmitted immediately.

If the peer transport is removed while the chunk is still queued,
sctp_assoc_rm_peer() drops the transport and schedules it for RCU freeing,
but only clears cached transport pointers in out_chunk_list.  The queued
control chunk therefore retains a dangling transport pointer.

Once an ASCONF_ACK clears the suppression and the queued control chunk is
transmitted, SCTP dereferences the stale transport pointer, leading to a
use-after-free.

Fix this by also clearing chunk->transport for queued control chunks in
control_chunk_list when removing the transport.

Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Reported-by: Daniele Linguaglossa <danielelinguaglossa@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/associola.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index b6ac0966420a..5b0ae616e1ff 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -573,6 +573,10 @@ void sctp_assoc_rm_peer(struct sctp_association *asoc,
 		if (ch->transport == peer)
 			ch->transport = NULL;
 
+	list_for_each_entry(ch, &asoc->outqueue.control_chunk_list, list)
+		if (ch->transport == peer)
+			ch->transport = NULL;
+
 	asoc->peer.transport_count--;
 
 	sctp_ulpevent_notify_peer_addr_change(peer, SCTP_ADDR_REMOVED, 0);
-- 
2.47.1

