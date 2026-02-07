Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429951D7E5C;
	Sat,  7 Feb 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431091; cv=none; b=lRl315okCSgxhvDaI/8VSP5qD0rvVmwE0Wt0lztZUpkVUVGsbtH3kqOYb3uQUg8VVjh41+/sbwFW0tC0f8lT7cK0jcCZXgAvMVh8wPc4lYkMkkQk/7lnE672h/2sAm3yAT8JEa1/x2OHYMQ4pHSFN8CPYfwR5BoT2d6DbEi71Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431091; c=relaxed/simple;
	bh=f5yAONkNQzV2CW0gVHgwFjBZWGVy+XV9IW7vIKuLLCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB619vTvmVorhYWVZuMHdgXJ7Z+Y4Cb4gGOPPcg3ksCrE356+Iihh9M1eYIKIGLcmYoI5+yLdnvyHhDj7Dy3fKRe/YXeVgQUHB0KGaRF/7svY8+Vc72GCPV8+mTleFVKBUjm/P+lN1Bksx71nGdNIYDJx7QhNjlyGAAUmqDA99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFEGT9mo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFEGT9mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4D0C116C6;
	Sat,  7 Feb 2026 02:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770431091;
	bh=f5yAONkNQzV2CW0gVHgwFjBZWGVy+XV9IW7vIKuLLCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFEGT9mouxF2ieF886/7aYOxM6fFpgl8mQP2JMggadAwR9AwbjqxbSMKQE6ZEdn1V
	 gFMTdMCr2dC0kpmNyoRRWusyNqfMxJWyRWtVxOBBOsuJLdXI5j1HzqpnJY4QCFRtzz
	 WxLN3aDRxw8BY11QLoqh3o3zG0uO/jkFrTlWOkaJzPOHGaETUjRS/veM0yfVdjNmfH
	 FHOg75NecC6clKVSOX8tkvPsbxUBfuYNAwKDIYUMeX5mL5T2A6v0HVkZQOnn2mX0n4
	 fFCMGBgHZGyc4RYm4deX6lNq7HCmyy4IrTCg1n2/sfLgZusyyQymQonEY5nKGglElm
	 6k4Yq3BQ7ug8g==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam.chen@nebula-matrix.com,
	lukas.bulwahn@redhat.com,
	dimon.zhao@nebula-matrix.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org (open list),
	corbet@lwn.net,
	lorenzo@kernel.org,
	alvin.wang@nebula-matrix.com,
	andrew+netdev@lunn.ch,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Subject: Re: [v4,net-next,02/11] net/nebula-matrix: add our driver architecture
Date: Fri,  6 Feb 2026 18:24:47 -0800
Message-ID: <20260207022447.4017749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "This is an automated AI code reviewer, please treat what
it says with a grain of salt."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add our driver architecture

This commit introduces the nebula-matrix network driver architecture,
consisting of multiple layers: Device, Dispatch, Resource, Hardware,
Channel, and Common. The architecture is designed for code reusability
across multiple chip variants.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> +static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
> +			       struct nbl_init_param *param)
> +{

[ ... ]

> +	/*
> +	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
> +	 * is same with other PF.So hanle it special.
                                   ^^^^^

This isn't a bug, but there's a typo: "hanle" should be "handle".

> +	 */
