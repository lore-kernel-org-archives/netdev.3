Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E94F4CFF;
	Tue, 22 Sep 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078044; cv=none; b=C3eckVAEyoyaqTipjdXhEo9h67JTLj17FMPOhNC+dsJqdUQD7sEjA7ZAw8O3eRk+qA8bY6t0uLxPqhQY9A0OtLS1BKC1GxlaTjN062KcT3lsXqSIskmbwEbjWaQXcpTQO5yjKxFjnspTnqR8yrr3TsYKSzStgbsNXAQWX6HQC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078044; c=relaxed/simple;
	bh=iPCqcvUTBfr+67isUTSfP8lcawug9NL50a54J2kp+Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgtiryp9oZDIeJLuvVRzP2qYS59cPB9m6P40dp3IlUQBnaUVoX8ULRa3mCjQxmAn72gbqA/ujEt1h1loTNjH6q6xaXXXl/ro1GeVfA/fSII5GoMRVOE7ycRJeAmAXSVMIBfUpRUlAq9BqrVq/U4abDNyfegzPYkjog6NSvubISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RBXu/b7O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RBXu/b7O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D1vJIN1WEJSjIYe6qHmZ8YgFRvPHuWzAp9DorUFENJk=; b=RBXu/b7OlW7AD9qZboRvhA6+ur
	owGUWhCcQq6C2uoFIrL6YNl9GkH6LLzuZThDDhoHs5KplDdk79Oblgh57DWk598YHhNiIbgKmEzyK
	jjt87jNj4l8nub57t/AItqjQOOMW91DMvDzrz8eQqeY+dE7NloQHazEYOEe9PBF54zP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8z4O-006Zo4-5H; Tue, 22 Sep 2026 13:53:56 +0200
Date: Tue, 22 Sep 2026 13:53:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/8] net: dsa: motorcomm: Hoist port_to_priv
 helper into chip.h
Message-ID: <e0dfbc98-18e3-40d1-a0fc-0536be3f270e@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-7-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-7-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:53AM +0800, David Yang wrote:
> yt921x_poll_mib() open-codes the same container_of_const() expression
> that leds.c defines as to_yt921x_priv(). Move the macro to chip.h as
> yt921x_port_to_priv() so both files use one definition.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
