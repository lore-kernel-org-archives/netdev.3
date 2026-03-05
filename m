Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2F221FD4;
	Thu,  5 Mar 2026 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675779; cv=none; b=aiqd6MXhjn5McMj+2+TugY3KbJqbcOSNA8ScVIYNV5d/TSDZyToHA4+deCTl9e0VsoTOXAC7bAlwSw43jvE3HLmR5mm1OnGGeFzjuHCziVkkO8P6OlstO31JrpPsvIx9yYIYGFL0+Vf6iGBWKH/FUA8moCvoWIuELviN98d+PCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675779; c=relaxed/simple;
	bh=7f9FrJn1QE1Ys6n+lCWljrWlaMQba/yHYK2P2Vp47yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmfUlJanHmmHChJxz7ors24hCoZ3vM/N/Hl2DkdsuwxfuPGfcEku7qRz+1lK2AS0nH9JsivzQZVaIHI+a+B1OzIthaMw3yEZbeEhGg45aERTscpj8hFvoOff8enX+V+3CNQN0jBtTeeoYRyUvrylIe+hXNCpLX8aHFUcnXPWmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD88mOdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD88mOdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7454C4CEF7;
	Thu,  5 Mar 2026 01:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772675779;
	bh=7f9FrJn1QE1Ys6n+lCWljrWlaMQba/yHYK2P2Vp47yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AD88mOdVAEzXpXhiJiSgq7SVc/mtFICynd6q/ArWcmpp6lYu5I9Qq/yo+45DrgBI9
	 6IACN8SqaZcht2gCmkz0858h03LSFSRHkjJCR2OTMOBy8vf65edEwDHamH0VJHiRsO
	 DtQxFTQXx3ya8il/2YSY/x/vFTsewZsqGVJf6huhe4m/pWJAjoMgGydLxc/FhUA9rl
	 GUA/5TSiJYxc9uo+ZKM5NAryp2NusjQQRdYWlrCZl5IpKM71HbUtAoW0ZZRzBwPF2z
	 ytbQ4N80Vu5+kj+fkQlk7svM5XfaduqHZ1yELL+22Grfcc6PBvDXbeX1YRl/GM1Emu
	 M79q3lJivjyww==
Date: Wed, 4 Mar 2026 17:56:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Mohd Ayaan Anwar
 <mohd.anwar@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 0/7] net: stmmac: qcom-ethqos: further
 serdes reorganisation
Message-ID: <20260304175617.3974d064@kernel.org>
In-Reply-To: <aacD3osfaZkLsGxm@shell.armlinux.org.uk>
References: <aacD3osfaZkLsGxm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 15:53:02 +0000 Russell King (Oracle) wrote:
> This part of the series focuses on the generic PHY driver, but these
> changes have dependencies on the ethernet driver, hence why
> it will need to go via net-next. Furthermore, subsequent changes
> depend on these patches.

Hi Vinod, given the dependency on the existing stuff in net-next
are you okay with patches 3-6 going to net-next without at tag
you can pull?
