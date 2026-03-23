Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914B30C60D;
	Mon, 23 Mar 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301840; cv=none; b=ZeC60BR7daHBrJrxOMeIX/SGk28TjW848XDJMacDnb98wrvVl6EbOox/zgAplI/GydCynk+l8xJG4Atc3nXy4ZfJCA6ZGVpl8sDr9Cq2DA2c002H1qiQ8uKd2xgxNEcufwlsjLTJGUU3tIDFlNtKTkH3x3rWgYPgZ/0w6DeHP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301840; c=relaxed/simple;
	bh=R3STABNJSGZwjloMcL06xiDWvjGg8hdaV8ssjZ92LGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLdoGwED5ynEGnUso+vTavTylCtNf+8lPoPmRMXppUqr3Gg1HmahQ4isVYPGnp0NZrPCWqKBZhliIbT5uu0vIy1DLvQq/k/sGvRsTOoBehBEFoK3H6fruBlcrO4/uUwqSzX17zHrHud2dg+66G1TxZ6ayL2lwLP9hpwofyCwu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5b2oonq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5b2oonq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6B4C4CEF7;
	Mon, 23 Mar 2026 21:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774301840;
	bh=R3STABNJSGZwjloMcL06xiDWvjGg8hdaV8ssjZ92LGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H5b2oonqc23ORaa8vMdis3FeoHd1eDPStrY8+jmwiqim5IwbRMllw60/cc6xB3jp1
	 gwUYpRMZsoiB3sO0PabNWKGwKEV9kSiyO95r6781X1SxIDgxN/oODY0mwK/N0wtD+h
	 QZPXKEcKptDM4dB6SS8jCi3HCniR53fV/fGNZCAHoixRur9n6Sr04F1NWq5d+a1KUG
	 uTguasdQem6xLY5uI5LYOyqVG5rulNHOPQ05sLiozBdK2qyyGOroV54StrJfB24VHB
	 H0dQaX0IKYU0pIZU9PbDa8kJ7yCklSXVPHrFc2VkOSaX8GOj3RODI1iPUz8tp8SPSJ
	 8Zk7SXIYqQFlQ==
Date: Mon, 23 Mar 2026 14:37:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Frank Li <frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
 "saikrishnag@marvell.com" <saikrishnag@marvell.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring
 when it has unsent frames
Message-ID: <20260323143711.2775bfa7@kernel.org>
In-Reply-To: <PAXPR04MB8510310D3FEC15E163A2FCF7884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
	<PAXPR04MB8510310D3FEC15E163A2FCF7884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 10:40:03 +0000 Wei Fang wrote:
> Can this series be applied? Or is further improvement needed?

It's too old now, please repost and reflect the discussion in 
the commit messages.
