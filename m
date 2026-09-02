Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21E47605F;
	Wed,  2 Sep 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352205; cv=none; b=fTUre1lbqgRzsHjDYU5PMwLZv+ogEFgBNZmUAudVh2DIR9YkoMwq7tQgywp2hAh1UgmnmPyXuU5oZLlubh+enXP12I5IxNLUIqGbvTJVRaI26UEK4QMaBUXxlx3QqoS7rmQ7ZQK0W4dOI4o4qpj9BKcPwCVBnmT4A+2kvyJQKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352205; c=relaxed/simple;
	bh=vdKpchJCEHpObvZlp7G1thl7EeSlOK9KPXoSv5N4O4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtbwLPDmk9s5CU6baNriYfjuoQd2CLPOdWyYbTmsnuv94KPIFyumJAMGG49w3fuywNXYtS4WXns+GvY4TBUOptkEdUyBNA6e4ohK2SSFVzjozRpV3iocavV/6CGGpOlQEaLRVU+SonWic/KlQiu/rjQB+k1ALlweIfRjqQXYO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BnEZG/Wn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BnEZG/Wn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aG5qXYE0hgleoFSjDryN+frWz8Br2Fly54WxZqAVrMo=; b=BnEZG/WnBk5tyv7qSRW20RoEjU
	DF15g0MpZ6/4D6ZDSLDexkgA1w+od3fNQNptwtCyk+z4kMQyouioatwXegpKFLnFNQNEpmEoTC7cE
	rZncWnqexXUoZfBAf1tjYbag+KKe/G8/szLasFWc31QXAT69Wn/FZ2ff1Eq8Bm5tq0rQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1k6D-002W5F-IX; Wed, 02 Sep 2026 14:29:53 +0200
Date: Wed, 2 Sep 2026 14:29:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v4] net: dsa: yt921x: Optimize driver for better
 generality.
Message-ID: <b91e38ca-7ef6-44c6-89c0-79419cba57f3@lunn.ch>
References: <20260902024737.587386-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902024737.587386-1-kyle.switch@motor-comm.com>

On Wed, Sep 02, 2026 at 10:47:37AM +0800, Kyle Switch wrote:
> Replace fixed macros with values defined in series_info
> for port validity checks, in order to facilitate future
> adaptation to more switch series.
> 
> Replace all fixed values for DSA switch attributes with
> values defined in series_info, to enable better scalability
> across different switch families.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
> 
> v4:
> 1. Split patch into multiple patches

I still only see one patch. I was expecting to see a patch series of 5
to 10 patches.

This one patch still does multiple things. It needs splitting up.

Please subscribe to the netdev list. Spend 15 minutes every day
looking at other developers patches. Look at how they split up
changes. Read the review comments. Follow a patch series from v1
through to vX until it is merged. If you see review comments which
apply to your code, please fix up your own code.

You can learn a lot this way, it is worth the time and effort.


    Andrew

---
pw-bot: cr
