Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447699;
	b=vUQgwpai6IrOmh3sBOpoTkZ8w70xfR75kLmlawqVrNfBzTodGn4haK7jqWg5P21CCSWx
	 JpBhOS99/sv4qNXdy4dI0Najl+S9mPDN94iLaJPqMlbin6Il2YsNOKBJ6hND3r84SUuTa
	 gi3ITV/zvHcTcD4CL1rRt44GAfGmEc5uIAQh7ERjnTiICrHSc8MdY6VyzZ+g9dEYlQVhb
	 Xs9CH4hLjcuR4IFaukupj9xTOMojMAjts/VrAk2Js7tQrBzDtHx84SOI+ueYlB4mR9n0A
	 gLvAKtX2RmXvFzZ6r5EhNgBS9HlReF31hSSFYGg2P+wF8AUhij5oxmwQrqg/Ynez41Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=rd7HKNoZdZvE8lr/tvCzJ8B26fSCroLo4VvAtY1YV38q9QJwGHdHYR2y9H8C2VDgJoNP
	 np4jy+4k+1QkZfulAC6EYeFZy4leG8j/W1rWHTjC3lr+VN5U8vDJaZYJ2BsQAFfsKe1jn
	 AgOVIeuAshv2VQoSlBzGwpgLFl729I/vXDLcwiwr1Gwa5eZzowHoGB8rjVnQIDHiNXbix
	 GGMtXtZmtlNofxREEFm5yqbotEVyVeg/2BCKV6vxD01vcSVkpcPQeZItRfrYVfIA7hNik
	 RxsREbQ56aChX1Z52ZzSNSfnxL/NWhMJWpdr1WO/nmxXgwbmm6VyfpPt+eSbK+tyJJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SidTa3oo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE71606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SidTa3oo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE58E1F00A05;
	Thu, 12 Nov 2026 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447699;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SidTa3ooh+dDUnsw65X63uLxzNg/ez+yu4ozqE3le3/IDWgcdcqL0/n2ratb+n8nP
	 vo+vko1f74c+izxVAtj0XWZTMqu2fxi3eKDLfmIlKX0No3e/tXWTGSqma4B5F2kUG+
	 kdGAUgQIk221C1D072hw5Y/2LzUbXFU+lJm/m1b+RZhUOYHlQBIz/GS82ZLN6NZUUT
	 HLj4983t7tgbwAQiej98FzUjBuGlCbUGl6DDkHdujavx2FCS8JSPJVM93FAyHe49H5
	 3kvB80B4hWWpzPIKg2E/k3utsQEK7IHkcgRpsoBj0YniVxUR0XbEDeXhixR7bk/Xjl
	 FrHWDfNh+lsmw==
From: netdev-bot+sinfo@kernel.org
To: Jiaming Fan <fan.jiaming@hotmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH iwl-net] e1000: report RX checksum offload as on when it
 is enabled
Date: Thu, 12 Nov 2026 01:41:38 +0000
Message-ID: <179444769837.2168702.18320155804189818970@kernel.org>
In-Reply-To: =?utf-8?q?=3COS3PR01MB10251F4C0DDF4A1AA90095494E7702=40OS3PR01M?=
 =?utf-8?q?B10251=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3COS3PR01MB10251F4C0DDF4A1AA90095494E7702=40OS3PR01MB?=
 =?utf-8?q?10251=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
