Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398936;
	b=HKSjdwAXRTkgZ4qv3P+IiCDl9eVoma/uv/XBijr6Jw2qSMgwUbW/6WPgF6xsh6L6iqel
	 cGoqbwyFFsCZLAwBlQEmBaClNz9izZRUAljonp6jVreMLQM/EjoRXaV8xeT1Qiuld6O+k
	 ZI4+k+551ji8U1VKBmDeUmq3UeI52VlNazAr/vY0kdvs07Qt/oC2RRCa54NSjFJxbI0r8
	 QFis9x5ZRQKXBtop3hy+GKuzdEFSZtU2rPRBKyiWP+azpwm4pz7Zx4DkD8w1EhoZeuzdZ
	 tzdovL4gPPhOvWKu6h7o4zDsMfuSz/HiuWrdNNox9ZytflEyILCpDwrurfojl2hC09Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398936;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=kS/TDTrY00Jn3FojL8Xj+bZxIz2FpM9MJgEtAuOI6Iw=;
	b=wXtXPygQISLxS71ekDmKkRTnJ7rmu45QFHUGMzlLfEQP57WWjK25T2jORXN0kUnwNyC/
	 QcxMThXIyeydKkFwlKeNfdjFHW3PH2vgSEg/aP16BYeuRZMPRqxHKIMnuJHsP0j0b7rLV
	 Ho0fL2hhs08uBbPssMzpTnYAZUu79CCJcx1IMAXyKUT45wjhQAzHBC9UbMY/XcsJObBdh
	 BmtB6CAiTHqrdPyLs5+F+0b6toXeet5+l/QvvOgoFiikG5QSxkAz7ryJq/9PQaI+sm8nT
	 lQNusD4wpyeSS7BmKqh6UB3m8uMy07vtV56g0Zo1SxhofWWJLB42bvKoJeNThivNUGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b="Co/kQqRt";
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7B606A31A;
	Fri, 30 Oct 2026 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=Co/kQqRt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kS/TDTrY00Jn3FojL8Xj+bZxIz2FpM9MJgEtAuOI6Iw=;
	t=1793398934; x=1794608534; b=Co/kQqRt/B2pujHcvhAf5qu0JVaLy7RClsUXl64ZnDoAsCF
	PuFvi97ait2BsASG+LKvfjcm2ZG8LctbUA+ULmqS/D9VyMLjJg2oUFHIkfJTlHmmDiXKSGAZEyPFB
	lyizFLgm+f8xK9sovBEAUjgQKd6fxa6cLoVPXsRzClc6U/w0D3HQewN6AXBasbUktZDNBt790r4xQ
	2Xh+/FmQKsPa9neltfZkFCx66E5EkLNlVFemv3Fp0GMzQaKABalEM6asH4k7O0magrreNMjsZYmYx
	zijuehq553Qxq2IDajto0+s31dd7LWYSIf1S3bkD2MKM9ZiliYsgoBYe1N48sbtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xMuz2-00000001kVp-07PE;
	Fri, 30 Oct 2026 23:22:00 +0100
Message-ID: <9291ce4a2dad9a752c84c34a7297dc0dd6b373e0.camel@sipsolutions.net>
Subject: Re: [PATCH net v4] net: Fix Hole-196 vulnerability by dropping
 unicast ARP/IP in L2 BMC
From: Johannes Berg <johannes@sipsolutions.net>
To: Julian Anastasov <ja@ssi.bg>, Star Chang <starchang@google.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	horms@kernel.org, linux-kernel@vger.kernel.org,
 wangroger@google.com
Date: Fri, 30 Oct 2026 23:21:59 +0100
In-Reply-To: <553d89ed-8691-45b6-ac98-0faf00b859cd@ssi.bg>
References: <20261026150539.1357037-1-starchang@google.com>
	 <20261027015619.1745984-1-starchang@google.com>
	 <5c1fe870-39ff-e83e-e479-0e1f0fed6a83@ssi.bg>
	 <20261028061644.2997812-1-starchang@google.com>
	 <f631e178-d9ec-f335-9163-c44a9e6c58af@ssi.bg>
	 <20261029090241.4070613-1-starchang@google.com>
	 <553d89ed-8691-45b6-ac98-0faf00b859cd@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-10-30 at 07:20 +0200, Julian Anastasov wrote:
>=20
> 	May be DROP_UNICAST_IN_L2_MULTICAST should drop also
> the GARP packets. Why should the GARP packets to be more
> privileged than the other broadcast requests?

I've been quiet on this ... but in particular for this, why would you
not just use the extra knob we already have?!

johannes
