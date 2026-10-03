Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F83655E6;
	Sat,  3 Oct 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038300; cv=none; b=OkUetlNIyFwnbzTy0YUKNRIQ+0b5DIWh4ASRhxv/bQeWlmQtY1fnlpzVW+T7L9RVzkHrBLGrngPTZ7DI7ufnuVU4O9fp3G/kERw3Nu/2Y8OtmVzic+CkCJvWwQaHrP47pkAHJK2kT1g7OZmQdBgYVdcKv9ZLcAI3gVPjtzEWchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038300; c=relaxed/simple;
	bh=lk4x11EHLXs2UR+/ptY9IIa9Osi6U0fC+7NUCI7ocrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPulZPJ8SQ7L4nQTh1V9DZ6v61tTrzOgomZqkGIIVkGJT+an6vH+yGNbQM4fU9I4ieJkfldR86OwwAFEyfb8ymBfrzBOLtIL5Ajgl37zCmT/8f0MtZ27E/fNZzkCKhbU/QryL0AUjZdngo4Tu+IDC/hoy8TEFAgxOO/BnkngMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lxEb1/yq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lxEb1/yq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rzMXWV4KkLzL1+bqSDAMTe9QwTODJ26nW39l5tWgYw4=; b=lxEb1/yqaPtt07KQPB0GXTYyKs
	xduLB7MZVgl+0Fg1WOyqqCX/fueGzNzdwMVY899dvb7HCbn3GFGciQE7pMITdCavgFhZylC6PykU5
	xgx2RJqn29VFTacaSG9MUi6YwiERzJqszO3P52yGBdIhz/8hwINGoUc976fMz8gKDzss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xD0sI-008lU4-FJ; Sat, 03 Oct 2026 16:38:06 +0200
Date: Sat, 3 Oct 2026 16:38:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link
 status
Message-ID: <36c4c389-bc11-4363-8e23-eb8199dc3499@lunn.ch>
References: <20260928220749.857-1-yongzhao.derek@gmail.com>
 <01a62e77-6c4e-4665-ba46-26d12b1c77b4@lunn.ch>
 <20260930212348.1919-1-yongzhao.derek@gmail.com>
 <2ea832eb-33f4-4bf3-bdba-5d983038d012@lunn.ch>
 <20261001181634.1508-1-yongzhao.derek@gmail.com>
 <7eed302b-d455-447f-9ce9-f15468b9792b@lunn.ch>
 <20261002203522.1219-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002203522.1219-1-yongzhao.derek@gmail.com>

On Fri, Oct 02, 2026 at 10:35:22PM +0200, Yongzhao Chen wrote:
> Hi Andrew,
> 
> > The traffic failure was however because of the error with setting the
> > DACs?
> 
> No, sorry, my last mail was not clear about this. The failure was on
> a QCA8337 user port connected to a NAS

In that case, net. It is a real problem that bothers somebody,
you. That fulfils the requirements for stable.

With LLM, we see a lot of patches fixing issues which nobody ever
comes across, they are theoretical. We want those to go into net-next.

So ideally we want to clear indication in the commit message that the
fix is for a real problem. There is now an automated email when
patches are submitted when it is not clear if they are theoretical or
real fixes, reproduced on real hardware, or just build tested, etc.

	Andrew
