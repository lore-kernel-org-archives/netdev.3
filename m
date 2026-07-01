Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A7EEB3;
	Wed,  1 Jul 2026 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865330; cv=none; b=IMolk5xrdYmfXZUKuKD0orRSVx6swTnECl57grvICB3w9gfa9ZceXU+Ditvhz1HPKq//Y5zBpaZYtmVTFsnRIBdHNMAyREt5VpAJT2t0/Ia6aJPZVvjOsuYvth8YxYekZ8OqN9i0aLTS6NijmXb4m4kQ+1GSy6W/rd0X6hkr1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865330; c=relaxed/simple;
	bh=mMcchdAlNizDIwsEX0g6yqVDmYD8+EbSdd0zY93Oyko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9dtq+Up+jYDTNFB5cBq0O+E0VsxJ7OFjzzvSV6NkshJQWHqny1XGe/W3qRzfcgByfHQQmEzyeDxHeeqZNRxuZmRy9jn13bYyPcbpTt3wqtW2jVE4uPXbBvqf3bK68eE/otRNlwEo4TvvuL1kAMAVibwXrBuXCn9FHVx4rI8S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz+PeIS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz+PeIS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC91F000E9;
	Wed,  1 Jul 2026 00:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865328;
	bh=TNFRPzXso8ICJqumC1/giinDXhjIml62iLi01mXW94Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jz+PeIS9qJcT/vKWBLlHAbZMwtiFCKpo0Fjvz54AIZ5P/mdPWgAJKCd3dw69/9n9a
	 rpmRPNPSpyfcp4kHAHHe8MU/ciSvWLz03FyX6AQWpfUs4mhlKaUJgpViADnpYR16LW
	 6WbGIVSJqOPsrrd5aO1dtI5RCg8zMl5jjDt55zlAdS3OWa5PFfe+vRfj6AASfR3RCf
	 mrvrkdhkWLqVY/cQ250YyfywlUlAyp8UXIwppVq097xxNZUbnOQfZD5Z6PoJs5PnwZ
	 g320UgFBeqavlHPutxMaAnIRKDFamWVTEWOUATH5nehzkY0mYNdlwo+QrJyPdwNScS
	 Tx2ytJ4jlXhqA==
Date: Tue, 30 Jun 2026 17:22:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan
 <zilin@seu.edu.cn>, Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Marco Crivellari
 <marco.crivellari@suse.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/liquidio: drop cached VF pci_dev LUT and
 resolve VF for FLR on request
Message-ID: <20260630172207.0002f3e6@kernel.org>
In-Reply-To: <20260629141656.1769227-1-dbgh9129@gmail.com>
References: <20260629141656.1769227-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 10:16:56 -0400 Yuho Choi wrote:
> Xgene PCI probe by using port->dev->of_node directly.

sashiko points out that this is not part of this patch (or driver?)
-- 
pw-bot: cr
