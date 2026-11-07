Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080662;
	b=bqnW7yty5TtjvA+EF1PYEbMB0NjwEKxzE1uGaUT8MJ0vus6j7ta4tR0VaH4xmRlJlB+0
	 xtLj26JlZN1P9xGgFB3xV+L0qd/OF28NJ+ysHTZv0lgrcIQOnOshy0pNcOzy8RELw1PjK
	 Tn/eOY+ee1Ov6vANxVil7bv2LAe++0ytjVXcjIHiw6fXYa3O8ClFXRSfz7GW+nnysH0Pa
	 ZjlSg5XAxfnVl+D+D0oEkrevpoeh5pLZlz1hMqD/m/2ZD79Is20QehOI6mI6m521DKcuK
	 J8E6zdTwIYg+iUEDoQc70N/0W47F+6qvDTILVJ6imrVb89KUdll26xkJKaRk/t8lMHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/52ToiBN9dNVSBlBF6GOm1T2xgM8Y/pYcMIFz9gueFc=;
	b=kX0mBzket3jq+FNk8iRk2xocN/gcQlxZiNgWCnpIWADJOlmLRFG8lUAq3mMPRTVWzc9X
	 6/WJu+7nSq7ugINlQtzbM78LIol9i16LlHIDSSyJCZsTFzuYBs+w4sLqLNpU783Jj42fI
	 mstFalzShhFd558V26sencDZVE30AY1SjQwDLd7Q4OX99IbrWygxHezjVMdvrY4JtCB89
	 AXYJOMoeTP5kPTLYtDiHhb/F0Pe+MIfnXabrMO0Bpi5L99zactHG3N54PvQYV+Cp7Zvee
	 2kJJK8o0fDdNhl5IUqZuEnR0w0WKScYqUkwTLY+3BzOUt3yBdlyEA22tb8inoAdiWFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ZWpfhOgL;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BF0606A32F
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BF0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=ZWpfhOgL
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-702fd86d674so1050691eaf.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794080661; x=1794685461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/52ToiBN9dNVSBlBF6GOm1T2xgM8Y/pYcMIFz9gueFc=;
        b=ZWpfhOgLiyeMYaDDDQoCQsJRcKE3eMyWHW9t57rDdQXxoshjMWoKuWHZ7f9wg4f7WT
         ASaI+pG2VRgjqjkqgywLvKcvhLK3c/SmEHqiTvAL4QguzGdlJdq/qN4pBxtMPA1HfC4N
         ChfLMROpLbkH0s1HjuhlJJuYxu2bYrWZUKyLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080661; x=1794685461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/52ToiBN9dNVSBlBF6GOm1T2xgM8Y/pYcMIFz9gueFc=;
        b=m4+Seb951bCw9+AdrnWv5PfBaEzY3zF5b7kA5WQjLnX0VBetwbV+igz09wMK4IVXoS
         QswMpd1/+TSMkuex/FLwNWjKLXIqrABN5Lu3iyusLSUrYVM1plzIGpvZLBwc1c5NFi7S
         qE9rktpmfn4DkF/ckJ03PKGbknFnXGcFXH+xRMjix6/ESV/kMnyLJh8fiqoUKZwOGgRE
         MTYHOJW+kLLBBrZ0a6Q7pGeF3P7gSX/qSea1x4QiD38SIHn2fSVvdqyTLFEOVdWTtOtn
         6/5xA4Wu9nqOjckflH/Bn/930vREwTEtRaiqU9GmfIzkmldtV1AiRpxJGaYj9bJQ77JH
         FuKg==
X-Forwarded-Encrypted: i=1; AKwUvBwrMLqqI6qIvgG7en+hYPBHHN4Mec9fPT6dZI/4BEUn4U9wZNKBrNF27oFYdB9e3MPE47wse/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UnJd6X1qQEXIkNpvrrOPtv5M1LZV1jIVixaowQAaOuEcOnoZU
	u0LHj9GNnJY6nxpuhpEK7eImst+dc92hXSdlZloAswyg7oJlGWeRJZX7RpyeYLYZ2J9UtjY09An
	kdQWpkIM=
X-Gm-Gg: AYBFou08ZbLxHc6rco5nmjIpqQaX5RiHHhg89YbOq8cTWDClEOnmMrKTFc0A75yqKy/
	1kQk7eet/sgQ4ywYg00uxL/PpHc7vH+MgH09kJhlEpqRQ0tF6Y3L5V8ehVZhhr5t9WD2QddcC7z
	mSXVPksiAnijpiwN7PZOJxU6u5bpQ0ef5pPefNqN4E5i54OzLx9vQdav0JjKGAeykTWjhXxTw45
	tu6/HvTG9tTdoK7/KLxh0RFDKSgLjT+8KF4a4e+/RwhOGhtWdIFzto9Yzoga7tiOwBBS6TjYxYR
	jwZ102JLbPdhBCySQjBidE9yqWOrnyPpKPbJPoGfZ1SPeZB7yExRd2RQEiXRoWv9brFai7dqW+n
	0NVyprQR4bxEnVx2Cqi4uj+AB3uQr/kjKJl5ttqyThvjHl38cXdnpgM/2t1ueC5LMhNZUJyP1Qs
	WPBOUM7qr6xNnPjU4GlFwRT57sZWo2JYpA0fA4JRVNi+ZKFz72BAM1yUadkh62QEE1nCdoYqkDH
	LMnTM86FXR0xC/KsgFbaflONj2xMvmRWo+nHrUHlLbEb+87YjvhWqDWS5ANlmBhM01AZCutfH93
	bVfCpx5TecdX+qXKiXKEabuRmSCWKROhBYRyX7h1cC5g4RYA0Q4Cobu8JRYW1LISU58tETRw4If
	/q8jmjl3NreUD5jt7sQ8C5ZCAbrFczg==
X-Received: by 2002:a05:6820:4a02:b0:70e:1dd8:6695 with SMTP id 006d021491bc7-716e78e810fmr3171706eaf.37.1794080660666;
        Sat, 07 Nov 2026 11:44:20 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e9fa7ec0sm4210706eaf.3.2026.11.07.11.44.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 11:44:20 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] netfilter: br_netfilter: reject unsafe neighbour devices for DNAT
Date: Sat,  7 Nov 2026 11:44:17 -0800
Message-ID: <20261107194417.99328-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

The IPv4 and IPv6 bridge prerouting callbacks classify DNAT traffic using
the logical input device saved in skb->dev. The physical input port can
have a different bridge master when prerouting resumes, for example after
an NFQUEUE verdict. Netfilter reassembly can also combine the first
fragment's bridge information with a different fragment's input device.

br_nf_pre_routing_finish_bridge() replaces skb->dev with the port's
current bridge master, but looks up the neighbour using the existing
route. This can put an skb with skb->dev pointing to bridge B on an
unresolved neighbour of bridge A. Deleting B and resolving the neighbour
on A then causes a use-after-free in __dev_queue_xmit().

Before calling the neighbour output method, check that the neighbour
keeps skb->dev alive. A neighbour holds its device, and a VLAN device
also holds its underlying device, so allow a VLAN whose real device is
the bridge. Release the neighbour and drop the skb on a mismatch.

With bridge-nf-filter-vlan-tagged=1 and bridge-nf-pass-vlan-input-dev=1,
the logical input device can be a VLAN such as br0.100. The earlier
route-device comparison then succeeds with br0.100, but this continuation
changes skb->dev to br0. Comparing dst->dev directly with skb->dev would
drop valid VLAN DNAT traffic.

Doing this in the shared continuation covers both protocol families,
including a queue in the remaining bridge prerouting hooks. Leave the
cached-header path unchanged since it does not enqueue the skb.

The issue was found by an LLM.

Fixes: 2948d2ebbb98 ("[NETFILTER]: bridge: fix double POST_ROUTING invocation")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v1: https://lore.kernel.org/netfilter-devel/20261030042155.73844-1-kylebot@openai.com/
v2:
- Explain the bridge-nf-pass-vlan-input-dev case in the commit message
  and the neighbour-lifetime comment. No functional change from v1.
- Add the Fixes tag for the change to direct neighbour output.

I have a reproducer for this issue and can share via DM

 net/bridge/br_netfilter_hooks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e15355ff215a..1f5c7f284e0f 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -307,6 +307,19 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 
 			ret = br_handle_frame_finish(net, sk, skb);
 		} else {
+			struct net_device *dev = neigh->dev;
+
+			/* The neighbour queue must keep skb->dev alive.
+			 * With bridge-nf-pass-vlan-input-dev=1, dst->dev may
+			 * be a VLAN device, which holds its underlying bridge.
+			 */
+			if (is_vlan_dev(dev))
+				dev = vlan_dev_real_dev(dev);
+			if (dev != skb->dev) {
+				neigh_release(neigh);
+				goto free_skb;
+			}
+
 			/* the neighbour function below overwrites the complete
 			 * MAC header, so we save the Ethernet source address and
 			 * protocol number.

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.55.0.openai.911.g06873a30d2f3

