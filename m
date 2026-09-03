Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E53328E6;
	Thu,  3 Sep 2026 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477754; cv=none; b=iJbBFRClXZ5SwvLf6I4OcdyxARplMulbhXkM5hOVsjHv+FDStmvhZyF6l2SDE+arjsaStF9jskQf1C77IVKGyyj4kNDZalhd+7ij/pyFLRDV8YmDG0xmt2gzCnNY3692cw3CtAtQLlnflQJ68k/LWtPcDKa5qnDEs11fWC5WIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477754; c=relaxed/simple;
	bh=U5x9qaygFInR0b+wz8KfAjhmfGyc0PwTUIUcxduux9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alCifv2Vx2+UuUHdgmJMUc96tNlCAb3+rfOkk61oXVbz/Q2uXRQvyNB1icEPepwCaMcAWWtcpbwxf3BduDXV4HWlNRfRQUR9MSJYIpLu2nlWUq8yNe3vwxJYASj/1hmJ7LdOP6tnU9nJMVPsi/sscU3C4N22uONs1sPgl91j2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQoo80y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQoo80y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E0C1F000E9;
	Thu,  3 Sep 2026 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477753;
	bh=FvNG3LS8nPKzshGEM3d/JxEgqTvJYa+h83LktEUOD94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aQoo80y82vc9TxxsFDQBriTEWIeLzd/Ryt+8HOXF4c5N0mBRuno3eHgTx7IoemawA
	 noVHuzBJi6Bx2nfUWaG14UcVKFQaq9y/eqe/rjd34FoFw2MMOrJvo8BSsm1j7q0hLs
	 9CA2dLz+dLTpLDPDf+eYvE0Xl1ZQYdCUmXuYU6iYLHeEoEm1U5QsTM5PhOski2p69k
	 DWBBHb4s9NYB2QPKJAI4z2HxxhpNBnyMIZFuuzSC+Jhpr8hmh0adNtFaUz0s/XdbE8
	 awv5N3RGCVdrrWW8iiQXLkKPXmmDxAviGBZERYD1BQ8mkwiesyst23I3rX8Qtl6gNQ
	 03sRNauHVabfQ==
Date: Thu, 3 Sep 2026 16:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, Wei Fang <wei.fang@nxp.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Message-ID: <20260903162232.791e4c43@kernel.org>
In-Reply-To: <GV2PR04MB11739E1618294F313E989A7ED88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
	<20260902195613.1e18b44c@kernel.org>
	<GV2PR04MB11739E1618294F313E989A7ED88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 03:24:24 +0000 Wei Fang (OSS) wrote:
> > On Mon, 31 Aug 2026 10:54:26 +0800 wei.fang@oss.nxp.com wrote:  
> > > This series enhances SR-IOV support for ENETC v1 and adds VF support
> > > for ENETC v4. For ENETC v1, the trusted VF management and per-VF
> > > configuration query via ndo_get_vf_config() are added. For ENETC v4,
> > > preliminary VF support is introduced for i.MX94 and i.MX95 platforms.  
> > 
> > You only replied to some of the AI feedback, should we assume that
> > feedback on patches 12/13/14 is legit and expect v4?  
> 
> I have not seen any other feedback on patches 12/13/14. Except for a
> pre-existing issue on patch 14, but I do not think the issue needs to be
> addressed.
> 
> Sashiko review link: https://sashiko.dev/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com

Please TAL at:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-7-wei.fang@oss.nxp.com
