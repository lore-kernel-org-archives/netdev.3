Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B273B95F9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667197; cv=none; b=LG98FcE6N4G4jTdOaPhsmrYxhAb1kQ3Rf3jnAGAKRht3l/Do4wVrW7to19mmjS66Ts+ec0U2+PjOaSOzFzfgbzOfQhog4A0O1OA6/ThKqkejS+C56fpOE2L+bAk2Qi8FT0c+FZujNbs0v3L5w0G0R7OBhyze9JPNLpq4sUTfYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667197; c=relaxed/simple;
	bh=cqb6fn3qPYG6U7wZpGSLfqaUVnbPG24A+s6FO5pbYlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhPjnlqNujPEiw2hXHG5bIM9IMgKwRbzh00k5cygROaehrwlXX3B8dDDBq7qjBTl/QwQC/p6phvRR7KyF5YKbxFImTBbO+ZLzR/Hm7GFk85UKP0CtgnFlJTkMCMK0XgAcXjKn8I9Xqwf2yU52UNoTyCdmfBxNSDipenGtUawh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQav6trh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQav6trh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0CD1F00A3D;
	Tue, 21 Jul 2026 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667196;
	bh=M+vbEhNomgWsvX0xx1+0wzbB/AAojB8yVvZ1w8lBpQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JQav6trhgHNVki2mO5Vf2X9yZjD80kRPiR66itCbIBBpWqrHB+kg79HuqG/IqZxSh
	 4Tr99CDV3Ji9oQLmMpamhHN5FdZNu15cR/YTsnvtBQUDfbKY+mgS6dx6fs2yj2qd38
	 B+PKD47pabBU6+4f/cAoFQNzj/Qx8afSbi3N9vFwOwW1NCk2NMBaIFZqtj/GD2W7bk
	 cz7nmx/y+fkHCEcZ+9aOZJ/4TZhyRpwGJih6lqg+qZe77Xr65PzfqZsqfJ1PnxQsss
	 54bBW1J85Pf99L6HHja7Hpv4nm54LU+FSaVjuZ2tFmg8rVcmoDvWvVCwvib9AuKN3i
	 wInH+yJyNN3ig==
Date: Tue, 21 Jul 2026 13:53:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <andrew+netdev@lunn.ch>
Subject: Re: [ANN] E830 NIC join intel's netdev-ci
Message-ID: <20260721135315.11db9f24@kernel.org>
In-Reply-To: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
References: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 13:20:40 +0200 Pielech, Adrian wrote:
> I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet E830 
> product line joins the suite that tests ice driver against net-next-hw 
> branch.

Great to see! Any plans to split the MAINTAINERS entry for Intel
drivers to claim the "Supported" status?

I think the coverage for i40e and ice is good enough, but the entry
covers a ton of other drivers.
