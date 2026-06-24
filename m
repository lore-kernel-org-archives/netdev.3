Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6E1A5B8C;
	Wed, 24 Jun 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338177; cv=none; b=tYq4tjXEi7IRLWJEzo+zTBguanE13zRD7o1HRdOjUS02sIVyk6mrALJc6chEvZsiOcX6LRAMLOBkOgXpeghLoVobzYBJDKI0xlfVQHC3wd6gYi7KivPm8/2+DruciUPY/ygeKk78vAHAuotBaLXg/Q0KgVMvK215VhNQig52JrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338177; c=relaxed/simple;
	bh=LasahKFSXLBITBWRPsBXLd1ni40lQOnTMOoyA03O2Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Jqe8rVpdUu+WJQ0usLDlwq/O9yuaVH75mCaYH69uucYRXbt3P2KUhPSkOZAx43FLECh7JXid/5ZtvdU90xBkwBzG9z48YzqfJf51hehrD1sg+1Iu9eQXxXtZWYzW5TzIpMv7jhllLLBPbkqm0BUBXEerdOAucpfV978mljw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vXijjovM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vXijjovM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qSla3jeK98XNsFZZwT6BxJJ0v52d6+uUp75wrdA60zE=; b=vXijjovMNj8CzyxZ3IQloFgNnG
	AieQK3gqgHrnUz4YDQNpy8zZo0mFi2yZ5xG9qwYH3RnZHY98Lvz+gD2PIRomoMXxeII8jG0VwFVsu
	7EqGriay+Qj+GD3cycIIIf6NBhVriGqhd8dli/+/eB3Lg+F9YHSytffDPpDIgtarqaBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcVZo-0099J8-BJ; Wed, 24 Jun 2026 23:56:08 +0200
Date: Wed, 24 Jun 2026 23:56:08 +0200
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
Message-ID: <f2ecb668-ec56-4c84-ac97-474a2d761005@lunn.ch>
References: <20260624200514.1332788-1-zinclim@meta.com>
 <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0673af7d-51a6-484c-be38-3f46849ebb30@lunn.ch>

On Wed, Jun 24, 2026 at 11:51:29PM +0200, Andrew Lunn wrote:
> On Wed, Jun 24, 2026 at 01:05:14PM -0700, Zinc Lim wrote:
> > From: Zinc Lim <limzhineng2@gmail.com>
> > 
> > Reading an hwmon sensor
> 
> Since this is a hwmon related patch, it is a good idea to Cc: the
> hwmon Maintainer.
> 
> I don't know hwmon too well, i've never had to look at locking, but...
> 
> static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> {
> 	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
> 	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
> 	int ret;
> 	long t;
> 
> 	guard(mutex)(&hwdev->lock);
> 
> 	ret = hwdev->chip->ops->read(tdata->dev, hwmon_temp, hwmon_temp_input,
> 				     tdata->index, &t);
> 
> Could you explain why this lock in the hwmon core is not sufficient?
> It could be i'm reading it wrong, but it looks like the lock is shared
> by all hwmon instanced registered by a
> hwmon_device_register_with_info() call.

Documentation/hwmon/hwmon-kernel-api.rst 

When using ``[devm_]hwmon_device_register_with_info()`` to register the
hardware monitoring device, accesses using the associated access functions
are serialised by the hardware monitoring core. If a driver needs locking
for other functions such as interrupt handlers or for attributes which are
fully implemented in the driver, hwmon_lock() and hwmon_unlock() can be used
to ensure that calls to those functions are serialized.

	Andrew
