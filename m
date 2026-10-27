Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144989;
	b=h+ejRYyehXji/rmx/PORLBaoAAo//y6viVo5h58OxoUpdozh3MFDaxdUD6wi98oTCEMW
	 OCi94pEk6D/DV6XcapludxzGprsloUihtL7Yv+WumF9o9u0vvK9DnSkN5K9PHfRQAf1c/
	 5MeQ81TGJy8ySrz+8cOmfJ40EPQ8W9CunD0Uo5QkyqoBn9WDKuyc1Dp43n35tU0Oz+WUc
	 jhyTIIaft9pJTW6pd2HkiHRaXSgPAPq1Ltf/d6q7d4umZwzhmoJOAsUOc92ONcIoXJ/Jx
	 ZPfsnMK7xzYpvY845GIqBK78FaO/HLk1KLlH/DlABaUBqbQNvv6zyTRW7WMBy1+pmFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bqIhIyDGm0qv15oVHFaINcz6UZj9AfsmtRw0L6gOf5c=;
	b=DYUL0PkGVA4p+ARCa5nrwPqcKuaOGc31T0MJFG28xs6c3YMFNF1JFzPVkMjYZeVsMb+h
	 SLQbQEhG/FrdnGZnY1BxZMqBSVIolbMCZhFBDUPcw7TqfR7skXV10KkjUQFsDkxIvmDqO
	 8hhSQHkTfbTD1FfQkdZwb34GzunzTpgqmien3UEjgIuNHWkrpqZ8WMsQHRIh17unP8ECs
	 k1HKLCaxWiywR4VFTJLD8fHQIaIoR4969InJLDmjTvTp/rpJ14bYRDOvGd6bL2bq9HIeP
	 FRFiti1uNh73hstIcmdpn6OGklMRCQLvP8LdJmsJO/8b7mfwmbC9VMe7/mHcZEpVylA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIAoheN7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D7606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIAoheN7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC181F031E1;
	Tue, 27 Oct 2026 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144988;
	bh=bqIhIyDGm0qv15oVHFaINcz6UZj9AfsmtRw0L6gOf5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cIAoheN7+S+BlxlFKUZdiEAen1VCWLlh9mf75ZaogwhE+ngsiZbk3u0GRD8iiKupm
	 q+MX+nCILsFgAYtDeEyCAl1j0ogeC+L0Uzq5sfsumh3PR0zcf/JSCznMGiF2B4Oc6c
	 7v48wsvMFSG5os4uOGogEePAPoq/1kjgPkR5zoeuSP+IfDQBNB3xZ90E5WGhiZeh2w
	 iFE+DpOAfeNSslvELtkaZjF4ACHfs95qCI8prU5UJLSxyWX8g/xqdSfLlfTT9UXYbF
	 NnKWkDKtbcBde7JgZFwtSL9eNaRHLNlDisQNjzJFgsFz+4JJkL3ME8SAz8o6QWG6q8
	 leVEKLlsNxWFg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	eddie.wai@broadcom.com,
	prashant@broadcom.com,
	huangjw@broadcom.com,
	gospo@broadcom.com,
	brett.creeley@amd.com,
	ap420073@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/5] eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
Date: Tue, 27 Oct 2026 16:49:38 -0700
Message-ID: <20261027234940.1267225-4-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
References: <20261027234940.1267225-1-kuba@kernel.org>
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

If a replacement agg buffer can't be allocated for a packet received
with XDP attached, bnxt_rx_pkt() drops the packet without returning
its head buffer to the ring. The head buffer leaks, and since rx_prod
still advances, the device gets a BD with a stale DMA address which
points at a buffer the driver no longer owns. When that BD completes
the driver finds no buffer in the slot.

The agg buffers consumed before the failing one have already been
replaced on the agg ring, they are referenced only by the frags of
the xdp_buff, which nobody frees. bnxt_xdp_buff_frags_free() would
skip them since the frags flag is set only on success, so set it
upfront.

Pointed out in LLM review of the first patch of the series.
Tested on a BCM57504 at MTU 9000 with a frags-capable XDP_PASS
program, receiving 8000B ICMPv6 echo requests (a head and two agg
buffers each) while page_pool_alloc_netmems() called from
bnxt_rx_agg_netmems_xdp() failed half of the time (bpftrace
override()). 44.7k packets were dropped, the page pools' inflight
count stayed flat and there were no KASAN or DEBUG_PAGEALLOC splats.

Fixes: 4c6c123c9af9 ("bnxt: adding bnxt_rx_agg_pages_xdp for aggregated xdp")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2e7276801fdd..4607c31eedf8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1427,16 +1427,19 @@ static u32 bnxt_rx_agg_netmems_xdp(struct bnxt *bp,
 	struct skb_shared_info *shinfo = xdp_get_shared_info_from_buff(xdp);
 	u32 total_frag_len = 0;
 
-	if (!xdp_buff_has_frags(xdp))
+	if (!xdp_buff_has_frags(xdp)) {
+		xdp_buff_set_frags_flag(xdp);
 		shinfo->nr_frags = 0;
+	}
 
 	total_frag_len = __bnxt_rx_agg_netmems(bp, cpr, idx, agg_bufs, tpa,
 					       NULL, xdp);
-	if (total_frag_len) {
-		xdp_buff_set_frags_flag(xdp);
-		shinfo->nr_frags = agg_bufs;
-		shinfo->xdp_frags_size = total_frag_len;
+	if (!total_frag_len) {
+		bnxt_xdp_buff_frags_free(cpr->bnapi->rx_ring, xdp);
+		return 0;
 	}
+	shinfo->nr_frags = agg_bufs;
+	shinfo->xdp_frags_size = total_frag_len;
 	return total_frag_len;
 }
 
@@ -2293,8 +2296,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 							       cp_cons,
 							       agg_bufs,
 							       false);
-			if (!frag_len)
+			if (!frag_len) {
+				bnxt_reuse_rx_data(rxr, cons, data);
 				goto oom_next_rx;
+			}
 
 		}
 		xdp_active = true;
-- 
2.56.0

