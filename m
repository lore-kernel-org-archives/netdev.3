Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67037EFE1;
	Wed,  4 Mar 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657914; cv=none; b=r5f8mlwPTeSH8P8sroeiO+BHcRA7oCOB7az3m/KFa+kCsoZnA9veTfunV+YfbjaplRCuGcuaLAAZ/CuBVcXZAvGdv3iixyUspjAZzji0Bu/j2okENbI+x17gATlvAUVXWHokBPNedrTYXOQsXnvXg6kCLLvMeIHJ7SBkopLmJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657914; c=relaxed/simple;
	bh=wrHDuSd4kFUPU6TMVDFCdQCegEzwLz275EjghmodJYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUD8lC+yx62IVYHXg+qVzUFWnjOxkgScMH9xYh/ybd6YqZrtGy7ETU7KVh3P10qNGyNeFRRYDfIe6CjQOgSrHv3avlbziTXlANesTaV0sugkc9M7CGT5HTneeK/3xbuVgn08TrsyvqIZzcnErp6zmhCE1LCy8dwHvqFkbLb4dEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JjdlpkUH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JjdlpkUH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nJEhDLvUh+H18Fkmzg3CFif9ky3ccbPDC/ejtdiiJKY=; b=JjdlpkUHcTrQd+IgT8cRmCyU8V
	9XTH4ze8fSFJUfXx/QSPU5XgITc3DPwpdsSN0Q+rA2PZ1s4AL21O505m4aEEIobNeuN2dD+FGdOSV
	ffx2jzzabKJdug+Jqk3HDBCOTGCwjB0yjbaXha3Lu9cQcMkWsorYrMx0ExeQum+noiEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxtI5-00AAqo-JF; Wed, 04 Mar 2026 21:57:57 +0100
Date: Wed, 4 Mar 2026 21:57:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: spacemit: Remove unused buff_addr
 fields
Message-ID: <02bbff3d-1f27-4b03-a963-660bbb7facee@lunn.ch>
References: <20260303-k1-ethernet-more-fixes-v1-0-0ab0122fdd14@iscas.ac.cn>
 <20260303-k1-ethernet-more-fixes-v1-1-0ab0122fdd14@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-k1-ethernet-more-fixes-v1-1-0ab0122fdd14@iscas.ac.cn>

On Tue, Mar 03, 2026 at 05:24:18PM +0800, Vivian Wang wrote:
> These were never used. Just remove them.
> 
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")

If you are giving a Fixes: tag, please use the net tree, not net-next.

    Andrew

---
pw-bot: cr

