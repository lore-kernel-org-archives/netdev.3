Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C42D593E;
	Thu, 11 Jun 2026 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193050; cv=none; b=WT53wrsT0U9rBN3eaNqGJ9YNW4yXz78rmZIzIrSiZvWeT1a12gBFMHnw5k9Dobm448sySQ8fOjVI8SWwMsRu7N2iBTZphAV3G8djSloMlY394LO+nsoFRfP0yLHV3qmnKDmLq/m1kaj/ribn9FfpAm/LR6CrV0mSg4eqD9WekFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193050; c=relaxed/simple;
	bh=C9Wz+326V6lLAkyQkqUwoBDeBjlimsAoy9A//VFYad4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pldjwaUy5W8FkKiedWocY/BAun6sp3se7780To87mB6yRms9q49iv9EQ74UCGeDFBaZ9ffJJjrtVUDTW3w1jT35j49Zaj9KG0CVvFSj2cutjL5KWfCb+VmRJfnBESoxX2JAt4m3aVrikkMElJW+6SSu5kU8M4ntXdD506OlSG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=InqXw1qT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="InqXw1qT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sX+gVdKxQAFtgOnc3Ye54B2febFesWu+jtpodVkLRc4=; b=InqXw1qTMWyJj3LqY2qNa30o8u
	HN+5Xj4LNlPzK7VjqtJe1SYjEcsEMoYe9HfJQsphZFd2dnG9juPdMv/B+s5JGclqspjY7Qh3Usc8W
	XYh4hKdEG5DesM/KEGnJa0by+rgFEJdZPpclV0q0F0NadoA7mwY4SmNH+LEf3fYzAOD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXhfo-007BME-Ba; Thu, 11 Jun 2026 17:50:28 +0200
Date: Thu, 11 Jun 2026 17:50:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Carlier <devnexen@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jan Vaclav <jvaclav@redhat.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v4 0/3] Add standard stats for HSR/PRP
Message-ID: <e8965004-f286-4589-a834-309ccaa1d575@lunn.ch>
References: <20260611095035.852370-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611095035.852370-1-danishanwar@ti.com>

On Thu, Jun 11, 2026 at 03:20:32PM +0530, MD Danish Anwar wrote:
> Add standard stats for HSR / PRP. This series was initially adding HSR/PRP
> related stats for ICSSG driver. Based on maintainers' comments on v2 I am
> now adding support to dump standard stats for HSR/PRP.
> 
> The drivers which support offload can populate these standard stats.
> 
> This series only implements offloaded stats. For software-only interfaces
> Felix Maurer had said he will do it later [1]

That is ideally the wrong way around. Offloading it used to accelerate
what Linux can already do in software. Statistics should be part of
this, you first define software statistics, and then get the hardware
to report those.

So please get the software statistics merged first.

   Andrew
