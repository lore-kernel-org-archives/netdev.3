Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475372;
	b=kJv0761NZpe4xZHmfAZgQGAKFGejbDZSHttUuvqqUqxYlnUWHw1S+5qvKlNtAWeQHhE7
	 37wFmnPVSCpUxSD6sAnVp1zVXyq6cfyrTHjQ/zj+f68DTp619UtYNhNfiDJwKjzhdS34d
	 2gNYw+Gh370ZdMqym1kPR7Q2qQGdJsOXx/vkgfHGqLFlRCmVOE/vHHglcnkQoAg3503fz
	 br5fXcQ9BlRL0QQqUC5nac1bkKeSzBNb942aEvQCuWVZi9551e3Aonxc17E1XFDOWXi7W
	 4snSetPnH0jgvHJcfN9tDwrA0QYkJRB8ybAZIGXr2JRZQDcP0pFbUdD0wjrK0w6QwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
	b=lUtLila/Wkrl5o7Q9BdgRCpIdaLZb0LY6x8IMppx0xc9vqS2LsUvYvt9hyUAkJtUUi7+
	 7t26P7MEjiMMw+z4R5LQdF1xFCIXBQMy4R1KltHvXevY8aJYh956TueWcvBdvwddgq8Gv
	 jwXhBKIbGbyJA5cTK7udG40L4GEXIknhOOQ/4shwjbaTiX/U/J4S+mvA3YNWiQpm2K1Ik
	 AkMrsxmMA07+NoglQBSIoHrsCTHIZpUmDGYJlBG9cgRjKpVnTTjs837jCNV0Gb0Osy1U1
	 ZKMrgs9E78cJr7xFIEg1n0I/kQbuLNMjUtSS31ON2+oCJNmGhJJjUqZ7gjPbGrMnKRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=sQ0if6jp;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA62606A332
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA62606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=sQ0if6jp
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53fdd2fb171so22153031cf.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475370; x=1794080170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=sQ0if6jpmRvMZgps5pZsOPm03BKyUoafhUkOECOPcsYVBLTZsYYdDYchxGW4CoOXTq
         5HeycxLZKIsY1Tv7dMWxvxibkozLYkDmqR7tWHWK0eEBBIC94OdyhTtfEqj5F7Ojn4ID
         F/w9uv9r/DPlI6jyQIxJlfaaGM5QhDDoc2i0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475370; x=1794080170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3hxAM5cEROmPK4n0R9NwV2gBM2O/XyZLRlxcI8cqrk=;
        b=rlivMflJN4BypzJrcoBubzjz+jL2BYOeQabP4oOweCCo+xhewmd2XJ7e40OO/ADKQM
         yDk7t9EkRRlNdY6SUBF57e5CVwCOi53BBLTKkkK8LtZhjE602gRdoM3OXPRB3VmYTrZ0
         npm9x/ioBrAj80Clmdo6QU0FRPOb2ObOSRzflnQMG1RfgGSzPgDmZk/5+WADgkWZH26G
         +kHLC28KGOyi76to6RUY4DVHq1egUoaRo8izEqFPtQTDwXb8gKQatLcEciRr3b8Ajr3X
         40FHn+gLpDJqMYv81X2nAJbVHcnRHRc4LPUAWc73BLzYqFBTifoS0pPb+lRP/mPiVNAa
         J2ww==
X-Gm-Message-State: AFq9FYK+kbKHC++CpDUWi3M70V3mZtpUgsZpJifqCIUdWD+Q3T/RMvZT
	BAcop7gIlZvGBi0tt6YhY1BLeY7FzxDjUiSi3WpzHLfR3Cm6gT2h98JbMadHjE+8i5/OlMQGj/L
	WAmY=
X-Gm-Gg: AYBFou20IBWQqQAPYjQnc0QKf0RoNtfZx+x7tFZRRs02Z/c2g6mYMfNAlkVCYNx7E5+
	r8O+SloUYpXhFd78TJiRWKsoKiWvW208vZFY1uzBEx6Iv6XO2fAOWQqomohHq/hr/BQxmi++i0P
	+oxdvkzPMSb4egHm2Rqjx01/PDXp7RYtsicEmLqe/0qK/wasnaoL6kY+iJ0qWXbIntjR6Gt1KXU
	0T/w9Uewe4VG4S1sf/XKOxQ/CpBqXpBka9a2x4cfVADDjWiGCNz8OUovLkr66Qyf1rf64sBN5P/
	y9CIPyMzAarb94vPEYYursJhzI0ReKCbTxHFk4SseZWP8wQjZ0D+dhkQsopYWGjxFmh9Us+cP0Y
	VVKyTlQx1WSSdpthviBZ8Yy4E6YVpSsSQg1B5bTJ606dp070RK2Z9uzjTsQ1m2juLDivE+Y/pIr
	gXt58O7cpyW3PYj2lcpFy90+SYdOrhJnSCbjkooQdbWKb6CpbQu+6mlR0nxZ+BUNZwY0glSAOEZ
	Bj0owfMGiWfLIs8R9WXgCwlZ0xam3ACrK7lPoyFa0J5mxN6LR6puyGdYqgZSHRXO4fIpC9Do7US
	ic+iF2bhj51z3YMhPj9e/aLMdXYH8XP1Z5SdwlLHshQ8ydGHnVQbAWcxbSnYFI0MFtAk5MdMFty
	4ttsY5DCttqYELm0=
X-Received: by 2002:a05:620a:2702:b0:93e:e4d1:797b with SMTP id af79cd13be357-944217f57eemr951964985a.56.1793475370499;
        Sat, 31 Oct 2026 12:36:10 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425abd317sm446917585a.36.2026.10.31.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:36:08 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/3 repost1] net/sched: act_ife: require a full Ethernet header on egress
Date: Sat, 31 Oct 2026 15:35:59 -0400
Message-Id: <SER-NSBD.v1.r1.20261030042947-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com>
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

This is a followup of commit 5b483f7791b0 ("net/sched: act_ife: Only
operate on Ethernet frames") as reported by Sashiko.

The finding was raised by both Sashiko providers (nipa and gemini)
while reviewing the parent patchset. shaos <shawnq1@163.com>
independently reported the same undersized-egress path with a
reproducer, which was reproduced and verified in our test environment.

The issue:
On egress tcf_ife_is_eth_skb() only checks the device type; it does not
check that the skb carries a full Ethernet header. For an Ethernet or
loopback device it returns true even when the skb has no Ethernet
header. tcf_ife_encode() then calls ife_encode(), which copies ETH_HLEN
bytes from skb->data. A short skb therefore reads past its linear data
and the copied bytes, including stale kernel memory, are emitted in the
outer Ethernet header.

The parent commit fixed the reported ingress mac_len case but left the
egress path without a length check.

A total-length test is not sufficient: a non-GSO TUN skb can have a
large total length while only a single byte sits in the linear area, so
ife_encode() still reads past the linear header. Require instead that
the Ethernet header the encoder copies is present in the linear part of
the skb.

The Fix:
On egress require pskb_may_pull(skb, ETH_HLEN) before encoding, which
ensures the Ethernet header is present in the linear data ife_encode()
copies from; the ingress mac_len check is unchanged. A short egress skb
is now dropped instead of being encoded.

Conditions to recreate the bug:
CONFIG_NET_ACT_IFE=y, CONFIG_NET_CLS_MATCHALL=y, CONFIG_NET_SCH_INGRESS=y,
CONFIG_TUN=y, CONFIG_NET_ACT_MIRRED=y. In two user and network
namespaces (a victim and an attacker), open a TUN device in IFF_TUN mode
and attach clsact to it and to lo. Redirect ingress traffic from the TUN
device to lo egress with mirred, and install an ife encode action on lo
egress:

  tc qdisc add dev <tun> clsact
  tc qdisc add dev lo clsact
  tc filter add dev <tun> ingress matchall action mirred egress \
      redirect dev lo
  tc filter add dev lo egress matchall action ife encode use mark 1 \
      action ok

Send a TUN packet shorter than ETH_HLEN (a one-byte payload is enough)
and receive the emitted frame on the other side. Without the fix the
outer Ethernet header contains bytes copied past the short packet; with
the fix the short skb is dropped. The attacker needs CAP_NET_ADMIN in
its user namespace; no init-net privilege is required.

The same path is reachable when the total length is large but the
Ethernet header is not linear: write a non-GSO virtio header with
hdr_len=1 followed by an 8192-byte packet so that only one byte stays
linear. Without the fix the copied header reads past the linear data;
with the fix the header is pulled into the linear area before the copy.

Fixes: ef6980b6becb ("introduce IFE action")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Reported-by: shaos <shawnq1@163.com>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_ife.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 2afd68983ece..986264af8146 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -876,13 +876,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
  * is an Ethernet header because the skb could've been redirected with mirred
  * from a non-Ethernet device.
  */
-static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
+static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
 {
 	if (skb->dev->type != ARPHRD_ETHER &&
 	    skb->dev->type != ARPHRD_LOOPBACK)
 		return false;
 
-	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
+	if (skb_at_tc_ingress(skb))
+		return skb->mac_len == ETH_HLEN;
+
+	return pskb_may_pull(skb, ETH_HLEN);
 }
 
 TC_INDIRECT_SCOPE int tcf_ife_act(struct sk_buff *skb,
-- 
2.43.0

