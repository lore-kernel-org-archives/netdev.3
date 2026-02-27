Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D02309B2;
	Fri, 27 Feb 2026 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236548; cv=none; b=LyDM1Jb0L39AEncH9Wm1R2ndHeHb+XRGpTusW3aYAJf4bokA8nHaOV9A7e3VhXfg+yZHDU/aPjjhAOdCQHHkTweoC4wx0S0ZHL0r+02OpCZX09FT6yNiLrVQGVdYzqBDb6KbytaRG1gByjIak73hhCESdCaabhnfWc5YxnTkMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236548; c=relaxed/simple;
	bh=BM8DA+vrzH4Kr4PAlA/qQRdglCHh8ezdJrAaJjQK5Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0Fp3STMEISAKaW1kjLxxLJVFlDKVAmSj+YqpBB/OzPO/Ooay8KirqiDf7TOAzFSgZCQY5U5P4/ezsn74ANnqg/efOHYZMQEinmOAstcxttuf5uf30FdbTv8NySZ5GbhRjKLT9DZtVSd+JAtX2dYIobUurtdxanen1fxmo65fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjUUmxG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjUUmxG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBFBC116C6;
	Fri, 27 Feb 2026 23:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772236547;
	bh=BM8DA+vrzH4Kr4PAlA/qQRdglCHh8ezdJrAaJjQK5Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjUUmxG5ouxd5JX4NaC9AaykzO/pIUVdGfj505dHRFc3kEdy6JX9g/c6jhtvvyNOr
	 6xufQ/Tq0c63ugk9Nid+WOf3DYnknrygWpl/FWqwjXn1tV1kmqKlFSna8NHMg98MxU
	 p88wvz5hBBmMRxogIvFo2nW4d1zl9BexbUymIteHELkY93NgN0Px97aHb1hj2kToDu
	 LhdbpMiSfeAFp2xgFUeTBpsvQcSLZy93e3VQMTbEf4wRCB7hyDRCO0rfgTBPP820mK
	 mYiBBLRpA8iLAqKIGxJ6Pux5Umj1x6uveZmAouFzbPDYnrd5cMLAqThvAmuUgQE2Tl
	 5R/pVUiCQWllg==
Date: Fri, 27 Feb 2026 15:55:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: cedric.jehasse@luminex.be, netdev@vger.kernel.org, olteanv@gmail.com,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <20260227155546.6f861f76@kernel.org>
In-Reply-To: <f6885957-998c-4793-93a0-d3cf957ba702@lunn.ch>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
	<20260227035537.2630823-1-kuba@kernel.org>
	<f6885957-998c-4793-93a0-d3cf957ba702@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 15:06:35 +0100 Andrew Lunn wrote:
> > If entry_add() fails after some entries have already been moved to new
> > hardware positions with their hw_idx updated, doesn't the function return
> > without rolling back those partial moves?
> > 
> > The software list would then have some entries pointing to their new
> > positions while the gap for the new entry is only partially created.
> > This could leave the TCAM in an inconsistent state for subsequent
> > operations.
> > 
> > Is there error handling to ensure the TCAM state remains consistent when
> > insertion partially succeeds?  
> 
> Can we get replies to previous versions of the patch series included
> into the context that the AI is using to perform reviews? This has
> been explained once as being safe.

It should fetch the mailing list threads from previous postings.
but it's a bit in flux because sometimes it sends too much $$ doing
that. And other times it causes too many false positives.
