Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391600;
	b=sfp8gJqSh9kXPy/Un7rec4trRcQ78V+O8CTBZf9Sukgkpn8SUG+ljguGIcFZbi0U8DUz
	 ENY/ldFoqgcqp9S4UvHwVPiYILIu1egP6XtvssJnWD111EBvRoM/hSmmHB4pJYJn60xm7
	 TeSYQbPul6cddIg94vMFq89cYsexviAqJZCmBufBYIXzuS7cTwqwZezPp46UXzO2yGsD/
	 pnQNxgbRwEITRRqEvifqaHqUV7SdGjbk/Td9jbux34TRpwu554i1f+S9F0Fo1YxeON5L5
	 P3EKWLQSa0CDT+P8JA5JqF7LEMiePZBu9OIgRd+H2mH0p0lqWP/tnq3Gi5Q/SZJxRCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391600;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=lCyc+LqMY12UXq6rKnLvhi2g2c9KLwZBXahbynKrBgk=;
	b=LKMs+FhUJ5ZIoOSYomL/EsNuVKo7XVZth46ncyTjJlwV1aljaeWJxXHoQAFtJFVXXydb
	 8QH7upfcZolM5NNWoV8XsiI+el3LSTUYzXXHN1ER6YQOc5gaKWqS8LUHw+qH0EZeAbqoZ
	 0n/mSIUm6VwT7tmJK9Q9xsGOptVA6rHyFDH4kjLJswGo2vCJkd0xE/v3FvmzQ/1qKnTL8
	 qZ2cgwCRYihToek138MOUINV5Oerj8ywjju9NZVHh1GO8Buo6cK7lmjyRckNo3fZor9DY
	 H99W9dBXQ8TfGZNJltCCv/b3al5ZeDCUQUEXCblKh5UzYN9HMl73qGTk3K0+JZfmtqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C8UFSQwv;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E49606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 20:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3E49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C8UFSQwv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lCyc+LqMY12UXq6rKnLvhi2g2c9KLwZBXahbynKrBgk=; b=C8UFSQwvAOCVIgE4oypRqa03RM
	GMI2A/8o6LSR9pCCwvbBep+lVMENiCjtEOFDZ+ee9WwSHyok1ldcgkN4NmS6aELK17Lo5V4m+0pfN
	VwZ0T7X5SV93MtxSzKcuplhpBNOe+OCSc2PaJBSvsspOMaKzlb/5Lt8I4/Qav2Q5XpKQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMt4u-00DQlW-Tg; Fri, 30 Oct 2026 21:19:56 +0100
Date: Fri, 30 Oct 2026 21:19:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Zhineng Lim <limzhineng2@gmail.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: Netdev devlink A/B firmware bank selection feature
Message-ID: <34a6dde6-7a4e-4291-9f13-22d56793c866@lunn.ch>
References: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>

On Fri, Oct 30, 2026 at 11:28:52AM -0700, Zhineng Lim wrote:
> Hi Jiri,
> 
> I'm from the FBNIC team at Meta, working on firmware and drivers. I
> realized that devlink core currently lacks a feature for selecting
> which A/B bank to use to activate the firmware, i.e currently we just
> have "devlink dev reload pci/<bdf> action fw_activate" to activate a
> pending image, or reload a current image if none is pending.
> 
> I'm thinking of adding a feature that allows for A/B bank selection,
> something like:

Any hardware out there which supports A, B, and C?

> devlink dev reload pci/<bdf> action fw_activate bank active
> devlink dev reload pci/<bdf> action fw_activate bank inactive

How does 'devlink dev flash' work? Don't you also need a bank
selection?

Seems like 'devlink dev info' needs to indicate banks?

	Andrew
