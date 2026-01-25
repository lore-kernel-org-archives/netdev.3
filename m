Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2D405F7
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358772; cv=none; b=KLyZ6pVWsRgIb2Ac0gTq2ya5BZbpaAS8EThnO32NOIbUV5VFAcvd0Ubq7/b5p5rdsmqYEXWZBv6+I6S8/xhNOyXLCuIRFwPsc3xfM1PtrleVtKyqMGQKXF+cGu82/xUHv24VSbyZ+ng2JfS82Ui++mGYa6XlcTx9jf2ZXSrFAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358772; c=relaxed/simple;
	bh=HWVhKVtKS6pIKAHzsk413fQ4HusFYYygmqjAHWlFV/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9kaUaDnAyQBSMrWxoobmW0MI1wiwwVwAUGw8M63yMgCvifnXSoDfC7/5dPMPCqEaE68G0yqkVvQf3Iq3XYEefzrP+S5eLCU+qVWnv2I8CX7D42YdLaJ4oCVgf1UscA3+vY8JEsXel9SGe1QlqcAIzIaCWE6lhmQ8tC7g0lT2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PKqvWDXG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PKqvWDXG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=IeonbQaiFnuzYCSWPOrvuux+QANreGFB73XTpUc6yVU=; b=PK
	qvWDXGh7hIPjuTnfokLuFunJEwCjB5lhFK2OHHBQYrNgVQYBmklrQvd3rtYb4FSR/FuJGVqzlxc9T
	ATWCK0fQ7sAe+LYL8gKVlY0/Omk0c6wp/j3aJr8d5HKt0drvQNA7yiTsCMMrNSwz03mtUU4JN6sAu
	eOpSYJNRWBTiZRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vk32e-004cqv-HF; Sun, 25 Jan 2026 17:32:48 +0100
Date: Sun, 25 Jan 2026 17:32:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection
 failing with overclock
Message-ID: <5e52ea32-a79f-40f3-a62d-4a8af6162934@lunn.ch>
References: <20260107071146.30083-1-enelsonmoore@gmail.com>
 <20260109180147.GN345651@kernel.org>
 <CADkSEUjEobNfmnq1vZz5mr7rDs6hN43LeOk1UJ5gWW_jFFHhaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjEobNfmnq1vZz5mr7rDs6hN43LeOk1UJ5gWW_jFFHhaQ@mail.gmail.com>

On Sat, Jan 24, 2026 at 11:21:12PM -0800, Ethan Nelson-Moore wrote:
> On Fri, Jan 9, 2026 at 10:01 AM Simon Horman <horms@kernel.org> wrote:
> > In any case, I think it would be worth providing a reference
> > to the commit where this was fixed.
> I just checked with git blame and all of the mdelay/udelay references
> in the driver predate Git history.

For commits before the beginning of git, we just use the first commit
in git.

     Andrew
