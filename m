Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7723806DB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437931; cv=none; b=mXQjtCJs5a+IrRLtgeSMykFs5HcZvrYGGCGJhM5S4Vzn00goUe9kv6iF3Y5S01HoEzwhnEKTMfdYTjogt8VYveKmPhnzTnFDFTJ1pCloSIO+2jBXm6g1T0NlCNkyFSMyl+p3wNfaT/8s2BqZ1MJH+5h1xvQLH81SdfQf6HtUT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437931; c=relaxed/simple;
	bh=B2jwSkUlIjLFtZ0+xlNiJ/fn5ceRxS3MtNEEP2hu/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo8YDNybGCOy4mBjWnKFaNfFXug3Q8Ne/xncTvHDldv2Yb68M8+xGPbvkRkdAe6W386OTbtAdyofTKKZ9Z7RsdqZQIKHFFebVwvfmLXX/itwOIC4Zr7hHIUClsgLXfSg0GWJiuycZm6wrDK4vWuShNlZpW/IiRCKI+9N+OJfogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FyFA6oFH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FyFA6oFH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ov7dAf8vwJevqPXcZ5dazG66Avmus3yiFwb0nhqKU0w=; b=FyFA6oFHnf0nx+spDryNIgH1vU
	4ljq0fKiVCwsxhTpssR2zJYKvN3FIAtHIbK/IrCSX0XvNhzh1JPawe1fqdE4ORoZrhd6b/OFRbp9N
	hqitYTbfr/ox/zevpXomkYS1Sly8fkjof9Ln8dmtDYJqdwk69yxr/dPlLIenVwOqLUiM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUXEk-005ldI-0V; Wed, 03 Jun 2026 00:05:26 +0200
Date: Wed, 3 Jun 2026 00:05:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Fenton <andrew.fenton@grapheneos.org>
Cc: netdev@vger.kernel.org
Subject: Re: [QUESTION] Packet uid for kernel-generated multicast
Message-ID: <d31e7097-0adb-45e4-8e50-313334ec791e@lunn.ch>
References: <ah8aQWX60nTiHMLQ@acomputer.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8aQWX60nTiHMLQ@acomputer.local>

On Tue, Jun 02, 2026 at 02:00:33PM -0400, Andrew Fenton wrote:
> Certain multicast-related system calls such as setsockopt with options
> IP_ADD_MEMBERSHIP, IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP result in outgoing
> kernel-generated packets that don't have an associated uid.

Just to be sure i understand your question. You mean the user ID of
the process joining a multicast group?

I don't actually think it is a 1:1 mapping. Multiple different users
can join the same multicast group. The kernel, i think, just joins the
group once, independent of how many userspace processes joined it. The
kernel will also answer query requests autonomously, and i doubt that
is directly associated to a process, just that some user(s) have
joined the group.

     Andrew
