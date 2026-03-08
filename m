Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E71E505
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772958824; cv=none; b=i/XIl0sk3oaT1I18GSpCg0KCg7cWLlZt+c3UtPNvWNID78j1/f31HfYNnDkSXqq3nW0DwnKEcRCdGhEbYlBlpe1aQqEID1RvSJrEUCSPI502YaPiynZHYIKScXHWev9Q5DMr6q3jMuvjKz9bWxuii9WHuz/27D7PPmIHzMb0z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772958824; c=relaxed/simple;
	bh=kLSKOitdaoVtzVtaLvgUT41Tv+/KcuOwChwYAunlF7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/JMSuxBDy4rnroF9x7E2WOnuRSd/bguQ8otxUiZfnMnDzxachaMHkb1SVEG1hxjK52rFctfk45CUSM+hhvFZvq38JzAE/BPyBGZucP5Jdd1ceARsQ0DX4NoJr2dx5CEMen+eWiKn9mA3pUg9A6DP8yQvkmf1nrE1uNoW+tYpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbdeuwrJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbdeuwrJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3597df496f6so4436868a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 00:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772958822; x=1773563622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LrWUESIBjuaU2ffQktwCbquNdN3g32EtrYN1kFZAsY=;
        b=JbdeuwrJNpCig9ubZDDRAnz1BN0kIeRqUbbKMKBw5efD8LctG7c0SAe/Y62YXPIlVj
         /30f0mmz8Hb9PHv9cR3cDjJL5wIIh76DXyean12MIRlAYUbQXIsMFJZkS0lA2CvJ2Qwu
         IywytSA7nnpn0L9yxAvq3Cq/L8Zpa2d1U9uc2iTFLTGkk7pvA7uvrXEgI/wkPbFNzeXr
         UFN3prqZMpvR+IqvdyEc3Vy5ZNJqMK9usApu7NT7Ehxlie+Z9Xm2TmeimWEHHZaXGCm9
         LXVfdraidITieEmzMDY677CeUviJfXoGSUOd5C98v4YaJjeAMoPHKyUR66XDv/1aLk50
         pjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772958822; x=1773563622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LrWUESIBjuaU2ffQktwCbquNdN3g32EtrYN1kFZAsY=;
        b=ohqfvLHmwRRu3oGyOMlIH7fDBBrOxG69EQNvOWLeHeNgxLgA5ijYYiMs6ZyOwXO7z0
         twwNjH4RRvVmqf/yS8QU9PPQ9Xy/zkY2UIMXUCSpxG7mhx/FNDFyICdyzQUUMSE0++kG
         1kYs/BAqiuhpEk1ybaD/BxTKQOBiXvCheaqD29VXKuNIfWeTGsFCySW2zOs9Q2Cei9S0
         NMrt/j6dRyWWhIPgvDzXplg9g2I/WL9UfOz8j6J8C7ZILhnObWuGtPLkFgIn27pNRTCb
         P0F9PcvOGsbbhPrY0al7BnCP3e6of+PrPjDBf16F+q7HPlsoi7LXCj9zXAsAGezIwBya
         x+EA==
X-Gm-Message-State: AOJu0YxcQxdK58x7cfPk4MYxY6YIte1femst1ou7B7hTDFZiljzoYLx9
	6uhspo/vVTwSQYPVGH2ds1m5Oll7wxgyosMn9ykrmFCyPb5Wn2EML6g2
X-Gm-Gg: ATEYQzy6FvnfXAFQ5xRu1Q8lL1JOaeXvPZPg/YnLgqk6KwXRGV3iVy1HM69/QP535Ek
	W0JoM/Pl2YjeYw2YeBPogaQ/yOf908uSw4aP4SwKc0kn+EcmmF9f316H9+UnIM9alGKMeIZK+c9
	QT1tAt+1mk/rTheciAki8WAVqsZm3lrn5zsyKht29n4PgiqqkhB9q024+3yvKMnK9+6EaFcBzuK
	1eDyo0YJmz4c5D+ZzcYhYqZQPRmp5V8tvpe59HvYe0O2abqpqtbn0beRx1ooJJ/kSuDOw0oScd8
	51ji29M5Px83E9XzvLhfejaE4qhu1lPk03EkR7zKMSADnOJZCruagt5P8S68vQx8fHSleLSaasc
	IOPfDDyGpjX9iHGDJmnz8haLCpRCkwRNxYyld+1pEx19S+eGZZ6rkQxmjsl/k6UEjrakQd4VJKp
	JtGRBJw6xxI/SBpDKUAdAYJDj/8PT6iEP1HJDdzwQ9qA==
X-Received: by 2002:a17:90b:2e0c:b0:359:8ef8:d5f8 with SMTP id 98e67ed59e1d1-359be1317a3mr7417256a91.0.1772958822351;
        Sun, 08 Mar 2026 00:33:42 -0800 (PST)
Received: from DellG15.localdomain ([112.51.242.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0179a67sm6982723a91.13.2026.03.08.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 00:33:41 -0800 (PST)
From: Guoyu Su <yss2813483011xxl@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com,
	Guoyu Su <yss2813483011xxl@gmail.com>
Subject: [PATCH net v2] net: use skb_header_pointer() in gso_features_check() for TCPv4 GSO
Date: Sun,  8 Mar 2026 16:33:19 +0800
Message-Id: <20260308083319.1255118-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
References: <20260307162905.3697050-1-yss2813483011xxl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a KMSAN uninit-value warning in netif_skb_features() [1],
which originates from gso_features_check():

  BUG: KMSAN: uninit-value in gso_features_check net/core/dev.c:3804 [inline]
  BUG: KMSAN: uninit-value in netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
   gso_features_check net/core/dev.c:3804 [inline]
   netif_skb_features+0x6fb/0x1870 net/core/dev.c:3828
   validate_xmit_skb+0xb6/0x2400 net/core/dev.c:4003
   ...
   __dev_queue_xmit+0x3016/0x5a50 net/core/dev.c:4795
   packet_snd net/packet/af_packet.c:3077 [inline]
   packet_sendmsg+0x91d9/0xa320 net/packet/af_packet.c:3109

The current code dereferences iph->frag_off directly to decide whether to
clear mangleid_features. For malformed or truncated skb data, this can
read invalid/uninitialized header bytes.

Use skb_header_pointer() to read the IPv4 header safely from either the
outer or inner network header offset. If the header is not accessible,
conservatively clear mangleid_features.

This keeps the original behavior for valid packets while fixing the unsafe
header access pattern.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e4b5d8.050a0220.256323.0018.GAE@google.com/T/
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
v2:
 - Drop the SKB_GSO_DODGY shortcut.
 - Use skb_header_pointer() for safe IPv4 header access.
 - Add missing Fixes tag as requested.

v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..c70263654680 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3805,10 +3805,13 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		struct iphdr _iph;
+		const struct iphdr *iph;
+		int nhoff = skb->encapsulation ?
+			skb_inner_network_offset(skb) : skb_network_offset(skb);
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1

