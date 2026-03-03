Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFF3932D3;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573920; cv=none; b=O146DLSD2aE/bnauF9sSejNUx1QZD8q+3rOn8RFPFgyEe5lRTs5110JG4Csa6O52FUnahQF9YTJMzoQHNVGWaRGvdbkPOlruTB/MgNel++rWILeFAykWTKfAg9tQ1Qx6RNdYH1Pg8zjN7QcDKDeFSaIijL2ukEWZAAwH/f2Y+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573920; c=relaxed/simple;
	bh=kiZnYX3yv/7hSE6KQoiA8UXoibzSF3gsyFHZYK/bwPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pewf4UWGgzqjYvufdiC2kYeuBPL7jAE+1MBhVXTthA016cRtyLMTWVIgkGp2/4GCb3WEr5FYmEFObC8OVeS4nSSwNkggYafA4MRBe8o1vumfznzglU2YU4RNhpRB/a/SoIg5ppdh2csldyedaZMebTU6BgxMUYlSVnt/FWuN0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snir68Je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snir68Je"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88A6DC2BCB0;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573920;
	bh=kiZnYX3yv/7hSE6KQoiA8UXoibzSF3gsyFHZYK/bwPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Snir68Jem2/t/ivsAWksLm1hN/tHccmHiv5tAxGNh5AUiVOnpz7oXkETc4mMHLlYG
	 1sQYGkZyg7MIogM6jJj+wu+HIdAeLTEu20iQ3Nw1UD/qi50durqBmYmW/kT/e5vAon
	 iCycZZLvoWtKw+H1ar2hpmfYfJ0kZWDw93atGV135sXJGjDhspZnxGzJoSIIFGNEu1
	 TdJ6e0w96xt7ZfIfnKDLsFTiwFdi6i1GZSbaNDG7/4XxsfWvHQxuy9I4L/vugUJkNt
	 S5wkTwcsVW11xA/G5/CJO0sHMclFimv22pQHTAcqLaHQZAuASdvaCpv2tc7IZAoOVd
	 xL73kX28XB4lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0CEDEBF9;
	Tue,  3 Mar 2026 21:38:40 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Tue, 03 Mar 2026 22:38:21 +0100
Subject: [PATCH 2/2] igc: fix typos in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-master-v1-2-f180b1ad98b5@gmail.com>
References: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
In-Reply-To: <20260303-master-v1-0-f180b1ad98b5@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772573919; l=2226;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=ezcHABa5+m3YgVJzerPyH32xEuquU6DSu3kByoKy36c=;
 b=F5z5ui9GIfYpWWEgTxwtGVvdmqDUHzQREk6s+IhqrWDwINgqwPtik1msgaOWumPqrdJleLkR7
 GSB0ZC4rXIaA3QAxs8Id7n0SrHri9RzCDySCUQoE2q3aHQsE0pHJx8o
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Fix spelling errors in code comments:
 - igc_diag.c: 'autonegotioation' -> 'autonegotiation'
 - igc_main.c: 'revisons' -> 'revisions' (two occurrences)

Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index a43d7244e..031561fdc 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -172,7 +172,7 @@ bool igc_link_test(struct igc_adapter *adapter, u64 *data)
 
 	*data = 0;
 
-	/* add delay to give enough time for autonegotioation to finish */
+	/* add delay to give enough time for autonegotiation to finish */
 	ssleep(5);
 
 	link_up = igc_has_link(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27e5c2109..de3f3d95d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1793,7 +1793,7 @@ static const enum pkt_hash_types igc_rss_type_table[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = PKT_HASH_TYPE_L4,
 	[10] = PKT_HASH_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = PKT_HASH_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = PKT_HASH_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = PKT_HASH_TYPE_NONE,
 	[14] = PKT_HASH_TYPE_NONE,
 	[15] = PKT_HASH_TYPE_NONE,
@@ -7021,7 +7021,7 @@ static enum xdp_rss_hash_type igc_xdp_rss_type[IGC_RSS_TYPE_MAX_TABLE] = {
 	[IGC_RSS_TYPE_HASH_UDP_IPV6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX,
 	[10] = XDP_RSS_TYPE_NONE, /* RSS Type above 9 "Reserved" by HW  */
 	[11] = XDP_RSS_TYPE_NONE, /* keep array sized for SW bit-mask   */
-	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisons       */
+	[12] = XDP_RSS_TYPE_NONE, /* to handle future HW revisions       */
 	[13] = XDP_RSS_TYPE_NONE,
 	[14] = XDP_RSS_TYPE_NONE,
 	[15] = XDP_RSS_TYPE_NONE,

-- 
Git-155)


