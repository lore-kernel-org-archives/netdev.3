Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0631917CD;
	Thu,  8 Oct 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475764; cv=none; b=Vyw3NEahVbzUBbHuTJRM/GWE8ZqFn+e2Hi9YDBskBmVB97qrnHjNsy/vOGSojy/XvOJJ6hkx8GfA99WT7M6kA5+LM6wN9nycPLJRGihEwPbJmyt1r7pucZwCWpCvngzC1/Jc6y6SZYstC/5UtxNYnnQQNdFqZMe11tXxk2SVTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475764; c=relaxed/simple;
	bh=rN6QrJ/FderrzX39LlRDRqRkwnU+DF8RSBIFIMzVrsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzSLQ0xyRd98LRQ/GoZeipdN21QfwJaF5Vjh+iyLm4OoJxyww3KjAfOM/49GPRi957eeudlivIeJKEaezkvmStKIjl16qYoNPgC5ncFLzXGrhBtltoURJc13GsFK7VdEYIgPHcJXbyA0I8i/4aQNTyrbl8XL9uCDXj2q/TZNyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZJ0JpJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZJ0JpJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9AB1F000FF;
	Thu,  8 Oct 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791475763;
	bh=bN1u4IzBX5QN3dtKatmh/K5Ots/2e5XCrv4nvQYwY9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cZJ0JpJHTBXRoqJep3kF/PeYnclWApFqAggIdgN5Prhp63nKnrsyG9907fONBPK9j
	 IiRDzCFkqioWyGUG0JFPwrrJj9kaTMgO4OKOMEQUXiN33SFkdf9j8XSYTMX3EZcGRi
	 3EEzP43bd9rcAndeUraeczs1yNRCONc0VlFgXKI2ZrLMM0K4JV/tnKrCsl5qVtr57S
	 hoS3xINXD6p8snPdMgbYvM/et2bOEa8k7Sf0bY7cn1EQuXbzrfLRVUo0PUiBatkwzW
	 E7mN+Qky5voCPLWlDvNWfvtEbvckysGcNNXFzbM5FUqYVaTjORTQS33fL/tabyFT4o
	 bpygYHYM9Cmqg==
Date: Thu, 8 Oct 2026 09:09:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: qca83xx: read resolved QCA8337 link
 status
Message-ID: <20261008090922.070cd86b@kernel.org>
In-Reply-To: <20261008160558.3966456-1-kuba@kernel.org>
References: <20261006160316.1356-1-yongzhao.derek@gmail.com>
	<20261008160558.3966456-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Oct 2026 09:05:58 -0700 Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Ugh, the auto-email did come out in the end, ignore this duplicate and
pls respond to the other email.
