Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2932E6CC0
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983915; cv=none; b=NZoZVF7Lxy4f/FdJF/YsJ6HL9ULuZ7A0AajclvAD+iiKXHoCRUk6KKUXu/LX+BVvHjMtUqvgP7K+IsUZ1ddynfkCzs1s51r8TRTm+V5XlNndg0wDfgOasHv5SgmRPwHZhHXPoHO/3BpIl+TWgv3w7RYENv3P9h+oNGCJ5z34e3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983915; c=relaxed/simple;
	bh=by7va3kaAI1KZQ4FbkgtwgiL2v3fnfpRhdNDFF3Buy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpzQtImKdgTPV91ytxOzZLBNCMv6aPGI/VBAWBBeEnbBT0nduDq4Ud8y2Dn5Yq/3x3oulzdXAlAZz2+urdY0w2PxQM3vN3BXkJQNqTrXjd7yF+x8d4ZAgMBUuY/JMcqrJSqpkekmWensmp711H0Zy4UhSwXQGY8Hmhef0QcTW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYc/Zn1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYc/Zn1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B641F00A3A;
	Thu,  6 Aug 2026 02:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983914;
	bh=KoHgXbvL30Qgrmwk9JX+SdamFirx6sCrtr9gJ1smc8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZYc/Zn1lhVAXgs+g6nlR5jkiiCRnFcKtURnan7/7dYARPGyIIYXQnbyMTKIb7e4Ah
	 OXR44HMtLbJs1TbINMZXQVnKmQQBK2RFX40a/DooWOGy4DjoClV/cd/s8z9O+LRdD7
	 ehW2HeeAkCoqys8Z/Lmu/kmThxZBVb7FQgcT3X/6MSTN2DIH+smj7VCCzw4eUCnY64
	 OQTTHbv2q+dZWAkI70/43FsBtcdhd/Qu7/JGppncO7Di17ht4Sf10O6H8AYAQIcGUi
	 QoTlANCxiUlyx9MqprrkQLT6bBNAsI9NU1ifDhG7RNvjbICfoesaE+jJh1zIuBSNPE
	 pOaIGDwJPEh9A==
Date: Wed, 5 Aug 2026 19:38:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
 ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
 vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU
 values
Message-ID: <20260805193832.645bdb30@kernel.org>
In-Reply-To: <20260805224401.58791-1-mmc@linux.ibm.com>
References: <20260805224401.58791-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 15:43:55 -0700 Mingming Cao wrote:
> Subject: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU values

Warning: drivers/net/ethernet/ibm/ibmvnic.c:1031 No description found for return value of 'rx_pool_entries'


please DO NOT repost this until your previous series is reviewed and
merged. Please read:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
There aren't supposed to be more than 15 outstanding patches form one
person or company to one tree. We are flooded with AI-assisted code
so reviews are slow. Your place in review queue depends on your
credibility with the community so please help review other patches
or just wait your turn.
