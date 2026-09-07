Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA1525A7F;
	Mon,  7 Sep 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810984; cv=none; b=Xm4BNL/Hnw5VgsmswNZhtTpyO1FNOP1tZ33GMTsBtPQ06lXalKkscgR3ktR0P+apH5HYwPRTrFnrknXKJs6AKZObiUaqLOya1uml2clcdtiqbeV61iW2HtbDpHwgV/TaQ39DC6W94qhG04p/SSHgAp+bslsz2iOiDPS3dBoZzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810984; c=relaxed/simple;
	bh=dpLJTD0ulS67m9Wlsx6gXxyMvrHBlwpS9Myge1UGs6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGd79ATdYsDeQMFtNWirgYZaM1Ttx0yDPIUd5EhV7bpncxyDyshVR9XlDxnsQro/CEkv3pXevc/pQLB0l7CjWSWF4FKL1eKO9J/mb8c5O9xtzQHhMisWat4zgQpK5bYpFr36p2ZBqRyFBSiaroHaF5wOiBmZqXwOqKUuN0mGWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4WT8lyQX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4WT8lyQX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u3PebQQH89K9sJyCI/oeC9tMmRauFJqG/ZCBCEcaQ6U=; b=4WT8lyQX3UxBmTS6jqGGZG4MMR
	Y3TnjCKUUXrQNSNtrBR+wHZVimf2DOoynotPPf1bHrfayik287ytcWmm+A2Mhn4x5TEnwDEvkJF6q
	eDvpGa8619gSTreYzHJ/C379ubm07BXnnbl1UhaAkGXpRGy8swnpxjOb4EIMcHKhksgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3fRu-003cYd-Cp; Mon, 07 Sep 2026 21:56:14 +0200
Date: Mon, 7 Sep 2026 21:56:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] net: dsa: motorcomm: Rename MIB stuffs
Message-ID: <512aba3c-10d9-4796-95c4-d481b14652b0@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-2-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:43AM +0800, David Yang wrote:
> Rename them in preparation of major MIB refactor.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
