Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC8233933;
	Wed,  7 Oct 2026 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332848; cv=none; b=pKOOZlV6zkIpM5PpsBl3cnieASiYYVsOmOYDWJ6/enyTp2uiX8JZacGj0cc4qVITH973ZPFEVmRPObPsUjkR+AgTZXrWYMovLVnl3tA4HLebpfbMi+iCV9j1qPtZ+hS2WMHIYRd3gCNz+VZTpanWlbRYj6y+yylyLaI1F+YqUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332848; c=relaxed/simple;
	bh=mQMmFYPEoNYCERymqt5EaqVUK25g8kBj7yIMKj9ZaX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeM1ehT8trgpRcqXe3mXV+LupXVHyu9VGAEfSAQEN8JkiRzWZzIb+skadSo1/frL885w3aJZcufN6VPWop981rgqGE1/HuqVMvE13ACD9PbouMMVqF+ID1TP4ALLkfsuosOE7E4cHzYrY93uJorFoE9zJlVlUn1wtkjKpu6eufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkxXVctl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkxXVctl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868711F0089B;
	Wed,  7 Oct 2026 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791332846;
	bh=1tRPf4gAioqgLMgU7c6dHPz8m6V2TpPM9YEN1/v6sqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RkxXVctlleR061HBWfWht7a5j3oyrTArqmOMD4IwIDlxQnPZ0fZYp2hWg1GhMau0M
	 tOj/cOUOygQzsMZFnJ3yqtxjT49Ip2ZrZCt8LI8YTKh39vhXzpCbUFMiNIL3gP0tkA
	 WxtbFa1ToZRcwU2Vj8q02mf6v2UDHeOEmJu8SmZMXCEU6qsq9r/C+hye3KGNLMJ0+r
	 HYEdWk/RfCWEBKvaNhvIo90t6dGMeq1CxQcLYdSWDYrNsLMprTeusCcDqOwR/BsOEZ
	 hNihSg8sjm/ZaJFjjguCMPUCKzZ23qSVhcGEVdRKypV2fVMaeX4TvxJxlnXRnV81na
	 tvPAIUXwUh89g==
Date: Tue, 6 Oct 2026 17:27:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <han.junyang@zte.com.cn>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>, <han.chengfei@zte.com.cn>,
 <zhang.yanze@zte.com.cn>
Subject: Re: [PATCH net-next v4 1/3] dinghai: add firmware version check and
 RISC-V  readiness polling
Message-ID: <20261006172725.4c1e89d2@kernel.org>
In-Reply-To: <202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn>
References: <20260928202059763e9xqxhTwFe4DHa6a2wq0L@zte.com.cn>
	<202609282024273579VUWteKdnnbvWlyjERLQ-@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 20:24:27 +0800 (CST) han.junyang@zte.com.cn wrote:
> +struct zxdh_fw_compat {
> +	u8 module_id;
> +	u8 major;
> +	u8 fw_minor;
> +	u8 drv_minor;
> +	u16 patch;
> +	u16 rsv;
> +} __packed;

Why is this __packed? Please don't sprinkle packed annotations
unnecessarily, they lower code efficiency.

TBH the AI review for this patch looks like all false positives / nit
picks. We do trust PCIe devices a little. The AI review on patch 2
seems to have found real bugs.
