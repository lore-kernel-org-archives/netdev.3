Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC9F9D9;
	Sun, 29 Mar 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787573; cv=none; b=Osf7si/fCuR1sP7/L9bX7vvFnEHUc2Xts0cj+0EbyogErIpmPQnrM/GSODfMmRzYsTh0i2RtMrRycM7YU6hZGQ1k1whSaF6sMMF8M/cnzK58VB+7nTqzFCdfHpllGJLrdbqHA1AYb1qU7DLPsKo+B8dNOrQhyRY+VdWGndx86DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787573; c=relaxed/simple;
	bh=sukW0mVRC0HkGydmkMxneEH0cG5b+882rL4crifTwl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aVlnnN5mZAveyjRceDpafzDEL6Ru7VSlTmxOKSCSoEIijgk6bqmXD48J9BGSDPCajJqWK8dRYAxUJvUy0p48b7aRt5fmMc55MSATP0JrkrhqAEwyukaRiGuMurWtOeHXXZ+ecwLvoQZ0e+JCOzeCPDamoM7vn7XcBu0pUMxP++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8EB519200B4; Sun, 29 Mar 2026 14:32:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 87BEF9200B3;
	Sun, 29 Mar 2026 13:32:51 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] declance: Rate-limit DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
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
 
