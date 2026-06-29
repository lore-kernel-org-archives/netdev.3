Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FC379966;
	Mon, 29 Jun 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742276; cv=none; b=Ny+a7rqqdXcbdy6n0X/gf8+n9ZaK3G3CNakY5u7mhbmB60fta/f+YaXkdILDi9eZqyzwatpHMYkpphtLxc9fmh3aB1rX6qmQ1ji4yvmRN4YErik3sb4UThedETE8IodOXFRZGaTbAjDTk7SaWrJZyw80UKD3y8k8JGGvsttHozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742276; c=relaxed/simple;
	bh=w3Rk58VFHsHRk8+/VRDIy/78iRnDfVByA+Q+K0PFJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5qG+Y4r40CCl6UqvVRHGt1mNm7qUEty6uMzQGPQyb2HhI7FdelXAeH0FpZ1av21R9BKKL0BZgPYyUvSMkWqB+CIAePYd6qL4+ZP1TIsxhRltA2P+r+5z/Aq5eNbXrm6jIuEb4A+GomYNDaaikh4KrvMIEpdS09FiR6m5IuAkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ba9IDNG5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ba9IDNG5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ljs7RGaTifxfFw5bn73caHjn9tTVbQSLKh5eLK8il9o=; b=ba9IDNG5qaNFbWiu8XAchmSY7m
	H6B6cvKMhQWm/IMhepYGlwO/sminRwaTuwNC8KnxE/eQq9T2JAkYRli3bDTmSTZlGpakGnAx2jn8K
	rpI80xwM6ZaTeTrrSNeZf5BpQdHsMauMtaeRbYFLZK+927daMOnNxGnPZlJide3yZp3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weChI-009las-3j; Mon, 29 Jun 2026 16:10:52 +0200
Date: Mon, 29 Jun 2026 16:10:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>,
	Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [External Mail] Re: [PATCH v3 2/7] net: wwan: t9xx: Add control
 plane transaction layer
Message-ID: <92b1e341-31a1-4f60-80d5-ccf8f742a38a@lunn.ch>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>
 <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
 <49939d4d682f4c1fb359973ea2cdbd00@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49939d4d682f4c1fb359973ea2cdbd00@compal.com>

> > > -	devm_kfree(dev, mdev);
> > > +	mtk_dev_free(mdev);
> >
> > Why are you removing devm_ calls?
> 
> mtk_dev_alloc/mtk_dev_free are paired wrappers so the caller
> doesn't need to know the underlying allocation mechanism.
> The devm_kfree is still called inside mtk_dev_free.

Two different issues here:

1) If you don't want to use devm_, don't use devm_ from the
beginning. A patch should not change how a previous patch works, since
you are wasting reviewer time reviewing code which you later change.

2) Do you understand what devm_ actually does? Since you use
devm_free() i don't think you actually understand what devm_ is all
about.

	Andrew
