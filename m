Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A419D89E;
	Wed, 24 Jun 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337902; cv=none; b=AKvnT/619O3Lhw8dvd0d49rAYowKQaI0U8iKej2GAN0ZtFkC+7xHWsE8yCIdHI5CI0vqjPHCTd+dAKrEKh93XV5ouEfOFh5Tg6Kw6NzzdcxqQCvt2wCixxgh7Dzlu/i81w7rOvx9cNy8ASNvE3/Db/5VwLUXVOcu4oO+w7cCC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337902; c=relaxed/simple;
	bh=AFEW21SWiqiIFTvSKJN21okIlXcZyTwSPfAYCnqtbJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIKyH1EsupqGxzMh5kXcDoA0Phcvv9w7a4lOqc/5slSgOamAKrZH2I7fbWzucyd6MP4nvAoKzueq0FFrb1oFWnjMk6tIFgA3ptFWKvXo2907X4nUTJJKAorChuEx3lyjHRq0+vwRpbkTJQlZdblQXisxZCwhPkesjttuvjPro0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EnPuo9t4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EnPuo9t4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hg2jGaNyqb5D+bewA3yspL2Q0+FIRriJ4/WPaOu7cmo=; b=EnPuo9t45YOpg2houW1O3P+5cj
	Oa5/y5gqDdlsI29/QvicDu+sq1a1kAjWd/pO86SbD48WnDA/8HIVGsl9EXXHfLWFdp9CwJwFG4Qr8
	+6oYo6XOt+LFGM3obSLddZ0sTmhSUXz8DSVMWD9Xb+M4wthF6nCYCRonSZIv7crMb57A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcVVJ-0099FA-T3; Wed, 24 Jun 2026 23:51:29 +0200
Date: Wed, 24 Jun 2026 23:51:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zinc Lim <limzhineng2@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	alexander.duyck@gmail.com, kernel-team@meta.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zinclim@meta.com
Subject: Re: [PATCH net] eth: fbnic: fix race between concurrent hwmon sensor
 reads
Message-ID: <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
References: <20260624200514.1332788-1-zinclim@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624200514.1332788-1-zinclim@meta.com>

On Wed, Jun 24, 2026 at 01:05:14PM -0700, Zinc Lim wrote:
> From: Zinc Lim <limzhineng2@gmail.com>
> 
> Reading an hwmon sensor

Since this is a hwmon related patch, it is a good idea to Cc: the
hwmon Maintainer.

I don't know hwmon too well, i've never had to look at locking, but...

static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
{
	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
	int ret;
	long t;

	guard(mutex)(&hwdev->lock);

	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
				     tdata->index, &t);

Could you explain why this lock in the hwmon core is not sufficient?
It could be i'm reading it wrong, but it looks like the lock is shared
by all hwmon instanced registered by a
hwmon_device_register_with_info() call.

	Andrew
