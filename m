Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794623195;
	b=GYaP+AIuU85/eiviyAQHGTsMTkFCsHw5xm47CdOJC+nbiBVlECWPfFhZjxQxgVuklsnb
	 jUV8RJ6SZSdue+OWNQWokF81KMP5kgZaBIYbRO/olwWcx4Nw/B7Zhgll+JiFnBkw8K8LB
	 hn+hzA8jk5QK4d2mt+OVDVb424WYaqDCMYp4xsR43lDqcE/okXaiQwtUn7E9wxgG/PCrU
	 4CgUY/nLcSjZCXMk5PFam7eldgjon6/sNCpYCaVyzY1+sA3Q4G6Mutx/WaMXlLCDjvCUa
	 Co7SVwb7Ro/89DxHh6w8/ZijdH2FUW6ppr6OCWJuz/HNvxzMhRzb3lI51xi6wUUjTng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623195;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RHjLlFLFdNOk8gkUh0wv0vVZpDsAN7hIt0lGfu22Uns=;
	b=fBV1UaljDj8fbjPDA8WF1L83UQkOPaNouQN0IKIzQR0dlQjDTWX7E6krrj4j8uLE/y1Y
	 GQx2OwHjdX+kgt8/BDopyjSWpOZRosagYK9qZMUWVAuqNirZtTaAzbUQZE+KgNPnO0MXm
	 NUV+N76hOvQyv0JTTJmxmitS1UMml7E0Ju6qBCfkwwjgf3FDteYk55CC3F4tYYmh9qCIO
	 muXWzetfDCcvRCKjEFzQ1sKUV7nTKEgHwB1/g6tw0UM3WWI6gJ72ZYE6xwP7yK/TBCON+
	 Z5BTZZXoTSdKqCpvZl7fw1BOAnxzGMTZIy6+Egso+J08ta1PKPqlPWB+KvqgD7fRMlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAlBRgRX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D2606A329;
	Sat, 14 Nov 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAlBRgRX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7DB1F000C4;
	Sat, 14 Nov 2026 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794623194;
	bh=RHjLlFLFdNOk8gkUh0wv0vVZpDsAN7hIt0lGfu22Uns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LAlBRgRXDwEsUQ+ppcIjvAs1HLeuLJIO/Ld//6a43pNEtvLTZt1tNBUCsCLwibiw0
	 yiyYgyXIKSA4qycOW9kWCaSHYhgDbAPHaElPoji6S42nveXjYLIDuIVvSfHbRcHzvE
	 BWtPGsHh0teRNS8X84QNM0X1Ggd7dp12wvqZetVFnTwJiMUICc7mg4397w6yghOTMF
	 UHyMr8/iKC/OgrR1FTNMAiU/GTXdUPc6f2QY7Iva9pyND0tG3stemjU6WF1DY6fpnX
	 UXmwM2b8HxnSwwpH4C9+p+CDkJLTq9LlGK0WX47cHedYm+QMIPhlNJfb2fufBwFtH0
	 5r1cvEGxqlxEQ==
Date: Fri, 13 Nov 2026 18:26:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: bring NLM_DONE out to a separate recv() in
 link and address dumps
Message-ID: <20261113182633.1bff5ce5@kernel.org>
In-Reply-To: <20261112180808.1217483-1-hengyul@cs.unc.edu>
References: <20261112180808.1217483-1-hengyul@cs.unc.edu>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 13:08:08 -0500 Hengyu Liang wrote:
> Application impact (Ubuntu 26.04 user space): Kamailio 6.0.5 with
> "auto_bind_ipv6=1" added to the shipped kamailio.cfg, on a host with
> one IPv4 and one global IPv6 address. On v6.8, it listens on both
> addresses and on localhost. On v6.9 and on net, it logs "Could not get
> network interface list" and listens on 127.0.0.1 only.

IDK. Maybe others will disagree but I feel like uAPI changes that
happened (almost) 3 years ago are "settled". At this point just
fix the user space.
