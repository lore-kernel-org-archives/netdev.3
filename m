Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A222F0661
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852670; cv=none; b=Y+PN0ToBYb8wRx2FqugWgNllhwgLe12fKqdIuIl4PBGfhiDBMa9BwJ/uZJN1yWCTkPVv824BuHgdyrQpAq2U9wfaUP9pqi/mlI9d8B4iYS6kMNXpLurXcpUDiS+LSoftiD4Je3AmWlXdZPkIFrrd3KJq7KT8cmGvhS1IkT0MFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852670; c=relaxed/simple;
	bh=ixO5g+tSsa5SOsrsqiBoVfI6/HYlBOep8URYpaf4KS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHq6DDW1qQEj+pih9hlZ2Z+aaqK/A7CCCdrvPUbUtH+5R4Wt+A4JOxDeFz5oseR8IaxwrVXIH9XnvmLSYWVyazY6wSz9a44zz9KApP1gYS5rlAKZ8kOBu22ZUnAwFN+yiLi28G4UafvZgtVj//QQF88NS+WbSCwggBc1WiloSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZL0MY8pd; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZL0MY8pd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ixO5g+tSsa5SOsrsqiBoVfI6/HYlBOep8URYpaf4KS8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791852665; v=1; x=1792457465;
 b=ZL0MY8pd+L1F59swRgu+ohk55GYe6WBZ6PtLKseQ8R8d4pQidDv3rch+oCXVIW+BtcSu6V5T
 UvB7Ef9PBtkWDKXSYdsGxAQdZZg3TQFe3BxgH6a00sXzXdoz40479TmjztDp1ZR/qBdXu3vQ7Kt
 W2BZ2ik1nOxTc3botkGDz1eM=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 885ca98b374d8d2d;
	Tue, 13 Oct 2026 00:51:04 +0000
X-Mizu-Trace-ID: 885ca98b374d8d2d
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 08:50:57 +0800
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
Message-ID: <as2AcQnWDYezKLGb@fedora>
References: <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
 <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net>
 <aoVzaHfKWG-_OJOY@fedora>
 <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
 <9e3e44ac-8725-4372-af4b-e5092c8a3810@hartkopp.net>
 <aoet6aHyJI5lGNOX@fedora>
 <6001bd73-ef68-4820-8371-a22775fb820a@hartkopp.net>
 <3050c887-a9cb-491d-816c-0d7b6384923c@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3050c887-a9cb-491d-816c-0d7b6384923c@hartkopp.net>

On Mon, Oct 12, 2026 at 02:41:28PM +0200, Oliver Hartkopp wrote:
> > I've checked some whitelisting ideas for bond and team which did not
> > really work and turned out to be risky.
> > 
> > In the end the V2 patch from Jiale Yao testing for ARPHRD_CAN and
> > ARPHRD_IEEE802154 / ARPHRD_IEEE802154_MONITOR (suggested by Gemini/
> > Jakub) seems to be the best idea!
> > 
> > https://lore.kernel.org/netdev/20260728151240.89434-1-yaojiale02@163.com/
> 
> What happened to this patch above?
> 
> I still can't see anything of it in net-next.

Please see the kernel test robot reply. The code indentation is incorrect.
And There is an extra "}".

Thanks
Hangbin
