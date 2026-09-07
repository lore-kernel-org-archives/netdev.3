Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990065237AF;
	Mon,  7 Sep 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811278; cv=none; b=l5Qs0BpRrXHUqyUVjTFgN3yLOtTznyWd0T91R0TspmPJbagtQNM4YeG22f5IjgUPEu2b8mAynLXsffeRHyav3HpPmFNNxPcLhcfIhvU1osvbv7pvzgPsG5dnwE4cS0YF5CFNo3xnBe++tkoYTwhfAWJz4dJeN2E6Q8FJmcrX/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811278; c=relaxed/simple;
	bh=MpJKUnJpMGO352eMGsfL/0Ecgds2iKMNZvGGHt5XgSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/+TXKzl/joSiGp9fZ9pKBnY9Ec2n14/2+GL584fH1xGMw4RtNMQVnL4aFcwJ7uORxTeVuoQ9mFXZ/on/mOaeF4K8YW7Y86NvcKphPr3Fu2gozzbe4wKO/wfQRez/KqIweealu/KQLUKy1Dkf3RL8Mw0I724k+nSMoGua83iWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iVwqpB1l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iVwqpB1l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FzgFrQWO1QUDK3r6ambMlVVR44z9D1KAT4Qm5gREN1Q=; b=iVwqpB1l0gR4m7wdzYKtSs+JdQ
	6l5tOE+bshYIVvBFWD4bPJL8/OpDUhh87dZ8qH2/19DmW7ph0Rnx4KZoV0u5iIURVMdOrv/sfaTjD
	0OcSm0ppICALv+cD6CSK1snFyWdRiQUvooCjWM32D8FROUrRxSmHrhfLykP/prnFMqok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3fWf-003cdo-Hs; Mon, 07 Sep 2026 22:01:09 +0200
Date: Mon, 7 Sep 2026 22:01:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] net: dsa: motorcomm: Split MIB module
Message-ID: <64fec756-5b74-4815-8e6a-256d0e9268cb@lunn.ch>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
 <20260904162952.709368-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904162952.709368-4-mmyangfl@gmail.com>

On Sat, Sep 05, 2026 at 12:29:45AM +0800, David Yang wrote:
> yt922x is going to use a different MIB scheme, split it to reduce the
> length of chip.c.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
