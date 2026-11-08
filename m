Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129848;
	b=lvRypMSzHNCEQSmUgnKMmh88wrCGjYJO8iWm/gZ76Er3wi2t3dTs6HeCY2ACKG8Gw8y8
	 3FU5WpEszHbMiOGHEpyRzwp99dL/r0Nx7cmvi3e+TkWjX4IOomCC+DLMi2Doc3t+ZcYET
	 AoiolNlly2AoHX3rLW1SWQUsWi6CZqvUz5NJk3B3QBgWvMP66aYfs7gFPnw/W+QofjjuM
	 DLoGeV22hu6Mr5cb8MX3z9RR+4KIG09npUVkrNmUHuWZvqnpZO8z4rwVlBh+dBjFANx/1
	 ob9hultrsnmaQRWR5jNSnkAX5tbHAObMyo64EXX0wVPkISwIN5XYkKuhCYRGb4tkazg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129848;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tQxKIyAXlBwDhSPp/TxaPn0rgpWq0tA/ezL9W8QK5g8=;
	b=NFKKMIYCQCtLdIC6CC3cgotKkBeZwjIPrZLiyA6bdEWfUTQjtdM7tfRBswGYbSTVQNrQ
	 sqjDEO3SCscbsnRzMM7XxyuA1YyU3So8McMbUppANzUF3yIlslpEe2MrY5hnAPCyFK8Su
	 ZmsbTgjU5ZQSEgxkJWUgdkDEqMJ2AcQayjcX077GwUHquXLeud5L/e59l6K9rq6CyPsKG
	 3JOPYL0z91lM7t0z4MCbvuGnaZFVEaGvC9iHukul+SJYb87PA9Z71CUWeJAeDzv+bezdf
	 BKMs3qb287AeMb5vNjVx7rXS9yBqaVGw4vxImMiNwBCuwLJmlGDL0uQ0nlWxain+vaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Xb5SpIca;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F9606A31C;
	Sun,  8 Nov 2026 09:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Xb5SpIca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Xb5SpIca8Ls4HS4b1mNSKI2j2rhFbRDwLYnkQRLmMGrP0oQMF61vhVBostJluXFxR4mncuehzHV2+
	 N09G05PpF1hNd5AgZprrjEHdp8qqHOeTTR+eoU9wZvnZAiyNCjZdY3hMrU338pKTa3p58J41AoGKg+
	 5VtLWPP76ZmgXwUA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af03faa28f-c0433;
	Sun, 08 Nov 2026 17:23:56 +0800 (CST)
X-RM-TRANSID:2ee96af03faa28f-c0433
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af03f9e529-63cf5;
	Sun, 08 Nov 2026 17:23:56 +0800 (CST)
X-RM-TRANSID:2ee26af03f9e529-63cf5
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <witu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] erspan: drop packets with an unknown ERSPAN version
Date: Mon,  9 Nov 2026 02:23:09 +0900
Message-ID: <20261108172341.56557-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411422969.994134.8902723149137301857@kernel.org>
References: <20261107130030.35220-1-yanhaishuang@cmss.chinamobile.com> <179411422969.994134.8902723149137301857@kernel.org>
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

On Sun, Nov 08, 2026 at 05:03:49AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Can an ETH_P_ERSPAN2 frame with a 4-byte GRE header get around this new
> check?
>
> is_erspan_type1() looks only at gre_hdr_len and never checks
> tpi->proto:

[ ... ]

> Would it make sense to also require tpi->proto == htons(ETH_P_ERSPAN)
> when classifying a packet as type I, so this path is covered too?

Yes, this is right. gre_parse_header() takes an ERSPAN2 frame with
a 4-byte GRE header as one with an ERSPAN header, but erspan_rcv()
then treats it as type I and never looks at the version. Type I only
exists with protocol 0x88BE, so I'll make is_erspan_type1() check
tpi->proto as well and send a v3. ip6_gre has no type I path and is
not affected.

pw-bot: cr


