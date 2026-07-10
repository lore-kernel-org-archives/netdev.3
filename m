Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E323C39A;
	Fri, 10 Jul 2026 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710190; cv=none; b=Xk+AvhZBDVhIRLnTi7dr5Xaj/Z1QW/iqZbwxdjZnIqlNJEwKOCf7mfOKVlUAyiq5NU6RC4nD+7xM4D1qGObt60uQ+hLO7lNuk1f3jQwE6veYrNanRdBgBScUS9tir7A9FirBiiBoigrf3fgqjGsd3+3SCzB906kdH7oAEQ2qTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710190; c=relaxed/simple;
	bh=0ZCWtiwbCYObNWqc1ISQHKxg4n/1ZqXRuQTiOOP/6G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsAFZ3x5Ro4pG5ly9l+RL3LmMRFvYrOVnanlNjqGpgvvsRROTQ3RSyABSCMsnNd5gRbsYW73iQu81DzCB087kUx/LcnXFzN/lwhUXn2gO4XN3OgpOrI/F4Meclr3w75YD6qZuA+iNYCD448F9r/yUQ/CxzifFX1CoUgzeOGRnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2yqzNXkg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2yqzNXkg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zmdAJBwKwQivqKeOB+8/J86pkL4UaeLbI9NcIRhX7l8=; b=2yqzNXkg0O//1fox9mp/J3ZVjw
	1CCxYUgwOMDnKK8Emz6izbi+dG5EfDg9HOwA8hlTDL0TUr2YK0ux624OguCqsdOM+TN1H54l4aMhm
	vNS+PCU31IKtgjFYRRY67VtIUaw1Idu7bM8G+NvvlXped6LL/nYNpgq+nQtYjjyf1V1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiGUt-00BgSb-8c; Fri, 10 Jul 2026 21:02:51 +0200
Date: Fri, 10 Jul 2026 21:02:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Luke Howard <lukeh@padl.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
Message-ID: <65e12726-2af4-42a0-9c49-fbf0d9909aaf@lunn.ch>
References: <20260710-mv88e6x41-fixes-v2-0-e23654c65aa0@padl.com>
 <20260710-mv88e6x41-fixes-v2-2-e23654c65aa0@padl.com>
 <da33e486-2f01-4077-af30-1dc53a6aa2bc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da33e486-2f01-4077-af30-1dc53a6aa2bc@gmail.com>

> If changing the algorithm at runtime isn't handled fully and the hw
> AFAIU gets out of sync (i.e. static entries get lost from hw, but
> retained in the linux bridge), maybe it would make sense to reject
> changing it while e.g. a bridge exist?

Does a bridge actually make a difference?

 * @DSA_CMD_FORWARD: This tag is used on all bulk traffic passing
 *     through the switch tree, including the flows that are directed
 *     towards the CPU. Its device/port tuple encodes the original
 *     source port on which the packet ingressed. It can also be used
 *     on transmit by the CPU to defer the forwarding decision to the
 *     hardware, based on the current config of PVT/VTU/ATU
 *     etc. Source address learning takes places if enabled on the
 *     receiving DSA/CPU port.

It seems to me, a port not in a bridge will still use the ATU. And you
can add multicast entries to the ATU without being in a bridge.

If you want to make it conditional, it probably needs to be all user
ports are admin down.

      Andrew

