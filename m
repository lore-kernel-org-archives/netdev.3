Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71F4BA1C0
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472807; cv=pass; b=gT40a0x02F3CZ+2dAlVqCEi+pMRKzRVLOElFpymeeN6b7hvM1d6HoBbCzOCPexT+j7xePYIhb7WFlocgu9CRb8vUe0dPF7FE923uEzaiP9mTudgE5GaDh2ewHplkA5EVHIT5Lmly6s9TZvEarsIxCYFrDZzjPWMI8kpwROSDCKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472807; c=relaxed/simple;
	bh=Mtp5bsaUmX/s+WnZtwrAzzfDrBqtRRb5bfY+/bnQkEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPIjWzV7W5LRzLCzP63WISaohk609UgIdZVpPrXoklfrFYtsFFRKUC9vC/2vuyCgIb8F5k7b7ofoRR1w3skqQOIrsSgKht6aLdhb0gC/JyVJFgYvWuHv+pDNIjU1hQ+JGZUCd96R51d4Cdpb6EMRch3Ar9kUpJziN4jGEdSjFus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fs+5CIuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JGjK06ob; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fs+5CIuL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGjK06ob"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVaUg3641943
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 15:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xO6HRIbaR779RI13y+o0Nr/9NK+qGmYcAQOWWtcfvJ4=; b=fs+5CIuLFcpDjBzR
	at7VKHOxnae6JNHFqwD5XCNkJK7k72fyz7iYFNVpbSzZnKRkZw1iJMG+Yk/OEsNZ
	JusLXG/w5fQvrDfmW5xef1Cqf+zQmNAn+nzaH0Ezxj46mWENKiSQvBvg8ieJd+YZ
	8k+Pj1Quvgp3xTThwa0Mbw5vITg5VdzW1BoS3h1Y3tPsO91AUiKeXV837Q3BOpxI
	8fVCDHWrrehFgx03nm8/PsFV4lfywEZdNOb3MQCyna/a8meaVF4p0gl5el6DoDgY
	/N7XhXWpUIaLV+OdwRsirlE54/hzZb98jjVnk8kYQ3aX/+fyQyiBYNF2Edlz/GE4
	MiAhAg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe43gku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:20:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91256a7b7b3so91773726d6.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472800; cv=none;
        d=google.com; s=arc-20260327;
        b=VI6cs0tVpc+0Df88fhG9wJbtUucrLJlU5WEkpAwp3fj12AXUz1uwiHRXS/Fdv4bQQd
         cJZBQfLDwww+UDInODMZlKnijUJHz7g1I7CstFy/rIapsMLoDmOt4rI2GM/WiXRd2NSC
         H2ttxn36kabTvb8oqqTuRpAJr8mvml9/ZYSFxqDDlmEK3MiLfwZhEhnHQgNiMVvnkKWC
         TCNs5cvEjV6QWYPxbkiEmlFmU5la1gbg2pn2W7ECovmJFvoUgY+lgJrnjiin2DfjuI36
         FDxBL5ZSZyaws5IUS7N66AEpXGINjDgwM7ZTpl9/k0nJQ0RGUHZWRY4oPrgqlv7h+TIv
         gvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xO6HRIbaR779RI13y+o0Nr/9NK+qGmYcAQOWWtcfvJ4=;
        fh=ElJEnkumHD0GNqRPJWh61agkzUaNjx80UEkM/lB7Pe4=;
        b=FL10mOcqExYv23ZwICccYUAzrPkXaxKAV6B7jNG+RNNgMFpYNQt8GAqV6WPeSnhtV1
         Em7mVVtO9KZs2nWiR81rIoGcCzxF2GETLyjXO3dgPvrAdx8cH9qu5OHcjCQmk8wcaYU3
         u1myuml35SqrzOGUpIWHlRaqjPHnCtllqOs0DxPQK9UlwrNocBhPrjqLXgR4Mru6/EB/
         iCN+sHRtXTM2Ri3R22oSftsACuAx+0oz7m+26UGlMuMlCgE9SMfbsVTjg1+XlJ+5IYK7
         XMMsaKiDhxnv9nx9qVYqwFtoqEJcfYJzYyuJuLvErJ5OOKLZGGVCQTuJ+hu/ZDf+QmfO
         uUyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791472800; x=1792077600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xO6HRIbaR779RI13y+o0Nr/9NK+qGmYcAQOWWtcfvJ4=;
        b=JGjK06obGWcsx/dxGV2QE2EhozdlxEohmpjAq4G//d9XpliLh6dSSXoxHuqtv9Xsh/
         8gkIlCtOTu6zWYKIrW1Wc0GJaREGqudibPIctjLGKIFFGHb6SxamRM0B88EHAArc3uvW
         LgQwrYeWSe5MiQ4wDVb8oBUbemt0NS1OjVL/Qy87hB8yXXd/OhpdZlJjbJPmY9IpEvIk
         B9Exp4tW9MMUFCN15wF2or4m2u2qXlZ52EJL46PC+ssx9R/0hZ803V8V3PGVjMyqLOLz
         qGxuEAJ9s1aLGp+5gouuEsX0noxZQh6j6GyThl8eJtvX3l9xyLGVcsuwMSUYWuLJfdcq
         q8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472800; x=1792077600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xO6HRIbaR779RI13y+o0Nr/9NK+qGmYcAQOWWtcfvJ4=;
        b=NRf3Q2ECmEQ0kwEId2O5hh/d4qJCGdqVokNRJeUT/9BsLmQ5+N9DPjuzbOgfzAANG/
         gdBejhZkaZ7qE4sWkTkTyqf9y6TycNHEn3HpTS7mBS8TBgNt3Q37Ga6Gn+tkEuyl2p3N
         XJqRox0SPsr3jqwNdRb1LTU4ae++q2eO4aiZKReky6yLY9mMTuTBxNX1D4IZDVXsxHyl
         lx6rPjCC8SMArb5p57As76Yu5uwHd0y9GG87teLHLTNNybZYzwRv1cDvS6bf1Yd7rM+Z
         v5ilbtSAu0UWWQPf1csbYa/PBOZCaH3o2YQSDr6vjHqLipTX3xcdFieeAUSe9k+ABsPp
         xtQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcGHQ+IHcqh0bMWJtEinieJi2IGfeZw1a854HmUy0a6JwMITO1VW2Zx9Vomz81jalK75eAj/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kXxa+lDeF/gvoEsaa/Brcl/tEyUkYIrkp/AkjQ676q2FJW05+U
	3n103ZP1Ua8q72F22xLFKZccnUGdxmtZ0/R6H9SJvW0rwrq2MF1ViB0vANS7v6Nfjcka1AyVYpD
	8pU+hwjYeSGKy0JsvUi1nCSPM/XS1jz43Adh1eVVEdce9vdo13SGru15TUVZngaUYLkvFSdyepS
	0/LO6G3Ujpyry8payTEExkb7CEqDOXCR2AdA==
X-Gm-Gg: AYBFou1ue+Tj6j6PGZZfmn2dB951bTyAa+ZbYQ2LoFBjAOxJwmu5WvR/e2knkigCm8L
	YtR8Q+/j67sbQHF9M0JjKUg227nCOIbQFmbfcnn2qY1nfX2k06rvEo/2jA9ExfoK7gR5qtb/5mC
	2R6gbDcnU0TIGpQjy9DQO+vmYRDcjf9k3jrmRiWTyH4cJPfH8vBsX1uVym/ctZuQ+eGcPBVQnvi
	vdf6Dvi1+gRJB7Fz4mdxwi0Ov28AXx5OqYfLZzVQrNku/f5GD0/d56evK+ArplYGbGkkyQ7yes=
X-Received: by 2002:a05:6214:5d13:b0:912:488d:33ac with SMTP id 6a1803df08f44-919979319efmr107076206d6.17.1791472799542;
        Thu, 08 Oct 2026 08:19:59 -0700 (PDT)
X-Received: by 2002:a05:6214:5d13:b0:912:488d:33ac with SMTP id
 6a1803df08f44-919979319efmr107075616d6.17.1791472798756; Thu, 08 Oct 2026
 08:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007182238.1154851-1-peter.hunt@opengear.com> <20261007182238.1154851-2-peter.hunt@opengear.com>
In-Reply-To: <20261007182238.1154851-2-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:19:45 +0200
X-Gm-Features: AclHuK93Uq-IFjmeH-9lFHtazJbB-UGdgh5WgvVUomru_SE4CNqvEhX_yndO9b8
Message-ID: <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control
 signals to port drivers
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, mani@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: rOJ_awRPHYCENDXnebMHXaQ_-qazIaAa
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac7b4a0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=t2vznHeBAAAA:8 a=yR1rUuH2P9_sZCukppcA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MSBTYWx0ZWRfX2tlZp2tboKFL
 kAgQJk5rDOrSzCyECIOsO1d8WAbaRbEFeLudct8sOK5r4P0mRJM304HK0f+Socrv8sDciU6iqA0
 SQBP2Kqq2aCKM+OgRYr4hbPc0akuXJY=
X-Proofpoint-ORIG-GUID: rOJ_awRPHYCENDXnebMHXaQ_-qazIaAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MSBTYWx0ZWRfX/omSqr3qEFai
 NvB1kAbiWJuS7HunJSoYDFYWga0tAtjIsVf5pdb3ExU6b3TvVbIDubbAAS5DW2idTdGMoxrbhS6
 BWHWl1JI5Rs8wi5Ns9jCZdFd+WNPzWtBX5xGwowr0XWiwKBA//QNPEdBziHz3kIrdbBwHCy7WVl
 wbQT6Gpdf8zWPynRznrQF8C/bmM1Jh26criWiihB6XCfYE4k7eO3kUyq1Bj9waGFWmaIZ68qySG
 4GdiMPhTMhPN0txmwIvTdPtCf1i0m8InUGuLPpjav2p3Pk4cAnJJ/VPnlOst0M0FTd5KDbPv0ZX
 IVkfVddsX7zm9FrwEwgH4Gd3jgefL8vjnTUjMpbD9n/V6XKqApT41YyP3Fi9RC3C011+EJOUywa
 pjMTQorFAwocGRTKGGZhLWxIfK8XcgzGxerZA9ny4ltu/D4L2dh2zYQ07yq7j2x2a2kEYi2O0Is
 DX3IW618SNDhEBHuqmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080061

Hi Peter,

On Wed, Oct 7, 2026 at 8:23=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com>=
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
> away. The raise and drop paths go through two small helpers, which do
> the AT port and ->dtr_rts checks and pass the driver the resulting
> bitmask.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
> ---
> v8: Add wwan_port_raise_dtr_rts() as the counterpart of
>     wwan_port_drop_dtr_rts() and move the open-path handling there, move
>     the AT port and ->dtr_rts checks into both helpers, use
>     scoped_guard() for data_lock (Loic Poulain)
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
>  drivers/net/wwan/wwan_core.c | 69 ++++++++++++++++++++++++++++++++++--
>  include/linux/wwan.h         |  3 ++
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e68..4206649d4b45 100644
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
> @@ -679,12 +683,52 @@ struct wwan_port *wwan_create_port(struct device *p=
arent,
>  }
>  EXPORT_SYMBOL_GPL(wwan_create_port);
>
> +/* Raise DTR/RTS on first open of an AT port, as a TTY does. Called with
> + * ops_lock held.
> + */
> +static void wwan_port_raise_dtr_rts(struct wwan_port *port)
> +{
> +       unsigned int bits;
> +
> +       if (port->type !=3D WWAN_PORT_AT || !port->ops->dtr_rts)
> +               return;
> +
> +       scoped_guard(mutex, &port->data_lock) {
> +               port->at_data.mdmbits |=3D TIOCM_DTR | TIOCM_RTS;
> +               bits =3D port->at_data.mdmbits;
> +       }
> +
> +       port->ops->dtr_rts(port, bits);
> +}
> +
> +/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
> + * the lines are only dropped if HUPCL is set, as for a TTY, on port
> + * removal they are always dropped.
> + */
> +static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_on=
ly)
> +{
> +       unsigned int bits;
> +
> +       if (port->type !=3D WWAN_PORT_AT || !port->ops->dtr_rts)
> +               return;
> +
> +       scoped_guard(mutex, &port->data_lock) {
> +               if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL=
))
> +                       return;
> +               port->at_data.mdmbits &=3D ~(TIOCM_DTR | TIOCM_RTS);
> +               bits =3D port->at_data.mdmbits;
> +       }
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
> +               wwan_port_drop_dtr_rts(port, false);
>                 port->ops->stop(port);
>                 port->start_count =3D 0;
>         }
> @@ -759,8 +803,11 @@ static int wwan_port_op_start(struct wwan_port *port=
)
>         if (!port->start_count)
>                 ret =3D port->ops->start(port);
>
> -       if (!ret)
> +       if (!ret) {
>                 port->start_count++;
> +               if (port->start_count =3D=3D 1)

You basically have the same check above
> +                       wwan_port_raise_dtr_rts(port);
> +       }
>
>  out_unlock:
>         mutex_unlock(&port->ops_lock);
> @@ -773,8 +820,10 @@ static void wwan_port_op_stop(struct wwan_port *port=
)
>         mutex_lock(&port->ops_lock);
>         port->start_count--;
>         if (!port->start_count) {
> -               if (port->ops)
> +               if (port->ops) {
> +                       wwan_port_drop_dtr_rts(port, true);
>                         port->ops->stop(port);
> +               }
>                 skb_queue_purge(&port->rxq);
>                 clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
>         }
> @@ -980,6 +1029,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port=
 *port, unsigned int cmd,
>                                     unsigned long arg)
>  {
>         int ret =3D 0;
> +       bool call_dtr_rts =3D false;
>
>         mutex_lock(&port->data_lock);
>
> @@ -1036,6 +1086,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_por=
t *port, unsigned int cmd,
>                         port->at_data.mdmbits |=3D mdmbits;
>                 else
>                         port->at_data.mdmbits =3D mdmbits;
> +               if (port->type =3D=3D WWAN_PORT_AT)
> +                       call_dtr_rts =3D true;

Any reason not to just call dtr_rts() whenever the callback is implemented?

>                 break;
>         }
>
> @@ -1061,6 +1113,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_po=
rt *port, unsigned int cmd,
>
>         mutex_unlock(&port->data_lock);
>
> +       if (call_dtr_rts) {
> +               unsigned int bits;
> +
> +               mutex_lock(&port->ops_lock);

So now we end up with two mutexes essentially protecting the same
state. Since dtr_rts() is always called under ops_lock, and the ioctl
path acquires both ops_lock and data_lock, would it make sense to drop
data_lock altogether and rely solely on ops_lock? That would also
allow the ioctl handling to be fully covered by guarded ops_lock
mutex, simplifying the locking scheme.

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
