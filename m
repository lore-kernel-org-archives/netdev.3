Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39ECF9D9;
	Sun, 29 Mar 2026 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787578; cv=none; b=UfGlPhM6aKEx11lYO+DHidu8331bYxiNy4Rr7OM+99NjNdhBK1nPdL++QDCcQIqAqZDIiQiLoYHVhLfxICixR6L08npmd6KlblqnfaNAczKnNE8iYQFUKXph8SDNIUv3cCu/A5rKPUYEs6yXFFDAnlW6qSZxRMekd7PlpxmWgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787578; c=relaxed/simple;
	bh=mdftbmWyKv+KEZRvzk6ehhJTa0juTCj8+XtqTkrNhTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rY5yTP4ej+hR8rc7q8Iao8U+iuq4rtSm04OGWOYpMEecwbgJfVsENcMKPvI+SG9Lw1MRB30rVupLSuZoIst4NH34+LuchlgoAqZ0kCGtmHjUPE/2WD1tVyeXXRoXs76w2b+V7GLmzgzMNLT6YTRoksmdb+x7KFWLJtn3V9xf2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BAACF9200BB; Sun, 29 Mar 2026 14:32:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B45A09200B3;
	Sun, 29 Mar 2026 13:32:56 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] declance: Include the offending address with
 DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291314560.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The address latched in the I/O ASIC LANCE DMA Pointer Register uses the 
TURBOchannel bus address encoding and therefore bits 33:29 of location 
referred occupy bits 4:0, bits 28:2 are left-shifted by 3, and bits 1:0 
are hardwired to zero.  In reality no TURBOchannel system exceeds 1GiB 
of RAM though, so the address reported will always fit in 16 hex digits.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/amd/declance.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

linux-declance-dma-merr-addr.diff
Index: linux-macro/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-macro.orig/drivers/net/ethernet/amd/declance.c
+++ linux-macro/drivers/net/ethernet/amd/declance.c
@@ -726,8 +726,10 @@ static void lance_tx(struct net_device *
 static irqreturn_t lance_dma_merr_int(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
+	u64 ldp = ioasic_read(IO_REG_LANCE_DMA_P);
 
-	pr_err_ratelimited("%s: DMA error\n", dev->name);
+	pr_err_ratelimited("%s: DMA error at %#010llx\n", dev->name,
+			   (ldp & 0x1f) << 29 | (ldp & 0xffffffe0) >> 3);
 	return IRQ_HANDLED;
 }
 
