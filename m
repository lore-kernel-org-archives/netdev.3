Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852134;
	b=vRExnZ8l/5vjzGcnTVN4jxgGiLRQ9ey3wdY0XmC9RmYoqMrnoUypk6b1RlwJeUtUvgaS
	 G1tI2m+NKYKjizs9bDyGRhE2AGatlM8iOuZAvpuTo8E8jE4yuw24ITKWmbURUGkSo4D/b
	 n+muUHMAIfUunacJ+fxZX+twM8YSaIf0wifdw84Qu4M4t6VYYmAUvBiHYnNTA0Isd0+Kc
	 R0/MJRxat5FmYqYxFM0vkIhjUWtoPXMNhZuk651vyb+qn9PEfK66UGWB3QabEoA544tcT
	 sh3T1FSRBzqnbw0wgo4smqVEvZyM6QekU8tGKFlqRw7GMIun6rCyoFDUOxAGcanK/gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
	b=uF/1vQmrnfM8v8EkRv0tJXG/6XVXJB/7bLjo85SFOxLPDUmpcg6HytsGZjPr5pynv8r2
	 16q3CCV1gw++Q6ftEjMXc3hwi9AWtb+I1Bp/dSAejDAtwA/K1TOw1oLi3N0HVfClYPy3E
	 j4z+9vSrx9/8FUTAGHapzrzlGl6tC3u4T2ZDRGW/1L1UahroP2GsQk2PlDUIcC1Fg+ve9
	 j9lE0kMb0vBMf+h9VeMmTapriRuupHw4wfeojctFYuhFO85JwaIkuwqxEODiyzc12zrBm
	 sZeH6h/kXEmN8j+OBR0u5cShmcHcPxH9m6WgJMKEwZkVsxJbj5EZ1x0zTA2r0jEQN1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QStxbGRn;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74460A2601
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F74460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QStxbGRn
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b83459526so21313546d6.2
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852133; x=1793456933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
        b=QStxbGRn1F21eax8GW4sa3RsUGY0MbFGOmXRL0gC4hTuM3DUeyUGYtdLQW1lKAl8D8
         5K+MsA1tF5QDxiSWz5eSM0zc5XeGKxxT1e4GHxv82CqWtvTa2nr7l0TbaxEbEWClvp/X
         H8+aU5+gnH6qeGkCdHe8qRWiH4uEnUlVe3/yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852133; x=1793456933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZyYYHpGqq1G8pX8JZY1figUKThlyyxg3qJ6OuB35Lo=;
        b=cZVOWi7a+yc3V9r+kIB4nDXMktIFsjOobKzzTA/LsaePszbWKWMCYUNOSlMNw9IJpx
         rInb2e+zJ1IVyGXPU2dWQTle3j7OrJP/XO7JQBp/APtb2QeGSX36N71VEhU5wl7kaGD/
         GzOCv7VuyXlfSIij9scnn88qCf0+vZmgYIbD3LRl+kyE1oLFerCJD0iS+c4LpxohgDkv
         hg/5PSUWpKrmC2H2priFURvytKSZZKRB7Q2hqrg7whvgTHSspMv2viatyADQWxkNc+zl
         JF4kPnrOUVGFdQjfUpxgN+OMbgYeQ0xKcC+AK8KD+ZD9N4Syk4/dF6HZDTsqP2VP7HQ2
         RMGg==
X-Gm-Message-State: AFq9FYLXSJ8FTUgmx37yL47suWISEU6NGoJImtht6zO5VW441L1SKc4S
	QzsG56wjaGByY453T4BjJcNC2/GISLie0rsLVsheZcL60vtUy4KekWB6igezRo13uf8D1KNJO1J
	/dBQ=
X-Gm-Gg: AYBFou1xMrQVr/bgGJran9fz8FbIreppkbm4Z6a9ylUwluwIcAyxOcAI7ThXsH5sLEm
	BcMoAQMz/r5QJwTDRO/qF6I3d32RiZgPAWoGteUs90Kb3d2sW/scBXIwRJ2r1KzMrfPsFNT5or6
	IOG/xV69/6q47bOI71A9AVxQBd8sKJ4sVAljvWRsTm/eXPJYsIBBfG5n546atkkarUeYZaqoT6P
	AYf+SQDW93YbWW2WTtlw8JcgSeqd/bbY9aK6S4wt4SC2tVl+ZlmVT7DvzdSbzIcHK5LYkwEEKtH
	vSTvlEL6lFkCeUk5TNa8EY6rbvRHmwLnCMGeD/n9t02r2h6FgVAyTmme0Y0Msi9ZsvfLJDPQvOT
	YmxoklNLFCtK+MQMcY9cyJBAQXu2zChReWOdxGDr60ciDND0GqRp5P94DfIoR3pxv4S54E++e62
	Bdsh6gHt7eTGTBqXm9Ph5cfW33lZ4mXa4sAtpqSaJNDlKmapBDWhDPH1BhdskVA2WVJMGHilwgH
	27Jw/x2Ke2wNbYLZVXL27o2fz/Q68SlZFMLq6+YCtMBVQbv1gVX0LCCXkNWVtlJV522XcBbG5BL
	si3q3lAAi1av+LxtHUQng88oYQZslyn50vTx70UnlA==
X-Received: by 2002:a05:6214:53c1:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91c48e36df9mr32053496d6.15.1792852133128;
        Sat, 24 Oct 2026 07:28:53 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a7cd7esm22349976d6.2.2026.10.24.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:28:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/6] net/sched: act_mirred: ensure a pullable link-layer header before redirect
Date: Sat, 24 Oct 2026 10:28:38 -0400
Message-Id: <ACT-N6N4.v3.r0.20261023200137-3@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
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
tcf_mirred_to_dev() may redirect a packet that has no link-layer header to
a device that expects one.  TUN builds a valid L3 skb with mac_len == 0;
mirred then pushes zero bytes and the IP header is parsed as Ethernet by
eth_type_trans().  The same happens after a VLAN POP_ETH or MPLS POP chain
whose producer did not leave a full inner Ethernet header.

The Fix:
After the existing push/pull adjustment, when the target expects data at
the MAC header, pull dev->min_header_len bytes into the linear area and
drop the packet only when that pull fails.  This ensures that a consumer
such as eth_type_trans() can pull the target device's minimum link-layer
header from the linear area.  Do not gate the check on skb_network_offset():
tc_mpls_l2vpn.sh legitimately redirects a decapsulated packet whose MAC
header is not at the recorded network offset.

Conditions to recreate the bug:
- create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
- attach a filter to the TUN device's ingress hook, with a mirred egress
  redirect action targeting an Ethernet device such as lo;
- write a virtio_net_hdr with hdr_len=1 and an 8192-byte payload.
The unfixed kernel parses the IP header as Ethernet and can BUG in
eth_type_trans() via loopback_xmit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Link: https://lore.kernel.org/netdev/CAL4Wiiq3h_OoVo9BpBy0pqFe=AeyN25QxsU86h63qEf05uCJRA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v2 -> v3:
  - drop the skb_network_offset() condition; keep only
    pskb_may_pull(dev->min_header_len).  The offset check rejected valid
    MPLS L2VPN redirects (Eric Dumazet; tc_mpls_l2vpn.sh).
---
 net/sched/act_mirred.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 553342c55cf7..85163c46d652 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -316,6 +316,10 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		}
 	}
 
+	if (!expects_nh &&
+	    !pskb_may_pull(skb_to_send, dev->min_header_len))
+		goto err_cant_do;
+
 	skb_to_send->skb_iif = skb->dev->ifindex;
 	skb_to_send->dev = dev;
 
@@ -335,6 +339,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	return retval;
 
 err_cant_do:
+	if (skb_to_send != skb)
+		kfree_skb(skb_to_send);
 	if (is_redirect)
 		retval = TC_ACT_SHOT;
 	tcf_action_inc_overlimit_qstats(&m->common);
-- 
2.43.0

