Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8263ED119;
	Fri, 27 Feb 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199833; cv=none; b=n50+pGyZwmrE7/+x4qfQuezNjZbiUUr59SmLoq+kqVKBcZ9+osPn/VWrvxNmY6EBS5yX/Up7LbiahTik91B285H73uWOQBlAYpAPVnrg4yIw0bOpiyKfsaksvhJhLt1iTuiwlPY69MSiMuA2ySRGUvXSmAb4Ie0y+Kg9Q+crLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199833; c=relaxed/simple;
	bh=w8CiRJDdjaW9aDKfP3+nyfiRb9ToVwtTsc4kKJoE85c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4wJnyMcfYOQHHUJge+GBrUy2VHdFMfurQ3nMmCqSLjv96aEBk7RF4OGcsv1Y3wz9G9/wbv1lzrz7tsluKV0yQDFQBTuYusZjmITcG2Nosd7A65xmlKEW/GRzL5jWw85cWfpEZhN5Pg+tc697R71L6jFlrZ2jEGVnAQOgZYyjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsOPvrK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsOPvrK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74884C116C6;
	Fri, 27 Feb 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772199833;
	bh=w8CiRJDdjaW9aDKfP3+nyfiRb9ToVwtTsc4kKJoE85c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsOPvrK0YjRdtxU/ZGev/S4fmMq05NZwIwdOFeFe+B0qw25c2AMMOyobge3/TZLnQ
	 rlPgcDFNFHZfSIYsblbHYqYRDUHRnxjV0UmHuepU2mev5kcSgCdSHIXbwAqcoOZeVc
	 jH2jHKeC25WdjAwXHgbMCnDYSLF+klqLCF/gzf63jlN9v8g3UvqFahuuOrkTUK4EuO
	 Ylm5PRd2LZgBOS+I/FZWPxTp1FBDbWvR6PbjLDGmsoGrhw5ISy98PMb8gyPPkSIuTv
	 /XdT0lH0C9wPEuz5QADkForJx9rHpxqOyaOFr0AHEtM8AWD+lSADVuNbn17y2zfKR9
	 3GxNIYISdhziA==
Date: Fri, 27 Feb 2026 19:13:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/8] phy: qcom-sgmii-eth: use PHY interface mode
 for SerDes settings
Message-ID: <aaGfldzQq2nL0rx6@vaman>
References: <aZ66OT9scKipRRu2@shell.armlinux.org.uk>
 <E1vvCc4-0000000ArLA-0Eix@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vvCc4-0000000ArLA-0Eix@rmk-PC.armlinux.org.uk>

On 25-02-26, 10:59, Russell King (Oracle) wrote:
> As established in the previous commit, using SPEED_1000 and SPEED_2500
> does not make sense for a SerDes due to the PCS encoding that is used
> over the SerDes link, which inflates the data rate at the SerDes. Thus,
> the use of these constants in a SerDes driver is incorrect.
> 
> Since qcom-sgmii-eth no longer implements phy_set_speed(), but instead
> uses the PHY interface mode passed via the .set_mode() method, convert
> the driver to use the PHY interface mode internally to decide whether
> to configure the SerDes for 1.25Gbps or 3.125Gbps mode.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
