Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AA31B839;
	Tue,  3 Feb 2026 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159281; cv=none; b=QZkW5u8aLkOIXTb619Pd9sFQJIT1HEJ9Hx/5cLy94w+h0boUZdERjuLmR+M1Xufu+HtYdZE5a60Rv/x0nrRfRGvFmOLjYDyuq6oJy7huYXwcZvvUqs2jMwvEJDGjIpOG06xR1xobTkiaG0SkiLMkdoAwxWndLESrITSEegD82xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159281; c=relaxed/simple;
	bh=xTEa66SqIkzAleDgDRd7lGWFimq5gjopqYwFXFVLDpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Csum5B/3K4UkxTr2reCuPEVdrWUKBwasyatCcVGIuhoME8/3X+yEq5nNUg8E4upW4QDStdU6gPO/uoht3rjY3t0nHZLFduTU+9s9LUl8Agrk3GpIQy8DXmDYhKZTxy7iyyChmkR/JkRrecOdlnMsTmZGJpP800IYlSL7pORXJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjCVV9pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjCVV9pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E38C116D0;
	Tue,  3 Feb 2026 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159280;
	bh=xTEa66SqIkzAleDgDRd7lGWFimq5gjopqYwFXFVLDpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sjCVV9peYhhrciKha3J/XPkboPPVtTmNcInZhTc+F62AFgALdSSL+Hmzh3A2B1EZw
	 Arb6xJM4W1nFMQHJ3SDeign5nxpIop7IWk+jPnwsbnxebEoNgGkNU9yyuUd4JXgWp8
	 uzRMtCfHfyqKmTWraf02FKOFcXLaV0kNPjJdZtK16eOujseXLzblXMxMdLyjtshz6e
	 XpLGxeymh3oTeJzBWHskWP+FjM38PaSmDrWkwiV9MOHXwXgPgcGCmV7tmjtrBEmWup
	 7ZfQI4kVJN5yRgs5VWOkBuS6/mK9mZoru9ha9OUUsxkn0fL38QTmXizln3FJaYtyfx
	 BeatimVe6FgrA==
Date: Tue, 3 Feb 2026 14:54:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Chester Lin
 <chester62515@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li
 <Frank.Li@nxp.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 imx@lists.linux.dev, Jan Petrous <jan.petrous@oss.nxp.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <mbrugger@suse.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, NXP S32 Linux Team
 <s32@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring
 <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linaro-s32@linaro.org
Subject: Re: [PATCH v6 0/3] s32g: Use a syscon for GPR
Message-ID: <20260203145438.5a850b61@kernel.org>
In-Reply-To: <bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
	<bdb7cd69-7dcd-4e8a-b04a-14a2eb902311@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 12:18:54 +0100 Paolo Abeni wrote:
> It looks like patch 3/3 depends on 1/3 but it should land in a different
> tree, as patches 1 && 2 looks suitable for 'net-next' and 3/3 should
> probably go via the arm/freescale tree.
> 
> We either need explicit ack from freescale maintainers or this should be
> split across subtrees, right?

FWIW normally we don't touch the dts patch at all, unless the
maintainer chimes in and tells us to take it. No waiting for acks.
Off the top of my head us taking dts patches only happens if 
the person posting the patch _is_ the platform maintainer..

For this series we're waiting for the bindings to be reviewed.
