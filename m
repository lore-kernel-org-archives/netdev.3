Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756780;
	b=0TU7QrXjx8vuEZ+SNjycUWnydnptgV2PqIZYWuMNmUussxfvLow/prLWydIZt1ViVnTH
	 zeyGWh+hS+nTEZ+zREzG7N2H7AWR47es0XVffhOMFXtw/kNpX7As40V3qJ2DSwJVE0Fal
	 NKSprfe4ohwxPMpBsSUQLagp2keA9Jvbss/LiR/jyx4Rg/xYe2DYl8MMQ915dwQEM3g0k
	 1UDo55adHVWOoEXOuxZeR1M4RXfdJ7g6wHJxDW87ENyZg9YNivUdg4bs5Arzptz6Cy5hw
	 L7ub0xm+pPkcpTqJkGENy7SK0vi6FiT3/+XlrpAhF8QSwtfYgFIdNMksuwbylP90INQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
	b=1T385wO9fbytcuSJnywBLj1ZS0G7kkomWc3dlNikaoMAgHpAwEVYEGCGko4xjlS4CE0J
	 6CxWhGOVViPh/Lmz4ST1fAWpLaav+/QJNIklogjoHfvCfgZF7SIAKpwJ6b3CoOVPIeqK9
	 uLdXDe1ogybhrvYVX6ZrcydCDEdZD/MvxkRBiFan4NzJMEfis7CPeRYMqpsI/UXh2juZj
	 BI1v4/tqHUQk39eb3SxAyh9BjGSVd83DcIzxtd0Dv7bySWpJ2s4NKMzMwH48jaokzmQtQ
	 onWRUVItMNKEdIir1mULTTxWAo3DT6r0o1nAYTTbrgvxxW9mgy5kKCss3hnHAr8zyvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u1430m0q;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F27606A333
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F27606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=u1430m0q
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917d595138fso5659946d6.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756779; x=1793361579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
        b=u1430m0qP/A9kJIJFSLgIapQETPAFJziJC7HIEFc3GT5frECg0W+c98paaGch9M/x5
         /CkHWTgVCan9thcUYoK8w/xd3aTPb9JhLSM25tVKpUd/jwLzYccDDp3VjEDWk9X/odCX
         uoZ+lPVTdca0C8NH9fz4l2rTb1QdKoiCe+VHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756779; x=1793361579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gV9JJW+KLxJUN6kglpTyIoS0mZGlvplEh+/pn0zPRYE=;
        b=BRlwK+R+BT0W2YeU6FsCgsRV4sD/iHqlx/Keh3wnrI8LrENZJkCuPh4/PCQM7nqg1g
         wEs8knpppSebD8anDEedhvwW52VMnNa0+ZlIoti5VQnzZY8kNudkA/+fe3uMfa5BBN3E
         lTjBA3z0WJHQRRzte41B+1gOuqavBwMXNOpxmWfAzeWk0BPI3GC8gvOm31Tey8u0ZcuV
         Avpbr0/NVLG7mlR9Yc26Iqv2pr+ilfejyKv6hCmo/OpXHCpJm5Jsu0Iz1LFyU8qw5hua
         HJGJXFBh0NigILpE92aZRKfGPgGcpfK7U5VY5zCAYmd2JAxu1Atsy1p5ehYclwqANkYW
         XoIA==
X-Gm-Message-State: AFq9FYIy43UvMUIh2a+AXo5u6pbwfRJZxj0e+nOFuE8r1FnHZvFb42oH
	VrCv4VRE90dg/O/g/+4Gktoa2ByuvAeNfit1x8Q0KStFAs/MjbyJ7SwrHJrF/TKnFdpHLpWf9X1
	Hoz4=
X-Gm-Gg: AYBFou3Ji+dbmAxYTKsQmHRAk3IPxWIbofoJl70PE2VIL+vImQK9ob/xAtYN1o7HN/I
	kIlcj69r37R5m/Y1Vyi8k+gF+PawjxKbPm4cfnCfFgmWk/QxZ1Xcrj19Kw0X6+R9equcwFln5uv
	w9XuFNvd4b076q5tFdto8OXY28F4yVI/OWCPT3iog4tAULJj0rHDtkFiDl+zUOOkIcZ25qYTmkh
	Dl/9qP5b1PNIp7S0HeSXc4c1mv531wZhMbHO/GDEmsKb2MsTG00rCoZ81XtKfSQ4Ah7ZUdumuJN
	4Wqrz/NDCGDF03wuDFov7ZZoM8dLbw6zw0kV8DJhAgx465LTvFT5JGVh1HA6FdusrqF84OeIXLi
	S2MS41mIPEnVvOwmYu4eUEsBDMmmgO+pLYmvBQW4giZp5Ou5b8wtKMrgYhJxl5BDY/3XZU93M4U
	6k9F6Du9QWXUBS8COojyPUPGD7YIGYf62lObu4qprXxdta3Bcp4OqlvjenJ4IC2cFBUCiIANCP6
	CtedQpOd8vSOQjHB3CYAGqNkEfWlI/6FItVEct/UfmV2Jmi3S49MEUXAkZ9/Wo3PYPpE4lfUa7N
	ho6ImXAGPVq9Y+ZqTiFzMKl9b/2Jcvao0Lbkz+/MVw==
X-Received: by 2002:a05:6214:509c:b0:91b:8d12:bac9 with SMTP id 6a1803df08f44-91c3a4bd85fmr27351516d6.0.1792756778735;
        Fri, 23 Oct 2026 04:59:38 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:38 -0700 (PDT)
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
	Jiri Benc <jbenc@redhat.com>,
	Pravin Shelar <pshelar@ovn.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 6/6] net: openvswitch: ensure a linear inner Ethernet header on NSH pop
Date: Fri, 23 Oct 2026 07:59:21 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-6@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
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
Reviewed-by: Jiri Benc <jbenc@redhat.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
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

