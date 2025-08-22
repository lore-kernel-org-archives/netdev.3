Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAB7261E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826495; cv=none; b=d4Be6vZ1KeLD+PxLcAULWR8sHbQpFsJoAnzVUQcdpVtSZeujjv1bqNdb38C/aQHmTqaxZ01rMdcA8jG8u+6YnvXhunNwWigApD2W7bB568tvW+decfbpBHADkpTGrN84lg0+OhhRMcrrXq6WLctwawMpTMLvGh+OfvewGXRwmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826495; c=relaxed/simple;
	bh=wHqz9Wlbaf83KFOlw1iiLIpVVifApaYUExlNAiJWEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqVyCacssxyeKYJhCJHwJO34CC1tTlJVEd1AO+uUlHz73/e432nFTgcWrMAWwjBPah4OaNYlUpqOli6RAaBBQS+qRaBCmodLF3eXTbX46ApKWV6QKklt3FjbICS0hlG31ohXkF5unPEVZSMsPGRfs7guFwSmTVaKLL0c3yrE6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQjccp9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQjccp9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5ABC4CEEB;
	Fri, 22 Aug 2025 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755826494;
	bh=wHqz9Wlbaf83KFOlw1iiLIpVVifApaYUExlNAiJWEIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQjccp9xKj95HCaGjGGp1ZHlHJNZmyeuYOjvHWWIEZt6jk6Q/08/c5kSClzkOpD5i
	 OqcNYTMoCT7uZitvmp46UfY5J6OGfN1Oe10hqx3MCTnR22siIKXwJsVgZVbvDNUyC7
	 OiVmADEd7ejDBxFZ6ZKTGTJ4zr43U+WS3EPbV89hwXZ+2qoiBKlFhVshQypb9avmNV
	 oEVHJyXzrYOxLSCYrvQL1tEK1W8eKgOhmQr6vScb8MxkZIqnThdpfv2Mo6VbS6ifNE
	 p7aUWcZQJQ1G0FDCKl8/8GkE4qg/D/+u6oO/Onf/gFXkKoCR5Ojw0ZYVASO5UPfWty
	 EUn04eWFEg4xw==
Date: Thu, 21 Aug 2025 18:34:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <20250821183453.4136c5d3@kernel.org>
In-Reply-To: <20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
	<20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 14:21:07 +0200 Lorenzo Bianconi wrote:
> +	pdev = of_find_device_by_node(np);
> +

did you mean to put the of_node_put() here?

> +	if (!pdev) {
> +		dev_err(dev, "cannot find device node %s\n", np->name);
> +		of_node_put(np);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	of_node_put(np);
> +
> +	if (!try_module_get(THIS_MODULE)) {
> +		dev_err(dev, "failed to get the device driver module\n");
> +		goto error_pdev_put;
> +	}
