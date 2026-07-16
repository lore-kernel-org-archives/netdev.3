Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8D422550;
	Thu, 16 Jul 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209226; cv=none; b=IbSqP7fplWc8jDxcVmBpEN0Qy8JIG/92Qxqya5x5qsmTJ9uHYJ7iQDBbPX7dKr2UqcP4lQPPZh4R7OVyoumDDr6htsAsFleVhs9jNx0OlDTATuXX21mvuC6mKsamaC6kbqdbk4n+igNsjXMRuU7lGBuYIrY4cp9J2WgmVkGBAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209226; c=relaxed/simple;
	bh=PWBC/exfG2Ivb8wE2KHaXIOKDQcMexdnxxbsFGCIpxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOXY4r/3e2pQYeuQMExWUjQsEZ7KdDxu6jtQ7n2J/lc6E6lEx2B6CuWRQEP8saeOiLru2NVUCd2PT9UUazEyKSerEl/1XKJewmUUuD4S/mSpq/qj9hGf+bdz+OLoZ20w5iCAlv7rSDUVq2leAR/m0peKDfcaS9r1HbLWDM7sGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=STgyyqej; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="STgyyqej"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5clbNR+QM3hn7vlRC6uI8yNfcKOuS6wt4+ho+d1KBsk=; b=STgyyqejNeD79y3Lxd+bvljCWY
	b47nW9YSlwwCO92iwtFKkh+DCTNIcyuCntySn9UGgJo4ZfVvR1iEV6ONELGIdFOIR0AkhdDk7ajur
	283a0WJflkYD7+x/lcRlw0Tn2uxqUPVggvWREN6K0+g5aDJyGhCV/w2FJZirw7KplaQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkMJt-00CXTh-T1; Thu, 16 Jul 2026 15:40:09 +0200
Date: Thu, 16 Jul 2026 15:40:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minhong He <heminhong@kylinos.cn>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	remi.denis-courmont@nokia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phonet: check register_netdevice_notifier() error
 in phonet_device_init()
Message-ID: <7ebfbaee-fd9f-4376-b8ad-a28f34de8f24@lunn.ch>
References: <20260716101504.158387-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716101504.158387-1-heminhong@kylinos.cn>

On Thu, Jul 16, 2026 at 06:15:04PM +0800, Minhong He wrote:
> phonet_device_init() registers a netdevice notifier before calling
> phonet_netlink_register(), but does not check whether notifier
> registration succeeded. On failure, netlink setup still proceeds and
> init may return success without the notifier in place.
> 
> Check the notifier registration error and unwind only the resources
> that were already registered (proc entry and pernet), without calling
> unregister_netdevice_notifier() for a notifier that was never
> registered.

It is a good idea to look around, and see if the same sort of bug
appears again. Think about what happens when phonet_netlink_register()
fails.

> Fixes: f8ff60283de2 ("Phonet: network device and address handling")

Does this bother people

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

    Andrew

---
pw-bot: cr
