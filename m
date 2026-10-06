Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1443E40EB
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275432; cv=pass; b=Q3bPfkb6aDS3zF+T4Yp1vRpIvgJfz0AEFQS9Rk+ZQBF3pqddN9695ILu1qLYUTCGt0cyYpj+DS0q+7X7uHLayCXDz2JOaZ1ekWPqZjAOePAosBzTdG6R10lAJnkzfcGz5S/BZ6HuyjrzoNTLhpotl7OQIDXgnG2n90s2FW8K2u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275432; c=relaxed/simple;
	bh=SZ2Cqouzf2DxnR7lhpDTzXtTUMd+wHcWoo2UCnDoWlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0ZOwiRcK5vgWgJyYVsXSaOlNC0eao4u2hh57xiStWE2D57Do4rG8WrMQrMWCr+s89gqVwEFVd+v0ojR6JFUVHIUuB/aB/qaD5RZT6jZ03hlB83T+2+ds1vlKJMurLrwvaFLakk5RH70xGTcciXb+asC39dCLBcN2G23pbDkemg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WtZJbPWm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDwgmie2; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WtZJbPWm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDwgmie2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966eApn1083531
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 08:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IhWlzBrodTtXgnRYBtXz3K30QUfYNEEzBTba7ysaKrw=; b=WtZJbPWm6l7NKU7g
	FJT84V79FBs5oTdx+yM0TDl+LPRCsrNtXXSlKWlyw+GO7+0oB3jcfrmiy9ghVIcb
	LpxVuV2HKLM/7ydx1e5aHInj+eb7Woi6fYp/B+nxdS0aF9vJWay6cyFlcFmKiGnc
	L95F0q3gol8M5U/4nRhUQQ0Jmu1dlEqRklYidJC0qAupoAfp6yVosMtWJXE/6L2p
	IZDfwUnUicdx0B8y+mZ7pw2iRecFP0ROcyyiycIoP4Hqmp4oRL3RnaYraVE46qW2
	lNLkkoGZdVlmGysgRrFNJvj5aN7xnb1lkHG2DLSCjr53TWzKuQnXtUj7PgA4ch+f
	/T6lQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu3tvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 08:30:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cbf2fd504so515198585a.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 01:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791275416; cv=none;
        d=google.com; s=arc-20260327;
        b=UDJCYOP1e5f0yL9BPC83+2NuRN9mHXa+fLvFmQA4dtO3boXW8XIoHCtoUHI+rCLdnp
         gtOw9i+2KugO1RY7zbDjuphWes+h2jP1LxEAKQvTWtMYU3EObsPr0nxPMtc93zrY2uIH
         gTkIAjgd1JS5pdOja+hW62mThprupX2EzKqMpnePaYRcJts6FzdSfCWCcYRNl5DZEZeY
         M22tP7t/RQ9YTXc+ntvGFDHHDY0PPQwUWWemDt61uZCS5pGSPoXRXGouZFAlrUibml5x
         fbF1/En1VZxpvW3efU0fSqDbzxo8in6Rd1qntuVBr4feyvgldxgsD3bo50suxgu2ni0D
         DJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhWlzBrodTtXgnRYBtXz3K30QUfYNEEzBTba7ysaKrw=;
        fh=i33K670MfUSCJ4xYGCpgv3BQ6q0Vsu0j66apzVV83vE=;
        b=P3PG3WiGiCi/+V6uO8dgDctbM77OM8Jp9AJIWj/HHvq8nwh56mdipBKeZ+CbE3asr5
         8hJX1RZMGKDy9+FxMyuIL7pxBIca+U4BAKgqonzoIknQqQE0zo1cn6Cn+LtVZML6q7XH
         l6aYtZoyrzLNlCT5pCVLpYFlBM4WT/yDY8Rmq6gz80WTanKlNPGpJqGlC7D/lyJgcnS/
         TJb71H+nQH7UvIz7/udofYZ9g8Me3ZVPzqxoYv0P96494GTbSB+b6jT10rj0nkDInQOA
         JXfTMfkiPa7f6in4OxCWn87tBd6xzy0TQAe6LFxsTYFuKPtKu3oBNkDTIwkmm74+0M+y
         CR6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791275416; x=1791880216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhWlzBrodTtXgnRYBtXz3K30QUfYNEEzBTba7ysaKrw=;
        b=iDwgmie2pLDOUSyvDndzV357y+fYbzeZ3WPgnaoOXGnhbBYJ4hucFpoZDgXiCNMj+1
         YmVB+Pv3S99HN752Y0bdc6GbvL1/2VTtkE3/HKNqk/GDs0vZ9ZPlbaq6XVpYxcrKy2dw
         NUkOakaqjU6/4q5fLaCS+DHQogFSRr54Wspac/k96rT00i46vNpqhq65kYHFOTCR9NAq
         i7U/mvuWDg9P7xh9TTQph+0zTbDH5xN1pWtof9s4bmaAXBKLcolS6LiWC6+8jVTTC+ZT
         fwVfOmh2VRGo9JzkveW42i6INVsTawoQBOqNKtVFKnjZoa02F2mgJLN1LFgIqVkN+xGu
         lPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275416; x=1791880216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhWlzBrodTtXgnRYBtXz3K30QUfYNEEzBTba7ysaKrw=;
        b=p0O7qi5S/OBCnp03xNLmZQqZ8Szj/h+NhUmkUDYnXaN2NZSKstO4gUWFipXuHnUo8O
         QR27y8vKhqcjKiXVBPLAEyYeO7ZaPVHydkpWhw6MK9XT/I2ALas8X+FPmUIc0KY8fO2b
         LY1jFtEXnKeEclXdAjpC9CGyAre4JSZCdNmE+qWxd2KJ6FEWGIr1aX7rz539xIa7QFbo
         Gf/Nf1ZFtU462QaGm6oMOfD8dXhLGXcW9VqcQVQEk1boivQ/1gDsrHc/wRnYrZLTnFf1
         JEr7e7WemW77b72ujqDk9/WvSGE1Y87Izf93K/KNBg43oEzzX317GZx6VWUcYyUR4kAn
         FFAw==
X-Forwarded-Encrypted: i=1; AKwUvBzk2FbwXYF11cXFFNIeYkYJCMhn4PUxC+zB6YFmNf41t/nnfkAoqGGX4Byp9/R4/ZE2W8MqgOI=@vger.kernel.org
X-Gm-Message-State: AFuF++mDa8aHm9tR9dH7CwW5DpMi/SHdt2BNiCMGmazzEumJMTLf12Vw
	aEd2O+c97X3AOLMJBkhkHe2sbJPbUkUvJkKQHIYlNGyt1D3ag1c9htC8QkNcdZXN2qGcoDfUOMr
	Fr3xX8VPjgAYCZ8uDEFmQ3rtVy7n4KBnFUXKRVjmRACY5FtkQvq8anXfZfsMaSI2N+GBIfEouE9
	BCEqY5fZHtL0nTIux6EsvdMs1rkR0jZN9Z0Q==
X-Gm-Gg: AYBFou1Sg5j1hUCgOSIH/Zk7iQXygHYBzeypOERhM5XNLIQ2nx3eQ4p4YXTuSeedeyM
	FgbUsmP7Afe4TqGP8ncKSVmBarX2BnzvPFPYPcs0dZwtBioDVy2hVtMUjhgbfLGRG0YhGH/rx/N
	ilTMSU1s4KzhQe2nKLCgHh5WHDSP/9djjBCtIl5z1dD+/YiAzOEtzr4QiGtFE06OFr7Xc7b/WGZ
	N0+xEDbs+zwwN9Cj4cVOrWCyWP/BJxWNsI90bZVTF9WgisZ4muKYyJVOa7Y19iFi5CFElGmUws=
X-Received: by 2002:a05:620a:2547:b0:939:de6c:cb45 with SMTP id af79cd13be357-93e8f4e85bcmr105691585a.47.1791275416118;
        Tue, 06 Oct 2026 01:30:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2547:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93e8f4e85bcmr105684885a.47.1791275415318; Tue, 06 Oct 2026
 01:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006040422.3208888-1-peter.hunt@opengear.com> <20261006040422.3208888-2-peter.hunt@opengear.com>
In-Reply-To: <20261006040422.3208888-2-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:30:04 +0200
X-Gm-Features: AclHuK87YvCOucsoBPBbwhveceYERw5WYT0aIkBl1ttuymaYMtJY8H6CXMeK9NM
Message-ID: <CAFEp6-16BDkenpJBDsizvb8dGddXU+QzGuTv62v-hy-qtVbxGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] net: wwan: core: propagate modem control
 signals to port drivers
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, mani@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMyBTYWx0ZWRfX3LFGmU3pMP4V
 qt9kpI8gzqkg4bXlghFU6FWVTVtmvgQPgIItpoUIMe7Cf4/3e5d4dshK+HGFakENGfClZiVBqiz
 1Ts5olZTmtO3ELkZHklp6ny6RdOJ/+A=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac4b199 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=t2vznHeBAAAA:8 a=-ELhO9GzngQEtxseaSAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-ORIG-GUID: pcWsQI-u5OXYrDCoFgkzuH1R_Ymy-hGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMyBTYWx0ZWRfX6sySxSaxNN+f
 DpZ8+TgLZAU0G40BeexnVYV++tG+z+r3OKNwMxYFFAtHfQkaSwof1zKMaIxSk2NhRim4xSWzM++
 aT1VViP6HSifK7twO/xCnTJt7JcAhbjcxCo6al2i9Iv55W3+d46Jcji4CtrKmVJ2s78Rv/tIkv0
 KJyAiInyUTG6ro534MeA9wFBun8coO4sLU3JapGMCar26ZGRyS3s5x+/iMYlI61gt7ZAHpI5zhA
 O4WhkmWIoyLsIt0Agqj2vD5n3OklHJD/VbLsQ/O0F2MNHEC5h9MrzDq7o3j/AHKa18ToV6apKrx
 vyww36WV36/mZycL2ZFbrQ2F/FF1ax53kKCGO/Te0N2UfqbSIljKdDTq0Fds25gwS/ihX3jaYWN
 vz90flj9GVjFDvnl501idODBBahrhcxepsg/CjpQWR0j1xadyA8x6etPH0cMXuEY7weUH4zyRbJ
 8hPBrTuiUWAweiWVWtQ==
X-Proofpoint-GUID: pcWsQI-u5OXYrDCoFgkzuH1R_Ymy-hGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060033

Hi Peter,

On Tue, Oct 6, 2026 at 6:05=E2=80=AFAM Peter Hunt <peter.hunt@opengear.com>=
 wrote:
>
> The WWAN character device emulates the TTY modem-control ioctls
> (TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
> result is only stored in port->at_data.mdmbits and never reaches the port
> driver. A driver therefore cannot act on the host raising or dropping
> DTR/RTS, even though some modems depend on it (e.g. they withhold
> unsolicited AT result codes until the host asserts DTR).
>
> Add an optional ->dtr_rts(port, mdmbits) operation to struct wwan_port_op=
s.
> Drivers that implement it receive the full TIOCM bitmask so they can asse=
rt
> or de-assert DTR and RTS independently. The wwan core tracks the full TIO=
CM
> bitmask in port->at_data.mdmbits and calls ->dtr_rts when it changes, gat=
ed
> on WWAN_PORT_AT to match the open/close raise/drop behaviour.
>
> Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
> the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
> last close if HUPCL is set in the port's termios. This mirrors TTY
> semantics and means individual drivers do not need to implement this
> themselves. As on a TTY, HUPCL defaults to on for AT ports, and userspace
> can clear it with TCSETS to keep DTR asserted across close, for example s=
o
> that closing the port does not end a call on a modem set to AT&D1/AT&D2.
>
> at_data.mdmbits is protected by data_lock. In the ioctl path the ->dtr_rt=
s
> call is deferred until ops_lock is held, where mdmbits is re-read under
> data_lock, so the value passed to the driver always reflects the committe=
d
> bitmask under ops_lock and is serialised against concurrent ioctls and
> against port removal (which nulls port->ops under ops_lock).
>
> wwan_remove_port() also drops DTR/RTS before ->stop() when a port is
> removed while still open, regardless of HUPCL since the device is going
> away. Both drop paths share a helper and pass the driver the resulting
> bitmask.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
> ---
> v7: Drop DTR/RTS on last close only if HUPCL is set, and default HUPCL on
>     for AT ports. Pass the masked mdmbits rather than 0 from
>     wwan_remove_port(), via a helper shared with the close path. Both
>     from the Sashiko review of v6
> v6: Rebase onto net-next. Snapshot mdmbits under data_lock before calling
>     ->dtr_rts from wwan_port_op_start()/wwan_port_op_stop(), rather than
>     reading it after data_lock has been released
> v5: Change ->dtr_rts signature from bool to unsigned int mdmbits so DTR
>     and RTS can be driven independently; re-read mdmbits inside ops_lock
>     in the ioctl path to close a concurrent-ioctl ordering race; add
>     de-assert call to wwan_remove_port() for the hot-unplug case; update
>     kernel-doc to note the op is AT-only and describe the mdmbits argumen=
t
> v4: Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock;
>     release data_lock and acquire ops_lock with a NULL check before calli=
ng
>     ->dtr_rts from the ioctl path; gate ioctl ->dtr_rts on WWAN_PORT_AT t=
o
>     match open/close behaviour; reduce boolean to TIOCM_DTR only
> v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
>     on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
>     wwan_port_op_start/stop rather than in the driver (Loic Poulain)
> ---
>  drivers/net/wwan/wwan_core.c | 61 +++++++++++++++++++++++++++++++++++-
>  include/linux/wwan.h         |  3 ++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e68..eba4b0582b5a 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -655,6 +655,10 @@ struct wwan_port *wwan_create_port(struct device *pa=
rent,
>         init_waitqueue_head(&port->waitqueue);
>         mutex_init(&port->data_lock);
>
> +       /* AT ports hang up on last close by default, as a TTY does */
> +       if (type =3D=3D WWAN_PORT_AT)
> +               port->at_data.termios.c_cflag =3D HUPCL;
> +
>         port->dev.parent =3D &wwandev->dev;
>         port->dev.type =3D &wwan_port_dev_type;
>         dev_set_drvdata(&port->dev, drvdata);
> @@ -679,12 +683,34 @@ struct wwan_port *wwan_create_port(struct device *p=
arent,
>  }
>  EXPORT_SYMBOL_GPL(wwan_create_port);
>
> +/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
> + * the lines are only dropped if HUPCL is set, as for a TTY, on port
> + * removal they are always dropped.
> + */
> +static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_on=
ly)
> +{
> +       unsigned int bits;
> +
> +       mutex_lock(&port->data_lock);
> +       if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL)) {
> +               mutex_unlock(&port->data_lock);

Using (scoped) guard version would be simpler:
scoped_guard(mutex, &port->data_lock) {

> +               return;
> +       }
> +       port->at_data.mdmbits &=3D ~(TIOCM_DTR | TIOCM_RTS);
> +       bits =3D port->at_data.mdmbits;
> +       mutex_unlock(&port->data_lock);
> +
> +       port->ops->dtr_rts(port, bits);
> +}
> +
>  void wwan_remove_port(struct wwan_port *port)
>  {
>         struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
>
>         mutex_lock(&port->ops_lock);
>         if (port->start_count) {
> +               if (port->type =3D=3D WWAN_PORT_AT && port->ops->dtr_rts)

I would recommend checking for the dtr_rts callback in
wwan_port_drop_dtr_rts() rather than here.

> +                       wwan_port_drop_dtr_rts(port, false);
>                 port->ops->stop(port);
>                 port->start_count =3D 0;
>         }
> @@ -759,8 +785,20 @@ static int wwan_port_op_start(struct wwan_port *port=
)
>         if (!port->start_count)
>                 ret =3D port->ops->start(port);
>
> -       if (!ret)
> +       if (!ret) {
>                 port->start_count++;
> +               /* Mirror TTY semantics: raise DTR/RTS on first open of a=
n AT port */
> +               if (port->start_count =3D=3D 1 && port->type =3D=3D WWAN_=
PORT_AT &&
> +                   port->ops->dtr_rts) {
> +                       unsigned int bits;
> +
> +                       mutex_lock(&port->data_lock);
> +                       port->at_data.mdmbits |=3D TIOCM_DTR | TIOCM_RTS;
> +                       bits =3D port->at_data.mdmbits;
> +                       mutex_unlock(&port->data_lock);
> +                       port->ops->dtr_rts(port, bits);

Could we add a wwan_port_raise_dtr_rts() counterpart to
wwan_port_drop_dtr_rts() and move this AT/TTY-specific handling there?

> +               }
> +       }
>
>  out_unlock:
>         mutex_unlock(&port->ops_lock);
> @@ -773,6 +811,11 @@ static void wwan_port_op_stop(struct wwan_port *port=
)
>         mutex_lock(&port->ops_lock);
>         port->start_count--;
>         if (!port->start_count) {
> +               /* Mirror TTY semantics: drop DTR/RTS on last close of an=
 AT
> +                * port if HUPCL is set
> +                */
> +               if (port->ops && port->type =3D=3D WWAN_PORT_AT && port->=
ops->dtr_rts)
> +                       wwan_port_drop_dtr_rts(port, true);
>                 if (port->ops)
>                         port->ops->stop(port);
>                 skb_queue_purge(&port->rxq);
> @@ -980,6 +1023,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port=
 *port, unsigned int cmd,
>                                     unsigned long arg)
>  {
>         int ret =3D 0;
> +       bool call_dtr_rts =3D false;
>
>         mutex_lock(&port->data_lock);
>
> @@ -1036,6 +1080,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_por=
t *port, unsigned int cmd,
>                         port->at_data.mdmbits |=3D mdmbits;
>                 else
>                         port->at_data.mdmbits =3D mdmbits;
> +               if (port->type =3D=3D WWAN_PORT_AT)
> +                       call_dtr_rts =3D true;
>                 break;
>         }
>
> @@ -1061,6 +1107,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_po=
rt *port, unsigned int cmd,
>
>         mutex_unlock(&port->data_lock);
>
> +       if (call_dtr_rts) {
> +               unsigned int bits;
> +
> +               mutex_lock(&port->ops_lock);
> +               if (port->ops && port->ops->dtr_rts) {
> +                       mutex_lock(&port->data_lock);
> +                       bits =3D port->at_data.mdmbits;
> +                       mutex_unlock(&port->data_lock);
> +                       port->ops->dtr_rts(port, bits);
> +               }
> +               mutex_unlock(&port->ops_lock);
> +       }
> +
>         return ret;
>  }
>
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 1e0e2cb53579..57406139304e 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -57,6 +57,8 @@ struct wwan_port;
>   * @tx_blocking: Optional blocking routine that sends WWAN port protocol=
 data
>   *               to the device.
>   * @tx_poll: Optional routine that sets additional TX poll flags.
> + * @dtr_rts: Optional routine that updates the modem control lines to ma=
tch
> + *           @mdmbits (a TIOCM_* bitmask). Only called for WWAN_PORT_AT =
ports.
>   *
>   * The wwan_port_ops structure contains a list of low-level operations
>   * that control a WWAN port device. All functions are mandatory unless s=
pecified.
> @@ -70,6 +72,7 @@ struct wwan_port_ops {
>         int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
>         __poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
>                             poll_table *wait);
> +       void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
>  };
>
>  /** struct wwan_port_caps - The WWAN port capbilities
> --
> 2.43.0
>
