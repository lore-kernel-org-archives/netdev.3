Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316525;
	b=Y1cjxiFbKneX15Nux/RXt0sNpcMWNbC0vzhvz7eLmTg3XBROy95gq3fjfdOP+iV2aRaF
	 hl/o9SFSI0btp00ZzOj6oxfi4pDRs/bMjzsDLylzh/YlxAMluGwoivBu6OqwUFSCRFObL
	 SaEoR/WWuo+qiOsBHyIn9xNh+mfrVQh7D/LMAz7fSVIirvR9jsfuzBZHTqG+8+2V6ESlF
	 dQleLFrsQ960dDbT4sPnX0Khdg5cRQ7DWxXWxRoEVytDwOXhqFEHU/H6LxUd7YskaJeQi
	 BQTBg00Iy6SaT3pQ8d6XXA2BhwsB4cl1pUaK52h7bkQb3jmf3v2iF3mbgt1cr1fiPsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316525;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=D15Eu+ajxeeIDXHCqmfCYpfdhqr+t0pJpZfF3KXQSIs=;
	b=sCHd4XS4fDHl6c3XEYzoZNaY35/dQYCe0ljBN8T80WzC/jY5eazVO3wSCuGG3RAJxU3q
	 0SX3jTRZ+n3pMtUDw8f2FJ0BXi/CD8dThnS8s64Zfgzwxs/nyfIHChEvVyKGjs9/5AGx7
	 tCTdchA0RhaOssyMzpxcYrkn8c+QkrmgJzbxMebAls5/Pgmlh5gVfSNpRUCH9RurXLlCf
	 sw0ZU3RQ1S5hNCGkQszWKroyhewXHA3AOx1YQIwttOjokBs75ZuLNdmeBff31aWGg65Ij
	 VfB7uXuOD80QgMR85VXoq37PCaAN1sZefr8OcuPVxJbL7zQ6uds7PNUX9A3BTQI6hxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PExuW3zb;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A96606A7F7;
	Tue, 10 Nov 2026 13:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A96606A7F7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PExuW3zb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=D15Eu+ajxeeIDXHCqmfCYpfdhqr+t0pJpZfF3KXQSIs=; b=PE
	xuW3zbf6G3AaxaJnxKPZYxEMTXpiW1ly2MvOY9Z077PKtNMIL53j0vEQnB1G1GeW3hh6AV/eFSUZK
	AGuq8B4o3bGCYOe5zHcyCuSzdDO5ck8L8XtCpm5Gg5lcZ+NR9XPKAV9B/t3pDakdvaAeWw1AbVCcn
	zEHNUn+IZJBwsIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQlh0-00FTzo-S4; Tue, 10 Nov 2026 14:15:18 +0100
Date: Tue, 10 Nov 2026 14:15:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes
 underflow
Message-ID: <60bec8d3-7a0f-45d4-bc6c-a43ce92d1884@lunn.ch>
References: <20261107015447.335056-1-mmyangfl@gmail.com>
 <91357461-8056-4b1d-a06e-6f1db5eeaaa4@lunn.ch>
 <CAAXyoMOwtQB01SFo+o2UPZZtw3Dhkpq94h8N55ZEas81z6VWUA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOwtQB01SFo+o2UPZZtw3Dhkpq94h8N55ZEas81z6VWUA@mail.gmail.com>

On Sun, Nov 08, 2026 at 02:07:34PM +0800, David Yang wrote:
> On Sun, Nov 8, 2026 at 1:26 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +     if (res) {
> > > +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> > > +                     port, res);
> >
> > Please don't break strings like that. The reason we allow lines with
> > strings to be longer than 80 is because somebody is likely to grep the
> > error message in the code to find out why it is being printed.
> >
> > grep -r "Failed to read stats for" is not going to match.
> >
> >     Andrew
> >
> > ---
> > pw-bot: cr
> 
> Hmm that would be more than a pure code movement...

True. So add a patch which glues this string, and any other broken
string, back together again.

	Andrew
