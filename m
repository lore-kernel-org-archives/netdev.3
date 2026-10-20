Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458729;
	b=fewvH25AUn/LlJvSNB04VyE0lttj9enM5MR5jSjEn1CqN+4d7LYUXDBZS/vJ8sGRtMPe
	 QXizmUslYQkvLW/VYaQqthm10T0XmLoaFDDk+1CX57KsTqFon/Cp13JXl/FEv2kfqk7Sq
	 rCjipiVM0v99IHdHe9+L3HlSlgkBd8lr7q58ONpiEx8jDzr/JUds/mYKS+nGBFw4Dtxbp
	 +2xoulKgLTmG/cXBjce1evHBEEFNMEejBG/PqaKuC7XJtYdGXnMpJLL0kYlLlnHYVphq2
	 Rx8ysR4FfeSNt40KSrBOJsVKGL1dR9S+BB7Fxmu/y5ptgpaXxZV3PeT4CCEy99jydfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hph8D+eMCYs3gyzRE67O+LWduMA4HXKPhpMpMk4l+EU=;
	b=cCraYSN/MY0p3GLffK8CJltV7WSQWGem6mc62SN+YRV2ZHjRSens1GMrWzOjw80QM3sQ
	 LYa5MXu0+Yod9LN8KYI81jUA2SxzZ0T6/VMb8UJ+OJpsuLBJO6LxnRg9K0P6roPlBk+gS
	 i6JnZgXI5uYrzr8nrwoPrMjhWNkowZ6ez/+bI0mOmCZVid/HfhUXihmQJMuE/rTfpGAQv
	 eUp7/D+JqUfG6BGKxZz7QyEtQwS1O+ftzfvOVndj8Vkefphj4PdKfmuSWfiofzDqqeab3
	 tF1M/u0L65ilMMX09vZeiZ8wx1oCsXNnEN4Hp+MRfTpRWiaRCwChjplbR6NbG5cfbAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWENNeKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF76606A31A;
	Tue, 20 Oct 2026 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWENNeKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578931F000C5;
	Tue, 20 Oct 2026 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458728;
	bh=Hph8D+eMCYs3gyzRE67O+LWduMA4HXKPhpMpMk4l+EU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iWENNeKWZLv2DtviTvLfufW+rRsjBSYBRMpnM9V88Db6/0wbPo3VJLYGK/VVL8UHU
	 XGb/MHh/4ZOpJBVf0Sc6xz/UQwk7gH9QYkj94uhLL0Sn6hI3cplZupJ+Lomrm4E+mq
	 SDuV/4r2cbuSKT9+LeeHuEMu74sBwupjxLcyFPR/g8L10LFzhIyNKwSn7x/Li+WXS8
	 7t3KuM/17CUQpMjScdBGaSmexSgFMoqZoGEo4sAgmUnI0V4y856mgWqyL0mC9qSZPd
	 fda/Y58o2BCqZTnWG+MW/E0Gvh6eZ2scEah2odP/22z1X2wJnvnj1pf8zKrfdC0Q0/
	 LX/NBXyJMTNvw==
Date: Mon, 19 Oct 2026 18:12:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v31 net-next 1/8] net/nebula-matrix: add channel layer
Message-ID: <20261019181207.170d68e7@kernel.org>
In-Reply-To: <20261010095939.2230-2-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-1-illusion.wang@nebula-matrix.com>
	<20261010095939.2230-2-illusion.wang@nebula-matrix.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 17:59:24 +0800 illusion.wang wrote:
>  adapter_init_err:
> +chip_deps_err:
>  	pci_clear_master(pdev);

The error labels should be named after the target, not the source of 
the jump The latter leads to a lot of bugs and confusion.
please see the kernel coding style guide
-- 
pw-bot: cr
