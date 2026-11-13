Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592253;
	b=yo02VjEEjBtGt326ChlkMFWVjTYqTCbewxoxx3YC3B4JFKmlonoKlJuPpdQXz8dGbd13
	 vd8MvPY0QvmgnHUByG3Wta0lnohRrEwbDImGrryGuy1oz18vPvaObYnz0Xc4J4ZRDE1Nz
	 +BMxTTTzbp8FTevOpSwZFa91RwrdbDMgkygj7prNIMw1Sxynailgh7Z7EcwXRydkGDkz5
	 gt8EGBO0SnuUOZmSnPIvH527HMc+nPYSKc3uZV4Xcvmn/AV4MPL31JbhLvFbQA0U6j/8w
	 uddQcqWdd8rMYJHJhdlQdNMGp68VBdM3lbwHr7UEQrHRpajnj9K0/xobZx63a+q2/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592253;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=/XZwdUYt8kBTSTypLeLIdIsqqmTJ/mEKW9zpO2/18h8=;
	b=pzI33AQQzK3fncv233OuOcS6ACH2AseWRetZpNqQpW4ROEwtz7fY7bkit8uHKrC+tufP
	 wzu7RkANsU92u6HopLJ6ueKh4RDSHQQtjc04+1yJ9RmQ0RBnOmx0IAIzoCjPJ16N8dLAv
	 3+ozW4HuPGzEU/fBELM8t5v68+qlS98BxazFULAzmIR650AB4oUKBRkXfRPdAp3fyAbdP
	 xHejYWhyVesEK9js5mWCrmobfrirkE+pnfB/QTFy0/tTSE4OCrCzyRsHVJFvTGvgdF7dC
	 cljTz9ZFdHgtdBq8dKUMTiHypt2EVRK/8HZyjbgtB4CU+lcUVNd2dpzLA2cd5ecDnvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="n/wBjYRF";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CA606D483;
	Fri, 13 Nov 2026 17:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42CA606D483
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=n/wBjYRF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/XZwdUYt8kBTSTypLeLIdIsqqmTJ/mEKW9zpO2/18h8=; b=n/
	wBjYRFFeVKgvrBwGQONrRUi0W6q1bfdcSbQmSkrvI/llQ9Yf4I0LyuhdUnp/YsBcMDbEmxKq/nq6/
	moNU+9kaC/0GpocvsfhIEMVv2e2Oer2wgPYm4yHwRJDTfUtB5mCpzWd4OThAUdoR9lbmw6HH2R9lo
	ZNbIT8I8vnnwNk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRvPw-00GKZw-SL; Fri, 13 Nov 2026 18:50:28 +0100
Date: Fri, 13 Nov 2026 18:50:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] net: phy: restore driver state after userspace
 MII resets
Message-ID: <ed79ced2-5b85-4b50-8108-893f5c667435@lunn.ch>
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
 <11acd5b1-3099-4e3f-9fdf-a3c5c6f098c4@lunn.ch>
 <CADvTj4oPugtaeAXPvjJ10nhfKGDWTKbtALfuyF1+wUsHu2e90A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4oPugtaeAXPvjJ10nhfKGDWTKbtALfuyF1+wUsHu2e90A@mail.gmail.com>

On Fri, Nov 13, 2026 at 09:39:17AM -0700, James Hilliard wrote:
> On Fri, Nov 13, 2026 at 6:33 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Fri, Nov 13, 2026 at 01:48:39AM -0700, James Hilliard wrote:
> > > An MII ioctl reset needs to restore the PHY driver's configuration and
> > > software state before the PHY worker can access the device again.
> >
> > The MII ioctl is a footgun. If you use it for writing registers, don't
> > be surprised if bad things happen. Even reading registers can cause
> > bad side effects, like missed interrupts.
> >
> > The whole design is broken, there is no fixing it, so we don't try to
> > fix it.
> 
> Would it make sense to submit patches 1 and 2 as standalone fixes,
> separate from the reset recovery changes?

Ask the b44 Maintainers. It is unusual for MDIO to be none blocking,
so i do wounder about the other path.

> The b44 patch removes a spinlock held across sleeping phylib/MDIO
> operations, including ordinary register reads. The write-error patch
> propagates MDIO failures and avoids updating cached settings or running
> follow-up operations after a failed write.

We don't care about the cached settings. If you have used this API,
you must expect bad things to happen. It says so in the comment above.

    Andrew
