Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A79334692;
	Fri, 14 Aug 2026 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736013; cv=none; b=f2CLmCrS+p3kvo7/tBMeeuUq3PvD09ECmuxcdTzYI/Vitf5Jl8WhUDyK5hYGZKTn33TSPATkTaM5rTn/bSwYPbiom7CxekyoZselngavHObYdmjo18qM93yqsRF5tSKMnvBQOFtyfN+QGd5ALjo7d6izbyv83tT4cnIitjbN1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736013; c=relaxed/simple;
	bh=VPG7s1sxQsZEGDMc7AUsa1XlpNU6KxPpn3Ac6G3ico8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djZ5xFJmFUak9mNpSKPHa5YnbM1CErDw7+GdksOoIG0YdNFksBiYuk+k/Mm5e8aP5jgAi+sNkbHZAg1+cZNePiJ/yF72J6jvTrNFHXkn5uzLirts+WcgEUiES9X/pCc4/NTj/iDTFJLnWpVKNfFZcj0fhxkptkjDbC0YJ5STosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovD5fcJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovD5fcJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A21F000E9;
	Fri, 14 Aug 2026 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736012;
	bh=+NXDhoTASy1/bOHe9CIArTmuj8pK6MpVNrpjBWHd4jM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ovD5fcJeme1udsCqq6r1AW/HiOGlAvxm0X+71CNKo1its6PK05V0GuoDwcBGZEqrk
	 GASP0SDJit+I4vcsDt4BiypcuE/GkjubnCDj2zRJDpS40jVmDFlO5drED1QSzH/Dol
	 7peS1jR3Hnthg6zZ8Xuook4v2JvlxU7+Zo2IvwhLm+/qS7qcRoVOq6yZkk7zPODm67
	 SbiROoLwG1F19hH8n5sPJUJCHpgYVyouFSrPBTFZGwUpmvAAenIGGQ5bc9Gmi/UoKh
	 NQpFzIqnBsbyRoVjpGsWsJHXUtYoA1WSjSpCeyBsc7e9HzR9bmhMjNypQhw9pXza02
	 uYdU7FaG1iI/g==
Date: Fri, 14 Aug 2026 12:33:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v24 net-next 02/11] net/nebula-matrix: add core driver
 architecture and HW layer initialization
Message-ID: <20260814123330.4b8056f5@kernel.org>
In-Reply-To: <20260807044422.2356-3-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-1-illusion.wang@nebula-matrix.com>
	<20260807044422.2356-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 12:44:06 +0800 illusion.wang wrote:
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

Documentation says:

  dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64)

Please, don't error check this :/

> +	if (err) {
> +		dev_dbg(dev, "Configure DMA 64 bit mask failed, err = %d\n",
> +			err);
> +		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(dev,
> +				"Configure DMA 32 bit mask failed, err = %d\n",
> +				err);
> +			goto configure_dma_err;
