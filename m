Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E442DF14C;
	Sun, 29 Mar 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787557; cv=none; b=OTSceYUSIT/567JCp63lsYKiUUd46s2sx2zQCeXNqVIBU6j8tzBDT6B+9qjcnNHfXPc64HsKOmc1r6201aCujgpO+Gi4Ffp3zGufl6JQZGkNlgnGMId/SZLKV9WMKRrfoSKo9F5mR2VaZwzIhdS5rco7Pt/j5v02wXhv91FBtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787557; c=relaxed/simple;
	bh=K0FouHtySwvao99HLbnzkDRpEYsWKTFoks6dOm8RRqQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=alzvY9YrKgKrLE0M/tc/kxprwmNRxG7vSYl9ZRY3BXxXkjIyS3K9xD9u8S6N9xc6j37dDB73q38VsK+ZJxcvB/9b48uW4zSgcILCUXFMM4mnV9+7kZRPpAPp7wsbGxAeve8eq6xfe4Icyoxeh8xM3YWF7ahUFcOagA9CQN+C7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 325B792009D; Sun, 29 Mar 2026 14:32:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2BD5392009B;
	Sun, 29 Mar 2026 13:32:34 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] FDDI: defza: Rate-limit memory allocation errors
Message-ID: <alpine.DEB.2.21.2603291252380.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Prevent the system from becoming unstable or unusable due to a flood of 
memory allocation error messages under memory pressure.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/fddi/defza.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

linux-defza-ratelimit.diff
Index: linux-macro/drivers/net/fddi/defza.c
===================================================================
--- linux-macro.orig/drivers/net/fddi/defza.c
+++ linux-macro/drivers/net/fddi/defza.c
@@ -767,8 +767,9 @@ static void fza_rx(struct net_device *de
 			fp->rx_dma[i] = dma;
 		} else {
 			fp->stats.rx_dropped++;
-			pr_notice("%s: memory squeeze, dropping packet\n",
-				  fp->name);
+			pr_notice_ratelimited(
+				"%s: memory squeeze, dropping packet\n",
+				fp->name);
 		}
 
 err_rx:
