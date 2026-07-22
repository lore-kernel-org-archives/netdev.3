Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8F3AA4E9
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736414; cv=none; b=fptcQfbVyQHjRNn72v43DrlQL0BgEPzGE109IHmGRUMtXp8hrGIQwzjIz7E968p8IpYAPftkGlSDx2+xZDrHMU0vD2pbJORMjA1Ub9yAiZLhEUKX4IS+yEeB80HgVdQMvLw5psXFCeYMSmaXfNKUOvgDdIBTKD3COEK8e4i0gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736414; c=relaxed/simple;
	bh=UE9vt7vskD4aIOjEdv/nBfnEWhKt8wLGmDJTYXZnNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuzLobLNtKEuwpR5RmD3PpsB4YThP6wcvU4kgGZvr7SUAglL4Pcr02HtJBxi/AgpRNwvsFPHa6p1kQ943gqbGRGxM0rWBXI5rzHjk+gfVyWiQVj7aYar96DDjqKe9bhaO1SiV5oPFVEwLqXkdPdg11S+XWHdrHAwEb6HwqUIe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RXJbeegS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RXJbeegS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UE9vt7vskD4aIOjEdv/nBfnEWhKt8wLGmDJTYXZnNFU=; b=RXJbeegSEZXwFuHXcVf4TOaTfQ
	58eTn0/2/JMallhe5JX32b7vWHUxDRnQH8EfE7cV0k453JuYosRYqhtZoyaj0TeJ1zx2Do/R4BPY9
	wv+q4OA4CDU/a8/lI62IB7NWQ2MtETWRllOUOJwtRP2pBHePs2MKx+X5s+gKKjszXETkCrT49wcDm
	ZMen2bPcA85j6EIPJXIwBEmWvLt7MPEjiG+m59xgPFFFd4s6s51rMwNCnJ9Hk55WIaZpTloZf+JDJ
	U1GtZqFHou8/LIRY8Y1bNmC0NgIPCbYL6035C5IocvC0wHxo5CDG1uLMyyhn4QNw2raEt/SdXbWUR
	fHilT3EA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wmZSy-003743-2t;
	Wed, 22 Jul 2026 16:06:41 +0000
Date: Wed, 22 Jul 2026 09:06:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, 
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Xin Long <lucien.xin@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
Message-ID: <amDqY3G3lPGEda2X@gmail.com>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
 <32f55932-e7b6-40ad-95f9-9daff98356c4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f55932-e7b6-40ad-95f9-9daff98356c4@redhat.com>
X-Debian-User: leitao

On Wed, Jul 22, 2026 at 02:01:13PM +0200, Paolo Abeni wrote:
>
> @Breno:
> a second pair of eyes on the resolution would be appreciated.

Ack. I will review it and let you know if there is any concern.

thanks for the heads-up,
--breno
