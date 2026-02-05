Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B02441A0
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258834; cv=none; b=JpWNyQ4xEeZP2UY2KV98Lr1ppigSAOoaIpHuuR/6tUlOCjlGYva7+kjQIbNh3w6uuUPLIpnj7zARQVciX0VG71JazG2HhKuolhtK7NeuDqtCLXQPwU0J88djxRbpq5lXuso/zgTWDD0W/fEsyQb/FWrcfaC0RD4kuBBehy80PMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258834; c=relaxed/simple;
	bh=U7I7jj4ew3l3l8repXu3+iYg65A9gu8RqvAWpPgFBhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtjPZMXWEdtaWnjKuuuIMO6Wk6ez5XanSY4//o2TRLX+taewG9Ljd5jeli0zTmM8P3aH+E05IZk8wtJpe+rDr/F9c3mKi/7UAx+L1DM2Udn1a8LCzOkxIT8oLabrd+qIXWr42c5R5LPLeFYfrMRLyNC1ZZCQANfWPy0mcnMmRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idC/R252; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idC/R252"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6AC4CEF7;
	Thu,  5 Feb 2026 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258834;
	bh=U7I7jj4ew3l3l8repXu3+iYg65A9gu8RqvAWpPgFBhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idC/R2527Sx10zJQ/WLI9FDXe7+cbG3BYH6TamWdv3jk02Dvjav5Wrlj0u782/X1U
	 20sH4phdVh6ZnD/98dWKAnTkat3oWXvWOOiLrRywsf8ZlfQ4M1ILH+lVA1axG/4SGc
	 7uGsEFsW/aMsqFAsO4eiO7xojeXeUGIZXzVpdPafC31ZHD9KQ+wcXccXvgYZnFHawm
	 aoI28HH0g7p4CZTcaF8C3fK+EN+ghsJODSyVE2+h82WMZ2J6jPgyUs1xqPqcxtdlpk
	 ZdY1Un2rI+8NyS/K4ZhpCcLHPczZO3Xj08h6e3rzuaH3J3GTPplOB0Yco0Uu5wOBPu
	 LEmKyb3vukbbQ==
Date: Wed, 4 Feb 2026 18:33:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, davem@davemloft.net, guwen@linux.alibaba.com,
 lulie@linux.alibaba.com, hkallweit1@gmail.com, edumazet@google.com,
 lukas.bulwahn@redhat.com, andrew@lunn.ch, dong100@mucse.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260204183352.00b248c4@kernel.org>
In-Reply-To: <1770256081.5424275-1-xuanzhuo@linux.alibaba.com>
References: <20260202090638.46836-1-xuanzhuo@linux.alibaba.com>
	<20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
	<20260204040054.1698677-2-kuba@kernel.org>
	<20260203201237.35c5f756@kernel.org>
	<1770256081.5424275-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Feb 2026 09:48:01 +0800 Xuan Zhuo wrote:
> Regarding this point, I did some experimentation and believe there are se=
veral
> issues. First, since request_irq requires passing the RX structure as cal=
lback
> data, we cannot reuse the same IRQ directly=C3=A2=E2=82=AC=E2=80=9Dwe mus=
t first free the existing
> IRQ and then request a new one. To safely free an IRQ, the most reasonable
> approach is to stop the backend NIC's operations before releasing the IRQ=
. This
> constraint means we can only free the IRQ after tearing down the NIC. I've
> reviewed implementations of other NIC drivers, and they generally follow =
similar
> logic.
>=20
> Moreover, I believe it would be quite difficult to achieve this with only=
 minor
> modifications. In the future, we might consider introducing a proxy or an
> intermediate structure to serve as the IRQ callback data, which could ena=
ble IRQ
> reuse. However, that would likely require more substantial changes. Given=
 that
> we've already done extensive review and refinement, I'd prefer to avoid
> introducing major refactoring at this stage.

Please TAL at commit 3a856ab34726 ("eth: fbnic: add IRQ reuse support")
for inspiration?
