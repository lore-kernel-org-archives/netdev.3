Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794110884;
	b=WyDnIEoJY0J+DAFWA0WwcTLSx8904Ru0f6GrVyZmupRNXqeCpuyI5wEAlKQ0IN9h07KH
	 KaLa7yJrMnd7VYOczKpe75ww3aPZfINltJXq6nzgCFDtrKeqMW2FL6Mw3J4Ucv/G0j+PV
	 g4U8jzcmGt9bGwsKo2l48srC88EDzbnjU3MfyYRcvs6eavOg0WZytRdCHQ/JiHd03H5YX
	 8HAF0ysk17/1I4OLAgz8Z8R6j0xeVefSjVPL9hi6XojXbhWsdU32DqFV4pvETXM1XTa5n
	 LZOdaZK0qNnrlkbM1w64k5aGsA2eVT8CF96B6/uNJC5Y5FYSBw54NFEhjAxJURIGRKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794110884;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=i0mn4kyjpsJOLwR8BfB57/p6FpIMYD7Mq3h01vA4rUo=;
	b=wxvvZm42G6UIZrW2KB8JvBKE42UiU0GYctYV67Y7+OZLVBu6csNkRF0+MwkPOy8W/0cY
	 /uJHAlo/lIriyosBukURPhZb+Mn5F9S055y/b1d/pDUsrZcJMDb3cLbbI/GfD/QuiLL+l
	 ns2MbYN71l5xW7XO2lTDzSrCbJyWuGvaQbqLPyKElrboIHZqt+JvCtWrztmdLE939sx5+
	 8V7toAHkvLfSpHqh70WTrrp3t+8cev9lXnKvPxWFM6VloUJUIlKCDyXvcH4yfHt4sJz54
	 GNGitTlUHAN+5Y2ut/+xK8iIqcndxKSE90Krg/R/sMn2tV5UGuzB7yqSccbYZJ5CIUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=X53lRrhL;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12D606A31A;
	Sun,  8 Nov 2026 04:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F12D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=X53lRrhL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=X53lRrhLm8PW4os7GM2v8Pl9rXG+sLQqqFZJ3Sn6DqbEzM04s56siLNVfwI84jhyyxQRn6XLG3VBE
	 ujyJ3HyeufOuZXixZ5Nhl2QhGbgYhdrs9Er8wuukxcsp82RQuNmPtaCnSwx1ax9GDp3BdR9u5OTiDV
	 rsNWWJhYGkZqa/rg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56aeff59d368-b77d7;
	Sun, 08 Nov 2026 12:08:00 +0800 (CST)
X-RM-TRANSID:2ee56aeff59d368-b77d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeff59ec88-5c3c2;
	Sun, 08 Nov 2026 12:08:00 +0800 (CST)
X-RM-TRANSID:2ee36aeff59ec88-5c3c2
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, "Alexandru Tachici" <alexandru.tachici@analog.com>, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped
Date: Sun, 08 Nov 2026 12:06:00 +0800
Message-ID: <20261108-adin1110-sashiko-reply-1-yuehongwu@cmss.chinamobile.com>
In-Reply-To: <179406205322.994134.9029665354316624384@kernel.org>
References: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com> <179406205322.994134.9029665354316624384@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Sashiko,

Thanks, the finding is correct: adin1110_net_open() writes IMASK1 with an
absolute value that includes ADIN2111_RX_RDY_IRQ whenever the chip is an
ADIN2111, so opening either port re-enables the RX-ready interrupt of a
peer port that is still down and undoes the mask from adin1110_net_stop().

v4 keeps a stopped peer port masked: the peer's bit is only added to the
value written to IMASK1 when netif_running() is true for that port.  The
write stays absolute, so the bit is still enabled while the peer is
running, and netif_running() is __LINK_STATE_START, with ndo_open() and
ndo_stop() serialised by RTNL.  priv->irq_mask keeps its previous value
and meaning (the STATUS1 write-one-to-clear mask), so the clearing
behaviour is unchanged.  IMASK1 is written in exactly two places, both
under priv->lock.  Single-port ADIN1110 writes exactly the same values as
before.

On the FIFO question: I do not think it needs to be drained on stop.
While the port is down its RX-ready bit is masked, so it cannot raise an
interrupt, and whatever is left in its FIFO is drained by
adin1110_read_frames() when the port is opened again.  Draining in the
stop path would mean reading the port FIFO from a second context while
the peer may be running.

The patch only changes the mask programming; the pre-existing probe-time
mask state, the TX/SPI interrupt policy and the operstate gating in
adin1110_port_rx_ready() are untouched.

Testing: no ADIN1110 or ADIN2111 hardware; compile-tested with gcc, W=1,
CONFIG_ADIN1110=m and =y, full kernel builds.

Thanks,
Yuehong

pw-bot: cr



