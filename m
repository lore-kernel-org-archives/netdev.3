Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFD18C2C;
	Thu, 30 Apr 2026 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508029; cv=none; b=GpIkUQvbT08P3Czhy2v7Q9D1pydvfwr1/stDFJXa6iQXFYnX1+IdtlPlbXARm23FoehhxSyJ96PjZ4GLVwh4e07wIkDcjokcGZoF4fWLIPPoNUh5UH6KozRp93FoPJoROcs0BejxyoenbFFjLyk/3ZLpQlwOu/BSE/d+FM6VLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508029; c=relaxed/simple;
	bh=fQhlf4FVXz8jqrxUfUCR7CcIhP9nCMAq8KesLC6HqCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzGslI9wUXKLVoQzvRBfHWm2Bl+3e7a4nh3hxHrwJrgWg7FauVtdq2Gtaolp1BQS7OOdNgg0b1pojQQ3n/Lq5wJDeQ+Qimifyu35lJoKdFK+56glJXaqPussWxjOQJwLo+GvSV16JsWGVRA4hDAcXQjtHFInRroxdJEHZDHgPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5PyDpKwy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5PyDpKwy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=icHsd1TlftPaJ6j5j1qmW4lXPQP4Ynfc2dJNOWPkDRc=; b=5PyDpKwyDJg0/Vcl2JJqPdv68b
	7mCT6ojdSToaLxVm1u96oyCfiHQVEkFS0Q3Tb6nZwGt/7FZWb8dPNrtLV4IpmU6woZsx6DxFiJ810
	erRRmoksoZl+QP+eY6C3aQwEnfyHtgA9fLV2fOUhW6vACPeZzQ2dY+itCnQWAMs7Nseg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIF28-000bEJ-Uj; Thu, 30 Apr 2026 02:13:36 +0200
Date: Thu, 30 Apr 2026 02:13:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, chester.a.unal@arinc9.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <e06bee51-561e-4405-b3b2-a5d672d8e8b0@lunn.ch>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
 <20260429234612.2240476-2-kuba@kernel.org>
 <afKaVQ27GUQiWZTb@makrotopia.org>
 <20260429171124.07787599@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429171124.07787599@kernel.org>

> Not sure how much of the D in DSA is actually implemented but in terms
> of fix why not do what the bot suggests?

As far as i know, this device is not D in DSA capable.

   Andrew
