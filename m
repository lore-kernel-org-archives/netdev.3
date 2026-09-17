Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35E1C6FF5;
	Thu, 17 Sep 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604245; cv=none; b=ExSU277OrY/g0SJwjywDTweusCKh6pO5zqfrFA6shlCGIOihObG1pBLhtbTjCs1/02utwg4xeH46CFslnYqbHCDXDGlG7g/7M44JozEJh/bqA03lQpZoS4HK6AZ4ipS95ljb0JH5uV+9KpY3tSiUsHoUKoTWJ10AClvNljHQmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604245; c=relaxed/simple;
	bh=IGjAEWFOc/+1R+37HJVbwF2xGRkU8Xs9dy+KXyWcoeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCIIuFs7f0IasydMgrmYs6H8RCYBmOfAJBM2IWFw+GeAvO7bTHR90X6/Nx7tYsYCLz4sP3eijujeEyepciHh6FXrvIqzwz+Lj9Bsrm6xK5fk9bjwSJ0FbOQYzlQ0XiS65em9W0/16rwZU1IAvve4gs/0f9AN5o7y1AFwnkXghHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6fXj4C7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6fXj4C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BE21F000FF;
	Thu, 17 Sep 2026 00:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604243;
	bh=IGjAEWFOc/+1R+37HJVbwF2xGRkU8Xs9dy+KXyWcoeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c6fXj4C7zfoO3ysMN3CknStyxZALc7cDJG9f5em9uh4dsZtjEFsta8iUcAJpzpE0Z
	 Pnoq11vahqq/r8AsfhTS+sQ4t/PWsnRbPV8S74HrphZ4RZH0pM/ZL+VF5RneQhk9LI
	 gjbzKD3N++R9EYo/hfsdCN50g5nrRvytSGe20g++qtPePLIP+fwohN6GeUBK6w60Qc
	 vWYY7spemUeLj5IkgKIIkXO/aI/o3M2Z25nwoTx6vH1La6CtcQRMH1oRgtyDj2G0U8
	 EbzYW5r0rWOaZPsU0gqlvMSMdyCHAizYvFg3/AL7AjXKp1DIf6szo8UyMFzliwiFqB
	 nziLVRIkUOxBA==
Date: Wed, 16 Sep 2026 17:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, Paul Fertser
 <fercerpav@gmail.com>, Simon Horman <horms@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ncsi: validate response packet length
 before accessing fields
Message-ID: <20260916171722.39e323fb@kernel.org>
In-Reply-To: <AS8P251MB000151B1FA33EDC00D8275D2C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB000151B1FA33EDC00D8275D2C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 19:09:37 +0100 Aamir Ahmed wrote:
> ncsi_validate_rsp_pkt() takes a pointer to the response header and then
> reads the checksum at the end of the padded payload, without checking
> that the skb holds either. ncsi_rcv_rsp() reads the common header the
> same way before that.

Patches need to be posted in one thread, which is the default for git
send-email. Patch 2 should be in reply to patch 1. Please repost.
