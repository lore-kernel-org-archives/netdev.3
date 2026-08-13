Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72102415F34;
	Thu, 13 Aug 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786652725; cv=none; b=lOK62g3G3gKLxcs0rtXDlhVSE/eSO9cahSmFvCTOaN+SCn6mOsiDso33z+bPQX+9GuLv8U+apfIJZ/ZuVESXSqSn8FXDTfVh9OW0B906FtFtNzduQV+feFiDoFwUt86OvpAxz2Rs2clb3DJgHgkBDcqhR/PtmUseq5+EkezIGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786652725; c=relaxed/simple;
	bh=Be4ihjxyCZeutdFb5jBtm7jJLUzhE3EriDZcjev1esA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv4MDt6nB89lBE51Q+FTJqx+yZmd6J3MCdlgxDTRbI+s5MCyNCM3kOZTJK8C9dUJb1ejpidpE1Zt1zNFH55XpDNz3EfNjxnf/0ka0pQjCKNj579nN5PfBQEi0YrW/7eENGHR4pkVoSrTt8vHB1xivCGzKnUu53uGz6euv+h+XpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GN2EKfha; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GN2EKfha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R5Suj0VwqOlDmqLdrVVSNPEq5mL9U2cA2Q1KerY0kfo=; b=GN2EKfha0ctkY1NHEAf6OMGiSY
	JG01ENksObvgQ4z14Opbr+lQl/BIIo+7eVE2bmPGfCu02hwipWwMLZdsisIzKM/KsXm+k05iib2Pk
	XooBI2RtDxmvyPmHmfMBsk/k+kaX+X8Rd86bpu0cxzjfqzyMeVAKS92gWF8jQwY/M/Ns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wubzF-00HUMM-D1; Thu, 13 Aug 2026 22:25:13 +0200
Date: Thu, 13 Aug 2026 22:25:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ruoyu Wang <ruoyuw560@gmail.com>, netdev@vger.kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Message-ID: <9ee8e417-e626-45c3-8c4d-cd605123ff37@lunn.ch>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
 <4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>

> By the way you haven't CCed the Fixes commit author (me).

Hi Nikolay

./scripts/get_maintainer.pl drivers/net/bonding/bond_netlink.c
Jay Vosburgh <jv@jvosburgh.net> (maintainer:BONDING DRIVER)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:BONDING DRIVER)
linux-kernel@vger.kernel.org (open list)

You are not listed. Maybe you can submit a patch to MAINTAINERS?

    Andrew
