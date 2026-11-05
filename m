Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917605;
	b=kKWcdI92so119SlAdDL3gCEX/ac9xhsurNK6gzseJanS+JfJJldvZ8HU8B2/t1pceIt/
	 aGQClh/ryl7pAif6mDSd+Hc9s6vZ9On2QwW+y5ntt+o9Pgy8Yq/mYy71i1QVvacneHfNQ
	 fN2Tu30XtA5UcXXKoaBe+6RjYcRFzDjPg4Id9jiyAP8quXB2fCilqB+RwbtxWydwtsXKG
	 fpdtTwhWTrvw9zKCgXLLWwelxoJ4KUmdmXtVe/kVartP4MHauirZ9gTuNdSSqjUVZ5Il5
	 fJbPBTvFaGYBpeih1gvOvWBUKMQtTKf/mwqX9Obx6AqAhsKudOg/IZJlMACzzhG3FpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917605;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Ub4KS0c67znfqPuuGGrCdZPsAUTqtjypyv5in5APvsk=;
	b=a+MlNjcn0uUiFvPe9H75gYUOftXCMBMbpvaSD/fAr3Rw+K4DZfTG2jLVhxqxyZDNs833
	 OfNPD5FMoRy9ttNu8+X2phDIrzIXvXYXjYpIMaNvdjIBnY8fTagpfc7m2nxJSC6Twv8tk
	 v0b75/cxcrq7WKYIsiIgwoLulpmJ+vp78eZyT5TF9KwHFs+Qax/fkKyvaG5MTI5Fwsnb6
	 R8Ivmg9LiqFuczoWt2TvxBRwAgjKBOnnknbuMhbJk3KAn+NSWTD+JreG2MdUkDPl8Jjn7
	 rbKFp7Cb8O2b2u+rUIyPyqoTkcbGfeZ3RjOvDhHEKak6bW7C96Fjix5seSiz4q2vQ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QtZXyt44;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74283606A31B;
	Thu,  5 Nov 2026 22:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74283606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QtZXyt44
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ub4KS0c67znfqPuuGGrCdZPsAUTqtjypyv5in5APvsk=; b=QtZXyt44cZ6WYIR4u51L9qY8QV
	8U5nIyigKIP/Xj5h+Vv79DO+7rFc2OjaMkpkcyMJkubmBwA8X588eHyenyiC5IKZeUHMaYMt1xbkV
	eFSO6Tbbl24nXwHJFjL/79ZuhHJsyoRr21nF7jBw4VOg/oSZwxdqnIvzb/B7vwP8DE30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xP5uj-00EeBs-9g; Thu, 05 Nov 2026 23:26:33 +0100
Date: Thu, 5 Nov 2026 23:26:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: tommy shih <tommy.shih92@gmail.com>
Cc: netdev@vger.kernel.org,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Lucien . Jheng" <lucienzx159@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_an8801: add WAKE_PHY Wake-on-LAN
 support
Message-ID: <1779e3fa-08a0-4726-af42-bcb8a64d769a@lunn.ch>
References: <20261102132903.713908-1-tommy.shih92@gmail.com>
 <7e1ac14e-b306-4921-84fa-8266b3263f2d@lunn.ch>
 <CABXpiCoUqhq_Jt8AWcZRQWue-pTvoYSGxNkbz7e5MLvw0Mjh2Q@mail.gmail.com>
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
In-Reply-To: <CABXpiCoUqhq_Jt8AWcZRQWue-pTvoYSGxNkbz7e5MLvw0Mjh2Q@mail.gmail.com>

> I don't have a concrete use case for it. Waking on link change does
> not seem to be a common way to wake a system over Ethernet; magic
> packet is the usual method.

I'm tempted to reject this, because you don't seem to need it, and it
is not clear if it is even correct usage of the API.

   Andrew
