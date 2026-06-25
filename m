Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED03EB7F4
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406444; cv=none; b=DyZiYnkeN0vppRIflKp/5d03bwiElUkVuceCOiAX1ha47ep4uYO5FHGB8TQXnhW2R7hI4mRU4Pr4faq/tQ6E6kG91mjwsBerUvCOm4Y6/avpA1MPPVqDGZ16476elTaWPeRjV4WVc/AVKY5bZcrjQ0WGvi6KcNz6ddcbg6+ZNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406444; c=relaxed/simple;
	bh=/eRuHFDI2ypTSzxFHx5ug3Zegsy8wNUUeDduP/sw8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRZS8iorSiciMIYABhixB82N8wo9EssWyqNEX4WWCk+0xXcidxhul9/hqukdwErZTP48LahJvCMRTUs/GwgIZoQ32lZksqP7OJLXgvhSI9wib7iwi0X9qL3m5lwFDHTW4yM668ErPggJmlWX819jH0xpqRXJ1wgxe4bibNZ3Gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b20gVmlt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b20gVmlt"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aea4e781a0so12989e87.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406438; x=1783011238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feHQJVyeMqGKPt/6dnOwPMhuCCxYGuXcKgg+YszQic0=;
        b=b20gVmlt+vRsj7kmdKOo6cTYNW2uLyqzaiMcpMkS99XqRjEaovF7oF7otTRRqxy58+
         QIYhQfY880vgUCo7tBkuRNgzJcds7w38poDXHOfm0P+ckAWXKq4Em4uPBkB94dxDxBnl
         RWsG5iqqQHd2pV4rkShikKReLN2seROJHb2vOkuzjVzlbRwbHUtSXv0gjj25qm4aU4fx
         dR+LxkTz1xPLghCjtUUr7kh+enlhAF5wHlyk/3m06YwNy4xN4mfC0aNWLSEsZ4Il2zr0
         HGuqLJncDIhCO++KjJ9kekIUQzCBtSIdEoUV7Er/lqkkIDwRnZ7hROGEgP+TBasjqAd/
         AIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406438; x=1783011238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feHQJVyeMqGKPt/6dnOwPMhuCCxYGuXcKgg+YszQic0=;
        b=R49JI3zNaClCqOEW3OmdcZcIkpuzZWlX67WpSNL3xI/9ve1hKC6gUfGF9Y73Qz/Kqo
         WLZx7qjkwEL6lMuyXQYjMQiaEXNFBFvZBp77pHr7h/sX0EYBtYUntPzuK6Mvd5I93nye
         C67vTC545MneErIxt8UN0jZC10vhAv4PnOdJiTMSJcf3Mu6/1xPt89L33ApksX/zLcBO
         06JBkDkRX6D6lncm4NIrgthtc3ajVeZTp5KHC++ohl5KKIC6cSxXzmS6CpF+YkzQ2Dqv
         juWL4Aqn5QJkf89JJi4JIQ7lS3r3I7vIbPajPLmZ/TIvb4l4nLFw6nChtqQQJx9U12+6
         46jw==
X-Forwarded-Encrypted: i=1; AHgh+RrMMstONl8hm7YbwpAIZhnKlynkGW2jL6pR8TpY2v0yznJO2tiSS3wWGNMCWFxVR78D1lJ+HNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fpmWVLIClYURW+rcAThBxDOwgcb2/QQ/8/ZBwFG7lBxdx3+R
	DUw0c2hCN+qEDIc+zqSeZaNH2RuT/4CF31JRun0SoNmkA4h8SWUfXhHK
X-Gm-Gg: AfdE7clgBVa7fsxKSqQuC0aNoVC9XjE8dlwGljhF/jGjw82nHYmAmWRbZS2ClLWr20b
	WMzgy1D/pPkamrDbF1XdmrReEy4bv1bbnZ5Urzg0VdVYsqNFOvOKkWXobEfwCX/qH2Kq3GyRSFU
	4YaxZsjOqNppoWf9P4CSzPKvPnJylzpVYNKkG1NrOJ0pZCWMwZwAQ1PqytfMz/k+7mldiVVhx0I
	UPyuV5jKIf34ZPb8tDhjY059NjMyHZuWru5HU1WzlBg41SPpYO9OJyODgRz4ahAaGqgX5asD5kB
	BBPXrJ5NlJs/rw8xRcDN5wDmMPJB2V8mrfuzu+nW22R2iNHt8J1o7g742h4jjs9ES9AudGJpLS0
	Tr5QLuSaVuHoMTgFKl9cfW85giRj9Rn2SxWkwagzmSgSibhPEoLuqthO4gKA/5MzSzroRCEe1ke
	YWPElI4zHdi8SMws+e2by1e4Hh9dT7
X-Received: by 2002:a05:6512:4052:b0:5ad:699f:9edd with SMTP id 2adb3069b0e04-5aea1f63d9amr1156950e87.26.1782406438099;
        Thu, 25 Jun 2026 09:53:58 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:56 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15/6.1/6.6 2/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 19:53:33 +0300
Message-ID: <20260625165335.162311-3-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625165335.162311-1-alexevgmart@gmail.com>
References: <20260625165335.162311-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

commit 2cd7e6971fc2787408ceef17906ea152791448cf upstream.

udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
tunnel xmit functions"), on the path:

  udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()

dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.

Without local_bh_disable(), the context may move between CPUs, which can
break the inc/dec pairing. This may lead to incorrect recursion level
detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
__dev_queue_xmit().

Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.

In my testing, after enabling the SCTP over UDP:

  # ip net exec ha sysctl -w net.sctp.udp_port=9899
  # ip net exec ha sysctl -w net.sctp.encap_port=9899
  # ip net exec hb sysctl -w net.sctp.udp_port=9899
  # ip net exec hb sysctl -w net.sctp.encap_port=9899

  # ip net exec ha iperf3 -s

- without this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
  [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver

- with this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 12469cf1a49d..99686b87b99a 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,9 +263,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2185f44198de..0f7e241178f5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1085,9 +1085,11 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.43.0

