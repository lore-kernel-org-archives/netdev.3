Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057283DD50D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281511; cv=none; b=U6Ezqc2NMFs0pMUX8karXRj8rVdGqL0dgT0lsEoq9m9fvNNk3k9CpdDNmq271jqqWDpxDbifQMCfiLzye/fmzfVBwzpZ5I1dVbAVcIh+/ufmG/w5LOmItQ7T7LDqqXKwVRkwjFfn1vxveWzNS9zFFWun2EFzcrdnv0h4ACglIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281511; c=relaxed/simple;
	bh=VieFunzUG1rZrphtwNiHTJgs3x1h5zg3MPNsoGPDiWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU7uIvcrTwRw0oVLWaCtV9enrIkZ9GHuHwHFJLac+WQ+dXo/SEg7/R48u3OMIwY6g+zl8/EfZFKDVPv+XpVS7sYxD6giiXJKHP4YFb3CSZDfO7BRxGnuJ1ZU4bgBSvkfMezit+d2xfXBzcE43Ef+sTuTH5hlzBrmj7HHaCo/4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxY7EEIt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PKfcy0i+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxY7EEIt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKfcy0i+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A5FPh160598
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bTcOZk1sU7Cr4tIN5dvWZPdb
	1cIAJQKKZzgNOboyWAo=; b=WxY7EEItgMWleFNAVpaHwfH1Fh2UnXDdOV7xRlmQ
	0ghdSu2SroEpDe4ZYh/4b1Frsm0M4DL5w+8bEThCgcbQMJvnCeZNUslpMm5ze/Gs
	L6yUvvUlMA7MwiQP14ONQwdNMBmOtPpUvXySpmQkZbiFESW+cG1h7BJEuOCHmQbJ
	66dGVSqBMjhXaURmiGqwYzXghlMVQkhBSHwELk7iW+KOZcwyWy/i2sd7o2qFI/3O
	u3iFftSATRIWXWFLliY43aj1UzFT47O3J7jXTmO6ifG15Cf3aZitv2Tfs1lQ8m4o
	yN1q2IsWuvr+9htUHFB0t/5F1r/02nXEotw/7pUSWdWk0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu84yb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:11:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc7a6e4e1so709795785a.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791281508; x=1791886308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTcOZk1sU7Cr4tIN5dvWZPdb1cIAJQKKZzgNOboyWAo=;
        b=PKfcy0i+c1eglqgw+q9137hoJ/neMCs88p625/Rz/jVyfyTFdIqvkE/nwbjGhJfOFK
         L469HBmnCmhy7CkFXFMPT5pGA/qQoGfHC3+wKkadRc4INrSGXTzeep3yM7ced+Jg8QIl
         ry44SGWsoM74X5SCoTQ3XX4fiyzOLqM9YBNdk7UZv523gE6Ua87dWZvl62D2ZV1dh8tv
         nIFy15xcDphwq31H1MHhz4/53j5rQbOCysASEuPepfBAsujRCWm23jeXzQd0Yu1MCYVh
         DLRcMovtqYyRNzpePuAfB7NV6WObe4CC1cp661aERG20KhWGm7LIX1vsR/BTx3dSAS+V
         zobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281508; x=1791886308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTcOZk1sU7Cr4tIN5dvWZPdb1cIAJQKKZzgNOboyWAo=;
        b=wVTpTLwU4NLSjcM5hVGBjxBYfVOXx3R39OilBrK37sZb0yGVe6boIDbwDgiszTjNtU
         HENr1nAVGYVUkJtKe2lC5/0KBk2pTlkHJRC9g6WwsARuFVKJ5ZFfs9Q+/x7DHUhMf/9M
         Mtio6b+e9wKzlDNOJdW7ytSrv0EhhERB8xh3btryLGW6ofdC1S0u95z3KtMkrYtcdmIJ
         CH1xZNPOp65iOo7YB8zfUWA5bjzAYxDhUnvJd8nEICclBxYYcvUV8BO9NGqEjscvEmAQ
         kRtv5/ZdZxBpWnNjZU2/ioM+2ZaJCI8WMHKfobi5wr6WP4VMCFbdGhfjOqio2ic1zmfl
         otzg==
X-Forwarded-Encrypted: i=1; AKwUvBx1BhFqzHv9qCN0BzJgeyV6/e8C9xstFkbf84jupRlpkgovHxTjtmW1t/ROZok++j9t16Q5A4s=@vger.kernel.org
X-Gm-Message-State: AFuF++lMbaE0WwSHdukMA8y/akbsP61Hvyd3Y3lOdnXKldLwFT7U/JP1
	H6ngETkKet/ErFhTf4vP2/NUh1zpWqvHu2p+9UnEnYKR+IC8EUiD8x5GBTOwYUtTvwYJAj6ESU7
	hfi9/v3FOU6M0jKuRzyuX1pd8J+dl9ijlm5Lp4eeipGGOlBgbejHHgUjMET8=
X-Gm-Gg: AYBFou3S6dU+s3pBMRPA47QkirVVIIcZEC8y/8uPMr5G8aHLF0+qzOgVaN2ZUVCPq8h
	OhUyVp4fqedy/0KHC57GH9h6et1W5JhmHnXoau1IIb4IBwEQe63Uwty4LylYEYZ4xAHOXWT2k6Y
	a2yF/2V2sjf0gWkbI0mWjPbKHm8QbsNs4EFmPmf4LGsGGqLBu2EhupLMaqG3vfHB7NqwkCmAml/
	K3Cq7FbReqBtE3cic/geB/pSzVx7cJrGyEihd+zfm5Bx0+XDNAklVN6koXj6v5K3MjLum1syg2l
	AoSoT1vmGRP/qQ8yu6M6JYFp3c2g/3oae9atgsOswgvZG8pewIrLxzdusp60ebGyhJdJ9OOR8um
	o4DiYmQof2NbAYg==
X-Received: by 2002:a05:620a:25d0:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93e8f4ff7bbmr151195985a.53.1791281508236;
        Tue, 06 Oct 2026 03:11:48 -0700 (PDT)
X-Received: by 2002:a05:620a:25d0:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-93e8f4ff7bbmr151191185a.53.1791281507645;
        Tue, 06 Oct 2026 03:11:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1776cfe45sm64306225e9.1.2026.10.06.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:11:46 -0700 (PDT)
Date: Tue, 6 Oct 2026 12:11:46 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v4 0/3] net: stmmac: Introduce hw queue priority
 offload
Message-ID: <asTJYbO3a9EC0KhX@lore-desk>
References: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="udmTCzUCSWgTpXTE"
Content-Disposition: inline
In-Reply-To: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX1RP8NYA0vrzJ
 +v2D7smPMUmWDNTfNSI4aYX1iUU413HAxT1gGQVHYweH9DTspphhg0sogXbJt5PlpJUFnkj3gM2
 HOCCAc1JonuS+Le5gFiPRiGaQs86t4o=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac4c964 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dNSR6zmZCi-5ndhixXcA:9 a=CjuIK1q_8ugA:10
 a=hyajzLvZGwCchFMiHN0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ONvt2S3CaaY3oTQF_5k0N09Qf6pv3cUy
X-Proofpoint-ORIG-GUID: ONvt2S3CaaY3oTQF_5k0N09Qf6pv3cUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MCBTYWx0ZWRfX0bZpaS+9w+ec
 8Jzf0A4JlXgsuBojkFaajS9eeLWZnFWZCco3OfTOgMNwlQ9ycL+YGCXjmdY6zzQe3A5t8iBiF12
 E4VC36OmKU+nxq+OX6Voc4T20uwTZdwU0R10g9Wl3nJBTWTFR/9CG4nozFZq265U8x5HomliBlG
 Lq5x+YgEmkcFho2EDPkY3xsXIpCgO5Uf9HubOaXRIeKrgQ0+A4ePN6JIGUrJjHEsoTlkYRmUAR7
 OKVjxZdVdr9LUCXFG60M8UXTIk7YI+xeRejVN897EsqkZ7c3qrZ4qY/sn7iug5G8/vconWZAvAs
 VoKYoU4wn2pH0d0uCeVsNQ/Gz86Vjq6KL+sKrm0luwqA3QoikFjyft5UYrT5SLg7KukaO1XbQav
 JLBXFNhSJ/YWK48x+86qapF7CkpmESypF1Ab7izLb/v7zozJYs8lMqYMkyiZncFcDxPzJ7TphxP
 THNfJvATKTZugktXctw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060040

--udmTCzUCSWgTpXTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Implement the offload of the tc mqprio hw queue priority in the stmmac
> driver. This feature requires the mqprio to be configured in channel
> mode.
> Do not overwrite real_num_tx_queues configured by the qdisc in
> stmmac_hw_setup().
>=20
> The misbehaviour has been reported by Shashank and the patch has been
> tested on a Qualcomm RB3-Gen2 board.
>=20
> ---
> Changes in v4:
> - Move real_num_tx_queues fix before mqprio offload patch in order to
>   allow easy backporting.
> - Add patch 'net: stmmac: set real_num_tx_queues from max(offset +
>   count)' to fix the real_num_tx_queues configuration.
> - Link to v3: https://lore.kernel.org/r/20260928-stmmac-mqprio-prio-offlo=
ad-v3-0-abbe181f5024@oss.qualcomm.com
>=20
> Changes in v3:
> - Fix cbs overwriting removing mqprio qdisc configured in dcb mode.
> - Return an error in stmmac_reinit_queues() if configured number of tx
>   queues is lower than xmit_qdisc.num_tx_queues and mqprio offloading is
>   enabled.
> - Link to v2: https://lore.kernel.org/r/20260924-stmmac-mqprio-prio-offlo=
ad-v2-0-fdd8b69efccf@oss.qualcomm.com
>=20
> Changes in v2:
> - Forbid cbs queue offload if mqprio is already enabled.
> - SP requires 1:1 TC to TXQ map.
> - Fix the real_num_tx_queue overwrite during device open.
> - Require the qdisc to be configured in channel mode to enable hw queue
>   priority offload in order to not introduce any regression in the
>   previous driver behaviour.
> - Link to v1: https://lore.kernel.org/r/20260918-stmmac-mqprio-prio-offlo=
ad-v1-1-5328157fcb58@oss.qualcomm.com
>=20
> ---
> Lorenzo Bianconi (3):
>       net: stmmac: set real_num_tx_queues to max(offset + count)
>       net: stmmac: align real_num_tx_queues to mqprio configuration
>       net: stmmac: add tc mqprio hw queue priority offload

I will fix sashiko's reported issues in v5.

Regards,
Lorenzo

>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  37 ++++--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 147 ++++++++++++++++=
++++--
>  4 files changed, 172 insertions(+), 23 deletions(-)
> ---
> base-commit: eb0c18404c8943356f4aa164e5db9067b79ea93c
> change-id: 20260918-stmmac-mqprio-prio-offload-3d82d87f7bc8
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--udmTCzUCSWgTpXTE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTJYgAKCRA6cBh0uS2t
rIc+AP9evodgsgIwTTdGv/RgmpB3B0Xw1hzg2HAD0UDXltWaTwD/QVaIF5p9o94I
wPNDQCHFkUU8YXnSMZcx8ssRKfDLkA4=
=NQSM
-----END PGP SIGNATURE-----

--udmTCzUCSWgTpXTE--
