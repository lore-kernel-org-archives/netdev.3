Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388A5A5123;
	Fri, 11 Sep 2026 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158318; cv=none; b=cJ4EjzMMKlbqFtZk6hNMFD/kmGO5ZE1Jqn490JhE4J5mQnhmLpIoOUiXhiZo09Wwq/A2v4VdHJvpSAmIBHtzk9aoygpW907XnPm3qRTt/Rl7kfB/zNI3lzQMBT80LjK+O933Ema32stQ1TVLhKd1NYIsdk8wgAfSHwV0ycwo6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158318; c=relaxed/simple;
	bh=lHDWDVjMBGf2h4n8i+Zmo2uLUHoUM9T0K4r4fBwpDWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VIT5U6Y+vPFrWN7aIL4vLeYFvQz8ivZys3kpt1Zyf7LadTGmYlwrYmWS9F/EUzHODPGbLHMD3BBGh5Hsb7Pm2GW907BW10QXmE1G2tR4XcXStoq4zIIfA+eO54zC1Jwb/l+A/9DnoCz6DteinevwrVXxeUE7NNUCgWg5uvDJRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com; spf=pass smtp.mailfrom=rimpianto.com; dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b=We7GHXFw; arc=none smtp.client-ip=46.14.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.b="We7GHXFw"
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: =?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gatis Peisenieks <gatis@mikrotik.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gajdos=20Tam=C3=A1s?= <tamas@rimpianto.com>
Subject: [PATCH] net: atl1c: fix soft lockup on out-of-range tpd_cons read
Date: Fri, 11 Sep 2026 22:17:18 +0200
Message-ID: <20260911201718.1517366-1-tamas@rimpianto.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id A3093E56-5882-49F4-BE60-CCF4E694B27F.1
	envelope-from <tamas@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Fri, 11 Sep 2026 22:17:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From; q=dns/txt; s=s20260314391; t=1789157847;
 bh=wN3k3GbZ5TqcbVQ8ermIHqcBIOWeycwyDzExWsohfj4=;
 b=We7GHXFwlb5/CQKumMILz5+1XNH5oaSI105OJ4ZbQB5o30locUCwAyO1yCOCPdne9cDCnji6W
 S2MuGJ7QObnrnpO/efU8LOo+K3+y7kPsqU3JQe7m47GvJKBi5SjZbB9Mn0nfFo/S6Ge0BPdPuBX
 ++napMxoBmZ9DQxCjJcwzMaIqCGjFgCkdDQLF9mm4mHqSP29sY2zoq6SbLTqIU98DIWemim4lIu
 pQRJ0xcz3cidOXrFMjEnTkm3mURWS9h15urB8KJBrzkYcI3omJT9hk0of36+hnzfECVAq0RA78W
 X9iVxN/Cxu1btXTHpPQbVg13u9knRewXisVRxVNg88Ew==

The hardware can report an out-of-range tpd_cons (seen as 0xffff)
while the PCIe link/MAC is resetting. An out-of-range value can
never be reached and the loop below would spin forever. To avoid
a soft lockup treat it as "nothing new to clean" instead.

Signed-off-by: Gajdos Tamás <tamas@rimpianto.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 7efa3fc257..e58f1d2c26 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1602,6 +1602,9 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
 	AT_READ_REGW(&adapter->hw, atl1c_qregs[tpd_ring->num].tpd_cons,
 		     &hw_next_to_clean);
 
+	if (unlikely(hw_next_to_clean >= tpd_ring->count))
+		hw_next_to_clean = next_to_clean;
+
 	while (next_to_clean != hw_next_to_clean) {
 		buffer_info = &tpd_ring->buffer_info[next_to_clean];
 		if (buffer_info->skb) {
-- 
2.53.0

