Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0742903C;
	Tue, 18 Aug 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071916; cv=none; b=VI93A3/OcPM8o/9vulybUeGTeSpzWV5O4wbvwZtaOA7Y+Rv84uQA+Z4JvCN7zZerfGtiOFlVihDXWh/FXR6HAKznrQVUUq7pcf5SvQZT+AQN0QmU/TALU/id1Tjp+V+cCkKJqti2zuX8WLWV9MG6FUDt/zw6Evlvp1baMx5FBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071916; c=relaxed/simple;
	bh=CyEIFeC2hQsBt9VsmQsUa5VTYFWveHOtFT6XbpbEOhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAq626T8P3LTulT3M0aw4uyPZvE8XnFgcX0A3GKZC3zPWTO3rHbRNqbhdiUL24p1SrcVWytwGD8Htt8kB2BDg1bX1taZ0NAi0EUOJ50GkwlQBljBjF6ALYJV4oEshFSWx6aepnsc5c8dL/ZEcnsMAdZymsw8vnGpyfPd9Kw7nHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfGEckMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfGEckMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11CB1F000E9;
	Tue, 18 Aug 2026 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071915;
	bh=CyEIFeC2hQsBt9VsmQsUa5VTYFWveHOtFT6XbpbEOhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GfGEckMsn9saJWERu30pYiMPbyU3GA4BFpsslQk+mADhJfQRALnfSVbCwWtxAUtIZ
	 Omvoj95xOGUIrv7k9UXt6NoRqrM3GystqWLgkYfnSZSOeHK9q8BdaZdVlktJEZ53y2
	 D5Fls0iDczrZXmXdv3evgHsS1z+PTV3fMw3M17Nx5bpeqkXvNf985HsOkMgmzcLoQ0
	 DC6s/nTKY8gQs1R3WGPMvh6GfOdg0VrZIhF/f7+t9ESmOcXZc1I8Th5ISd9xojwgmf
	 uAT2pieOO0U7bp1c8ZTmC2bxyBcoucVxgkHkHN9bE5LSgcQQJXt1rCOS02JOsHLfRy
	 H0roThacs6oKw==
Date: Tue, 18 Aug 2026 09:51:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, poros@redhat.com, vadim.fedorenko@linux.dev,
 Chris.duQuesnay@microchip.com, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, min.li@microchip.com, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
Message-ID: <20260818095154.43f79293@kernel.org>
In-Reply-To: <20260818163746.3988829-1-kuba@kernel.org>
References: <20260814082656.306534-3-ivecera@redhat.com>
	<20260818163746.3988829-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 09:37:46 -0700 Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Ignore, got confused between feedback on patches 2 and 3 and thought
you(r LLM) were just responding to Gemi-shiko.
