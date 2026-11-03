Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711884;
	b=ms3u/jnhuXUcXW1UuqbTV8lMn4ce2qFbugcfoajHSKQkWOAPmhQ7POHAouwggwHjq84G
	 B7GUeZEOUSVkzpFUTne2j4ZrTnH8ohfZTZMq0xmkCdGX5qEq8Uspswjt51K97pDMeLtNi
	 lxcRw/H9qG8Ch6V+Xy2ZvBYYNz/cTS1FI1FRkHWNyKlE6ijLCelW3hkXtksmeh50U0pbN
	 s5U+6I956E/2vcQ9KoWK3230y109svc0zNWE3PY4lsJItJReHIPUBVu+SQ7bJ+V5gKxSz
	 YrDbj56xOUA8UJ6hOnlifZxIRGWus4Spb1nziW8ItQPAQGdkOUwqkfUHB9qhbrncdUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711884;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=K9NjD2+W4U6XlZrh0EAEIVxEbQlkl7AjVMW3Vg/Ub/I=;
	b=GAfnIth1+8eyCKNKDqd1FO3jvng1lYeB4GfElLK9DbJr2wLpy9MWdQac2JsnQ/10wZpN
	 GPFjJQal6RFql20XKYo3A2jCaoMqM0c/VqDZZ4O3QNbefeM4oBMGycEozAx5YyGWuqmQX
	 IFfTQk4l7l9LSmTCfsoNo2i6jqPiXb0GCHEsMxhjIdzxJOhq9dEwzuwi7bNOWe/nLKMGR
	 qFgZ9WMS/QesjwJSuRW2I/L0vI0+JsfPHcgz+NwNVHavANWFfbk3SR3NqEB+lkDICSSOd
	 YwLvVAI/c4evDGCAkYNJWcIdxMc8QevcNxTh/vAf/y15ICDEzxq9XFB9oxDp3gBTsFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mySeKOCX;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC96082BF9;
	Tue,  3 Nov 2026 13:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4EC96082BF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mySeKOCX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K9NjD2+W4U6XlZrh0EAEIVxEbQlkl7AjVMW3Vg/Ub/I=; b=mySeKOCXECat/gT6wlEkO1lhfF
	HpjH+OZEmSnxM3vAtf7yTXSohM+uGLVgfJvJytF2/CPWdy/oU5tJHuo11rw8b80qkiW95NHDHSUx1
	olYaPMzL9Wv+xzsCfKhon1tL1J6AIYUg18bOdTiwSDojFU0mYmPd3s6FOP2dZgDv4zz0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOEOj-00E3ZI-Cg; Tue, 03 Nov 2026 14:17:57 +0100
Date: Tue, 3 Nov 2026 14:17:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip
 reset
Message-ID: <636c7cc0-f4b0-41ae-8cd3-c4bedb70307c@lunn.ch>
References: <20261102101125.3523835-1-mmyangfl@gmail.com>
 <68a1d47b-e3a1-4353-82a0-89fb2d387f2b@lunn.ch>
 <CAAXyoMOsu0kL9Y=7+BhDizgUbF+tY+i51vdNpeZ6KhQAPovvcg@mail.gmail.com>
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
In-Reply-To: <CAAXyoMOsu0kL9Y=7+BhDizgUbF+tY+i51vdNpeZ6KhQAPovvcg@mail.gmail.com>

> Motorcomm does support cascading, but not in our driver. So yes, this
> is largely theoretical and I just follow what sashiko said.

Then i would target net-next.


    Andrew

---
pw-bot: cr
