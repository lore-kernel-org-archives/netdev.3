Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A3399001;
	Fri,  7 Aug 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111293; cv=none; b=hhor5eAQLefRJe7uJHwEZQjvSXhxc6xnzF2YJK+zIlV9uz3MRokLURFTElOZOPwBsLNuhjP4sI1cpHB3fzRNEeY929Z2vVF0vCjeZoc+9PGNIpVkwlUJBSQMeqD8OtZTiEMB74v3vAZCy3JwxoZMGrf+uw0gWTH88SAdZHQu4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111293; c=relaxed/simple;
	bh=QoV5/1tHFAeAzzfpzULNCDUJoDUKAI6RgYqyanrPhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHT72GPT1EvB8Ls9R02iui9OU/gOZIUd7Jv7dTw3Kw2dNdOQHAtIdKMaNN2KVLJa5WYQJP4bS7jj7Tb58BMn2wCKJwjZcz0IDrEdLoPbbtBCmeLaEJmXUlXLeRdnF8nnEar7vFeZMSt6W6t8yD67V6zSdVv6a/pCu4R9M664nvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SY58c8Yv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SY58c8Yv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=c2uA+ah09GU3aqnZrtS4ICVTsAXl85bFZHHBxjxScGE=; b=SY
	58c8Yv66vUFDTGJMFvRE7xoI+YBWjbI2vCttqWFfyRJaAyvLutOcEZk42m64tC5CmGr/f0FWo2HVO
	oOcCOqtyc0O9XLXjAt1MQgspScJHToVvtKU8i2DyopqQV36LvQEpZ/DUvqM3gxEN6NdENpAz8E1HI
	yc7EGOXoc4bmkR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsL8M-00GbFc-A1; Fri, 07 Aug 2026 16:01:14 +0200
Date: Fri, 7 Aug 2026 16:01:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: krishan mohan <krishanmohan298@gmail.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: Fix memory leak of hwmon_name on hwmon
 registration failure
Message-ID: <aaba84dc-a9e2-4dc6-936f-89fae4d46140@lunn.ch>
References: <20260805043643.194976-1-krishanmohan298@gmail.com>
 <4effcfad-50db-43e4-9e6a-7227525cc53f@lunn.ch>
 <CAAvqt3s1Tt9zM9vUO1-khbRPLX=fQbPaDsG_Xyd3t87reyWvNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvqt3s1Tt9zM9vUO1-khbRPLX=fQbPaDsG_Xyd3t87reyWvNQ@mail.gmail.com>

On Fri, Aug 07, 2026 at 12:52:58PM +0530, krishan mohan wrote:
> Hi All,
> 
> Please find v2 of this patch. 
> Changes since v1: - Move hwmon_name cleanup to sfp_hwmon_remove(). - Free
> hwmon_name independently of hwmon_dev.

Please read:

https://docs.kernel.org/process/submitting-patches.html

and then submit a proper patch, following the process defined in this
document.

It is also important you start a new thread, otherwise the CI probably
does not work.

    Andrew

---
pw-bot: cr
