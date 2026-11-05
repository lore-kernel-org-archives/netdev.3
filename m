Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922065;
	b=SmNTWHATyobhxAOP7RQmagE7XCE7G77Q/9QJ5DoMNbnPAK6BVZonuewaRFX5AnMQFagO
	 hrpiCwXce4Bz6026G+Zg9qzmszoWYPxl5tQkZhIJhLICK8ghxAPLcoL9FE4BhASv3AjnW
	 aflsJF75xVEH8njY7+cCNP9IXDBE+MDjNeI+N8gzwzVS9Vod4MJyLhojwwvVsBHAHBeH3
	 bxwxJDP+HvkGVR5f03HlzJRKJANJ7IFtVQsMTutCOuPHpFQSeexklbx7HZMxzjQId6vr1
	 i/kiqIOo2uhlmzOWLqx8KSparheBKtDf4zTQ3pkRed6vvm7RG4ovZlKBTGGf1/QavXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922065;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mpNNvS3px6ys5AOGViIx/mWfJk8yX+CKrJZwmVMd1M8=;
	b=rRIjQ10vCvwiGRFICc1boYC/575WxepLS/peP7ulaiX1GjX2p9j9lzxXYfAAN0JBvE2Q
	 IZGqda9Vija0kzYVdj0RlEw6tV95CgKazTOy5DNR4v5O/7lFC1hnXWLdu7RMUCJINVLuU
	 VvPTsmL1vZbk66XKMolWSA2QKoL7djeeTPdFdKhxXj8OJKJ6AdwsHxtDiTcTtiR6caPbO
	 Cd4f39SsGtRxOEsnG2Na4njctt9acCoSzgiu5dr8Ubj9RNyQrLqB8dFi/5SGjrVI6m+WA
	 vp8Xe6K8mmU8Ux64PJMaIaJ4TwgK7AcTq/yqxzJ2hDQMLx6aHXvBKYtt9ERvwjXzZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFpnovPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B6606A335;
	Thu,  5 Nov 2026 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFpnovPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958E31F008AB;
	Thu,  5 Nov 2026 23:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793922064;
	bh=mpNNvS3px6ys5AOGViIx/mWfJk8yX+CKrJZwmVMd1M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFpnovPQgLhzcLrYd3EygLnzv/d3AnzcyuyVDaItFg6fm1txA1MFdlw6xYTVcTSPm
	 aiwtBhSVRG/2WMRncyFmb6Y+YWgA9AcXa0BAkYuMt1QBwdH3CcQAq43Qla9B21MhxH
	 F9RZMKt61ovI5XULjkGhs+0UmbWYcOCx7A1rrlRs7y2FIIJ108SziXesSZE2Xga0My
	 xaq59w6wOn+p4ar12TM/jUPuBp5PTdfv0Cb5/N2qJZrTQ0fEiy7I69q7cGkY6j9mCH
	 ZpW6UIuAyyEGxOQLWUQNBAVUzWH3qnAMXY4kt3H57TNgamDu0RyUPreLjzuR0zYTiY
	 Mbvtv0zi5Eq/w==
Date: Thu, 5 Nov 2026 15:41:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v33 net-next 0/8] nbl driver for Nebulamatrix NICs
Message-ID: <20261105154104.18f24322@kernel.org>
In-Reply-To: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
References: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
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

On Mon,  2 Nov 2026 15:54:01 +0800 illusion.wang wrote:
> This series continues and refines the previous v28 NBL NIC driver patch
> set for Nebula-matrix m18110/m18000 (SNIC s1000) Ethernet adapters.

net-next was still closed when you posted this. It only opened after:

https://lore.kernel.org/all/66b35989-9195-4e96-99bb-df383a52aa5d@redhat.com/
-- 
pw-bot: defer
