Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334119;
	b=DOy2wV19hH60aLzzvqWxmzQb5lzpyHUN+RAO2WRBxpQ3CngL2A4gtam4BtJVonIF5RLZ
	 jPS3txrO7/WCFZC+x+qq/YHzD+okzH2184B6gdCrxtNU34TIMDfFvd9q89DP2uCJ/JRhm
	 FT6KI4nvSS8Dw1wuOKTduMeuH0nKv4pJWs1zb7XFt2zdjLox3MCWdcuJKhA4rTpjZQbkH
	 RAIhrOY+O9XmHfj0+AxHCYSn4yYrhT/Vo/Tm8vMMB70pVJkynHafMIakgN8xyDVcglvFu
	 A4HSP5xFNSzuwBxXW5VwZsjFSDXLZvTMYtgbw/6FY6JrveSYBucbZe/jd4drY4iHSWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
	b=rl2QEHyA9lH3qnuCQFR8CwJ6p9OTrbWTnwrZCHCSdWnt1C7ltT1b7zr3UhE2qZfizCu9
	 z8X77ZIw3oj9Lg9LjWox/AiGe53UtLBpooIDlvrf75rgNKLS9EMiTZNw9vrZrOlHoOooq
	 CKiubw/5qcMgsZyiKGOu7BWXlVH2RD6yfXqg/imLGsPLMfxbHINhYzx68RY1HCtnKC9we
	 0NFRdgVScPeg1pi/VXg5XyMI+HWhEyan4vI3Kp7GS04O5FwbusAtyEoaPUaGlw7SCVpGe
	 /hx/Dj8wYS/5yCLkeP3+9OkIr/OCr+sxjU+p9jihLWAk3F9wTIywmeBARH+gwnETBHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UQt10XbB;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6C606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC6C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UQt10XbB
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-483a66818edso164618fac.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334118; x=1793938918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
        b=UQt10XbBkkvXiGl5Qft/UotQH8UE3kbVRvvtssudQnkCaG9GnY6433nC1ryUbs88XD
         U8nWbPb0vXcjs5jWmQ+K5Iz7gQYZ2eJrm1GRmeXjRzkjoT1doVzYm+Lb1QYaEa59mFby
         LK0jstYeyvXJrZFbBo842W2EzZPw4CA3v1VVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334118; x=1793938918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uu4+KvWwIV0d7oHG+0bpuFJz50WGRRgzdpZ6XppMrug=;
        b=LdQlz02wZqIWDnIzNSk1SxI7mdEoBu/NBShcsZ1YwJpEs72LvtBQHNXGqws6g3Qgqx
         TAC6zC+Wen/IQJrRQTntvNTj3wJ+2SsAi1FGxwp8q1pb7sjDk0exwiT39rwVZP78IF64
         aakV+yfhdsfPU/ZnnjG884rTHlAhbxaio3V+On7Pfj4hJPVU8FyfFCvCLlhaX3K/I1KA
         mEH73KLTxuGVeoDIoo8w1nHS5/4ulhVCfBTkg8pcGRV2pYa/+B+cz8MeMRwsQb+S04Hk
         9Z4H9+izo+cjpk9w8Oj+v49jkEUg0BqkH0Ma4lUElixVapcM8GMUno/wWBf23ECWQpFU
         AVEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIUgvTbiVvO5TO7gHQoUnSzl0J0YUbugM+IQT9bBaAhsQJYsuYv/0xYJaG30pGnuArh8M6eNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUmtK3DTcmTS0ZzhSOcGI1nddBdVIAIM+lNRKjKkKEbe8SPvnw
	6Dr8VqCPr6yabYQgp2r4YwAsMx7/S58vTXuUu1XwwyM2XRQq4NuoOJ7qPT+tj1T5nbQ=
X-Gm-Gg: AYBFou3+yGtEbzl89g9wMdgZ+JqhKSCswyWlzWWri7oycp5dNKw9Nk+k/3mzisD3irJ
	B5VYviWfme8YXdCHxa6tsu6g53eqpoIsysxvbCs0tMs9uYJkZOMjtYdnIleXesvhuwjWo/PudxN
	KM09ZxuLXAXL3j/7LdWFpu3mKzwoYtrG6JPgFWSe1VJu3oP9p718azPVH1LZWiardWj0OrevNve
	p7C36PgXC3DIemJftOAth5bwS66ql/JyaYeg/ktpqDvPKc6HsjsfR98NdgAOe6GaLAs1yo2qSSI
	rWimzQ+WvGIUiyal7AzNotF1G5tC3PcuSK3GX4m2cAT+vJ/tFgDWrJeVdHbgS4h26KoCSA/dpeV
	ZudlC5kZyezJxoTeotmqBZ5t/LQqx0tpSp2zPCIAXUbPq0OgRK8J0ICPANM162a6oDuSmQl0Ftw
	JQb35ZTs0+0CkNH1pEK4BB6cpq9BYn5K7vwozOMhwkXwxcyBRw7VBz1zM/tlouHIR72krcnM1rY
	Yfp1QY/4r+kmf9h5q5SiXHs1X8TmBVQFA5gRGrCYzAjaz/sJ2suIwwg51wP/kL037fBsixfR3EI
	oS7DoYNtXuYBLvZJXwJJbfhyqlwHH5KsfLJzynfQcEOKwPAdvFe6C8XLxzMax6sjAsXHiuFpKsR
	Ih/Kkycqmhh8X7GEWjbToYvGOUu7ziw==
X-Received: by 2002:a05:6808:17a3:b0:4ec:4c7e:37b5 with SMTP id 5614622812f47-5640ddb4f38mr841806b6e.29.1793334117847;
        Thu, 29 Oct 2026 21:21:57 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd9888bsm764152b6e.5.2026.10.29.21.21.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:57 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] netfilter: br_netfilter: reject unsafe neighbour devices for DNAT
Date: Thu, 29 Oct 2026 21:21:55 -0700
Message-ID: <20261030042155.73844-1-kylebot@openai.com>
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
also holds its real device, so allow a VLAN whose real device is the
bridge. Release the neighbour and drop the skb on a mismatch.

Doing this in the shared continuation covers both protocol families,
including a queue in the remaining bridge prerouting hooks. Leave the
cached-header path unchanged since it does not enqueue the skb.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/bridge/br_netfilter_hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index e15355ff215a..726a2d17ed3a 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -307,6 +307,18 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 
 			ret = br_handle_frame_finish(net, sk, skb);
 		} else {
+			struct net_device *dev = neigh->dev;
+
+			/* The neighbour queue must keep skb->dev alive. A VLAN
+			 * device also holds a reference to its real device.
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

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
