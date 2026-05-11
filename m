Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE74D2ECA;
	Mon, 11 May 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527534; cv=none; b=tJUEznlB6h6P1ZeUlHNHgH5QKCvTkfOo7glG1yorUSYPBHmTP0S9c9yfCa7GJ/HUKKtpUZ7tgxpU+tiob4K52BFU1fdL4FQ+iZE7kIHYyn8eiG1BfbEb9K75MzY8R8of6s6GvHvxyJgcEqURAbkxEC7bLRGtYMFfFb7DQ6eq9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527534; c=relaxed/simple;
	bh=/TxxhLguIMMJw61FkbCd9BRPyHsWolTUNb6Z9H5NEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+VORJ6ZB0Em3yXE5jyRYZqeBP8P7pGCROBnfO/q42WJxB2cLxTwyeSZoVZwhg4rtVnvFS9XYmiz4F9S3irSuqxpJg8yzkmOeEXz6Yryqti1qVKr+DJWnVGCs/a8mABno0Mev97LgoU0LjLlvVbrbV5uJYSAY3ZMrOmvkpY1oNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Uj8GcJyj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Uj8GcJyj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nJ2FXSPqoiFHz8HJdZG0Vz82Ls7wfjaEAx8to7uPAWU=; b=Uj8GcJyjGEPqEw7eN4Q6JPFXWj
	+hy+kFC8u3QxDQ/7fmMBhOOkih+8HopcLCQfET9S3kBehLCMVo92L7iAkSIsQtXA9V0GLqXCdjHAp
	nNmDrGP5/ggMmFhBkCaEfd4sCs4MdVKTA7pVbEPgGxJIEnjQRjaxhY3hk1XJegF4BtFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWFm-002Qfw-Ug; Mon, 11 May 2026 21:25:22 +0200
Date: Mon, 11 May 2026 21:25:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Message-ID: <b6af67df-1217-411c-ad47-f9c3e556d345@lunn.ch>
References: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>

> @@ -163,7 +166,7 @@ static int ncn26000_config_intr(struct phy_device *phydev)
>  }
>  
>  /* Directly accessing via Clause 45 read avoids the extra
> - * SPI accesses required by indirect access.
> + * SPI transactions required by indirect access.
>   */

Please don't change things you added in the previous patch.

	Andrew
