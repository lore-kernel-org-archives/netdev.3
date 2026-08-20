Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4443890F0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216164; cv=none; b=BbV9wmpRwGfUoU8tGJMvDUywAAyHLu43BFOYboz5TiBTl0vGQ5ROoDXYlt+uYPdjbZVXBUmAJG7WXvdCJ6HJ9lrIF3Y9lqgVUjACo+r82iiOjtoNWDNodw8xQmqh0cxfmocxnIw8KAvpja9qpqANgcFhCD9XjARaGwWX5ssqnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216164; c=relaxed/simple;
	bh=hdu8R7uEWDwrJN23hTljHFynGj8noCEa6Aze5jiopxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLLHWYFCa2hPwKrsVzPoUzA7eVmOqUx3cxZOScJpx9OfS12iLeS3lvApHJo3KCJSUvltqNVNAy0Dr642BXi2O32oaht1fcQjMzuvL7nY3ovC+oI12VzkX776S7+D2Wi4SuvnFL5JQJ6bqMhzJF2vxUfBuON15zebEIpZmxAwBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+KXzFck; arc=none smtp.client-ip=95.215.58.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+KXzFck"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hdu8R7uEWDwrJN23hTljHFynGj8noCEa6Aze5jiopxM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787216159; v=1; x=1787820959;
 b=r+KXzFck+ntvOxHDjwopRCLZb1D6Q8ZkqVdMSKkzDZZGrvPMb3qjBqvz6JgQqqJRMK5WwQfJ
 UoM3Ey1ZyGB+z5y/Zl6Ef+JwLijKCv0jRkSouixg9XR2cdL4ez07oh+cnFs0yO6WGTAnPZZTwhS
 QTN55CHHx7tZV0450u9SY9l8=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 67c35b60d010bfe3;
	Thu, 20 Aug 2026 08:55:49 +0000
X-Mizu-Trace-ID: 67c35b60d010bfe3
X-Migadu-Flow: FLOW_OUT
Date: Thu, 20 Aug 2026 16:55:40 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
	jonas.gorski@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
Message-ID: <aobBDGBjg_TJeu9g@fedora>
References: <20260625114216.2507435-1-louis.scalbert@6wind.com>
 <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org>
 <CAJ5u_Od76V6cxcEUT4h4EQQ4opJk9tLYHYWum7tWp0t1CWjGZw@mail.gmail.com>
 <aoa-dJKd25fTARYm@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoa-dJKd25fTARYm@fedora>

On Thu, Aug 20, 2026 at 04:44:45PM +0800, Hangbin Liu wrote:
> Hi Louis,
> On Thu, Aug 20, 2026 at 09:58:16AM +0200, Louis Scalbert wrote:
> > Hello Matthieu,
> > 
> > thank you for pinging.
> > 
> > There is no version 6, and there are no comments regarding version 5.
> > 
> > best regards
> 
> I saw the patch status is archived. Would you able to re-post it?
> I can help review it.

BTW, I just took a glance at your v5 patch. Since you use `parse_on_off`,
there is no need to define `lacp_strict_tbl` anymore.

Thanks
Hangbin
