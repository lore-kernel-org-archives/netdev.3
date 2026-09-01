Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF537245012;
	Tue,  1 Sep 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306911; cv=none; b=eVzdYhhEfNprfcaIUatTRRxv1K+7pYD5LwhFoAoFbJfEa5O4RdYdBGewZyLsrn3SeaPDwxa5tEHzYNE60TC9D4NTg+0U9UyhEPvjQqckqnKv76DmBZN+nzIzp/PsNCSZhhI+z/c6E43yXmEO687YYv8+fugV5aoE2TgL0xAzTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306911; c=relaxed/simple;
	bh=ctItrf/cfcjXOq0Ai16mP2Pl6ePJ26E5prZIjEr0Sss=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=kezU/3p+zDTAOmkDFfxdvGHea6/urZOEDaiO0KNZUpCuTlgPKL0z7SYwWuHLEh0pOsnhazYo3whULrUYk/+B44MZYLqiTI9jqyGkqdMRzuMI57BINuzVMob9RndTAwRSuSNI+Gfte2khvvskVapVND/z62dleEn6zNEudx+l1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Q0FwJKoO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXZWoSa8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Q0FwJKoO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXZWoSa8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C02357A00BD;
	Tue,  1 Sep 2026 19:55:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 01 Sep 2026 19:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1788306908; x=1788393308; bh=9Y2/hLnEimnfLdBSR04KDsBy2hua8nue
	O1JMg1a2Evo=; b=Q0FwJKoO7QJnx6RsMTriFxFP2u6XWYYAw8sjRZYnAJ+cXs26
	Ryyod9yaE3bpRNEjSyVzAxDDhrN3Kxhp92SKMNcALZOtoibmMtyoZUQVWclAUENz
	HtSipC9onAHatAlDoaH4btclb0DsAiGQcnhgiS4ah71ZsCbCIhRH5RgmupFdXp0E
	vSRwTbDIjPYLoHEGi1v5jyzE0tpxwH8z2clhMFA6pgn5DxFNRMqRdfBS/Top8IrH
	mzlITC7YalJ5LQAST7IuOiVWHKU2kR1LZKe9ECuE8S2XoN10rOm0D2Wgctd0+1+q
	vnw/DdhTHTUnyqGFWmpPlO/ANyG1hYAUqQEApA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788306908; x=
	1788393308; bh=9Y2/hLnEimnfLdBSR04KDsBy2hua8nueO1JMg1a2Evo=; b=B
	XZWoSa8RQBb7Qbmv66eZJ4L1fPsX++GdEcgM7PQIjX8WkXNm0j8NMEbYtHPCoZDW
	2V8+FWyK3cenoZK1AMsttAGqbgavgkDKNuCpvGNWd+DqUqwC89ox1Zv1U1/OkTfU
	dO5g7xGFPFUJr8PPutZu7Q9ik45O9NuRPTNKoJX5fAcMEwY8ju2s30Ts9KbYa+wL
	7b04GzcOnPx6QKYFUeVNGiyK5EqmiLOmUBGP8B2aLLawLinfLB77ibocMhuBD1YO
	X1wZutmwNHSoHV0GT4wQp2TxqHgV/GM6rk70HkUlBYOVPNUjxzmco4vbRkkbqZM6
	eat8NR2QP/HcQZ6MfolHQ==
X-ME-Sender: <xms:3GWXahZFwOkzDUCAFF1vYM5rULB_RS_-MihwK0YJ5WyFT35wJ57VDA>
    <xme:3GWXamq0r2uqf_D6Ivu0fyLsXVXJx_q_y4AGaf3wad-F_DSmM-7S-MgC79gtWjVDJ
    z09uqRzlZ109tobDIttNYy6JrTkIpRPEq7YwGSMqN2TBKrjc725-yLM>
X-ME-Received: <xmr:3GWXatRQ7erqtXCgChQcJQxdiLTIbauoi6kl7SQSPZOWpFDH26rJuDpRiZw43ZMZZH_PKA>
X-ME-Proxy-Cause: dmFkZTEF5G9dHS2y8j69yQlY/Cc2henMgbR6Ho4Oa11gnKiFvRfOsHVO14a26394OoW67b
    Sp+hFqKDYv3nVowJFwoAv7Q9YoKSh/BgxAMYCjsXHPYS7b3n8ixaj+VIKjkNP2K5YhcniK
    0A4iVJxa3qSf/NJaEyQS3oGGdXp43Sk6uAdVAR/LKxk3BGkhx3q4hf0efX3rJH1SQmk6/e
    nSZ/GrfrB+fG0+G4JDQ5GYc/oSj7C4rdDqh8MUs87MiznBXZyY8bMdm1UJbnkxZUwUte9y
    o8u6JtRXqALg0wal14QKGz4J0IXZIJ6QeKTG/KEvFh1sn4GaNHr+P+MaJSZJvXvohH/ZKv
    ocEc85J2e9b40KtvWQi49C1DQCCJ8qIJhaaGs1vcfTx9Gzrym5cEGaNhajrGIyFz5sZI6L
    vqn6sM3uJ7ewt894SEvv7W50hX7+BXS7rgIR4CioJVD9XHRwoykw5CHlJ608Pxl/wfPaV6
    Q7wS+5nRAFczMXbXSBYd7f8I2s4pVePADA6yEx7NqUAsxSmslLHHXRt7Ori7g0r8R1R3p2
    /58mIjr2GPYhbldHOMXwTFKiI+BoJB4ygNDjXpNGkAXqREgeDiC9oLjZITcHdYz+p7Jfxz
    OJQx9tEQUVsPnp8P98ZqWt0q9jNadWPGynYlbcCMcTQHIRedyvzg+5A4xXWQ
X-ME-Proxy: <xmx:3GWXaiq1_o8JxoNdEtjZSNzBnbN6IyAq0qRNgk7z65nXjZ1yt77JBQ>
    <xmx:3GWXav35uWRx28a4D3n9PG5OCbQGgfW52I1PXJcxcDJShcwXCsjuUw>
    <xmx:3GWXap4pNpK8xmxMR11coXz2O6-jBvXcAX-RRmBt85-j3a4do8NZjg>
    <xmx:3GWXarTlbBSVyrdsqGh2yVWwSGxwpHsLDxYe8vxXjJDEGb-qMHyL-A>
    <xmx:3GWXamQjj7R3zKNbslTfvqJ0oD_wleelkrOR2jmrAde4G7zWD4ReUziR>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 19:55:08 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id EF5329FC75; Tue,  1 Sep 2026 16:55:06 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id EE6559FC41;
	Tue,  1 Sep 2026 16:55:06 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Eric Dumazet <edumazet@google.com>
cc: Jiale Yao <yaojiale02@163.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Alexander Aring <alex.aring@gmail.com>,
    Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bonding: reject IEEE 802.15.4 devices in bond_enslave
In-reply-to: <CANn89iJthuCa-BZD9vik7LUw1to8aqTFKRgQfmOGozGvMeLanw@mail.gmail.com>
References: <20260831140710.469576-1-yaojiale02@163.com> <CANn89iJthuCa-BZD9vik7LUw1to8aqTFKRgQfmOGozGvMeLanw@mail.gmail.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Mon, 31 Aug 2026 16:20:58 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:55:06 -0700
Message-ID: <588055.1788306906@famine>

Eric Dumazet <edumazet@google.com> wrote:

>On Mon, Aug 31, 2026 at 4:07=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wro=
te:
>>
>> Bonding already refuses CAN devices because their protocol-specific state
>> is incompatible with the bonding model. IEEE 802.15.4 devices have the
>> same constraint: they keep protocol-specific state in
>> dev->ieee802154_ptr and do not use Ethernet link-layer semantics.
>>
>> Extend the existing check to reject ARPHRD_IEEE802154 and
>> ARPHRD_IEEE802154_MONITOR devices before bonding changes their link-layer
>> settings.
>>
>> Link: https://lore.kernel.org/netdev/aohMHTTH4VqqgZA7@fedora/
>> Link: https://lore.kernel.org/netdev/6001bd73-ef68-4820-8371-a22775fb820=
a@hartkopp.net/
>> Fixes: d5ae67bacd96 ("ieee802154: rework interface registration")
>> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Jiale Yao <yaojiale02@163.com>
>> ---
>>  drivers/net/bonding/bond_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
>> index 522eab060f9e..c716336c5172 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1894,9 +1894,11 @@ int bond_enslave(struct net_device *bond_dev, str=
uct net_device *slave_dev,
>>         struct sockaddr_storage ss;
>>         int res =3D 0, i;
>>
>> -       if (slave_dev->type =3D=3D ARPHRD_CAN) {
>> +       if (slave_dev->type =3D=3D ARPHRD_CAN ||
>> +           slave_dev->type =3D=3D ARPHRD_IEEE802154 ||
>> +           slave_dev->type =3D=3D ARPHRD_IEEE802154_MONITOR) {
>>                 BOND_NL_ERR(bond_dev, extack,
>> -                           "CAN devices cannot be enslaved");
>> +                           "CAN and IEEE 802.15.4 devices cannot be ens=
laved");
>>                 return -EPERM;
>>         }
>
>What about ARPHRD_6LOWPAN ?
>
>I think it is due time to use an allowlist in bonding (and team) to
>stop applying bandaids.
>
>Plan of action:
>
>1) Add:
>
>static inline bool netdev_type_is_lag_compatible(unsigned short type)
>{
>      return type =3D=3D ARPHRD_ETHER || type =3D=3D ARPHRD_INFINIBAND;
>}
>
>2) And use it in bond_enslave() and team_port_add()

	Agreed, although the list might need to be more than just ETHER
and INFINIBAND.  I recall that folks in the past have bonded ethernet
with wifi; does wifi show up as ARPHRD_ETHER or ARPHRD_IEEE80211?  A
quick grep suggests that most of them are ETHER, but not all.

	Dummy interfaces are used a lot in the tests, but those should
be ETHER.

	-J

>Thanks.
>
>pw-bot: cr

---
	-Jay Vosburgh, jv@jvosburgh.net

