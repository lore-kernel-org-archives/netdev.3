Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970A348C72
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199812; cv=none; b=Z6T4oKLZ0s1YSuLkwnna/YJMHY29odvCT+pPhVV0DSWsbcbS3aVBS9jjY3WdMK2EMlGKKrDHhjcsHbGfmliG3sq+8jB88Ttf4G/+0ZE8M3speRv4dXcSZvf82uuRkr9Y60VLeV/YOiWHh51Wdmr/4gxUyYN7VzIpq64oamYf/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199812; c=relaxed/simple;
	bh=LT6K+v7m6ZVGt3aGSUB8BJ91U19GunDVdkb540QrE3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbfzVB2imRtbYesm18M8QUJRFJkxjiD1GrSk1FgfL7trjPHo/pW+h4TrAinSFPzpQDCYXTDHgPPeXgbb09D9wCSKHkYmjyQXMvRqLLrVkIQpfA3E4y9JNuq323VGhFHU4+4m883Pnp4ZizkOI3PEXRUvZHIBSQgeAV49I4CZlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sO4QoUel; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sO4QoUel"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4YTedYV/8nP73ZKNT3MbmiH3e6GmiM2li+eX6iXEHgI=; b=sO4QoUelJ6wlKRgXX+EjvpSbug
	cT7BdbV8Q2lcAFxgLquDo+xp8rQAweCCH20u2y6EpIGoVlFW95MNAQYcT2JGOgvreOu1heD8hnRML
	sAkzFwaCx6rfGNRM0tG4+VJHJqdc45duyf8MPFhWGgprmCy/Ma+NMXafdGJvmjdvt/cA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPL95-003g0Q-Sw; Tue, 19 May 2026 16:10:07 +0200
Date: Tue, 19 May 2026 16:10:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, idosch@nvidia.com,
	petrm@nvidia.com
Subject: Re: [PATCH ethtool-next v2 0/5] ethtool: Add 'pages on|off' option
 for module EEPROM hex dump
Message-ID: <2db0b93f-d001-418b-b3b2-ac5c7276bdfe@lunn.ch>
References: <cover.1779190777.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779190777.git.danieller@nvidia.com>

Thanks for adding json support.

> $ ethtool -j -m swp61 hex on pages on
> [ {
>         "pages": [ {
>                 "bank": 0,
>                 "page": 0,
>                 "offset": 0,
>                 "length": 128,
>                 "i2c_address": 80,
>                 "data": ["0","0",...,"0"]

What is the value of length? It seems to be something you can
determine from data itself. Is there a legitimate case for
length != len(data)?

       Andrew
