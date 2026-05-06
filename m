Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F036D9E7
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051373; cv=none; b=ge8Kud4vYwJZTXhryxpifwwcW2mNPHHv0P6FewpIKUD9INi/d4dVn6pWoF9LgLcmwOBMrJesN7KnWo1wG+3WpAMkqWWOeDJFmAvJI8vtk+fZPE+7yl3F3HO5nNTkmfhvg58bafbJcQH3h+/um15oFL7x+K1vkL2FbCwTs9cdg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051373; c=relaxed/simple;
	bh=ALyrwPv46yqKwQxyzn7gQrGA2L7qPbuGmptiwpmJlxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3tU2PnD7UcUfFhRQIl4rG5vkRk146BIP8X8tNZmVowRrtcFNsIlGiOJ4o97oD/1Rs3WT+XF6Uz2qdOColoNgOlkwsbQbmZnjQz1Qo6OF843rJJyR/iT0gen2fnJea6msHoXbP6MxCBivM31HXQTZoA2uzo8yE1xHhEDccLD9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjODiCD3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9BQ7h4e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjODiCD3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9BQ7h4e"
Date: Wed, 6 May 2026 09:09:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778051370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skBqPPEQBUoopL9X8YIMSeBd2bgYMsArj2N8aRsakek=;
	b=EjODiCD3qUEeWsXuhFCcRkTQ7JyALgwItDCVQJo4QoyCGO5smBjTXav84OpJYZIkEgsECx
	xpxuwantaOAI918cmaI2JU/gUaITkYJ4WSWexEP2p/iaFJu+6s6phmqyhoF9zzegzfmu7E
	SvvuWn4CF7pFlcT5sEyFOrLhWZI/WGa6iSN3dP9/7bnNthJNtGhgZyhUKCE9KhIvIYUQ5d
	iIqlEsu2oG4taCat3mHABGq9RzwFJRFq+gDCv7WhpL0XNS3zP+DzO4S+7ug7Uzywqeofah
	uYzVu0hZxrKBelmEAKHQoGzl2dJrBWZwxAe8s/2mccjd2DHZdGXUSG2b4jkqOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778051370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skBqPPEQBUoopL9X8YIMSeBd2bgYMsArj2N8aRsakek=;
	b=Q9BQ7h4eCyzzKm5ziOQwruW+dRpM0yCEDnqaMRJgCB9+H/ygaEkLQa6AJUH5+8zkx+ZVe5
	EYJIVTZS6zppijBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260506070928.hr8uavhJ@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
 <willemdebruijn.kernel.22897601ad5fe@gmail.com>
 <20260505095216.T02Z4R1T@linutronix.de>
 <willemdebruijn.kernel.8d257bcbe351@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.8d257bcbe351@gmail.com>

On 2026-05-05 12:14:58 [-0400], Willem de Bruijn wrote:
> > But I can't expect that the header is always there. A random ping/ arp
> > packet goes via the same flow. At the same time I don't want to make it
> > mandatory for all AF_PACKET users by checking the skb's socket.
> 
> I thought skb->protocol is the unambiguous signal whether this custom
> header is present?

No, I parse the header. As far as I can tell this set based on the
header bits from data passed to af_packet. Even if I could change this
to something else, these 16bit should better not collide with anything
else so I think used the eth-type and expecting nobody sending a PTP
packet is good.

Sebastian
