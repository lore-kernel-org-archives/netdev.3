Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B93BFAD1;
	Wed, 20 May 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275940; cv=none; b=PemKmby4AZGSY3AFkGyQt+P6b1eEk7IjxnqYyvYC7lmWbGddOPoj+b5kAsXIAM757kB7a6yQvbpwK2kgebI65IIFfV+qYqoprdPbGZTIrECvHMXEr5wULMNN2f4vfzinyPUpseai5/IReBKpNGmol0dznXoDey/4riAHktRdLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275940; c=relaxed/simple;
	bh=Gga684UYpjR7e5qC9JO6/UvxtvUp3k6Cm0LtoDfgVXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BWNoG+IfKZulwUiqn7t6f5rwlhin4jqm8ltosmhjPhVOLaEYGycYqSg3kmL3VpJIDwecF06VSZQy2oBrXYDBn1peFx0WxSGT53/Un1O+ohHHRycbtb1TqfZwb0hVD7IqIRC8UzzM1n3G/nSYSQwwrP66IPkAKKu76OKLDdLsHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 02B9692009C; Wed, 20 May 2026 13:18:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EFD0592009B;
	Wed, 20 May 2026 12:18:57 +0100 (BST)
Date: Wed, 20 May 2026 12:18:57 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] ethernet: 3c509: Add GPL 2.0 SPDX license
 identifier
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201206370.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This driver has landed with Linux 0.99.13k, which was covered by the GNU
General Public License version 2, and no further conditions as to
licensing terms have been specified within the copyright notice included
with the driver itself.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/3com/3c509.c |    1 +
 1 file changed, 1 insertion(+)

linux-3c509-spdx.diff
Index: linux-3c509/drivers/net/ethernet/3com/3c509.c
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/3c509.c
+++ linux-3c509/drivers/net/ethernet/3com/3c509.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* 3c509.c: A 3c509 EtherLink3 ethernet driver for linux. */
 /*
 	Written 1993-2000 by Donald Becker.
