Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BC351C10
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145566; cv=none; b=X2MSb2EP0+92trr3jaQRV28hIc0tJNKvNADVPz8AXilxG4/6vEZmTWXa5JctRm9wII5vA1QCO+wkZZXNcJeQK8FoXIro7yjoElMCfCuNAd8N2OBRpcVJgeX/FK9L2U6ZjwVpmpdps6VqQ/wCjRBhua8IHv10KqFnCJIbO1p2nXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145566; c=relaxed/simple;
	bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6Fna2FvnS0S8rkQgQBPNDiL7jGi9/iAF57JFDrvT2K3SaU7A7YPESnOWDnu6SbBTz/mx6X9cQ6khBuq94FUXWLP7CJWj1Ohf9O1r3/Ssk0lj660tGyNjasECYiUFxIo1KI9T90Z8/sUex8KlyFHaAccEerWCLON+QY3DTfhck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIw+JG4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIw+JG4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D41F000FF;
	Fri, 11 Sep 2026 16:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145559;
	bh=LmtaT5OOtng/3d/XlKtuOLYcMnkl4rQaCZQ5X7edgM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IIw+JG4BsBbhc/SfEGh186GxlKIOGfioXRx5wnjCYSnHwNKm17QaiUkBWtWjlDYWb
	 VN4cxVtNIiMQ04kZfRoiwTOyH/TF8h0hDsXOH/6GFQM/7N4NOhnfXfeMA0FwydENWb
	 dCPybsqMFaqUEqavNqQVXcc2InZyfRx5SGuMMfXJPk40Iy6PQWbBflGDvtq0fedAWY
	 +w6DpEIWvaphnblusMmk67UoiKRypR0xrXZ0SNMnumBVrUMp85ihfAxtwQvdKewPpq
	 6X+VVN7x/4rZ4wloAFujenheS2bINnePBGZ4dniy36L+KvBe8uCCYIv2kbJqmXEQSq
	 BDElkEcdy4Whw==
Date: Fri, 11 Sep 2026 09:52:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [PATCH net v3 0/5] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260911095237.243ab37b@kernel.org>
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 13:26:15 +0200 Przemek Kitszel wrote:
> Fix OOB access to the stats arrays.

I'm going to assume you mean this for iwl-net, there are already 15
patches from Tony in the queue for net.
