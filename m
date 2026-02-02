Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745734E74B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028183; cv=none; b=qieI11Vo5Pjtab0SSt6/N0+kHHZFUxKWtXDFnmuCtAtjrOAkCm8IkwPSIOiVhqpVt7h63r/OKppMbE+H81rFc4QUAHlX5VXWuu8m7j1wTk74qzi9MB/Ssbd8UTuMwa9NICyS/VNuwsIBazFgWVwiwB9PVhknz1w9WLDLf8gwsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028183; c=relaxed/simple;
	bh=Bii5lAhMbOuiGNxu7r40Jd2Y0F1BQJs+8WIlzeV4JEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8w/OC43yrd67LfluUFis8RXgLLnLgOBKjB/G40wtEcvwh04nSL/WShtx3TilmNI7o7rkzl3T0hMbQa5d/HNQMv4o0cOZs7GkS+uIDsCv0HWDi5BHggUSBA60ISxkroZe7HB+V4jnOdmvaffcvEU7Ox0Of8XXUP4YMjcxVl8lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGh2LgNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGh2LgNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAE6C116C6;
	Mon,  2 Feb 2026 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770028183;
	bh=Bii5lAhMbOuiGNxu7r40Jd2Y0F1BQJs+8WIlzeV4JEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGh2LgNSyAnSVp4CM1KGzBttl86jXfOW4Ca4RSg4JoKmlVyKQxn4k17gsWuRIE4x+
	 QrzG0lZavgDryfCrT0180hTDaD9AKX7mEvODWi+K1BJmy12YOWdXwHl7dqGQqQufKo
	 fYnreh6hdkXr1xEXSca8w9VagTuCs8C925uffTwxBFR2xZ1NzXlBdUlqu3xvbN/JQJ
	 X4T9gIR3ckY2BRFoD4rH62Tu9QLnlNLkdGiClubG1dNc+P9TIkTjNtgBSD3y51KE72
	 xMTC7vOomVoUQV+M2qeaukqPlM+f6whb8FPnNgrTXUesqRv+qdlbZ4O7AOm48IqZYM
	 rKqHEmO9T+7uw==
Date: Mon, 2 Feb 2026 10:29:38 +0000
From: Simon Horman <horms@kernel.org>
To: Takashi Kozu <takkozu@amazon.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksandr.loktionov@intel.com, pmenzel@molgen.mpg.de,
	piotr.kwapulinski@intel.com, enjuk@amazon.com
Subject: Re: [PATCH iwl-next v5 0/3] igb: add RSS key get/set support
Message-ID: <aYB8ki7Yd468N_Ah@horms.kernel.org>
References: <20260127085410.79645-5-takkozu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127085410.79645-5-takkozu@amazon.com>

On Tue, Jan 27, 2026 at 05:54:07PM +0900, Takashi Kozu wrote:
> This series adds ethtool get/set support for the RSS hash key in the igb
> driver.
> - `ethtool -x <dev>` to display the RSS key
> - `ethtool -X <dev> hkey <key>` to configure the RSS key

...

Thanks,

The AI review automation did flag a typo in patch 3/3,
which I have released in the form of a response to that patch.

That notwithstanding, overall this series looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
