Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360C230264;
	Sun,  4 Oct 2026 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123203; cv=none; b=gzxdBe/cKp+ApS/G93l58iOtIo4k2eIwt1cr9ux4KEV+HKoM+r5mbulBOeuSk3yjZtKsuFTJFiTvZQgdttLfVwWJ4X0DwP6SFy21FUy+4HVhmONpQnKUCVuMJP0Pf8yFRfpEmWa22CJGpVyKqkzecIEjXVeVM8sRXxWZNmEW5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123203; c=relaxed/simple;
	bh=ALSLL3fll36Rh7xIMUts5Xsp6PdBzscWdAXGgLe5XM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPhJ3o94dapdG4ZaJIBmP8sxJE/FeAaHMrJS4EO6HF+DArkwTP+yJscIW+FR9phl72IsYqfy44FSxGZb9bh0Mx9qgmevuJ9fJy7NpJymzbIscLX3eqdSnDmf39a7TEHKCDoUU5ZSDlpqiQE3R7o2X+y2Lbeqt8E2KPM5lXrXq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lLJMlDUl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lLJMlDUl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b4e+/p1dPYJ4f2plL7QtJKrsombqyJ2bNeqZ5XbY+WE=; b=lLJMlDUlPHwQcgZNWE0teN+A0b
	II9mWl5QIKLiLm4NgTBdquFImjL5RFsaIkRLRn2Fn117wdg9E1OXK7NR+nB1shjIhiEm9lXSgWBSn
	jWaBZzhp5ky/Gylgy6tXxFf6/+eevTfVbZbrJF6sI3gBFb8pQ5DLZjZKPPANlQnkobCA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDMxm-008t7z-9y; Sun, 04 Oct 2026 16:13:14 +0200
Date: Sun, 4 Oct 2026 16:13:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] net: dsa: motorcomm: Add TC prio support
Message-ID: <0383b2d1-7e6b-4ada-8813-7170f244097a@lunn.ch>
References: <20261001204851.2576101-1-mmyangfl@gmail.com>
 <20261001204851.2576101-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001204851.2576101-6-mmyangfl@gmail.com>

On Fri, Oct 02, 2026 at 04:48:48AM +0800, David Yang wrote:
> The HW supports fewer ACL priorities than TC does. Notice the default
> priority for flower is 49152 and catchall filter has priority 65535, so
> scale the priority accordingly and reject the ones that do not map onto
> a hardware priority.

It would be good to document what the actual mapping is. I think you
divide by 512, and then invert?

The code itself looks O.K.

       Andrew

