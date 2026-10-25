Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931030;
	b=oOwPCIcfR9uJZ8S5VAZqsTvvEHz3falBNM21rlcaoLK8Bytf3oAaZfd/IcVButEfIAK4
	 Ii/r2BFkDgUDsgZr6WtEbRrhTKeY3a6BFt6r+rCG3Fi7mc4LrK1WvWHgDD3/5dtCfYQw6
	 EMI6/PybaIlfpfCjWReeKN5p4tEsI2MKFjgB5b7NdlRZmqTy88paBRRt4tAO/H6Y1pozd
	 31iXThPitxeGXlm3h68eN6h29UWomVmLcxk/30FynV5GlygVFSflDnRIKTrJCZystuYay
	 AS9iK+KvOf5wUHMRYD2syHmrZS3vhnRShM6luMVy3v3oBDdCgligRCIZu/AfyhwNuNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931030;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=WCJq7Spt50NY99h3wenFRcpEIoJZtvetq+C/35JzX4c=;
	b=00F68KP6wV35S6ykpuGOugCrXuUM62N48pnaW9c++t7cp4YzQPenzpOggsnlhq6qmLI3
	 tSvCixqLfbVfxF0wcSW9zm1X/GXSTC5Ctmzg62tK/CHXD8jXJSlnc6x1CVBqzj9TRY6uS
	 jlpe7GwVw6iaHfy+JEMY8QO/1hU9HS0fY6MKt/Ixld/DTdkTDK3I8/S8pxs4X4+gFo8wt
	 32gyZViPMEsf3BAKGD+9pKo4iPcCb+p5Gm1/GqI/GCBA1cfZruQNijwyxP5e6AvMYo6fm
	 cfZC2GYycaFxjYYBYfA7wYipPq9rRvHKxR8C8cEch+gA6qpH4nrbME+pWps1GWitWhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CmEmXH0k;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C0606A31A;
	Sun, 25 Oct 2026 12:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=CmEmXH0k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=CmEmXH0keYZExIibYd2Z4j4puaoQaGMxTI5eSDTzKvQSPwAumIar6hhBx4TWkXCXNcOx1r2PNK9j3
	 8mfzocU2rtZhnqINpfOqb/JsThkezZXMLscnmtMMeThhZm4XHNeKSkjx0Jolxp282/3xyA9SijEP0a
	 tS4e9oGJ8lgmldL0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86addf4d023e-e4627;
	Sun, 25 Oct 2026 20:23:44 +0800 (CST)
X-RM-TRANSID:2ee86addf4d023e-e4627
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26addf4ceb0a-878d1;
	Sun, 25 Oct 2026 20:23:44 +0800 (CST)
X-RM-TRANSID:2ee26addf4ceb0a-878d1
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: edumazet@kernel.org
Cc: netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dskr99@gmail.com,
	maheshb@google.com,
	linux-kernel@vger.kernel.org,
	yana06070@163.com
Subject: Re: [PATCH net] ipvlan: fix RX byte accounting for local traffic
Date: Sun, 25 Oct 2026 20:23:32 +0800
Message-ID: <20261025122332.725535-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL4WiioxAR1ZBjVJNgYfLM0hUwyHapRu+TAUzedpOpe0yheH3w@mail.gmail.com>
References: <20261025014251.542973-1-yanxia@cmss.chinamobile.com> <179289279836.3327.9494173903555653580@kernel.org> <20261025052117.603790-1-yanxia@cmss.chinamobile.com> <CAL4WiioxAR1ZBjVJNgYfLM0hUwyHapRu+TAUzedpOpe0yheH3w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Eric,

> Also macvlan has the same issue, maybe wait for net-next reopening to
> send a series fixing both ?

I reproduced it in macvlan bridge mode on a 6.6-based kernel. For local
broadcast and multicast, five IPv4 UDP frames with 32-byte payloads
increased rx_bytes by 440 bytes instead of 370. The captured frames
matched what was sent. Local unicast and traffic received from the lower
device were counted correctly.

I'll prepare a net-next series fixing both drivers, without Cc: stable,
and send it when net-next reopens.

Thanks,
Xia


