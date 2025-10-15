Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749182BDC13;
	Wed, 15 Oct 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544469; cv=none; b=rk2temOnZfkd8XjJfNJVQkfSoX5enkorDZDO5mOKGimHr0uZuQ8Vx0/A8+0qiqGFozpoOFBF5cCx7NpLbwt49zdu69Q6jEJG4ypouoXhlieHSEz/upSxHo6kt2Ib5M0twNYAQPgnQ/clzjmL/77eSdHN7FYhZsWdn3NU4OLPi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544469; c=relaxed/simple;
	bh=/xgC0Foj4sRECkkeujgbfojixypoYlfCwdvcLyXmOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upOOcsOl5CMkE0G0E9OlJxoiFuWSLYYKtSO6MuKrZNPvtLUupqy8/QZz0CXUQ2G+n9jhpr74cDgnVhIyuOORbsXk323yDDvgjr0hh20VhCC5CJJd6wWEEgI/yGqzQseG5MchKXhYu0MjWZQE23jgQj2W+C8ZwcruFZsP/4nCXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6ELbrhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6ELbrhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E877C4CEF8;
	Wed, 15 Oct 2025 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544467;
	bh=/xgC0Foj4sRECkkeujgbfojixypoYlfCwdvcLyXmOGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6ELbrhnqgx/bgNPJVFXQQnGtJXQNt64zVKMLbiQ1yDXdUH0v473aMU2NKwLUp3Q0
	 BW4Mz8sfSBfLQ/SkpimKPbwOS6GzekcSPu4zZ8UstXuwTEqXWrMVs1GxWzricTm9Q1
	 bCMyry0l022vMXY6zb1NF/R/ciexvFsNw2eWfqkr3QDb6lvEvctoBLR9tIMDpMQGse
	 3lJ+/f2jpl47KhA1jvDGM4oameGuRkJX5+2gX6m+SuAM3CM/hW302BQ460g5g/bEFZ
	 LLwFz7fG2roW/2HZ9QAHFIUV+sBlg7SKKsSA+c81WGVI96trF98K+29z4yYAjdwT1p
	 4KQTcUFi2qV4A==
Date: Wed, 15 Oct 2025 17:07:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] net: airoha: ppe: Remove
 airoha_ppe_is_enabled() where not necessary
Message-ID: <aO_GzldXUvN0gN5s@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-7-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-7-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:07AM +0200, Lorenzo Bianconi wrote:
> Now each PPE has always PPE_STATS_NUM_ENTRIES entries so we do not need
> to run airoha_ppe_is_enabled routine to check if the hash refers to
> PPE1 or PPE2.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

