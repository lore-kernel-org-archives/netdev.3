Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925F39E9B0;
	Thu,  2 Jul 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998272; cv=none; b=Q07ZJejuhM6WJvXF7klZrzHGe6gDF/JX/DKkHr9x93/UrySN32H9Ui5pfsnsJijYobPjeseE2HYZ82AiLbYBOMLp/XHkjjjwhdllKugr+rRv9qOC9fFXGIdQX15M0M1Wuk/RbpHCddPabCrDB71hcIjcJl7Q/MeVYEnmXj+zzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998272; c=relaxed/simple;
	bh=//D3uZfTEdwmfAVlWaaXFjUGMJyonaRFXbBx+eXZKZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUdlFyDRdH8GAPtgXYP5Ww2RJQmuoJTUFjj2ys5j9GUQcZgXbv2vU4xD5/xLleQlLCPuiL/nHLJhxS5t+4jUwYXqlfg4ETCN0jDUcQrWODMM7JWbEnD7WjnYtDOHOD8PjPn/bFunBAO3+lvu5qH+Cpg5gfzlvZbxJeEbhM5rxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hz0z6wqw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hz0z6wqw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SMqwiBjsY811wsdhvrMKy4I/6nVJL+QwyBvMLtPCIa0=; b=hz0z6wqwjfes3BE50Xqto7zsNL
	9eVqpXP/xwtLZ115zutnnXHtn1IIhPGlpCdXwVzOuERWVewx3WLOOLC3DtMaFCaHUGSrgwqHIL6wS
	1Ub2iKLLM8VjFXFfAhXU7ogEuMLDtk0Q9ziEQjwCJEKijQYMU9FOJl3ABt7/jIsyvdog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfHHv-00ANFi-8x; Thu, 02 Jul 2026 15:17:07 +0200
Date: Thu, 2 Jul 2026 15:17:07 +0200
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
Message-ID: <1e75c090-f4aa-4a02-82f5-fd4f3854acbe@lunn.ch>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
 <20260624-t9xx_driver_v1-v3-2-73ff03f60c48@compal.com>
 <2a90ae6b-2b6d-4340-b557-915252cc3488@lunn.ch>
 <49939d4d682f4c1fb359973ea2cdbd00@compal.com>
 <92b1e341-31a1-4f60-80d5-ccf8f742a38a@lunn.ch>
 <4ec081f8df234cc584702abc67213965@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec081f8df234cc584702abc67213965@compal.com>

> We will also remove all unnecessary devm_kfree() calls from probe
> error paths and remove paths, keeping them only where resources
> are freed and re-allocated at runtime (e.g., CLDMA queue lifecycle
> during modem reset cycles).

There is no point using devm_ if you are going to manually manage
their release. Anything which has a shorter lifetime than the device
should use kzalloc()/kfree().

       Andrew
