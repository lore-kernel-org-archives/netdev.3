Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585123C8AE;
	Sat,  1 Aug 2026 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545717; cv=none; b=L1jUmGVrycIAx1mH3YMQfsUVXVSZ9LmRtRLQMwCASOj6YxkbY3ggVbmyqz7CB17u4iDwBqc1p0NIq1denMTD8dUgVCKbcKlS5dWVrLTksY2UP8iWbCeFrRoIMDu3S/RXksIoQe9tRP4mkFGpMtiqyI5L1kIoAERTr6EF+tZaNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545717; c=relaxed/simple;
	bh=Y7ay/jOVeMUkZYpcUzuSBP136GvuV+QVFGz6F3NnHB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXLEIE+9MSwVIho6F+D/+heTMoclY0bGlDcCcL5+hTC1SZJZEYZd6eNR7ULo0KB1LJ+0H790ZEM5+LJUI+GrIEdo1W9ByMbI29GHTLbDaCfKY/1bG5DkxBiahaOXLpAC1x0uHdbBO6VWtwifY7b6Rq+J3WLzLcHxJASU5LhnSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfRwkO2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfRwkO2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5D91F00AC4;
	Sat,  1 Aug 2026 00:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545715;
	bh=aQl6TGVfL3NmtSfkueFsekee+G6Sceu8i+KIbKRPfTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NfRwkO2ZJwjlk+XbyQE2kPYa49m7PSS+Jq4DR9RQ6Qy3HnRQBP/UH7a8yfKK3mctn
	 /G5AScBQB93Wm9gdFFFmZDiuXT2aap8pzxgeTmzIhnKdaPlYw0LL/njOprOh3GmpgX
	 LkOKjh3WzjO/f8fLcFtVnNeNNb4Bbh/OE+Vdm7rBE5L/3EiTyaL2IsGUl8eXtLk/gC
	 JAeafbcx76ivYOTRjQnpCPn34qmGhUQ0CNPUg7Ur5x8a9ThvCv8FjYqdxT6D/aAfGE
	 AYhkMyPktd7gV3C7SqAMlkpzOq7DYl9PcWpYSjUBhiqGEzHJwaxnhWDg9v9h08/PGc
	 EbSQMa+gkxnpA==
Date: Fri, 31 Jul 2026 17:55:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: stmmac: fpe: Move fprq configuration
 to stmmac_fpe_configure_pmac()
Message-ID: <20260731175515.10e5eb2d@kernel.org>
In-Reply-To: <07c55657-cc7e-433c-89e9-a21688ee8ba6@bootlin.com>
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260729015247.25774-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<07c55657-cc7e-433c-89e9-a21688ee8ba6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2026 08:31:39 +0200 Maxime Chevallier wrote:
> Not a bit fan of the writel(u32_replace(readl(...))) but I don't feel str=
ong
> enough about that to warrant a resend=20

Most definitely +1.

Please fix, respin will be needed because this patch triggers:

include/linux/bitfield.h:221:17: error: call to =E2=80=98__bad_mask=E2=80=
=99 declared with attribute error: bad bitfield mask
  221 |                 __bad_mask();
      |                 ^~~~~~~~~~~~

on x86 builds.
