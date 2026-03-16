Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16B38F620;
	Mon, 16 Mar 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656646; cv=none; b=EeWP3RCtYa1AW6Pp/fUtY/0u2opwcTNFs2lGFrwDXBNGTPGmwKbVkS7M+3JzRUFGuvyIFugt3x7uEDVQvcJY+G3wm7V1iKj2HdkrAHoqWcLPBW81dzKZZirS/cPubdNQdokQypytq+FAgieMAiZZV2V9z7aoyoJpt8bTY+MNS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656646; c=relaxed/simple;
	bh=/VGJMds3ORqj9TFDUkQR2erg40cWpWfMoN/aPgcs/wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsDGUIPSF4Pf/Y5IDfNNn3rc/eh1HpzsQNfO3yLigP6M6dwhilCOHV5wUA30p1wYBsk9d/24TMOBPMLEsJKc7frldPZlDKIrQ/jQeNc0I0aAIVo51O7XHP9FR+SvS/RScO5uvirBffFCcnlPDYzh5jM+yv3VpodnjRVcIt7wqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEQ/s1Ih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEQ/s1Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83E4C19421;
	Mon, 16 Mar 2026 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773656645;
	bh=/VGJMds3ORqj9TFDUkQR2erg40cWpWfMoN/aPgcs/wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEQ/s1IhMlnTgqpa7+xpsEgyczWYJyFH2Ww8vlPMdcnctp6PLbMpjnibdKz/mJibd
	 xvzgk3gyQTfDGNcCpgSztu47VbQ2IxZYdzW3S0vv43ueZMUPfqgW3fhX4o5m/JPiAm
	 /waOw/wclhPc1A885xYWGMovsnieFILGOGepYzokJJzWDOfaqO9Az/uaef18Fqwxm5
	 q19C5nGqBZ4DjNT6KdXmS3lXlsEoYs4wjDFxC042tme5olvynq1o4qQj/v49w7mLT6
	 KGAnkEjnAgLLj1Q45K37slQ6g8n1E+w1ULxRSRDBTHk0jBRsiaZ8bpXhyxGy5zgSg/
	 1o0d+VnUm6moQ==
Date: Mon, 16 Mar 2026 10:24:03 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <c28d7cba-3805-4e6d-8051-d12e923c1973@lucifer.local>
References: <20260309022013.5199-1-fmancera@suse.de>
 <48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
 <cd87ed46-b774-4896-b25e-4806eec9e0b3@suse.de>
 <6c005900-3461-4e3c-a396-b2984735af9b@kernel.org>
 <51102620-fb8a-467e-9144-786d1fe27e31@iogearbox.net>
 <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3cd289-2b7a-4f64-99f6-05eb9d67c0fc@kernel.org>

On Mon, Mar 09, 2026 at 02:02:45PM +0100, Krzysztof Kozlowski wrote:
> > Are you talking about [0]? That's legacy hardware and in this case just
>
> Dunno what is legacy there...
>

Is this satire?

I'm not sure why you're being quite so aggressive in your response overall
here, but Amiga is ABSOLUTELY legacy and you are delusional if you think
otherwise?

I think the kernel should absolutely drop support for it, museum pieces
like this cause undue maintenance burden, and sorry not sorry - if you own
hardware that old, live with using older kernels.

In any case this kind of facecious engagement, especially in response to
somebody as lovely as Fernando, is really unhelpful.

If I'm wrong and somehow Amiga isn't legacy in 2026, then SAY SO instead of
giving an unnecessarily mean, dismissive and frankly embarassing response
like the above.

[snip]

> >
> >    [0] https://en.wikipedia.org/wiki/Amiga

Thanks, Lorenzo
