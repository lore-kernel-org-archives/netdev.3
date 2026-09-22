Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3B53B34F;
	Tue, 22 Sep 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078009; cv=none; b=XbkkzOOGz9rDTkkv2tDFypzFzUHl6XDeb7H/N2dbrq36ET6TXX1r1YhCc9cLj95d4TEenFTPJrvwGnrDlyq7dhXCM4m6qYdkNENmlDxUI+3jbNm8Rv0uBXI8jTEQeyNoOSVJ6HnTRx+pRZ2Qp4xWI23CRb95IQ4kvIl8U9B7MJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078009; c=relaxed/simple;
	bh=cI/yf+/aqxNz3rlHprxiG0BzxCoJgOUsadd+/LIAw5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhA6fgd2lPu0wCgtxBW2DcKbUdoBQ71mXJ4TTWmfayROGyqo0v2BRp/kEiPcK7B5kolJwRXn/d/u8bzee/FAyioz16qX6LSmrZFkESVsI+XFASSzfAszwz6KD12yaMeRWbZrRWH/lVHqUXgNNRoBA/nJEWbyxw1CQF+vgZy9EQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YbXSFs53; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YbXSFs53"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ypCY+k+45VQubu41f8meQZDon9VQmNyZQfmomwPKcZE=; b=YbXSFs53MUnonh+H5jXY6eAn38
	tyFalBC6amIBqk4bICJdLtP2Q5T/Pq+qhLrmcHN7RPmGl+HcjuTrSTHIYlNn3Dtxy1aQJgN/1T5bD
	843QX/7srAzURcKl+DgiRpBS/0MLW03Qxm97ojTk4oGcZ2/W9XUhVvEtv8d+sqjlcaDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8z3o-006ZmQ-LO; Tue, 22 Sep 2026 13:53:20 +0200
Date: Tue, 22 Sep 2026 13:53:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] net: dsa: motorcomm: Introduce
 yt921x_speed
Message-ID: <beac6481-df90-4faf-bdc2-8c3ea09b0480@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-6-mmyangfl@gmail.com>

> +	if (ps == YT921X_SPEED_NUM)
>  		return -EINVAL;
> -	}

> +enum yt921x_speed {
> +	YT921X_SPEED_10,
> +	YT921X_SPEED_100,
> +	YT921X_SPEED_1000,
> +	YT921X_SPEED_10000,
> +	YT921X_SPEED_2500,
> +	YT921X_SPEED_NUM
> +};

A nitpick, but i think YT921X_SPEED_NUM could be better named, like
YT921X_SPEED_INVALID.

	Andrew
