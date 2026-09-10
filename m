Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A14A64C9;
	Thu, 10 Sep 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051936; cv=none; b=cXZwtJQ9sdJHJUG7b9gV9lwM52VrcfXZyuDYgjg8uQqkh7viAx59o2jApC677I7deMnLjNw7Qn99y0KVecMSQyNnq7wZO6TVPZxVRi8QulRWOU1jtd5bswoAxTsOrTto2yI/tmgWWQmxmRt9B2mVmiH0GD46cYEipWUAk9GGqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051936; c=relaxed/simple;
	bh=p3XsBirz9OWD8wxGJkEUU97/T5rMCjKQL5F2/+Kyzn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrv+NE7dOBQYw2WxQWTH/B+u39qBDb2nsbyHkVhqwHzGE6vz2QJei4bEEI7aiD0znip3kOjCKSiwmfrxNjLZh86xaspJwJ4APnmGAmhu9+I+YWwtBgQ3GE6V1l5yQh0koiVht5eh0Zh6mj0quQ+PT5tR0j/VwNLsYILSjnUr5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAxuq2KH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAxuq2KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BA51F000FF;
	Thu, 10 Sep 2026 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051934;
	bh=p3XsBirz9OWD8wxGJkEUU97/T5rMCjKQL5F2/+Kyzn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fAxuq2KHHppscY4WjUklPWJypduF1+x+nenA1H4pWVi9MXtyBKoMz6Nt1KnUUT+jt
	 xfpGg05LPRVLjxgWuV9M2IaM78gx81uRPq1xqvWmXUlNTu4TOJWsHCVfuEClKtrAJ+
	 Y7/VLs2kSqRuFu8Q+d5iafy/NEf4SJpgSoFuyH9BbEu/kcP7fU/cXlg/hhRtRdt7vO
	 5+irLpBDFRTb2biEa6AxvqlVTm0xBYrpnQcdBZo9mwuE8m8B7wdS//31juX3bynSL6
	 Z+xaTOgvLbwDjquNsLKXLXvqGSRks5ngH57ELsQrPSiWjRhfcWiGwo33K/vtGmS7C/
	 nCfT/1BycneNQ==
Date: Thu, 10 Sep 2026 07:52:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>, Thierry Reding
 <treding@nvidia.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Message-ID: <20260910075213.1c9aff98@kernel.org>
In-Reply-To: <20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com>
References: <20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 13:50:46 +0200 Lorenzo Bianconi wrote:
> stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> the PTP reference clock enable and stmmac_init_timestamping()
> failures are logged but never propagated. When they fail, the MAC
> system time counter is left in its post-reset, non-running state,
> while the driver keeps operating as if timestamping were up.
> This matters for TAPRIO/EST qdisc offloading, which derives the EST
> base time from the hardware timestamp counter: arming the gate list
> against a non-advancing time base would leave the schedule permanently
> stuck.

pw says this didn't apply at the time of posting
