Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153226;
	b=Fx//foqSlk1rYo3HIwVsESi+L1hnqjPqsJB4vg/zYsIrZEyDb221hVlVnzDslJP5h7RK
	 K4PRrsZkn21qWTLjrgqd4Gyds6rxkXxuuclhUvBJQbWi674onlgg4mbwJMMx2Mnb+r67U
	 zL88rEST8xtjp7/267kXqTmOHkCh1UORSgDilnB0qk+WKzICgwL1m+R/IuWxGZYbHbQVx
	 Udy6MjbppPxugjVoljRdBrmx38Pn425fvVnE9CiofhQqXm3bDWM44q+OQqsCcxy6TEZhh
	 EvkbubrQjM8BpQ6xiQD1xJBHxeYBwihTg4v3Xuj79QHZUFEOZH0azyq3Y4AzmvYCEhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
	b=EXtvd13AI4dPAtLbUMelwgx3PVEEIhUh1hs+BaM4VLnjU5bKw7dhhnxhVDN/u5kbWOZi
	 sGWqeWMa6cti44YhfNQy6X1488aRKYxHleecYltXP9yPf2Wc1mB9Y1u3aH8TMJgMPp8Vh
	 qUJveQW5SMRBEKsstrlLMQOAf6lm3aG2u4405Opn2l4/TUleF26w/ysz6N1GSLA3wY3BT
	 VUiT0Ztjj0W1dH8Vm648fqqKjuNuCL/MA3H2QRS3ARsTHAU+ADE15FjNCz8pSABFBVu23
	 EsTESWSvzvHU8TBPhzPqoep4a+j6vGMJY3Tgw8QVeMS7SE8+07bI3Q5Smx76rgsI93Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=jdBtDWjZ;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC8606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 15:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=jdBtDWjZ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c40f29667e6so21595066b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794153225; x=1794758025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
        b=jdBtDWjZHG5CUzNm32M14oMgSHsFKp9Y/CKm8FSWfpgzguAOR6lo1zlEbGrcrQ2TWi
         dFL1NQni1hq+mKZJLegWtmEGk9ZKN8JuM4K15/A/fbfj4s9rrEBE0REKLe9ZmHA74X9r
         b6vS1Pe2OEBkM47+8qAHYHyZG6kqyA8tCQs297SRzac6iFbUaEBIse5H6JCwF362WE99
         MIbHGwlVpViRiGdLeOpmv2jQAZDYmv1/SfBOpVKegiiptRe52N+z8twHnF4pPx0Vs+T8
         4il9r1znT6g0ilE714rt5BvRbvvsP6jHrixASZzfvm4lDV7ptbkYssMUnPVM9nsJyMcN
         jdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153225; x=1794758025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
        b=Mzp5dP015/3YJbCYH4Pm3ga/QVBrtOsPW1Z54Mtp7+ggikaBx39IUbrYoVvWTq3j2r
         2DDEkBbPA7QSott+R73dHNqG/BU5t+Txo0JxjrvBxc61LmKy9PhJCe3nSLM3ShDQ3n2D
         E25RMymIbwJKs+3yJiTx2VQVtC76ihuh2qFe4kMS/zPRDe718/a0UcP9bYFKmKiWM8i3
         0L276udPsYNlCFYxYuGLK0ZdAfqP951G3GW69gWfLhhsYSoZtlex7eyopnUzkCE9Rjwi
         1i600I1XUdXZ/cr79S2vQxzlsLZurXtRNkXW4DzHIuvCp+R6SgCkih2UOXCBAmIjSPeb
         zBsg==
X-Forwarded-Encrypted: i=1; AL+hErFvpTHVxwP6e94tVxglCjuECVRUhWbN6inU6NAx11J8zbYZ7RgWFZb5TUCmBVUDW1/mIm+8pKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fdyaJX+ycVFO3REjOfkdIctJ4kbWzA6eDodmbUdRop7v1i6/H
	vHB+AL+0M4WRl0CtAdPcX03F+HO2bKH/PtXVwfQsaCn4OYSnd0Gb+nHB4oUPf5PDXQ==
X-Gm-Gg: AYBFou0n4U7iPKyqUaw6k7gCh6opfsm7Ht7sGgNFo220ZreYFG53t7xCKtf/St/tfNr
	4R4Os2Z9sCxYAvVy3Wlm4WlPVknZx8YvfJ++Lj4Z9FvVfvdFhI2Xr0KWJ0d9HtNo8KqpTAmVWok
	g4eqhtrDhrwDJDuN4m7wwbX0Kt4Pn1axf8VQO9WEWAnUca/WaOL31+H5UEYFvdCoClCfI+QilI9
	bsKP/oSfoqh1AaNO20B/hvxqHwMKZ8M2ebhYlrKJ8eoxf7TyBH+GVvC24YUEWotJ8Cni/cL3peB
	t0HhigEMOgzWC58r+cQVzJ8SYE3OHRjBacgYwan/MsJAfNT+FkMEKbkqo/Hea9jVms1PKZ1tRjg
	kUEX3noKuTnidPFKNduJUubb7U0+nVU7TpcbGbVsBwzfIrIUKHOZa2uFLuHBvU9r+j/Df0S83d4
	eO/eswNiL6KQ2vXnGr0cgZaXXfyIDQVNow3s6yqtE85qQCKXmtkjQh8eBUegaZibUuU8Joem90R
	a4Y12f4b3FhQxR1OUaVDZFkE44FkXuXHTslMf48fWddwaz+Td+zVcvk591SS006frj5W2qY14Ep
	wrV4xrdbFWsSy8QmK6U5jPBPMd1wcZ44C/2Ou+PMWL09wvQc2RpVn3G0nGQrGkcGfIYakHYczNl
	aFP3jimQAm3cDdwNvxoe0km87NW96RVs2vBHbgu3y14BuUjg6LtndDFXvij+ncoCtUC8ldOYlZD
	i4z9Wgbywx0FGw7NB1RtQz763am7mxpQCdihKMroJu9OfUta30cFmnTeyCCjxwWKxuwkfmdj+L3
	PVji2KAlKBswkLygGeZh0DZz2JRM0iYWOgCVlGfXkEAq1BHa7Rx6uv3UfF1EQw6ZQwUV0Aajc4I
	UOfNChRdM+qAA90nB/U=
X-Received: by 2002:a17:907:3e82:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c4d6d1aefcamr131880266b.1.1794153224347;
        Sun, 08 Nov 2026 07:53:44 -0800 (PST)
Received: from Desktop (p54aff56f.dip0.t-ipconnect.de. [84.175.245.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52f4bsm71648166b.8.2026.11.08.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:53:43 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH nf-next v9 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun,  8 Nov 2026 16:53:42 +0100
Message-ID: <20261108155344.35845-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down. It is Pablo's patch with my
changes on top: it keeps his authorship, his Signed-off-by from his
posting and a note of what I changed, instead of the Co-developed-by
that v7 had. Patch 2 adds selftest cases.

The flow caches nothing about the bridge. The gc finds the bridge port
from out.ifidx through the vlan devices of the path and the bridge from
the port, and the tuple gains three bitfield members in free bits:
bridge_path (from Pablo's patch), bridge_vlan (the flag Pablo
suggested on v7) and port_vlans. struct flow_offload stays at 296 bytes
on x86_64.

Tested on nf-next 734bef548a96 in an x86_64 guest: nft_flowtable.sh
passes five runs out of five, two of them with PROVE_LOCKING, including
all twelve roaming cases in both of its passes, with no lockdep splat.
Without the port_vlans reset, the new stacked bridge case fails and the
other cases pass. net/netfilter and net/bridge build without warnings
with W=1 (x86_64 allmodconfig).

I used Claude (Anthropic) to help write these patches.

Changes in v9:
- reset port_vlans at each bridge in the forward path, so the gc checks
  the bridge the flow transmits on: with a vlan device of one bridge
  enslaved to another, v8 counted the vlans below both bridges, looked
  up the bridge port from the wrong device and read past encap[]
  (Sashiko)
- selftest: a bridge port that is a vlan device of another bridge
- selftest: the roaming cases give socat five times SOCAT_TIMEOUT, as
  roam_stop() ends it; on a loaded host a case took 109 s and the 60 s
  timeout ended the transfer before the check
- authorship: Pablo's patch is credited as such, with his sign-off
  from his posting and a note of my changes, instead of
  Co-developed-by; his paragraph on the switchdev notifier alternative
  is back in the commit message
- rebased onto current nf-next

Changes in v8:
- drop bridge_ifidx and bridge_vid (Pablo): the bridge port is found
  from out.ifidx through the vlan devices below the port, the vid comes
  from the encap stack (bridge_vlan bit) or is the pvid of an untagged
  port of a vlan_filtering bridge
- the fdb check sits in nf_flow_dst_valid() next to
  nf_flow_dst_check(), the hook is fdb_valid_dst() again, and the
  comments Pablo pointed out are gone

v8: https://lore.kernel.org/netfilter-devel/20261017235849.1066624-1-julius@bairaktaris.de/
v7: https://lore.kernel.org/netfilter-devel/20261014235628.197976-1-julius@bairaktaris.de/
v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
v5: https://lore.kernel.org/netfilter-devel/20260914072541.897040-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (1):
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

Pablo Neira Ayuso (1):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves

 include/linux/netfilter.h                     |   7 +
 include/net/netfilter/nf_flow_table.h         |   8 +-
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  38 +++
 net/bridge/br_private.h                       |  13 +
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  45 +++-
 net/netfilter/nf_flow_table_path.c            |  20 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 251 ++++++++++++++++++
 10 files changed, 384 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

