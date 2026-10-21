Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562491;
	b=AuZwfjCuSnHC80T3De5xos2SzIEw7cGS3I0VFgUsMPSthyOpfEt8izqwpmCN1fqR+V3U
	 z4sVY+7h+yPUIfwusYQy9UbdaPAsbwsKJTGD8yBPqrSu6ddWZ2btMTAIjrrJGnHta+jap
	 w8grgcvWuLQZflGGiIWX/D3s73fgHI8FDJRLltm5SUF1D771tHGK5Oa6I5BhC3V6HOnr4
	 nwRnLj0+RVr55yVddx7iAuSt8akW3LR2JnQ6MqpQKnKEGH5aiSUtOyHf+c0dgOybjMtAu
	 5PRao1sVrxd92hre05/Xr7EdHXQpwRuIWohlGWv+LB4uM5KLVxKno5NjvTH7QOB97Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562491;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eNZXlOLeewTXWI1WqIl+aRPlHrAtJyq64DqUbFKnHpM=;
	b=O4mYIdWDT1UCSV9c5GkEHfMnsRetc4DzSBGQOioJ9KYapVcya3a10j5RCgckBz6ya49q
	 Vx5Vh7TEi93AawcH5VM7NeG6kAYwImSTBTFL4vxMI+L3DfPNTAfBWTzBOnJE2Es4dtu9B
	 gGQBZvkC/upZLGNCfK6T5wGFxX3HqDvKpxstaFG98URFSiddOJbAI7cc2ldDfO0HNGUA+
	 9TMkjMwYTZXT37iI+bbSsi0Y2Oi6eyvoscho9JgO+r9zM7xFZ0I8axzKy1n3ealben9ja
	 8wqSbG7dvUTV681o+TtfRVNQxynmT8zLJ+/UCcBAX0r6snbjH2r5f1JqNYX83u9U4jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=k8clFnzx;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839C606A319;
	Wed, 21 Oct 2026 06:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9839C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=k8clFnzx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=k8clFnzxlkTV8JkA5DtvnSZWhSeRPJRApawnFQ4sVSae61ThjWThhItgBXDe9d5oHPyu2Tvr4gy2L
	 tqZkzJ4MI9bEJGxGA3MbcBdZEkhk0sFqQ8ZIY4njQ4mxRTsrCVJSHcmyPC7nch+mh/jcMtkHGeslXk
	 hlMJlNV2ymEXnF+Q=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86ad8552e2b0-c2455;
	Wed, 21 Oct 2026 14:01:20 +0800 (CST)
X-RM-TRANSID:2ee86ad8552e2b0-c2455
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03 (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36ad854fb0a6-e7187;
	Wed, 21 Oct 2026 14:01:20 +0800 (CST)
X-RM-TRANSID:2ee36ad854fb0a6-e7187
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] erspan: drop packets with an unknown ERSPAN version
Date: Wed, 21 Oct 2026 14:00:22 +0800
Message-ID: <20261021060022.2809935-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171555.GA3236673@shredder>
References: <20261020171555.GA3236673@shredder>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 08:15:55PM +0300, Ido Schimmel wrote:
> __iptunnel_pull_header() drops the packet if it can't pull the Ethernet
> header of the encapsulated packet, so there's no memory safety issue
> here. Only reading metadata from the wrong place.

Right, the ETH_HLEN pull covers the bytes the metadata is copied from,
so the commit message was wrong about that. I will fix it.

> Given that this never worked and that there's no security issue here,
> drop these tags and target v2 at net-next when it re-opens.

Will do, thanks.


