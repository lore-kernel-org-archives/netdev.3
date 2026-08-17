Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E13F483C;
	Mon, 17 Aug 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981071; cv=none; b=l82AwZh9+98wnh0Jw6e3/AawGDf0m1UL7g3hOg9dSJ5czncs4e1UqS/0cR2wmYSF7XlDYvmT09hJTxW7gwG57liONy/KoRKtHgc3usBjQ9ETysxEyhUIn4Wjcn16kCCiGxv5ajcvp2uG5fpDesd5omwS0tMTonwgIhFLGnhGAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981071; c=relaxed/simple;
	bh=muM6PKgU7oCoGGq1jcacEhJfoWbim6H6quZtBPzveGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q74fjVHOi9XBrurvoE9f5Y7pbNXtvlQle62ZY4GUnmiZNmIn9HzSSmFtUZGMYiHvGYYJ03dgFoOzYo+UQd+DRlKSmsotuFIsN97leDToQLygUGoX98ZR18lUCYxeu4/faEteAtj4Au2Cku9hCrm+cbwj3oJ5Vl5YqmRlVznfmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga1WH3P8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga1WH3P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350351F000E9;
	Mon, 17 Aug 2026 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981069;
	bh=FBUTW2FkWwtd7HDYBqhsq1wJ/D8BGWzfQGa78XpM//U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ga1WH3P8y4SJnw+QK08Z64nJKK1BJ/ys5SQer0PZ6QaxpaWvt9gFWJ37Loi/nhm3H
	 2aCvn8vhkE3KJUbVpYIy3GVkKeChvAVO+Ip6//V00Dgn8S2hdUjKTC2z2I8e5qCVr1
	 rlHviFoXqLq7azrsbyk299rDNBgKB7hGgRX8ozBkfp4EnWvp12oXaFsad+2O46bWvX
	 HPt82s1tsXUL5VFxib0jySjH0d2U57D0jZqu5gft6uyrhcZfhdnjvLOLn3zOHXGNoJ
	 eLtqJlf3Kou55JMt6a+3hzUMgnEl6iTDLh7Z/5/LnHAwA4DmVkqNHfrDEA9RZRmPMg
	 N00VvwjEEP6pw==
Date: Mon, 17 Aug 2026 08:37:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v11] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <20260817083748.05f798ba@kernel.org>
In-Reply-To: <20260817110626.510277-1-kyle.switch@motor-comm.com>
References: <20260817110626.510277-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:06:26 +0800 Kyle Switch wrote:
> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.
> It also adds a new exported phylib helper,genphy_c45_template_testmode(),
> plus two new definitions in the MDIO uAPI header.

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
