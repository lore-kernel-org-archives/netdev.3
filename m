Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317035C6AB;
	Wed, 22 Jul 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739508; cv=none; b=joyBgxXA4h38y9hBJ9Ir5ybjSmxo+wnAI2vAH1XOAMx5JijWu+KRJEnpOJF1A3K9QkXIXXe/k0Rx6CVy0/WO5tMS63BnNF1MkKZztCEfqU8fDjlbb1ywksA6a99tBkdyIW6i2+2OFNKJOKiKs81zkWZFsJhru1TltEcwOho7j3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739508; c=relaxed/simple;
	bh=OHVe7X3BrK0oqoxZUmLTDDBCgdrgkLz8kSoBbgSbESA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5jMvqDwVkWt5euAxb4YMGWb1XIhIDcK+tGIuK6suZsGEqsfAzOiXF07+AxfTNhNZ2tAd2mnglyHq0Wj/4egR2BB5QDoeguFqGT0DP0H3MA7+1+/w8eh0YNMdQ3B4aYzmwO1Aj5Q+Q73jh4SXMnzKkubS/BWZBJD+jLoP+zTw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIvDOIDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIvDOIDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000221F000E9;
	Wed, 22 Jul 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739507;
	bh=ORcTfzsf5GrCi9Q3hLpA456nnpz7dyxlllQU2fcWOxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hIvDOIDnWwEP+dvo1sTONdc2eh83tQFRowa8Kpg7NO7euoaj+d3n/4IcnopONuwmr
	 ujmTxmWdRvaUguSjaBdPp2ceuz3wha+Q0l6L6tynwbYefJZtwUEYhqpMBkEQl7Wfu+
	 FASTzDhcE1euJEorHfddcUJAljZXNkpwB/wZh4dUHcARozVrJL5UDz6G+ZHWFthDAK
	 435Gu3lvtci/RS4IQ4mnCWEVt2O6W8UhZYIbBlW0XsK+YBZp1gcGb/6mQF1zQz59Db
	 aMa7HAL31X5ju2qRnCRpXOrXdNpZK+QgD0cMDKKA6w6+9w+FxaTeXpdDBef2c1sac8
	 WVC8hjPd4TDeA==
Date: Wed, 22 Jul 2026 09:58:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Woojung
 Huh <woojung.huh@microchip.com>, Nick Child <nnac123@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Sabrina
 Dubroca <sd@queasysnail.net>, Arun Ramadoss <arun.ramadoss@microchip.com>,
 UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>, Willem
 de Bruijn <willemb@google.com>
Subject: Re: [PATCH net 0/3] net: don't read an unset MAC header on the
 raw/qdisc-bypass TX path
Message-ID: <20260722095826.1685b943@kernel.org>
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 21:40:07 +0200 Doruk Tan Ozturk wrote:
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path, skb->mac_header
> is left unset when ndo_start_xmit() runs, so eth_hdr(skb) resolves ~64KB out of
> bounds. Commit f5089008f90c ("macsec: don't read an unset MAC header in
> macsec_encrypt()") fixed one instance; these three are the same class in other
> TX/.xmit paths, each reading eth_hdr(skb)->h_dest. On TX the L2 header is at
> skb->data, so use skb_eth_hdr() (a no-op on normal TX where mac_header is set).
> 
> Found by static analysis (0sec); verified against source, not runtime-reproduced.
> Confirmed by an independent cross-check that mac_header is unset on the bypass
> path (__dev_direct_xmit does not reset it). More siblings exist (sja1105 shared
> TX/RX helper, atlantic PTP path) and will follow separately.

If there's one known source of such strange packets we generally try to
fix the problem at the source rather than hardening the whole stack
against bad packets.

Can we make SOCK_RAW + PACKET_QDISC_BYPASS set the header offset
instead? (If not the relevant analysis should be part of the cover
letter).
-- 
pw-bot: cr
