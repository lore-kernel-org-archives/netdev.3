Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB709175A6B;
	Sat,  5 Sep 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594380; cv=none; b=C8/qevGjTGC14AUyrZt6chdSQBanAP4EhPiagMEGvm04Zle1vqzWbQhqf7ZNsl3foNUiGhFlIlb8o+ZLYR7RjwI/BVO/U4WumFHNZXXfhraPNzx2f5NOoYv4paqpsVUquAQ4Sx5DSys3TzQD1F9Wy6vc8Qe6i5B1gG33g4obIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594380; c=relaxed/simple;
	bh=6inJcufM91+L8+lAVis/F1jiStypTiyA/Ugt/PU5uTg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuDvfFw2R4EoVyXtNGLIIZE5I5JyqR7tBD64f/fvg/2S4OU1Z80VVg77EbQSh0ES3Cg117985BBQt7Bo17FaCJDoTfJfzKYx1xeeBhvHc/tIDH3k2Uzqd5+sDwkEipiigx+o/E9VrOKO3YlemAL94Lw8huirayjIZF82K7xqvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZY/r+HJy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZY/r+HJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8FVoDKKoNaPjLoBUERmyOTFCPcV5A3MzZKBXUqLU+Js=;
	t=1788594378; x=1789803978; b=ZY/r+HJyg7Sr6mMC0ZKYS98BD8x4XjsfeIhQ5RdA1C3lFVg
	pFyJA4HlaRue7tyVn4c7hsEOixgyik4fgVTx4XrM2SF0TPVZcLghDoms625dVonrXKD/iCaOfnqe9
	Fsxcms+ZyvHSi9M5jIQIepq40CmvhN/Ko7fzxdW9lbHInSBo+He5BhTttzTRr91Wt7kLlgbROqOxq
	lfEGvTJl/dleGHId92poHY37NVXBG3jJFTXweLiqtqFL9XUaZkw1W8cE5YbVVcwnSkKsM4+xskA57
	U+hbsNf92neijp27kok2/y4YYuZWWEqUFIDK34neqK+kKoBJOoyqXSHj2s3zCy7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x2l6K-00000002CPf-2Dc2;
	Sat, 05 Sep 2026 09:46:12 +0200
Message-ID: <6ae7fd5e4d24bdeb0f0df057f767107e08567640.camel@sipsolutions.net>
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	 <donald.hunter@gmail.com>, "open list:NETWORKING [GENERAL]"
	 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Sat, 05 Sep 2026 09:46:11 +0200
In-Reply-To: <20260817084713.7a7694d6@kernel.org>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
	 <20260817084713.7a7694d6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2026-08-17 at 08:47 -0700, Jakub Kicinski wrote:
> >=20
> > ---
> >  Documentation/netlink/specs/nl80211.yaml | 351 ++++++++++++++++++++++-
>=20
> Hi Johannes! Should we add this file to wireless in MAINTAINERS?
> Or do you prefer for us to handle the YAML stuff directly?

Not sure, we don't really seem to be using it for all I know, and so
it's just been getting some random updates like this, I guess.

I think I tend to prefer the status quo, but I guess I could also just
apply patches to it if you prefer.

johannes
