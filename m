Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BD3D0922;
	Wed, 22 Apr 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860163; cv=none; b=o5Pwz/Vq5wRt6Ayc4adVtFRU6wOs2nZWNoyznhPz/02ywxmkGrgdXlmqPX88pi48IFn6+xWFwaLvpKIRn5nh+xFcf4Di7Us+d7NZJ3qLLZZMs3S25ZdHLXVXzRALR/2m9ONpg5vLnboeiEs4iV/WLD8Oqz2Xsu+ilQgQlZ/zzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860163; c=relaxed/simple;
	bh=/QP6CHv8nDOvg+AUR/1MSKzXuYCpyMCLVMEuIF128X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHtaeu5bAhkS5BQNiuLb72r2vmrkxjVbVrhRaaVkzlIXW6vUDZaCatWpkt8JXNSRb7HA8vYyDuogWv1HDNkFPCLXFfVjD8+/rdlC3TjDxULsMVfXEkn2T8K5LrpQaFHiyrHrC78dkraZWqoi0nmBzrKqXOnuDi4dXxFPujLMYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hljiyX4o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hljiyX4o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7a/mv4r2gbk9ugCsVdkGy9pMeQHoaChgP2wcmzZRisM=; b=hljiyX4opP9VKmb/bixcQEbs9c
	E900g9Ymtlh5xY7+zo8XFpl7GKnBGTwhWiEWDPJ42oI4LIfBwZ/Jhf2autaHlGXGw5PC0dAlfRZ7u
	OPRsIRapxmfiLiimOdSu9E4OPQYOvLixxDEGn0S+OsY+tnu7Xt/biNRhFb+aJ64fzaIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFWUk-00H1lL-QX; Wed, 22 Apr 2026 14:15:54 +0200
Date: Wed, 22 Apr 2026 14:15:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Fritscher <michael@fritscher.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 14/18] drivers: net: xircom: xirc2ps: Remove this
 driver
Message-ID: <408d1987-6ecb-4d3b-afed-8e202c8ff21d@lunn.ch>
References: <73e3a34c-f1dc-403b-b007-18ff85d66ea1@fritscher.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e3a34c-f1dc-403b-b007-18ff85d66ea1@fritscher.net>

On Wed, Apr 22, 2026 at 08:21:23AM +0200, Michael Fritscher wrote:
> Good day,
> 
> actually, I do use Xircom PCMCIA network cards (yes, the 16 bit ones) on
> Lenovo X60/X61 laptops as a second LAN card for server maintenances with
> current 64 bit distros (e.g. Debian Trixie, which I plan to update to
> Trixie+1 when available). Why? Because I have them and they are working ;-)
 
Hi Michael

I will drop this from the patchset for the moment.

Would you be willing to take up the Maintainer role for it?

	Andrew

