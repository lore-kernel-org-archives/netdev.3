Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857BC2C6;
	Fri, 10 Jan 2025 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474535; cv=none; b=RxrPPQt4LXMDSLVnl/i9V2YN+j3CGIjFvRsL5KZFWePb28Q+YPAPM+Bjj8y7YVKYlBouLAX1MF7Pt7VvvPxOc6TQAD//ltzjDIFtWE5Hm/X7EN/eBplu8jBNPucvabEcDR1pe2RcWmtxSWrmd2vRmxldb5rH2x49+PMp3vqKw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474535; c=relaxed/simple;
	bh=2Rgjg1zFqD+nWOVgkA/R5GzzOIP7+Ega7WrtK+6psQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOBVFFhDSQCyqlRVtzOdDVx0klsIGmaG8rIB74qe56HsNGBMsWcrcZyEkWBVkvNyfDbblGTdwoOewsqO77kdfwEVYTh3Ag5gPkVM7dPV/KTdjfBBiaJvNx5eS7wTJTFDoKU6rth2XR7yYax6eVqDfnUE6UNvSRckglm6rnA4msI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rar9Z8ci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rar9Z8ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A25C4CED2;
	Fri, 10 Jan 2025 02:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736474534;
	bh=2Rgjg1zFqD+nWOVgkA/R5GzzOIP7+Ega7WrtK+6psQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rar9Z8ci6DktzKFJZHgULmIQHB5P/Lw50nZ4dd/BkLHFqyZL0XNlJNri1EDcbKPlP
	 ARpU/vVx4VGuE5p6y9s7/zWH3BOBtPTF3Z90nmA1VzMJ3lHP6yP8Fu684GIXwRu2F6
	 4Uf/kfSdVS9OKrUAb3pKR3DMkWPVTyYsZ3W0xuUZpP3sKbeOeoCK56h37FOmR94HrE
	 TSpgKc3WqTtyM4+jPHIELZSvEtfXRCM9WmIelSqQH3+Rp86ltTYFeb62ne+e2iv8fr
	 ujBlDiuxj2m6+wXD5vqx7a7S0e9vhho8vAr6kSfAlsh+ma5Up99Y9WzpU9Q9/NDWPg
	 QxwWVoqzJG6Uw==
Date: Thu, 9 Jan 2025 18:02:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 wellslutw@gmail.com
Subject: Re: [net PATCH v2] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Message-ID: <20250109180212.71e4e53c@kernel.org>
In-Reply-To: <tencent_E1D1FEF51C599BFD053CC7B4FBFEFC057A0A@qq.com>
References: <20250108100905.799e6112@kernel.org>
	<tencent_E1D1FEF51C599BFD053CC7B4FBFEFC057A0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  9 Jan 2025 02:05:52 +0000 Yeking@Red54.com wrote:
> From: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>
>=20
> ndo_do_ioctl is no longer called by the device ioctl handler,
> so use ndo_eth_ioctl instead. (found by code inspection)
>=20
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")

This tag is unnecessary, Fixes tag should point to the commit which
_broke_ things.

> Fixes: a76053707dbf ("dev_ioctl: split out ndo_eth_ioctl")

Now that you added this tag you need to run get_maintainer again /
correctly on the patch and CC the authors.
--=20
pw-bot: cr
