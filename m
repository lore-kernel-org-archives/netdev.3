Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B22D73A6;
	Thu, 11 Jun 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157841; cv=none; b=mNto0unhiQYPheaGC82DOI/y0C68CzOJemk9z428Wb8E6o796Uc6J8WPcgZsYGL0/tEVozTtP9cv3R3dYyE9XEG525PWc8KEbJdQWvAFChaDHaYp2B0IKIi2yHknlzDG4b6i1TcgoK/wvhAIh+BWzmtLJP73cGHL3YahqtT4dss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157841; c=relaxed/simple;
	bh=hD9JXSnnhKKjszjvZu5gUEwLdE10wd/KBk++0my1Y8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWhn/jxyrUgsanBMGI81VAYy55Ek/3inddH7nevk0Cmf5DVctExiQijzdQ7AHHFoNcTaetEtpYpuqsmv40IvnHT5OWpzqF27Rc7O2cPTUcruXDZRjyQvYiv+75S+qdKgmJmUire//+mPEyE8d+c98BO2dQqH2GJDU8C04S5cGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dkY8LGeT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dkY8LGeT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z7yljr+pgwJS4zPjc+Z3hz6+DklzBZDI5Vx1ti63JxI=; b=dkY8LGeTqyrzIDLigFlP59we96
	g2MN+QQWfmraWt8JJRzANrC4wluuNy9AOaNRNvvh8eSvKo8pHdasP4ZMlrbyEUcjoAJX9/+gS4JB9
	mvRifY801lgNlwNWr1c2ZBahIl3jcCgLQx2F2jGTC75gfRQv3BqozxoDObSZ3YB8E3IU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXYW1-0076Lp-8v; Thu, 11 Jun 2026 08:03:45 +0200
Date: Thu, 11 Jun 2026 08:03:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvneta_bm: add suspend/resume to prevent crash
 after resume
Message-ID: <922113c3-7fd0-4f15-9fa0-7e9a540409dd@lunn.ch>
References: <20260611020935.1933865-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611020935.1933865-1-yun.zhou@windriver.com>

On Thu, Jun 11, 2026 at 10:09:35AM +0800, Yun Zhou wrote:
> The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
> allocation. During suspend, mvneta disables its clock, causing BM to
> lose all buffer address state. On resume, mvneta_bm_port_init() re-
> attaches the BM pool to the NIC, but BM hardware returns stale/garbage
> buffer addresses. When NAPI poll processes these buffers, DMA cache
> sync hits an invalid virtual address causing a kernel panic:

Has this never worked, or has something changed recently which broke
it?

	Andrew
