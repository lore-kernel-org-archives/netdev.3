Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98832FA32;
	Tue, 10 Feb 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757634; cv=none; b=n156w5DeFIak52XPYagsSD5QkfxGrDlwjk/g4HD52ksVnWQs7HeiVbowzaeJop5yKNULy7Fr6ILm0njlLqzsXv18LBm+PIWa4Qlr1yx8wyqp6AL2z1V5ktcCMftDcGXi1MiIU3zNH1mlB5rZMiHEsBYbhghh9gb3a3bBhhZhB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757634; c=relaxed/simple;
	bh=q+tZKyxVxN5Y94OQHols2LeoaJkSkQ02k6a3DHGPV0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdplIxFQ8hXoVLE95meK8fwtRWvSMowIgDJV6oaMk1G77eWD0zP+1HZaK7qoXWB6rXejm+/Hccr74iHXE4oYN46l09g/9h5AiptL5MWmcwhoX9Bn8g8WoyrXIgrymKb/gZTWruIyAqdG8NmDC4SjYLC202BY5YsxYxFWaRc3ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2801A54CB31;
	Tue, 10 Feb 2026 22:06:59 +0100 (CET)
Date: Tue, 10 Feb 2026 22:06:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <aYud8nWZ7c0RxRIx@sellars>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-3-linus.luessing@c0d3.blue>
 <20260208160046.GB154003@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260208160046.GB154003@shredder>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Feb 08, 2026 at 06:00:46PM +0200, Ido Schimmel wrote:
[...]
> > +test_inactive_other_querier_norespdelay()
> > +{
> > +	RET=0
> > +
> > +	test_active_setup_bridge "1" "2" "3" "4" "5" "6"
> > +	test_active_setup_config "1" "2" "3" ""
> > +	#test_active_setup_wait
> 
> Why the comment? There are more instances below

The intention was just to highlight what was skipped in comparison
to the according test_{vlan,}_active_*_querier() variants.

Do you think I should remove these lines? Or add a brief
clarification, something like "# skipped: test_active_setup_wait"?
