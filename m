Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C838E107
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096215; cv=none; b=C1P5PYFHLqxpuRhCUvfL4Tx14DsNI/5UNhHNRkpTjfiRJaapOCsc2vVoEIbRFERCmF8T+h1h8AQiB9WsTwl0MQVi4zmhWuNpUQtdRLNlTdBpTLmgRuMQ1mUPEYLI1I+4Q1Q72z6WS+kGc5r95EPFfrBhVx01RhFlFpyYEBr54+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096215; c=relaxed/simple;
	bh=GNjMrb+MoIZhVc42HxTFNyEub3JvaOvPVCCRnCaK4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kb40LjVE/HDT/CuhuFdZIjagh35JF4gr7mxUAky5P5bDE0xX3nTQvQoP6/YT2CLXsiyW0vcZ9vNeT83gnFUE+jttz/LYSWMn0SDNQYoj3lAcSUpQzFNp/6Th2ymbEHfNDzuofFuOMydxOG23w09c8DweKfVf/m8XXYEzvbVTsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDfI77Ob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDfI77Ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37295C116C6;
	Thu, 22 Jan 2026 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096214;
	bh=GNjMrb+MoIZhVc42HxTFNyEub3JvaOvPVCCRnCaK4LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDfI77Ob/9pILaxgURmZCtKCNjhC1b9v64FEki8zczP0UDl5fZzhZWZmdpA9dmEbW
	 BfP01KnjlLKwZSZj+J1OBFC8IYCNn2nLgvKwbihDjyhfqg0S3uffp6z7qXd0utyEhF
	 MXsEsN0FNnfoMoozjCeuXRWKaK0jQr3QO7WlGh8G4OEn3RWWlrqvx4EarVfrJ5ELg1
	 MrxwwsqbiaYk2LVZVL2IXCVCR52LpTFk3msRvniMdRKZjOf3qC8hD9EXe3+xsNLFjH
	 OuDY7EhVKf36mUWxYIH1ybEiphl83eMoF2EsxgtE/DeSjtdEJSVybyqwNOrW25cTYb
	 3CTzVovydyyNg==
Date: Thu, 22 Jan 2026 07:36:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <michael.chan@broadcom.com>, <sdf@fomichev.me>, <almasrymina@google.com>,
 <dtatulea@nvidia.com>, <asml.silence@gmail.com>, <dw@davidwei.uk>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 2/6] net: introduce a trivial
 netdev_queue_config()
Message-ID: <20260122073653.13dda331@kernel.org>
In-Reply-To: <20260122081240.GB1544331@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
	<20260122005113.2476634-3-kuba@kernel.org>
	<20260122081240.GB1544331@kernel-ep2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 13:42:40 +0530 Subbaraya Sundeep wrote:
> > +void netdev_queue_config(struct net_device *dev, int rxq,
> > +			 struct netdev_queue_config *qcfg);
> > +  
> Minor nit: make function name something like netdev_get_queue_config
> (to avoid same as struct name)

No.
