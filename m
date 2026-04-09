Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8F1D5CD1
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702301; cv=none; b=K6zFfCqQ/gf+WrDJXw2/OMub+3zPXbbvEKoJWl+S3iO3PiqAAaE+m+dGBoS/TPD/Nb1KTCgOuRwVZ+6OJsTS6feNsM0p+1TSvbPlNpUu8+Ccwv4uVxSQUq9tEr2EUXRon/IWwKcD5p+bmsaS02W5USjk3BqnKzb/HJFIQbBSGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702301; c=relaxed/simple;
	bh=XbvmYxYToqOM+Ve4KTW+qEPJth2RCNBiqg1hn8bMxqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB4NtLMtSpNvhRYlZ//4oL1sytaK0ij6N/pCS+VV3flSdwE7wpgNzp/zfjpfduCsbeOGZ7fOXKwdmouy+ImbISpADIaPX3VbdQyke/BpGe6+6EB5iyROl26BB7ZHQyZc3SXlER+nLP9aO/0MuAsCgxjDCgIyL0mtYNy6sS9oPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liPC04BF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liPC04BF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88793C19421;
	Thu,  9 Apr 2026 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702300;
	bh=XbvmYxYToqOM+Ve4KTW+qEPJth2RCNBiqg1hn8bMxqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=liPC04BFK8CxlL1psh4kemN3baKgd6BtQcJXqKqJzm4pSgK8MT+pZ8UplZM/s9Jg8
	 nKmfPib8Lv88EBWgnADj8xA0CdLX67C8r9UhFjd49DVLmhp2IIxnISAST3ZfF3mIxV
	 vMskZTUc+5uU/1hnsrfW228qp43fH5Z8eN9EUzlXVk9dN63VsAfeBKXkd3SZ7SyipX
	 HKNaltxvS3B+EvSr0jnWm4STR2GCnYE0ziqy9vrwN4tga/5NTW6Hg5Ff9HHG2l1z4B
	 Hvx+tlzIG0LC39maYkipaQyXCU04A342cncX3UeFkXJHIxzJS1mqv8co2GpTvwLEAX
	 VeXUVxKvUoQRg==
Date: Wed, 8 Apr 2026 19:38:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 1/4] net: dsa: remove struct platform_data
Message-ID: <20260408193819.11be1526@kernel.org>
In-Reply-To: <20260406212158.721806-2-vladimir.oltean@nxp.com>
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
	<20260406212158.721806-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 00:21:55 +0300 Vladimir Oltean wrote:
>  - ``dsa_switch_tree``: structure assigned to the conduit network device under
>    ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
>    the tagging protocol supported by the switch tree, and which receive/transmit

AIs point out struct dsa_switch_tree still contains a pointer to struct
dsa_platform_data and the doc above mentions it. Please follow up.
