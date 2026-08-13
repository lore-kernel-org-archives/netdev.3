Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E79489892;
	Thu, 13 Aug 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634475; cv=none; b=TKYSPfHU0/6+wl7ZW7c/dqcuEjMhThRoSmse0twTAx/gQ88dzdSmpkp6Uak34Wvrjscl2pyS0dBmxZw4Ke2LzeSl21fjd0MH1st/uFouMdK6B8s/1wAUFAJLEmvZeFPGLDrSWc0XVTHgx5HHa662s9hw88zQIt30P0tRGqWxO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634475; c=relaxed/simple;
	bh=kMMHpfRXNgRACS1q4NWmG8XEKMop1mm7uGaSriEt0b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0LwHu43wmthk6aIWpyuWHevx1RG5XCSYVZ4lSjIwoTLIUheNkkP5UcPH0Ytet8Mx6Vkx6IUo2MGwrEHhpKvO5lA0CUvWUPYUASla4likHW9D2oZ2TpHCbmDU7hwLchHxU/6SLe4v/3W0tbfrxa0/+Ul0jEGDHgCF2hHwA4HyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4VNoT6kt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4VNoT6kt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aVTkzFudckr5PePeOgZQceV66DyPfbtTZKWYK735g40=; b=4VNoT6ktBhbKvDSRPo3qBdFiSi
	EGXLV0HLwb0qYXu0xfgdWp54n20R/Aysu3I2ESRiTSRJ3JeklenFu7Ek7/baWt4ncHAHsCsepUaBu
	PLLN+aW8nYCbgT6S7eyDO0PgyKfUM8omPFvDeZ/8FtnkdKOMKQ3E3BRkAbNuMhLjf3W0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuXF1-00HRuw-0d; Thu, 13 Aug 2026 17:21:11 +0200
Date: Thu, 13 Aug 2026 17:21:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Message-ID: <5515f232-faf8-4390-9bc8-165984a6f1e4@lunn.ch>
References: <20260813111121.1672-1-manushprajwal555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813111121.1672-1-manushprajwal555@gmail.com>

On Thu, Aug 13, 2026 at 04:41:21PM +0530, Manush Prajwal wrote:
> On an of_property_read_u32() failure, rswitch_get_port_node() sets
> port to NULL and jumps to the out label before releasing the
> reference the for_each_available_child_of_node()

Looks like another place where _scoped would work.

      Andrew
