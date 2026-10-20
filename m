Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460745;
	b=qjxOoKbrgwUA82K9V9YHaj44HCC9x2I1/6v99owWDkQaGU9FTcVdlJrs391KKikdBeVz
	 fOcS2s2pJnVRoZWkLmv3Gv3l73HeubCiJ1An4nTqcsHUAqo30ezwvgvDZPlmSEPCMG1dn
	 /yuu5yRlO6d+UpM2Yodgmn+8WkP1qaxtZGzqvuWuc9iOwQo9kVOZ7rYABu4OjHZ4LFRJ9
	 FQnKT4KnU5H3XONpDnhtAbgx6qiZ0eC1KlcsGG6JgnsEXHuCikZnauqXwI9qF0OKXVy3Q
	 Jc5oxOKFbTrNIuyr+wA6EtokXdnwPHF/gtLnJjU3jF2eLB20DDMBHyiJ6UFfPDOKKSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460745;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W034+nZvG4TDfNjiR8mU9NccyHyyWqiASz0u3uyLj2w=;
	b=Wmui+iVmANyJ2tdCl550ztXiMiag3oD/GDgne3Q98IyMjUpoCq5IsBd8bp87mQr8RCsD
	 Cy7dcOJq/KWFaJgO/6s6nVG9qAsYbrrHgTub5MLV7m0MRnJhWT7goh/CMZ+R5l71HlojH
	 5OCNuXShwQ6qp0Gzk0GgRZ0b7nRYAQeejmBQxANXVCaq4ahZ98Hu6RwD5zuHnEmZN+qYy
	 htja4fBD18IRINpOF4o3adfUCllPKZSlH+D6Gb6qH0RdIHoqIGqCgB5ESOyJQWslpOggU
	 /RR8pMP2tmke+OnMC866vCoQa6IRXrsZo5UNJc8ZUQSq2dSmUc8vNF9mruDB6fOIofQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WzuPIzSr;
	arc=none smtp.remote-ip=95.215.58.79
Received: from mta1.migadu.com (out-79.mta1.migadu.com [95.215.58.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC1606A339
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CC1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WzuPIzSr
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KcmKimTUWSvc0OwhXD4P3O1CuX5gAOJ5eE3dl16aHmo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792460742; v=1; x=1793065542;
 b=WzuPIzSrsCA1MlfOa5zYuIHLKtXoqvmHfIugD5ErB4Zsazk0T/9P2glA79bCb8cNXGIbMcBr
 MOayFE7r5vhQKoM2YM/5euZPbhrdBsfiYMdiScGR/uw2/MjgjT/HLs3j6HPGEFhtmEQC+Rw/oiG
 wbRHgVdRAMdUncRg3RLf2m2Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 65c4eaa1d9014f00;
	Tue, 20 Oct 2026 01:45:23 +0000
X-Mizu-Trace-ID: 65c4eaa1d9014f00
X-Migadu-Flow: FLOW_OUT
Date: Tue, 20 Oct 2026 09:45:15 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: lirongqing <lirongqing@baidu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] team: fix promisc/allmulti leak in team_port_add error
 path
Message-ID: <atbHq7a_YzR6VuTg@fedora>
References: <20261019083122.1841-1-lirongqing@baidu.com>
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
In-Reply-To: <20261019083122.1841-1-lirongqing@baidu.com>

Hi Rongqing,
On Mon, Oct 19, 2026 at 04:31:22PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> team_port_add() increments the port's promiscuity and allmulti
> counts before calling team_dev_type_check_change(). If the latter
> fails, the error path does not undo these increments, leaving the
> port in promiscuous and allmulti mode even though it was not
> successfully added to the team.
> 
> Undo both increments in err_set_dev_type, matching the cleanup
> performed by team_port_del().
> 
> Fixes: 43c2adb9df7d ("team: set slave to promisc if team is already in promisc mode")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/team/team_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index ca75f08..3b30063 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1386,6 +1386,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  	return 0;
>  
>  err_set_dev_type:
> +	if (dev->flags & IFF_PROMISC)
> +		dev_set_promiscuity(port_dev, -1);
> +	if (dev->flags & IFF_ALLMULTI)
> +		dev_set_allmulti(port_dev, -1);
>  err_set_slave_allmulti:

I think we can remove the dev_set_promiscuity(port_dev, -1); in
if (dev->flags & IFF_ALLMULTI) and move it under here.


Thanks
Hangbin
