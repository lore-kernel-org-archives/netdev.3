Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90814481FB9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036798; cv=none; b=pFlZ4aoNQOVogZUBUD4jLMS3BaZlJfip1yb1drji4qEJRBNulhcBdgNRCpBx6MH++52fl7NqGyXtZEsgtGTg9p5rRAZWSG527rx0rCedHs0bzf/pdBYZIqdBDKmftOaE+sjuBkEM7yEFvcvq76T9P3BxncqWPQZg/CDzCM7lNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036798; c=relaxed/simple;
	bh=DyCNqVxC4kxHWHN69j4Mw0AgSOqg2fmrIPK1/F7v50A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW0lfxu98ack5dD4eTZBuJNvhuRArPDiW2HQoQNZNNGbjEvH6e1ouyiitr5B0w+rpRgAazQw/ctHFqoVDnwCDcdUR6sdLkViDSD9AeQEmZs8L/XkLLhBBNeNWcnTJatCyODA142V7sKeZa8P2RmZe+utPQdQ1NNMx+ZDxUeB5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxoqCkJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxoqCkJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D981F000E9;
	Thu,  6 Aug 2026 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036796;
	bh=o8pnzIzH0Mov4RBerqLZFRMgIBht6EOUU0eiRTKqTcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lxoqCkJCRzm8ZfMJVkg1M9ZWSk2GmPBubGTapIT1tH6AivJXadleRt9BkgdMvX+Xi
	 qa344fRIzmGORZ/aXDScvulLCAqnZlNIqLAA7RvOyL4HrNLPWLLic3nyRJ0ZNqbfwn
	 s7nan7T8F5v1q+aQOLc3zocpk8Loyg0LbbLiAm+HcnnC2ysGFSlNXM0kRGtrTtvuvX
	 087onIVStFIHnQO/FDSYiYngfLdSm61z2XGE4+306+rd9rXj2eAiUkwroJeXTG/dPV
	 YPR9Ay1dDfie5uKmTSHpj/qsuY6a8Dmkqp51GSPoJ4HUkV+MnTH7HaxOAChxxKfQfp
	 Lr+Adb8yD2cVw==
Date: Thu, 6 Aug 2026 10:19:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates
 2026-08-04 (iavf, i40e, ice, igc)
Message-ID: <20260806101955.69cf2401@kernel.org>
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 15:21:53 -0700 Tony Nguyen wrote:
> The following are changes since commit a347304b2ca1a5377d5bd2d8a72e4b4f12afe648:
>   net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

I'll pick up the last patch and send the Sashiko reports for the rest.
LMK if none of the reports are actionable..
