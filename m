Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4E4DF4AD
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397206; cv=none; b=F7jP2DcrovB7udi0F8zKflaYg24+PNwATVUo4bGj0jLrqaLcqqG5Jypa4VcNTy+xxy3Ftv4lIcCB4fclNzoATNWYO2PIH3Po06qC2R/SpXXUHyDXQsiPe6Qy5B882aCpd1O8FAMXypOueIn3rKjZ5WRxC3dXsBzWf9P+Of5WNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397206; c=relaxed/simple;
	bh=8X3ZABWSAH5pZwcoScI5M0q6jxXy3lLjwU9QlpIfVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeyxzlCyzEFfpTIT8RSbFoLEYm9musoN9MPGCevRTNK9aiDdOvAGyQnyHfeB5JOudoO8dQCVOczkt8AcVvP+OLHg2RQmtHlETQCE9b6GH1HgrPDDZ1GHs/1huaUuSOZxkYFxK0Nau4udC91BbKtm2Vr1azLxY/9i/5KaGiPDll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0wOcu9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0wOcu9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3B91F000FF;
	Wed,  7 Oct 2026 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791397204;
	bh=baxxZQqYfcdgt3J3+Y7Zaau9ipT+2nNfUp40+DEEqo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F0wOcu9DjjrEi/Wy34Jjupxy8RSmREDZaa6UPA31hGNJefdNAUfH6ks/3T7xe+6Dc
	 eyXEzLBfjXbE09/TKFXsBFKWWOrovSEiJgtOLVicWHN971uzq1s9V73wDn5Xr832xE
	 FehM64nRprER7jV83eiTiX5OrlQvvEFVVEx8wqq/3LV+JuCbkFnTOMZjbS2jVx12Py
	 7jPDJO/Z2XndJsYydITK254vF/wahuuFP75GAzTRYecNbJGNm6kzMmQibEb0RAty+b
	 59QQwo5szbYBJo8oaQhd+RF3qJVR1LSL0GYLCb0qr6UbHK94U6ts9H5gssvGHlNoUd
	 ewMacVf2bX1Hw==
Date: Wed, 7 Oct 2026 11:20:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific
 wrappers for neigh_lookup() and friends.
Message-ID: <20261007112003.7bac3394@kernel.org>
In-Reply-To: <20261007165000.GA1177153@shredder>
References: <20261003212336.1304988-1-kuniyu@google.com>
	<20261007093555.66e9194f@kernel.org>
	<20261007165000.GA1177153@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 19:50:00 +0300 Ido Schimmel wrote:
> > Ido, David, thoughts?
> > The unusual (for Ido) silence makes me suspicious :)  
> 
> Too many other patches to review...

FWIW you may be able to find some use of SUIE with the MAINTAINER
filter (funnel icon)
https://netdev-ctrl.bots.linux.dev/suie.html?delegate=netdev
