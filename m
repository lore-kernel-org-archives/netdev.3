Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9B2C0F7F;
	Thu, 25 Jun 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354934; cv=none; b=A/dEYMefD155r3fJ2OhMgD/lpk+zeAOImOd51B9IbjNZxSUS5NM6uqz/HcYorvgt1+So1gK+YES8aRnH+4A8Y+88Usks6nYiNPCTcFwGp7Y8ATl+awl6XUEhLl4DYeFiJX2Xu4TcQcy7nSGr9xDCYTpqSbUIG4iTgCTgxx7mtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354934; c=relaxed/simple;
	bh=Tx/nABsS6Bk0T4AsscFUEDdFzZ9oI4CKHnYX+q/rf9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taHl+HCBQn+ySmYYtuAcvpNI2HPTd/6bL3y+22+hYHQcpOMdXChq+kCkwM8xy6hxQV6nlOmv/yfUZpyQsFXFeraufo3cbpyrU43jKlB+L2XsIrjG82ex7LCTzB9ERneZwjbTp5Q3kKh+El1L86o0QvQIZ/CfkFKyklW8wRB8/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg4rQ8/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg4rQ8/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444041F000E9;
	Thu, 25 Jun 2026 02:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354933;
	bh=5W/I/MnZpjgwv9HbFL2VX4INISjg2IA5aSi2PVZHso4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Eg4rQ8/9/BedKzweZfHM1LL4Ifxid/js3v+bbQ2ZVL7/AvIgq/8prRPjIEz2jm52C
	 pwrFMGn8x5W/KxnX5aUi95giPFtkzRnJ7/TwXmocp9Jc1EgvoM1e0UtKFvn1J3+dpD
	 aPt3LzpQuUKatMobwSlhIDXYyd9NHN9u+gpLrd86dp9v4pC3mJacdQde4l91KTiCbp
	 GSVSrta+XaY642rYKWDsjK1hQ8Lx6zdsFOzMhcIb4X4uSSYvBGS6ZCNrgtfeCzXg6z
	 ClDcbILSNwLUkSjFxIzvbUMO1S+aMQzJEwJtk4CkI2dSzn3NDspD0JdsrVXCHabicb
	 MP5qWujiPRkcQ==
Date: Wed, 24 Jun 2026 19:35:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Wells Lu <wellslutw@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Shitalkumar Gandhi
 <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net v3 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
Message-ID: <20260624193532.64caeb52@kernel.org>
In-Reply-To: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1782195965.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 12:11:41 +0530 Shitalkumar Gandhi wrote:
> Shitalkumar Gandhi (2):
>   net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
>   net: ethernet: sunplus: spl2sw: fix multiple of_node refcount leaks in
>     probe

Only the first patch reached the list
