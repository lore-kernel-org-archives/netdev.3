Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE193054C7;
	Sat, 19 Sep 2026 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862077; cv=none; b=m1k/dBc2NWx1TO9hPh2MogyDh2Gf/WQ/4KY9XiQMc/AP10e/V0DmrGuMsGuOj6I+6PGMXUd5yGwA41HnNKIBWezdrtqviCY/+nkTbRlCo1tLyHX5rhtOVgpCqgQ9pFaJjvqAsxiGE8w0O6PrzPDXN4nWj4/MlDku7FMbJuAWzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862077; c=relaxed/simple;
	bh=n+mvTSngjPV9KcQ37XpKzmSreh/qs+ICkC3aMjlRzMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja4jMWWMX9ITNBOC8lzjhUwVmyGJuoJqfUm7Lu6UGdn1F/swYOmTrLmII73Q2FS4+q+IV7T+80jT/4kVEGRm3eNQJ/P0NqhONC252bJBj1gPNnhGzPHW9MdUU6fHBMwyZbcmav4LMOmD9KMgFibkH9e3bz6isdTwqjl2xKwGfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxhccjP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxhccjP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236B1F000FF;
	Sat, 19 Sep 2026 23:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862075;
	bh=W6XpYlqSAUDYu2tTQpZ6AxUTQ7zY6Z7lXw2iw401dcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KxhccjP0SC+YfGESK9r7B0FuJgV1ssSOv0COhgDFitbx5+kSAHQCGivmtCi241izf
	 2gPqGwkJFD3iis9udq3WWFNG4k4P0EzXVFAvFzZSs+JeXCQbbMipg1zPPQAc8C8Xy9
	 Ni4Sr4ogrjCESZmJOd/kSjiSvrO2frcHSZHKgF7iOrAXfOuxtDMR4qQJ7JuSazEL/l
	 YqaZ1wpr/Pwj62Ehq95XIH6W2xmmH7rrIUYt64I3+Nep2zkVbOadjl3OQXXWuW3zNY
	 w+8oN2kW7Zuvpng0pF4wyP+0siJSgM5EWsmQctmDLCTSeI26THuE8shxcQG3GbAarS
	 vKdpB9Ct8ePMg==
Date: Sat, 19 Sep 2026 16:54:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: jackbb_wu@compal.com, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
 <Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Robert Yu <robert_yu@compal.com>, Jeff Chang
 <Jeff_Chang@compal.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/6] net: wwan: t9xx: Add PCIe core
Message-ID: <20260919165434.08d026a8@kernel.org>
In-Reply-To: <20260914-t9xx_driver_v1-v8-1-5206c2e6bea0@compal.com>
References: <20260914-t9xx_driver_v1-v8-0-5206c2e6bea0@compal.com>
	<20260914-t9xx_driver_v1-v8-1-5206c2e6bea0@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 18:31:52 +0800 Jack Wu via B4 Relay wrote:
> +struct mtk_dev_ops {
> +	u32 (*get_dev_state)(struct mtk_md_dev *mdev);
> +	void (*ack_dev_state)(struct mtk_md_dev *mdev, u32 state);
> +	u32 (*get_dev_cfg)(struct mtk_md_dev *mdev);
> +	int (*register_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt,
> +				int (*evt_cb)(u32 status, void *data), void *data);
> +	void (*unregister_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*mask_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*unmask_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	void (*clear_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +	int (*send_dev_evt)(struct mtk_md_dev *mdev, u32 dev_evt);
> +};

Please remove the abstractions which are not necessary in the initial
version of the driver. If you have access to a good LLM these prompts
will probably do a better job preparing the patches than you:

https://github.com/kuba-moo/ai-prompts/blob/main/driver-upstreaming-prompts.md
