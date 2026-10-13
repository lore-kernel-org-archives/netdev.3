Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6455295B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905627; cv=none; b=eXVP4r4BdOedrl9XKAXhvT5nE/ZJWiM7ziIN+tKoAImrUMQTJYD4EdSTyixqNXCfIBT4ipGZ394IDghTnhVpp5Yzewc6D/vxluFRg5uw3JAqrYvzwKtzYEEO5phrQCkoDgy1H6J/jT6QlQUrb9FYyVWFvQpKX5PxPkZVBMWKZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905627; c=relaxed/simple;
	bh=hvR4gU+aJ5sFh8b8hiP8dD5N3LG+R73Tho451ruiOm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khE+ajU4p1vUvHun887yRkugkSHkjJ2D605Ov4nmNwyB+PfH1ZUxknPP1kZDbb/qexVaJL7faCRFViUECn/hxC3vooEQvYC8LJy2vw/Kk3iHWuhKkg323TPOY2kzVXNePatpK0t08ctvzuh2AK4CtRwwRamn6kR7d/Bw6hg6/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J2h8XG1w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SkHCfuhA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2h8XG1w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkHCfuhA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE4QZP2571150
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HGeBD3r78PRe46uI+kLHVwNa
	muj8NRza/V5oim/8S1s=; b=J2h8XG1wsM86CpohKwAVsMYjQidPsCgLchU5wXx8
	NpEJHWAUg4xi+UmBNYdkc6TKf7j6BobzE47cQ/gdVXUuo+15j8kMGjhCeU9Vi+RL
	ajEGJqmbP8s/EqvZbU/XqzgMSrXLbN1EgicPh0xdiMlmVnXAZjo9gHJ5Fan19llx
	yr/Tz67OaktrxJszSPhUeYt5/qjEvjPLG7G4Yy8BpxYQLaL8Y9QsvSEZnMmH9TuN
	nXCeCE4QxTtBFb6p+w0Zik3fCFZC8W7a+G8/cUHvzKom7ERk52fdIEhOtAy96X6F
	Qo8TTT1tDONigKD3kIDhlDJZu73HdbpnS7tOzx5TDeccBw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hcbqnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:33:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb7f9bb86so619322585a.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791905624; x=1792510424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGeBD3r78PRe46uI+kLHVwNamuj8NRza/V5oim/8S1s=;
        b=SkHCfuhAxIfmDSaUyuFTKVSwurFgQ/cZ9OJWDPURlmiF7iAp/C9cMO4rCVH9kuECfq
         wBL8e90DjqAK474AzmV1RQ3ixwhbFQ1F+xByXQ7jbToIBPCRyw8ifGOO/dFnEMY07uSb
         i8QOPFy790IOm5agk5BfI67XJaszkRWmH/Oh9T053j42R8ZIvrHijX9aCTvPSnvz1GS8
         ztMyPeFdrl4AIX3R7TUBneFK0KBR/ZDg0zavqpEM3jSOlpPUvIFW2D0dP5mJKo41Rl3j
         DAy6gERR0NtGe8IF1/jXFB+an77TQWVSD4FE3wshMmxPsIb6MeCcA6gh6GC52ORwB6z3
         bslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791905624; x=1792510424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGeBD3r78PRe46uI+kLHVwNamuj8NRza/V5oim/8S1s=;
        b=pEK1EUSfA9fCpANHZAZmLgDKU5+KAQwMQMRQUGVmejRTrkS2BFJ6DHX1ISE17GPkpY
         pUusRtNvdksWqXqv9Q6wliyUBxej++UmpTVx1fo2f6Xn/JPhTtZP2vJClrJQzbAjI1Jh
         jvIMK6Ke4dF24+z/jAYMpPEfopGhWjofN2m1nLeLGb/4n/vAkWLIWJFubrP9JuRqZX9W
         sna+2kEj2tzI4Rngrtu1ZgjlATO/VwhY3VkJyoKYeY6kvKLPDgLpERphKSyEAoY6Tw1B
         kmMPUd60aDSn+7xF3/tlnvZMlyZb9CePeBISbxrVJcm2fotj3XJ62H0epx08spWwK/4e
         TE+A==
X-Forwarded-Encrypted: i=1; AKwUvBwB4LCh/wI79Wo/IuBaAciyPENeBPGmJy1YUmBEGZ9KGWMsus+oFq9m8GwZjXnh4/hlN6cOHDQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXiUWTz2EUI2zn+xaPm02ycLzter/BtXHKah+swAc/2pxYxIzi
	YMG4mfwgOM0qGoYjxArI9VrDp8MBNC/OQBLN/h/ef5EG6tiRQMilQjKNHCEb0XcKtGd0c9SxQkB
	B6zIdTFDMWuwFKkngdZE6bPjPj21S23EOLMpLIoT7kPFc/QBgjxw8olMHpgs=
X-Gm-Gg: AYBFou2U25awS5QyDwN+XJuBy+TMgBf7XXIupFDsupXHsa5yo9wCqRn4CK0PVPHzwLj
	ADu/9aoudHxhBn8sFaSiwa4Ma26NPMbtW+0sZR29nQar7nUC//bJwzC/f9krLUTHXkxGAIsOrf6
	FaN8ZsWd1RIauTYFYvpxjTpVFG3q716pEhKSb8EvJWMBK3o6VOs/IVt45DpU7GearTK4AGFWdQL
	ydJnUJUbb1QK+VlXy4D8IYn0CoGZABNRWrZPzsrzreKGqu5X9s1a53hCrACuhsQzhKPnJuT4H9A
	Q4PTolXlB/e3PRlgefJmOEtF51QWhuHDe+T7k95Kfswdx7iS7o6OnVIuwlInunTmeocLq36/foN
	9qyaj3M6JzyAekg==
X-Received: by 2002:a05:620a:3711:b0:93e:9292:1bb0 with SMTP id af79cd13be357-93ebd0c08e9mr2039607185a.3.1791905623963;
        Tue, 13 Oct 2026 08:33:43 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:93e:9292:1bb0 with SMTP id af79cd13be357-93ebd0c08e9mr2039594885a.3.1791905622602;
        Tue, 13 Oct 2026 08:33:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabb8sm6621534f8f.15.2026.10.13.08.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:33:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:33:41 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, boon.leong.ong@intel.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <as5PVATLFOcTHbkV@lore-desk>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <179190522792.434549.2113659711683261245@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LxLLuhv1acDbnu1W"
Content-Disposition: inline
In-Reply-To: <179190522792.434549.2113659711683261245@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfX17t2aC4QGt/9
 x4pu/n9jowA14GZN8kMsZBO2onumZ4879NBU3DPrX8BrGZ/+QuNB0JHchFB2+GR1XtbhFO63cul
 igj9zm3Gyg4OkoXU0SZr5qoHZx6rlxBDmw7coImLDiL4RzQ5anSpkDYTZhmZ6z6znhu+5cfriER
 dDIjfSjuAWAU7/W60S7uoWnfe1DHvubwwGFLIl2v3NdT5QeRHPEu6vpoacd+dSXRhskp5avFZYW
 oCghTZf0FdaA9ezH1A1LPzqsf2LHGz5XEurRK8ZUamg8YSu82eR1MbTbhl25cK/oNxZWl5sMA64
 BiDYS43hKXWBMehyJSxZE5BLIfIhFNCZkAse14E9Ye/VLO9fdSZglZYq4zRCEYorZpZfZJungzm
 U4g+RoyHxeUcr3FfTqkg3GlN89sO9iXJcVEjzGKKZ3crSSGAdZUws62C6EgSUKtOm/ikiNy0NY/
 jHvi4czHkVc+3bKCd5A==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6ace4f59 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=cRO2Fxw6IMYKndE-NWIA:9 a=QEXdDO2ut3YA:10
 a=R2sLeNz3RpVDkO3zkzYA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: OyDmZVqrJJ9qBq0WXeQO1V7CVXZWx0W1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfXx+/JoT2ip/bc
 qe/8SEUSDaG5hXzTyF7xF25SGd4fxjGCSk5UBiuqdpmhBhMaGWoHBDjZ0+QTjJmbzWkGhVDwWi0
 WWBNkl+572iL7vPBlluv2QZSxr+nN2o=
X-Proofpoint-GUID: OyDmZVqrJJ9qBq0WXeQO1V7CVXZWx0W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130061

--LxLLuhv1acDbnu1W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The commit message's premise doesn't match the tree.
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   stmmac_xdp_xmit_xdpf() never looks at priv->plat->tx_coe when deciding=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: disable TX checksum offload for jumbo frames on bugged cores
>=20
> This patch turns off TX checksum insertion in stmmac_xdp_xmit_xdpf() for
> frames longer than ETH_FRAME_LEN on bugged_jumbo cores. It is meant to
> match the stmmac_fix_features() workaround that the skb path already uses.
>=20
> > The XDP TX
> > path bypasses that workaround, so once XDP is allowed at MTU >
> > ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> > device would leave the interface with a full checksum insertion enabled
> > on those cores - exactly what the workaround is meant to avoid.
>=20
> [Severity: Low]
> Can this scenario happen in the current tree? XDP still can't be used with
> a jumbo MTU. stmmac_xdp_set_prog() refuses to attach a program when the M=
TU
> is above ETH_DATA_LEN:

This is actually a preliminary fix needed to remove the MTU limitation when=
 the
device is running in XDP mode.

>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
>     ...
> 	if (prog && dev->mtu > ETH_DATA_LEN) {
> 		/* For now, the driver doesn't support XDP functionality with
> 		 * jumbo frames so we return error.
> 		 */
> 		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
> 		return -EOPNOTSUPP;
> 	}
>     ...
> }
>=20
> stmmac_change_mtu() also refuses a jumbo MTU while XDP is enabled:
>=20
> 	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
> 		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
> 		return -EINVAL;
> 	}
>=20
> The redirect case looks limited too. Devmap checks every frame with
> xdp_ok_fwd_dev(dev, xdp_get_frame_len(xdpf)), which caps the length at
> mtu + hard_header_len + VLAN_HLEN. At MTU 1500 that is 1518 bytes.
> Redirected frames therefore reach the new ETH_FRAME_LEN check only when
> they are 1515 to 1518 bytes long, which is VLAN-tagged normal-size
> traffic, not jumbo.
>=20
> The one path that seems to reach the new check today is XDP_TX after the
> program grows the frame. At MTU 1500, stmmac_rx() still sets frame_sz to
> at least PAGE_SIZE:
>=20
> 	bufsz =3D DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
>=20
> A program can therefore use bpf_xdp_adjust_tail() to grow a frame past
> 1514 bytes and return XDP_TX. stmmac_xdp_xmit_xdpf() never checks that
> length against the MTU.
>=20
> Could the commit message describe the trigger that exists today, and say
> whether the bugged_jumbo erratum covers it? If this patch depends on a
> separate change that allows XDP at a jumbo MTU, could the message say so?
> The Fixes: tag reads as if the problem can be hit now.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index ca61ab449e32b..0e29c5d04714c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_pr=
iv *priv, int queue,
> >  		return STMMAC_XDP_CONSUMED;
> >  	}
> > =20
> > +	/* Disable TX checksum offload for jumbo frames on cores where
> > +	 * checksum insertion is broken for oversized frames, matching the
> > +	 * stmmac_fix_features() workaround used by the skb path.
> > +	 */
> > +	if (priv->plat->bugged_jumbo &&
> > +	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
> > +		csum =3D false;
>=20
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. The
> comment says this matches stmmac_fix_features(), but that function also
> turns off TX checksum offload when tx_coe is unset:

since this issue has not been introduced by this patch, it needs to be fixed
with a dedicated patch.

Regards,
Lorenzo

>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_fix_features() {
>     ...
> 	if (!priv->plat->tx_coe)
> 		features &=3D ~NETIF_F_CSUM_MASK;
>     ...
> }
>=20
> In stmmac_xdp_xmit_xdpf(), csum comes only from the per-queue flag:
>=20
> 	bool csum =3D !priv->plat->tx_queues_cfg[queue].coe_unsupported;
>=20
> stmmac_hw_init() clears tx_coe when threshold DMA mode is forced:
>=20
> 		/* TXCOE doesn't work in thresh DMA mode */
> 		if (priv->plat->force_thresh_dma_mode)
> 			priv->plat->tx_coe =3D false;
>=20
> stmmac_dma_operation_mode() then runs TX in threshold mode
> (txmode =3D tc).
>=20
> On platforms with snps,force_thresh_dma_mode, do XDP_TX and ndo_xdp_xmit
> frames still request full checksum insertion through
> stmmac_prepare_tx_desc() in a DMA mode where the driver treats TX COE as
> broken? Should the XDP path also check priv->plat->tx_coe here?
>=20
> >  	while (true) {
> >  		skb_frag_t *frag =3D i ? &sinfo->frags[i - 1] : NULL;
> >  		int len =3D frag ? skb_frag_size(frag) : xdpf->len;
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1%40oss.qualcomm.com

--LxLLuhv1acDbnu1W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas5PVAAKCRA6cBh0uS2t
rBh4AP9zsPqcy5v4MxxUTWhZ0mz6mxVY53by/yLBAIv2hnvqoAD+NV1ihtRAqalp
oG98y0xYkm4wcIjB5r1EF/ebj3Ig1go=
=LEQo
-----END PGP SIGNATURE-----

--LxLLuhv1acDbnu1W--
