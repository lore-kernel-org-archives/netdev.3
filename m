Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A6250C06
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759325; cv=none; b=KQKXj9rZINlHh8EMD2ENPqpMTfVj9UhsNl/X9VHLTJSUj817Q1kBXzCDf6z8RAN0VIIhc+PzfsVTJrW2euUC8DLv1t5p4WTe6Abptkdy64h14KF5FDLOdla8hj91GPkLIV+5q2e2ZVinNmegEH4OnD8bKIxVMwZkXhrcP07d9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759325; c=relaxed/simple;
	bh=9pwmrS5qSZ07o90BArwUGKC/cHuc+GAlONFVRJwj5S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+HUyAhLEl/xsMM/ukQHFTEWlGWDHbbNN5R3toiLTsle60+JkHndzLFlO+5ll2dXxHgBNjjouW6zcY3hC+ewHHB//chFS6ljyGxh36663e8POJR8FIMOYm6W99Mrygh+w0yfcprBTbVqmdVYX78dtnaa9DpKsD8IECfALNlNO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3EA6D605BD; Thu, 09 Apr 2026 20:28:41 +0200 (CEST)
Date: Thu, 9 Apr 2026 20:28:40 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] nft_tproxy_udp.sh flaky after Fedora 44 upgrade
Message-ID: <adfv2FGtbge9TCMz@strlen.de>
References: <20260408152432.24b8ad0d@kernel.org>
 <add7NeuWubAQzGrg@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add7NeuWubAQzGrg@strlen.de>

Florian Westphal <fw@strlen.de> wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > When you have a sec -- we upgraded the NIPA systems to Fedora 44
> > over the weekend, and nft_tproxy_udp.sh has gotten quite flaky:
> > https://netdev.bots.linux.dev/contest.html?test=nft-tproxy-udp-sh
> > 
> > One thing that we hit immediately is this, in case tproxy test
> > uses socat:
> > 
> > commit e65d8b6f3092398efd7c74e722cb7a516d9a0d6d
> > Date:   Sat Apr 4 16:01:03 2026 -0700
> > 
> >     selftests: drv-net: adjust to socat changes
> >     
> >     socat v1.8.1.0 now defaults to shut-null, it sends an extra
> >     0-length UDP packet when sender disconnects. This breaks
> >     our tests which expect the exact packet sequence.
> >     
> >     Add shut-none which was the old default where necessary.
> 
> Thanks for the pointer, I will try to get to this later today.

No luck so far:

# grep PASS /tmp/log |wc -l
900
# grep -v PASS /tmp/log
# cat /etc/fedora-release
Fedora release 44 (Forty Four)

This on
commit d444044483a98264722ff77ffef407df0589c6c7 (HEAD, nipa/net-next-2026-04-09--06-00)
with a debug build.
(non debug did not trigger anything either).
