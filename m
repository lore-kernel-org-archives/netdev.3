Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA53839B3;
	Mon,  7 Sep 2026 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812479; cv=none; b=bN/9POMF16LVy6T71ugmWeTUSGPBFp5Jez+qymrdgHum6RObIgKRboGnhBbZp3gIQ8r5SIRMg/dls75jNUj3gEiCdTKkHq7vAwTGMJdnuxqOIUkCytsgYxY+jQWYQB8ozF1Nh8UUOveY5tMu7KlZo/e+LNJui9gIOXRuU2L43hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812479; c=relaxed/simple;
	bh=nz45TLa3B/z2T9fnrZIFpMvPVIgrU3RoXRMfbuWLYPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFRLxXB9yHXTSfVkhNw9BwqtNpfPLQZMbQ25PuAvSY9J5bDrGnm0UoCeqt/WkaJhoyrgEqKaxmwLbf6djtRJbfsm6HccEuH/VZrjEOppF5mdVwuWeAjqQGUZba9oZskYGr8XBBOLR42Ly1877lxBJ2rUyVjWF1sSEfbTEknQS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KM0PJLA+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KM0PJLA+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=susvB3rbS9zvr/20VdYg5JZdpd5hIfZmK9x/Iwk5XXw=; b=KM0PJLA+JcGwvrqh+e0MuU9jyq
	leeZpj1XiaHfrkaNPsScaqV9TTNfYXOdVk8IhID7FrTUrXMoZql81YgSaZJVZkjvBooZ+txauOpTW
	TpGZw0H352qNGe1pMezm+N/H4c3Se3L8jWyoWxRtneNQDjj+ZxvX8cYv1XJ1k1IfRQwI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3fpw-003d7Q-UB; Mon, 07 Sep 2026 22:21:04 +0200
Date: Mon, 7 Sep 2026 22:21:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: dsa: motorcomm: Fix MIB
 synchronization
Message-ID: <023ec406-4657-4827-8154-a72243c06f15@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-6-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:47AM +0800, David Yang wrote:
> The previous MIB sync was based on the false assumption that 64-bit
> variables are always atomic. To fix that:
> 
>   * .get_stats64() uses u64_stats_sync, together with u64_stats_t;
>   * others take the free mutex lock if possible.
> 
> To minimize time of the write side of u64_stats_sync, a per-port buffer
> is used so that all the stat can be written back altogether after IO
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
