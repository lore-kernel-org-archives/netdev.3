Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1E2D5C7A
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839833; cv=none; b=lmdf7JXxoX7rtPNYPKwIt03fPdAdSElxxhuTxJ1pkgc/prML4jt9IlFzYWk/qO5nQOpANM/55MtGKQlyl5E4Y3mKQPs6MG8xWQ78v1x3reKGjdfB7OLMDVKLCUIQUPS1TZCBaazVQK4q4CyRI/+vDPFxVgQwxki0S0xvIx9TJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839833; c=relaxed/simple;
	bh=pBom+DbWYpkuf92Z0I9is2Xs5KSaQUWXc8R1/sLAz3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpofOCHFw0CCIZp96Z6T8VwRVeYOG9/pICHLUxH6bHicOqisOOmxOBSS8MJQxzYeXo+gdM37UzxNjx2jrJzZOLc1M9ox7Q/8GwfGd8us8O+OY9XcE9NxYJv3//+xMlDGR4RVw3+vwExPnDp9R7JMNofx0PxBPVXEzZEgd4jL5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n+uK/lir; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmmS70K7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n+uK/lir";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmmS70K7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJMn1o080169
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N2HI8C7LvVnjvprSiL/yD01X
	dxo6jYD3Wpi+RAikd0o=; b=n+uK/lirCF/sKTXGK2l96GTBMbfcuCdYni6ExXX6
	ISY4IxfhnAhVVWvIaL7uPHvVdqPXAWJ2JvEJdCsAq/qTMOTbKotkhDIUTLh7ZBG1
	oE1RFEpc4ioVEWzFwGCsrUk+egdrxwRkmiIePutDbjE5j2CDw6FDfNH/5jQNQkbv
	mcG/UYBTwfrdKt/HZ4hNMgfQ2RfAWGWI77wE2/7rZ1pQ+IZIwteyFzfm5jdRSaHz
	y25xs3MwZPwjxyDGvny3GeQf/cEuebFVtCiT9rTLCXco6sR9noLi2gi0kXDFnxaa
	R5hkBGFDHpubVZSZPNCR8igjflYd2gx04QoDyAESiSnlOQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3kfnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:17:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91256a7b7b3so38132386d6.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791839830; x=1792444630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N2HI8C7LvVnjvprSiL/yD01Xdxo6jYD3Wpi+RAikd0o=;
        b=WmmS70K7K/hbtZCXCjmYtBYUzeHT3KaKulpynAKtVSwDwgxYYUBSgs8k6anmXoiteO
         S+raK1frMLBAjX2eL7zxMOient+LLEKYEQr64aYcg9GfT272CFccXqJK8s92ft4Ah4so
         DWL5E6Gx1nyyFv2MHTDdpI9A/vtR1+KVoQbM5n+eD0HjwE7oGcysC2ADD0UR5Yp4d7Fh
         /KKHGkGjIkh2aVCwxYanS+uDf6gVDnSLnHRBLAUPj1gT7CBzwLq8oKp3H5xifWSwqfBk
         hNqHHLaAwBnxEqQbFpIIN1y1QDnoW5KrPMXgMJZtvqwnyF/ck53isHHDYQXQhUSdflOW
         bi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791839830; x=1792444630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2HI8C7LvVnjvprSiL/yD01Xdxo6jYD3Wpi+RAikd0o=;
        b=iQPdusRB/0hWUI4POcCqXB9KK/SJfSPWEp9VxB16SSy6ctEyxXlU9hxjRu9ODHmKDJ
         14ROxx1WJ+jripD9Vn/yCW6NhJMgjL2hFUH//MU51xRx0jikXIwrbxuc/Pp69sbWDQb+
         CkMSl7s8CyHDJXcs+n66J/Je0evV9NSVk2TlwrqL3Sw/1ZCkRJF0UVaWzvvrKQRibmfe
         7wvIYqlyK/k8kyIsJgXTKPLfeCWefk5xGEBmERzrr0TyPfiSJB1OqlwuV9ncu2YeQYKW
         pcXtH7gV2dsssRTCLe8ZwixDhtgwKY/n4y7ZdoMyWk49Pjp8T8LiWDDX6gFgmvn7kznq
         XYKA==
X-Forwarded-Encrypted: i=1; AKwUvByNohpt1uD+a0GCFD2eQNLHbzXGi7vmwgcwxWEz38meSPgJH+UqFwn5GdPSyzxeKV5SWTmO5js=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOV3SErMOgsJhjspSmK+VSnz0kLwmFWM7m43TDfYchl1IKQNGW
	oNARf6Oyype6RSQWaJOtEgppmktNGNP6wF8KC7YzFMMFMX0lMdvHLegOvYnm+pRzG4E7vn46OyG
	J2ajAYAw9vknlAW60VvOATs4Y/pBrh4uDeAHoMkXI6YbCLM1BblfcW0JT2Yo=
X-Gm-Gg: AYBFou223zQ/7zHSvmIMWer2qobxUt/xcKu430m/PVj+DdtE74ekxuPH5z1DZPqUW8K
	Y133zvuGQx7HNpF4LyxGXyZkPae7W1vhqlX/IGd1IqX9tAnUZE61o5ejjjn1ijrJ8WLuRR2tvnS
	F7xgRnhBapbv3FYYr7hB2tixwh+IgJKevC44xHh8w+TJpvh5akH5essb+SGEXxfqJT26A2wh/Nc
	L99MNf0aa1XhupRpq2Es9rpGxStCi62seLgsVUGLogyI9vwlm3If4x39TYlPBSfv7tyrjUlnRNY
	z8UZCBGVhWP/e85hQ5lBZH+yASfGObFPb9xbA+I1LZq6QuYSqUWk9jowqNAskbgSVnuserb9gdI
	XJmvPz6I3Usc6vw==
X-Received: by 2002:a05:620a:bcb:b0:93c:82bc:146c with SMTP id af79cd13be357-93ebd259af4mr1792544885a.37.1791839830070;
        Mon, 12 Oct 2026 14:17:10 -0700 (PDT)
X-Received: by 2002:a05:620a:bcb:b0:93c:82bc:146c with SMTP id af79cd13be357-93ebd259af4mr1792539685a.37.1791839829438;
        Mon, 12 Oct 2026 14:17:09 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beabbd0sm364159745e9.12.2026.10.12.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:17:08 -0700 (PDT)
Date: Mon, 12 Oct 2026 23:17:07 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Thompson <daniel@riscstar.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: add tc mqprio hw queue
 priority offload
Message-ID: <as1OU7AbxQKi2zWC@lore-desk>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <20261006-stmmac-mqprio-prio-offload-v5-3-d7da93419784@oss.qualcomm.com>
 <ase3UrUehtLY6b_5@aspen.lan>
 <97bc33f6-1566-4449-9343-9e3463d5b8bf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iPLAchsNbX0Ln+SK"
Content-Disposition: inline
In-Reply-To: <97bc33f6-1566-4449-9343-9e3463d5b8bf@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NCBTYWx0ZWRfX5HKvuLGfKvL0
 rEE0IWaT9agK/E1coFQ/hq2P198Sng4h2Ur+5/qd8pPUW/oYdlrNC1Q+aaRx3fdqACtDGtSr4hM
 vbw7DqI1+r8TDxDgJFZzgQB8k16L0atg8kvrOux3iu04UP5s3FHYQ4cXENlojqNxN6s22t44M2o
 XSPcCqH/nnfREsBVVAUt/M9luc3ir2OxOjkynrL07FhSXPwopO0PQEQaiPp+0bipaZ82UmoPakS
 KiQG7knGl2upsrbFBLU4COt5E5ciOu7p3+xtcZupr1QbeBKi6twYXEwHhxtR0IAbn3qF/hMok2O
 FfC9OQU1qMm6YCg2hhzkBUXYuH/fTCY/XsHhumB6DYDgjeatwJu5ubP7b9JBlk5cta+i+m7vlJR
 cUWQua62ROTFkov7GWkavFvnHs6jZM1/gQ+PqrrCveWeBzI7+I/K25o+R+ymnl5AK2EQk621x0d
 YBIOqQQTl2EL9OVBcVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NCBTYWx0ZWRfX9vc64XI8H5He
 mk8K3dZEeuEA68reBsTdLtSFLP3Iq+BU8mbHXrxcKNFCNhjv88jCJdpgfVm4UBPCes1m3B0g54S
 neQy01bLKbrMkZHwSUK6t7SRoTZAA8A=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6acd4e57 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Gl1wkL_h6YAIogX5mJgA:9 a=CjuIK1q_8ugA:10
 a=QEm2v4ACax8AGLlfgY8A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: iQMpgmo9w_iq6J_7Atfz2IJDA1AxqbQ0
X-Proofpoint-GUID: iQMpgmo9w_iq6J_7Atfz2IJDA1AxqbQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120084

--iPLAchsNbX0Ln+SK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/8/26 17:31, Daniel Thompson wrote:
> > On Tue, Oct 06, 2026 at 12:46:27PM +0200, Lorenzo Bianconi wrote:
> > > Implement the offload of the tc mqprio hw queue priority in the stmmac
> > > driver. When the mqprio qdisc is configured in channel mode, the MTL =
TX
> > > scheduler is switched to strict priority, and the PSTQX/PSTC priority
> > > bitmask of each TX queue is programmed from the set of frame prioriti=
es
> > > mapped to the owning traffic class (qopt->prio_tc_map).
> > >=20
> > > The channel mode offload requires the DCB hw feature and a 1:1 TC to =
TX
> > > queue mapping, with a single queue per TC. Configurations with AVB qu=
eues
> > > are rejected, since forcing strict priority conflicts with the CBS
> > > algorithm. The CBS offload is refused while the strict-priority sched=
uler
> > > is active, and so is a channel count change that would enable an AVB
> > > queue.
> >=20
> > I don't think these CBS offload checks are necessary. It's quite reason=
able
> > to mix strict priority on low priority queues with CBS on higher
> > priority queues.
> >=20
> > In fact on the hardware I have (TC956x) the lower priority queues don't
> > implement CBS so mixing AVB and DCB queuing (whether SP or ETS) isn't
> > just reasonable, it's pretty much unavoidable when using CBS!
> >=20
> > As a concrete example of combining mqprio and CBS, the following works =
well on
> > TC956x (when I tested an older version of your patch):
> >=20
> > --- cut here ---
> > tc qdisc replace dev eth0 handle 100 parent root mqprio num_tc 4 \
> >      map  0  0  0  0  0  1  2  3  0  0  0  0  0  0  0  0 \
> >      queues 1@0 1@1 1@2 1@3 mode channel hw 1
> >=20
> > # No CBS for TxQ1 means we can't offload this (h/ware stays in SP mode)
> > tc qdisc replace dev eth0 parent 100:2 handle 102: cbs \
> >      idleslope 800000 sendslope -1700000 hicredit 494 locredit -1049 \
> >      offload 0
> >=20
> > tc qdisc replace dev eth0 parent 100:3 handle 103: cbs \
> >      idleslope 400000 sendslope -2100000 hicredit 247 locredit -1296 \
> >      offload 1
> >=20
> > tc qdisc replace dev eth0 parent 100:4 handle 104: cbs \
> >      idleslope 200000 sendslope -2300000 hicredit 124 locredit -1419 \
> >      offload 1
> > --- cut here ---
> Given your later tested-by, I assume you are looking for future possible
> improvement?
>=20
> Also it's not clear which revision you are referring to: AFAICS this
> patch is (attempting to) refusing CBS + SP since v1?!?

Hi Paolo,

I fixed the issue reported by Daniel in [0]

Regards,
Lorenzo

[0] https://lore.kernel.org/netdev/20261012-stmmac-mqprio-cbs-combo-v1-1-83=
1e323eb4ef@oss.qualcomm.com/T/#u

>=20
> /P
>=20

--iPLAchsNbX0Ln+SK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas1OUwAKCRA6cBh0uS2t
rDrnAQDZDj5JyQxIjvG4DZeX1nnGMtdTq5WaVjVLoFhVH48/oAD/dldb+6SuuQzW
9YcrToM/mhrG6pcgFkcaqq/LD5RQ3AU=
=BvcV
-----END PGP SIGNATURE-----

--iPLAchsNbX0Ln+SK--
