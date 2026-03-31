Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583F283FD4;
	Tue, 31 Mar 2026 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936027; cv=none; b=JmMwCRcJk2iZzT3zSKXLWdOUfRvv8VG/2odbaWq5BlQz4Xlyinm37cC5uqwO+G8r6c4ulSPbABOt0FZkOXkBNogYFUDOP3GwHMUX/nNaf6OSdHiiAIycgSpFCNmUM89vpmch8wnLtHYUTVwwkyv1M8jqrmMZp0ATWyLTGpVEp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936027; c=relaxed/simple;
	bh=Ee6opNaryfGHiIa8jXCXhjOuSR5f97VK7ftydvAf6ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0XMQa7xfuTQIH6gIFMuTuUhm6v9UTH4COUG6se33WN4rSP2cG2MmNb/7K124fP7uTeBos+XsdRoj58NmCoKXDgQQi45uEqDAHsc3938mhDz3w+HfWVBxfSjU99mUF8GaRlK0YmY7CODZ8gfHEewJFct40KvaZTot0sQp13mX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=D1277GhP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="D1277GhP"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62V5kaeH72628760, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774935996; bh=pEDw9somGOJu6/8v9wZ9i20CKMIqTMMH2Tox4uOSKVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=D1277GhP3bGnta5vEOxZqRzNRtRhV7BdPBZ4tNmxYX1DjrQRYGSQkG/Mcrloc5sse
	 VZuzWybIH70FLgIyknxyhxROAMDBZ2wlPGuJ22WsqxABSyGNgv8HREIS6uuEprQuL0
	 mh6ewYc2ivj7L8ZNDis0vCBfxCwFV5XkJnnf02IAQ/xC9SlBn1xWasOYeOOWUyfwar
	 Fv6lNK2tqNNtnf+PqxdhY/TssOman4qG/vK0YqCX92QS5pe6SVOpJ1dDmmTWebvfqz
	 7rSMej6m2GKp10pdF9Sv/fEb1kO4X/VNBnx/Lx0/d57OQGvcAgUBpHDzLeNwWmtY/Z
	 qd2zv9QU/to7g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62V5kaeH72628760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 13:46:36 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 13:46:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 31 Mar 2026 13:46:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::46e9:fab9:b2cf:c99b%10]) with mapi id
 15.02.1748.010; Tue, 31 Mar 2026 13:46:32 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Topic: [PATCH net-next v4 3/3] r8152: add helper functions for PHY OCP
 registers
Thread-Index: AQHcvPOyAxvCbLugj0GPCTeX7npeYLXHZLAAgACjrzA=
Date: Tue, 31 Mar 2026 05:45:58 +0000
Message-ID: <0fb2fd8f26334b578c299ee71958202c@realtek.com>
References: <20260326073925.32976-456-nic_swsd@realtek.com>
 <20260331020156.3518006-2-kuba@kernel.org>
In-Reply-To: <20260331020156.3518006-2-kuba@kernel.org>
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

On 31/03/26 10:02 am, Jakub Kicinski wrote:
>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > 32a4e8d423115..8747c55e0a484 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> [ ... ]
> > +static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear,
> > +u16 set) {
> > +     u16 data;
> > +
> > +     data =3D sram_read(tp, addr);
> > +     data =3D (data & ~clear) | set;
> > +     ocp_reg_write(tp, OCP_SRAM_DATA, data);
>=20
> AI flags:
>=20
>   Does writing directly to OCP_SRAM_DATA here actually write to the
> intended
>   address?
Yes, this actually writes to the intended address.

>=20
>   Because hardware indirect SRAM access ports typically auto-increment th=
eir
>   internal address pointer upon access, the sram_read() call will advance=
 the
>   pointer. By writing directly to OCP_SRAM_DATA instead of using
>   sram_write(tp, addr, data) to re-establish the address, the updated val=
ue
>   would be written to the next address (addr + 1) rather than the origina=
l addr.
>=20
>   Could this corrupt the PHY configuration memory across the initializati=
on
> paths
>   that now use sram_clr_bits() and sram_set_bits()?
>=20
> Can you confirm if this is legit? Not sure whether this device / register
> auto-increments or where AI got it from.
The address pointer, OCP_SRAM_ADDR, is not auto-incremented after sram_read=
(tp, addr).
However, the address pointer is incremented automatically after ocp_reg_wri=
te(tp, OCP_SRAM_DATA, data).

Best Regards,
Chih-Kai
