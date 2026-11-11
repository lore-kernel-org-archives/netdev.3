Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435639;
	b=tnrW8Iz0oCb6DjQb7ruEWc/3R9xxzm35LC+vbChSE5GRsLOB++uKDFIY8HAahQyxxEfi
	 XCvGXIEaMtlwaZXYisfxMeTcm/+BZCSvsdQjMPC9nlbgUz/XctjE8nr3llilBJShaKliH
	 bPEv6X/cQEqOxP1bV8Db5iyeye/dqrH3aNv+Dv7FXKw8+gIXJbp3SRifb+Bg9ggrD/1O5
	 7CDfDmwWaDDm104/CG2I+xwwWvCOku2C2sW+PeT6s+FRv0sUfdyEeKPcR61OtDCb5IfGb
	 xYilkBq0CPNhdno/yTwK6M9px2AkQabweZEwFw/ye4pCIXRQIIyRNc+kcXk9HIiIcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=l41r/vBb8YxJ/z+2szPSZoICsIGBmCS/02+qIbRTW+A=;
	b=j4slqYJTzdg45ZJfnJNwusOCdgHnyCUFCdLNO/w+dohL15l3NqUvZq/nz3/B5/EhiOS/
	 T1KOX5tTYF/GfB8sJd12/jkzaYwtU8x3nM9M/ll0+/GIkSTF85+k1GXvzhC2rKW8f0ZT7
	 s3UXr77oa1RfKcRtlKrMbSFpHJWp42YexvfAWrcKLWVGYaCex7sdX5Mxq3rpsfO3jDwkb
	 hDC1YhPIv84/okzbCdpgZA373ZFXvFrkzGxR+gWDjY4AINv1BWtXcPZ4PlRUrIEXuRyYg
	 AVzjFjGRlDyRrJ0GwY5SBQkrPShpMkFIIEmNiceS2K72gYQ9mWnXcp2062CXjmo7qdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=pxanTNtW;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B82606A330
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B82606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=pxanTNtW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794435638; x=1825971638;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=l41r/vBb8YxJ/z+2szPSZoICsIGBmCS/02+qIbRTW+A=;
  b=pxanTNtWBaAtMTjvbb387BsP/Q+agdDPabf9auTIkSUzcavTmSdWwT5h
   hCMF2pKEdHDAz1fKQmLt5D28TDcmgwBty5eDUyghlV5fytkvncTayd6Pp
   iCdHTqHi3zBx44cPbUkA0L5rkxp2FGoyoft/bZCUw7UTcj5zxBDQqjAr7
   Vdu+Bqj4UMQvSgyBVkqHLP69CLmeKqCSWBdms+QTHlB6pgoPomTn42mIH
   +vYkf/ptp+Yry+BsDzUlnLZRvk51Twx7BL+USiZEsDKDwyfXtG/7uGg5S
   qOgDlssBwom46pcyASVBgVFWOI7/aI4GrdSM7inWBoTYYknXv/sQ2yV4y
   w==;
X-CSE-ConnectionGUID: 2YDboeUBTCaDBItEl3LPoA==
X-CSE-MsgGUID: dbgt/kXoRrSXt5FY50nmWQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33548453"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:20:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:9342]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.212:2525] with esmtp (Farcaster)
 id d802550a-d76f-402c-b56b-7f591cc48a5d; Wed, 11 Nov 2026 22:20:36 +0000 (UTC)
X-Farcaster-Flow-ID: d802550a-d76f-402c-b56b-7f591cc48a5d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:20:35 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:20:34 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] net: ena: set admin device pointer before
 queue allocations
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>
CC: Avi Weiss <thnkslprpt@gmail.com>, <netdev@vger.kernel.org>,
	<darinzon@amazon.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>
In-Reply-To: <179433615241.3327.1653126166147440177.b4-review@b4>
References: <20261109071126.87125-2-thnkslprpt@gmail.com>
 <179433615241.3327.1653126166147440177.b4-review@b4>
Date: Wed, 11 Nov 2026 22:20:22 +0000
Message-ID: <179443562266.24920.9919335880545623225.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-11-10 18:42:32+00:00, Arthur Kiyanovski wrote:
> On Mon, 09 Nov 2026 09:11:27 +0200, Avi Weiss <thnkslprpt@gmail.com> wrote:
> 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> > index 297fb36ab8c1..23b3ef50b8b6 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> > @@ -2045,7 +2047,6 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
> >  	if (ret)
> >  		goto error;
> >  
> > -	admin_queue->ena_dev = ena_dev;
> >  	admin_queue->running_state = true;
> >  
> >  	return 0;
> 
> 1. This is a bug fix, so it should go to net and not net-next.
> 
> 2. Like your other patches, this one has already been applied to the
> amzn-drivers repository:
> 
> https://github.com/amzn/amzn-drivers/commit/7d1dc4341d4f8376c7affdc2a97c7e012118beaa
> 
> Therefore please do the following:
> 
> 2.1. Add a From: tag to give credit to Wajeeh Atrash, who wrote this fix:
> 
> From: Wajeeh Atrash <atrwajee@amazon.com>
> 
> 2.2. Wajeeh has agreed, please also add:
> 
> 
> It should be added before your Signed-off-by:
> 
> 2.3. Move "admin_queue->ena_dev = ena_dev;" to the same place as in the
> github commit, which is directly above the q_dmadev assignment:
> 
>         admin_queue->ena_dev = ena_dev;
>         admin_queue->q_dmadev = ena_dev->dmadev;
> 
> I don't see a clear advantage to the location in your patch, so I would
> rather have both drivers aligned.
> 
> Signed-off-by: Wajeeh Atrash <atrwajee@amazon.com>

Two corrections to the commit message, plus two requests for v2.

1. The From: line must be the very first line of the message body,
above the changelog - not down among the tags. git am consumes it
from there into the commit's author field, after which it does not
appear in the commit message at all. Placed next to the Fixes: tag
it is not consumed: the author stays you, and the line survives in
the permanent changelog as plain text.

So the body should start:

-  From: Wajeeh Atrash <atrwajee@amazon.com>

-  On the first probe, ena_com_admin_init() allocates the completion
-  contexts ...

Equivalently, set him as the author locally and let format-patch
emit the line for you:

  git commit --amend --author="Wajeeh Atrash <atrwajee@amazon.com>"

2. Wajeeh's Signed-off-by: is missing from your draft - my previous
mail dropped the line by accident, sorry. The tags should end:

- Fixes: da580ca8de2c ("net: ena: add device distinct log prefix to files")
- Signed-off-by: Wajeeh Atrash <atrwajee@amazon.com>
- Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Both are needed. Once From: changes the author, netdev's
verify_signedoff check requires a sign-off matching the author as
well as one matching the submitter.

3. Please send the three ENA patches as one series against net, with
a cover letter, instead of three separate mails.

4. Please state how the issue was discovered and validated, and how
the fix was tested, as required by the "Bug fixes" section of
Documentation/process/maintainer-netdev.rst. For a driver fix the
testing statement has to say which hardware it was tested on, or say
plainly that it was not tested on hardware.

Keep the sentence about the standalone driver in the commit message -
unlike a link below the ---, it survives the apply.


