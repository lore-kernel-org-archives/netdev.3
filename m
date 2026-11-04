Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804968;
	b=yPh57KOuqMBS2g2pULQ4lpufN5Sl/eltLgk/s/Hcpe77FoQc15oFNRqywnjqrkrFNaKX
	 3XnIifUW+8r32Wz+2WM2Ymit/DGpYgL3SOSUhGWSx5W6KVuktsiD7aCUAQLwZCX01rnlO
	 Kge82kdPUhC6M7KvDBWDAPYrIJYpHHd8Qu4ah4l4Zm4wEEOTBJhqzjwi6czXDcWuRxuNK
	 jrYpieqXyM7sWHmLaIBdmm2RDvTgcRrazNLEiSCGGigmu7TO1NxibfzBEVlEXwozKVgZK
	 rJ8oeakuPjaB511M6kV2gd/zrS61MZEYXhmGkCTpiZX6Vh46d4Zu0E69FMdr4u6Y+Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804968;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pYaBYvyHGfqovA0PmSh49RnZhLfxkHCuFby1QxWDzbg=;
	b=J25fAuCulyXTm/CWsTerLkqJ7Q/fUms3wDnMnO1ejWAglysvm9sAj3DKvGG7FwAwUX+V
	 x6I4r9br4ji/QpDiAj5d1ER2yRg1r0T37Fbg2XXYA8UKwAb7SVXdTmNX05tFTVHr0Zk5G
	 qyi3GKgh0uh28az+qBAMENCNVWSua02xKFZO0gmv1DymWasO6b4Nf727p69eKPXAb+XAw
	 AWJGKONLookoJNC7R2ZbUQdGnx0Pjy8thZQs2bST/51IXOckgQbQb9F7gTpqcpQr7wSZf
	 W9LKk5H/0aWRVPMWfW9M1pDPT8wsVFKfhoncyNhoOqGCCSdkYS38tSik/phlkRA0mnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Eoph5MmI;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4B606A330;
	Wed,  4 Nov 2026 15:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D4B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Eoph5MmI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Eoph5MmIPb0ytWXb28Qha0xneV1DCdjoeQyjfxrtu/kLsQfit7nTuPtfPSt6RToq6z9kFDIuCwIMk
	 CRlsXd1GyEVEUfxCUYvMNpGv05RZuqVz2NoE/Sku81Ly8H7Nrpu6vFvRRxGJKVmXAKBWy+xQgK4VGO
	 ESGYG48D8O3F0xYU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aeb4a90177-6a51c;
	Wed, 04 Nov 2026 23:09:11 +0800 (CST)
X-RM-TRANSID:2ee36aeb4a90177-6a51c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeb4a95cdd-21ec0;
	Wed, 04 Nov 2026 23:09:11 +0800 (CST)
X-RM-TRANSID:2ee36aeb4a95cdd-21ec0
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuniyu@google.com,
	xeb@mail.ru,
	yana06070@163.com
Subject: Re: [PATCH net] ip6_gre: fix changelink conflict checks for L2 tunnels
Date: Wed,  4 Nov 2026 23:08:59 +0800
Message-ID: <20261104150330.70978-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179353522212.3131.3721818848581323546@kernel.org>
References: <20261028115710.27806-1-yanxia@cmss.chinamobile.com> <179353522212.3131.3721818848581323546@kernel.org>
X-Mailer: git-send-email 2.43.0
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The collect_md case is valid. I reproduced it with v1 under UML for all
four ip6gretap/ip6erspan combinations. Without the metadata tunnel, the
update succeeds; with it, v1 returns EEXIST. The revised lookup skips
collect_md entries and keeps walking the bucket, so a real ordinary
duplicate behind a metadata entry is still rejected.

The revised patch passes those cases and the existing namespace tests.
I am sending v2 to net-next with the Fixes and stable tags removed, as
requested by Ido Schimmel.

The encapsulation setup runs before the lookup in the existing code.
That rollback issue needs a separate change.

Thanks,
Xia

pw-bot: cr


