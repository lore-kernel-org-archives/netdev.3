Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756778;
	b=Ng8zMrMzAIa0N14GASv+PPUluzPAsYy9twEz/H/rqlKeIgJgw7THKoyKf9YRHAwu+0lV
	 +pgtG/VU0v/jPHZhREjn1oFg/TbaUeWsHMUHW6FsqIdrQ7gt2eTmBQXyeZnW0T3l/fnJx
	 5Xx19d13YlWSMP3Uy5RMDMet+6wTziI2+pxj66VqSt94hztZyrrMDtmmRVDTc3WnHU1Vb
	 dGbQF1gyi7xKpVeMGsMBZY5j10/hoXoeMjpKrcysCyz1eTa0OvkEWwHae+q3VIPB6j9xO
	 EdMb44NQiCYhFRmfgiuWJVNZwAkDPHMvc3RvUKZOHuo2sLBupPn+ayQgFSW1Iu9gg5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
	b=e6xuxZfdV51nmfc5pfSMuXUzhVFWdHSjp/8MqKPv5bArn/EUcEz8xBy5Rhfm7Z9bVsVk
	 3+G06R9NmNnaMvzXEwZGKUj5Q6xWhq+JcCQ+ehipd6t4d1u98aR605xGmGhs+tt/HM5hr
	 qq7/BF3iyZXJUO0A6ufaxr0IYwij8ts1KUfdDnOoDlzzXjdPmH5gSKGDvCbt4rRlizmzN
	 Uh/upck6ILwMYo7ZjeHSEEOStPpz5FU3D8azYJuwIyCp0zhEgA9iGOSrpOkLAJLpi4EOv
	 I2WTP8zmfPbpkxWObz664YeHdCHUiKe7K03jkJNIOimjhirFzYZq+siOkoSUWw1P8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cjXdylKS;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C47606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C47606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cjXdylKS
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-918f75a68f0so12144026d6.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792756777; x=1793361577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
        b=cjXdylKSOAu5bD0QGJAPwgXR8f/IvlXcgMSjZ7tyObvJC/6q8pxPUAsdcCYrMy4a+F
         psPWB1mAg2iznCNJNp3GwM8IEw4XumEmizNYh9DBpYGSIrSJYqTjUceN7ZDY+mYn/6zO
         hXQGMoUJ0nih7gjkktxUEn6E+LtvOqrd9qpqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756777; x=1793361577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ODXqAHSl1PzO+WlHi3VkH0G2LZlWHwMXjD7qVV4H+Tc=;
        b=vRdyK0ia0a4Nf/TUPi7PUr24QcXKz8Cr77OLGUoHNduFojzUbygGBtKPZEbjQK3PWe
         uOFWaByfkodKqhzZut2SfnXPpRGVeSU9Oum5QK6MwiSEueR1CGAiJA9fQ3pq3c/gB5zh
         YxWNQU/QngNONs/+4lTy9HNWGlechDVK9G9Ao602zQN8LMz5Sr8ISGGEcUhnV+Yl6vzO
         j4MNQUUHD1DKKPqdgGRgn6wUk8FHkk3HLL6UZi7oBCBBQyTqaWNbLH6g/Ear4VaitMZM
         PJeX2Ki7SfEg3E2Yg+0kMYjvxL+vmvPA+f/+wiGAmzgY/7xrMZxzDvTx/kQME5G/E6ca
         G+Jw==
X-Gm-Message-State: AFq9FYJ8BMkt2i1v3SGHvDWPQcnAXpSlXGHBYvUdH6C3L65gn435zROJ
	dmldpKVKk0JkJOMMQLUPFLatIEW2cAn2fUP0JrkAfOCne3Gg7SYx03liac8RUZneYcAiVfQOKLP
	w6os=
X-Gm-Gg: AYBFou17wMKDhZGigDMCydt8HYwnRm6nwaJLdd0VDaeqroYlTW8YJKKGXTJ6FHj8uQs
	ZVj7ymn/MkFStPkiDCodI1Hz9LgerGzuzUREXKT/ja+xjKJNiO62RdTmo0rOfzfwWkilEE+cM9I
	A8KhHViSCovqw+on1NTdGWf7gFh338KL4nR5NyzNCI8MyIl3Jr4mbRopD1No1CEYWz5hQoir+Rd
	py4avNrgTeI6G+huMrSswvMwRkjuZJfJD1h9GLASXoLXHnPGo+5q7LCMd1don2eY+LHVngDO0Hd
	K9/NGJeTWMrB4iDdntt2dFg02ST8CAa32TYRtNRGUiuqv44iHhRHDlknHz6Zo6ZMuT2cvEhuIwu
	uqnTNgkTmxA9K+59rUQvHwiNn7sprPyYkCWUF2Peo+BdIa3V46THejFq+NkF7nhR+lgy1GGeFpX
	JNDfTK1Yun61ooGFEhcHysmHCVxd+MZ0Yaf5GsT0UaAwG5OUJnfoVEqm1UIhiE1gCfa/QkN5QWS
	Fdnv6FwQ3Ir/64yDAagAGsWWUnxnr26z0AMSgVayJGXBKLHY/seHym0awxwWJJvM0c8QYRCqfeJ
	VeE2um8Jifq7Mgg7K9KPzzI/O/PSoxHi2UAIAOX7Nw==
X-Received: by 2002:a05:6214:328e:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-91c3ab17827mr24192296d6.30.1792756776725;
        Fri, 23 Oct 2026 04:59:36 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af493sm18358246d6.9.2026.10.23.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:36 -0700 (PDT)
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
	Pravin B Shelar <pshelar@ovn.org>,
	Martin Varghese <martin.varghese@nokia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	dev@openvswitch.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 5/6] net: openvswitch: ensure a linear inner Ethernet header on TEB pop
Date: Fri, 23 Oct 2026 07:59:20 -0400
Message-Id: <ACT-N6N4.v2.r0.20261022191829-5@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-3@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-4@mojatatu.com>
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
pop_mpls() restores MAC_PROTO_ETHERNET when the popped ethertype is
ETH_P_TEB, but skb_mpls_pop() only guarantees that the MPLS shim is in
the linear area.  When the inner Ethernet header sits in a page
fragment, the datapath now claims an Ethernet header it cannot access
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
internal port up with MTU 9000.  Install a flow matching an Ethernet/MPLS
packet with one bottom-of-stack label and actions pop_eth,
pop_mpls(0x6558), output to the local port.  With CAP_NET_RAW, send a
4128-byte AF_PACKET/SOCK_RAW frame containing outer Ethernet, the MPLS
label, inner Ethernet and 4096 payload bytes.  The two pops consume the
linear headers and expose the inner Ethernet header in page fragments.

The Fix:
Pull the inner Ethernet header into the linear area before restoring
MAC_PROTO_ETHERNET.

Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Link: https://lore.kernel.org/netdev/e85fa16e-df3c-43dd-bb3a-9edca07200ea@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/openvswitch/actions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 27152bca8a8c..03b31e33e880 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -153,8 +153,11 @@ static int pop_mpls(struct sk_buff *skb, struct sw_flow_key *key,
 	if (err)
 		return err;
 
-	if (ethertype == htons(ETH_P_TEB))
+	if (ethertype == htons(ETH_P_TEB)) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return -ENOMEM;
 		key->mac_proto = MAC_PROTO_ETHERNET;
+	}
 
 	invalidate_flow_key(key);
 	return 0;
-- 
2.43.0


