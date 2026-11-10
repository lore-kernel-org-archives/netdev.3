Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278318;
	b=LpL2A4O3LmcDERfT6dIo6WV36hQd8Ic1SIN4oDgRXasAWAG2dS4UB2k5tBRv6+eY4NCC
	 CwDNMaSacVcf7zlIibe6Q6UrPfYNvXC1Ia4zkuuHJvRaLAo2ED1O6KrQLyGYEdvMDNSLz
	 27TvgW2h8XAcLN+mxowswiEw4A9sWHrHBfmX4r1ZaShuP4nYNYBVOdMKfeHUmrxJFUKIk
	 sVzriy02og9vNzrDPV5X/FPB5Mu+NuFwdM26BAB9rs0FWh7+l/35xaBpULROmtT8DacQE
	 C7DO+mv0qFncFDIlb/C/CP5HKQMdl7X6Pi8dPLJ1m1UxPBpAmX6ME9mQqCw9tYMDVHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278318;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eVM5XFxpTekZI/TznZd5JXWHYNNpDG15hrmiBUopk64=;
	b=wIFDAPyFcBiGjzo6eN7V02jsi91l1NG35VskQuPzFI2m+JzTiEKpjaM8yILKxc/Gqzra
	 WxXu8ARzNkfKn7tZ5sj7Pa7+bZ1+gTaghBc5XXRD7HZeb8FaI0eq0rp7SsGOrnJImxPFP
	 jggshNF2LH/mvv0AcRXb8r3aZopFn9rUXpVVikNEHFaJLc9TvEJuQpXyLw2e2wjfmNp/x
	 Dj6P3irNjC/82K+aeykfgvNqaGojVjyEGy9y4weebuJgpZ1VLqcvhP4hgMvp0FTrdx2Gl
	 tfZIEw/FA5Mkbr4eJKnGhXY1mgqZbt3kGEpSDHhF9aaw/pFRqsCRey4gZ9ssSFEhdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=co5amkzN;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AB60A260D;
	Tue, 10 Nov 2026 02:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369AB60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=co5amkzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=co5amkzNgSM4eSt5maBYOipTvdJoD6KKIekUMjO8V3MWhhzeyX9HKO0FPrl7hK+x6rW87jGNkhQv1
	 g2Mj+zIRy1+f7dzbSNu8JqA0UpxsDc5rFRGiPSTc19Onygrz2M6IEz9LAxzagDCIwyHqQD0+7K6Miq
	 1EQC0kK4WHuGSd9o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af283a8b65-c70bd;
	Tue, 10 Nov 2026 10:38:34 +0800 (CST)
X-RM-TRANSID:2ee56af283a8b65-c70bd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af283a8745-a37b7;
	Tue, 10 Nov 2026 10:38:34 +0800 (CST)
X-RM-TRANSID:2ee56af283a8745-a37b7
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Simon Horman <horms@kernel.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Haokexin <haokexin@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()
Date: Tue, 10 Nov 2026 10:38:30 +0800
Message-ID: <20261110103000.3141-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261109165902.GS18859@horms.kernel.org>
References: <20261109165902.GS18859@horms.kernel.org>
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

Hi Simon,

Thanks for the review, and for looking into the neighbouring error
paths.

On Mon, Nov 09, 2026 at 04:52:35PM +0000, Simon Horman wrote:
> But I wonder if this nearby check also leaks a reference,
> because while it drops one, wouldn't there be two if the
> condition is met?

I don't think that branch can be entered at all, so it does not
leak in practice. eth0_node and eth1_node are both initialised to
NULL, and each iteration of the port scan loop assigns at most one
of them (the reg == 0 and reg == 1 cases are mutually exclusive),
while for_each_child_of_node() visits each child exactly once. So
the same node can never end up stored in both slots, and the
both-NULL case is already handled by the preceding "neither port0
nor port1 node available" check. As far as I can tell, the equality
comparison is dead code.

The DT error the check describes, two port nodes carrying the same
reg value, does leak a reference though, just not through that
branch: if both ports have reg = <0>, the second assignment simply
overwrites eth0_node, the reference taken on the first node is
lost, and eth1_node stays NULL, so the equality check never fires.

On Mon, Nov 09, 2026 at 04:59:02PM +0000, Simon Horman wrote:
> Sorry, one more thing. Which is not strictly related. But as we're on the
> topic of error paths in this function, I am not convinced of the validity
> of the value of reg being used even when the call to of_property_read_u32
> fails in this loop:

You are right, the error is only logged and the uninitialised value
of reg is then used to select eth0_node or eth1_node. Depending on
the garbage, the node is routed into one of the slots (including
the overwrite case above) or, when the value is neither 0 nor 1,
the reference taken by the of_node_get() right before is leaked, as
the node is not stored anywhere. This is the pre-existing loop
issue I mentioned in my reply to the bots: the "port reg should be
0 or 1" branch leaks the reference even for a valid out-of-range
reg value.

Understood on the patch-set, and thanks for the hint. I will send a
v2 that combines the fixes for the two drivers, keeping them
unchanged and adding a per-driver patch for the port scan loop that
skips a port when reading its reg property fails, only takes a
reference for reg values 0 and 1, and rejects duplicate reg values,
which is what the existing check seems to intend but never actually
catches. Happy to adjust the split if you would prefer the loop
changes as a separate series.

Best regards,
Xiangwu Lai


