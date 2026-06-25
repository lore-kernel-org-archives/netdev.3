Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA61EA65;
	Thu, 25 Jun 2026 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346160; cv=none; b=BZaOwR17/B2luf/Jq3/XJk851aI5dpRgeYYG8nfsDaeW8VGZ+IdOdqG8c48cL4/S+unfLG0rJakCErf5YeWE7Ae/0l2Ji5g5CspSZc2VWOJbAPDQdx58/9mw4wxQZGzVQ8/vsuqSbOknOO56i9kkc0HpEOa8e9AHAdPnjy7V9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346160; c=relaxed/simple;
	bh=EQz2XCBwRS8uLK6XBV7zSGPH2BY3UI9xhwr0H8YcNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMCZTrzu8Hg9/Mg77ZjOFBIKJegHqJmOjGFXXHz3Z9/wn03GXs+Za4OaC90mUzKUsXh568ziZwEG2NJ/bWxc+6YBMRToxvBXy2s8vaV91geS7cK9SjT93d3j4V1epfCocwds5NKJmkyXpbxdgZi0Gr7WKMt033BbY3VK8WY3VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpSBA7rI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpSBA7rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78491F000E9;
	Thu, 25 Jun 2026 00:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782346159;
	bh=EQz2XCBwRS8uLK6XBV7zSGPH2BY3UI9xhwr0H8YcNTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MpSBA7rI/ESXhoj9CFf1wpUgC6YJUA7qMDqhbRyBPAuDBK9Ia03yaI2I6ew/dbqJu
	 sss2bjJYZ3xFjU7SUn10PhUlBSTCkC3jZ+5d8+XWPcf0b0mTJ8YetSCIuQnV/4JhP8
	 P8IplKPYma/WqSQ3oTuKqFKsjQsjK4+ixeCCY7rVMaojpukWcsBA3hX2ffZ6pqF/TX
	 TQdn+BW6ED5QjuxjNwGZqtBFZ9TseAmoE+282nKTfiTlpipVnSkH6rqv9FJiNDXNaS
	 va5qPjm+KN3jX0XhZ+Py1CCPxU6lBx38jGoqyzWCGEln8G9SIirWiLNhXKj8/UXz2q
	 l6X96M/sVO7kA==
Date: Wed, 24 Jun 2026 17:09:17 -0700
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
Subject: Re: [PATCH v3 0/7] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20260624170917.09967c74@kernel.org>
In-Reply-To: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 18:04:06 +0800 Jack Wu via B4 Relay wrote:
> T9XX is the PCIe host device driver for MediaTek's
> t900 modem. The driver uses the WWAN framework
> infrastructure to create the following control ports
> and network interfaces for data transactions.

Replying after a long delay and then immediately posting a new version
of patches is very bad. Don't bother replying and just put the comments
you had in the changelog of the new posting. Otherwise the discussion
may get split.
