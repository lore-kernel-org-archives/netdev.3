Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32C7E0FF;
	Tue, 19 May 2026 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149868; cv=none; b=P1sZVmOLOk5j9q08/Dct7dnzN8Q4aJFjDoaX/i3vcnGxyPLChQ7ILOxDu516w1mZS+UAkapSN45L/QLUSNROPCzL1nyR2oW5OhB4O/kiwjzWPA8rPC/2/7ZQuSmuZyVlN9wM5cklbNKiQuj6NSQRD8nR5Pi/RKr3Cu9nEpy7MCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149868; c=relaxed/simple;
	bh=dM8m+QgHdXt1PXx03ijyWSuzXKCiU1Ey1346tTYiqOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=regnyFw0R6W22F/Gwd8wsAAoymzMMppho/+65KpIsgg9eAvR3IhBwR6Dc2fxqdINIip3Suf7KzUcC+6x2P1R+PB/nYNRfQ7vowXTMoEFbeMXNaymfjYz1IOSodhOKCNuVQN5rebJN7dDc6OPHeOa5e6suJyrVT65Junv8bOighs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpw6zyen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpw6zyen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C9C2BCB7;
	Tue, 19 May 2026 00:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149867;
	bh=dM8m+QgHdXt1PXx03ijyWSuzXKCiU1Ey1346tTYiqOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hpw6zyenAU4wJg5pZxIgfkyucFnl20LWjrTMfbUVqjojcEbA+88lQS0HhVb5zYED5
	 /tHTJ0uuBow8ImDJPUOkyLqaFuTvSVJ/I96p7McwiAwzqPNMGPk62IlXcD/s+HafXQ
	 Aj2pep2MCTwa7JcJBQ8l2mYg5xvLAOk0mXQqMbKp4VIw1T73lQVlXHp5kgN4nROSb/
	 8FRwKRK6+h8VJ9BvIViU5AWXIZqG5pffQvhX9iLKhZyv7EGAhYZlguaOe3yfgszXJ9
	 F/PeRcxFbxFxLN3f4E1ZNsoVDHsATgu+5ooL7bMot0KT75xsaehwJFQdyn4DvkU6Vb
	 wFMrd47q4+0Cg==
Date: Mon, 18 May 2026 17:17:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] net: phy: micrel: Code clean-up
Message-ID: <20260518171746.353a7c76@kernel.org>
In-Reply-To: <20260518171551.1eb8b09c@kernel.org>
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
	<20260518171551.1eb8b09c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 17:15:51 -0700 Jakub Kicinski wrote:
> On Fri, 15 May 2026 16:50:23 +0200 Christophe JAILLET wrote:
> > This serie is only some clean-up related to
> > drivers/net/mdio/mdio-mscc-miim.c
> > 
> > It depends on a patch called "[PATCH net-next] net: phy: micrel: use dev_err_probe()"
> > that has been sent recently.

Oh, missed this of course. No auto-tester will get this sort of note.
Posting patches with dependencies is not "supported".
I've have expected you to know better..

> > Note that in the 2nd patch, the order of the calls in the remove
> > function is changed. I don't think that it matters, but I'm always
> > relunctent to change such things.
> > 
> > The patches are compile tested only.  
> 
> ... against the wrong base tree I suspect? :S
> 
> Applying: net: mdio: mscc-miim: Remove some redundant code
> Applying: net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
> error: patch failed: drivers/net/mdio/mdio-mscc-miim.c:318
> error: drivers/net/mdio/mdio-mscc-miim.c: patch does not apply
> Patch failed at 0002 net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
> hint: Use 'git am --show-current-patch=diff' to see the failed patch

