Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089583;
	b=WQW+4Lel3HvnJFGRrGejxdo6c3bB1wi4/h1LgAW9YGO4fvrscGrLU75MCXdC4nljQeMl
	 +66gxvmhNHHoozQqnNSrcSS35aP+mAaXMqBSgu9bMhi/zsOzaLxkMJTZXAU1t4zDlCfwd
	 4scbzKvL/Mikj9er4eENdLlkDNUtvl0d1ettHUdKh5FFUKfhUNLqwHqgp9KsOmXxAyTkP
	 1nq7jRaTiw3LsPmAuBWpeLBeLw2y5XhVoNR2kd2Q5xgZgiOXnd9UFs1k0LCYEUDPJLXnP
	 LFGvLlrivIIVTtbJTtED1/hEa7pC0YnY3qRinzwnISZMVMkOrlG/Rzcw6c1k/OlFcMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XpW/DdE5qn9QatlbEdzB04ru20fRF8+9BwBzjywZl4M=;
	b=ImyP+TRXFmjrm01Yzymd9RHHBRuSqOPKP64pP/l2lug9p7qvP1bZbzA+yaQb2NJXrvvA
	 /hiwPRSqFeAAauWrfWyhQoBOELhWxh6QDpEXmgvqF3CF18Ha4LAb7+Yol/hUXHZCCyhXD
	 gC4GN3/T2Q+UP2lkl0Qadhy3F6Uhap+OuPPeL0Nt6MAldOHkaHW7a4XQm3R49ZG4J43uw
	 4FmAnfKh5+Nz4NFb9wT+gfSAF5zLgGlaa3il3Kdsm24gFZlqYM7blfuIsG2cnJWt+2eGu
	 iC16LBxsE8APdy9HouejDvQo1mGGFmtSd29Hxj57dO7A/32xN2gx1iQn5LRbDD5mGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU7z0pT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DE606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU7z0pT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866CD1F01825;
	Tue, 27 Oct 2026 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089582;
	bh=XpW/DdE5qn9QatlbEdzB04ru20fRF8+9BwBzjywZl4M=;
	h=From:To:Cc:Subject:Date;
	b=eU7z0pT6IsfrV7wrlJ8Nst61Byi0ux/HTaTNI3bOcbfpNvQhqPgpOESbTvM8cjLGm
	 RIe0wLIhrNDxZaIIZsGA1KFftd+8wXOaE/4HAqEbt3dqufpLT/zDeOSIlchE0FDMz0
	 l4w2dr/quTfKnHtH388W6tM/dSMDHa4RQmkWZcQ/mDIlTX56dRamtz3mbaLahDlrnM
	 ZtLIrf41CnwAIYIpD2xsPh0n5N+G0OgkyRrQiQrngSO383PPOV5Mdk1LZSFz5ke2vy
	 s+KEmj14W2WRGZ9I+skYV3PsdClo+oQxl8Pe844koQE5v03oJTgPI+Crtsvjuna36c
	 8dH5Yn46KnsVw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>
Subject: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming from the stack
Date: Tue, 27 Oct 2026 09:25:59 +0100
Message-ID: <20261027082604.1485903-1-edumazet@kernel.org>
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

eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
NIC drivers always provide this, and they should keep using the fast
version, without an extra pskb_may_pull().

Devices looping skbs from their transmit path back to their receive
path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
the BUG() in __skb_pull().

Instead of fixing every producer, or adding a check to all
eth_type_trans() users, fix the few consumers exposed to this:

- Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
  header first and returns a drop reason on failure.
- Patch 2 uses it in loopback_xmit().
- Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
  ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
- Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
  (TEB) and NSH pop cases at once (only the MPLS case was tested).
- Patch 5 (from Jamal) fixes act_ife decode on egress, which was
  consuming the inner Ethernet header. This is no longer a crash after
  patch 2, but egress decode never delivered a correct frame.

Other eth_type_trans() users already pull the header or never see
such skbs:
- vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
  before vrf_local_xmit().
- tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
- XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
  ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
  only trims frags.

Tested under virtme-ng with AF_PACKET reproducers. Without the series,
all four cases crash in eth_type_trans():
- lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
- lo egress "action ife decode pipe", IFE frame with 8192 bytes payload
- lo egress "action vlan pop_eth continue", then a BPF program doing
  bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
- OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
  eth/mpls/eth/4096 bytes frame
With the series, no crash. An ICMP echo inside an IFE frame decoded
on lo egress is now received and answered. Normal traffic on lo,
veth (including 8000 byte pings) and vrf is unchanged.

Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com/

Eric Dumazet (4):
  net: add eth_type_trans_careful()
  loopback: use eth_type_trans_careful()
  net: use eth_type_trans_careful() in __dev_forward_skb2()
  openvswitch: use eth_type_trans_careful() in internal_dev_recv()

Jamal Hadi Salim (1):
  net/sched: act_ife: do not consume the inner header on egress

 drivers/net/loopback.c               |  8 +++++++-
 include/linux/etherdevice.h          | 28 ++++++++++++++++++++++++++++
 net/core/dev.c                       | 18 +++++++++++++-----
 net/openvswitch/vport-internal_dev.c |  8 +++++++-
 net/sched/act_ife.c                  |  4 ++++
 5 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.53.0

