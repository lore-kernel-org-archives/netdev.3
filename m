Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE37547048
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905292; cv=none; b=cO34rH2Umynco25s7mYjN+9Yjz3gYW5stKsky+oln1lGirJsvIltEdIAJzgP8rFM0gbjsyjtGgMkxphNsPOTeWkuHKHdBqA1ipXaj0q+PqzGwRDgAuCnEAalq9gPsADbi4cxWg64yXu6lrHaSPhSwG/Ei7F11mZL+sAfpaju75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905292; c=relaxed/simple;
	bh=j248eSLYf+df8/TkTVb1pbcKGkDo9cpOKJ48FuK2QbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWu/TA9ijo+jev7atN6FImnnw1M6hMpnRsqdkGcuGWq3tAFfrt6TLpnIfhYTT3iGbqwSSe9lNck8OWgKRBMDuAKnN0MJeK6uJrO5sD7FkARtDxZQWCNLeIBFRt894t/ZJN8G/eZSCYyCsbIGLq7Sc4OR4zX3jX8cU8CZcWNgN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxgTQWFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxgTQWFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C81F000FF;
	Fri,  2 Oct 2026 01:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905291;
	bh=0DOZBDNt17kgkOTMRnLHfv+tYwiptncJ0XUdWNzF7f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lxgTQWFp1yLsw74RGAcNB2gJ+PSy19/aUNB6TFQDfK7X6IZUST9rkFh0TCXZGNBGY
	 6RZZys1aBXAc++LCet7vMAQlOEbXGvD0yT1VwavqS7zAZolKwkO1b8R1ai8jSbcFdi
	 9sG23kz+P/aML4NKhmXVcYmiFo4WPAp1nNHon1XBKNt9Ytu2pSbHk2+CilZ0UnqhXW
	 SX4DQGCy8bmHcbonitpBVINpvfBg6yj/hc+Qgb2dE+CI9HEJG0cccR+WlgaFJILcgW
	 hADAXn3uKQbTLYDI/QuRR1Ez8kjJ4yUCdBAg/kgvwTzL+pl/2f/YouQUuMOjVvfHTS
	 Pm8/Q0hAmmgsw==
Date: Thu, 1 Oct 2026 18:41:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, bcm-kernel-feedback-list@broadcom.com,
 nb@tipi-net.de, florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in
 SW_RESET, restore it to SW_RESET
Message-ID: <20261001184130.2b7ab18a@kernel.org>
In-Reply-To: <179080972360.31693.266631430009737406@kernel.org>
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
	<179080972360.31693.266631430009737406@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 23:08:43 +0000 netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

please respond to this
