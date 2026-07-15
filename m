Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF942BC50;
	Wed, 15 Jul 2026 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073742; cv=none; b=ix2Sgx+sbVGPJ/RfAcCBcxUcbxqQ/UfDCD8f6e0JZ5uEzBKln5NgdWKOokrjV4epVMCsJ27tBgB4eKBdXqttkiRhOhjDPv4Fd0QHHcgCJRIvQJBn7+POctrMCmcHm2n01BVu+e+y0eRC9ZMOmmYNr9IUCOxwMM3DDwOM2Zdmu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073742; c=relaxed/simple;
	bh=TuProlNK/Uv3DE8FKBMfInHmc8gDxlSQsdyUlTsvyGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNkklN88oXG991lt8qJQlA602BFm5r20Fb/02zD1wxPZp+IfA2puvhr/9NqBMuIUyEXFaDyyhcYjqHX68Z0jvnIj6Fs4X5NBCQV7HNxoaY4H9G+jraEvtlvym271xqKPmEdroDdMxx2WODgyFWaZtOvX/xZtO7DP0w/5AH8R41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3R+jcue0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3R+jcue0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pTvkOjlns9RFkv0+vSukvxooP890RSLYU4Y9WY59W6I=; b=3R+jcue0ePU832L7UAHKfkc6po
	64iYXMvt4SOWi7sr2IkkXoTQQdEt8CLemAItqo8M18NVp99tIf/T73nbm3ksuv+/ITSet9mHP5jt/
	hdhayqXQzCSW7C0XotGiK2kVPyI8MKJNCcjP0CJY+oYmuJcqEOGFHFiMlnycmA3QcJYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjn4h-00CGm1-Mu; Wed, 15 Jul 2026 02:02:07 +0200
Date: Wed, 15 Jul 2026 02:02:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
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
Subject: Re: [PATCH net v3 3/3] net: dsa: mv88e6xxx: don't clip ATU Move
 ToPort delete sentinel
Message-ID: <b925cbe2-bb34-4f63-b4b2-657babdf63ed@lunn.ch>
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-3-9a8702b27ecc@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mv88e6x41-fixes-v3-3-9a8702b27ecc@padl.com>

On Wed, Jul 15, 2026 at 09:29:43AM +1000, Luke Howard wrote:
> mv88e6xxx_g1_atu_data_write() masked the port vector, which is correct
> for a load operation (where portvec is a bitmap) but wrong for a move,
> where the portvec encodes a ToPort/FromPort pair.
> 
> An all-ones ToPort value is the sentinel used to delete an entry. Chips
> with fewer than eight ports (e.g. 88E6141) clipped this value, turning a
> delete into a move (to port 3 on the 6141/6341). Other chips such as
> the 7-port 88E6352 were unaffected by chance.
> 
> Fix this by moving the mv88e6xxx_port_mask() mask into
> mv88e6xxx_g1_atu_loadpurge(), where the portvec always represents a
> bitmap; the move path then writes its ToPort/FromPort pair unmasked.
> 
> Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Luke Howard <lukeh@padl.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
