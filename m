Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785924;
	b=O6uAC3Nf49rAycnL+gYiRRnKLDK9az1ALWbJrTj38ljArJ+x51waZmTZP8/CfHRthAS6
	 UZQVzGTlCGQVMpfYNAnbKlCK8Cgp0EBKkVmmlFGTcSruCA7kbhY3QQ9VIkMH45zkgu/a1
	 hKAFUGImpHaI5PfLiSxv/uwcgWSlxHebxImFbuq3cC3h9j6xiEzdqDVeppiEp4owUQ9sG
	 J4xxeL+p3TlmZ0cymB1ppafJTAJGztwngYoSlJ/EiYtHizdl7y5m6IRGVjr1p6+kxaho1
	 qQJrA/F0gVSeJMP1uI/qt4eMmFVJ31BOnFUulq/0PqIfYx4q5SkRnyBVLXn3YxrLxiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=sjjoNU4OK/n7KURPKe/oyQb00JhQCh4KxXbD2x391nA=;
	b=ZPPeCsNYa6j4xkQSkkkLsY0JGYA1gSOn1XyVUzvG4DRFWm15U32qGVCldr+3bRTE0Zp1
	 JehptPko+lGs+uOOylf9mJmhpTI+uz0U/D+ppBaiwSSraTkxCUh1Q3ICiaa0W73Ovk8jm
	 MwJzwG2dbdHIxat3H9BmALExzFoxsh7/FdzRnMpw13/ZbTLRYlRq3OqSk9VWf1EIsoyq/
	 sm4GNM8+dpNYJQyytywB0fF8lhUCGHXppFk7vxWZwanTl8Jqg5oFpqvhm2VOLnWbZJRqc
	 tpvIwG0gR75mVqzFoPPin6Zac0wO/ADtjYOqL0YiFzjbcwsTnYriZgAccQO0zz2/4Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxJVZMPk;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D9606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E43D9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxJVZMPk
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so929033eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785923; x=1794390723; darn=vger.kernel.org;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjjoNU4OK/n7KURPKe/oyQb00JhQCh4KxXbD2x391nA=;
        b=RxJVZMPk5rl+rmSGI0jnSRe24VoOJlo9Z79OpwPLtFXqQaDaA1fpuBmNyDS8SLLv9P
         OFbQ22D6sSuP8mBG+wuaWeF2qdXuEJt65kDxVWT5yNskpacVqZkDHghfuxlw4CVfqGJ2
         r7eZj57E6MfPKc4fTBDqpD13klqoHbTWGkwXEW3QDDDJQqjFO5ZWsk5zTTLOSy1q3iYP
         x+NoZMKPrn4OBNWykJrN+s6mtGeGRE6LrPy+4pkrUzNGin5Iri5VWhSNqfdnnZgQDnWE
         8D6eU8MvslJpRafTAvumrdeS17lKOZ+v4mVvDjADjuxXXlHyOTU5tPTzGZtQhIIUuRYG
         wSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785923; x=1794390723;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjjoNU4OK/n7KURPKe/oyQb00JhQCh4KxXbD2x391nA=;
        b=HXNvWrP+OJFs2QulPGZmM3se5CZWtGFeZ6/2iZZt3L4he/l1Ter0ExpnfqlhEctDZF
         JR7DUEPQdS5s40UfBZiDdC2WPXjx1kL9CgAid3YMrVVyyQXkRO7g5ECMpZU4R+iaoYNl
         fmzEVJA1fXUYKKqxtCPESeJj8DQH2Om0TgsMNXKn6UNegxpPM726yifxdutbQSh935UW
         AaacTpbwEY6/uuZSxToM6Q6lekNtZXlY90AXUJNNIgxghM+68D9LGaE0g9InqqOCxlP7
         3WWaF7lK1hebcfrOqc8k3BHpAFoPLYbQ6391lQ8fBJDoqVJNzCiR8fFccSTzrCF/cANE
         ZPUw==
X-Forwarded-Encrypted: i=1; AKwUvBzn9RKCZGICXZaK849JAkvJnAEnJcVKHxxZT2n09RkVsK/Hhlua2fXZYWei78Wp3N7lrZkmcUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sflW8W8JssNYxqR3N6/OBX+Z5ymTCOEJOd7HQBFkVBGXnRnzQ
	iqW1GEZg5vO6pKnDG1c6Gdaam8z96KkwChc1Qm62h721MRdxMEM/ZW8sqFjQKekXdLSSHLfc
X-Gm-Gg: AYBFou06srO+bPE5XbXIKbstGFaetOHBrH/qP5MZl90bU66kArhvbGbIXbMuOQDglmb
	p1vkHgbB/thgAnG6KmVDGibu+LXd4hwRn6IgWyVCz+ILbpVeWGFQNm93GQ20gPnFStgFqqXF7aX
	6m/35q+BwyERxUkuMHaUhzeiQuSVerI7OBKmeiO2outmEWp3VhKk7UJacobY2FcqnRrqDt/kzV9
	SBXViqfdh/DqIwmdUbytEA07dvVJPMd9fMyUov6ft6dWXmIb3AlVMYqOND7BUxFqt+q5m6oCnjs
	BbG7ijQIZ6UIBSXPPSMOBdrsYlIg6oC9alSHLE21J+CBue2jIa1kElc6nh/qR3Jyn8EFX3OJoNU
	OWUjFus6YZkjV1Wxcp0n+aYvKBlX9TSkbV369Zt3943htcWRpyK8/ReHJIBYAbyv6wLyR/8I6yM
	gIxFPxdXsrJLqNUQYmxLF/hICpwb3pzeUqvC3DPpPHrDiLbdXgnetR+Su8a16UL7SizdIOHvoZj
	H9PohA6NB50VRnRuDpQzA7sxYxRBzZWtF/aAwTlQONg03qeK06Hi1W7d3eRDyT/iOzoG2I9D7lz
	k/W37KDaI+i0fF3N98s7cRpg2Fx25nI3BnHNJXPih3ah5SJ0KPI1Gql6CSG1zQDCdedR8j2ZXpy
	kL2bAnFDpNy0T
X-Received: by 2002:a05:693c:62ce:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-36a42362451mr22493017eec.11.1793785922864;
        Wed, 04 Nov 2026 01:52:02 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm7911411eec.23.2026.11.04.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:52:02 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:51:49 +0800
Subject: [PATCH] nfc: rawsock: prevent TX work requeue after socket shutdown
Message-ID: <179378590950.74297.14503648624087894519@gmail.com>
To: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com
Cc: horms@kernel.org, lauro.venancio@openbossa.org, sameo@linux.intel.com,
 linville@tuxdriver.com, aloisio.almeida@openbossa.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

rawsock_release() marks the socket for shutdown and cancels tx_work,
but a delayed data-exchange completion can still queue tx_work again
before the socket is finally freed. The new worker can then access
freed socket state.

Check SEND_SHUTDOWN under the write-queue lock before requeueing
transmit work in rawsock_data_exchange_complete(). Allow the completion
to clear the scheduling state without scheduling new work after the
release path has begun.

A KASAN test with a deferred NFC completion callback reproduced the
use-after-free on the unmodified kernel. The same injection-assisted
sequence completed without a report after the change.

Fixes: 23b7869c0fd08 ("NFC: add the NFC socket raw protocol")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 net/nfc/rawsock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index f7d7a599fade7..efdbd512d4600 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -168,7 +168,13 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
 		goto error_skb;
 
 	spin_lock_bh(&sk->sk_write_queue.lock);
-	if (!skb_queue_empty(&sk->sk_write_queue))
+	/*
+	 * The release path sets SEND_SHUTDOWN before cancel_work_sync():
+	 * once it is set, do not requeue tx_work - the socket may be freed
+	 * right after the cancel returns.
+	 */
+	if (!skb_queue_empty(&sk->sk_write_queue) &&
+	    !(sk->sk_shutdown & SEND_SHUTDOWN))
 		schedule_work(&nfc_rawsock(sk)->tx_work);
 	else
 		nfc_rawsock(sk)->tx_work_scheduled = false;
-- 
2.34.1

