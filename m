Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFB25B0BE;
	Mon, 27 Jul 2026 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194411; cv=none; b=ePDYJE97jVlyw+DMldAUrOvUDzhzJFRwNb6qAetURT03VNC/2zCBKzLFl1xmbMVrJpmM6u8rVDA9Ct5X7rvRvXO7IrXUGjzi8swKqzqQKwxwUByUT40KBxhbxb50ZIBkylpcA7yZRYECI5bciLeRaLmBbKoJu5NbrH3y+83t0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194411; c=relaxed/simple;
	bh=X0h99WVsqXjK1wXbNVpFcYM2IvOD132XVPGyS+znnM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHL06rM6I3vX63XhikJ1HF6M8xs75xTjaPdEeLgWREao+XpdOv1haE9WLdjhgPrJ0dmUm6hnsun6Am45Vcx0grHF9/6cGpu1tJEzNq7tyHljF/FXGAexPLz6IyLsTF9Hh8RcQxmyQrODv9OMssvKAXh7ExKdE140uhyJLnTHYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h//dHP9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h//dHP9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F171F000E9;
	Mon, 27 Jul 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785194410;
	bh=cq4mJ0RXeim+Euv7PLuGb1Hgr0qLC63V7rQjWD9Hqa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h//dHP9T53GpQJb21bLLrTAVE8BJ5RGB3rrEH1tdQwlHuEsz3dxyDdOcNCj1XBJv8
	 yjb8jsnOwS1YUXHPu44574Tsw+XMMp3qSZePBth+G3GT7fdtj8ObE9KF7x7kMzb3LW
	 iS2+qBYEITk8omuPp36x4ghcKDbZueQYGIs8/XwbBhk14I/twQ5Ns4vXEPUUBj0ypz
	 8nziQl9JSn6W0Mb8Lg9Egf/Izdk1CRMiwodYl6/3PDqAUI4VNDtxXUuUWlV6pwZc/E
	 mQKld6iPn0ZUu9w20mtevYMF/MmYyslbwjvpgIBCKutpPijSkYphM78x3yIqq5cHG0
	 Z1EbF6jQfjsgQ==
Date: Mon, 27 Jul 2026 16:20:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Ajit Pandey
 <ajit.pandey@oss.qualcomm.com>, Taniya Das <taniya.das@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 3/6] ptp: qcom: Add PTP driver for the Qualcomm TSC
 hardware
Message-ID: <20260727162008.2b93959d@kernel.org>
In-Reply-To: <20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
	<20260727-tscss-v1-3-beed14e72510@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 19:40:59 +0530 Imran Shaik wrote:
> +static inline void qcom_tsc_split_ts(struct qcom_tsc *tsc, struct timespec64 ts, u32 *hi, u32 *lo)
> +{
> +	if (tsc->soc->rollover) {
> +		*hi = ts.tv_sec;
> +		*lo = ts.tv_nsec;
> +	} else {
> +		u64 ns = timespec64_to_ns(&ts);
> +
> +		*lo = lower_32_bits(ns);
> +		*hi = upper_32_bits(ns);
> +	}
> +}

Are you sure the compiler doesn't inline this trivial function with 2
callers even without the inline keyword. Compilers seem to inline as
much as possible these days.
