Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAF3C3F6B;
	Sat, 12 Sep 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244072; cv=none; b=JKxShBhVzt93M3qvKvaDz9J6A/uVpZB8/iBWMtPaJ/qmHkgV4Xfd6krxbbV/Joca7IB42/jVe9SdjUAsizrju48mDFkLEpkLlWXuRgO78Uc7O0q8uQO9xo7iMefBvnEnR6KYYr2H7fVN9ua75Xw857BOEuZJYyJmOuOhS9xmPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244072; c=relaxed/simple;
	bh=aMPkbxR4vtJzo8CQmwjK4ydwCWfJWyYm46YXN2FALZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOXy6ZkUf4egwPzbxUIDynGn7DUYga3ju9fOypf1ZDKudkEW0vw2b+OeQZ382kHlADbHVdIbpITV/R0AJq5GQ37LxinWdz48CarcYS0wqXw5WqQznY8VwijjE03pZvRE0b0RNyo5yrnrI1pw+YgMv4l7z+OBfu+WJ2ukdixI4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrX7l1OA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrX7l1OA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051D81F000FF;
	Sat, 12 Sep 2026 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244062;
	bh=4oIqfV5KvbDI3IxsRZQ0qEeErlbPv5b2bokyql58ZQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MrX7l1OAJDEXaSi+yO3atB0AhnXcGQZB91SZ1OMJlf9nuUPg0LaizMDHxmtO9ESd1
	 ENnnjy7v09zGy+l1UrIkWhHbi5bZ4sdPXZKrrIJ6deBKpx9XdQ75M3gXqVvoLMUu7Y
	 oJHdkbKGBRtEvT/4WlHwPu+7b/xrjZ0xVW+nNrOk8Ug6jGehXVbmFf7iTq+vuDObOW
	 ufeiU7Tkiw+awST3BRX1jJz59feM+4DiHNTNw4Un7z7Bxq2gG4JVi4AxlLyVxHpK6s
	 HfcwklUKFmx/TVXU/FrKO086thP5Z5n2TmiO4ar8U77taiN7osBwfidpi8vOy97iTW
	 +8084FdwzkMOQ==
Date: Sat, 12 Sep 2026 13:14:21 -0700
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
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] net: pcs: add basic support for
 RK3568 XPCS
Message-ID: <20260912131421.2960a12d@kernel.org>
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 23:37:03 +0800 Coia Prant wrote:
> This series adds proper SGMII support for the Rockchip RK3568 SoC
> using the integrated Synopsys DesignWare XPCS, along with necessary
> fixes and refactoring in the stmmac core and XPCS driver.

Sending the AI review FYI, please look thru it and judge if any of the
comments are worth respinning for. We're waiting for a review on the
device tree bindings, anyway.
