Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEABD2877DE;
	Sun, 29 Mar 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807648; cv=none; b=ckCJoe+sXBPaiYSc46P5PjgaXsNKSumkdgGpUbgA4qcGmun9F6KVlfmYmyR0fvMDzLFZ8OZ1davOoJIhVqEMQRQwBcyi9hgG5/3lQ6NlczdwiIoWnQyulhMbL5aAywFRAf3AToaocu7MyXdOB89LCtvqf/XfE8mJmzBLpOmlvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807648; c=relaxed/simple;
	bh=K2TUS5wPF64bHYLFmBfA6rSe0bvnHVuBKXQ/xFiyLQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m0YQq6vIbG313A7oVTZ3lj603XtIeF1Ht24mtyWd+Gb4ue1EcRg/amC4HYl0mfDxVa4GkGSm2Wo1yDyUzwgYYdxNUaGK3bFLCokc149BW4Yx0YUa/zOG+91+b2FjuEcb/nLOCfVsJNYrvZrHo2RXogJii1uNz3pbPvmldeM+EIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A1C8792009D; Sun, 29 Mar 2026 20:07:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9B4FB92009B;
	Sun, 29 Mar 2026 19:07:24 +0100 (BST)
Date: Sun, 29 Mar 2026 19:07:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] declance: Rate-limit DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291838370.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Prevent the system from becoming unusable due to a flood of DMA error
messages.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v1.
---
 drivers/net/ethernet/amd/declance.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-declance-ratelimit.diff
Index: linux-macro/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-macro.orig/drivers/net/ethernet/amd/declance.c
+++ linux-macro/drivers/net/ethernet/amd/declance.c
@@ -727,7 +727,7 @@ static irqreturn_t lance_dma_merr_int(in
 {
 	struct net_device *dev = dev_id;
 
-	printk(KERN_ERR "%s: DMA error\n", dev->name);
+	pr_err_ratelimited("%s: DMA error\n", dev->name);
 	return IRQ_HANDLED;
 }
 
