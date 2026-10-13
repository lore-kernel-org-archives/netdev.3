Received: from mx.sorah.jp (aapne1a.mx.sorah.jp [3.112.186.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8B1A7264;
	Tue, 13 Oct 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.112.186.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896583; cv=none; b=Qa4tW/l0Rj0xwONe2DUZS+8JYg5ZfmXi7Gq9fYOdYjPJAB36SFOZkmqh/hdC/ZJFYIkKLShmwjZ03m5RVCB/a8bpmM6zd2J29AgwZoiuHj00VGsK68wlr9DBbfzls83e5j843v0SiVO1kMJpOCkR7hMr9dMiV5REY9ti7auDszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896583; c=relaxed/simple;
	bh=QMSPg6QmrXJ7vGJN/pvcE6kfmJaeP7jSA5r70Z1e57U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUCd/GvMhDd25vuVwVjr6fA7iFBl1Xum+Kf/tylt6aK0wfudXaG0X9YixWDZ2IxFonCZb7MMP6BNsHmmZWFAQGz3MKgLhzdjB2LLvrP63jgZVP94RSPFWRGR+0foimbgilChquo5s5MweRq3kfZn03QZ/phORC7of7ZyGoELb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp; spf=pass smtp.mailfrom=sorah.jp; dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b=PTxWDPU9; arc=none smtp.client-ip=3.112.186.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sorah.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b="PTxWDPU9"
Received: from mafuyu (home.igw.nkmiusercontent.com [192.50.220.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.sorah.jp (Postfix) with ESMTPSA id 4F8E160116;
	Tue, 13 Oct 2026 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sorah.jp;
	s=nkmi1707srhjp; t=1791896580;
	bh=QMSPg6QmrXJ7vGJN/pvcE6kfmJaeP7jSA5r70Z1e57U=;
	h=From:To:Cc:Subject:Date;
	b=PTxWDPU9knOXyuJUhTL0h3YJQvbiDBFb9LTzbteVSN/O4s0opI+ywuoEotb26AeB5
	 XojzIR2Fc3Iw9Zm2AxDoJg+A1+hRSghg/UzQobC0Msseaz05akWz0G/n7vcs93zpmt
	 mlohwtOBCmQnsnh7HSNjs2gbqmv5rfUF8CzOhe+Bpq/+g/bNa0K0hNqBZg1MlA/Ry+
	 TkZUp06y26doNLqZdhTeRByhYNK7TvCV6tDrv4jivYMS7S7pzOIUkHG490FLhIr0pu
	 N2o6j82FfaF1d8BAnDQWl7Mddb1Aqr/ZPIrjHHJfdSwAuhivME/7GsIFrtl6dUjwPp
	 VEz0de3CP6IWQ==
From: Sorah Fukumori <her@sorah.jp>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	lixiaoyan@google.com,
	linux-kernel@vger.kernel.org,
	Sorah Fukumori <her@sorah.jp>
Subject: [PATCH net v2] net: gro: don't chain linear parts larger than gso_size into frag_list
Date: Tue, 13 Oct 2026 22:02:48 +0900
Message-ID: <20261013130250.3643916-1-her@sorah.jp>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_gro_receive() chains an skb into the frag_list of the held packet
when its payload cannot be attached as page frags: when its head is
not a page fragment and still holds payload, or when its head and
frags would overflow the frags[] array of the last packet. Since commit
5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
skb may itself be a GSO packet whose linear part holds several
gso_size segments. skb_segment() cannot split the linear part of a
frag_list member across segments, so segmenting the aggregate in
software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
hits

  BUG_ON(skb_headlen(list_skb) > len);

Fully linear GSO packets come from generic XDP. When the program does
not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
skb with pskb_expand_head() and skb_linearize() and keeps its GSO
metadata. GRO on the device runs before generic XDP, so each aggregate
passed by the program carries all of its payload in a kmalloc'ed head.
A tunnel that decapsulates these packets and runs GRO again through
gro_cells then builds the bad frag_list. This was first seen on a
router that forwards TCP received over VXLAN, with a non-frags XDP
program attached in SKB mode to the underlying bond because one slave
lacks native XDP:

  kernel BUG at net/core/skbuff.c:4917!
  RIP: 0010:skb_segment+0xbb6/0xf40
  Call Trace:
   tcp_gso_segment
   ipv6_gso_segment
   skb_mac_gso_segment
   __skb_gso_segment
   validate_xmit_skb
   __dev_queue_xmit
   ip6_output
   ip6_sublist_rcv_finish
   ipv6_list_rcv
   netif_receive_skb_list_internal
   gro_complete
   dev_gro_receive
   gro_receive_skb
   gro_cell_poll
   __napi_poll
   net_rx_action

It reproduces with three network namespaces: TCP sent over VXLAN on an
IPv6 veth link to a router namespace that has an XDP_PASS program
without frags support attached to the underlay veth in generic mode
and GRO enabled on its VXLAN device, and forwards to a veth with
tx-scatter-gather-fraglist disabled.

A program with frags support in generic mode gives similar packets.
skb_pp_cow_data() rebuilds the skb with up to about a page of linear
data in a page_pool head_frag and keeps the GSO metadata, so once
frags[] is full the next such packet is chained through frag_list
with more than gso_size bytes in its head as well.

Refuse the merge when the linear part to be chained exceeds the held
packet's gso_size. tcp_gro_receive() then flushes the held packet and
the skb starts a new GRO packet as its head, whose linear length
skb_segment() handles.

Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5
Signed-off-by: Sorah Fukumori <her@sorah.jp>
---

Notes:
    v2:
      - Mention the head_frag path that reaches merge: once frags[] is
        full, e.g. after a frags-capable generic XDP program (Eric Dumazet)
    v1: https://lore.kernel.org/netdev/20261013102453.3272620-1-her@sorah.jp/
    
    Testing, on net b7ad72414c67 in qemu/KVM (x86_64_defconfig plus
    VETH/VXLAN/BPF_SYSCALL built in), using the reproducer described above
    with iperf3 -P 4 for 20s:
      - without this patch: BUG in skb_segment() within ~3s in 4/4 runs
      - with this patch: 8/8 runs completed without a splat
    The same reproducer also hits the BUG on Ubuntu 7.0.0-38-generic and
    on v7.3-rc3. W=1 build of net/core/gro.o under allmodconfig adds no
    warnings. Full allyesconfig/allmodconfig builds and the net selftests
    were not run, and no selftest is included.
    
    The frags variant did not crash an unpatched kernel in the same
    reproducer with an xdp.frags XDP_PASS program, also with RPS on the
    underlay, gro_max_size 196608 or sender gso_max_size 8000-20000: GRO
    batches there are too short to fill frags[]. A kprobe on
    skb_gro_receive() shows the 64K page_pool skbs carrying about 3.4K of
    payload in the head, and the non-frags variant returning -E2BIG from
    the new check about 4000 times per 20s run.
    
    The crash analysis, reproducer and fix were developed with an AI
    coding assistant (Claude); I reviewed the change and the analysis.

 net/core/gro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..ff828a3dce3c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -187,6 +187,10 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
+	/* skb_segment() cannot split the linear part of a frag_list member. */
+	if (unlikely(headlen > offset + skb_shinfo(p)->gso_size))
+		return -E2BIG;
+
 	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
 	skb->sk = NULL;

base-commit: b7ad72414c673ce1fa1f463e807cd4f34f8be9bf
-- 
2.55.0

