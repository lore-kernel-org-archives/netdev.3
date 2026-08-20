Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC713D886
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787188868; cv=none; b=N9cS/ZGd7IFsLmAsilAmDxYJd+M5ctw9V+CeS0CbnXwz9QSikyrWPlWne9odDxGo+9t+Pu4OdIO/HMdKJk+dgLv/qacYQ2qJotEbKWgv0FrtVumRx/UWCRt+gGUpK9ZSVIgH3gAS/KSGC/tb82+IryeT3OGcpVcaQd7OJCEdx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787188868; c=relaxed/simple;
	bh=H4Jm/6UQJMHg5bqVSZrcY/fB0MGHputJfnSaNWrph6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URh8mruFpf9EBuF67rfzRFNhWRNDoHCkavgFjqnYEGWs7NtM73X/nohws5BcTvtaulj6RdMydA616S4F5eH7iVdZkk2UdbEK16grxyv6jPiVRYEHVaepcyfAET9FTLKymBG7NfppmA9EekNtpCBymGGVuIPmwf63dRPI1zpABaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 689bbdba9c3511f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8a17b0ce-782f-41a3-b86e-1784673c23b7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:57d20e8d050aab34dd74522b840d1e94,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|136|850|865|898,TC:nil,Content:0|15|5
	0,EDM:5|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 689bbdba9c3511f19a56ed5b684f684d-20260820
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2009243294; Thu, 20 Aug 2026 09:21:02 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: Re: [PATCH] net: stmmac: platform: fix of_node leak when breaking RX queue loop
Date: Thu, 20 Aug 2026 09:20:56 +0800
Message-Id: <20260820012056.3190641-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6ca6be2d-548d-4110-9964-567bb8788e62@lunn.ch>
References: <20260819073258.467604-1-gonglinkai@kylinos.cn> <6ca6be2d-548d-4110-9964-567bb8788e62@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2026 at 15:00:26 +0200, Andrew Lunn wrote:
> Why not for_each_child_of_node_scoped()?

Yes, that is cleaner. I will convert both loops.

> Also, does this bother anybody? I think this should be for net-next.

Agreed. It only leaks when DT has more queue children than
rx-queues-to-use. v2 is for net-next.

> And while we are looking at this, what about:
>
> https://elixir.bootlin.com/linux/v7.2/source/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c#L232

That TX loop has the same break. It currently survives because
of_node_put(q_node) at the out label drops the last TX child.
Switching both loops to the scoped helper also covers that.

I will send a v2.

Thanks,
Linkai
