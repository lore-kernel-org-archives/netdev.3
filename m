Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787871;
	b=zLPSQ9tAYgdsIVFJl5AkkO4u8s9OTN0oJTIAckikQmj8MBOaB/VVXNwnLlcE9ZyUVTFw
	 6lljGSF9305CZiXjUePU0gzGI82iNArirY4IrRA7HYjbqqhIaPDRmLZnQPxje9rD0Kuai
	 QbffigaAEkYOfkeXdKBRlUfSF5/yhg/3dvnd3cf3a9PD0du9xExIujbcSccBMM5gS2M0W
	 IU8OcvhymZt36aVFDAn1MKnWrL+eBiwJUCVRCVm9zpTZkjYtjvFQmV8aT3IDRzNriYkuN
	 w43nKFxAD1X2hgsJXmpZYV6B3OJA0zNw5uDWmpPsfYClWezR/eHYpDvhrz3XZYEvaBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787871;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XvgxgNB1ffOcRWX3bhu6xrHhXe9E5FGA5l0NPhkrgZg=;
	b=1aQ7OX4D+EtKLjrlAc6e8PXSIXze/dajepgMpjt4/P68e2VDipf80vkOuxLbmN9NJII/
	 4bLvIccwkoE8qzJOir0obs2EfZ2e1+1qAmhKqVwitW+u2GFCddguMZ/HJHsdZS9FUWAuw
	 6XFzVOjB/c/m8xk65v5qFsMS9AL46YZsbssSce25coW6lgcMtSF1xthW9bdd7mNjsHK7b
	 ymdohixsbi6cPPi3m9Iy6PanJgBfvc1yMxw1DacLSfYTKzDAwnWwpq092uniVBr99JtCc
	 km7n+4+S1rx7RN4sg2zbhbowjrFKCUK9lWEInPFgJ0Xp2BwTdQzEHbu8rkSdwJgb1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyuunmeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD4606A31A;
	Fri, 23 Oct 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyuunmeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D7A1F01825;
	Fri, 23 Oct 2026 20:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792787870;
	bh=XvgxgNB1ffOcRWX3bhu6xrHhXe9E5FGA5l0NPhkrgZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hyuunmeY6kKg/g5FxHDjfS38lRM08JlrEIZ53RRh3DBstctHEq2VrPMirgTwj2vzB
	 8+EJ3Mx4UJ0vsXtBvnlgebuqp4/pIcDATG0OZC/mGIAdOzsiq2fqzZwYG9TZcNlG+o
	 eTqkjbbVqxH+0XxeIZbEvCpZQ/DxadvNnwonPzyAA2Rn2shekbrjkMt3Wf2wUeoPVw
	 RJvodduhIX+EAuvz4zcU1rJeeOpQ1bvdsWo0zVw8FVXpUOdB7K0h38Qv3mg6gFfaSy
	 ajrXm/Zx7NX2wOZGmNbzkQ0OqDmL4emVLsx2qo/K/EEKgdIuwf3yliY7u93/0ryTHR
	 FYkzUBPICq/cg==
Date: Fri, 23 Oct 2026 13:37:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: divyanshu jha <divyanshuj2006@gmail.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Oliver Neukum <oliver@neukum.org>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: cdc_ncm: add Apple Silicon MacBook
 Air (05ac:1903) device ID
Message-ID: <20261023133749.02337983@kernel.org>
In-Reply-To: <CAGg1W3gd_nyRs6BrAOV=ysKJsQMQTOskv+DpeP=kf+C-o3JXdA@mail.gmail.com>
References: <20261023070419.235361-1-divyanshuj2006@gmail.com>
	<a386789d3d2d6709cc5e9c8b2b05a283@tipi-net.de>
	<CAGg1W3gd_nyRs6BrAOV=ysKJsQMQTOskv+DpeP=kf+C-o3JXdA@mail.gmail.com>
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

On Fri, 23 Oct 2026 19:14:45 +0530 divyanshu jha wrote:
> I will correct the "cdc_ncm_devs" -> "cdc_devs" typo, add the
> model/descriptor
> context to the commit message, and submit [PATCH net-next v2] once the 7.4
> merge window closes and net-next re-opens.

Actually, feel free to repost this tagged as [PATCH net v2] with 
the feedback addressed. Pure ID additions are acceptable for stable@
so they are also mostly acceptable for net.
