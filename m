Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581F1F4CB3;
	Thu,  4 Jun 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536638; cv=none; b=Vhrn1Ff3aaFX+KpfBk6eFzW3TI7TNqkf6Th67rYkLuEwmQxf1ExPLLJpu1MbM05lZTr+igtwgEugRe3eoAfbKD8uWueO5jelE78sQ67hM0Zv+Em7SWAiPPxuoK9TJjnDd0N8mT+D+tKPE84F5VpelVh2Cef/17NVZ89CVKTc9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536638; c=relaxed/simple;
	bh=E5O4CQvdXPwkXJMo2ITuL0Zm58nCisd9Kw5BEusOG1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqjRKMiRhoWejGPjRCi/7/W+saDFpL+0B/se/dycrVqAWckJwR1Pf80KtSOa483xDz6kmj4cBGEAsJzdCkEvHaUt1RwQYqEUjcNCV3ODVSLbm2btSkd9I4h4ot7nrvdqMHeoaoQxlyn5ujBbSXGbDmj1FjjrOWlu1fhioRW8y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDXMH5T+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDXMH5T+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40C41F00893;
	Thu,  4 Jun 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780536637;
	bh=QGiIv2EogEHFCZ6gLG2NuS35JHQ8K9sawD/XXjwoGF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mDXMH5T+YgYjpWjeRD9wgaNvXS+A9PsVLasvd3/bHaBsfDJpmwoIC6+SxyE6T4jc9
	 FKSTZuH8YzcVuGuxLHf6SGTHraEQTvY/vwfbGSe66Yin1QwmFaHdQKY4I5dLiuqvZR
	 O3z9MmlO8QnjkahcqgmBvTsXzeGqtanyd6BsUevMZxZu0g1cn0WcIURVUIVsZsaWBC
	 DWS3c6ng2vdLM+3FR+N7TfhrCNncFBy4bVxr3eNpLVRqgIHjGPZd9HRvgUYWI67wR4
	 L4N1B27UGhpI93qDtmqoRd9kR6R59ZT4Mk/WtIwjXroHHYS85fqkthPi1lVxHFVxze
	 kIy/MCgZlQXdg==
Date: Wed, 3 Jun 2026 18:30:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Message-ID: <20260603183036.7c4762d2@kernel.org>
In-Reply-To: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

I dug into 3 of the issues reported by Claude here and I think all
are really preexisting. But I don't see why we wouldn't fix those
first, and have a clean AI scan. Please send the fixes ASAP if you
have them, if they are trivial they may make it for tomorrow's PR.
-- 
pw-bot: cr
