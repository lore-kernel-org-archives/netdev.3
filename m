Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905C23183F
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891635; cv=none; b=P77F/G+mXOygy0BGq3isjlrXPIAQGAglTjzX4wLR9HwRtQp/S085xK7WFzUhBOsJ2p6Mqtb0UB9l3XVzVMx7rRcP00nA8zoLAeZSuAZnpSkqKgdVZYqeXkCFLF8IBH2It3mvPMz11RNTjR0y9BEOtsGDgb0LFpjZXjr8X36wlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891635; c=relaxed/simple;
	bh=Jzg7GTBxBh8XOQnVBxb1qxVcdhURobx+TaYub1coe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/XBYUv55Ulc6etD6Tj5kQ7S1Nu1V/VIzhKkJpQXCv5v0bWNBVcdR4XyfuidlM3rKnga3OCposK/jIhSMiMsgk+48hxY2zR9ONDbaMVzlDyUt7NnbPMV8KfMFn3JrnorlXVhl8nCbzzXZdoTalv2kh5Is3KIl019T+VbIq3tUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U75nV+un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U75nV+un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C56BC2BCB0;
	Sat, 16 May 2026 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891635;
	bh=Jzg7GTBxBh8XOQnVBxb1qxVcdhURobx+TaYub1coe4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U75nV+un5haj4K+0xSnIGcYFUDSCkkQGBGvbD5j62g+VQD3ekWgiBKv3mZsSSVEsA
	 aI4NZSgc9F9SzCWgyO2wXON53YiUU5u55DENG3+ArJFxqmaPnDp32hI16fGjxGcAA/
	 DlyCrImRHQvKAEi35OZobZdXo+26jfjxiXIfqgZwfdHb/6zS2UQ6kQhB425yghNIxz
	 kWmXSpaMuQFXdKgE1qcz4gmRtbkbIxG3/hOFWE/adDoZn1Bk95VVM514mts2oaqIdD
	 RDG/mFF0MF0ijYVdie0Un3icWt37Co2X4HpCoTZLHj+l4koioX+C+j1vSyEEJ/o7Lg
	 e3nWkSZfF8qnQ==
Date: Fri, 15 May 2026 17:33:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luka.gejak@linux.dev
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, fmaurer@redhat.com
Subject: Re: [PATCH net-next v6 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <20260515173354.70d9db10@kernel.org>
In-Reply-To: <20260513182657.20346-2-luka.gejak@linux.dev>
References: <20260513182657.20346-1-luka.gejak@linux.dev>
	<20260513182657.20346-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 20:26:56 +0200 luka.gejak@linux.dev wrote:
> @@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  
>  		/* make sure another tlv follows */
>  		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> -		if (!pskb_may_pull(skb, total_length))
> +		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
>  			return false;

pskb_may_pull() changes should go to net?
Someone sending truncated frame may cause an OOB access and crash?

> @@ -110,7 +110,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
>  	}
>  
>  	/* end of tlvs must follow at the end */
> -	if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> +	if (hsr_sup_tlv->HSR_TLV_type != HSR_TLV_EOT ||
>  	    hsr_sup_tlv->HSR_TLV_length != 0)
>  		return false;

And this chunk can go to net-next.

I'll apply patch 2 already, looks uncontroversial
