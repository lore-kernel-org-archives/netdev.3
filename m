Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406608;
	b=IUDEySwQ58Vxay86oG0xIM5+ZJ1CQ72ktV2TDlCcsvm48hG/2fI9E7xrtied2y4ZFTA8
	 0z5bXdAqmwg+Hj8btKi2lApMlwm9DNGUo9a+9d34wYpNJN1vumKxDsAuV+YN1byv7+iLo
	 gwKnZ0eqZ6Qamow9dFtAFgGDeOHyB8MKPnO1mmdWBgylspQI4TF8ck8JSFkXSgkfxgwY+
	 p4jCdxQT6E+nuQOs+0RvYgci+iRTnDoL0r2GimcJH1KjkoL0YMUDiCYrbeBTJeH7m1By7
	 VGcEUv8u/1hgOfzDzWoxPoTrhbX50Ztr6hozvNiw8cE8C5U4vhn5TE3GYJQ5mVjz5jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kkp0sf7AYW6VmAUeGJTN0IINgbfaB9P070/+YW6JJGM=;
	b=Ld79pKazAR4vt7LgIYQN2L5YMzz3cloFneWDRKCNLYpCxSddIfpV9BZ3tvECqgCwJ8HT
	 EPF/TgwpWPLlkJ+TsBqni6gXvtWgOggxw+m1RZ5JtgoCIpJWGSCuSLiEx27HSZ8T2SWX+
	 bSX6Fh7sKJvQvNE7EVyIGoJzLMqWEAJBPLpjwvu1rg/4+thNW0hmTejCl4fWstrZa9uOy
	 H+b2nnBsbtWKqlsqhKXeod1k3nOMujBHgQbNXXo805+gzqEwREGk3h4GJfwnUYZxDxyZW
	 4zNuEIMMRH8XLhb50UMjnQgBE6gaWQecDQH+e5pDX4Yp+qlumofRCadcRCwr+SjCb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SQ4E1TMp;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65052606A338
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65052606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SQ4E1TMp
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53394bffe0fso34034641cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794406607; x=1795011407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kkp0sf7AYW6VmAUeGJTN0IINgbfaB9P070/+YW6JJGM=;
        b=SQ4E1TMp/e2ruLG4sjeW4a9FyCecaLf7rPv9DZjCXoQQokviHfyx48hZqqIliIAyzg
         U0qynPV/Rcmw3BZy5NZ115W30eORxd1WIQpNwsNbtHLkZmQGhIImXhOEOBnpyc5JsFyU
         sMeljLDzBCoa+U/Jzm/wSHqHh+G3MhvLtwxbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406607; x=1795011407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kkp0sf7AYW6VmAUeGJTN0IINgbfaB9P070/+YW6JJGM=;
        b=yPyrHavWWWmw9mLKs5YGg+og07K3OE8m62Wa5MJwhDzjGetVUr1pivYaO9DMKMqe1e
         O38ZHx1Ss+gwfEcgdshed95vHqTBU4108MGE8/5XDaW3zyZ+gvtwhKwESNQcAc7aXMWP
         i2FSUw1pCINAyZhHRmpegbyb6T8QYCghCRbFohgOBOOIgceNbukYyIk+lx9OxbM4PPIw
         bmHBHz8EJ6suj9AIFwBitr4KJWRmNoZgKopXSPsh+HHj4CufKEs4hyyw3lDEhypzFbLM
         pOfP6edjCkojlIY/5hgGWuynpSe5uIttPcJcvPre6x/EAVX6713jFDGcXSI/x/5ATnja
         ibqw==
X-Gm-Message-State: APuU4Z/nRS4sVrjmQNIfEj1pWi7IyhRWphv/gAfPFokDbwm+VKLfj8RC
	iFEsx3lhjmhw9COKqjNexw/lLhYMyx/JO6rcfhW0v1SbJu7SKbvKXSpCkhR5thLY0Bvznw5py+K
	4ieE=
X-Gm-Gg: AYBFou367H1TBeqMSiqOGLnvAtnYneGFNu08oKUMF/cIgK3hwwLThesDmw73oLXNnzR
	Mkh+k1w1CyDBD6/nFEFfz6o+gX73eNfBgXuHZIJx5TLBOQalAzQ38T8obDxQrQVNLyXBm7PkHlH
	nfZfgRvQj8bKISyI86f45fN+htyC66cEH1Dq5cE9aTggt0h8uFvMV5gyBlpgEtMMj5YyrUBOVGR
	nMbkLdSl9NZIPNbseUbQcd9R+yqnufLWjJmTnPnMjlkbVJ3axmI2k8yUvnhd6MJ+PS5XvmteeaS
	tgBQZr/VO/Ei6hjlLDVSJHrlTQJJQbgU1FFfgE/W4lg0lhGeev5iCR9jpNT/eke/5O1zT0oBRDp
	RgvmO1Ttpio5BfjDdjKOfP1CUzBb4UEt1unTAZQPHovx75bR9/J9O31HBRwdXRyi4fQPNs6lOae
	4EcAI/5mKtUjX2k3t1zJgvlZofEDg4Te4JAqTJ6WhyFd/mcfXzu4mCASXcAZP4Git9XugOdJFMa
	W+1AB43dz3Lwokkfsm4XLqiZ0hUj/dzGtlZZEqkDHFVFs/si+BLNbfGP438BEdQjRpXy1SF4ynG
	za4EPhVAjvYVSudvkMda6s8Qc0m2nU86oqx88vEXPjbzqgzC6u6+3CrWf2av2TJ1mguiZHsNMmX
	tkVnwyNc30aUTSg==
X-Received: by 2002:ac8:5fc5:0:b0:535:96cd:559a with SMTP id d75a77b69052e-556c0cbd262mr31027821cf.16.1794406607214;
        Wed, 11 Nov 2026 06:16:47 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550be2e592sm51505041cf.24.2026.11.11.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:16:46 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	sashiko-bot@kernel.org
Subject: [PATCH net-next 1/2] netfilter: nft_fwd_netdev: drop the stale dst when steering to a device
Date: Wed, 11 Nov 2026 09:16:37 -0500
Message-Id: <CORE-9NOG.v1.r0.20261111073528-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
References: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
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

This is a followup of the review of the teql arp-queue fix as reported
by Sashiko.

The issue: the neighbour variant of fwd rewrites skb->dev to the
configured output device and calls neigh_xmit(), but leaves the skb's
dst untouched. If that device's neighbour for the configured nexthop is
incomplete, the packet is parked on the neighbour's arp_queue while the
stale dst still describes the device the packet was routed through.
Draining the queue re-looks the neighbour up from that dst, so the frame
is built with the routed device's link-layer header and then transmitted
on the configured device. The packet leaves with another device's
addresses.

The Fix: drop the dst before the device switch. Both lookup inputs the
neighbour transmission needs, the device and the nexthop, are supplied
by the rule, so the route dst is never consulted. Without it the queue
drain keeps the parking neighbour and the frame carries the configured
device's addresses.

Conditions to recreate the bug: two network namespaces, A (10.10.0.1/24)
and B (10.1.0.1/24) in one, their veth peers in the other with only A's
peer addressed (10.10.0.2/24) so B's nexthop cannot be resolved by ARP.
Resolve A's neighbour for 10.10.0.2 as permanent, then load this ruleset
on A:

    table netdev t {
            chain c {
                    type filter hook egress device va priority 0
                    policy accept
                    fwd ip to 10.1.0.2 device vb
            }
    }

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/netfilter/nft_fwd_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index a48c2f765bba..ad4d61d64cdd 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -175,6 +175,7 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
 
-- 
2.43.0

