Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221673E0C7A;
	Mon, 27 Jul 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182373; cv=none; b=UrYZOOjclzpjpasDYDdCGVcNys6TPTS3A2LDRXoTCmo/dOccwrbfxqSLslLAYQlQdxHNANdsLMTQlAz69bSzDORZIhtZbRnBxYvoCsbUJWPJ++0cyL1nZxAsGyx1zIb/22ctQKYFTJq6c/QEqpSmxU2hRjd2Zq27mBCFaV6snuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182373; c=relaxed/simple;
	bh=FLBmVTd819rjVdz6WKwpajtkqhS3+hfih6Ghu58PyWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NssE4b5ozla73rFQoMyIWnKeHR48OUWgxmL3Mwl3crLxtRAfzhZA8dnRf2nww4voEz6c3jDLNM4hjOASL34ToI+vExZZpvl6o7RZ8CV8GmyisUgWgsNOVj0uv07nobVeWUtvl+CUkgzt358vISfDFih77i3VFeo6GGSP5gesAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpe8V1qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpe8V1qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140551F000E9;
	Mon, 27 Jul 2026 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182362;
	bh=n/yvjIcw5QaNnhiVtdTRqE8CydXDUvrWbE6SFMgpj/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cpe8V1qoWEZ/ikuucBiwtzmd87494Dd+/pI83F7qba4mdWCCpw0TNpRn76kkJ9Aym
	 qNUZmXL+jCEG0dwxX0y0LXEApaGEmUMVurfpDHoEwCdtVzA2urH/4SUhiWP3Qwad/N
	 0PDMbYMJPcqsy0XUrvvM01IZxcUZzGjsUWtp71i4KkKNQqXPueWrrvD8B+tlBgB/LI
	 CqxIhWXFMgos/RkgnziEW4u+3VkaKM3Y5RxYyK/m5M6sHv6CE8OrEZymQnMy3buaNf
	 iVPrTezMjhcl9UTpL1dAfFq0uZbx2mqysEOHOoU3l6hUe9RTVz8JALsBeu2eSJJnjW
	 1HwRLGL36/DGw==
Date: Mon, 27 Jul 2026 12:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Chris du Quesnay
 <Chris.duQuesnay@microchip.com>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>, Petr Oros
 <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman
 <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
Message-ID: <20260727125921.2e16bed9@kernel.org>
In-Reply-To: <B047A851-87E8-4156-97CB-117A71CDBCD8@redhat.com>
References: <20260713103739.1553284-1-ivecera@redhat.com>
	<20260713103739.1553284-3-ivecera@redhat.com>
	<20260722135848.2d401ada@kernel.org>
	<B047A851-87E8-4156-97CB-117A71CDBCD8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:33:35 +0200 Ivan Vecera wrote:
>> Real dependency is probably better here?
>> The Optional is meant for NICs for which PTP truly is a side-feature.
> 
> There are some chip variants that don't support PTP. Should we depend non-optionally?

That's what I would do.
