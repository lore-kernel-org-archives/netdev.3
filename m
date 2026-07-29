Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E344160D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366097; cv=none; b=VVL1lG48F9uoNO2RdYi/C7Wa9MngkdTIwLrWZdequ6YNknW8HLgNeoAj8qKV5Xk+QRVebD+xbhtGFarRbXzwrPkGKQRnMvfCaS16/LNIm2qLOpqOMfZXlXtF+f9QSvJYUUJ+W0Aj5YfvjY7+EFrqWTNjwL+S/D6OLZl73UdVQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366097; c=relaxed/simple;
	bh=Oyb45EYofyM4dN00IPyHH0yZs9a1iN55YP3vYtNIdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnfq9tQyiXCoVb4JJg31zZ3iPtlO+Pt/6e1tPSR9fgDAbuWeXTMUIQxZYx3Q61RiMGqD0nndUP6HNVJzez1/uit9AO509gub0jrAoWwUjAr/0DyGro/MOlo2tr8MokX1x8IuZ5fr8TFxEVGeeMvTcAA0j4bXrjuDqH6+n8NFSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=rijZq63q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="rijZq63q"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so142049a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785366095; x=1785970895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQUnJujPcFsZ6VetQyxf08ib9Ig2H7AajXt4skg+zWQ=;
        b=rijZq63q+oPsIrOMxQr7AeQ+zNvmWcMRfyA1vG+NO2lC/OrBAAwYMj4YS5hJg7mD/B
         jVFVALBM355p5Cco/oTphy+9YAHHhrPtWT+jzz10+F8dnCISBY0uNHYzxOkA/dAkLG3H
         hxSpnPEa6cOgckpHscJUcnaxgTgq5jMNPNqajQ8eqjKO+zqrFNSwMyl/e8eH5iDqa4Fp
         uThNN7Ng1V9n1p7Io37MpuBlOcMRRwT9fGFfTIAEBEqq8LE/U9ny2j8slj09bzVzLPw2
         w7uN4sBkrJtxZZFqVenL/AdXF2l4tt6p/nWbTsVIgostWjAvby8g/cRFkzzYaWn9DTh+
         0apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366095; x=1785970895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQUnJujPcFsZ6VetQyxf08ib9Ig2H7AajXt4skg+zWQ=;
        b=TOCjv0fY1Ay1kIz4uHzDkvj/ARgT1NwDaoy+QpDADCtJIZlzKT8neA/HnN5CFpKUeb
         YqYZGKlbp8qKYyaQI1y/zQoPTKHBX3/OgtXrCHlzqrp2K6qObZ37+oqs1W0Ho7t0fBeH
         JLfy2UWbUIrNHuJf1z5nvf8RdWKlwl8QBayrgv706WTusriIl64u2MLAiNy9j+6gSbpo
         5nmC2nfSckfmDuEgcEbjmmhP7wU3yJxoST/zFhCNaU3sERLmHuuGtpgHtU29fJ3G68Qf
         z3wQPqzaZq3/AKvKeTF0rMEqpP5kNAMoOhbeVB3vC0Twgc8Ptg8oSJZk2i3CyfAyUmpL
         Zw0g==
X-Forwarded-Encrypted: i=1; AHgh+RrenirjcAGiI07tdsnVNfcaeTdvhDJTriAFRRc6Ws8DqGwkJKnoiA48TtpDxH5JllgsgUKfj7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxPtWXTZV0QB/StLlRWU6mJurL2gSC4S9YRW182+BHIPB1Vv/
	vzjP1BRdAAVA1hiSusTcfAr8TMgyzZV/a5gpjjn2WW6XPcgyEV+Hg9m1u9gE60JRgQ==
X-Gm-Gg: AR+sD12ODGhYbBAp4Nu1gGBmwXldy3R64yItCZIo+BI9zMGsfYIXj9x0u+SOkWRFQLc
	qxIDPgmJyVjdfd/t33C17MAl2nZScEKHvtRhnSsJfcHRooJRxxoWsjVJ4lQxxSXPHAL73k9cleD
	VIsAjDjON/DQlS1Cf84Q3nd19nE5l7iXNKo8WHvA+vhkgUGOU1dOUaYsHt2oRw1ng0ndP6CiA1n
	7PfRB58hQy6mE1NNjEpMn5FWZrRw7bIzzqSbSLtzj4slW6tsSABtsYFTQY72e4I8WKCLOMEeNXV
	qCJa7AYIbllTOSeNXm3jzNXIcz7wrDxGl+xcxd/KGX2auQcBpuyOBeqiELnk5KeUz8b0JrEW3o8
	HQPIGsLeHeIGccuiktKQzizZ3gJzf36MfXsFHmlYCA2sVhIRYEa8Ea9NxXTBjIgKdCehMTGroe5
	9u70T/wHBuDireycBWRGAZ2HP/TlXQ++tTvR/Vrxa/atm3FmF93hWpi3ASAgkAZjksEA==
X-Received: by 2002:a17:90a:dfcf:b0:38e:c1ba:4f94 with SMTP id 98e67ed59e1d1-38f9b83aa0bmr225471a91.2.1785366095305;
        Wed, 29 Jul 2026 16:01:35 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm13777272eec.23.2026.07.29.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:01:33 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [RFC net-next v2 2/3] bonding: build NS probe headers before inserting VLAN tags
Date: Wed, 29 Jul 2026 23:01:18 +0000
Message-ID: <20260729230119.2717507-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729230119.2717507-1-xmei5@asu.edu>
References: <20260729230119.2717507-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bond_ns_send() passes the skb from ndisc_ns_create() to
bond_handle_vlan() before any header exists: ndisc_ns_create() returns
only the ICMPv6 message, and the IPv6 and link-layer headers are pushed
later by ndisc_send_skb().  Tagging that bare message causes two
failures:

- Corruption: bond_handle_vlan() inserts tags at mac_len = ETH_HLEN,
  expecting an Ethernet header.  arp_create() provides one,
  ndisc_ns_create() does not, so each tag lands 12 bytes into the ICMPv6
  message, inside the target address.  Every config with two or more
  stacked VLANs emits a probe no peer can answer.

- Panic: each tag also eats the headroom reserved for the IPv6 header
  (LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) = 56 for a plain
  Ethernet slave, leaving 56 - 4 * (N - 1) for N VLANs).  Six leave
  36 < 40 and the ip6_nd_hdr() push underflows skb->head:

    skbuff: skb_under_panic: text:ffffffff85eef44b len:84 put:40
      head:ffff88801400b740 data:ffff88801400b73c
      tail:0x50 end:0x180 dev:veth0
    kernel BUG at net/core/skbuff.c:214!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    Workqueue: bond0 bond_arp_monitor
    RIP: 0010:skb_panic+0x142/0x230
    Call Trace:
     skb_push (net/core/skbuff.c:224)
     ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
     bond_ns_send (drivers/net/bonding/bond_main.c:3255)
     bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
     bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
     process_one_work (kernel/workqueue.c:3322)
     worker_thread (kernel/workqueue.c:3405)
     kthread (kernel/kthread.c:436)
    Kernel panic - not syncing: Fatal exception

Build the probe in the order the stack uses: bond_ns_build_ip6hdr()
pushes the IPv6 header, the probe traverses NF_INET_LOCAL_OUT as a bare
IPv6 packet, then bond_ns_add_llhdr() pushes the link-layer header,
bond_handle_vlan() adds the tags, and it is transmitted on the slave
being tested.  NF_INET_LOCAL_OUT must run before tagging so netfilter
sees the IPv6 packet ndisc_send_skb() feeds it rather than a half-built
Ethernet frame; ndisc_attach_dst() supplies the dst
ip6_route_me_harder() dereferences unconditionally.

The tags now land at a real Ethernet header, so the target address is
intact, and pushing the headers first lets skb_vlan_push() grow the
headroom itself, so no push underflows skb->head.  nf_hook() returns 1
on NF_ACCEPT with the skb still owned by the caller; any other verdict
means netfilter consumed it.

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/bonding/bond_main.c | 106 +++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..d5a7a7dd1eb2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,8 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/ip6_checksum.h>
+#include <linux/netfilter.h>
 #include <net/netdev_lock.h>
 #include <net/xdp.h>
 
@@ -3232,13 +3234,75 @@ static int bond_arp_rcv(const struct sk_buff *skb, struct bonding *bond,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
+static int bond_ns_xmit_finish(struct net *net, struct sock *sk,
+			       struct sk_buff *skb)
+{
+	return dev_queue_xmit(skb);
+}
+
+static void bond_ns_build_ip6hdr(struct sk_buff *skb, struct net_device *dev,
+				 const struct in6_addr *saddr,
+				 const struct in6_addr *daddr)
+{
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
+	unsigned int len = skb->len;
+	struct inet6_dev *idev;
+	struct ipv6hdr *hdr;
+	unsigned int tclass;
+
+	icmp6h->icmp6_cksum = csum_ipv6_magic(saddr, daddr, len,
+					      IPPROTO_ICMPV6,
+					      csum_partial(icmp6h, len, 0));
+
+	rcu_read_lock();
+	idev = __in6_dev_get(dev);
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
+	rcu_read_unlock();
+
+	skb_push(skb, sizeof(*hdr));
+	skb_reset_network_header(skb);
+	hdr = ipv6_hdr(skb);
+
+	ip6_flow_hdr(hdr, tclass, 0);
+	hdr->payload_len = htons(len);
+	hdr->nexthdr = IPPROTO_ICMPV6;
+	hdr->hop_limit = 255;		/* RFC 4861, 7.1.1 */
+	hdr->saddr = *saddr;
+	hdr->daddr = *daddr;
+}
+
+/* Push the Ethernet header after the LOCAL_OUT hooks, as arp_create() and the
+ * IPv6 output path do.
+ */
+static int bond_ns_add_llhdr(struct sk_buff *skb, struct net_device *dev,
+			     const struct in6_addr *daddr)
+{
+	unsigned char ha[MAX_ADDR_LEN];
+	int err;
+
+	err = ndisc_mc_map(daddr, ha, dev, 1);
+	if (err < 0)
+		return err;
+
+	err = dev_hard_header(skb, dev, ETH_P_IPV6, ha, dev->dev_addr,
+			      skb->len);
+	if (err < 0)
+		return err;
+
+	skb_reset_mac_header(skb);
+	return 0;
+}
+
 static void bond_ns_send(struct slave *slave, const struct in6_addr *daddr,
 			 const struct in6_addr *saddr, struct bond_vlan_tag *tags)
 {
 	struct net_device *bond_dev = slave->bond->dev;
 	struct net_device *slave_dev = slave->dev;
+	struct inet6_dev *idev;
 	struct in6_addr mcaddr;
 	struct sk_buff *skb;
+	struct net *net;
+	int ret;
 
 	slave_dbg(bond_dev, slave_dev, "NS on slave: dst %pI6c src %pI6c\n",
 		  daddr, saddr);
@@ -3250,10 +3314,46 @@ static void bond_ns_send(struct slave *slave, const struct in6_addr *daddr,
 	}
 
 	addrconf_addr_solict_mult(daddr, &mcaddr);
-	if (bond_handle_vlan(slave, tags, skb)) {
-		slave_update_last_tx(slave);
-		ndisc_send_skb(skb, &mcaddr, saddr);
+
+	/* ip6_route_me_harder() in the LOCAL_OUT path dereferences skb_dst() */
+	if (ndisc_attach_dst(skb, &mcaddr, saddr)) {
+		net_err_ratelimited("NS route allocation failed\n");
+		kfree_skb(skb);
+		return;
 	}
+
+	bond_ns_build_ip6hdr(skb, slave_dev, saddr, &mcaddr);
+
+	rcu_read_lock();
+	net = dev_net_rcu(slave_dev);
+	idev = __in6_dev_get(slave_dev);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
+
+	/* nf_hook() returns 1 on NF_ACCEPT with @skb still ours; any other
+	 * verdict means netfilter consumed it.
+	 */
+	ret = nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, NULL, skb, NULL,
+		      slave_dev, bond_ns_xmit_finish);
+	if (ret == 1) {
+		ICMP6MSGOUT_INC_STATS(net, idev, NDISC_NEIGHBOUR_SOLICITATION);
+		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTMSGS);
+	}
+	rcu_read_unlock();
+
+	if (ret != 1)
+		return;
+
+	if (bond_ns_add_llhdr(skb, slave_dev, &mcaddr) < 0) {
+		net_err_ratelimited("failed to build NS link-layer header\n");
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!bond_handle_vlan(slave, tags, skb))
+		return;
+
+	slave_update_last_tx(slave);
+	dev_queue_xmit(skb);
 }
 
 static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
-- 
2.43.0

