Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312228;
	b=nByvNi37Pmt3h9q+TyqQ/jiY6pUlgtAV5xEz9Jr5676R9Mu67smn2ULquzRk//ld9oab
	 7vFRL3dBw+H6tWYjKaEeEeUfqHd5MnmvASFuUs1+CNtZsZFHw3BwB6hzDTWycZcePyH6I
	 relJsngpIV4MRTvptnDuhxR5Nc5VGiQaCd9LJRUmrT/Gpo4GTPTZhRgE4YhcIJGkQH6nj
	 ULn1j9tQAbbDOP+5jLWDNkWWE8eiZSRCnqOKBWwa5ce5gsNUzSn33szpZ7YNd2LY5l2S1
	 k1CjjF/2Z1spCatNFW/5hCzmb/Tsba8YQDzdIgNVTZtvRd0shXSrK6I2pbJiiAZUjCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312228;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3E/3zyMD+uPVnyErCUd0kjVVb+CCwIBN0VKu1A3yz3k=;
	b=pjmR6XFjW8/hUnF5jz+LsSqNIbVI7mSNwQNJmIfWzGO+OmWV+7kKUyUxc7AWoQD564Ii
	 dFIJFIl1VYuPNvBP8rm160oQMG3kq3avOdkiaaypiO2Dz5nEJb2Sa+s6GfhnmpLAH/wKm
	 4AzvPtw2EBn83mGtYP34pwBqUUDLQbvZv9DbEqbY4RvFLKzsaPea6bMd8yUy/5vQ7hLIa
	 GNLc6jhz9wi/Ljw3+sYQcpJBaIE1aEe1LhrOSO07jzSNdT0dskATtB3+pn9aB0tiOKXaM
	 k81Xprile56iUDDdRokL0c13HVpOAvXebpvLu5OPnfF9stXBydE5iEFOxh09jP+gxjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="QZI/xXHn";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D995606A330;
	Tue, 10 Nov 2026 12:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D995606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QZI/xXHn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QZI/xXHn2UryHTaHUO2CJN2MDc023a+/qCjSYAdOIs8X7tsltxvZ3/DCGetBTcZYt0kTpefhzGsuw
	 Quj1f69Hum8VgLgKNQvdI/HyJAvTCYKVz6D1WfhQbQX+zevrvcKn88Ktn1OT5mM5U4k2CY8NbZUdnW
	 Um3Xwk5EH7oKqzL4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af3081aad1-aaed1;
	Tue, 10 Nov 2026 20:03:42 +0800 (CST)
X-RM-TRANSID:2ee16af3081aad1-aaed1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af3081dd3e-b3c6a;
	Tue, 10 Nov 2026 20:03:42 +0800 (CST)
X-RM-TRANSID:2ee36af3081dd3e-b3c6a
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	linux-kernel@vger.kernel.org,
	almasrymina@google.com,
	yana06070@163.com
Subject: [PATCH net-next] net: fix token index wraparound in SO_DEVMEM_DONTNEED
Date: Tue, 10 Nov 2026 20:03:31 +0800
Message-ID: <20261110120331.13661-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

SO_DEVMEM_DONTNEED computes each index as token_start + j, in 32-bit
unsigned arithmetic. A start of 0xfffffffe and a count of 4 produce
indices 0xfffffffe, 0xffffffff, 0 and 1. Once the sum wraps, the loop
can erase an existing low-numbered token from the same socket.

Skip an index when the sum wraps below token_start. The check runs
after the MAX_DONTNEED_FRAGS test; skipped indices still consume the
1024-item budget. Tokens allocated with xa_limit_31b are unaffected.

Found during a code review of the devmem token release path.

Built net/core/sock.o for i386 and x86_64 with W=1.

A temporary UML module tested copies of both loops against a real
XArray. All five cases passed. The wrapping case deleted one entry
with the original loop and none with the guard.

Fixes: 678f6e28b5f6 ("net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags")
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 net/core/sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index e2401d7..90f59b9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1115,6 +1115,8 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 		for (j = 0; j < tokens[i].token_count; j++) {
 			if (++num_frags > MAX_DONTNEED_FRAGS)
 				goto frag_limit_reached;
+			if (tokens[i].token_start + j < tokens[i].token_start)
+				continue;
 
 			netmem_ref netmem = (__force netmem_ref)__xa_erase(
 				&sk->sk_user_frags, tokens[i].token_start + j);


