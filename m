Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E406490C14
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696372; cv=none; b=MclwqH1779BUSjs+63UyqNHoBCAjSrVFYXW/QGWxmdRCdqdQzhEkPD3or3WGPgdlREhZChhV+HV3DNyUUX5C5crfGgkAU2LH4o3XEsMTwDG35cZM5FI4lSqhBFGfQQ/NEOtm3rfWbbUkLQATiv+KW6di+bbSFFlICz4SQQqINHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696372; c=relaxed/simple;
	bh=mEdR2tx1LHDyaqyyS/X36JdZWYUI1LR1QvNX1VgVojE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDoEr0JJQA/Lfzwne/0gqBlPg+sJ94kcKomt/XUvoCujMDcGiUL99BPqrDlAkl7P/Mw7NWK0UClsmvaMXemPtZ8Ip0d9C6zeVTgxrA/qYvtDWUZ6ndcOn3i/fF24286RlY5e6ijxBUJykLxgNCOebGnOrjl7eK0M9cxUtjkcIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWAVvyOS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWAVvyOS"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso463420b3a.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787696371; x=1788301171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbRd4C72E6Tx1zFpSce3Z+MgqbEl1YisqbhWXwpdJmA=;
        b=sWAVvyOS1JtnoIepHNqmeYx9f9gkVTqUmjNtvkN9UZgl31pYe4egO14ko3ZZ4xSSNS
         /YRRDU0hNEBRHWXuRhFglZFiq4WsFMw9IXfMKCmtEYSV2RhixnRPuPa+vM8MFGXFfhRX
         spEGH1eEal70NS3qeGYkywU8v46h+YLJeERvy1qH38ndRAq1D+jHoHE/JNmDZTP4OSP1
         ugsSgGMKMp06klddFJBRTVo/wymCQGRx7M/UequCDTLe8hegWxenZGd0kntYVm8T8IhZ
         VjWjzY88JCx2M/F3f5qab7tpTdKdHvjMSOI5NJgDt/jJoLr2foUQtXG4JRCtvpe9EChV
         WmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696371; x=1788301171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbRd4C72E6Tx1zFpSce3Z+MgqbEl1YisqbhWXwpdJmA=;
        b=eYQEbMhUpE4xH6bJ3co+L1vWx5U6xgezjlQcTxrRf23lJZZ26P3fS/h6iDXqhyXxWh
         hfa9zXdTcdQX81RvQoAXV346KWouarF66rSF208yHYpD21pXL6KRBLxoluXXuyK1V2t2
         5R2K5hqMootf8VgIe8fi4uK0NGSi3AU+JHZacnbfH37YFYhPK0P7Ir9FyTdvhR+1w0p8
         lqzB4PIBE+xCN1FXzQSlJYEYUG+5ymd9SmNqj121G5Szhzz5UnjxGUtUs8VibUP+4sgi
         Pyx3XBuZXxYjvJRrCJ19M9QciAO1k+DbxcZAEe+vffDMEMzI8lVVmFMv+0Ls0ldoiRBo
         ACiw==
X-Gm-Message-State: AFuF++nupG62rmVzys6d/Lqk1+F/9iMJctc6HfqmWdjYUol4fb+JDpP2
	GN3C0xPt5jOUIjYype90gipTfPzgeFcDZhEUfOknDyARRsfbGV6xywbrVlhzjw==
X-Gm-Gg: AR+sD11afAb/kFkRPyLMA5i/W/AwTPxKxjPPknVuXMzgspj3fEKQSRyy5OhCX6tai9+
	0xOm4+Q4a0ZYANRAE0TmKjqSTIlh0JOibJLmmYcFzQtPPgugIj2z0HGAl5b747iTDHPrc/pv+Ro
	nRS8FYO7bV16kts1jTMkuDOy0ss+VPz2MW32UkM88lqZRHb9QRSBPk+Yi4aTc4esuANBbsX+AIX
	z9YqGWURdxS9M4+wZYTRMmmkx/gJ6hSnLCwK28wvF0r6QeA0Yn5fOFJc7OoCW+dtNhSPleAeaGf
	A0G24Lm2V9D4i792zwGcIfIJf//oTEB17Y+iK4TdGZwKH/21JyhWBlmeagMgMadV4avoccGf18N
	3C0BnUQst2gBitpMBaWaYAvyoNXMcMdYmrUsK45IMEskDIAYsUF2scE0qr98w+Hqj34lgniwIkS
	r5HlSTHgnG3Mp0OV3c/M55jLcAOeK2MoCUd/XNfYWMODLx0d6WgXEVIRPlf3mBAOW1hx8OWiuz
X-Received: by 2002:a05:6a00:1f17:b0:848:2c2e:c7a3 with SMTP id d2e1a72fcca58-8537648a353mr3388101b3a.16.1787696370760;
        Tue, 25 Aug 2026 15:19:30 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535acc39a7sm276934b3a.23.2026.08.25.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:19:30 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] ip: skip IPv4 cmsgs for non-IPv4 packets
Date: Wed, 26 Aug 2026 07:19:22 +0900
Message-ID: <20260825221922.85651-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_ADDRFORM can convert an IPv6 UDP socket while a native IPv6 packet
is still queued for reception.  The converted socket then receives the
packet through udp_recvmsg(), which passes it to ip_cmsg_recv_offset() as
if it were IPv4.

This makes the IPv4 ancillary-data code interpret inet6_skb_parm as
inet_skb_parm.  In particular, IP_RETOPTS can take the IPv6 lastopt and
nhoff offsets as an IPv4 option length and RR offset.  A destination
options header can then make __ip_options_echo() copy more than the
40-byte stack option buffer.

KASAN reported a 152-byte write on 3/3 fresh v6.12.105 boots and 3/3
fresh v7.2 boots.  A production-shaped v6.12.105 build instead reached a
hardened-usercopy BUG followed by a fatal-exception panic on 3/3 boots.

Check the skb protocol before parsing SOL_IP control messages.  This
preserves the queued payload while omitting incompatible ancillary data,
and also protects callers processing a stale non-IPv4 error-queue skb.
With this change the trigger returned its payload without a control
message or a target KASAN report on 3/3 fresh boots; both controls passed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/ip_sockglue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a55ef327ec932c..24cb74c3d62025 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -22,6 +22,7 @@
 #include <linux/skbuff.h>
 #include <linux/ip.h>
 #include <linux/icmp.h>
+#include <linux/if_ether.h>
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/slab.h>
@@ -171,6 +172,9 @@ void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 {
 	unsigned long flags = inet_cmsg_flags(inet_sk(sk));
 
+	if (unlikely(skb->protocol != htons(ETH_P_IP)))
+		return;
+
 	if (!flags)
 		return;
 
-- 
2.54.0

