Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAB25F988
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262071; cv=none; b=XzuT00BEQ3aX5lPyqIFf5DT1XB6UaEapH83U1xjCDR4oQNQOIT5Jbn24qtcCbQrjk4OmdzE8NrXaGTuRvQ/0uJrixlZul2EuvWm/OCI39vqs1GADgHNvuTW+n+B8dteW+3Dy+bSLUX6gMELfV1ge7cx+/EvlbLMbRulCv6KWSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262071; c=relaxed/simple;
	bh=R1csfpNkuxC2RuQRLG+bQJki0XQQIjYFLhb3v6HXtjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsODoVbOT2ukolPnXNGJgJyshJuftX7f6rCZgT371RC4mwWj1aRHdl2PLgixWqRel9JjIjUyRq79bp71lRVDpJBEqBLOTGjmPPtzdmkdOw9yltfHi5Epb79rt/+GFtlUuxwLyu7urS5iykfa8yeFJQjPixQDjIsvmU+9RJCSHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZaDkdjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZaDkdjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D2C1F000E9;
	Thu, 20 Aug 2026 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262070;
	bh=5yI93gnwy7UKZyDGlar0JhbcT00ARq4NQYfFqw4pe3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eZaDkdjIgbImlfSGdajNMnma5g0sb+nBd+5zAYUIc5RMZ///1FP60XNlx7oHUbrNS
	 adLo94ieT3M9IR33igB6SRx38Got/VIhixM9eoTDRtvs7Z9qxspVKbKzujC/wAck5F
	 RX7CRKhE4nYR/gpG1dW/R3biiOOAGvDk1Oi0yRWl15CMH3Xi0YbTnKbGWo+59tvKMS
	 ToSTT4WpKfU4PTHldij0xTsNTivO1dW+l7OgqlYRCYJD1ZY0GtCMC1gLRw1xHin6BQ
	 ADOESE+u36WXJ6qxVswBZsXgv5BJXPdR+QgO00y2NgNl27EvSdHviXlQ112p9K9+g4
	 5gnMqTGXBYCNg==
Date: Thu, 20 Aug 2026 14:41:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <rafal.romanowski@intel.com>,
 <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, <marcin.szycik@linux.intel.com>,
 <anthony.l.nguyen@intel.com>, <horms@kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array
 overflow via proper realloc
Message-ID: <20260820144109.14e7777b@kernel.org>
In-Reply-To: <53c50cd8-edfa-4fe3-aec7-a6d66194e635@intel.com>
References: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
	<20260817205047.3612990-1-kuba@kernel.org>
	<53c50cd8-edfa-4fe3-aec7-a6d66194e635@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 12:52:39 +0200 Przemek Kitszel wrote:
> I see no point documenting such minor details in commit message.
> 
> As a whole, this patch trades a real bug - memory overwrite -  for
> a slightly different order of operations and slightly different
> failure point when there is no memory

My concern is that you're backing out of the promise not to turn
a fail in kmalloc() during ethtool -L into a broken interface.
Fix it right?
