Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65D48594E;
	Mon, 21 Sep 2026 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025282; cv=none; b=VjfkDZEjqTRiLT2TJP9ml2qSd9SLrd/ACqd+7iI3zrJYq9x8nDm3roU0OV9obDs6PO2QlEXDAtGU7ObI3tw+3nzgMMCrttWRk6vastulz3yQoykFxcgffGlP2lMGq4f8N8CgrZc3um3mH6Z2w2h46dvw9jCaoZcv4f05p9tXfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025282; c=relaxed/simple;
	bh=pZWq/VUfpsb0S24DS/LYzSU+NdII7InseEtqKIEJLU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyGZgdU952RDvYBeAxBZzGuPtwDfpymJJ414P8mD3vJo+Jt9ZF/Nk7Zj3CibTqjhkFpOhooAl2msc65OnAI60J3kqFvCoM5o+3T/6cTGViKUR8GdKjLh96wE6Bk/vNRd5D0EqEEmfu56Cqz/I83Ey79f+FOkNHqThEG+ZsLdToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AghGX+pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AghGX+pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE641F000FF;
	Mon, 21 Sep 2026 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025281;
	bh=pZWq/VUfpsb0S24DS/LYzSU+NdII7InseEtqKIEJLU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AghGX+pMjf2qxDfL8CTVfIuP36wjitsTYFI9vCAWdWNJ8VJEMNbtTcBCpTwazJ7q4
	 8PB+eSw5R8mHEis3W6Wqf45c0OEq69USNopr5BGRfBL7gvP+I8HrkUq2uOIF6f7BKd
	 ll3AsIiv3qJ2kL6GkzCPHZzfUOLpuBo9na07dQ9bddLrs51tpC9PDnp7CEpME3JS0A
	 TEylBI8aTza8UvVCfck7f3SC4LurH2rZyuTkFPjEQTB2yKwI3W6OHyWXt3o3tzbRxd
	 BbWTii6n6FHePkVeqZBUtNHi6Kx7MSODfyLp15v6Ll9SrsJriulOF07MQ51hIZz78n
	 tT7jEIVZzEXRg==
Date: Mon, 21 Sep 2026 14:14:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Richard Cochran <richardcochran@gmail.com>,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Vivek Pernamitta
 <vivek.pernamitta@oss.qualcomm.com>, Sivareddy Surasani
 <sivareddy.surasani@oss.qualcomm.com>, Taniya Das
 <taniya.das@oss.qualcomm.com>, Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Vivek Pernamitta <quic_vpernami@quicinc.com>
Subject: Re: [PATCH v3 0/6] bus: mhi: host: mhi_phc: Add support for PHC
 over MHI
Message-ID: <20260921141440.1512b9f8@kernel.org>
In-Reply-To: <6e314a3f-c73c-461b-86c7-472ef02e440a@oss.qualcomm.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
	<20260917074804.08818813@kernel.org>
	<6e314a3f-c73c-461b-86c7-472ef02e440a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026 16:22:16 +0530 Krishna Chaitanya Chundru wrote:
> > Carry this until told otherwise:
> >
> > Nacked-by: Jakub Kicinski <kuba@kernel.org> =20
> Thanks for the feedback.
>=20
> We agree that the PHC driver does not belong under the MHI bus.
> In the next revision, we'll move the PHC driver to drivers/ptp=C2=A0
>=20
> Since the concern raised by the NAK is being addressed by moving the
> driver out of drivers/bus/mhi, I'll drop the Nacked-by tag in the next
> revision.

Is that what "until told otherwise" means?
