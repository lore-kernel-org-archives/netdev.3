Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B21A316E
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168110; cv=none; b=PAtFMMSYxlSKonwWq1TJ+FcKa4V1IcQKWkU1WAheiY/FUZms/ruiv8UdksH82GeekV+BzzRbgeLXiyIawE9cqQ3QTVIWGeXRIl6Nt8gyaJVgcgtsygXucaDoxHtniuYN13IIvDo2MLTtTpEzKtlTcD34p2Ve5pbP6VjufoV13GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168110; c=relaxed/simple;
	bh=rzn+mXwuxuGBqeL9f0zlEdgdDoITVl3qMXqi0a/HbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3XVqw+TFXh0IRka2qL5U9TszkKg1sjXiRXO8ONftI7DLi7ywxvRJa32azlTJjo0NTxQELpnaMEvow0M650icEtZ1jRjD6YZ8hzc+Z1NMymA5AyIMeeaCyhoy8aEc7cCh+02OdTEREsjMoESuw4RuzPxCd/ZGwp+k24uRDm/+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcWBKvcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcWBKvcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A07C2BCB2;
	Thu,  7 May 2026 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778168110;
	bh=rzn+mXwuxuGBqeL9f0zlEdgdDoITVl3qMXqi0a/HbI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcWBKvcpSgYbkBNyr6JNT1JrlsNQNjuDcOrxP9Q04JR7iG1SGc53yJH9QuWx5bU6x
	 V3bLy879FPuVi32guDbf+7BM6eD2rG0QsVrSlIBxJHWhd6nwvx/fOu6yjzWxUC7lsf
	 ppTsFMDsQK6dNf9+DRUSOd4udu7qMWEQZ7ICQIc9NUqxdGbHEgFSC35l5T9xjZTsNS
	 l4W6WgDn9gxuCsAeA9SdmMeOdmR8pfwnBXaWyeo3hLoxjnlKlKKRQE58NzxMwvsLRV
	 OBQl58iKhbpDNK1WmaUAz0L0ER1vrXEEI+o6c88vRJ1twtcyZiK8t6jU3Do5lOnVhB
	 ZNuiPLuNt/Row==
Date: Thu, 7 May 2026 08:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "chleroy@kernel.org"
 <chleroy@kernel.org>, "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260507083508.681108f1@kernel.org>
In-Reply-To: <AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
	<20260506161629.5488a643@kernel.org>
	<AM0PR06MB1039657EB2FADD7BDAD4159D5F73C2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 15:07:35 +0000 Holger Brunck wrote:
> > On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:  
> > > When the device is removed all allocated resources should be freed.
> > > In uhdlc_memclean the netdev transmit queue was already stopped. But
> > > at this point we may have pending skb in the transmit queue which must
> > > be freed. Therefore iterate over the tx_skbuff pointers and free all
> > > pending skb. The issue was discovered by sashiko.  
> > 
> > And you tested this how?
> > 
> > Given the questionable v1 I'm highly hesitant to accept patches from you if you
> > can't test them.  
> 
> I tested the patch on a ls1043a board running HDLC in busmode on kernel 6.12

Please add this to the commit message, as previously requested.
