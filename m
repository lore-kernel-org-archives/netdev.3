Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CA44D012;
	Wed, 21 Jan 2026 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979422; cv=none; b=oGabAQvvwnXDd1QUtA/JN6ZR7qxvpfA6s8bg/MHtaNy9rj6OmEUTQRnzDQXcTfoUcSugdQeuNH6/J/ux0SxXfNiey83wkJFcJxyYzcHY+HRrJ5AQLNlu8ZNngQXHunPAixhrihMo9bvzO71FT+5MG0tplVUynrofAnsYpJo0VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979422; c=relaxed/simple;
	bh=LPTWJYAQ6qudvoyanTM4lo1W439gR1ri8d0jQlc19fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhCOLhgNXsgrkw0O2mD3iuqvG4VLGIh4xMw0fKQ5imMrejrZM537rYGrJ9mXJcOvWRBk95SDVhqbF8XdVMMUwdTy5RQYgdWsEbiU8ueNZPGZMFGq9qZM8AomsoNUo8Ao+6S/MxY01NM3ao4d8fGkGoaa5TIi0FYl69eXQhKewK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRs3i8Ey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRs3i8Ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB9C19422;
	Wed, 21 Jan 2026 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768979421;
	bh=LPTWJYAQ6qudvoyanTM4lo1W439gR1ri8d0jQlc19fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRs3i8EygVgM8EkxAJQiTKjnDFt5hnbi/DDet82yNMnfR93FH5G/2Tjnu36d73oTI
	 KH+Viwbz8J1udbmQ419Ww0tATIR5J9/vw5a9egx1xVPs/lRAlMiUms8kmdzBqyeFaC
	 4mJjaNqrZVKhpF6WY9zOnbpRcujFKGhejn0DPQn+wJ1PJy5gePXqcshjGg3GQlk2lD
	 uAEY7e6o18D1GStCVQj8xRb27NV1i7mys75Ixp7Z1GUAyp1XVCgLRqnMaq384/agn8
	 JrM3q/HnGgyuCJRPPrervu7qP+Vbin/r47Sda2hAQHTUxxquniUAMf35fLvGE6U6ST
	 635Ab+QCJ3Wlg==
Date: Wed, 21 Jan 2026 12:40:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 03/14] phy: qcom-sgmii-eth: add .set_mode() and
 .validate() methods
Message-ID: <aXB71tN-mf6xBVFc@vaman>
References: <aW4kakF3Ly7VaxN6@shell.armlinux.org.uk>
 <E1vhoS7-00000005H1T-1dXt@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vhoS7-00000005H1T-1dXt@rmk-PC.armlinux.org.uk>

On 19-01-26, 12:33, Russell King (Oracle) wrote:
> qcom-sgmii-eth is an Ethernet SerDes supporting only Ethernet mode
> using SGMII, 1000BASE-X and 2500BASE-X.
> 
> Add an implementation of the .set_mode() method, which can be used
> instead of or as well as the .set_speed() method. The Ethernet
> interface modes mentioned above all have a fixed data rate, so
> setting the mode is sufficient to fully specify the operating
> parameters.
> 
> Add an implementation of the .validate() method, which will be
> necessary to allow discovery of the SerDes capabilities for platform
> independent SerDes support in the stmmac network driver.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
