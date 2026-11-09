Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226629;
	b=Cdefq6JMYIhopLHvjrxw+hhydu9vAY4SeNSMU7qY4wGXqXsDc6XgTajsoDh69i6+z+H1
	 En8KLa4uxbz+FHNxBoDqbG9CRoED5w63A1P2BTkdfdVM0tw38i8q5Dw3BEuOtG89vGsfF
	 CDENAHF1xII6PLKczhAWajIXYPBVRDxuGG/qwwdy06EEwROwauGHE/sOCi3MM6I6zh2kf
	 i24hfkOVzHJRZRNljiPBw/biHj+hKqEH97QEswdRJdnVihHKUeidWpsJPBJqKOFDVU6ch
	 zgR10FmKyrCbM5a8cawcVWmx/ijhWyiSY6itBhLfd9sKf1dcXg/eX8CYYsiVAzdSG/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:References:
	 In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language;
	bh=NssoIYQyZ43nLRrkqV6rgytLjGWTG5noCd+YF6O5nOE=;
	b=VL4FaUleqk3ooPLr3F3BgrKlrKOa0ZAnPiH1g5B1Re/tWFnkxVFH3Lo4+0OjcuGMvpuF
	 fLmXUqjkfv4gS8MFpPNWR0oYiwP5t7E8aTKVOpHCrDmqoPAr46g/7PlipNtR5S1pvBZF5
	 IdlpGe18hxwlpBDBZDNnw3JuEIKYlky22p/29MbN2jIyMt96bp72h39lalvNZjrLRCJ3g
	 qmrwBK4OWKMWYXlvBdXQgHHHYBjHhISzxcbutun8JWRz6JYVqrW0qa2+TvgCKtRwjdMEa
	 ey9j1EsCjQtonx/zPLPiHWdWribRNcrWTN0StQS6MQfVZhY3WTRl9N3z83UT7Zwly0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w05G0xgc;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC507606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC507606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w05G0xgc
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53e1d40628eso10244851cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794226628; x=1794831428; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NssoIYQyZ43nLRrkqV6rgytLjGWTG5noCd+YF6O5nOE=;
        b=w05G0xgcfX7EvI2qIZJ18ej/X+ze6J03RBhPVvmJMlroGEnzzeupGnpBjIDYcjHyVu
         2p0LltbD8FOj8Lik2mAVGaBiIfhRkUUeev6AFxQsEGmJqJqlw+Gy1UYgTDyIEHycpARn
         upttpJgPs9LGncA11RX+NQjUIoaA/UBWfs88upJRDQs4LJxEcRd+SzD1htdlZO7twz5R
         RIF/F1KLDr+tAFTjEjFwbc8JGMP4iQZUJmZWgDUvGvKpJkoYlNj4YhtSkkE7SOiaEbL+
         sErJ90Ub5QU7ruSNsMTj7HzGKYzuvdNssezj5uADjyc3J2OP4LVQS1Mo7T2/FaJqULrE
         yoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226628; x=1794831428;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NssoIYQyZ43nLRrkqV6rgytLjGWTG5noCd+YF6O5nOE=;
        b=X+a00wGAr4BO4F7oLd9JVEdh5e8NcE6QKfrcl29Bpq0zhP2Spdy8TlRPGVyp+sq6BZ
         nPldgApp/WlKjlc144pX92YlPk9EkJ8ii8lf7BXbAIXCaJGrHaSRuds326398AOr0JLR
         wrI4WS84K8BHhXaZOYiqvvIrJjrHweNqT+63k+oNbgQ8xffoGNzK5gjMO5Tnp91q5C0S
         nmh9WwrlTkeJwTQhjJe2oCTGmg+Pq1KRcgUbqkm58wh1LTVqRpqSNYQZgtv+yskX25zk
         xy8FishzupzmUNwKiDNscr7L0y9++uXNCavoiUdvNgamu1kcjlpYP+VnXMpHAz6/I/CI
         8aEA==
X-Gm-Message-State: APuU4Z+I91EcvMh7loF3xoP1eEw71LnhFrV7aJBVPvC4Ax7mmz5vHvWU
	Z2Nj0Zu3JuxuX9vB4/g86LzFLdPw4qX/3wsjT9ISNCBWTYcBpXwCBMfbK8HPzsY7
X-Gm-Gg: AYBFou2AcziNNEaFF/Sv6yyBhXCFXTyrvJnLu9LmC0KIxSCpeMD2vCH//o9TWNaUqeO
	1w1EU/lhH9eNDbaL+U/KHd5rCrT7lR/AfoEGpPJkyBeto5oaL6d+0DiiwMlQ1FrOScjLFzK2GXY
	/kFdZQUaLgqR+CWGHUEhD55Lr24N5uVtyqm1u0istgVi8Etpmb8rE/ntihhr2slKnyEO3yNbKnA
	YCne2PQ8vmjonAeFZWQJ6ujOXr2gU3oVfb2RTqAL4THVxP7JJpOyXolq1ZvmMRa0Wb5aPNO7uur
	S096btUDqW87iGXhAn1QZnhBHk6Hra4Xt+hOYdRGzZjASTvBXOlAUqodTxHEqCrdHbWLay3H9c+
	0zXw7Z6t8MHDR94FErUq2s0XRTRv5Zdu9GpdDbIpET1T08YRzu8V4QI2of+PMYeqCaJUvvFnZ1K
	AxwdRPhsOWzvcjnCgzJGJj17L96tl6U5TEL3XmruE9cSb/sq4ztarw4aongsv1YXNabETB0U/1v
	5Haf4ojGZ0CSd41DYiBUnuSZ0gopp9cOExbvV2gqLpOGABq1mv4H0cDwFF99ma+KdoLhgLaxtxX
	iK4K6tyOS5hGGrCsHUVAUcn7vCvgM98zRqzCP9N2eut8
X-Received: by 2002:a05:622a:22d0:20b0:535:f9dd:a3de with SMTP id d75a77b69052e-554472361f7mr8323831cf.23.1794226626380;
        Mon, 09 Nov 2026 04:17:06 -0800 (PST)
Received: from Desktop ([186.247.171.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55261474cc3sm39066831cf.3.2026.11.09.04.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 04:17:05 -0800 (PST)
From: <brianrobertjames@gmail.com>
To: <netdev@vger.kernel.org>
Cc: <westeri@kernel.org>,
	<YehezkelShB@gmail.com>,
	<riverscn@gmail.com>
References: <000201dd6fba$2c726e80$85574b80$@gmail.com>
In-Reply-To: <000201dd6fba$2c726e80$85574b80$@gmail.com>
Subject: [PATCH net] thunderbolt: Use needed_headroom for the transport header
Date: Mon, 9 Nov 2026 07:17:04 -0500
Message-ID: <001101dd7044$3ba5edc0$b2f1c940$@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad1wQzllGGjtmFgISvi5Wzu4RDT11Q==
Content-Language: en-us

alloc_etherdev() initializes hard_header_len to ETH_HLEN. tbnet_probe()
then adds the 12-byte Thunderbolt transport header, although that header
is not part of the Ethernet MAC header handed to eth_type_trans()/GRO.

This makes gro_list_prepare() include 12 bytes of the IP header in its
nonstandard link-layer comparison. Changing IP lengths, IDs or checksums
can prevent recognition of packets belonging to the same TCP flow,
allowing later packets to bypass earlier data held by GRO. On the tested
direct USB4 link this causes TCP reordering and excess retransmissions.

Reserve the transport header in needed_headroom instead. Keep the
Ethernet hard_header_len at 14, with 12 bytes of needed_headroom. This
preserves the transport space requirement without changing wire format,
offload features, or RX/TX credit allocation.

Shun Li published the identical correction on October 9, 2026, in
riverscn/thunderbolt-net-dkms (commit b18a196bb5ca). Credit for that prior
published correction belongs to Shun Li. This submission adds our
independent AMD/Proxmox hardware validation and receive-order evidence.

Link: https://github.com/riverscn/thunderbolt-net-dkms/commit/b18a196bb5ca
Link: https://bugzilla.proxmox.com/show_bug.cgi?id=8306
Signed-off-by: Brian James <brianrobertjames@gmail.com>
---
Follow-up to my November 8 report in this thread. Fabian Grunbichler at
Proxmox requested that the actual patch be submitted upstream. The
one-line diff is included inline below for review.

Test environment:
- Two AMD x86-64 hosts, direct native USB4/thunderbolt0 traffic.
- Receiver: Proxmox 7.0.14-28-pve; historical tests also used 7.0.2-6-pve.
- MTU 9000, TSO/GSO/GRO enabled, gso_max_size 65536.
- Unpaced single-stream IPv4 TCP iperf3, 20 seconds per arm.
- Stock thunderbolt controller unchanged; only the receiver's network
  driver's header/headroom line changed. Cable, ports, MTU, offloads and
  CPU/IRQ placement were held constant within each comparison.

Receiver-only original -> corrected -> original comparison:
  Original:           30.599221 Gb/s, 620 TCP retransmissions
  GRO corrected:      29.779541 Gb/s,   0 TCP retransmissions
  Original restored:  29.994158 Gb/s, 540 TCP retransmissions

Endpoint interface error/drop increments and receiver FQ drops were zero
in all three arms. The unchanged sender in this isolation test ran
7.0.2-6-pve with TX E2E enabled; receiver RX flags stayed FRAME|E2E (6).
This comparison isolates the receiver fix with that sender configuration.
It does not establish that GRO alone resolves every retransmission mode
when both peers run 7.0.14-28-pve.

Historical 7.0.2 receiver-only comparisons on each host, 20 seconds/arm:
  Receiver A retransmissions: 536 -> 0 -> 132
  Receiver B retransmissions: 564 -> 0 -> 769

Historical paired receive hooks covered identical TCP payload bytes
(18,871,120,863) and packet counts (303,590) before GRO and at TCP ingress,
on the same CPU. Forward sequence gaps were 0 before GRO and 1,219 at TCP
ingress, with no packet-length parsing mismatches. A corrected capture
had equal byte coverage at both hooks and zero forward gaps. Overlapping
and retransmitted sequence ranges were handled separately. This supports
an ordering defect in the receive software path for this failure mode.
Runtime tracing confirmed header/headroom 26/0 before and 14/12 after.

The measurements above came from actual Proxmox hosts. The current
mainline source was inspected but has not been runtime-tested on this
hardware. The diff context was checked against mainline commit
7475ea8b58616b33c04afb976cf0fbaad9dd63fb. The separate TX-credit diagnostic
is excluded from this patch. No Ceph qualification is claimed.

AI assistance disclosure: source review, diagnostic automation, analysis
and preparation of this email were AI-assisted using OpenAI Codex
(GPT-6 model family; a more specific serving-model identifier was not
provided). The measurements and traces are not simulated results.

 drivers/net/thunderbolt/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1410,7 +1410,7 @@ static int tbnet_probe(struct tb_service *svc)
 	dev->hw_features = NETIF_F_SG | NETIF_F_ALL_TSO | NETIF_F_GRO |
 			   NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	dev->features = dev->hw_features | NETIF_F_HIGHDMA;
-	dev->hard_header_len += sizeof(struct thunderbolt_ip_frame_header);
+	dev->needed_headroom = sizeof(struct thunderbolt_ip_frame_header);
 
 	netif_napi_add(dev, &net->napi, tbnet_poll);


