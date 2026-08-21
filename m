Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205621CC71
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317289; cv=none; b=JpCQgShhWcw0kSlFlDOXA0bem5BaRU8EJO8FuQ7e1eE3/cngY3NmYmb9TNslAOwHvWQLGM0H+wsFgnl7rPxJNSt612QXJOzERJ9yT7K3LgGLpIa3qj2W6njo1YhifPwKJ7iLAfrYOwfUQJ2+pXA4XNEhfSQC+L20RpuWFn/uJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317289; c=relaxed/simple;
	bh=5UQEbg8CJ9Ltey3HOYemgtScprFgZKG6U4xVnm9WJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4EHOMCaf6JAAaEUKi3dNCLOIE5dqDEjAEiFKsHpEG1B4ZFmDWbCVGNldc1+kechE1v2QZ7n986uCtM+w7R8k79a28ISuTUK7f6zMOEwuesBOSvWhn1cZ8GGGCzycsY+WQ5T+6zsHy2BOo8p1mcXsm50oIL7+R8a4gYsYRvVSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JG1LMcPK; arc=none smtp.client-ip=91.218.175.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JG1LMcPK"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5UQEbg8CJ9Ltey3HOYemgtScprFgZKG6U4xVnm9WJHo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787317285; v=1; x=1787922085;
 b=JG1LMcPKS8ZZShW7g5rHLiGTtdOPk/KjMDWoRQrgw5nbbQO8R7RoAXDVPWx2KtyYOnSb/3Mp
 Kv9f9RBMDDbIHXISwNP/6eHo2iLOy0FHI2KLfovfxtb5DII6qCd1TefX+WXDpuYfNvpVCNvK3pT
 IzrQLi/1m+OjI1wUw1iwyW4I=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.242)
	by smtp.migadu.com with ESMTPS id 66ea74ae35e86623;
	Fri, 21 Aug 2026 13:01:24 +0000
X-Mizu-Trace-ID: 66ea74ae35e86623
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 21:01:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiale Yao <yaojiale02@163.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aswin Karuvally <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
Message-ID: <aohMHTTH4VqqgZA7@fedora>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
 <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
 <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
 <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net>
 <aoet6aHyJI5lGNOX@fedora>
 <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>

On Fri, Aug 21, 2026 at 01:17:10PM +0200, Oliver Hartkopp wrote:
> On 21.08.26 03:46, Hangbin Liu wrote:
> 
> > > This caused a problem on CAN devices that were not created by the CAN driver
> > > infrastructure (creating proper ml_priv content). When TUN/TAP set the
> > > dev->type of an ethernet device to ARPHRD_CAN the CAN ml_priv is NULL (not
> > > initialized).
> > 
> > I don't know why a user change the tun/tap dev->type to CAN. Can they work
> > together? If it's a miss config, I think we can just leave it since we already
> > block CAN slave.
> 
> Correct. We currently block ARPHRD_CAN in bond_main.c
> 
> > > Not sure if collecting a bunch of ARPHRD values is the right approach or
> > > whether team/bonding should check required features and settings (like IFF
> > > flags, e.g. IFF_ARP or specific address length)?
> > 
> > Bond supports none arp devices. It also supports infiniband devices. So we
> > can't check it with IFF_ARP or address length.
> > 
> >  From my perspective, we can keep the existing check as it only causes issues
> > with CAN devices. We can work out a better solution if more incompatible
> > devices are found under bond/team.
> 
> I've checked some whitelisting ideas for bond and team which did not really
> work and turned out to be risky.
> 
> In the end the V2 patch from Jiale Yao testing for ARPHRD_CAN and
> ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR (suggested by Gemini/Jakub)
> seems to be the best idea!
> 
> https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/
> 
> ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR do similar things like the CAN
> dev->ml_priv approach but with dev->ieee802154_ptr :-/

+1

Hangbin
