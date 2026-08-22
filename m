Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6133A71A
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419473; cv=none; b=d8aNKkGHmeMlVmxUFBWYuw6Hj/ItqDC11zGvGkpPzDTNrFq1wjGhD2luTnW7ClJVpEs1mCNRaFnCxvFU6cQbYgPhvNPbOB3dLuM4+//CuWerrtcbBCNbixyKl94j0u2qfAb6BLH3DIbQIwkllQpvJN93GopuTNERqjkT5TEeGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419473; c=relaxed/simple;
	bh=pOiaLjZ9fpt+a+XvW0OXbQmtWskAHbG7Nale7iIf85c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd4QD4w2pufSnZN/OKQE9QZaR+w6rmGR3cxLdz9jEFSgakFIO8jd2sjUrjBW7r0GedQ2wNEv32XjbB7OXRodsIEuWUYUAAvN4h9qqwL5V4rYbujjnum9OcOUR14LxuM7U5MyhKqZfq9SL/qCPZIrIKgDB/oDH8Z6Ng2AJKy+6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba5N46fV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba5N46fV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so18029885ad.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787419470; x=1788024270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uwXJyVRdsHqAOLn45dLgJGtrCpRhfgYFpCZ94p0Y+Ro=;
        b=Ba5N46fVGj+WNLVAWr0cxtMfwA2pfbfUYNiSy1RRusHFbsIoYpxfMQJB9ulC2jZkja
         Pd3dpLQr/d8Mokms60a0a339IV8Ck+CTHPDE8ePWjQ0a+6UxvHFwdQnq7h3PQ5OWUAj/
         +liuH7qy4fOF9lJPgvS+SLlL8hlGpQCAe0IJwnYPt0xb/EYkNmo/b+lAhk4cHl3SfIBZ
         fpJhf8jDBTl1uWAty9n1sA82fl4RU1NsLy+Hte5wxih6lJ3aHa3SZrSnviXog3/ao9J5
         eLvpHzKWVjYvLPM8fMjqJThSKdVfmW83AsVaGIzut503e9c/GsxPg3dUdU3ecq0VPkhc
         6aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419470; x=1788024270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uwXJyVRdsHqAOLn45dLgJGtrCpRhfgYFpCZ94p0Y+Ro=;
        b=SceXsnJum5navQbuNRpg2rW8yug7OAI+j2CsQkBtU7c+l6C40QPIlF6pnYPw6TyNb1
         xnl+WpyHPLZV37YOKvamULD5cdM+08qjmcNUrLdZt3Q54RSpv4dsPX9izDzeAUoW8HPf
         bcWnPHZFuUCIzfwDrIoEJR/a/c+Is6w1Kkm4rSEqh8p9FM/Fe7wa9pzAhkTmVpCVAtfz
         MayAZwK03ylL/njxMnGd3Ili9GCoPf4Bdga4NAGxyVqYhuJ+bXirxqil2bPssXeuEDVk
         eLq9XLCzekAPISB2YMw0Oq1tH/SMoVRjVI0t4MOTAz9dR/OkMWzv2k0e9R7i8MeJofgl
         6kXg==
X-Forwarded-Encrypted: i=1; AHgh+RpZzA0M+EzxPDrIu+RDLeYD7TRoXV3JRGfwkHcs1Gw7YG601s0qie5rZlL3/4o3AZefTRvW6zU=@vger.kernel.org
X-Gm-Message-State: AFuF++lzcDoKncsKKRdDZ3ZlIAU1W5vvqOnN35RFNvcjHno5kGD1t8PO
	l6ueLALGYhknnm9Ki8uX1jQXohxlN8ovIrbjHC1z3SRG7XLxf7+HYNPb
X-Gm-Gg: AR+sD130P4j3jaAa2x5SUFx4XEkKyOq7wG00eSIo4vObkgH/NDOLb7+LugBwMPte/mi
	F0rrlxcz5ZLojz6GNn70JM4C5J/pXM7eZwFId1k9AbZo6nXqAQ4JdPyHqTorYug/8Lpa3j6Bbzk
	o9r2PAaccb7B6EnH0kpqhm9w1awdkV98pMGoxp3+T5ey5kM+rby6Xd71VgtBeqVC0QF9zUqfgwq
	njmbV3IFapoJS7lHebaqZ+2QX+VqDculw30XR+R/QnaCVWUVDy8CCzkbv0W/L5niCeZ5PkgST9s
	Uma6Kc7kakfTWX5hjPFo9HZa8OJigHPK5fPfBTP3DzRzw4MGsant0GPNdTvGSS0/GXZZzTImsna
	gOQNxoalNR0YbkPtSK5NqTdAMM7MVdyJLleQSS4kzVXamp2ylqlBzqKB7q4sFZ/PzYAKNFLgGNC
	zvjlJUyLyMVO/1d2DHwfhPuhUd584Xpd9Ecg10pHPISKdOM86ylEJD7WGtwCo2yB5o+pHeq3hRx
	EkNkX2suuoTxs9j/Q6uOEw=
X-Received: by 2002:a17:903:354b:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d64ada70cemr272498995ad.1.1787419470298;
        Sat, 22 Aug 2026 10:24:30 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.113.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767a614asm5220975ad.31.2026.08.22.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 10:24:29 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] sctp: fix NULL deref on untransmitted RECONF completion
Date: Sun, 23 Aug 2026 01:23:54 +0800
Message-ID: <20260822172352.63025-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
sctp_process_strreset_resp() complete a pending stream reconfiguration
request by stopping the reconf timer on the transport it was sent on:

	t = asoc->strreset_chunk->transport;
	if (timer_delete(&t->reconf_timer))
		sctp_transport_put(t);

chunk->transport is assigned by __sctp_packet_append_chunk() when the
chunk is appended to an outbound packet, and sctp_outq_flush_ctrl() arms
the reconf timer at that same point. A request already published in
asoc->strreset_chunk but not yet transmitted has neither, so completing
it dereferences NULL.

Two ways to get there. sctp_send_asconf_del_ip() sets
asoc->src_out_of_asoc_ok without sending anything when the address being
removed is the association's last one, and sctp_outq_flush_ctrl() then
leaves every non-ASCONF control chunk queued; as only
sctp_process_asconf_ack() clears that flag, it persists. An unprivileged
process that removes such an address and then asks for a stream reset
panics the kernel from softirq. A peer needs neither ASCONF nor local
help: sctp_cmd_interpreter() uncorks the outqueue only once the whole
packet has been processed, so a reply built while walking a RECONF chunk
stays untransmitted for the rest of that walk, and one RECONF chunk
carrying [Incoming SSN Reset Request, Outgoing SSN Reset Request,
Response] -- or two RECONF chunks in one packet -- reaches the same
dereference.

  KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
  RIP: 0010:timer_delete+0x67/0x110
  Call Trace:
   <IRQ>
   sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
   sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
   sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
   sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
   sctp_rcv (net/sctp/input.c:243)
   ip_local_deliver (net/ipv4/ip_input.c:262)
   process_backlog (net/core/dev.c:6680)
   </IRQ>

A response can only acknowledge a request that was actually sent, so do
not match asoc->strreset_chunk while chunk->transport is NULL. Guarding
the lookup covers all three completion sites.

Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Outgoing SSN Reset Request Parameter")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---

v2:
- Guard sctp_chunk_lookup_strreset_param() instead of NULL-checking
  chunk->transport at the three completion sites (Xin Long).
- Note the peer-only path into the same dereference.
- The src_out_of_asoc_ok latch is still not addressed; happy to follow
  up for net-next.

v1: https://lore.kernel.org/linux-sctp/20260820161400.2649968-1-bestswngs@gmail.com/
 net/sctp/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..2012f61e250e 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -488,7 +488,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strreset_param(
 	struct sctp_reconf_chunk *hdr;
 	union sctp_params param;
 
-	if (!chunk)
+	if (!chunk || !chunk->transport)
 		return NULL;
 
 	hdr = (struct sctp_reconf_chunk *)chunk->chunk_hdr;
-- 
2.55.0

