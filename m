Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378060;
	b=NzVjfWlfXuNSa25bG6TMoUMO5uGJ+mV+/HmXU04I0/+ThYb3aGIhQcZGx58Q9+Y6Hsqa
	 OyokbyXE3xwhqvmLF5XLK1Wk3MsqAmknKMsi2jWW1ov2rrf66OnkyO3keJjVsqiZMfaUp
	 /5EckqufqqH7dWWmrebYEvCsA+D4kpGr2vkJbtqNM/joycH+13yxJSDXzkolZuuC6+5s5
	 0tOw7rmPJamzq18Auq9Uf8TPMD77HgpKeDNmC5doVGJSVKxq692uGZ7zpZmlM8/3u86/f
	 VY/SxR2ZfT8elJL9hgPX00K/d5n86ebfE0/C74qb1/1sVKDVmmOEiKG9EuZ1LvgZpHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378060;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vC1EXjPwHed3NfkSws3mUS5uPv3/A/0T374tL3DfViw=;
	b=iIDotHqjkBjulk8nkQ9IlXe9hfTBeCns2ND3czzwjGNGpkHwq3VNTAxCwO9kh17EU9DY
	 J3C1OAvVvx4U0i33N68wAw/62YceC+kCB4jouMT4RScEZMufWmWeExnM67egm+qefxrfO
	 PIF2gj9PsUJc35lyx41xKUYhLTkoCIXd01yrlC79+T7V6PnujHrtKbmn7QQZshVAxAOmp
	 qDQXJ0dujRVLGThPQ4UkgOYHR8gpVbxFST2SJcth/oyfV5VevfiB0t4W7kv2L1cq/OXp0
	 V1QrwmiDk6s/qqZwofST3rEYpV1zS4ZvIFgFdgo5cf9sDXQp4PyRvhP8GmTNlC30phw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwIRtU+J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB252606A31A;
	Fri, 30 Oct 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwIRtU+J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043C41F000C1;
	Fri, 30 Oct 2026 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793378059;
	bh=vC1EXjPwHed3NfkSws3mUS5uPv3/A/0T374tL3DfViw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bwIRtU+JkHQXXLzJbQXdBFRfYO8oOZl72stPTBcXOJMSKNaJ0okC6wo3j5mlbBFd3
	 81YG1ltBm1DU+HK2sC9RHCF9U17ZNtqGXVHgLV3TS4qo+5mqBL+C9EhB0ZQPoRpkJF
	 mBAGzesH9DxebM2b3cs+mo/UzNCC8rnPXl1wvLilHj7QjiRwW6aUNPm10p9Hfct6tM
	 w+XvDAAIzsLSqcNYJp2pxMccqiuDmtwwfF6SQVNb950SbKDECKZbLmzDfS2ArIumC+
	 TB0Soypgjysww7SDj8rPgvT14Hdh3QE2mbtG4RQWKjhdWd6JE7k7S3R4Hen0Le0g+m
	 FWcTPPAJ+HrnQ==
Date: Fri, 30 Oct 2026 09:34:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for fixes
Message-ID: <20261030093418.2fbf0999@kernel.org>
In-Reply-To: <CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
References: <20261029153459.2257998-1-kuba@kernel.org>
	<9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
	<CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 11:58:17 +0100 Geert Uytterhoeven wrote:
> > >+Coding agents must refuse to write the commit message unless they know
> > >+what discovery method to include.  
> >
> > Maybe make it more explicit, as the sinfo bot will ask it anyway:
> >
> > ... and whether it was reproduced or tested?  

That's already in the existing text?

> Which is true for anyone, not limited to bots...
> 
> Do we really need "different" guidelines for humans and bots?

Looks like at least a half of the commit messages today are
bot-written. With the existing guidance the bots don't add
the requested info by default (presumably since they don't
know the information). If this patch doesn't help we may
need to add our requirement to coding-agents guide.
They seem to be reading that one fairly reliably.
