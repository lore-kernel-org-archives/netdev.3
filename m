Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA13E8337;
	Tue, 21 Jul 2026 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593166; cv=none; b=XFS4yIhfko/2Sa9nTuq+jaU98xHTr8OEdp2MURBO+BKhV4yHXCYnetOGaZ3T4ggtIURfEfNKBFKtEUUmQ39E0wfE1DXzJ2Etlc2LRb+RldpdabYu+SClCSIraHB+auTcpRS8hDQ0KUfztIWUt0mrsgQUpsbLfKpehncTTkPASq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593166; c=relaxed/simple;
	bh=x5LvYNanEuCGeWow8Ajdn53N9KgIH6oPuEFArgoQyDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO5jy4QyJd9uqS61QLcARpISCJBggG2KJqb5tNBiQaN4HSoc6nwmEHOMFneGJzWvOrEXU8fkuF3C6D9901ZPCRaB4eR5yZqjHg3N+9SYuJtH8PwUrP9N+xkfMW+JcxTBNw5neiTWxze+6+dvheIGwaQz15wjdnUUkcm8BvzKB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrHsut28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrHsut28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D301A1F000E9;
	Tue, 21 Jul 2026 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593165;
	bh=WOLkRRuA5gzv/smO14NEKyVxtmOigEeGMNU90PwI+xI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SrHsut283QOUxd84CEcwudlNyHl1PHEOHtVj7uju8hxJEU6hd/kuwWI2S8sq1EB7M
	 vg3hJ0KC9mT+pJbkaLcWvjkXBaAEcBv98Wlc6Pt12fLPZM/NEi2EiJQXYZIt8S6xTv
	 gHYsViDlKywBGUfKfd2P4Mci5k00Z8b0n2a8GSJ+1QeQAy25k83dtjvlqELgK9Bwme
	 ii2h42YjSWFqwU9BWi+tZiFeHTgVYamjcdtE0XRG9EIs39XEWUh7ySFCjE4C2JKzHf
	 6Ng/BZFglWHt8QoOpSVEYROa1p7MbLwkdwjzMm0WAkqd4bT7SfYKnvjuWDaz/bZkPh
	 GWpMIWKjAXDPQ==
Date: Mon, 20 Jul 2026 17:19:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xscale: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260720171923.2cebdeb4@kernel.org>
In-Reply-To: <20260704122722.5715-1-pengpeng@iscas.ac.cn>
References: <20260704122722.5715-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jul 2026 20:27:22 +0800 Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.

The last paragraph is phrased strangely. Please write it.

The usual phrase is something like

"Found by code inspection, I don't have access to this HW."
