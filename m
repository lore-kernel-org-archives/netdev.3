Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794327227;
	b=n0bEI2BKV/172hYmHf7VAet/DBeGvLMH3loZ9Dz1ibguWmIv0HOYN27yUhxB3KNUYrxP
	 X0YTt6NT/xQSPv/Lt90+ikw1IEvLN1c/DwLFY7TWso7RhP+L6V66BaIs2WTUeNMzpYfnP
	 4KlpNbStFX9kb0F047kPdaaVVHsqtJyMHMhxwNBPStm6oCHKNN0m38duh89IVb+CbqB0Q
	 7oVpEwgxUte51tA1UKesjghaTQ32N88c1VvB3l3vjdWW+tEX/1C6Cz+tOQ7KWI7sl04zm
	 VAeodHcbf54B+FmUGlaBtrFZXoTfNMXsG4bnjGr+QcFSNh7FtCr13bHBDMQjloLLG8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327227;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-Sent-From:
	 X-URL:X-Accept-Language:X-Accept-Content-Type;
	bh=lFL08heJopZr805d+tHWGDO+sHIhnW9x2eSKI6krkuc=;
	b=Lur/ks3BDapTHotLYBHl2IK192e7Swb7zbHSvRYW+7mf/3MP1sTgGhj2ltAZR4B1yzfi
	 feZpLNeFfsoXUr0wNnruAy2950pkFGXFev8Z7j+M3ab6T3XT+Wypptx8eKRpT6bFTYJIp
	 jBsk61yChvuhJf67pSq5wqtyVgo1HUkogKd8iv8eFZ1pBUbqEU04JOyE80FkhWvMN71zE
	 OY2rUkqZjDm98VKesS127/pFEeRqPx9LtNpjcK9AcpDygKduAwCdlq9wM4wFGoJx9pYtB
	 2qgpEt5QS4txh4jMJmiIVN6ESnPBmGMGAsm5GMqSSOiOzjCGzV17ESVOMaxm3m4l8Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Lg1kQnDK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87335606A31C;
	Tue, 10 Nov 2026 16:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87335606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Lg1kQnDK
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 58C18201F43;
	Tue, 10 Nov 2026 17:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794327219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFL08heJopZr805d+tHWGDO+sHIhnW9x2eSKI6krkuc=;
	b=Lg1kQnDKiBlvjcWBFMbu85dr5l5u6fFurA9o3sJXI9SAWON9h/OOne0FEmmCHdbryqbxmO
	jsgxsQdjVbe29xlBEtTpULQ6ksbqKuh2JpKJ08Pqez8vRV7/f49zbztLdhLERxurSAkXNP
	0hMk8JhzuIa8qOauKMCTAJPXUq5tLQJZ2C23W4T6pxncl03hKtDz4Z9Zjrd7hPOjQlvv56
	PS+ctYgG3U7GLTrxAFPpsJmRRLwFG/Xup+AJcmWumxnH1h38WShMbVfir5iBg38Si1+VRy
	ghPwKSxQ23EmJQsT9pKlwgG5oeQhlQ7waScSxVZlZJ1eD+YwToNLRzg5NsLJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794327219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFL08heJopZr805d+tHWGDO+sHIhnW9x2eSKI6krkuc=;
	b=Dt1ZXJeCmMJeQkI8G2Dgguhg5uzlcHH2wHlvlJIPxtccXZjn1EAMB407WlpTZlDzQ/WBoT
	5P7DKJTgS6fo3rxK5eIPH4ZcJd4f69gjpqudyc2LJIQxGppK6Yx9BzV5e/1C2vVfMFAXCF
	n+yRBVQvjtHZkOntNgLLiSviSm02oTQroXnpAWQR/NkQqc5khdqKly7at7U4kYMObUy88f
	QTrrxj6ck/B6GGWl8p8lU6/WBq6WpVLXpyFrsseHhOrMQx8fXk1ByWlE5LnBshphv9K1m/
	peamLPy3aaoMm542pHmhir+/QJl7ecdouQZLA4k1d/G9VD2bKUwwFlXJjruDfQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794327219; a=rsa-sha256;
	cv=none;
	b=gO1u6YbOidmUa2BIAMYAWcMyzESRTFVrR7SEyjKj8RqsYeXHpynQGTMxe7rQRNGsEncpIw
	if0lc2I+bXT2OMdc1HStb+jWqwpXLo0ZzZn+5lLWY+Dnp9N0cx1/T8U5gTdqz3UZDP3lDM
	9XzCFLqVBIoVKtmq/mhzyUL+sC2ulQDiqpJ5qbNHDbLXWM/hJHgJAJq/qdpbZnLyn0HtO+
	I0EJ7WylsYeurWvueKsKNqeJRe9IEYs5DyH5EqYwx5lrIyXhqptGHMY81BATJ6QbKLz9H/
	4xtwi40sKwFweveSIja+ANO60cpyo54D50F3IFbEhDNQYNwTE9Vedfg9OVn+XA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xQoTb-003WP0-0v;
	Tue, 10 Nov 2026 17:13:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xQoTb-0000000CVHQ-0iZS;
	Tue, 10 Nov 2026 17:13:39 +0100
Date: Tue, 10 Nov 2026 17:13:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 6/8] net: dsa: realtek: rtl8365mb: add QoS
 baseline and DCB default priority
Message-ID: <avNCswwpqAHHpAma@pengutronix.de>
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <20261002115850.962676-7-o.rempel@pengutronix.de>
 <CAD++jL=tuGRjbKqLhSLTobRC00UJkG0XhWxguxRRwDOTQLHd2w@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=tuGRjbKqLhSLTobRC00UJkG0XhWxguxRRwDOTQLHd2w@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Linus,

On Tue, Oct 06, 2026 at 01:18:11AM +0200, Linus Walleij wrote:
> Hi Oleksij,
> 
> thanks for your patch!
> 
> As mentioned I think the main logic of this DCB stuff needs to go into
> common code.
> 
> Whether to use rtl83xx.c or create a new file rtl83xx-dcb.c with just this
> QoS DCB stuff is up to you.
> 
> Some detailed comments:
> 
> On Fri, Oct 2, 2026 at 1:58 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > +#define RTL8365MB_QOS_QMAP_IDX(_nq)                    ((_nq) & 0x7)
> > +
> > +/* Internal priority -> queue-id map. Eight tables (one per queue count),
> > + * indexed [table][prio]; four priorities per register, 3-bit qid. An N-queue
> > + * configuration uses table N-1 (1Q is table 0 at 0x0904, 8Q is table 7).
> > + */
> > +#define RTL8365MB_QOS_PRI_TO_QID_TABLE(_nq)            ((_nq) - 1)
> > +#define RTL8365MB_QOS_PRI_TO_QID_REG(_t, _pri) \
> > +       (0x0904 + ((_t) << 1) + ((_pri) >> 2))
> 
> (...)
> 
> > +static int rtl8365mb_qos_setup_queues(struct realtek_priv *priv,
> > +                                     unsigned int nq)
> > +{
> > +       int table = RTL8365MB_QOS_PRI_TO_QID_TABLE(nq);
> 
> Prio to qid table is nq-1
> 
> > +       struct dsa_switch *ds = &priv->ds;
> > +       struct dsa_port *dp;
> > +       int tt, ret;
> > +
> > +       dsa_switch_for_each_port(dp, ds) {
> > +               u32 reg = RTL8365MB_QOS_PORT_QUEUE_NUMBER_REG(dp->index);
> > +               int off = RTL8365MB_QOS_PORT_QUEUE_NUMBER_OFFSET(dp->index);
> > +
> > +               ret = rtl8365mb_set_field(priv, reg,
> > +                                         rtl8365mb_qos_sel_field_mask(off),
> > +                                         RTL8365MB_QOS_QMAP_IDX(nq));
> 
> This sets qos port queue number to RTL8365MB_QOS_QMAP_IDX(nq)
> which is nq & 7.
> 
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       for (tt = 0; tt < IEEE8021Q_TT_MAX; tt++) {
> > +               u32 reg = RTL8365MB_QOS_PRI_TO_QID_REG(table, tt);
> 
> This finds the reg for table nq-1
> 
> > +               int off = RTL8365MB_QOS_PRI_TO_QID_OFFSET(tt);
> > +               int tc = ieee8021q_tt_to_tc(tt, nq);
> > +
> > +               if (tc < 0)
> > +                       return tc;
> > +
> > +               /* QID field holds the traffic class */
> > +               ret = rtl8365mb_set_field(priv, reg,
> > +                                         rtl8365mb_qos_sel_field_mask(off), tc);
> > +               if (ret)
> > +                       return ret;
> > +       }
> 
> And sets it.
> 
> In a code dump I have for RTL8370 writes the same index into both registers,
> so something like:
> 
> {
>    int qmapidx = RTL8365MB_QOS_QMAP_IDX(nq);
> 
>     ret = rtl8365mb_set_field(priv, reg,
>      rtl8365mb_qos_sel_field_mask(off),
>      qmapidx);
> 
> (...)
> 
>     for (tt = 0; tt < IEEE8021Q_TT_MAX; tt++) {
>       u32 reg = RTL8365MB_QOS_PRI_TO_QID_REG(qmapidx, tt);
>       int off = RTL8365MB_QOS_PRI_TO_QID_OFFSET(tt);
>       int tc = ieee8021q_tt_to_tc(tt, nq);
> (...)
> 
> So we compute index once and use it both for port selection and
> table programming.
> 
> Can you check this in the RTL8365MB manual, this old RTL8370 code
> could be wrong but it's also the way RTL8366RB does things.

Hm... good question. After some investigation, I think the register
naming is misleading, and maybe the RTL8370 code too.

The switch has a pool of 8 prio-to-qid tables, and the 3-bit port
field is an index into it, not a queue count: field value v selects
table v - 1, and 0 selects table 7. I tested all field values on HW
(RTL8365MB-VC). The field does not limit the queues either: with field
value 1 the port uses whatever queues table 0 holds.

See e.g.:
https://github.com/openwrt/openwrt/blob/c46ccb69d17e584479df849a107423175a143c83/target/linux/mediatek/files-5.10/drivers/net/phy/rtk/rtl8367c/qos.c#L45-L92

In v2 I'll treat the field as a table index.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
