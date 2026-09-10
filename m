Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA73998B1
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030866; cv=none; b=VKpaLsoT92l30b3g4RCDV+i/kAgZ/Sg7ahCEEsHwE8dTV52wWTy6B5E0i4F4bgTGn6+c5K3wN8Daa4gIdRSUrFzO9SdTWZoxx47bPJgfm66CYRsGvV/TNR/lgnXWl+KuK/HZK175/XCvr39TUtghRXzE/m/f2aVtb6Rp0wG2G7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030866; c=relaxed/simple;
	bh=dIbn/KArTYPw3HGBcspbqNsB7qAbz+1bLc3X+IlHTbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAFjyw0x4YR9v1kK95fHc+PECedbTeX7cEnstlVijnHVn4ONRtwbagmWFKlKMMgN4lo136+vWlXToD7TGiPxytQ4c345JBUEKDr+yGB81/srLKW7Ww+8rg6v4m9Hjt3eznD0Nnsm2gVEzhwXqMLJmknFDHI9AKb5gbbbphNRFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=nYMkALf+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="nYMkALf+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9c60d5so253813166b.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789030855; x=1789635655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5B7LaAqbmIcqcPKni65pEo4KDgrq44npDo9WAUJP4Ho=;
        b=nYMkALf+capkKa+4JS4BUFEJhWBnltfUQ3T6GFa44bTnHXHVw8U638o1jV8TyhksoG
         n55QpE5rKgKFGTxGbvIFcQtWY2JyLFSyFAR9hVpcXw+TWhWP0Ujk7XWBOzm5dAXS+Nru
         Dk6g1vz+NQ0GFuPpOUs9evnr2Q8uCDpfIGUytT3S5c4GXWlLvZRMplEZwHgUcIdKgVHA
         ts6HKyfnxFCjtfdIQke3u76Zjp4ajJMH70tYEmOq6nlX/hi+Ak0wsDIb4sWJ+8e7GFpR
         qQYT7OK+u7RkHN85HmI9jZWaMfQfthBeY2t/Egsc027LnBw7DuvV6IaT6yY2uCG/22Zz
         O5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030855; x=1789635655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5B7LaAqbmIcqcPKni65pEo4KDgrq44npDo9WAUJP4Ho=;
        b=sKvEML33YYuZFRSbJcbnRLnSyCmXIwDGwfrhzSeAQizYhguR9tgDx9/CTtIor9+1Gk
         PttYdqUEG2xoXhWyEZH94ti78c5YtSih7LMOONoqIXD2WYjHs+Dd6OQSVNyOho2dcZyJ
         NyQH0x6DArXFX02W+cbVl1XHObG7Ngc6WLZfFiwKL34RANUfveKr8c9PtNYevV/aNb7w
         EZGqkeDuTdOyZhY3Ziklw1Z9TlTGlz7eY/eqoXDAD7H00IX/jipBH+jmJ6WSq9qN7LLP
         3CcDbqvVc+2h+iq6j0rq8RfenpvSmZhDb3gCF6ihq9WUxtE7lWwUu1etqsSTzBUUlwuO
         22kg==
X-Forwarded-Encrypted: i=1; AKwUvBx3Fx4hSIx85Fb2VImVxcU5YnHGasC3YIl/FlSttjc/NYD6joWi/7tI8DNemUoHOPQyzXKAqgU=@vger.kernel.org
X-Gm-Message-State: AFuF++n+f/AtB4ogfsGxgG1Mao5/uNR2padh73svs4zYCnAcqvIm2v/b
	Egx5jn0m0gTCeis2Xkv4qtkb6y+OqDnBbyMjbxBiVWQeCNJN8fVrYH8F4z7Rwb4CEA==
X-Gm-Gg: AYBFou2IvOT5l+AWhf1l8JUCKkDLj6izRqpTrKHK90R6e4Z6k/sKyGx2kcKnwOFTP5p
	wEPLu/j8fa2IVIvXsKfMoC0qk9xvtRIbfXS9bzP9uP0t69P5MW1vezSZboRmfIF/NRt6iSL4Ew7
	EZxKloWbElzX3ZseAUT2kHiL4H245qYJw3RbGd2XyzqCNiTMViAEyzM4or4FC/9y9ycLaHu81iF
	2BWsUbppWZGMJaAwlImQE0dm5Xvrnb83hoN6Klpr2PgFKLrBNJbTNga5a9AWime/khG7KuN0iYf
	Umxrgpuur6k8f1VisTJDMRR2pws7y1i3I9h70oOZZI3G3luXPatYP1jgj56BJiDF0hF+Mfv72oA
	G7Mbrj50dQmjTbVAuIdQgq3ByJVjkrHhTCFi1y3IgZk0TJKVQyqwhwz3Bb4YUdQ3kOHMlYaf5Ac
	hh+EXDQmT7x+6oktu0Xed0Pmj3MFv4rB8aWRG4P2G8qGc9yGuljlNbzAi4B86gDqlJaiZ8gpf5J
	6it+AWPe0sqDh8bB+pSTQ0JlB+SLo1fByu9Fmzd9zLle68wnI9P8HhRgXWhMFKEGo7dQ+G6sF7y
	yqek58vZibTMdua5V5+el+z/yBhOG/CfIB6rmbkXCTbysdbT86Ry2NjcJN6/MojrvWfzoROn5FX
	TvKCtllU7Esx9YXMPKLGFHxxOZEr0ivztwa46dIeb077lYQ+6/CxfeMhCyJ2EDkv4DxXPqzHO0Q
	WBZ3H0oNpWaXzj8JLF
X-Received: by 2002:a17:906:8f8a:b0:c25:f7db:4bed with SMTP id a640c23a62f3a-c2945efbe7emr186476666b.19.1789030852391;
        Thu, 10 Sep 2026 02:00:52 -0700 (PDT)
Received: from Desktop.fritz.box ([217.26.235.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293eaf1ae8sm156106766b.40.2026.09.10.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:00:51 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com
Subject: [PATCH nf-next 0/4] netfilter: offload a TCP flow whose reply is never seen
Date: Thu, 10 Sep 2026 11:00:48 +0200
Message-ID: <20260910090052.2034970-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A host that forwards one direction of a TCP connection only sees the
client's SYN and then an ACK continuing from it; the answer took another
path. That ACK has no entry in the transition table, so it and every
packet after it are invalid, the conntrack entry stays in SYN_SENT
[UNREPLIED] with a single packet, and the connection reaches neither the
stateful part of a ruleset nor a flowtable.

Patch 1 takes such a connection over as the mid-stream pickup it is.
Patch 2 withholds the reply direction of a flow offloaded in one
direction until conntrack has seen a reply, and offloads it once
conntrack has. Patch 3 offers a connection whose reply was never seen to
the flowtable in the original direction. Patch 4 adds a selftest arm for
the path; without patches 1 to 3 it fails, with the router forwarding the
SYN of the connection and nothing else.

Verified on an IPQ8074 router with hardware flow offload, iperf3 -P2
between two hosts on different subnets of one bridge with the reply
direction bypassing the router:

                                  CPU port    switch port   throughput
  asymmetric, without the series   81k pps       81k pps    944-947 Mbit/s
  asymmetric, with the series      2-11 pps      81k pps    948-949 Mbit/s
  symmetric, with the series      11-38 pps      81k pps    926-948 Mbit/s

I wrote this series with the help of an AI coding assistant, as the
Assisted-by tags record. I have reviewed and tested it myself.

Gary Dotzler (2):
  netfilter: conntrack: pick up a TCP flow whose SYN was never answered
  netfilter: nft_flow_offload: offload a TCP flow that has no reply

Julius Bairaktaris (2):
  netfilter: flowtable: promote a flow offloaded in one direction only
  selftests: netfilter: cover a TCP flow whose reply is never seen

 include/net/netfilter/nf_conntrack_l4proto.h  |  7 ++
 net/netfilter/nf_conntrack_proto_tcp.c        | 19 +++++
 net/netfilter/nf_flow_table_ip.c              | 26 +++++++
 net/netfilter/nft_flow_offload.c              |  6 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 73 +++++++++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)

-- 
2.53.0

