Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2621D5AF
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784711; cv=none; b=llMcy/MA9DrP2+Frvfzf3X+cWpnEcAAvAe0YW93PaItdaKAN0+auEL1NiPmetA6JptMmR8Evi2eS2sh7IJYYFDQX+nemS3WrtHD3o2GZnmBpGqEG+QgO0aVtd4RDzs6CLKWywFjIfL/qRbjLQtY8n0Z/ulUpMOA2BPUqvh/DOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784711; c=relaxed/simple;
	bh=rxX0q9ScIBLtPx4KfGDMuht8Mae2P7Js8yYa0Sa+ZnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/LgJwoFFr5MJM5yQWogDFr0gKMT6CpcCWh8exsPpU8CCdoWqmV1J5QwOVwlqY+NtFLUxEKEtESlESr8SQJhyPe9GfNRABd64jEykJFfw2e9mJnGfDpLyGjBftsjeMj/3CPpmjuOcesjrjlu9iFBTq9M1cJbwjPOrAE6mxHo8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UCQWkDmR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UCQWkDmR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pAmfNNGbi//TEODRGCt0VpY99Lq/fYqBA/ajxnJ70Bo=; b=UCQWkDmRmOmSkXQGKIF+6+M8JV
	3dZF4gnMiJFLael6fXgEt6WeV8kew4u7mzgjF4RfM3VpWac9BT3/rB4NUhg9TpkeOnG9AwLvAr3WF
	ec68DvoG0w+zvNTYUxSHdZUVzYTL/eDVqDoXaRkfxfKJ6yreQ/uz0zlnBVOHwy8cTw6g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFCrm-00Guok-Az; Tue, 21 Apr 2026 17:18:22 +0200
Date: Tue, 21 Apr 2026 17:18:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
	kexinsun@smail.nju.edu.cn, luka.gejak@linux.dev,
	Arvid.Brodin@xdin.com, m-karicheri2@ti.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <010f9f4c-c03c-4159-aa18-f55be8faf7b4@lunn.ch>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>

> +static unsigned int hsr_node_table_size = 1024;
> +module_param_named(node_table_size, hsr_node_table_size, uint, 0644);
> +MODULE_PARM_DESC(node_table_size,
> +		 "Maximum number of learned entries in each HSR/PRP node table (0 = unlimited)");
> +

Please don't use module parameters. Look at other parts of the network
stack where such limits are imposed. They all use sysctl values.

    Andrew

---
pw-bot: cr
