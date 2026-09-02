Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8038553F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337811; cv=none; b=lwdTCpLCEEFO4SSsleRUOmUjC+ji/0BdQlVzkAsAa85EZQUhMZuo8emP5hW/y0EKGDgz02yjptLsHTsvyXN9QVnStxX7kSuHa2AEvrenGKEkQWepkC4u71kwM6pC63opbwM9wHAnKZmlF7iVX5/b3H+8uFKiJ35WueUn9Tg64cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337811; c=relaxed/simple;
	bh=4iqQOhkYAe4JDnnoq/RB1ItQgfUSqdEhqwOJ5R58t6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1RW4v4Ula3nPNcCf4ugHr+161s9suqLVs/kOyMwng52gduIZVGESQD8UlWe7idjsPvrdJknfgMsq+MGpqD7WCmey1jTaDrXMNrOZBk+NQUMOA4O15rnJYJKl/B0S/k2LWX9osCTcLXizRQuQwzv066yUiqo9R+hSWeILyFgE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MzQUyk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MzQUyk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso661712b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337810; x=1788942610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=90ZQiGeRfZ2jvqj4fAVGYYp8oYEh3dff8JUXtoUNxF0=;
        b=G5MzQUyktmXp9N+3SJJN8OBTMlGB/ee5Nx+CZwKLqueHaWWiPBB2yQnTzv/R8YNwp6
         JyZwr46QB3iUUNdcDdn4pGOhzbs3qc8KG6nzXxcNkPaTp4ZljHst6hT8waZuWVcRJE7k
         UraqsxHLxdNRyWvQ1t0eylQ4JGh3NX5JjgeBt1vvE2iwvR/g5c62bOgFn+h2EFQ26RRJ
         7A5SUMZ8cytugmLXX0M1Z7+98nxhTtkGedymeqT3pY7em8irB5NJVjVzE74HSewyUPYF
         cBP+tpHxDZyOamO9l1EpdxSpq/csaAsF7ibkwRa3hb/eAJ8dP4Z6ArV6X96osXZw14Pd
         u7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337810; x=1788942610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=90ZQiGeRfZ2jvqj4fAVGYYp8oYEh3dff8JUXtoUNxF0=;
        b=YTeI4UO29m9kZ3fJ+OS1wePGkDfEhyjsZQG7hezQmKpGnl5S28qnT7DG11G+fVZSN5
         e3YE/T6vkhmRuEtNOnE5UAYnuBS8Ldr6cerE8zpWV8g9KugPcS4amJzANHHWMpWoyrsn
         Q1uIBSM6zZve6OUaRK+BHKr8t+tsGKLDAELKHGPGy2DQz3YrRtTM+D6ewshMZmrwBBxx
         omoBRTS4c3ZLpf9CUWMYdil7ZGDMeMrXv2fuueiNlDmFEffSzWb74wFyNwyPnvPOitwk
         gy316VOy0/TWOV/3WOx9C4VbJKjmrHRHhvlDDYeEkWEhXrdeuNC2c3lQZCLPYWSfbtvj
         zDuQ==
X-Gm-Message-State: AFuF++ktwAd7wq3RsIA8ZTzlZRDDS70LY6P239LuhsgeYLYBoiR/1xbS
	XOo8TJ4oS86ILGuoAhEgxB5uoTBSl52smeY7/YZnuBRY4+2fPCz9gXcR5/KiLb2qzH4=
X-Gm-Gg: AYBFou24l/9BzkPypkYyGMQUqD1nNZjjxxHmQvprVdtrh2SdvHGoHX3q+RU1vGSumqX
	kD5sKo+h4RgWO3srMWYS8n73gtagplF2qYFRh4TQvNrcuDQBlI3Ra4uOTUfjuAAWg/tsUHXi9IP
	qYHUHBWYbVB7chHkBNCn/eD7ArrIXSR/Uityz1GVJ5a38AT/gHLW9S7GW4+hTGyy/NMRSCLJuPi
	f6+bVZ9T8LtGwcZmZO9gymWKcpN/tZGLFtBsTrnwCmR4R4cC7e9smfrQKnvyIZRB31MQg9Tieh8
	2i3pMY22Bpr8ZSUWEKZlV8EO6loBn2mUJOPWynqS5G0g7NED6PwZsMJ1amKc0D7J1wp1vQjtE7M
	FqukxNyHhF3LAu1Zj3L/78pBbygUYNV81xMFHFqL8LOf1ugd4MAdboyWFxHxflexS6Q+9kbZZLQ
	NvRMJ/C6DNRl2z0wgg1OAhjbAxkbzP92zSeKyxr5K1T9GQPiWeQlm6c52X+0t7IXZkdNQubywP5
	rAf
X-Received: by 2002:a05:6a00:2e9c:b0:848:2c2e:c79e with SMTP id d2e1a72fcca58-85ed3c7d861mr4329381b3a.12.1788337809432;
        Wed, 02 Sep 2026 01:30:09 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f29adsm1026904b3a.5.2026.09.02.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:30:09 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	stable@vger.kernel.org,
	Fourie Zhang <fouriezhang@tencent.com>
Subject: [PATCH net] net: mpls: clear inner_protocol when the last label is popped
Date: Wed,  2 Sep 2026 16:28:08 +0800
Message-ID: <20260902082924.2812968-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_mpls_push() records the pre-encapsulation network header once, gated
on !skb->inner_protocol. skb_mpls_pop() never clears that record, so it
outlives the encapsulation it describes.

Open vSwitch can then re-push MPLS onto a packet whose
inner_network_header still points at the older, deeper offset: push a
label, pop every label, recirculate (ovs_flow_key_update() re-derives
key->eth.type and resets network_header, but leaves inner_*), then push
again. ovs_fragment() trusts the record:

	skb->network_header = skb->inner_network_header;

so skb_network_offset() goes negative. The bound check is signed:

	if (skb_network_offset(skb) > MAX_L2_LEN)

a negative offset passes it, and prepare_frag() widens the value:

	unsigned int hlen = skb_network_offset(skb);
	memcpy(&data->l2_data, skb->data, hlen);

which is a ~4GiB memcpy out of a 30-byte per-CPU buffer.

Reproduced on v7.3-rc1. RDX is the truncated length, (unsigned int)(-8):

  BUG: unable to handle page fault for address: ffffe8ffffc16000
  #PF: supervisor write access in kernel mode
  Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:memcpy+0x8/0x20
  RDX: 00000000fffffff8 RSI: ffff888105d732db RDI: ffffe8ffffc16000
   prepare_frag+0x3df/0x4e0
   ovs_fragment+0x589/0x7e0
   do_output+0x4ce/0x5e0
   do_execute_actions+0x55d2/0x7b30
   ovs_execute_actions+0xea/0x450

Same root-cause shape as commit 975b5b067f52 ("ipv6: sr: restore network
header before routing and forwarding"): a stale network header offset
reaching a consumer that widens it. Here it originates in the MPLS
push/pop path.

Clear inner_protocol once the packet is no longer MPLS, so a later push
re-records the current header. net/sched/act_mpls.c is the only other
skb_mpls_pop() caller and gets the same fix; sch_frag.c saves and
restores inner_protocol around fragmentation in the same way OVS does.

Fixes: c66549ffd666 ("openvswitch: correctly fragment packet with mpls headers")
Cc: stable@vger.kernel.org
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/core/skbuff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..cc3b4b70288b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6690,6 +6690,13 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	}
 	skb->protocol = next_proto;
 
+	/* The last label is gone, so the inner header recorded by
+	 * skb_mpls_push() no longer describes this packet. Drop it, or a
+	 * later push keeps the stale offset.
+	 */
+	if (!eth_p_mpls(next_proto))
+		skb->inner_protocol = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_mpls_pop);
-- 
2.43.7

