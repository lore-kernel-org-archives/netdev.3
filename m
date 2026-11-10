Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350578;
	b=CnnYuwRpBFV5Jb54hbUAXp2+FnQbjp94ugH+5FMzH/NdyWZUhV+baaPKqfuKEF2OgHzE
	 dFWga247D5j5p+N0sbV739LYfeYW6n8tk86ADf6BQMs0VypIxGpe0o9op9IoD3whNZf6d
	 sWUrvfS+3niDqSm7QJ6d6kebMdMuPVbqCsOi6MCBS3dPqOjdvJ491cUvbKwg2TBK9pLr2
	 ACmVd9xQheaOEWQNhLua0/AvhTAY0C6quhhFR1sseqC2D/R+NuefiPSg6u3eTFaD6ir2P
	 YQZFIBXItc4iJGaZD1Y8es6R4JMu+MWmAVxQXAzI6vtJvPV6joeCP59wvQyVVOntmKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=65ccBi3rzxm73dF4Hh1JDA1NcutcYotrBjNv9MyOyhM=;
	b=2Z63nGjoCUd2RORk1uDdtVKooOkBxGLuQCk8iXkjOxJQOazr0bj2ZWBPkjlOnPSXAImT
	 XAaTJkuxpOE8uFK99ROMJF3Tf+w8zoM6LeHtkCQocrXUV21hSguP+in2akep2Y6/ViaNc
	 xQ+5tqRgh1LiYnUDoTygIr5rJD2h981atSNMzTR26RCbDRttSYNDCxnZ9FDJ4ypYhn6BO
	 t5PwlGzbtahcrabZJEpBnIiG/spUSyRWMCr1IzNf/bA31pGwet5KYd2mjFaZUxnSD9O1K
	 fTjFj69i0QSYWZ06YBztNKdcelASyasDS1VOul6ox/JQEH7FINLaA43D0MEfosN+tyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=theori.io;
	spf=pass smtp.mailfrom=theori.io;
	dkim=pass header.d=theori.io header.i=@theori.io header.a=rsa-sha256 header.s=google2026 header.b=B97Y8h0+;
	arc=none smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D4606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6D4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.a=rsa-sha256 header.s=google2026 header.b=B97Y8h0+
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48df951fd31so1048795f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google2026; t=1794350575; x=1794955375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=65ccBi3rzxm73dF4Hh1JDA1NcutcYotrBjNv9MyOyhM=;
        b=B97Y8h0+lfe0/AHj05Oi62WQcXmqYayJBwOKgM1wVexj6YwUmIAqvFuBFFwUuqlfgS
         IcISOfys3nOJeliQbQCcJI93jcdbdCp0miw66BPLtx4h+/++Za5uIfBKuLI3ATz3lC3j
         HeqMIeq50joZTvZ26NwuKH5VbWUCHE66zQK6M3eYQ2ECiTJi8//6KaCbID4zOxfEgcu/
         teqJcgi6kRX+vyvKE1n6iRdOchyPXoxjB5BhNTAjzDzu5FJNS2/I4f8zopNLKYtM+VV5
         ee0+gKenqyZmr7UVHrh0ElNeP59/hS3F0+poENrwM70ne0tofjwHpS1Zkci6R7Y/Ok6L
         jqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794350575; x=1794955375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=65ccBi3rzxm73dF4Hh1JDA1NcutcYotrBjNv9MyOyhM=;
        b=YUYabKEehyiV6/5WU8gwpYsFia93dEavcbRK+6Roo/n8qxETkVCFODtOPl7T2W8QVw
         1VfFOb7DB7x9rPdqd0uRv2bhwS5GBf/kZPFWMD7TbH5/DzUKkO33uDZ/tenajr/8XIms
         QGZmYiSowk2fd4d9kUfjeujDFz1JZDfcDNMgR/rnDFFLRcKRz3q/8mOQspvgltsm+UYP
         NDKDn0jWOlD6otUo6hCa7OuGT9ADB57pXKotc5+G9N1Nw6knXtbZjOQN4aOUOAcPQom8
         7db6Fq4YFXfYH8C/ei42VVD5cluoMkLfcIwvnhbjyaPMhHCTXJIALTP2SW/A7Sllbaw1
         XoPw==
X-Forwarded-Encrypted: i=1; AL+hErEnBCoFg7dBt01dSakeyVZgAXwsuSi3tOjdkzIbMzn0TTrZLXXEjV/13eXvMBgRkPWX7cDVSM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lNuCvXksvKtcY5akx8e9s8P3p+hWKarwPxn4dqeUCol9MEC+d
	fa26/j/36rlAwTU9anlb/ecffzAWdw7mPZAUUE9CiJebOtiZHo72m+fsxfWomvumVl8=
X-Gm-Gg: AYBFou1dVU30Yx9V9A2ZmLUXR9A2UIIPtt312ejZTCiCMklfcpLEH6rAm8+Rb30SBQ6
	kNBNozuXJ4QD8taFRPrgNGMEifazIhfU/EwnM85zTKDJ6XsR4HKzNS6Blv90IdsjlOb2F5l24cB
	OQTn1DvfspZXCCYfXOmCX5klw14xx5l8Rg2cycAloxvXRYu5gPx2twQ1eWXBTyOG5ACsXvLRK/m
	qexFjJmW/W+wNvNfVC2vhYo/rDUY1ybg2f3LpBPaB24wE99OqRHqv2NPtfRV+Firuj1dfdKu649
	+c2hHO0NubGlrX7lfPocEknYkPhQL6MHqmUPBUozpxXJQ/iCVTdI2mgWpiAevVFrihUJONbbklQ
	pwWo4M9xc83kgBH5c+G67VM7kjELuQ/R9gOlFhH0JZGxHU6pBK5dN4xs+8nA1daPlXdlsMUiDYi
	lzcrJYdQEM4CFQXpXBEWR0ynyLm3skDT0xTqd/TjMb8fgXSfrWA/xZpyHoROJ9j/fqx+uvWnvC4
	vgw1EcSH1X6vVQwMQSFLVzNShBqncMLSWNtnl3/IOQpXTN/+rfxRQwzpLd6ILLCu/ycP7/Vkn6I
	BrTMJN0cOtGnwJD9zXHZLX9x18q2IfTDDo/JO+ekOUwb7GJxoRjPwmmNLpNzMenYL1kAXvHL4tU
	STU1/VQ==
X-Received: by 2002:a05:6000:2308:b0:48e:6f76:de9c with SMTP id ffacd0b85a97d-499c6e9636amr523356f8f.28.1794350574841;
        Tue, 10 Nov 2026 14:42:54 -0800 (PST)
Received: from localhost.localdomain (bbcs-110-227.pub.wingo.ch. [144.2.110.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm7599946f8f.11.2026.11.10.14.42.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 14:42:53 -0800 (PST)
From: Yves Bieri <yves.bieri@theori.io>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yves Bieri <yves.bieri@theori.io>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: do not free a new asoc peeled off while sendmsg slept
Date: Tue, 10 Nov 2026 23:42:33 +0100
Message-ID: <20261110224233.82977-1-yves.bieri@theori.io>
X-Mailer: git-send-email 2.54.0
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

When sctp_sendmsg() creates a new association and sending on it fails
with anything but -ESRCH, it frees the association. The send can
sleep in sctp_wait_for_sndbuf(), which releases the socket lock, and
meanwhile another thread can peel the new association off to a new
socket. The wait then returns -EPIPE, and sctp_sendmsg() frees an
association that now belongs to the peeled-off socket, without holding
that socket's lock.

If the peeled-off socket frees the association first, e.g. on close(),
sctp_sendmsg() frees it a second time. Otherwise a syscall running
concurrently on the peeled-off socket can use it after sctp_sendmsg()
freed it. Both are reachable by an unprivileged user. The double free
on net with KASAN:

  BUG: KASAN: double-free in sctp_tsnmap_free+0x5c/0x80
   sctp_association_free+0x1eb/0x750
   sctp_sendmsg+0x15ff/0x2020
  Freed by task 836:
   sctp_association_free+0x1eb/0x750
   sctp_primitive_ABORT+0x85/0xe0
   sctp_close+0x22a/0x8d0

Commit dfcb9f4f99f1 ("sctp: deny peeloff operation on asocs with threads
sleeping on it") fixed this double free by denying the peeloff.
Commit cea0cc80a677 ("sctp: use the right sk after waking up from
wait_buf sleep") replaced that check, and commit a0ff660058b8 ("sctp:
return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
reverted it to return -EPIPE, without restoring the check.

Fix this by holding a reference on the new association while sending
on it, and by freeing it on error only if this socket still owns it.
asoc->base.sk only changes in sctp_sock_migrate(), which runs with this
socket locked, so the ownership check is stable. The reference keeps
the check safe if the new owner frees the association meanwhile.
Userspace still gets -EPIPE, and the association stays with the socket
it was peeled off to.

This was found by Xint Code, an AI code review agent, and reproduced as
an unprivileged user on net with KASAN (trace above), without modifying
the kernel or using error injection. With this patch the sender gets
-EPIPE and the association keeps working on the peeled-off socket.
Without a peeloff, a failed send that created the association (EAGAIN,
EINTR) still frees it, and a peer ABORT while the sender sleeps still
frees it exactly once. The SCTP selftest sctp_vrf.sh passes. The
reproducer is available on request.

Fixes: a0ff660058b8 ("sctp: return error if the asoc has been peeled off in sctp_wait_for_sndbuf")
Cc: stable@vger.kernel.org
Signed-off-by: Yves Bieri <yves.bieri@theori.io>
---
Tested on net at b71c101bbb98.

The fix and this message were drafted with Claude, and reviewed and
tested by me.

 net/sctp/socket.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b5a57f6..e7e14a0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2082,10 +2082,20 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 	/* Update snd_info with the asoc */
 	sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
 
+	/* sctp_sendmsg_to_asoc() may release the socket lock while waiting,
+	 * and a new asoc can be peeled off to another socket meanwhile.  Hold
+	 * it, and free it on error only if it is still owned by sk.
+	 */
+	if (new)
+		sctp_association_hold(asoc);
+
 	/* Send msg to the asoc */
 	err = sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo);
-	if (err < 0 && err != -ESRCH && new)
-		sctp_association_free(asoc);
+	if (new) {
+		if (err < 0 && err != -ESRCH && asoc->base.sk == sk)
+			sctp_association_free(asoc);
+		sctp_association_put(asoc);
+	}
 
 out_unlock:
 	release_sock(sk);

base-commit: b71c101bbb9814d163c00234d43c41f0a17907d4
-- 
2.43.0
