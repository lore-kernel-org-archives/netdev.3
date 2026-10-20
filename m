Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464606;
	b=NUnYd+Cz7qxnaOYRy+S0dN6anIB/hnvaIEK+GwszvpRFDnW4fa5udjX3cS7O1xSsBvk+
	 N0zwYrG7AZP9BjsGOgnLViH0d6ogvFqubJtpDthDl25NQMjYdamRyjQhp6aJOqipike4e
	 cc0onKd2BS1M7MaS+GHAESfiIB6seIQxZrYheRw0ZccxPlYlJ1m2wpTz2wTJU4R3L2LzG
	 RSfwFChWmPv0LATFXTcCOnLL4omuIpq0Xpwd2zIuXoNcEyJKBP4LZugYHwPv7hEJyQqnl
	 f3a6MLytpIBntO5bSWkoNtYuWRDLcLaKZVUbV6ruaM7ZTHeteYCVfnh023lI5WmoYvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=0TMjVt+LlvokeOU2YUvSVZACIrTwaDYIYzGe6LxrtlhHBZLeqnkuwoQW6mokbcNoSD5U
	 ZA579WXEMmFwoFoVilI8QLnP79Qcul9IID1rEaHCHPge92N6qgtS/S4Gx5bA/f7OoyTz9
	 aET/k3mNhoioI8riKP6CEa364vTM/Q1N/+Ft3/DUvLL7lp+V4j862dXB7KOivh4IWgUst
	 VScMzH0Zd03Hu8qPDozBZLzBODou1KHbxYD8WyRWgcnFajEF7cHPB73JnTv8B7fn1bNlG
	 xlePHDw5xwU3kM9nhE3mM8njPP2f+Dq4E+d7G5Hfh5J5NrVnoe1TWfynRNFBwlS+Kiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX8Dojiy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B73606A31B;
	Tue, 20 Oct 2026 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX8Dojiy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DD21F000C4;
	Tue, 20 Oct 2026 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792464605;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PX8DojiyryI8Cy1W42bSDNXBQxGKz69zvqwMB0FqDPAXUUIBTsNmNh51pOnTyHQgE
	 rgZiJUMRf/uRxf0HnWYtZU1ixK0R0y+9wopFIRMZPlr5zffQt+TDIEV9slVCq7cbXy
	 o3sbCyv2W7PZzhbnFiXU7i/44qSf1/f2zG6J7kTlup7xpmlFRgG7rH4GSpp0gcJ+re
	 pBU1x3e5dASkUXRj4uAYWzUuzfOL2AVbjvuG25E1hXKP8ORiZj8eoFTHnESPhUMWqc
	 WBC33eD51hHl/xY/lbHcE9viWynHpKXywBtJudsY548NpmusvhC4gPjfVg3y2k05u2
	 CSkw50Z2Pol2Q==
From: netdev-bot+sinfo@kernel.org
To: Binbin Deng <18983559317@163.com>
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] qlcnic: Protect loopback filter hashes
Date: Tue, 20 Oct 2026 02:50:04 +0000
Message-ID: <179246460434.3290.5287647652531785251@kernel.org>
In-Reply-To: <20261020024417.517941-1-18983559317@163.com>
References: <20261020024417.517941-1-18983559317@163.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
