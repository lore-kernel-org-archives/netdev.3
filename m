Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F33BE620
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311090; cv=none; b=KvR22aejo4kHiLIcSqULn1p2XnBcqmgJMET0SZSaWVYCEXMLEflS0X0n46Bmis4MPVg0MAjJ+B8S67cTo1YJbRPWzycM7cfRNMGb0KW9iIZwDFrUznbmxB4fD5nUDNZhK2qlP47mH12xZFhfwf/vro/o9b1KEtni4j3UaGSRRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311090; c=relaxed/simple;
	bh=AsyKC2rgdRcy45dQM2udDwDzp3J9iVLGufzOGIZ1hjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdDD0EYp9hRb9SZ016tiLdo0rgKxs0cCxIPjn3QWya2q7XoAp17Egmal40cJMlTHpim+5AocvnTGH/SEnbL2+XstjoclbQRBVXqAK25Rg18sGvSmqcqrlNOnuE4dh0g0OmxDLJvdzn1hhY4XWLcdixcICsohTdFd4TJVDort89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VgHnII2x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VgHnII2x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pd3xkj/pxHH38Ar9kQawTsx5wJsn77KhrIZ0IX+HMJY=; b=VgHnII2xrCCH2wCZ5o/vtwD+a8
	nATu3093AMiFDsyUiVDRSEJDeMRpXn2Gchpfo+GOwAW8Ywe47lQBSK3aBsTIK9tUdnYLcG4fDBM2S
	O//j/096uBnbEAtlxq1kEANI2nY3Nn/kOEppVh+tdpoJTqW8dXA3/s1LdpqIVcnp/Lns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE9q6-009JgF-Rf; Tue, 06 Oct 2026 20:24:34 +0200
Date: Tue, 6 Oct 2026 20:24:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: =?iso-8859-1?Q?S=E9bastien?= Royen <sebastien.royen@armadeus.com>,
	netdev-bot+sinfo@kernel.org,
	Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
Message-ID: <b20c5ba4-08ed-49c0-af9a-2a81a45a3ce5@lunn.ch>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
 <179129640372.2231598.1056441247005614175@kernel.org>
 <4585ddfd-122f-465d-80b9-c907a530075e@armadeus.com>
 <027573f7-b768-45df-8368-6dcd4700e999@lunn.ch>
 <317F33BB-1739-47AE-9107-F8FF3AE8B370@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317F33BB-1739-47AE-9107-F8FF3AE8B370@tipi-net.de>

On Tue, Oct 06, 2026 at 06:21:52PM +0200, Nicolai Buchwitz wrote:
> Hi Andrew
> 
> On October 6, 2026 6:16:02 PM GMT+02:00, Andrew Lunn <andrew@lunn.ch> wrote:
> >> This issue was discovered when upgrading an embedded device from kernel 5.10 to 6.16.
> >
> >So is this a regression?
> >
> >If it is, please take a read of:
> >
> >https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> >
> >and consider if this should be backported to stable.
> >
> >You then need to set the tree as 'net'
> 
> I might be overlooking something,  but the target tree is already net?

Oh, yes. Was it a missing Fixes tag which made me think something was
wrong?

	Andrew
