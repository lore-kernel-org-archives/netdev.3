Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06E384256
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278435; cv=none; b=ngr2xC3cEfNuExkBeVXm/ohTQJFLXAoAiK7GkBJZUSMGO500xDtZQJtKNdEzrFeDWoRUgVC943IPZFu6FEFQL3udc/f1HIhTL2eW/GkZgydc0cDSvOAdwRfFPokpnqcsATuzwzGJsGtAuIidq0IfG+v+vFpN7M/x75Ksty6giiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278435; c=relaxed/simple;
	bh=NKBGZWoIIlGbaWxX9xmW10CbbdPHmqrRNbNPhtaewOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D1EHEFurh/wWBu3F2g4iNnfuWIXDD8ljDZrqv+/28rLJUazZ6jtHonbye6Bcdecizh/kovni1cczsalh4RBjWPv6BPvuUYxM8PVz/WuxYTgpXBJha6k43KANxYStgfhUjnvWgDqAVS9TUOno1iJbJrjyGRwfDwpAKYxCnk4j+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0eZMwMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0eZMwMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B57C2BCB0;
	Fri,  8 May 2026 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278433;
	bh=NKBGZWoIIlGbaWxX9xmW10CbbdPHmqrRNbNPhtaewOk=;
	h=From:Subject:Date:To:Cc:From;
	b=E0eZMwMtwKHOgBra/6NbG+sQe5gYNLR17bQ1Ut9MEnEh0cXKlFZuQFa2ATsO2inr0
	 CHu8+1hUU0yh3nUW+wtwkSv6/aP1JsW8F1boAeWUWt+wcDdQkVinkH2Vus+ECt7Nst
	 IofWY1uc4sOe7ZFFtSVCx+pBC5JQVuX6lFUnLDKG01j4G+lIZN3fEQLUlu1TeswYaJ
	 mOa3qgBiftWzhZPAfQUkfhNFSmdqqAtcqUHCuiftmbZaokJRnix6LqkeWfB7PyCp6a
	 DkHbbbwjiT7Rq0MfWiFf89qp3WOs91B1b8QijSkPh6/1bRLSln+tlhCKK36GgrVyUh
	 5bf8KPoEFs+HQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net 0/4] net: ethernet: cortina: Fix various RX bugs
Date: Sat, 09 May 2026 00:13:35 +0200
Message-Id: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSwqDQBBEryK9TsNkxA+5SshCx4q24CRMjyEg3
 t2OWb6qerWRIgmUbsVGCR9ReUWD66WgMHVxBMtgTN752lWu5RGLRGHkCSki81O+UC673rty8G1
 oKjL3nXAWpt7JZvT4h7r2M0L+PdK+H8meFaR+AAAA
X-Change-ID: 20260508-gemini-ethernet-fixes-3ab203d28c75
To: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

During review of a minor patch for a bug in the Cortina
ethernet driver, Sashiko jumped in and pointed out a number
of nasty bugs.

This series hopefully fixes all of them.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (4):
      net: ethernet: cortina: No mapping is a dropped rx
      net: ethernet: cortina: Make RX SKB per-port
      net: ethernet: cortina: Carry over frag counter
      net: ethernet: cortina: Fix budget accounting

 drivers/net/ethernet/cortina/gemini.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)
---
base-commit: 18ae35be3f9ed26f9acff1dd96a9aed026421c5b
change-id: 20260508-gemini-ethernet-fixes-3ab203d28c75

Best regards,
--  
Linus Walleij <linusw@kernel.org>

