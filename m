Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1830DEA2;
	Mon, 27 Apr 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285408; cv=none; b=r+0+8Kb19Ta1ucc0IgqKgwUXxLfWF8IP0xgkMYN5/JwTscIfQQKuYqlgIZ5Diw8MmuaJB4OLI2g5VYfiPTCghfUChPg1ywqSl6SFn0YDp9YxOtGgBhOx6YERuUpFRolP+cx0SAfAirFCoq5UMfP6FPSJoz+N+MPiKKOw0ia2sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285408; c=relaxed/simple;
	bh=6v46Sw6068fw1Ozo+2xmT+X5Pw/sFtV33b4UtV7SE5E=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=od3w+5vqJEl94uwspoj0W19OlD2iqjHhRRKuufwDDJaFFs38VzELkAtFZzy7pHa/Zudldra4kRdIELPzOT4ClJi0GhAuxsrceS7CWWxLi2gVn6R0bnRbrzkxM0D3B6oQlD/DIMBS34G1BFCYOg8PChBrkJReqWMlW8J82MTWX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C934092009D; Mon, 27 Apr 2026 12:23:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C74A592009C;
	Mon, 27 Apr 2026 11:23:17 +0100 (BST)
Date: Mon, 27 Apr 2026 11:23:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

It appears there's a need for a maintainer for the 3Com EtherLink III 
family of Ethernet network adapters.  There is documentation available 
and the driver is very mature so the task ought to be of little hassle, 
so I think I should be able to squeeze in any issues to be addressed.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

linux-maintainers-3c509.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -67,6 +67,12 @@ Maintainers List
           first. When adding to this list, please keep the entries in
           alphabetical order.
 
+3C509 NETWORK DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/3com/3c509.c
+
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@kernel.org>
 L:	netdev@vger.kernel.org
