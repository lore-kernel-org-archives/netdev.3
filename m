Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134636E46F;
	Wed, 15 Jul 2026 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078714; cv=none; b=qytHGCMYht7VNXMl7FRvCg6kwN9lNO2473yPrIxtHVH4AHob88O2IdCfVi+7YKVTgJLxZCngn3SWy4ko+t9/Oxy4m5YK1zK8BZNWfGza75h8hSd4gOYehB1offkgr/285JaK9LDz14QGyryXCsbPJ/RRiCK30O7S3eAXzStYLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078714; c=relaxed/simple;
	bh=nbrK9mldE5JqeDv6K+pYmo9pJVnhcvcCJUx6TIlTKKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhh8zhztXt0IxUhhcOjJZvQJPgKeFTs9zIubskJyaLqnmrDSUweG7vy/ID0qOt0Sl8nrEImSkRMoGNvupyHOJ5uMa+T4LjQcpuZa3QJonXhRT93wAfOdwBpbUg7Sv0c5KPAUNV0p4edsfvaaUVDJPT9K8b9CcqOwsiVtPPW4ziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oV1LT2CU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oV1LT2CU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VZs1HzUMld6RU4sSBPQ3XBPcKPbX0uuBl/BKkS0rsJ0=; b=oV1LT2CUg9cBrpAnzcryXXqctI
	xAOKGC0J5CIUdfSlN0Shlim0Eh1HJaqBSdnbzj8PJJALQgkGqQioOaVtatQrfH+95oLicLJ/aF1sk
	b9IhkfkSge/bJsdVSHJge29kxcCUOeL9NpygBqEKqg5/yZL/944ydOKvpYMMtHiC3ueI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjoMy-00CHQd-VG; Wed, 15 Jul 2026 03:25:04 +0200
Date: Wed, 15 Jul 2026 03:25:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: dsa: motorcomm: Add LED support
Message-ID: <2b7b6626-7339-4998-b1bd-ce88cef92546@lunn.ch>
References: <20260701155519.273212-1-mmyangfl@gmail.com>
 <20260701155519.273212-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701155519.273212-4-mmyangfl@gmail.com>

On Wed, Jul 01, 2026 at 11:54:06PM +0800, David Yang wrote:
> LEDs can be described in the device tree using the same format as qca8k.
> Each port can configure up to 3 LEDs.
> 
> Currently, only parallel mode and strict 1:1 mapping are supported.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
