Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884912;
	b=vnit/Aq4sxbidhBSkO3EkSADe3BWGO8PfSIijK4sYYgcnRIpx9YtZ3JxC7loJCnBbvYu
	 9zdn+LjTwojmtx882WFCQzQYu4dO1j4wj4SVh96L+SJXjg/ynpg9T5NfVbmNf40uZAVrB
	 RYEYBJHxfdo5tEPHeoQzSniWLk2PLlIhovAnm310cNUaiK3OVONDHEnEyii0MZfM2lat4
	 l+r/T3kq+mwbjq26l9N/YeZZipywjN7MJY137MkKYsVKyxYNymBP5fCdbFAIOxYJPt/Hs
	 wrghjTLlPXdW0XvIe5TH91oh72+kAicXL4Q2eACYpueMzoakA0PpRrGF4PU5PPTwVmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884912;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
	b=V71OtMwMv+Hn7vBOnLL48XUZ0wHLQMqg/PA+Lzd4ia5Ygw+3VwlvB9K/RIXGnp1pcE+a
	 KYMjNVWUzn60AahscBm3LrdYS7sjOJB3aK+hb79/vLo9x8CiiQEcw35DP4TaX/GfZJcxy
	 XAyZoX0vDqTirP28hJVJc/5gV4hIV19FY1OKGS+EAgzfcbzcQ7pfPY98CLWJ8VEEIiOBr
	 EtXNu9Q9ofSJ16B/e0Z5uc/3xA9GnQQQU/SGFkU9E3Tq0nb4VZvr+7bjrb4lr0+xNlRex
	 NqzW778IGNCcPpdMxu5qMT7+oYHq2x+QJV+rmfkcx89A8EGON9cPSEDf3IstvxX+xYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKX8a5cs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2D606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKX8a5cs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793884911;
	b=uuxAcl8kgkcuAMgOIFD+pTEARJhJF5RIMSh+VUIh44lLmZAxueGOO4VVENthNx945Aip
	 DHQSyrL4ecGsYjCiJBdMtt04zJgSbhS1+80wcSMlSjs3M7hFSlqX14scc/nBFMFxHHOLv
	 K/dcmtoH7/F/ITn0s4h38YN2zNck1q51mqdm//P7oDnqqOQ02LH5pagI45pMRbVuo7Kg1
	 4noEFD+lhvivO48Ro1LRq6ztErApj/TUJ9BbYHcUNmJL49Gktg1fNIi83X5MHAJooJWtP
	 U/MNE/NjOmvaO56KfjyQqqE2eZyGzB0EVe5k2ddFNAnsUfct+WTA093HwzBP0e8v17g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793884911;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
	b=XnEnp6HFL9dSxCOV3iEnTk7NtF3CJsFHXUGu6VYTGiE6JF+tfgOu/ehnMIoO8wxfKcH4
	 dN8X4qU85VZQA0U4z+blQnhCxY41fdFXELWjLmTWMFP2VoU6NzlqcqnO7I69AORh0cmML
	 n6zteCHMg669GIcZH/ifGHcLHpdolg2ayrn8h6bQM5ND9VjIYc+HnYUMRA5aKN0nvbN1K
	 23Ne6Wv8K0MVHYLktWdm8ZK60qYorvoumXZrIGo+jihLEvZOfikwbk9EE2/2DgQYzMMmA
	 8Lz8ycXYA7qij1WKEdb+ZbubYnhW6xwT534OCgoZkEVcQq3rFw8U4d/ocM+qEZZxdng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C6AC21F00A02;
	Thu,  5 Nov 2026 13:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884911;
	bh=kQXVzs+UYaWDn+IaqCcCLtAQKsKwcmCsC/NWALdi5xA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FKX8a5cspFps6w+HwM2Ioc2w3NeOE4zkIq/KAAahb46BWyWEe/oaUfmbEEvWgDZnh
	 6Zi7cdSX0DyKayQlnPRvPotLcgcBqTYP6nvPtBbp15T8hcHvuqFEAgIlkldDkhIDF0
	 DYM0gdjNgTW1BTwFsMtO72taSPFjaBJRRIeaX3swjyNibcLWW7hTgMlOmj7541gl4U
	 GtivFbCKfdA6lEiq/uWAdV3HJTF1gcmPm//2/bETo3ZzOQtxT9i6VH6lTISlJ6lBFn
	 6RTNqAakZtCFzbP3228gVlGCSflBbablWN/ofqepxA9DEG8Ktqr1CcmuluvvwOvk9V
	 yg50G5y6f0n3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 41A6747271;
	Thu,  5 Nov 2026 13:21:50 +0000 (UTC)
From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k_via_B4_Relay?= <devnull+Dominik.Dvorak.econ.muni.cz@kernel.org>
Date: Thu, 05 Nov 2026 14:21:15 +0100
Subject: [PATCH iwl-net] ice: fix Rx byte accounting for dropped XDP frames
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-ice-xdp-rx-bytes-v1-1-63da7b5e3d76@econ.muni.cz>
X-B4-Tracking: v=1; b=H4sIAMqC7GoC/x2MQQ5AMBQFryJ/7Sdtg4WriEXVw0+kpBUq4u4ai
 1nMYuahiCCI1BYPBZwSZfNZdFmQW6yfwTJmJ6NMo7WqWRw4jTuHxMN9IHJlnc0oGGcoZ3vAJOl
 fdiTXyh4H9e/7AYxXQEFrAAAA
X-Change-ID: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?= <Dominik.Dvorak@econ.muni.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884909; l=3624;
 i=Dominik.Dvorak@econ.muni.cz; s=20261105; h=from:subject:message-id;
 bh=jfrNnQ7InY4Nb94BiB/3wT4b52lrC1Z8QEHRLs4bn90=;
 b=6zN3cKhm2x0ywzitDLLbqyMLnFFkq/laCYFenPD5EbBny9wxp05fhN6XuGjklEkEP2T03OLO4
 1Bggsv2bG6XBqLSi8kQtuZJMGbmNlzKK/IFJaBdjD3UDUxpH6LEUu5L
X-Developer-Key: i=Dominik.Dvorak@econ.muni.cz; a=ed25519;
 pk=RTZ8nGbFvBgcLsYzcjFd1S3jciozWEBDwMVtwC7jkGI=
X-Endpoint-Received: by B4 Relay for Dominik.Dvorak@econ.muni.cz/20261105
 with auth_id=1418
X-Original-From: =?utf-8?q?Dominik_Dvo=C5=99=C3=A1k?= <Dominik.Dvorak@econ.muni.cz>
Reply-To: Dominik.Dvorak@econ.muni.cz
Content-Transfer-Encoding: 8bit

From: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>

Since the Rx path was converted to page pool and libeth, ice_run_xdp()
returns the buffer itself via libeth_xdp_return_buff() on XDP_DROP,
XDP_ABORTED and on a failed XDP_TX or XDP_REDIRECT. That helper also
sets xdp->data to NULL. ice_clean_rx_irq() then calls xdp_get_buff_len()
on the same buffer to update the Rx byte counter, which evaluates
xdp->data_end - NULL and adds the low 32 bits of a kernel address to
the ring's byte counter for every such frame. For multi-buffer frames
it would also read skb_shared_info from a page that has already been
returned to the page pool.

On an E810 with an XDP blocklist attached to an 802.3ad bond, this shows
up as jumps of up to 4 GiB in the per-queue and netdev rx_bytes counters,
one per dropped packet, while the packet counters and the hardware byte
counter (rx_bytes.nic) stay correct. The bogus values are also exposed
to unprivileged users through the netdev statistics.

Take the frame length before running the XDP program and use it for the
byte counter. For XDP_TX and XDP_REDIRECT this means the length of the
frame as received is counted, rather than the length after a possible
bpf_xdp_adjust_head()/bpf_xdp_adjust_tail().

The problem was tracked down and this fix written with the help of
Claude Opus 5.5 (Anthropic), working from netdev and ethtool counters
collected on the affected system and from the driver source.

Tested on an E810-XXV (7.0.14 kernel, same code as current master) with
an XDP blocklist attached to an 802.3ad bond: without the fix, each
dropped packet added about 2.5 GB to rx_queue_N_bytes; with the fix, 40
dropped packets produced no such jumps.

Fixes: 93f53db9f9dc ("ice: switch to Page Pool")
Link: https://lore.kernel.org/netdev/DB7PR03MB460158B90A64D025962670E0D5772@DB7PR03MB4601.eurprd03.prod.outlook.com/
Signed-off-by: Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>
---
Based on the stable v7.0.14 tree, which is what the affected box runs;
the changed code is identical in current master. Tested on that box
with the fixed module built against the 7.0.14-26-pve headers.
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307d076153f77671e8c9a6ff4f8dd28..f62a1bb7bbca579b43fe2f4c8e1946e65b5cea63 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -968,7 +968,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		union ice_32b_rx_flex_desc *rx_desc;
 		struct libeth_fqe *rx_buf;
 		struct sk_buff *skb;
-		unsigned int size;
+		unsigned int size, len;
 		u16 stat_err_bits;
 		u16 vlan_tci;
 		bool rxe;
@@ -1028,13 +1028,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!xdp->data))
 			continue;
 
+		/* ice_run_xdp() may free the buffer and clear xdp->data */
+		len = xdp_get_buff_len(&xdp->base);
+
 		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
 		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 
 		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
 			xdp_xmit |= xdp_verdict;
-		total_rx_bytes += xdp_get_buff_len(&xdp->base);
+		total_rx_bytes += len;
 		total_rx_pkts++;
 
 		xdp->data = NULL;

---
base-commit: 458c6079fc1d41d564c37679c8ace02cd83ee817
change-id: 20261105-ice-xdp-rx-bytes-4aca4ac0e2c2

Best regards,
-- 
Dominik Dvořák <Dominik.Dvorak@econ.muni.cz>


