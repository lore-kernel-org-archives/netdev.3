Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872C21CC71;
	Sun, 12 Apr 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029255; cv=none; b=md5LddQa9OoFomCJ3InxhBXsQOS/rusAm9R4EirJWq9gmLx5uEGeJWz3upbtNsA306XGjEe8NjlDfacGw1hA9FKhvwLwg6eIgTxbW5eELIWB2G7ANO6xO0bb9ZwD679Denk4BrKHB1YUW+nKwtKHqhYh0KmCQ/0khxP3VUQM7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029255; c=relaxed/simple;
	bh=mn9/e2EwN8rFJOk0/sR2yis+6JUJvyxNFjs4jOhDAnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLFc86srBDZb//Vi/mAmynK83xk5MuI7pMu3WqmXEa/PBEwkwTO4cQsQZAE4+2syKKBZgD6Wxg1kUc5RibVniHmC0t+TG6qG2eYTGrXj26/gmgv5KPWYOhkBGCIshS664NOhXd461FcESitk3NCAEgqH0LH2fTiMDWTU5GRXrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZhR70Aa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZhR70Aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E4DC2BCB0;
	Sun, 12 Apr 2026 21:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776029254;
	bh=mn9/e2EwN8rFJOk0/sR2yis+6JUJvyxNFjs4jOhDAnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZhR70AaeVqHJLPgpplUFgZCXd4oJr5/zIYtOqCOgWfrcV5sacqSQILYZwwdTCI/V
	 K9/E+FLbw5264jn+qQL8YhEN/EIrngAD/7fh6hFs/S253RMKqen6sqVDK1xzStao1Q
	 Uk1bETWHWy2wgMQQ1oGtM3FMDzvl2FZu8GpGKL1A3skapc55ACvixtZLaeeI723L7h
	 dWeiZis/WlAaXOr+UY4EI3BeFf4R0wdcl4DBThKnPw6cU5i8p3KXIZ4jpoJMFl/Ze1
	 EeSY5kQtD24FnKkvibGacs3mWriSfU1WJn+0IjcRie7JeKoOX0Q3ZxT2blswBv9kmw
	 zj4vVbHZFaSxg==
Date: Sun, 12 Apr 2026 14:27:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v9 00/10] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260412142732.5dec7ebe@kernel.org>
In-Reply-To: <e6380e63-52b1-4d49-b639-ca638bf21225@bootlin.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
	<76e290cd-22bd-4ed3-b2b3-036e1edff140@redhat.com>
	<e6380e63-52b1-4d49-b639-ca638bf21225@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Apr 2026 10:40:13 +0200 Maxime Chevallier wrote:
> Let's see if the PHY crew have things to say on the overall approach :)

Not a word from them. I suspect we need call a meeting or just apply
this after the merge window..
