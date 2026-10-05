Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6568C418340;
	Mon,  5 Oct 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236677; cv=none; b=CHNBsXjbv4dIrmTlcIuWQVVBZIznljVqLhIn5wBUi9o/Gz5X9In7+O4TJ6h3KTqKWREuxg6c331ZRBf85UDYD9gKQy3iMO3ANAMCnoPf+KXIBkUHTPZEDkyBeJX2901lI9QFdKkyEwQf/QORVabInoXBnqXH8ixYR2Uo148VrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236677; c=relaxed/simple;
	bh=4/rDq4XAFThINN/GqsxY7MWsltjDqj4mbPy60j1iuVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF+FDjf97Fu6sJIPoh3BrL/CpBrJK4xVGD9MZorEcjouxiqmF6lL9uGLlgTKt7KTw9MF+lw/R+kjcTK1LoSG9os+CnjfbSstHT9L9NNDDy+1vR0JVlg0Cx18OFrCvOsv9QM49EB/Kk4w4QtK2bWXg0LBHp+ZV7X523tpR9aYpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+l3sne0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+l3sne0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E767A1F000FF;
	Mon,  5 Oct 2026 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236673;
	bh=OMGNafCDTIN7tw4XYN2fDnbCF/eJLY/nlgTC6tJLnk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D+l3sne0JSz7S/e0kjaWYoLkdpILd0g09XO0cEnq/7woWOynr0kGxi6v6ORBoneF4
	 cFDt30znQoNiGnVplh0IUpRrPIHe6bevX1qePBTo2eA61l2KPFmAEC/NdN0idLJscS
	 +6V6etyx8wQuYYe9v+wBjzCUcVNF3NCZIVdZY2nwLaZExH6ioS2Zt0yu/TJfB/BuT7
	 tIh8sB4+VhbfbmrdT0wYX+M2YXLglC1yuNBJPqrbR38XGATjv37EiqEn48ly4co7oj
	 qxXl/61UP6DhGKRzv1QaSVYNHDTc5Dsqd/GnUo6zMPogpAlXjWUUhl8ezY8P+N3edW
	 vpjmzcddJ/q5g==
Date: Mon, 5 Oct 2026 14:44:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Romain Gantois
 <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, David
 Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
Message-ID: <20261005144432.580daa2f@kernel.org>
In-Reply-To: <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
	<20260922200336.2201212-4-coiaprant@gmail.com>
	<20261005135939.01ccde50@kernel.org>
	<CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 05:15:07 +0800 Coia Prant wrote:
> Thanks for the suggestion. I looked at this again, and I think the
> dependency is a bit more involved than it might seem.
> 
> The PHY patch (03/11) adds the driver support for
> "rockchip,sgmii-mac-sel", which is documented by the PHY binding (02/11).
> The DTS patch (10/11) then uses this property. If I send 03/11 separately
> to Vinod and keep 10/11 in net-next, dtbs_check will flag the DTS property
> as undocumented until the PHY binding lands in mainline. That would break
> DTS validation for the net-next series.

Wasn't the validation running on top of linux-next to avoid this sort
of problem?

> Also, splitting into separate series means each has to queue and get
> reviewed independently, which I'm worried might not all make the merge
> window in time.
> 
> So unless you strongly prefer splitting, I'd rather keep the whole series
> together in net-next. If that works, would it be possible to coordinate an
> Ack from Vinod for the PHY part? Or if you still think it should go
> separately, I can do that too, but I wanted to flag the dependency and
> timing first.

Well, the patch series is already getting stuck because of
cross-subsystem acks. Do what you will, I have 700+ patches 
to look at right now :/
