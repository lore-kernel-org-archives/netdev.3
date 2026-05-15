Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C01643B;
	Fri, 15 May 2026 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804396; cv=none; b=BYoQ/CCfkhPccP5n3u+KKgbI3y2DhnR564nxby80/ocgQ0rchXrPVAgys0Dku0MNuR+UYM05uTo+agR2uQiU5W+JzgFyFE+HnJCunieioYnbbO8jcTbkufwJZ5hI1FUoWFko8PrF7ovNW51+hkephivxzL9K/RKJuZFeOxiiSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804396; c=relaxed/simple;
	bh=aYL/gPTTusuFgYbbe1Nedb5DgCK6oOu6R7rMMTz41yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J13TN0eMtYAwLIxlAVsdDAvb3dowFJaposRiW8B8zmDVuKx1Lp2glfSrJo47/qjXHxRIZ79yPlkB1okWw8x2kpOE/12D01by5tWR9LdZEkg3mryUzqLInZHXzxj0S9PLHvSz8oV6juwx9us1SVqj4TYOrik2PhM8Ss6gmMDhZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7jXAULf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7jXAULf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F96C2BCB3;
	Fri, 15 May 2026 00:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804395;
	bh=aYL/gPTTusuFgYbbe1Nedb5DgCK6oOu6R7rMMTz41yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7jXAULfXRXXovALlKyiLtxvi6JXrxlI2TASghQaQCcBEdzbUwt6kZxa81hdPHjo2
	 toGqEr0xfpQIz33OrQ6DH8kXi+rMtlKKhz0xG2dJpWvBrNZorOkvR0Po0cdqHb/g9X
	 DPk0a8VO/hasGxSL/GLQw4OpQ2oTL4s9k54rHZ8uAQs8+3r8HNfj8SfEGeqYVFKWmw
	 NezW/hJ4GT4Vc7P5V9BnPdIYJN5rvJSCfTN5aEsgyJQpCTYDL07Jfi17M1QK9QzIX4
	 Rp4OVZHT19mqScg9xIPlmpwCjeJECoxfi8mW4xJJqdf/SpJo3K39lFVgs0dUkghbIT
	 6lrqP20CKoMoQ==
Date: Thu, 14 May 2026 17:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tim JH =?UTF-8?B?Q2hlbg==?=(=?UTF-8?B?6Zmz5LuB6bS7?=)"
 <Tim.JH.Chen@wnc.com.tw>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>,
 "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
 "ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
 "loic.poulain@oss.qualcomm.com" <loic.poulain@oss.qualcomm.com>,
 "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: wwan: t7xx: fix race between TX thread and system
 PM suspend
Message-ID: <20260514171954.5d2edf8a@kernel.org>
In-Reply-To: <TYZPR02MB5232A8C6A2BA56226D97CF4A90062@TYZPR02MB5232.apcprd02.prod.outlook.com>
References: <TYZPR02MB5232A8C6A2BA56226D97CF4A90062@TYZPR02MB5232.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 08:37:48 +0000 Tim JH Chen(=E9=99=B3=E4=BB=81=E9=B4=BB)=
 wrote:
> Date: Wed, 13 May 2026 09:21:40 +0800
> Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM
>  suspend
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

Something has corrupted this patch (either your email client or server).
Please try to fix your setup and resend (maybe use b4 gateway).
