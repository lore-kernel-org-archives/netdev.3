Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14730F924
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222394; cv=none; b=HGH2AfwNddfhZBM37r+LyCVpLU+HAUzLkbKnr3UdfYutG84JT7qCHw+DQ1NFfGqp1vRYN/j6vsQxQfsehw1eAVI9Z9FTqi6y1+RuiauOkL/t/AGaUt3vPZ7FrFI5IgUdfTd26zGtlRevdgcp3dRitmW5a4r4pM2hZ6/EbtS5q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222394; c=relaxed/simple;
	bh=+wYxGSUrJE92HrnCdkDIGmeLqCqZUBPpYHpfcewv7tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvEx39+Lua2S4fbP2RrqZ/Lx55vMHpjte2fGp7l/UwRuc9yI6QUPZUEFKE0C0JzF+I4any2T5+A0KK0I2YNUyKGBmqj802PWd+3RrBukMMVtFKjaP4JSdQ4UZ2MeRCAzD9xbw+DKAFHCzk5G4GoyENO1u2/jijFKFY2gY7jrZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czZWZeIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czZWZeIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5741F000E9;
	Tue,  1 Sep 2026 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222393;
	bh=myrc9Gil2RJrqCTse2ZhaV1wha3SGUMFTBi/a0DM/mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=czZWZeIxlf3GT6/1dh47dSkMckpF0/fGbH+d4J4dghB10s7jtVgZl3KdK5FBfAi3C
	 7l78CVIMF+dyf9/SlsZE1QmM3loIj4F8aM3wzjaDeirj0pV1u1co1qwkhZ8gWFbx/W
	 O/nplxd2GNTF+gIpKW8eZq9i8Dk6pXKDtsbgTtxDyI+80PaJ7Xdcs+ZUD2F7kWmFeO
	 3GjvM/klpJ0sxk7ttC+4PLO9VpX979BvyZJ2HIEpweA3X49sBSVqHrJrVFatbm85nk
	 pRh8jXfo+22Xp7K5iTUQgJpzxP/VmFR73iDoeb+4h4Ku1wHyNAwqsD4kKbfDEicmsY
	 yQsk/qt1Yn/jA==
Date: Mon, 31 Aug 2026 17:26:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: hold runtime PM reference in
 setup_tc
Message-ID: <20260831172632.64aadc2c@kernel.org>
In-Reply-To: <apWVBrXNt74gtUd4@lore-desk>
References: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
	<apWVBrXNt74gtUd4@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:51:50 +0200 Lorenzo Bianconi wrote:
>   - This issue is not introduced by this patch and it needs to be fixed with a
>     dedicated patch

Looks like the driver has multiple bugs in handling of TC callbacks
while down. Please fix all of them in one series, otherwise we may
end up changing approach.

Can you also confirm that the device programmed while down retains
all the necessary configuration thru the open path, and everything
works as expected?
-- 
pw-bot: cr
