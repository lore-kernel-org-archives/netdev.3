Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C5332EB4;
	Mon, 23 Feb 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868350; cv=none; b=U2kvYgQ0Uh1scgjXDqz72IBzsAvfnJkAHXEKyVgHTKxXAkrjX99+KkhzjFYKMtisVQyRnlPBzq+0M/mLJObAzp9naypwoN7SyDxBEzypuoQrYwZSZIbHVAGwlh9yraI/z+mRM7C2b+cSwAV2Lt4B/QZWha+tQ0mnsQr3tIYumPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868350; c=relaxed/simple;
	bh=qW9i6zN1CY6w+IeHjsOXHWptGUB6blB9XwWVVi+sh1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXPE7UELajyeIkkSCMMSa5U45zmH4OUnn80XUCgH+Q8WanTx104rCbLQKmYo0EpaE7PY4XdFuyeYjjEB1qfuS0f/mUBOxLSiOtV/m4AECsehelmmlaVezRB647IlMYpzHdlspAJR58kdogi23q6Y6qsppBFegrXmQPL+OjpE/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxu/8cLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxu/8cLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1EC116C6;
	Mon, 23 Feb 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868349;
	bh=qW9i6zN1CY6w+IeHjsOXHWptGUB6blB9XwWVVi+sh1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wxu/8cLigHMnzGFEcQNnYenuwJd9vXt+eU8fmhzNlvcNnWrR33idDVrz8YJ8qZ8gt
	 sit1aDhavzpGKZqmNzq7HrFUWgnp//z5HMvlNmHq8AAmtREXxi/elr3TceAnwnrcFF
	 /VevfSQhsH97GE1xcZsAEsNDV3hU/XGigy72iojdrO6PZE0hz2XRYC6EPcqziISq0b
	 WoNh1FD+F1e4PMqDpcJH25ffCZfGGLuIdULPOL5bv9eKCVJYY1onKNieis/qq02d7O
	 EirCDVRx0nMQ95In+KE2frbAoqPyNyw1fg3rxYnsgH+xItEIIHvriReHMjGt7chd2S
	 DsV6MQiziaDmA==
Date: Mon, 23 Feb 2026 17:39:03 +0000
From: Simon Horman <horms@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, mwalle@kernel.org, nm@ti.com, v-singh1@ti.com,
	vadim.fedorenko@linux.dev, matthias.schiffer@ew.tq-group.com,
	vigneshr@ti.com, m-malladi@ti.com, jacob.e.keller@intel.com,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH net 0/3] Fix Unbalanced IRQ Enable for CPSW and ICSSG
Message-ID: <aZyQt_K7z6OdjP-K@horms.kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220041431.372610-1-s-vadapalli@ti.com>

On Fri, Feb 20, 2026 at 09:41:56AM +0530, Siddharth Vadapalli wrote:
> Hello,
> 
> This series fixes the warning:
>     Unbalanced enable for IRQ ...
> for the CPSW and ICSSG drivers.
> 
> Under heavy traffic and in an SMP environment the warning shows up after
> a relatively long time. The issue occurs due to the order in which the
> variable 'irq_disabled' is set and the function disable_irq_nosync() is
> invoked.
> 
> I have examined other drivers and they follow the right order which is
> to invoke disable_irq_nosync() before setting 'irq_disabled' (or its
> equivalent variable).
> 
> The first patch is for the CPSW driver and it has two Fixes tags since
> the code change associated with the fix is for a recent commit while
> the incorrect order was first introduced by a much older commit.
> 
> The second and third patches are for the ICSSG driver. Although they
> are both for the same driver and could be squashed, I chose to split
> them since they fix different commits and need to be backported as
> Fixes for the respective commits.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

...

