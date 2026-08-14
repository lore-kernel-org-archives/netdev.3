Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AE3B8D4A;
	Fri, 14 Aug 2026 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691739; cv=none; b=G+/becz2GU3hW9gYiI8FBxKPIiRmwmy5vLuyalM2Dl7ENixhD6gHRy5PJED52KN2ii7C5OpwJjADScKNvuM2jVt8X7YqG880dpVhFvM3mEv5PkE1c/DlmYmcEe2kK8vr4hC9iKIPoCDQUQgTHR2EJoZMJlw4aW+1JzsK7eC8ayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691739; c=relaxed/simple;
	bh=Inrp166h2GE7K1y91QM46IrBTnorXG/hv6IR62VnbTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8T8e2JtVIopxUXCjgaOeTruhIBz8CD7PqGbvEL/zpUwMgI1acFb3as8QAvSQ7EE5G+dm01oUsE2Vt8WCrMw8OtF+BH/dnAtH2qxTYfw+CTa0rB7r8zZIeTXJTolbgKx0ZB/vQMYaoMtZYjD/uqJM+KIycWRTaTUX7Iy8AnADO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svw0n5XB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svw0n5XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590511F000E9;
	Fri, 14 Aug 2026 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691735;
	bh=ztEGami85lSCZRCXrLsjABy3z5E8Fb1rYtiebbuHNZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Svw0n5XBCOtp3AgaMnTJK0PGbPR8tLxczEoaQWpZHMmmMxTnMUsftLT1UuHVevwq+
	 70QJZmYPVvcRRUfIFYZqHFu9C0/6pvJscG6BjJ4no0rncC7xW/tqTApVMOEUJrLFBj
	 pjYS1Oo6o5kmiaH8vgCKAIDtdz3DBsst2iSI0j89smQbQTSRNUxvROZ9kTCm+h44Mf
	 b6Dzb74+aNtfaeaF25L26V9yfG1CSkFXwS8JOtvFb+mish9ht2US+W7OVgawurlCVa
	 12/4A+N4a1EtIvGoLiCYx3yZh4b0rEYTOZlRodfygOmC8uLbcbL/CNEVM39tOPpWbs
	 HCS7ZFnrMyccQ==
Date: Fri, 14 Aug 2026 09:15:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arthur Crepin Leblond <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Message-ID: <20260814-violet-condor-of-expression-c491ed@quoll>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
 <20260813-wiznet-link-gpio-v5-1-ac8046f24413@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-wiznet-link-gpio-v5-1-ac8046f24413@marmottus.net>

On Thu, Aug 13, 2026 at 10:58:14AM +0200, Arthur Crepin Leblond wrote:
> Convert the Wiznet w5x00 SPI Ethernet controller binding from
> plain text to DT schema.
> 
> Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
> ---
>  .../devicetree/bindings/net/wiznet,w5100.yaml      | 67 ++++++++++++++++++++++
>  .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ----------------
>  2 files changed, 67 insertions(+), 50 deletions(-)

Where did you explain reasons of dropping tags? Why would I need to do
the work twice?

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state in the patch changelog
or cover letter why and what changed.
</form letter>

Best regards,
Krzysztof

