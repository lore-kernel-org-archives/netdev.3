Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C08493632
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426849; cv=none; b=uWP6DAKlTjNds13DjUtrriki8YNU722VexJd6+mqkS6ztBA5h0q2Xzcq8QbKfHlGRJEB+RbYvFwSdikd52Ox5q82QZon326BGr0/UcxlvHKK3FvuBN8gH59RQFxWd7d8nqW/BdsUIRj8n9UZw7+qCSdFVszlfaxfT/OdKKLWmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426849; c=relaxed/simple;
	bh=Sfj+OWwIhuw2DNS2upVZG/n6S86vGwiJwH8bbSs6IOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p662Giyfvl6Bonjaw3GLvhtwBA7eNKQbw1Jssm0gzpHMt863QE6zk81/ntYinfOPFwaPhkzQJhEZVvzYtoKtQDHTFrkbYaoG0VHOnzQPmNst6cXPTxKyAr86dwtZhqBRzFdoHjCdA8v7UVCXFXTWiAlpi2q0ZT8xjBFmyv1+QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFKH0L/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFKH0L/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093E01F000E9;
	Sat, 22 Aug 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787426848;
	bh=Sfj+OWwIhuw2DNS2upVZG/n6S86vGwiJwH8bbSs6IOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FFKH0L/JH8NGSacA/mfb8mDixnuYIAP1iGHz+ajyRYwfpBbjzpqkaK/YCC4ntbT91
	 h2Qh4a6r3mnc0XIswOaHG3nvokknbe3DeZNb3p7QGiOrm7C9El+3zIoWGGu8QrKRpB
	 uk9/3YWYYPdUU1sSeReVT80ONZiTSOCAHVEEhZHnGPHEp5nXC1DmqzSBY3Btulemlx
	 pcjSHubRFAlbj4GagNhO4f72z3i8vk8/HDML/zMfrTZei3Wht85s40nAMzmzm80mB8
	 TjHpTUgZhhF7/DoEFjsCmCAimaHbtsEWOCzobikoPrKreDQ0eiG57yI9aSF9I5cv6X
	 Zz4JuVxu3sYNA==
Date: Sat, 22 Aug 2026 12:27:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, lorenzo@kernel.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 yangshiji66@outlook.com
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA
 mask
Message-ID: <20260822122727.4f437bb5@kernel.org>
In-Reply-To: <20260820085941.380401-1-pawlik.dan@gmail.com>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:59:40 +0200 Daniel Pawlik wrote:
> The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> leaving the streaming DMA mask at the bus default. On the non-coherent
> EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> after approximately 41 calls when using streaming DMA mappings.

Can you confirm if patch 2 is still needed after this fix?
