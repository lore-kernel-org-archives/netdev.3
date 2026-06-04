Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18073E0C41;
	Thu,  4 Jun 2026 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562054; cv=none; b=q57NdBLthtmMn3GFnFc9NVB2luUXAakWJHjGAnEk29krDQcQi92EWoxKrymRizmjkkVxFVBk9JRoEeDVq8N2IX2WxMbYOnNfbAF5bjngm/N/uANMl6+CUOdJdLBXvKrDqK1hn6dR8n7LrESGYjJ9AHefPUT8CH+KyzwCAD6cSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562054; c=relaxed/simple;
	bh=JOr75AoxwJucrpl0nXzG0vdPvIxorGaN31u7MXw7hCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBdbxa7B7GkXfppQvitTYyec7p1J7YlyRKwgDZ8oVCbvA/6XkB++6oB7vzkEB6S3OboSQm3EDDOO5H3G8ru/FKCdi8gFK11itrVAFENMj2xqg5fl2BjdblwrbbYGcVqNi6V5fLjSZK+K2s5TVsn+2mOeKcEhT2vl/zw81AZgDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NxAVyHRH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NxAVyHRH"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6548XpX92227533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780562031; bh=rpbBdp8xvUVC/5mW9h4QL8AKFynQWjTURmS1vfHtBD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NxAVyHRH8NWIzayd+nq3veWHGrAjsOZ18cLrXrM++hGCBZfwTOQj/LEJv+pcLBb9y
	 UgMXFBc8P+0kGItWWTghcbgFmo0n/wCMB4s159wIcGY6t3s3T/4bssiEcB4QhwpYmQ
	 9qmG2B+qq5yGCyyYS1nBmI/s8aravVUj9rOPEwjg3tKsTaPzddWCV7EhnoAcMiSC59
	 3b5oXkU33yvc6DRoE7EfySZI8PnYak5b0HG3cNiWZXgtcOkoJYa6LyslWr0sN0OBY3
	 NJw/lTcyCgOBdttfrl+l8bFYV6foheJrIeStyMPFJOfGNNvJ/Na5iOByFj1/W1qr8P
	 5e+rNiFRdNmkQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6548XpX92227533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 16:33:51 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 16:33:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 16:33:51 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Thu, 4 Jun 2026 16:33:51 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Thread-Topic: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Thread-Index: AQHc8Y8ydZ9ThmFs6kuJK5zylfdiXbYpKbAAgATsPhA=
Date: Thu, 4 Jun 2026 08:33:51 +0000
Message-ID: <447c46ad1f654222a8daa423149f0b89@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
 <5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
In-Reply-To: <5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:
> > The hardware parser incorrectly interprets 319/320 in a short IP
> > fragmented UDP packet payload as standard PTP destination ports and
> > treats the fragment as a PTP packet for further parsing.
> >
> > If the transport data is smaller than RTASE_MIN_PAD_LEN, the remaining
> > data is insufficient for further parsing and causes hardware TX hang.
>=20
> Where does RTASE_SHORT_PKT_THRESH come into this?
>=20
> RTASE_MIN_PAD_LEN is 47, so matches all packets which need padding up to
> 60 bytes, plus FCS. There are not many such packets, so why both this all=
 the
> complexity and just pad all small packets? Do you have any performance
> numbers which show the complexity is worth it?
>=20
> > Pad these packets so the transport data reaches RTASE_MIN_PAD_LEN
> > before transmitting to avoid triggering the hardware issue.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Is this a Fix? Please add a Fixes: tag. And base it on net.
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

Hi Andrew,
=20
RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding
threshold. It is the minimum transport-data length required by
the hardware parser after the packet is incorrectly detected as
a PTP packet.
=20
Therefore, this workaround needs to pad the packets which can
trigger the hardware issue, rather than just padding packets to
the Ethernet minimum frame size.
=20
I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I
will remove it in the next revision.
=20
Yes, this is a fix. I will add a Fixes tag and repost it
against the net tree.
=20
Thanks,
Justin
