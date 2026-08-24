Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC93A450C
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567075; cv=none; b=ak3jLameL35BWT5hspDseCAYfWTbNvpBa6O7UmzLsRDGivJHYN0PdcKGdd9CKjTJzwYcV8/kIsg2E2blu6R8DtguY1gGz+2gFJs1HI109tNyvjllA6jTHgMjBMgd5y7x02OT0ezgD0t5OTrVBQp9iD8W4WJRzMXO6hX0g9/5XRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567075; c=relaxed/simple;
	bh=3wAyxzzIymASl2h2sDW+VYwM74tzh989bqPYlu7fvoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJe/mzY8Lk0QDaRoEAwFbFBCl/uhtPbUkbwVqSRvz+x5cwdiOtZtNXQm2goZxg1NB34Kda4rFdWbMdnLwHqhepfC3ibmb1XTvdUZV0gRUkhdujlunNNQwGhxuMgvtoDebcKK//dGkfdGS6EXCEeenHYRuo+6P4IBm/1YKKuYLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev; spf=pass smtp.mailfrom=dnim.dev; dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b=hBs8Xi9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wp2F2ntD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dnim.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dnim.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dnim.dev header.i=@dnim.dev header.b="hBs8Xi9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wp2F2ntD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EC155EC01C6;
	Mon, 24 Aug 2026 06:24:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 24 Aug 2026 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dnim.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787567072;
	 x=1787653472; bh=3wAyxzzIymASl2h2sDW+VYwM74tzh989bqPYlu7fvoA=; b=
	hBs8Xi9lxLUnAJL3whfZPzUCQMVGvPwK7kNQ29zopm4tYPFoB5KQgcIFLWCnMuaI
	XnoMN2ynFf0CAaTpCkq8F48BmuRXIwQblAOelEVpkvlwzCUqwpnOwjHKq26ZvJre
	EDOtROzL2NYLHjwRrLtlP4B+t31B6CRqWJN5gXosF5CzxNw21jTnvuvXjwmPVyId
	rqNeTX9mcLPSciKuzSIHX/YqppqcXyxC4vJ7hVrLakP9pjtCUOOwU0t1VQzqa5b+
	yxQBmdkT3dM6UHtr1s31OzNCAlUCRde4A2jqcKDEVmavU93hFTeprUVwYVkQhNSi
	x5QCIA510RYb43WX23AlKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787567072; x=
	1787653472; bh=3wAyxzzIymASl2h2sDW+VYwM74tzh989bqPYlu7fvoA=; b=W
	p2F2ntDVxnRlnuvdfPSfln05jEqbrs4qBBdAEVBAq2G+PWytY+5yu6hSATL36rgS
	0G0VvN6CuRqLa+XICjO6TNwlxA3E3ucKWBAX8HeF1qqrIotaSBWSsMsr9d9/H1e+
	7aQYMqwIRkb2pJdSWy/rswxCxb/R/jZNOYQpMjF5VZuie9PmpyrFvly4M6vuhJtj
	VC4w8PEEFx30Novd89u/s2GBzOiLmlYxROJuXmVy6owv9MIo0axIuQC4vMSRDdic
	yV1Bf5lxBU5lkNxWY0+EZx7lGBpUEyZ8LcA+n8vCxNHnCBdfQ5qVEb6n0PAVDPoF
	wLHSXARSqaquX0VdM/OFQ==
X-ME-Sender: <xms:4BuMasu-O5NtfpEYCDVfm8qJwsr2vSUjMzE0WTYGmFl37aaqEVE_MQ>
    <xme:4BuMasB-sn2skj_9pGCIq3vSg0LsQEBet_Ji1B2zOmA0zf5fioSb6_w_AoCqHtlC1
    30ERSslk9Mn39xHQxYXkXzM9oGBhCO6qtBBtX2iXZYUR2jbr3K7OonO>
X-ME-Received: <xmr:4BuMarZM_sKyIW36YufdqLxQt8EBFoEOc34V6Bl1p069Q_FkERpdSIPGuhtSTnJUu4AEV111NDrjk8KniDo6l0PLxTa6IPBSGEePnd-RwC0B9psEuxveUiRWhNJbt0f-uLBelEfCl4pVWXk>
X-ME-Proxy-Cause: dmFkZTED7j+fH6LWsl1Zh7Qw9Eb743Cyiwp2O4kq2Rr9juPSg8l4S+Jv2N+vTr99QJ9xmN
    FewDN6jClAHxp0yX689YY2FKaGMd/o1bSRabpLZpyt43nfLkdDQsp1a464QFEyAx86vdIW
    qbiSdI0tE23SI8sxVU5uICdNE5SDwLryquCfSbAzU0YMvQzVCq+Cpa6uF26ea0EoGlnmQh
    6pMSjiSEIVVgu9bXiS8aLuFSmQYw5EksD96l8MORauVbXCYITOm2MV9aUdtKFoStD79+wv
    wSnvP294/rMGUcX4fU6Pa4kdBT9Ccw/Gj8WtvPYJHpRnfFYGQKTzL1Sbgk3ThisdUq4pYQ
    l4K89tJrIWLztIY3Wa0+1tEM4M5GB5IRjsfRfK3F/OxXM3Z2h633R15ltCKDOF65JQLNz7
    9nht9DFjGMKDAeM6C7NE1EgOi2sa0tkauvfW0SxklMQXjD8CfTkaH+0DrVscXWdxGzZ75V
    s91notq6h5V9ORi9RUXyHtWmWZVWt3kBW573qb/llVQmUBZ6pxYDJYjf/YReN/jmendrlU
    ttHrw6fUo9bG8Zpb9lFAIUhSnHMeMoNYUcdEbKxBUXhGdvhzneKf41yYUg73+uGB6iqJRU
    0y6JZl3Gn7X7jxRNRp46vao9PxqFwiHf94wykLjSF003BE75Ib9YgcoKCwjw
X-ME-Proxy: <xmx:4BuMavXihhg4q9v_V0N-9XIkTIqNVf96fEpTb3SvAJDEBrxRzQmVLQ>
    <xmx:4BuMaiPwstJ3rP40HDPPC2NBNKJrx2D_C3jbutfcw3gMINoB6SkwIg>
    <xmx:4BuMahZn1UUfQ0ocxp4eDDDwFPp3to9fofj0H8vvMVyZqzjcvibPmg>
    <xmx:4BuMap-kyVsxRm6NRmCaBMrSMBhGRFxxhTcVNB7xKfozeqriAtoC5g>
    <xmx:4BuMau7VaikwNLwk30hENDBz8JRQ9VCzoPBpAFd-yu7z1blvUblUhr5D>
Feedback-ID: i14ee4b4c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 06:24:32 -0400 (EDT)
From: JR Lanteigne <root@dnim.dev>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: fall back to skb_iif for the timestamping
 pktinfo if_index
Date: Mon, 24 Aug 2026 07:24:32 -0300
Message-ID: <178756707212.4073008.8425791726071449399@dnim.dev>
In-Reply-To: <aov5lCT4P_3tmRqR@localhost>
References: <178746246095.3786864.2262454553798466512@dnim.dev>
 <aov5lCT4P_3tmRqR@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Miroslav Lichvar wrote:
> That would cause applications to receive a wrong index in some cases,
> right? If it's possible, it should report the index of the physical
> interface, but it should not be guessing.

Right: with the fallback a nonzero if_index is no longer guaranteed
to be the physical timestamping device. An application that maps the
index to a PHC without validating it could see the aggregating
device where it previously saw 0.

Reporting the physical interface does not look implementable in the
two failing cases. Without CONFIG_NET_RX_BUSY_POLL there is no napi
id recorded at all. For cpsw the napi belongs to a DMA channel
shared by both ports, so there is no per-napi net_device to attach;
the delivering port is only known per packet, and there skb->dev is
set correctly, so skb_iif is exactly the physical interface. The
index only becomes an aggregate with bonding or bridging on top,
where the napi lookup would have failed anyway.

So the choice for these packets is between 0 and the skb_iif value,
which is what IP_PKTINFO already reports. No objection from me if
this is dropped; I can respin if there is a form of the fallback
worth keeping.
