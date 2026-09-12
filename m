Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E233A9F3
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249672; cv=none; b=lvjuQ0N13n6v7NUvW2ED6sX4L/NUQFqNkWwKlDFtWhiOdTyiPoa24WSUx1tP/JQvFdcYT36yaCSAaxc07FLquGV8Tc8a+zOvTMDOmZLE7DloKntCBdmmjAYw5+uVnob3e+3wO62NyKbnPJmL2Jf4ZIPwkAxVg7yuA1XTeBCYVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249672; c=relaxed/simple;
	bh=aVP5H3WiUV3C3i6ipRfrWpK+MqLaOp+MPARIcfxT0B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+9o+9kNouzU1Omz+qHgjqzuucTWG2dRz7HyXyjv85h9dwkX1G+CNnp+A0BMouDORRJWmbhmrmDWDO57TpdOEKPTiIh1d3gBaLpWtLrGwoC3hC51AxsGBIefxTqE2QvlHZOzORKPDOY7mXkgs91FI8UNhNLtXVsdJOGkjYqWU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CfVQba8Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AI0yP34b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfVQba8Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AI0yP34b"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CI4cRL3572607
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gvazkXrT8HxxFMwGC6hBzST5
	l2wP3hbf1B9tV53FoCo=; b=CfVQba8Y4cf6fHtqie1cI3mXLs1Hz8NFV7ioMN8z
	zAWQK3fYKk75DbLNY/oaoqfXRUC+KUVjMoqKIIOFH1rkssxbga5rxpJeBDYHvUTE
	tLTRMtFLZoLZPrdqrAV69FWfqPaZNTmwrMu2E31D3khrd31IKARHNLoj96ALkViC
	AeYQvJQFdTpZHTcHeUT+kSdyq7MgnJznVVRWmftwJ/YOWnGMkT5Jjg4IlGQMv1Mb
	aCs2xunip1DrX8M+AeWcIqKO+XHkeK6N8i4Fy/HCaOep6IWss3PRx9Yqt17LFnPW
	rNPJWdxlIMBF3rX3h6r3ln1vNs6b5A1uoky7TVjUHPnoMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d9xj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:47:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so521238985a.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789249669; x=1789854469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gvazkXrT8HxxFMwGC6hBzST5l2wP3hbf1B9tV53FoCo=;
        b=AI0yP34bJKIPA2xfnXsg3KgMIR4kq8fLU/pN8qftEZC69nvEwdSaExteGjcw16TfZ9
         AZbOgYh+Ft6sC0UiGZGiD4aLCJ2A78ZWbgCI+grYLcKzS3hNa7Z06aff/jb3jfP6aagp
         clctBZKVt9QqRpSoCx5BAI1XAfdxSz6qhW2NfTq0hcf1jbOwX+PkrZr2w8AFx8qmImwW
         Zdy90L2IXI1IkeY65A3ge135TEIDJb7P1CwM9D0boiaWPjxeo9bCRIvqCFA0R0gFc5e0
         26gJr+aQXG/NdWinjlpiFlVjZzdCr85Zhv84o7H9I6ewNIoho+FTM7cBVJm/xwLLleRV
         cMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789249669; x=1789854469;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvazkXrT8HxxFMwGC6hBzST5l2wP3hbf1B9tV53FoCo=;
        b=SBBAANWE/2gHpsPBDUxFcut54huoaOto5evOqcQiEK1UNmi/8TNRunq967hWdYimxr
         3cDVifqrkwqm0SYndlqKU4vlKpLXdg7YCEIfiQS0sHh1i+5YyqkiNgG2PyM7qRTy64J4
         4PqN5KySrv8RumGRsnThE9DsN+SXDY5YDhZjezEWBMxIl1rTHro5fpj3ZLlNZwN2Emx0
         7fPr0HY8K5x8+JbeOAxi3IfXqFY0U9iegTgbsHAS10sL8HzbwEW8PMHw6CdIaUcL8JF9
         gNabV+8h98da/tOUWjOHoFT1HdqZMmCz3F93TB+Q1NZNtkuUsM0bWvubKQLpl9ACeFva
         uIlA==
X-Forwarded-Encrypted: i=1; AKwUvBysrwFk69Bkj5tgKIFjdj7i7pc+zAR7pMeSxmdd8gMvA3n+K5bsu1pc0COae334z8g2Ph4Y9+M=@vger.kernel.org
X-Gm-Message-State: AFuF++nI8356M9WhEXKYt2DSDaFBRmDA9S1uYIDWgTp9LI2twzlku7eO
	DGoTPQXyM/93ZrPRppZ+juLBU1mwQmGtBJYpINJ4j/1ob5OoDGkGz7CaTEngPyhDJSbKKHVxuBL
	9zvwOi212TsRbfJB2Eoz5GOXgUrvxNM0CDttwUtV8k9cHmNOoKfoRAOmRkLY=
X-Gm-Gg: AYBFou0gHXa9Xui2VEKHEBaYifyVCmPZunK6fAAtQtyLy9L5fxKpzKV07XWtqJ/W+3q
	bZKUMu4Qis1LhazD5Tn068wNa64/Vi4/G12onGGy0TG2299bWqUp0Haky+t0hpiLwtDMqmhLMnW
	PY2eAmJ6sVpW7o7UXVg909LrJOhfrShBINFcGPobh8aqX2v7kKogjvuwzREh5gQZuqyp2jJy0yN
	a7DY/SGTohu2WUqundDJYb4djQkCwpxD1fEI8ycQjDs1Bpu4Mw7F6penqn69tBHode4lCfJHdKE
	NeJmOrD/JLI/uCzLOPMB0jJCMH8/TwrBE+lRKqTzZkev8YH3LFuthxG5iWT/8ooW7r0jgqywBPy
	fEwR4tmJMwe+Vfw==
X-Received: by 2002:a05:620a:170c:b0:939:df5:977c with SMTP id af79cd13be357-93a036c2104mr646814285a.19.1789249669585;
        Sat, 12 Sep 2026 14:47:49 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:939:df5:977c with SMTP id af79cd13be357-93a036c2104mr646811785a.19.1789249669082;
        Sat, 12 Sep 2026 14:47:49 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f301121asm10415554f8f.0.2026.09.12.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 14:47:46 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:47:45 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] sit: do not report an error from
 ipip6_fill_info()
Message-ID: <aqXIgX-n7nFWC7Di@lore-desk>
References: <20260912005442.1795813-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZ3UIc/o38zgKTS6"
Content-Disposition: inline
In-Reply-To: <20260912005442.1795813-1-edumazet@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxOCBTYWx0ZWRfX8BvyDRAlIYZZ
 HT8jD/EIZzjpXFzHQ8gOMi+Z5x7fZN44wjTVKxTC9YXhr/BKLnG4otwu3nD2/8ZQY19ZiL8nNAl
 ti2hHPMsFAcM8YD3hUsbUywO6oG0Ti614pDJQGSGYMeVIjmZ76HVOUFu7rP4L9wkRDF7ePlGWkj
 OpBtj+ly8ppuSWnnqQYAkiLsPqmQD08yxq0WIO9LxfbHkBi1lBLvUyZcL+dEb098/NfVLQTDCE4
 EJaDuhdNGV3JJD5xuZk5s5vTcSNNMZcXJGPY6wpwxTVNHRMBrk+gteriZPFOxKOBM1eMsIieffi
 DmAFA4je/qMX33UGoefDZG1LSPfvSvDkSh0N3mBPZurh5CH4hDAnCaZcQfwM+GGx1D/mKG8SVkW
 WIViXBYEG2ykZAqGhZ4vBj/xHmyK4LHItizVnMm/bpH4aULvC0SMDoRkC0TTmQgzl7avev5Mf6D
 iU2Fx6Ews6UhrO8+RPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxOCBTYWx0ZWRfXwdwhA+zuyUdK
 bM2D7vAJwnSuKHyV9Mn81jzns0I6GSdtfcmbfzYt5OEXcWfBHNQD3y4FBQvmLS+eVjELeg8dmCp
 U4jRvuECXnVDNLPF8D/MR9dZKLMsSuM=
X-Proofpoint-GUID: wwfK0rgHqycMI2fZewLFP7HFaqSSJw27
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa5c886 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=dXwn1UAFjSf9spo3BhsA:9 a=CjuIK1q_8ugA:10
 a=WaWDPCP4zztkLaV--ucA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: wwfK0rgHqycMI2fZewLFP7HFaqSSJw27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120318

--uZ3UIc/o38zgKTS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ipip6_fill_info() returns -ENODEV if tunnel->sit_parms is NULL.
>=20
> This can not happen yet: sit_parms is only cleared from
> ipip6_dev_free(), the priv_destructor, which runs long after
> RTM_DELLINK has been built.
>=20
> Returning an error from a fill_info() handler is still a trap,
> because rtnl_dump_ifinfo() stops at the first failure and propagates
> it, letting one device hide all the remaining ones.
>=20
> Return 0 instead, there is nothing to report for a device that is
> going away.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  net/ipv6/sit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 14ba3cfb304a83ee37e3be5b09a57c371f1977c3..a7ec800216ade169985d389ad=
1dc672f0358f4ee 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1853,9 +1853,10 @@ static int ipip6_fill_info(struct sk_buff *skb, co=
nst struct net_device *dev)
> =20
>  	rcu_read_lock();
>  	parm =3D rcu_dereference(tunnel->sit_parms);
> +	/* If the device is being dismantled, there is nothing to report. */
>  	if (!parm) {
>  		rcu_read_unlock();
> -		return -ENODEV;
> +		return 0;
>  	}
> =20
>  	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
> --=20
> 2.55.0.1007.g17ff1f9808-goog
>=20
>=20

--uZ3UIc/o38zgKTS6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqXIgQAKCRA6cBh0uS2t
rHeaAQCVcV7+Sd+obmIcO6wigZa7JA6Y74ww/iP3KhyYfyJGPgD8DH6UsIkp/+Xw
Vnjm9RRHFl+8+W2JQDtG7C1NnIMfeQI=
=aYwi
-----END PGP SIGNATURE-----

--uZ3UIc/o38zgKTS6--
