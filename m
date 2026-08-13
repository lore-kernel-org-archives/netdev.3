Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E24368D66;
	Thu, 13 Aug 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606521; cv=none; b=R7cwyC6DqbfDipiZcug9phm/ToF162mjrkSvEhsqIWbLCr/UAWAQ8BKWv5BfPrtSNDaOpSROTpeGUB8P0S7Slfy5TU/zZt21UshIOFYpVaHHffyLSgZJRYmq6gLvyxZOJpaM5/sKWBkltkGnzCGb2mF0VWyhSEwVNGVil7Er2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606521; c=relaxed/simple;
	bh=hp+0WcXbQliz9FzK7KYDAWz9PO/rWwIYS9MhoVRlqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBwrL9H/3YpA4SQhgEYEhvcPwVoYfUTCKjLQSkTqrZrRbUaCRgBHuYpb6lGkHUhsb4RS017M9Gq2GW7vKtbBP1x2TkfcxAnvQwsQP0HIYnnY2ZTQZVjISmn1sOOSX1jYB/FsyFQ6NlrG/f6JRg6fMP2xCCStX2Yv7VHo4n0E7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC1zaJ+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC1zaJ+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13341F000E9;
	Thu, 13 Aug 2026 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786606518;
	bh=QHaoM8lS0pMvO7A/gs7acTSlB3NxzYQrkCWA6HbNPuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MC1zaJ+5pLB2AhCI4WeYnT0igUEhmAqZsoQz118IMLs+MybJk11+lz2ht2V9aas/K
	 /cqKzxbsvPdl7hqiyAfQ4YNb4/4CA4ZbGTfgufKqKKUDBF1twjbnqsyLJFQY6Ek5vf
	 5R3XLC0u8A08vN5/3RD9P3jWEXQDckSjMFuxdOziGB93aAjnsWsqtJXqKVe0RjzzED
	 eS/clSxGo6b6b8yda+MHlYG/GflH/p9l/22+1OsI3GK0pJtY+X1Z6tHiGyQ0yrY2Vi
	 +P59bkwWHh+EDn3fbywVlo14zdVR+uOiLmo8H4Hn/6V6xUhOJ+H8mHIYTee+uasY21
	 mrVzzF+VzK36Q==
Date: Thu, 13 Aug 2026 09:35:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/3] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Message-ID: <20260813-adaptable-lionfish-of-advance-b665df@quoll>
References: <20260812175337.18155-1-arouhi@sitime.com>
 <20260812175337.18155-3-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812175337.18155-3-arouhi@sitime.com>

On Wed, Aug 12, 2026 at 05:55:25PM +0000, Ali Rouhi wrote:
> Add device tree binding documentation for the SiTime SiT95316
> and SiT95317 DPLL clock generators.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit95316.yaml        | 171 ++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

