Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450378;
	b=I2naez42wIBbf93INhNTRoe/dLeJhN2on7Tyx+k1N//47N6IuIkblBTau81g9PO/MIuO
	 RFVMjVBF/mCuKu/avhzkHaDwBMcrq2WTdYYYnVvOJWrjXDDjwea/iPsCIYeJHJzwVaYIP
	 fcL5z7aK9NeJfJ4SqwH+rPqwgA5ABKMbmkTOBdh4F62pKM5UiAeAUHMCFsKSL4tI/2cz+
	 P+NpozkEMJImqBGT8H/dEPxQ7lto8O8cSP//Q3z2y+NtGmWz6tqjOUUh/9J53d56ti8DK
	 lffbiax4LYiugnzxj0gQ2+waRB/o0mSvljlQuXk39kVuV+/LcYMt79AXVbhlvlAgUjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450378;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ivaEEWTzoqwO0D7EurcMjNHq2ikATNWECtT5fWFlFMg=;
	b=3aLDirkg/e9tsgHtRkdJVlAvyehv38awwz1F0n8Uke4xxYNB1/g2q47eFeNr2bAVF+aH
	 C0kOd4N0/4bFpw0eBnbpC1gHnBpo+9VzePSK734v1OGdHmQrzoEY4PuQMiO+gPkHTTouU
	 Eed00GOigVGc0v+mJVW8geP4IQvNYBny9SGm5F6kc0ApsLT0qmu00rAzE/WrrWglDycTW
	 yVno6A9dzv6dC6qhYtMH1byfHureQlnmIlw2RfjMvi6VGjAq9TS6XEBXZ3NiHfaaiR6MW
	 ULbUvbR9eBhfd8Gm7hcpx1fYoCRjEDG2KacgvZbWjjb1VNTolh3SU/Ns0KX42LF3/ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFjhtMJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0757606A326
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFjhtMJQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B04E1F00A05;
	Thu, 12 Nov 2026 02:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450377;
	bh=ivaEEWTzoqwO0D7EurcMjNHq2ikATNWECtT5fWFlFMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QFjhtMJQbqRmDp8vXN4ABMEcLjpfUlNVGnpPfRckPKl1UNEm99kiLT0z2cAt9NU27
	 y+sknb0HOyPWMbU/CLDsiXzmFqfF9GcrrQAghzqSaCz3yb51AeNw/ireq+me6428P6
	 P5Y1nDIs7ci1bi8dtEduzHMHMIfHoEcP83Zg+htfIPxsGDSDLu2faND8YEJ532iBOP
	 ZDR8HwsrU4M8paxWSg359zDRLK4wW0kdsPQkh5HMhh/d3SVUb9+jvDf9IyVx95B58+
	 1BYFExumW3cfVipBBt1MB0Lzbx1kqYaeRsaY+GsgS4xEhI/a1z/CJrLqObWwQTlati
	 /S4p64H1Kfw0A==
Date: Wed, 11 Nov 2026 18:26:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Kiyanovski, Arthur" <akiyano@amazon.com>
Cc: Avi Weiss <thnkslprpt@gmail.com>, "Arinzon, David"
 <darinzon@amazon.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Brandes, Shai" <shaibran@amazon.com>
Subject: Re: [PATCH net] net: ena: avoid double-counting TX DMA mappings on
 failure
Message-ID: <20261111182616.631c9e0e@kernel.org>
In-Reply-To: <BYAPR18MB26005ED8BFAB5DEBB6D02B63D9702@BYAPR18MB2600.namprd18.prod.outlook.com>
References: <20261109123934.824610-2-thnkslprpt@gmail.com>
	<179444039825.7144.5680478965949082764.b4-review@b4>
	<20261111171127.7ce982b5@kernel.org>
	<BYAPR18MB26005ED8BFAB5DEBB6D02B63D9702@BYAPR18MB2600.namprd18.prod.outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 01:30:29 +0000 Kiyanovski, Arthur wrote:
> > On Wed, 11 Nov 2026 23:39:58 +0000 Arthur Kiyanovski wrote:  
> > > Therefore please do the following:
> > >
> > > 1. Add a From: tag to give credit to Evgeny Ostrovsky, who wrote this fix
> > >    (without leading "-"):
> > >
> > > - From: Evgeny Ostrovsky <evostrov@amazon.com>  
> > 
> > Unclear whether that's warranted TBH.
> > Avi is making the effort to upstream the fix, they deserve the credit.
> >   
> > > This should be first line before "ena_tx_map_skb() increme..."
> > >
> > > 2. Evgeny has agreed, please also add (without leading "-"):
> > >
> > > - Signed-off-by: Evgeny Ostrovsky <evostrov@amazon.com>  
> > 
> > SoB indeed seems appropriate if the patch is based on prior work.  
> 
> The commit code (as well as the other 2 that were already merged)
> Are copies of fixes that we already published in our github driver. 

I get that, but it sat on your GH for 3+ years. At some point the code
sitting somewhere on GH becomes just a GPL(?) code drop and the history
is irrelevant.

> This is the first time I encountered such a case so I searched
> how to give credit to the person who originally implemented the fixes.
> 
> If you feel like SOB is enough I'm OK with it.

Thanks. Also first time I'm seeing this. I'd prefer to give the credit
to the person who cared enough to push the code upstream. 
Or differently put - the best solution going forward would be if you
made sure to upstream ENA fixes from your team in a timely fashion :)
