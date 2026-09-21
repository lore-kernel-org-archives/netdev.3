Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5337274B4A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957393; cv=none; b=Gm5WFCan0/mYCaPwZ47xM6LmXyNuijuObwyhO9rrbbdpqYxtnOJCzrI6pcDB3t+G5t9kKxp7Ce9csar4ImW9WHWEDirF2Hcls+n3d8nH/GssPesnNmZ0SXiejk/YoEC2f8m9Bf+eOk5/SfY8Fsyo90Y3mEs0o+chbVaJRevzFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957393; c=relaxed/simple;
	bh=pmcWmfw41HVQfXfGz7i7Rx//hEnJfouZDUV4Er5YoPs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/6WXr7ZFMnW91J7fvYWhL7exiT669QpCH/2Jp6sQnWky6q5RJLSvgNGROunzW9ppL8KeWTCorbEfXnEgyH9AKodm1Z4oDj33cW9vNuKS6gjuI0QnzZ7BAfsZ3IurCKUXg+q3lPQg3hl/ImgzzIATcho/fHk05lanBljTcAhzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync5t1789957371tcba9a76f
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.25.28])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8043719272270054698
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Maciej Fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	"'Maciej Fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'Simon Horman'" <horms@kernel.org>
References: <20260920085114.1062503-1-jiawenwu@trustnetic.com> <F55611137A66BAC3+20260920085114.1062503-2-jiawenwu@trustnetic.com> <0b4c65e5-b2c3-4c8b-9db7-d221ffab6ec5@lunn.ch>
In-Reply-To: <0b4c65e5-b2c3-4c8b-9db7-d221ffab6ec5@lunn.ch>
Subject: RE: [PATCH net 2/3] net: txgbe: keep MAC enabled for NCSI and WoL for SP devices
Date: Mon, 21 Sep 2026 10:22:49 +0800
Message-ID: <065701dd4970$1953a5a0$4bfaf0e0$@trustnetic.com>
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
Thread-Index: AQF8eSHRJmWiUVkePJmLioVp15v0rwGIeIrgAl1UIoK3er1Y0A==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/36BtZsN8Hh0cZrJHNMJCx/E+RQEHoM36VkoP2vqxkZ8PMNFCxLVfvN
	PFUghaikU66loh+5xxgSbmBnroAFzqm4SWCJ3syLKlYEs2Ohq+VvrXJoolUMQ7Ixr/mMAKI
	+0FnTVr0y0e45dq4YqZsoP2MkQmjALpuLcbFzqgJ0x60zon0FkuJPYLabk2tohPcS8NdDEG
	RVZ3bGKMWmBSS/bM3AVEnSvvkQcFTNa6Jf74iZdyZInrlpzev03r8wGQSS5pXRA+w4EsdJx
	aS8ti1ifSaReezzsDpXGlpYQqoT+XChYmeM0u1B5/dVL+7h//eI9YX0RWxBg51h5p8f3+GZ
	9tjvZChOowGKGw46aIrDvXqdb+MIbastwvFpo0Aw4R41aR14D9IpKH8PzO20Oloakx8CjyX
	Dbr6u126LJ3UFRGu5tVBDlFjuroCWNCjSSt/zi5g0bn+uxEWrNW/OlBWm3Ah8HWAue4N82a
	jWeX+WAd3eOoQ/NidM/vPgxiGXVdictZrER1mbf860lk9WpETGtkU7cdaXH4QW939MG9IB+
	WF7KDDrofwL87aJMLRrke80AcZqnex0QjO1Xh5+ljLlsfuDRgRaW27xwFfUy8pZYN9kNy/T
	Xsg/9xzZcyEoMS/oXPyQgwGfEHQ0qKwivgS/jk2DeqW8ARwygFEUARe4fLWYZFGAahcDpkC
	qjmcPtzE+ExrdBag1fW+MTNRBlyfV+x8k8+v6QyauVZc6itQYyw/BioJNBJ4fKjAf6a28lA
	s9esyS1Rg6awa5UqYro4jr9e6nvZwVAG+P50mjsGFASuAJGBrKAAAnYCGDIaBr2OABQitR1
	pMqCneu/HWJM/KaP+pSMFrIg0nhB5OqBrxCF8U8zX6zmxYFsNx2Kj20b7BVx34uP3cFure4
	m0r7YD+bDZljpJWLv3iKi756QwfHzmuQAhkcICUEid/HcQHgYUiMCghNvSxLkucWP7PgFOl
	KTHfKbBTtnWaUpmHpJ+ugDYjHwjz0wszF8S22SowyfufCpArnfHcNXESdDbsYBSuB32mnTX
	KOj5rYdW3Zak5frQXUEloY7mvKxIjuxq8Ftwwn9rmY72MrxUY6VEJqkQwuHrm7W9u6ciDQo
	53oUFlypsSCl45nJsg/2S92xO6vaiRwSuHxbIGuFcpV
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Sun, Sep 20, 2026 10:56 PM, Andrew Lunn wrote:
> On Sun, Sep 20, 2026 at 04:51:13PM +0800, Jiawen Wu wrote:
> > The .mac_link_down() in phylink callback disable MAC TX unconditionally.
> > This is not suitable for devices using NCSI or WoL, where the MAC needs
> > to remain enbaled after the link goes down to support the corresponding
> > functionality.
> >
> > Skip disabling MAC TX when the subsystem device ID indicates an NCSI or
> > WoL device. Keep the existing link-down handling for other devices.
> 
> NCSI i can understand, but phylink knows about WoL. This makes me
> think your WoL code is broken. Please review it.

WoL functionality has not been implemented on txgbe.
I'll change to fix NCSI first, then support WoL later.


