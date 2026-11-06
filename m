Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947327;
	b=F2Kf3nyA71gZG1pb+Iw2Tf1vV2S7uwmWe9VHWoj6b/A5XNiO90GdFpqpN6sH281k5dm0
	 O916iAvP5qu19RHBmsPPW/mtPpSX7bL3zf1x7niIU+NeVkYwxwk5FotagaOKXC3Jyicfy
	 q8P2eKIp+Y1c5Y7k+7L0RN4FvlMoaAKr5Isa9tXEggi8offAsbzgPVtXn3KCZGRac+hnW
	 ZcO9YkYIWjraBX2clWQkFuxSYTEv6WVfwFsiM+ArtfAlPVuQluxoli6g8hRQp2s9w1ZR0
	 qYLPvsML5ktdpbEPcLYaXU1xf8eATliXV22EZ9MnsTRccf9uJ+p9iwqS75fhZIb7n/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947327;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ht+KGDq4apws2pxXUS2+kqpptXwtJfA+zxTTVVaGiZQ=;
	b=VeSXs1q6QiGZgQAsr4IG5NAUr6dUc1gyStDY2lKA7fy4g3s1rBPmNiFx45Tq6iO9LzuZ
	 um9dUXHnvMClhvpL0k1EJBT6UHoOqV2Pd5D9wQKbPwEJm/zx3p6fnk/T/51ZUM2TSPiYr
	 78YneHPDrml/5YX4yDHELdeO+BWMrcg/2NS1XQUI6jpa2t1DpK+OfN9yGaYZgn2qyVzuI
	 2Ue+sliC9tqzD/wNLKBptacOI9bNtfCopRygjCVh9RVgSjRkBDKXfTqMcTXWZdXFwUr9F
	 b1RbE5iMcBr08C6U1DaGjuNAAWgBLq8YVeUh+K4EGYtc7RKT47F7dDWjTOyjfjJyzpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=iRX6sOQH;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20667606A32D;
	Fri,  6 Nov 2026 06:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20667606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=iRX6sOQH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ht
	+KGDq4apws2pxXUS2+kqpptXwtJfA+zxTTVVaGiZQ=; b=iRX6sOQHLkmpDmG02Q
	66jvepKN/lwB1Ug6wXwTkBUq0EPvAHTT2LvdUmkiPbpuS+RJCGdyQJ0T3X9+DLln
	qYiE+ncCSlS5lruRsKfdYY7Ax11mpm+jcgMlhtqDooNLHrSHqf/cHHwVfihHDfAV
	EtC28qkTDxM5eMd8FjfJRTbQI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnR+uMdu1qZ7kzCw--.3170S4;
	Fri, 06 Nov 2026 14:41:21 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH net-next 2/3] net/sched: act_vlan: size push_eth in get_fill_size
Date: Fri,  6 Nov 2026 14:41:13 +0800
Message-Id: <20261106064114.3592670-3-xiaolinkui@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261106064114.3592670-1-xiaolinkui@126.com>
References: <20261106064114.3592670-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDnR+uMdu1qZ7kzCw--.3170S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1fZryUJry7Cw4fury8Zrb_yoW5uw45pr
	yDuFZ5Cr1DJr9rXrWktF48ua95WFn3Jr4UWryqk34fAr15Kwn2kFW7Kay29w17Ars5Cryr
	AryqgFnrWr4Duw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPPEhUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBHXrmrtdpF28gAA3k

From: Linkui Xiao <xiaolinkui@kylinos.cn>

tcf_vlan_dump() emits TCA_VLAN_PUSH_ETH_DST and TCA_VLAN_PUSH_ETH_SRC for
every action installed with TCA_VLAN_ACT_PUSH_ETH, but
tcf_vlan_get_fill_size() budgets only TCA_VLAN_PARMS plus the push VLAN
id, protocol and priority.  Commit 19fbcb36a39e ("net/sched: act_vlan:
Add {POP,PUSH}_ETH actions") put the two Ethernet addresses in the dump
without putting them here.

get_fill_size() is the per-action term of the budget that
tcf_action_fill_size() returns to the core, which uses it to size the
netlink skb carrying the action, so it has to bound what dump() can write
rather than describe one particular instance.  Commit 4ba61bfd4998
("net/sched: add get_fill_size() to the five actions that lack one")
states the convention: "Size every optional attribute unconditionally".
act_vlan already follows it for TCA_VLAN_PUSH_VLAN_ID,
TCA_VLAN_PUSH_VLAN_PROTOCOL and TCA_VLAN_PUSH_VLAN_PRIORITY, all of which
are sized even though a PUSH_ETH instance emits none of them; the
push_eth attributes are simply missing.

This does not overflow today, and only by coincidence.  A PUSH_ETH dump
writes nla_total_size(sizeof(struct tc_vlan)) + 2 *
nla_total_size(ETH_ALEN) == 28 + 24 == 52 bytes, and the current budget
is also exactly 52 bytes, because the three PUSH_VLAN_* attributes that
a PUSH_ETH instance never emits happen to add up to the same 24 bytes the
two MAC addresses need.  That leaves zero slack, and nothing keeps it
that way: the moment any PUSH_VLAN_* attribute is made conditional --
precisely the change the convention quoted above forbids -- a push_eth
dump no longer fits the budget, and building the notification fails with
-EMSGSIZE.

Account for the two attributes the way the rest of the function already
does.  Nothing changes at runtime: the budget already equals or exceeds
what dump() writes for every instance, and all four consumers of it --
tcf_get_notify(), tcf_del_notify_msg(), tcf_add_notify_msg() and
tcf_reoffload_del_notify_msg() -- allocate at least
max(attr_size, NLMSG_GOODSIZE), which is SKB_WITH_OVERHEAD(PAGE_SIZE)
and dwarfs a 24-byte difference.  The RTM_GETACTION dump path sizes its
skb from the netlink dump machinery instead.

Tested by building with CONFIG_NET_ACT_VLAN=y; net/sched builds with W=1
and no new warnings.

Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions")
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 net/sched/act_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 6a375fdc63dd..e666004bb919 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -348,7 +348,8 @@ static size_t tcf_vlan_get_fill_size(const struct tc_action *act)
 	return nla_total_size(sizeof(struct tc_vlan))
 		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_ID */
 		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_PROTOCOL */
-		+ nla_total_size(sizeof(u8)); /* TCA_VLAN_PUSH_VLAN_PRIORITY */
+		+ nla_total_size(sizeof(u8)) /* TCA_VLAN_PUSH_VLAN_PRIORITY */
+		+ 2 * nla_total_size(ETH_ALEN); /* TCA_VLAN_PUSH_ETH_{DST,SRC} */
 }
 
 static int tcf_vlan_offload_act_setup(struct tc_action *act, void *entry_data,
-- 
2.25.1

