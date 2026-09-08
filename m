Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6F49AA3F;
	Tue,  8 Sep 2026 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910835; cv=none; b=mTiRdvDWaQTACa8+qUFEGj6TEbMmH6MAat1hHO1YsR34UuQ7l0QSlXNiXCvQAKH+MAHisqwTOxtAaSo9fFiS4Hu+x8xIHTdQI7HnPC9jA+HIk6QXh+k0M1djPlHf0rNlIxeo5aPo7UpFl8XSQ7eAZOYKLKL0DtpOOylu/E0YmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910835; c=relaxed/simple;
	bh=ILYC1SUlaRoM1eZEdrxCH1DxIstltUXyS3si+buDvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbBn94OiaLUFXM7VhTr4hQviclAkhuK6csMbXtUISPsjoskoc5htlVdREouBipX+xes7bnBcYe4Dj0ae3pTGUNS/14HNYXcIvLYa4nOU6EGL2RgIM5WMoIdFc8uzrTNrvjzmV7bQsHCjJPH0z/40XopdxC9NMLzV6sKUNrN9b2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnB8q1Sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnB8q1Sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1591F00A3D;
	Tue,  8 Sep 2026 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910834;
	bh=fcZJXlYhDWD615p4JT5PC3pufjpYwSICP6q31pEFAmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KnB8q1Sc0PgxFQDK6Y73g1x9HgV4XcXzdwBhJticMiHitAo/DF4EZxTa949hxTEgf
	 w7qpJfuFnxjAEEp183l/rhc16oS6MnFpvZS4GXFpZgBUxE5eqcF6QCl1qCcyM9baHD
	 ouchSouYJ6LKbEhb8A4e3qJ2n/B78IaygKuXqSQAeFaAzvCiIE47r/OusrL+9NQEQv
	 Al3wJsx4fuWdITDbQ8MfohxGiSStL8w6px0qPb7BmEAFaPLSR6fagv5A9e4Vl766vd
	 mBH0Cac+qTwLFZdBAxuJQxm72GbAMIzgSgPZX0Tl4TN3fo7ZqOtY028crTXyaWgj4L
	 NZ76kYvT+dz7w==
Date: Tue, 8 Sep 2026 16:40:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6060: Publish the OF module alias
Message-ID: <20260908164033.5e995dd2@kernel.org>
In-Reply-To: <20260905134131.66680-1-hppiscas@163.com>
References: <20260905134131.66680-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 21:41:31 +0800 hpp.iscas wrote:
> From: "hpp.iscas" <hppiscas@163.com>

We need something resembling your real legal name.
-- 
pw-bot: cr
