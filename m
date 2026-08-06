Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B03A785A
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029554; cv=none; b=OJCnMpwvASY+9cpeuKVCQeUH+JfZ1D9ahYw+Rt/VQcJWGnCpipdBeAzUzYIA5EaGnrphN2LN41OW3Tltb9QwTlEasFeI26MJgoPkZbN2kdrit6K8HyTRLfTAsmgnCAzYsseuxhLbvF3StKKc7BJVlGYQJ8hxg1unU/tYxMOXATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029554; c=relaxed/simple;
	bh=lMFtTDGTCvVhvql6dY4AgQZ41cktbOHo6Cm5jpHgpeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4rGs6z+xrSKY5h5Oz1Qz8SaK2wWJObZreDyI6J6lb6jHH2xTETMKkw03LJ/TcHs2OByHcial4b+ByKjUPStJoWPt6YIfOn7TjuY6zbUbTTasfWEGnRTURMQSht9TEo5+fjwlBYGUG3A9Be0rxIbnVs/56388sWlA983HVrNnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sHuKzStH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sHuKzStH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso32913095ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786029552; x=1786634352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZHAiU7n90MzvUYuXvR9xtuxpe05p3NVzrsRdq55ods=;
        b=sHuKzStHCy2L3I+QuGj0JFwHAxrdROXcme49jsRWOlEb673MzOogFW3Vqd43/mXpxa
         FHKFaw0l+G2T95nHy90M9Go8dQge429VrRs6Apf4WBGYCCsULPxsmnwtiRFQGy/X8z8q
         mQ7PvKBCCTtNTuEki4WShZzKi2u7HlZQTtV6XQX1RSupRtoK+dZmvRW1QJ3jSx2hfon/
         y5oDOcmmIBYLbOpfshPpD3HEkbIpWifmJk2gMgOS51apMh09ncVcr0anrEDt6SqLxIbR
         el4xgpiw+bnrrhq6yn1UBwfD/dflWaT1eFiopb/D+bIYT8C+vAysuDzbGpEq90YOmqfM
         a4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029552; x=1786634352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZHAiU7n90MzvUYuXvR9xtuxpe05p3NVzrsRdq55ods=;
        b=nJYMYPT8ZurZ+t+uMd4iPD/62Hm2dzNW0lAcDC285icyoXyRLUcfPTkQ0JlMANqyYV
         ItNnYTpsf8zZBxs7Sb9SuAlpeK0ywXb42qQKmEpBHeHqSrHnhfIpMuGA7DCG2I2RjEOh
         GvsDg0k7f2o6eiW4z5pa24Q85PH/iOh0in0ciKflOb8O7juMpafjk9p8xN3XUeXufuEy
         pCrJchzV+EgWWPWYWtfvi8O6Xw2bCs/L4jB4PlqqhRHTCWZ/yiaR1g2gbJMFGAh3EfCd
         q6+Olt1J33+zwiNPJQt8p0O/4t15Pnh111e1kAgX63FFG9H9QyW4/vP9SxYfQJ+il8Rq
         2tsg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1CyzKZEnuLnASKAzyYibgv5IluaHa+gAm4xjepE8b1ioRCPnXa+9cAFB7u3dtxx8bFTTT+nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKc2KzzM87N6hBFJUxj5U3+wLquJyjyzje24fqm8PWqZuoNpnG
	Odw5aK3OUZk+ZAW97hbc70zmPgrnhIuAaU/cZgRSeMHUD3bu9e23zcG8ugyyOxG3Ze3Q
X-Gm-Gg: AR+sD10kpALgj/6oR4HjvQ73g0BtMiJUXYIVGsGbeeBygiDt3BUDnuMYll6bVUIifua
	n3C04D7irHVXAD+I0cDF3lqKHJ0Vutqcu4FVyUADxColDnmqwaUARXUhnEFSjK7HIL1/Deg91up
	hiy+4HQJ8JAnJUv+JvCE4C7+ib8Bww4iDC8zCmBuVtAe/1vPph9l+EicWIgXQWUZ37DoCneLon2
	GVMRp4owWeGJ+Mb1Ha5CQ0EWdC9HxUyHsbNmpggg9OnZ/q/W17Oh42+0TJx09bVPw8v9I2HtACJ
	KuvKTU+a/4fAEDKhvP78ozwxldt8r27XlDKOhwARmaNvDsEz/NL71MxYvEXwjtQug6FqJuPC19n
	Bgn/Lm/pmOmzkPr7binQ/2/5shAl4qzmFQ3B4T7w8GN3QBm7snja5MjZoixfdbLO5xvx6xZ5/iu
	y7EgyAnJtylrZ56Rrvh7t/hLUlcAiDoX4auou04z+9aUrnz+omlLI/IVxU6C/tQtGPBwpz6K7fb
	Y7DvucHvupP24c=
X-Received: by 2002:a17:903:46cc:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2d0ca7fad2bmr204351875ad.11.1786029552042;
        Thu, 06 Aug 2026 08:19:12 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa493118sm33680785ad.46.2026.08.06.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:19:10 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ip: orphan prefetched skbs before multicast forwarding
Date: Thu,  6 Aug 2026 23:18:56 +0800
Message-ID: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. IPv6 can also get such an association from udp_v6_early_demux(),
which runs in ip6_rcv_finish_core(), after ip6_rcv_core().

The reproduced UDPv6 packet has a multicast IP destination but a unicast
destination MAC address. It is therefore classified as PACKET_HOST and
passes the UDP early-demux check.

When the multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Cover the IPv4 multicast forwarding path.
- Correct the IPv6 early-demux ordering and document the unicast-MAC
  PACKET_HOST condition used by the reproducer.
- Add the BPF socket-assignment and UDP early-demux Fixes tags.
- v1 Link: https://lore.kernel.org/all/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..e5f2b1c6150d2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee5..d332ec60f9150 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.43.0
