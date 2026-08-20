Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5937305666
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215489; cv=none; b=q7FtmzVPgU9djFgNBNclzulLM4lzxLigEhDmZcdIvbMRdan8k1kREzhBLpn+vBsQlKDi65bp/kyxnURUbbR9VYlBrBWCXmL54kpn8udaEtCCUA8ifM9bFO2Ywd95Ygsio0iK5F1Z1eYcmWTSjOwnoND10I05hlt0YYk/SuZ+RRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215489; c=relaxed/simple;
	bh=HlkmhjLRXyt27HxAGMXJOWlv9jREEbGHPJbIWfyNRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfpyJHdk4FUtgNhiCZbRT+hrYoZweaQ2fL2s/GSi0Trw/XZ0y8tT2eeK5GJrStZzzT8uFO2JSXkp7gGiP2bkOzLfTu8T6sBK1zs/c+p7qUw9rbq6AvCWEa7y9E9hGHQ45n7hc3szZneQZJN9gZFrj12ezP4j00/SOuOjPIyHrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMBhnZPL; arc=none smtp.client-ip=95.215.58.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMBhnZPL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HlkmhjLRXyt27HxAGMXJOWlv9jREEbGHPJbIWfyNRQs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787215485; v=1; x=1787820285;
 b=dMBhnZPLRHyCOAaeZSPQoSA8HG6H0yJGdz+x2QMhMwn8JQgp1f52zJyH1MmQuNdMeCrB6Hhn
 iXKdIvCWqfbr4T6MFgj4xRON5pMWIUcnMhxJg6ck4yXdLwZ6XjizVeeiIZOflduOEv0Pn1xUUfY
 epv+in3I7WLrmOCkzM7zX7k4=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 1c0e7c2532f589ec;
	Thu, 20 Aug 2026 08:44:45 +0000
X-Mizu-Trace-ID: 1c0e7c2532f589ec
X-Migadu-Flow: FLOW_OUT
Date: Thu, 20 Aug 2026 16:44:36 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
	andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
	jonas.gorski@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
Message-ID: <aoa-dJKd25fTARYm@fedora>
References: <20260625114216.2507435-1-louis.scalbert@6wind.com>
 <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org>
 <CAJ5u_Od76V6cxcEUT4h4EQQ4opJk9tLYHYWum7tWp0t1CWjGZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ5u_Od76V6cxcEUT4h4EQQ4opJk9tLYHYWum7tWp0t1CWjGZw@mail.gmail.com>

Hi Louis,
On Thu, Aug 20, 2026 at 09:58:16AM +0200, Louis Scalbert wrote:
> Hello Matthieu,
> 
> thank you for pinging.
> 
> There is no version 6, and there are no comments regarding version 5.
> 
> best regards

I saw the patch status is archived. Would you able to re-post it?
I can help review it.

Thanks
Hangbin
