Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C213D51E;
	Sat, 19 Sep 2026 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856126; cv=none; b=t4YPw5p+p5koJi7m7mb729Z0IPg1ocdt7dIOZUp1CoZcxdF/CiSMsEeMAnYD/Ax8iVRqq+pW4b7E1hBml6AUWCEakdUdxHj+BGhjKir/veH97VNHrKJMLnbbN0ngCYLsk1fXfzzgiu197OLlQn9KeTozqgmtG4YSlzNsoTn4A1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856126; c=relaxed/simple;
	bh=7jfzohd5RGbmX21bPI5+tnftHn0UzDHWmHZJ63exygA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvY+xcpuESUmS0/YRI9mvNJbwwx4tab9pQ9bjigxyppjlipK1igTSvOtOwZNJycm7sKkbbolPPfP7TRpG0Jt7ifIh1hevx1EmGiLuuIFujVf2gxmWqbe0xW6odB1Kq1Wm4Ma4SGstdfFufc3Ryy0AZfYBElBp/nBRTk0gZG2mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of3sBBWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of3sBBWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CBD1F000FF;
	Sat, 19 Sep 2026 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789856125;
	bh=7jfzohd5RGbmX21bPI5+tnftHn0UzDHWmHZJ63exygA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=of3sBBWdKDIL0RAgzfoNcM0HH4TBTmFYv4DFcGu4mUCexYdo4d1QXo3CedqwrXTel
	 SxRZN7tKRSRSvhw7Oq2kl106T3TCNwh2Iy+ShyGXcvuc/jMnrZrcY1gNqE6au9KnjD
	 wfOGMaK2reMDRHWLAeLuY91ovEDiRu5Gz43nvii3o5l1T+ftVHvd5PE2Pw9s9XcI8H
	 IkolsoqoXFwa02FYPohKlpPoFxIFVECFzEOEwcYDptvxrkOPo1ZNz9XY0Et3ecCTs9
	 y6u4hs6MH4m1z/K4obNKrlBkKOY/eNmcBvkaeYY1hseDoCP8oZnIPykADT5mQRMYr9
	 EQT8j9DeaI2bg==
Date: Sat, 19 Sep 2026 15:15:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20260919151524.6a65c24b@kernel.org>
In-Reply-To: <178968029668.22033.6092490845837885048@kernel.org>
References: <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
	<178968029668.22033.6092490845837885048@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 21:24:56 +0000 netdev-bot+sashiko@kernel.org wrote:
> Critical: 0 =C2=B7 High: 4 =C2=B7 Medium: 19 =C2=B7 Low: 4

Per subsystem documentation we ask that submitters review=20
the AI feedback and confirm / refute it. If you think that
none of it is correct one email is enough. But I really doubt=20
that AI was wrong 13 times (counting just High and Critical issues).
