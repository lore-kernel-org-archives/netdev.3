Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A33389E02;
	Thu, 21 May 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358685; cv=none; b=OpRo0ri4Yo+MTgMVm+4gRJnRFpbMzE812SiHDGKHbcIBSK0uK/aedDEwTlffbI8S1rGheicr45ss3qf2Y2s35YNiSp4TJnTWqSRYk3IG/Xx7rcTORqChCprPwVJGq9zOPFeZdB3gLvptpDGmz5YqZfXCMAHwkDS5RhqF/vUjRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358685; c=relaxed/simple;
	bh=G9dUDE57/plskdTOGXGFEUmoJDGDjy6KP6TN1k4cH5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI1K3B0GgO5XJ8qGs90wQvbFQ3uHUXHL9Poipr5MVjN11O+K/OmJ7trdVtEUtUWAxzSp1plZOO9TeSemlZTR9OXxhVQbgzizhj8+fUHZ0io+MTCWnorVDnM12wFu49senAprez9F8nDRlpK83K+hIBwZBuaIyTZ4Dh7G2cGkVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPUhabzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPUhabzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8C1F000E9;
	Thu, 21 May 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358682;
	bh=cWklvZ0hMHT0iogyKba21Wxgt77edXzV0ISJvMVJQ9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BPUhabzhrsU06hASnrmP4UJERr/cN59RiKfzgMzwfGfZruTBPzro19zyS3w3xoIEO
	 ALv/ZpRMPTUXe/W/cHjjMKY7J+yPZNOqbM1Nr34RxPNbDbqjy94dL0oSM9/u05+6RQ
	 N3LSLEZ1+wJdsPdc+rfimQrBUBb8EZ3iQZk2eTQhfsSSv2ccSFjFMrMa/n4Ik/++v/
	 8XqDIckAiJUhzNCW54Y+Zl/pdp+iLHoFf1Joma3OlZDg4mHJwRFyVxHomnuROMSpVb
	 hdPgKSFlI0EW2ZXgX49QnBfH3jXO77sL6M921cdtdUR/MdmDxVr6eIk6+JgIRwoAuc
	 SwTMXkfk0yoTg==
Date: Thu, 21 May 2026 12:18:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <rouhi.ali@gmail.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Subject: Re: [PATCH v2 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Message-ID: <20260521-happy-celadon-hamster-94802c@quoll>
References: <20260520191943.73938-1-arouhi@sitime.com>
 <20260520191943.73938-2-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520191943.73938-2-arouhi@sitime.com>

On Wed, May 20, 2026 at 12:19:41PM -0700, Ali Rouhi wrote:
> Add vendor prefix for SiTime Corporation, manufacturer of
> programmable clock generators and MEMS oscillators.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>

Mismatch in From/DCO.

Best regards,
Krzysztof

