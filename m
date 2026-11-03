Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711363;
	b=NBKsYhQNGzMe3WxIGKCbjrSq0JVw6VsSNXgWmgOCRjOWEC0ynYEEMJgmiO9Cx93gGUnb
	 ZkLlzqbZfZBUxES32o8FjUCe0ifDAocE8UIoIyz/XqQL+uXc3uokiOCHOx49eoSSLltN1
	 W8eftfmM+FkJJuP1pIqXGBn2liCFXCx9iwwEo+4SBObXSmJvXkMjlTP9xUpPGgZwZcFYz
	 Vo/LOV1TUiUtOorNmZ2uIKqsJzPw9xNuJ1oAdpp54a2wAH2CWR2ot85jUF3X2n8o2kBug
	 0+xvYS3q0fkp3m8l09WE8MjuBNPUg4/+eDqRdff/O2ewGude/ozQ7th+FDFNW1keKVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711363;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yZpf1H/k4whOqY1BVAHAnVNVl1rw8m1xEANoC6I5NO8=;
	b=dPAXSyynziYTZzxJKvTXR8BVXRKP3bg5exnnz6ryiIEaAESfNpWiTQIx7i83D0VV4l+g
	 TYgVJq+E1yDZ6vSoAw23s5BLqRsFkbOYEaIZ1o65pUvDJbD59qOp5cLOaEIWQM/9MMXi5
	 /uKWRpE4rbWru0G9Go4aaO4QAM5Yj1QLVC4BaZYvEIrrzX7blllhnIx6kXl1Q3fu2lvbF
	 Lb2YLx3gugJ+vxufOJ+DO2u5AO3wNxXUxvkogkLDxIC2UPSI7dFOT9GgPE9+4OwnyyysG
	 mQ37qCeoEfUW7IIdzjUmELHpYomfhXcmCftJad+yq5qj4PE1gs4m6Mk2ha+LVdaJRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="v+/GviCh";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD1606D82B;
	Tue,  3 Nov 2026 13:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30FD1606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v+/GviCh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yZpf1H/k4whOqY1BVAHAnVNVl1rw8m1xEANoC6I5NO8=; b=v+/GviChsC3nfnI/bGjE3OJRB/
	cuzwpZpEQEv8eCzynRfAm0aIjtEtxa+n8wb3qtQE6fnyXNjmXXQrwk5csDwQTTwAqBQ40X6dij1xY
	/Sq9uEWlvC65HITtW4gqx5E5fbCFKCyZwwXeP/Q3JV5bfasObqYNAgewI1HnGOOcq4Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEGD-00E3QR-No; Tue, 03 Nov 2026 14:09:09 +0100
Date: Tue, 3 Nov 2026 14:09:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs-rk: limit advertised interfaces
Message-ID: <f554dcc0-14ea-4721-9517-dc0337c47426@lunn.ch>
References: <20261029094916.3127193-2-coiaprant@gmail.com>
 <c5fc86f9-3c43-4aee-8d88-92e8f88c6d5d@bootlin.com>
 <1B8D463D-1295-4BF0-972D-859C342E49F5@gmail.com>
 <48cb8a9d-622f-497c-a13e-bc679c764ce0@lunn.ch>
 <27E466B0-72FD-47BA-B952-68BF4A817A04@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27E466B0-72FD-47BA-B952-68BF4A817A04@gmail.com>

> >Are there any registers which describe how the PCS was configured at
> >syntheses time?
> >
> >	Andrew
> 
> Hi Andrew,
> 
> Yes, looking at the `xpcs_identity` code, the core does probe different
> MMDs to get the rough type: PMA/PMD MMD for C73 and VEND2 MMD for C37.
> 
> However, even if we determine it's a C37 or C73 block, that only gives
> us the rough family, not the exact feature set.

You might want to try reaching out to Synopsys. There are sometimes
feature bits in VEND1/2 which list the exact configuration
synthesised.  And since it is a core part of the licensed IP, it
should be safe to trust it, independent of the platform it has been
integrated into.

      Andrew
