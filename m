Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25262BE65B;
	Tue,  2 Jun 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360444; cv=none; b=ODi3Ky4NomIqnt0jSCKqEt5gW/nS1lmeJ+xjV+WoBaipxl8uCEreMvAXg0OhUFq3iEndP6nS5x5TSTKFeP8QUfPqMOatxILbHSIBehSc5PPM/5JB0jbQ5quqeDgARF/96GOAsUk/mMCsMHa7QrPbMfbqHkxAehV05sgsBp/CzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360444; c=relaxed/simple;
	bh=qZ7bCQSddA9GP4Q26qjJGXv0MQXMsd36Q5gss9jKA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPVNotyjdRINfDYoPmXa8QlNLfubnh//KhDHZRK3bV3CDkWdt7O6OEb9OAhn6LT/hY+2mksuIjhc8hvsY90+xBwjat4MaoGBoD2pzzVq+zz0PoXX1KWgMk8vjSoCOHcF1hTA13AfMTKJqTRGXtIN1Vei/16v2xIblrMbfzqdrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrT4R1Fn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrT4R1Fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A733E1F00893;
	Tue,  2 Jun 2026 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780360443;
	bh=XSv5f2xonG2jwEtIkq1PsvlV+gdAZE4pvna2aJ3ZHYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LrT4R1FnMFeZReAD7nfvr5RIo8JWtky/udCbBY2ZhqtUi+Q76cohHUOPZEQPcXUps
	 /Wj/tNIkm21gcNkRQqvwgEaMJsPAuURBo/GbsQiq5cFFN0tkEBlVPx7i/uVfJC7tQF
	 wnAlEDYIXPyXCrf+GobQyRYufJVMTSwCUzIitoFrSEY34U6fvlPL5Ur9kaeBbEkAY+
	 myNvh3CyNWI90Ti4L4ErSZvJS0Fsr+z07/P7LS6Elm648euQ6BzA/kxhi+gaCFHoVi
	 so0N9r4ezQYgbcSKF/7yU6B1PE6RMNVv9KDF62FV/0Sr6Y5/FxFfEbECoKmrjnHaDF
	 TBiI9b+sUDkaA==
Date: Mon, 1 Jun 2026 17:34:01 -0700
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
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/11] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20260601173401.2c892526@kernel.org>
In-Reply-To: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 18:31:39 +0800 Jack Wu via B4 Relay wrote:
>  43 files changed, 14761 insertions(+)

Please try to cut this down to ~5kLoC for the initial submission.
Whatever the absolute minimum sensible chunk of code is.

Each patch must build cleanly with W=1
