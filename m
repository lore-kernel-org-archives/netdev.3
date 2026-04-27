Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075E309EE6;
	Mon, 27 Apr 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285418; cv=none; b=b51pOPHY8I9d0m9hq0kxVqAnTw/ClArVRpF2ZbNypyTz/J90sgDlbo4C3XUvocR+BH4kF6EPc+43ju79JBf5cAGiNE3ZsvwILxk0H2lJvjGA8X8tAhPDGPfhCsCU6DlHHU6Tvlxnv8HdJP0Dxn8P40VZR2uro3Zha8Zdq264kW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285418; c=relaxed/simple;
	bh=78RX5zGVLpXWw+msE8uORJWlQul6SCYIsGZZz1TCQQQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZO4GDc6ZYuELLkD0XU+/AFuzzpFfGo0zuTTwqLkewf+jUwlfCox32sJP0sCBJKwvcAb/Ok3OL3v6CECSmH259PlES7OWP5ODYNPf8kJLBwAyz17am2R+/1BRG9fhraKwio9rsOVuE4J+t/1CiWzQT6G0ALGr4GElicS52y914hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A731992009D; Mon, 27 Apr 2026 12:23:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A149092009C;
	Mon, 27 Apr 2026 11:23:35 +0100 (BST)
Date: Mon, 27 Apr 2026 11:23:35 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Add self for the DEC LANCE network driver
Message-ID: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Like with the rest of DECstation and TURBOchannel hardware I have been 
handling the DEC LANCE network driver for some 25 years now anyway.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

linux-maintainers-declance.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -6986,6 +6986,12 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	include/linux/debugobjects.h
 F:	lib/debugobjects.c
 
+DEC LANCE NETWORK DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/amd/declance.c
+
 DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
