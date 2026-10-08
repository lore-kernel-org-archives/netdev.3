Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33773254BD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425985; cv=none; b=ZbxVIgUgGXwNc7sZHdx+guH+OQGvlQs+wu0pT+hvqxSoQdxpz8wIGP3s9CaXqOJwBbZsFYfMxMWiQF2qgXwE+ImtCYAmq8Go6piE4hT4X7J9qMhlMllxxN+gQ4Nu+DjV+4P7pO+1WlTS0XNQpGQpSUACHk/k5bOTFhu7L3Wx7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425985; c=relaxed/simple;
	bh=fc0KXrehR5Sr7rQ6yaeikP0wkAMjDA0pmbo3OuvWUE4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3xPiJjjsB/vqHZFKGkj4cH3uAGbNtmI3xQl4ULor1X8X2oBlzecnsuzjQzWF5Z+WifCagQywH/SRm1l+6qB4tz1TQezm9nT69a+dD8ZyDHLlpgoVK1NtGqMUbEjTsJH4O1CnxbYm+D9HFu9ZGQR9fkc4rr79mJZ7dQXTTDpLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync9t1791425954t422328f7
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.116.16])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2444343616977155017
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Maciej Fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'Simon Horman'" <horms@kernel.org>
References: <20260924020149.30800-1-jiawenwu@trustnetic.com>	<20260924020149.30800-2-jiawenwu@trustnetic.com> <20260929184852.364dd9e6@kernel.org>
In-Reply-To: <20260929184852.364dd9e6@kernel.org>
Subject: RE: [PATCH net v2 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Thu, 8 Oct 2026 10:19:13 +0800
Message-ID: <0eac01dd56cb$698a3d00$3c9eb700$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHFw784voQWFmvhZ36tPTMrlP+NdAGAvuvMAQYrQD63DdbtkA==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODcDgdcDagQKEFt1Nftp86ahx8cG8D7URo35Sr8fEm3lvsBU1gtZjL4V
	3hW6rprYm/nJPhcDUsxBEKKRmjsWWdpUGnSjebhMft1iyUUr2apjZi5TrP0CwylDU3IMexu
	Hv5BEU8MfVL7MLwhnSrTDbGhLRWg8l+XcOoJRtqhSjEBYKaDGSf10mLQuHPQsxfZXqhTaqH
	WAuO+2GH/pFa5Ka7refrX4XC3ZeznrlaoTtUYTh41JEorfcfwQRvkPC1yOi+p5B6BNf6ZS2
	y+SDcuJYMQQCmQ8YRL2GyRU8cJ86DZtvwuP2iFQTS/Nx9REnobVMFSyceWNVc5nVcD4Upjt
	UfDqZbvboXMi6i8mF2rO94h7VRN63mF9lNJm/3+HBqev7xEQsx1yWxEttN/PzclmDqZL0i3
	pUeUff5nxwsQMDPh6CgnX9wnHe7J+JKvr8looVLLfv3rfCZlCQLoRHK5vCrUO9XLCC+sd6c
	l4mHJ6v8yHokA9y88LSWXEBL3+nhfHI/2pb/zplDYz+Wo3T2DWc6VGDQeNUwn8gpsRAjgY3
	WHFvlhse3Wsj0XsHaDpSTZ6Vl2aCVkg7eBI3IYEgsVOXgl+hdR1THXbRKOtd1JAmqsS1cWR
	O1BHojocDU1OMAsB6UUotnDOSRXSBWAH76fFV6QtNxdHbx9lys9auglCA0aCaTJHam49tzY
	NT5v8I+jWJfR1N5+oqSSPtZq/mminTCv4Rd7Q2pK8bHWEIbp7PSy2Q2B3llo7kD1297Ba76
	02mmsyczUqoKC2p6Z1GaqBQxVSnM7O92rrGgkHQJX2gaMBDLIf1T6y33GUUic2ZaMLVbJt0
	PtOqKIEtFYNvRedGR+gSptP1G94t7HjryaQptDmwOPxRLsYKfoYzBWZQDIv6LACnikIg/iY
	SzVnRUcpsf5OFVG6WCsLt5dvvMNfXsmCkLxdH9fWLLIz2da7CaY/i9vDf1V5JciPEOdLdLZ
	8jUxrySSvuMYgU2ThhQ0TSvYrHBR6IYDGwKASIlqtT8PSGKUH59wuFEDJxKD3XBekoHdYay
	b3fcazp9yiwd3pte1RtAO4qkXuVtcxNN3JWIHkCwTnAyCN1hDq5L0jVg58iUw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Wed, Sep 30, 2026 9:49 AM, Jakub Kicinski wrote:
> On Thu, 24 Sep 2026 10:01:47 +0800 Jiawen Wu wrote:
> >  		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> > -		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> > +		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP) ||
> > +		      (wx->mac.type == wx_mac_em && (wx->subsystem_device_id & 0xFF) == 0x40))) {
> 
> This condition looks way too magical for upstream
> 
> Add some wx_has_ncsi() helper and add it there?
> At least then the meaning is clear, here it's next to WOL, no idea what
> it's supposed to mean.

I had planned to fix this issue temporarily, and unify to use 'wx->ncsi_enabled'
in a later net-next patch. Looks like I'm messing things up. I'll fix it all in V3.



