Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463F3E2740
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961260; cv=none; b=r1SUX7HkCTZitHVg8hxeGMexD/8lnYNC17+8LMBi5k2FlrAjqcgWu/Ja1+MnGVykn5UttcHYb74s8hdEsxKV0aD3M1skgiN0SbzZYlDiGThLD8NUYbTXdSf66NuLDW9gNnW14ET/yiBgLsXcJVCElv43banVuezXMaoHFKdmek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961260; c=relaxed/simple;
	bh=k+Iy8hjgM0nAL1BOwWPJsWBjd3NJN/SKRyyQei8ZEZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro7wB5idBdMdJHVPShchgPXBxZIceYel5JIxx6ZR21mxRcxn2JDPaneWvsnCqwKcj694mBOVRNxU7ygU/GY2wdxl3HmC5l9OW+EgbjoZPCMYKPapz0JZn8tV0gfwz3bIM91n3nYJwBKx4fNmKDm6yR9tLgrLAUNtvbRxe66EulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrhKChn7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHTp0eP9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JrhKChn7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHTp0eP9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HRsMA4127583
	for <netdev@vger.kernel.org>; Wed, 5 Aug 2026 20:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RG0WLH7pq3V59v399MYANWSL
	bjIejx2QigpuxS590SA=; b=JrhKChn7GaJ9cg8X8QHx8HLV42LHq7wCGriAnfoq
	JRplin65Zyq9gccZPsDNfPgo0RKWNhZuvIGBTkgrb4bI1j8ibP3wb3OsrHO3BoSI
	kL4IoIH0XY55I+cLc+xlJB8/+7rpLI1K2+M2RT3rnzD4x8KZVolA/DtvhZm6MHZz
	0rMhYnB53iKKR7aeKTSABYrdqQ3VmzP5LwU4tJilwc1DW9ch67bxOsvb6qEMcYOb
	oNVXlRodpxmGGiX5Q0BHNfjX5XFh8Q1cpJq4NmgFz6/1EiO2JhRviELvXxNa0XiE
	MGEWtYns9L5df7rJGMEuJ7uV/T/jkVFG3qAE1in4uRKkkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk2306-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:20:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d7886cdso23623911cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785961255; x=1786566055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RG0WLH7pq3V59v399MYANWSLbjIejx2QigpuxS590SA=;
        b=XHTp0eP9CQfeUfODI7eiagphw8nsqFRFIKC3VaIlKiBobKycyeGu1S2Sj7N9bXXS7/
         8pj5hoCxgG3pCEIsWfJldbtOcjzLJBPeNapfYdzPB3K3NQnfub10XKnvJU6f+WcAB2FQ
         KYhET9KaRW33xkH1ofGLfhq1ZEEeRlkfVul1WX40vrtd2lwyRciLG2QgSAqOCILOf1mD
         l9JxLCRNPas1NIx/lLsAolCIqOQf8FMdwXj7IEX5xxj4Bga8Vg71k+rh+XZOUqakA4np
         MNuUZCjqzO6zsr+MMojTUo1wahZS2hLbg+FqknkuGCCgV8kLuptMM5QfwHmExGfVI2l8
         KjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785961255; x=1786566055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RG0WLH7pq3V59v399MYANWSLbjIejx2QigpuxS590SA=;
        b=kBxkXmSCL7+OM52kwaMAdyruVW5V0OHxVvKLIgnAGQucE3xYJM1JPL5EBYI/CFFuw8
         9zGi36K+fGsInqCoHHyPkWyjLIztMu+QxhZMGwxn7EzKqoKmmVU/Y8uX8xcAZR4nQmHy
         Rb3fLlbVsVg4bLmD0Q+0NIcueNC3nAlmUk5v+L9CLGZTB7MJSM2q31hae+nPilkSqvdQ
         rh0Xixt/2aUOZ+Kzu4hlwRUkV/McJcpIvSTH0bKX0g+7OHKL6tc3tWHar72tDZ32zK0M
         onl4Ztpmx7Aece1+qxDyBj0dXwW7dfzb0AlVkbGLE+W6vh/U1aZJo4PB++RYJ+KMRB0m
         Gi0w==
X-Forwarded-Encrypted: i=1; AHgh+RrRCzdu+sHjBF58bm8FXAcaLgvfN3drKSFBH50j1HrqxsfDRHSFc9I0t+8cG/icebn+5zluLn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIamo9i0bsu6sEBbdKf3ISoYbDUML2d3OjvkxsXAcns/cI8xVF
	TDJW8d6tEEt36rop2EJbVsh1wtYGcA7zZUEH/WwEns5toYRhnhjirUG8gsqmH82zQHXBorLlRUL
	KFATrvzWN3ZTghWyQzagHRqEG1Bb0VllbmT+gN/dVnOZ3lLueIVGcL5SSsJ4=
X-Gm-Gg: AR+sD112d6dTOWM+Lh9SrwEqUw7gSFcfBooyeFl6I4ojKBZV/39yIW0EnH9UGWMscgW
	nhL1yXfkIydJ/mRk2QbJ8YQEJRaXo4JjMwc/IDEeWeMpJ85c7YwcLMXE3khWO4uPwbtfcZPQIo8
	quiBtrBqXXE7vZ0fLdqwzAwB8G84M94QwWVTZ0vMKdATYVzSZFe7ig6G2sAVCOu/ZjJjEw/xZP8
	CCabkOkjeznonYq4PQgQGVRPpbGtE2An9ywL2ulZIWVxiNAvXbGiJseQvOzLB5v18cryGAFEpZZ
	uFgm7j33xgGEXRyxSf0t+rVB7r2jkizbtfge9Jf0o2eBZ3VpON5RKaPTMpYtWF8XujTR1GvC6Sk
	0dvk55zFinwZTSJc=
X-Received: by 2002:a05:622a:551b:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52ce6113b93mr110064771cf.21.1785961255314;
        Wed, 05 Aug 2026 13:20:55 -0700 (PDT)
X-Received: by 2002:a05:622a:551b:b0:52c:dde9:5cd5 with SMTP id d75a77b69052e-52ce6113b93mr110064091cf.21.1785961254865;
        Wed, 05 Aug 2026 13:20:54 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d9dsm5850935e9.2.2026.08.05.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:20:54 -0700 (PDT)
Date: Wed, 5 Aug 2026 22:20:53 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: add tc-ets qdisc offload
Message-ID: <anObJdRfQcElQGFn@lore-qca>
References: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
 <anNzkcCXvOehhNcZ@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2xrkkYUQ9YkXZPG"
Content-Disposition: inline
In-Reply-To: <anNzkcCXvOehhNcZ@dcaratti.users.ipa.redhat.com>
X-Proofpoint-ORIG-GUID: psH8H66hYCFoFVS77Tqcz3uW84GYGImE
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a739b29 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=peNN9GvJXgMoxCkY4pUA:9 a=CjuIK1q_8ugA:10 a=h9vEhtIbZdNCuo1-SvUA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NiBTYWx0ZWRfX/WHvOd4oBsns
 Hgjk2seycf945niV8C7bFvcANphbmpqA21mgpHz97jtY6ftSew8uitCIaO8HPcTlkQawnUWtNeF
 NcXpA5XGaoTx4agot+OMXQreKSNaq31WVSXFzHaFL6ZURMtGk1FZLF8DONRGieSpyOJgG+tLKpw
 0vTl9P8ge4PPEFK/qBQvbU/AXX+kqqX3eOQshCdzz6oFYiCXt0Wpon9tNLMmy2Zjk416B1GBX6L
 3zjDDlfKuJRDSFNT5tD3d2LfiPjh9kxfhsPrJdZw5sbKbo6yE+d16ITIkXW2MpTtmHz5QMXN2l5
 b93aPHjhydkLIVmzluy95D9EJJXYccEQ8lY/J/89MBnOvIxVyYmmYBcuk3PxoSf6yvtL26qhUUu
 2TPbhrN9KwDTj7wVHXfo0UeHU0wO8kGqRzodDq4y5PAzo1uWeRu1CAMx47EMDmnGDDGQOJpfyv+
 lY3rsvAQPdpgSJHizQQ==
X-Proofpoint-GUID: psH8H66hYCFoFVS77Tqcz3uW84GYGImE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NiBTYWx0ZWRfXyWgV3zIj+z9o
 PnzCBjSbTTIJkyxLBdJXlFb3AqX2s8C49yY8OYnCu+Vl+jSiXqa+kG3nb5CHAnVBEZh6cJTdP+N
 +638Ow7gHxHLj4Jw5cOCLDNmf+Q9ItA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050166

--s2xrkkYUQ9YkXZPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 04, 2026 at 08:17:35PM +0200, Lorenzo Bianconi wrote:
>=20
> [...]
> =20
> > When all bands are strict priority, the MTL scheduler is programmed with
> > SP scheduling; otherwise the requested weights are applied to the TX
> > queues and the scheduler is switched to DWRR. The TC_ETS_STATS command
> > is accepted and handled.
> >=20
> > Export stmmac_set_tx_queue_weight() so the ETS path can reprogram queue
> > weights, and wire TC_SETUP_QDISC_ETS into stmmac_setup_tc().
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> hello Lorenzo, thanks for your patch!

Hi Davide,

>=20
> > ---
> > +static int tc_setup_ets_sched(struct stmmac_priv *priv,
> > +			      struct tc_ets_qopt_offload *qopt)
> > +{
> > +	struct tc_ets_qopt_offload_replace_params *p =3D &qopt->replace_param=
s;
> > +	struct plat_stmmacenet_data *pdata =3D priv->plat;
> > +	int i, nstrict =3D 0;
> > +
> > +	if (p->bands > priv->plat->tx_queues_to_use)
> > +		return -EOPNOTSUPP;
> > +
> > +	for (i =3D 0; i < p->bands; i++) {
> > +		if (!p->quanta[i])
> > +			nstrict++;
> > +	}
> > +
> > +	if (p->bands && nstrict)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (nstrict) {
> > +		tc_setup_sp_sched(priv);
>=20
> From what I understood, this will fail configuring the strict priority ca=
se (the only one
> possible according to the commit message, where all bands have quanta equ=
al to 0). Maybe
> the if() statement should be done like:
>=20
>  if (nstrict && nstrict !=3D p->bands)
> 	return -EOPNOTSUPP;
>=20
> WDYT? thank you in advance!

ack, I agree. I will fix it in v2.

Regards,
Lorenzo

>=20
> --=20
> davide
>=20

--s2xrkkYUQ9YkXZPG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanObJQAKCRA6cBh0uS2t
rHD6AP9XgYpCrXA9PFQnJ+qQc4QoT8kpSYf9vl3QSkxIMCjvKwD+Is5MIO3/7u+d
f+JCbvPCgJWfCbT0bcm+si0m9cLGQwY=
=538k
-----END PGP SIGNATURE-----

--s2xrkkYUQ9YkXZPG--
