Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA32C032C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471941; cv=none; b=N3HGVO6npjosYJaNX1igBEcBV8etiZqKPvUADnIQkBtMR/LjOZeZYqJ1y/IjP04cJp7L58aXU+FHnsh/+AnMFeg5Mow+rCV5e1TO3HFsrX9GSWy8iKr/m3dsdDqDAYC2RR9iYC9RmHHNli965aFuGt13I448C0jIS9E92vWdC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471941; c=relaxed/simple;
	bh=sNS3DtEP0A3C1Rk8RcuWF+nFz0WvfbxfqdfDK2pyQh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKCuYOsN4MnVfHN3i4GpfLdYOaK/ln/HftYR0qBjm9StsK2FGW1KKDIDiouO/AyPIPI520sNa42KPtch4E6oqq4PRQb4l06kVMmkAYHr2IL4G0IryT5eTxiWYcTcb1NtJgWtlEEbEK/Z2/m3eRTZK/a+TqtG86AsUVuZofeAjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAIgRXrx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAIgRXrx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89CA1F000E9;
	Thu,  3 Sep 2026 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471940;
	bh=D2KTR/927VPSyUHBItNhdHDxKuR54osLtU8w8VC4iX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PAIgRXrxMlYA0m9XTGuwokgSMorB/S8qPMu/BTq4L6vjwGICsSI6bbhcufsNAFUm7
	 NgfzPdkvtRkHEr6qvvx24WtmpEQq4vJECOskMwcY7OY8m7mXp5Nsu4E1L7YAds/rQF
	 AbWmWCBhrYSq6BPDGhi7/scR/C1A7hCBTNfTZGTweARDAbNyAoRkUfRKBGP/2VFFSq
	 n/9X+Mbe/QaEv6OmAq5MME3bxgbYPlHrUAM0Srj0Uu9N+GSIHwpkXrM7KRNtPyepVB
	 IoFk7L9neiiaHnfZqBmQNCwm0wu6nGWtUiZJ1IqafhXLfcKxc4PLiaGsfnXIQT6yJx
	 y/O8pqEjT8mPg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:45:30 +0200
Subject: [PATCH v2 2/5] net: ethernet: cortina: Finish RX updates before
 NAPI completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-gemini-ethernet-fixes-v2-2-2bbbd598ca6e@kernel.org>
References: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
In-Reply-To: <20260903-gemini-ethernet-fixes-v2-0-2bbbd598ca6e@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joe Damato <joe@dama.to>
X-Mailer: b4 0.16.0

napi_complete_done() releases ownership of the NAPI instance, but the
Gemini poll keeps the RX statistics writer section open and updates the
free queue after calling it. A new poll can therefore start while the old
writer is still active.

Finish the statistics and free queue updates before releasing ownership.
Only re-enable RX interrupts when napi_complete_done() reports successful
completion.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Suggested-by: Joe Damato <joe@dama.to>
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 1d9824d1716c..6502220362cb 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1581,12 +1581,10 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
 	received = gmac_rx(napi->dev, budget);
-	if (received < budget) {
-		napi_gro_flush(napi, false);
-		napi_complete_done(napi, received);
-		gmac_enable_rx_irq(napi->dev, 1);
+	if (received < budget)
 		++port->rx_napi_exits;
-	}
+
+	u64_stats_update_end(&port->rx_stats_syncp);
 
 	port->freeq_refill += received;
 	if (port->freeq_refill > freeq_threshold) {
@@ -1594,7 +1592,9 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 		geth_fill_freeq(geth, true);
 	}
 
-	u64_stats_update_end(&port->rx_stats_syncp);
+	if (received < budget && napi_complete_done(napi, received))
+		gmac_enable_rx_irq(napi->dev, 1);
+
 	return received;
 }
 

-- 
2.55.0

