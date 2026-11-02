Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626581;
	b=Lj8/cQs8y6QEjl7zUkeng6oSrnztnTO6i916gSTLittrP+AcUh3kRqsEeYvvUUIQVf/o
	 b1xK0582YTkyTg0Uti4wrQhhdrHxm91H+dq5iLuOQWjoaI1t3QqAIMZBhI0GE4vMxH4KE
	 B3yF61ARiDo7FSqZC3oQwN5tnVXNbW+C5Zz7RszcwGLe/rS4v2li27lqEfXqH1H/Kda1T
	 oPfS+7ueqgjPOFGDxQHeQgiS6zfXdEHLQzCAWmMZ80NIxLBSvduQjJFoLK+PviDN2mO34
	 yC1/Vq6v6RC51+1JKLCDUTRuNFdVW74Ddjc2vKFI5kpq8JmMRbQU3e9LDSJI9KRRazg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626581;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qKZ04hAZuwVXvCMLEEjYypv0Us/K6RMBdDWAUnDfKYk=;
	b=G6jMLc5bBzSnPaxu9PWcsQUKWdlKaNvj+crvM+WXPqW06XX5c4iLAgs9ObSuBDRO/Sow
	 I/lVoU0thpDuPyW+iD4k9Clk5IyGZwbpYWOBUu0VLZijwe9qyvPaHPfiD9LLbbqAU4S4L
	 91pELVm09CxGuefX0CT4+TTn/TeDXF0M/snveLeua2wKb0aAYFT0t23UQOopgJc7HdJ/L
	 sGjmwRLQ/N0bf5T0TPAKxWM3hT7sMBNAtUmlajdEKzSjLGa8EErwAb6fHLz8hdOxwq3ZX
	 NL7brIIXqfcF+LzoN5qnG2Azo6LT8ehQapUuvy5Mxfnw9MTr7+bS3daoIoUV+FydruA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LsDijRQ4;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532C606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1532C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LsDijRQ4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qKZ04hAZuwVXvCMLEEjYypv0Us/K6RMBdDWAUnDfKYk=; b=LsDijRQ4omthwICubdL161Yn3l
	tvYv1kIf7yAB0/tzQ4Rmbsg2JlfHhiF1Y0+AHeYS0vO9V1ncloo4beXPVG8WDDmbPJd2gqX+ciICp
	x7pZwWMQHnq+2OGmQ4gV2H8w8ezs/pJUxcIKA3WcLIA2djtgv4CMsl/W/bzj07GV1h1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNsCu-00Dnjl-H4; Mon, 02 Nov 2026 14:36:16 +0100
Date: Mon, 2 Nov 2026 14:36:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dave Seddon <dave.seddon.ca@gmail.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH ethtool] netlink: require a value for hds-thresh and the
 TDR parameters
Message-ID: <77e3fd9d-f2fa-479f-bfb7-c129a4461023@lunn.ch>
References: <20261102023919.1472495-1-dave.seddon.ca@gmail.com>
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
In-Reply-To: <20261102023919.1472495-1-dave.seddon.ca@gmail.com>

On Sun, Nov 01, 2026 at 06:39:19PM -0800, Dave Seddon wrote:
> hds-thresh (-G) and first, last, step and pair (--cable-test-tdr) take
> a value, but their parser entries leave min_argc at 0. Given as the
> last word on the line, the value handler reads the NULL that ends argv
> and the error message prints it:
> 
>   # ethtool -G eth0 hds-thresh
>   ethtool (-G): invalid value '(null)' for parameter 'hds-thresh'
>   # ethtool --cable-test-tdr eth0 first 1 last
>   ethtool (--cable-test-tdr): invalid value '(null)' for parameter 'last'
> 
> Set min_argc to 1, as every other value-taking parameter does, so the
> parser reports the missing value itself:
> 
>   # ethtool -G eth0 hds-thresh
>   ethtool (-G): no value for parameter 'hds-thresh'
> 
> Only the message changes: the exit status was already 1 and no request
> was sent.
> 
> Fixes: 66e5dcf295c0 ("ethtool: Add support for configuring hds-thresh")
> Fixes: 9561db9b76f4 ("Add cable test TDR support")

It would be better to have two patches, rather than one patch with two
Fixes.

The changes themselves look O.K.

    Andrew
