Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D293D9049
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200985; cv=none; b=HypYKtddF/sKhpkIgSCTgH8yABYMfpBAe+1M3TuUC4eAVP6qm7LeWTts9WbJ04yIappiug5yNnkzk+Wp5JhzCPjOYfZu7PWjhgCpytCmCi2d5Ht56HIZYytWGxUc7/4IWzmj6PlE0pyykhZCgB+Fu182lQJnqM7Gy/G9rRdCHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200985; c=relaxed/simple;
	bh=YIUU21IB9wMtKDb5k3cUtJycso1XbTtnuYNTeLOpXFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWcJx8pnADlfDEu9cWgeASSkLW9/1CnC2Xjig6IGgC/n8oMQOKDqcC4Fsj8OsUz/tsxtESHMNSPJ82uw1lhlHn2DY4fNegCvoe5ymI5Kj5t2hU7+/pJAI49Wy9sQVw/IeVQy/e91i/BL4FNQ7rfcmxL14iRqCdymf4oJNUBYWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUURnUy7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUURnUy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91DBC4CEF7;
	Wed,  4 Feb 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770200985;
	bh=YIUU21IB9wMtKDb5k3cUtJycso1XbTtnuYNTeLOpXFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUURnUy75lFJ47lfvr6v7SQEKYbogXwdwVBX1uYvo9wwxAKPjry4jY7BZ4Ftr3Bsl
	 o5wrRfoxCcGXcGLhwN/yErAUskFE3Sl/Yg8+YDSLjQUr+FuB0PBASFq5bdNkfNpKJX
	 jOA73CIpo8zd3beVs1wR/MzPrPnLaBIjfTjkfuDszlImxkbm314uo1+gNZj2M91kWn
	 Gmn0q7axBlAROst6JIxfM51NoUMN4yo+0gVnH2bxfi8hguAEL83m9A1GLn2SSuW2Xu
	 TNCtNQiujADfonQ2JDOif2BJzcYBhCSGWrEFcMHcxscX6eGEzdrAUU4Zf6/X7VpECH
	 NdfWHDa+vtwfA==
Date: Wed, 4 Feb 2026 10:29:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH v2 iwl-next 3/3] igc: allow configuring RSS key via
 ethtool set_rxfh
Message-ID: <aYMflIxseCDvgmdq@horms.kernel.org>
References: <20260131163037.88108-1-kohei@enjuk.jp>
 <20260131163037.88108-4-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131163037.88108-4-kohei@enjuk.jp>

On Sat, Jan 31, 2026 at 04:29:38PM +0000, Kohei Enju wrote:
> Change igc_ethtool_set_rxfh() to accept and save a userspace-provided
> RSS key. When a key is provided, store it in the adapter and write the
> RSSRK registers accordingly.
> 
> This can be tested using `ethtool -X <dev> hkey <key>`.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>

