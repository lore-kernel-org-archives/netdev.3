Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B358221FBB;
	Mon, 27 Apr 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332197; cv=none; b=PhDW4qCjutnXEV/k4To1x2hwYCCZ9/gXYlAUcEh25g+ey47lJbFcGXpdcP+2wF5SfSE5m5zfeJg8TNuaGcOVEkKMcxsieo0+UAgOKCObs3QPFP2dhXlB4/nBwWYmR9EjlzpD1sSRSTtMdturliA1l0Iu3iKAo4R0MYBv1ERRMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332197; c=relaxed/simple;
	bh=Ddrs/UQbLpt69ZO8G25NpUQNwuWYdy//XwqSK0PvFH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWaWaFPOurhWp6JmaSQJS6O1Q2S4tm9ZgpBu+mnssHncTzJrk61cIPEZWQtN2PvaccdE9JnTWZrX65jR0UKf593X3nmxP9ekdSbm7XWB1m/CPIieCEUetw7ayRWcxi3xVMKMZWNLjv3uL410USiYY6DXmTP7suGXyehu+97go3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si/cEtvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si/cEtvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B84C19425;
	Mon, 27 Apr 2026 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332197;
	bh=Ddrs/UQbLpt69ZO8G25NpUQNwuWYdy//XwqSK0PvFH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=si/cEtvfB4SzbR/leFNjGog8+/prnFuAFeZvSX2AiA5N/KP52kEUvw2kJJfWQNwh7
	 WoRbKOnPkH240C7O2qevmYc8K8atQqi1B3Fjd0x5jTlAnSncQk1vJbqYvAmqf86jbp
	 NVIRmenNkaWyen793uuSoURlfW8rsR4DlVnXNYRqEsYaBqYfSNl0PLYZqHNStd/Pg5
	 RbMfrrFKUlU7jYLof+bvia7HeIUW0MBA5ruGx2tt52Bnq5cLgcfJkU/1FxLkhmU31u
	 k32aI27PmqFMCTI8HzdnJX/f6p+oDlUEbbEodGxCBrmYwft+U7TIvpnBtmAdIfe+jM
	 Epx7EAc2eEx1Q==
Date: Mon, 27 Apr 2026 16:23:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, pabeni@redhat.com,
 dev@openvswitch.org (open list:OPENVSWITCH), linux-kernel@vger.kernel.org
 (open list), Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/2] Decouple flow operations from RTNL
Message-ID: <20260427162316.63eb2725@kernel.org>
In-Reply-To: <20260427091153.3210301-1-amorenoz@redhat.com>
References: <20260427091153.3210301-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 11:11:46 +0200 Adrian Moreno wrote:
> When RTNL is contended, network-related control-plane operations can be
> delayed.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer
