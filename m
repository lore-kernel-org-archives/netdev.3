Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598048;
	b=APDFBZyJ7505epH3bmlQL0V6W5kmbUM9RucqJcUaMRYUvshENB5IZ9YqsOBwLuoLtC8J
	 HxXw7AdI6w+Cgn/E63BgtiO9Ks1jXrv2eLSdnPnpnhg/okhNvoJLGT6fd0QU6V0cwwcUO
	 Fn5Xg/mJARjoBv7V2fkGEgIWp9OpE0Nx1h5ff59Bph4eK6BmXcTruUmYAkWQkKCdNBFlw
	 u/TugNZsNIBqHckZNUJkhIBrUWKloAL8ql/e69tdUQU9XNYVtFBqWxbJ0L7hpIYbjclpx
	 mClpy6Adj4HVKYiUdt7+QBgROGplYjEOXq7hiTSwQy2cOTxN+HZ91p9NfzuRNo3PxNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3CTklGnR6qKIfqjBldxG5LZR5vJ0yi1DcM9vKm2oYi8=;
	b=AGYKmpBk2wzo8J/IkJLq71GxjMc2ilfww8zSNU2184p/1/cv0xopFc1mMBdFj3EZXDzU
	 aXJkGjdmZwC9RlXC6KfNtr3FMQ9ZHNBzOn3p56DyKfQ9Au57IE+/7/rLpip3wCb1Gd+6m
	 Il6JpuV0La27yhdAx4L9sCmROQnHn53HdtwCymyEMxscNytqwI9l64dSXplMdZTvhp9G1
	 pjZDnsddydRGtg2oEtoeK8UxQ2uowco7VaELnhJgwR0CcfWolLHHrb194B4uVrIW2ArMI
	 aCaZnOl8FmzyHiPQ1kpvJcVPKDtBK3k0kGOzpdZoRrGoUnTEnR4Mt9yB7Di96RNVcKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="tNEye/+U";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A62606A31F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A62606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tNEye/+U
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so300276a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598047; x=1793202847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CTklGnR6qKIfqjBldxG5LZR5vJ0yi1DcM9vKm2oYi8=;
        b=tNEye/+UEyGcEv+mmO35R5dvve71SFnpGdHRW/DRlxtVWLwzBkim+HfwfLotWHxiS9
         sKaTn0VpC28ufBvoUqJLxYPS6oA5BG/soKhR/vAOzwGZ2ByTgMy3xNrZQhRIMl2ereqd
         KNwWeZ/QYTdM1rbkeBrJEE5tEImgecuqhQSSg4hTTE6ybs7kDu4uMfLANl1o5kU4P0eH
         Z9Krh0UGIZ4pmlONauHULtdHXG8O9Ujl/hs3+hAKdfKjN9RJ5nFDS1CKsX3Yegb9t+w+
         ADmr01xdfCanedBWLYvLp43nNrl5SyoFCgRGo1I9TWc7BgyWi1DeRjDl3vQ5jOgDaB13
         tXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598047; x=1793202847;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3CTklGnR6qKIfqjBldxG5LZR5vJ0yi1DcM9vKm2oYi8=;
        b=GN6VYUG2gfb/b/QZylPzX/uW/mMMOWunBIUPPsjf4Jew4E+xR4gBtHl3VTPLDrMmh3
         dPCz+BV+hP8kVe9ejjeUst8riUELSG/oKgZJYty1M5mHbq9f7z7yBBUFO8sWP3ujOUAe
         c0cwYQouigPiULUufkI0aVkI2NB6dif2AGMq2N3stK6+Vkp3iaOVxEJXiCl1HENOrnJE
         dcj+UDIMwq3wgHEp7ERRlQVB4kmegXibMXvpybZg0bNR++tT6ILv5ugtxUrTvUDdNwdo
         XNKnrxhLa4P7/h+cyNRUmNyK1NQkWposxKcn80fv4y1vhdYU0/kFuFyvSiWu3ZtNkXtB
         9M5w==
X-Gm-Message-State: AFq9FYLhDCiOUDLz/0J1Y5iFIvEu/FpmO6UyU9xX3RhH1kGL5pqUNcmy
	n6mLa+iNStYqgyvtHdiNamadb/MrweiL59MEtyATe7OSbBZ9Dg1m0RLQRW2LDQ==
X-Gm-Gg: AYBFou2b1MrjSa/erbhT22sf3YvcHUik4kxk3L+czcLp0EdCVDyXnF5jz1YoxEmkA02
	hp+H8yKKm/42SIJj5DJR4QPoQU5bURrIN4igU3P1guw3vXSo44LqyckTYPrl6FaC6AM7hplhlNa
	1VlwZb1h8RxC3ZmZB32gskLuf334YwE4IePwk3kLPdAZfVJAkBS3x0sOZ7DScLqvh59wXWwvIQ2
	q59k+4gC/kdQUaG7i/9UXoHyfoNnZmLSzOo0NgF7AGXXDxjaqvm9kQTilsFfR5Fs3cAhqK+yWwk
	Q7c3I4x13/CkPJheu48M4YhOVua/Q/49czIvuDVxdQSKAuLdsIEegF4Zp5SymeUvKwgtyTNy/Ew
	miUEVtiMMTYP0pHAhrhkcjwsEObmbifAl4Ss9o6hnMd8gvc++y1/nAmloB4mN048eesb7A6gvVp
	QYDnyVDnnqsAcs6U7IuWL4plhZHfAETc/p0i4FotUwGOJ8KOYNqS7vCJPrA3XuebhHQCAQbdrH/
	zurPADr5M5cfIkim1y2AZvAFSPPsg0MI9cJ7ZjLxKXbqBAC0qKI9FbOAYbryqFdoGNyCBNcnE6d
	RKwedatoKXhAGAHtFW1VAci9qQxyDWVTeKT9sctHGBjazMm0TVoA4PCSlYQ=
X-Received: by 2002:a17:90b:3a43:b0:3ac:9c37:9429 with SMTP id 98e67ed59e1d1-3ad86f1b5f7mr2277770a91.52.1792598046956;
        Wed, 21 Oct 2026 08:54:06 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bcb45sm82813a91.16.2026.10.21.08.54.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:54:06 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: etf: initialise the sock_exterr_skb before filling it
Date: Wed, 21 Oct 2026 23:54:01 +0800
Message-Id: <20261021155401.65997-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

report_sock_error() clones the transmitted skb, overlays a
struct sock_exterr_skb on its control block and fills in the seven
struct sock_extended_err fields, but never clears addr_offset and port.
skb_clone() copies cb[] verbatim, so the errqueue entry carries the TX
skb's stale control block to the receive side, and the ipv4 error-queue
reader trusts those bytes:

  net/ipv4/ip_sockglue.c:556
	sin->sin_addr.s_addr = *(__be32 *)(skb_network_header(skb) +
					   serr->addr_offset);
	sin->sin_port = serr->port;

The gate that is supposed to guard that read only asks whether an
address was requested at all:

  net/ipv4/ip_sockglue.c:484
	return serr->ee.ee_origin == SO_EE_ORIGIN_ICMP ||
	       serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL || serr->port;

SO_EE_ORIGIN_TXTIME is neither ICMP nor LOCAL, so for sch_etf the gate is
decided by serr->port alone -- by the stale byte pair.  When it is
non-zero the reader dereferences skb_network_header() + addr_offset with
an arbitrary offset.  On the TCP path cb[40..44) is not zero: the
transmit path stored delivered_mstamp there (tcp_rate_skb_sent()), which
is exactly where addr_offset/port sit in the arm64 struct layout.

Reached with an unmodified 7.3-rc4 (arm64, KASAN, in-tree modules): a TCP
socket enables TX-timestamp error reporting (SO_TXTIME with
SOF_TXTIME_REPORT_ERRORS), a sch_etf qdisc drops the packet, and a
recvmsg() reaches ip_recv_error():

  BUG: KASAN: slab-out-of-bounds in ip_recv_error+0x970/0xa0c
  Read of size 4 at addr ffff0000158ffdd5 by task A-227-A227-1_S2/113
  ip_recv_error+0x970/0xa0c
  inet_recv_error+0x94/0xdc
  tcp_recvmsg+0x378/0x408
  ...
  The buggy address is located 149 bytes to the right of
  allocated 704-byte region

Zero the whole overlay rather than the two fields individually: the
errqueue entry is handed to the receive side as a self-contained record,
which is what every other producer in the tree already does (sch_etf was
the only error-queue producer that cleared neither field).  This does not
change what the in-tree selftest observes -- so_txtime.c reads only
ee_origin/ee_errno/ee_code/ee_data/ee_info, never msg_name or sin_port.

Fixes: 4b15c7075352 ("net/sched: Make etf report drops on error_queue")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (dummy-virt,
KASAN kernel) against unmodified 7.3-rc4 in-tree modules; KASAN fired at the
claimed sink.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst ("do not publicly share a reproducer");
it is available on request.

Triggering conditions
---------------------
CAP_NET_ADMIN to install the etf qdisc; the socket must opt into TX
timestamp error reporting (SO_TXTIME + SOF_TXTIME_REPORT_ERRORS); a TCP flow
with a non-empty retransmit queue.  No out-of-tree module is needed.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/sched/sch_etf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index ada87a8..aaafcf6 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -147,6 +147,7 @@ static void report_sock_error(struct sk_buff *skb, u32 err, u8 code)
 		return;

 	serr = SKB_EXT_ERR(clone);
+	memset(serr, 0, sizeof(*serr));
 	serr->ee.ee_errno = err;
 	serr->ee.ee_origin = SO_EE_ORIGIN_TXTIME;
 	serr->ee.ee_type = 0;
--
2.39.5 (Apple Git-154)
