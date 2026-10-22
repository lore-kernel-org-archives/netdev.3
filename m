Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660957;
	b=thNBSIxOGvdZFOL/puljH3ttjCSQ3J94Pgmgo599zZrejwq20IO5cwYC0Lhe07heMyI/
	 jgJC7PyF4Hpd+zWwQYkbNsdrC0RJPz7yPoeUZoXuFmIZN7pYSfEmYP1NKXjMfEXOwNkp0
	 nAnuGPoDN6lEzE26cBUT5BoVivZGQACKeqyFoCBFW7d/RyaS7E++i8NOvsrVmRSP2q6HK
	 7YejIXlqna481VrDjvBFJAOEIZcQyxoDQJ7502t3VRVqJ+smYQVexdFxs18MhlrjhBvuq
	 ZTca4rVeOtsefzROmnvXZJwDeyq8BADCD7VakvojVHwME89vp0jakqBZ/7afeVNqSLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
	b=0OaKBWmpExm1irsRnCjRH+mYc73tea1CII4HPXlEP6gdUxpBA/hjSilRNtB4Pp3sPnMg
	 ZlJJvzntYESsXXjdAV0ln+YukVo7k+beT8doGgjW0euZMTxhNjGzV3WS+VimbGtqh2+zW
	 FIXSGqEwXA0EhTSo+hLMhAQ51C8UgoV8FlRX2kOxTweY6AppmdagfUJCpZDkRATGuYwqI
	 9ff6nr3CldjLRC+puSk6yGcRZmtSUiJp7FdS+AH4U+nc27Ml+ZFnHzCP66B5i9Yha69Eq
	 2RHv/kcf3m709TX2Gr9DAb/AQ9GXWYU5lyzLio/VB2WayABVkjRz7Lq/LEZ+OURI1dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ANhnSiVf;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C0606A332
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557C0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ANhnSiVf
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cb1c0e851so115988085a.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792660956; x=1793265756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
        b=ANhnSiVfzgB9MNcKy4OsRyOoBJPY3Gg2xPECaa9IuD/0Y94JUV7KpwwC9JBBmgXKX3
         7R/T+gVz2BoscttxgoKYb3emHKYJkgGxHjkGjDpcOePbaweY4/AHbAYIts1hoD2KbBKI
         1JF8gqqozwanGCLuNbgyS5FTNNwMW38eXf4Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660956; x=1793265756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=icU9YO4XysvgHIVlrdyvNfTHVdM7KlIy9zFDYV/1joU=;
        b=W333ac+WBbQjkf4bltaZt2McTrp+J8fj3s8KYK6cQZBQsQ7VikYptbRcQpUDNKjE2B
         hSJWMBCwkGwpnS39RK7y2ANezZJwkDUMXWthkNE7wZXgBrS7nzJEvGq8xm9Qfv0P8qPh
         zldnlvukoqvXh/TXg28IGGxDnZ8WCLh1YSS9jjosr3Wmz6JfqrM8dux7hsa4Yj3LfXIA
         njXthCgmj8qkedQ0G65YcT4P9TnKdXMJIX2FkBw1/3sfNA8Mah8bv6vvWEcd4m1AivHx
         nbi4LWP3v2oLRPdIm6xmlYd5fzegM9PIVahIvU7QUGybhuxo7coZ4JrAlBI5RHl8FLWh
         ElpQ==
X-Gm-Message-State: AFq9FYLC4mIJlyKGBvyIa0mjk4Fc33Q+vU6jvjoWKraUIFgNrOaT6vyU
	kCHm+y6+YPyrRNp5b+aDy3OAv5dz4B4zkrJ3Xa9uwEzgPUi65GuZbTyxC8mcTyxdFYAbW3Ao/PH
	PK3I=
X-Gm-Gg: AYBFou3LhiWciUxjTsQEuu44OzTt5rwPM9sqpoLdzs2JLadbkRs0E00YX8Pmv33buSz
	6Lels9lLef3Pk7D+d3pyuQnkK4q1o82evAFTX/fXuchjrSIv3WlXCZzshTrnZH9gM+UuC0P9ox3
	w4X7fG4WV0bF1oQ+/I2KvckYrnB7ooEvXR5u0CwyDK8d0hrCk/S4YaIIFiHH/cmJg2QZGIwEiIw
	a3lcfL+F3V2Y82EI4Ee4esLAtF+LyneRZbCmaLjudWy9sfSFfxeSStfZRGN5alnloUfz4alJMeJ
	+TyT61mx8IkT826AZRX6oF5pTck/sOTR5E1EeMhbc8w6X9mrxsfY7qIUsd37sI6/0l/QvaD98kp
	hoPKX/jaKH35cYoTbI5tavOV8sXkiNhoIm6s1VfbXspJhbRtGXi2eH/vM6fOJehW71Jui5WEz9G
	JiZZsZpi1EJJZDgfaTX6F0KrK1rTTnTqslgxGoGzaQ1UFYtYuvt+78TB/m5QIj9ubb0gK+dCjro
	KhYCeaXSV8kjA4N82Mm79h+x45xM85s0yHowEvnnsYLd9qmkgIQIuh9QP693spiZioS4ezahd/Z
	CV4GaE41B3HAhr32G+Wcgg89qH2Tbb3ez1XcGNS3S16WwrU=
X-Received: by 2002:a05:620a:294b:b0:93c:735c:2477 with SMTP id af79cd13be357-93f57f6fbd4mr922058985a.21.1792660956306;
        Thu, 22 Oct 2026 02:22:36 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2a60fsm469884685a.41.2026.10.22.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:22:35 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Garver <e@erig.me>,
	Yi Yang <yi.y.yang@intel.com>,
	Jiri Benc <jbenc@redhat.com>,
	Pravin Shelar <pshelar@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net 5/5] net: openvswitch: ensure a linear inner Ethernet header on NSH pop
Date: Thu, 22 Oct 2026 05:22:22 -0400
Message-Id: <ACT-N6N4.v1.r0.20261022051412-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-4@mojatatu.com>
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

The issue:
pop_nsh() restores MAC_PROTO_ETHERNET when the popped NSH next-protocol
is TUN_P_ETHERNET, but nsh_pop() only guarantees that the NSH header is
in the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath then claims an Ethernet header it cannot access
linearly.

Output to an OVS internal vport then calls eth_type_trans(), which
pulls ETH_HLEN from an empty linear area and triggers the BUG in
__skb_pull():

  kernel BUG at ./include/linux/skbuff.h:2830!
  RIP: 0010:eth_type_trans+0x335/0x500
  internal_dev_recv
  ovs_vport_send
  do_output
  do_execute_actions
  ovs_execute_actions
  ovs_dp_process_packet
  ovs_vport_receive
  internal_dev_xmit

Conditions to recreate the bug:
On a system with 4 KiB pages and CONFIG_OPENVSWITCH and CONFIG_PACKET
enabled, use CAP_NET_ADMIN to create an OVS datapath and bring its local
internal port up with MTU 9000.  Install a flow matching an Ethernet/NSH
packet with a 24-byte MD1 header whose next-protocol is TUN_P_ETHERNET,
and actions pop_eth, pop_nsh, output to the local port.  With
CAP_NET_RAW, send a 4148-byte AF_PACKET/SOCK_RAW frame containing outer
Ethernet, the NSH header, inner Ethernet and 4096 payload bytes.  The
two pops consume the linear headers and expose the inner Ethernet header
in page fragments.

The fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.  This is the NSH counterpart of the MPLS/TEB
producer fix in the previous patch.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/actions.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 03b31e33e880..cb7e16c6a8ef 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -314,10 +314,13 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
 		return err;
 
 	/* safe right before invalidate_flow_key */
-	if (skb->protocol == htons(ETH_P_TEB))
+	if (skb->protocol == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
-	else
+	} else {
 		key->mac_proto = MAC_PROTO_NONE;
+	}
 	invalidate_flow_key(key);
 	return 0;
 }
-- 
2.43.0

