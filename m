Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11516450404
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807330; cv=pass; b=Fqd6x9aiBPR5pkYKiHtuTiLnoV+01RwxY7wGbPZx1zY96hspdf80dTZGTv79LRXSY8XuYHS4O4d0MXseap+mcDBGInDqH3rX1t6S5T+0WZ5miV29fEO6KdobCdCVi2Q0vhRUz0HZ6BmBzmneheFHU7Sn8xh1IqTvtvLkt1X9/mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807330; c=relaxed/simple;
	bh=XkD4CR8PxcyIMPcQRsfJGKsjJYowH3YGB0feBNav0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpKksA8sLJF7ctTaSIMLH5cgExLnp/nxy4xSqzdgs88/rjLh3RE8MCJnrBtj7b5WNYQ6Zoi8jVu7wl48nzLscFL+CxHUigKOS+zauAIVEQQX0nniBvWCYkcSHrF5ze+XY3GTifUikKLcQIub2jhY6rMFHJsKmiNlff2snrrNPIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIgjJlun; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fX4J31/w; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIgjJlun";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fX4J31/w"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBxvnW800781
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mAGbpjDVZXSMGOmCLh8Gakvmpa7MrQxMwP/ilqdTzSw=; b=iIgjJlunebaL+dQl
	y7kyAnjPWPQyVlo/xPz7GIFkfZwEikr1zOuPIKSPYaLj2MtDHc1fdFB8f8op6wLW
	+XMplFk5+Z7AG/jH9ZuL2TiFzMPP32hMGXSdfS3lnuyq/QzPeecOx44JYznM0IQH
	Y05Esm7GtzezMV7x/ugGG37oRlDmgeWBqjUf9QJgdGl5QU+MQ0MJEShQEI3MpopY
	Kh22adoL4j3mzdXhgg2zOoQxIYBXT0260kg3Ri3iozM5FeIa8lQ39KhkRkJ8ufu4
	asQXAmQZl9IqLL1TX4ixiUNYH8p4PmLogxZ9ZQj/y0R2aEuC0LAieJO3S7XcdBo8
	pAxgzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfcrkux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:15:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc0b31ecaso385956685a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791807327; cv=none;
        d=google.com; s=arc-20260327;
        b=j0JSrPK5Nvz6Q3vtEIpCnkDLjgozoYuxc5m6ZPIRckVab1Hcq6bw+KaGysRMLllNOv
         46oa7YMYnIQXopuF61JC7OvXt4Ge7eBbWUohuYYwa3QQkNldpyreJoqxCjHrkfv5cIVf
         AvLdxbNKlMTc6k4Nczpc9osFotXjXQB0sHE90rwTnsJi2ak+/SDL652Au8Jsi+bKkMV6
         9QuxSnjZi2HaLN1tNfC642IWZUPSBU43Xk1oH/IaFAlo/jVFaljJVGYoSo5dI1cBN8F3
         q19YUbPlm9zCdg7Twbss1qIYujGKSWDC1rElpxBaaAQdUSR6qlSP/arp67AnrgpXbtct
         L96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAGbpjDVZXSMGOmCLh8Gakvmpa7MrQxMwP/ilqdTzSw=;
        fh=vkaRuI7c5/wAPQOB7eJoCljSqsp1pLkSxgFK3vVWtAE=;
        b=nAtsG/gguK7cr7cswnSiqhhVw1LkOJmcKRz/FCE5wJ/0TkYum7yhNv/YMX8uVfHOYP
         Tin8l4+DBvPYHuJ4CwkloW88PLigSvOd64Yv9luZPBgDd1Y0bxFS862cjh1Ml4bvnmMu
         cEW8z8BUrGtRANbFvRXqNo9jicW+ebv629eyVp2hzMUzNWd3SUs5ED4Lr2XTwYDt4Ehh
         /1l/LW1Rk22wW5d74eWwnFzEPYNpHnayGVm9YP1zGgK9JpgmOLSDczo9rzacTbVdDhIC
         hGb3ZXSFf158YKV4+R8Zvrh7uGXqr7H/VUws+SUfDWhR+m3COTn+VLas/GysKzKPaRZa
         +//g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791807327; x=1792412127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAGbpjDVZXSMGOmCLh8Gakvmpa7MrQxMwP/ilqdTzSw=;
        b=fX4J31/wTn3SmTMewUibp7AM5dsssYWJW2OHT0s6p5Gws4BaoW2Sq99szkOaUTY/bf
         RB3l7wUS+H3XNjjisl2xyDmZetC1hJxbvhTedI0zt1agmOa/OlfaJ1rahKYKwnp8U8FZ
         qLyc5+vUmTiKOHLahKKCRtVcntM5Xk+NNZy/+8bbX3ja/68OWukgoNSCUDtkOxd42i+z
         SQ9JVyuFp/JxxUPC09DymkHaVrOg0IsOou6Gs8xkPmd/1VR0yY3nUV26woQd9Z2U03Qg
         boMr4IK4ToDiAgG3SX+6NpDm7/bbZH8xxcrBS0Lx2ysAgzEN0dBNHJGHskUfC7rVgts8
         afkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791807327; x=1792412127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAGbpjDVZXSMGOmCLh8Gakvmpa7MrQxMwP/ilqdTzSw=;
        b=SfwpoISDuGC/9mgfS9yu5NZzAkzQtASE/ly75ahVpAGOcctkJNrwIsi36fLIqISpnN
         0YLOzb9xBjHYv2DYUB0PwhWxaLdsoaF15a/91T+jkfKN9zXlAOpAoVAAC0JFMb4bY8BO
         9pUJNcftWwN7SGSBHoQSUNxEp6MLLSCMik/eEak85tbuVRiHbuSaGqmbHUBuX/560J0i
         sW/6PrIOp1L/Fwain3RI3pxP7uB3Emo/fgW4qBhrRWJ3gQXFl9mkVyStM6522LbjyASJ
         3dAS03b8nSCqAYZmFGCmKUqlu3AZxwXlCDP6bpVwkW35D5TzD4J1JWdloig0O8XMhQvN
         hmNw==
X-Forwarded-Encrypted: i=1; AKwUvBwTBn3USJpeEMq4v8AaK3zjV91gyq+inzb0AlXWZTVAIa9/DYyopD6zATPoqpQKjezg9gcb8Xg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIivHGXIzL8RrpRijcNA1S02MgTzHKvOBO6qRrKuBNsbDYvpL1Q
	WmYcgiPf4+iBCPEE1JJNZxshNFtBzgnPOXyL8LkQA7BX+XJ5eXyusgXxgQbfAZI7nzshfpGgWqn
	BhBtU/JDT8E7f6fGaTmj/s9Vb8+NA6VjjgIDIJFL4H7j4BJFiRiYGOxd+JW+7t/srky7Q5QlaI1
	0HsAJB08ki1BGk6UquMdE8O2N+UWoZMS06yw==
X-Gm-Gg: AYBFou0Cur/eHrkOezJQUt+m4rgq5iRB6d+KgpaqCSXC9iH/VAuJEBmwIYsO/Iu5moB
	dHt7PhueLQUfShtivB+E7vtmjuWEX56CTK4Ej/DB9Zl+L6dNgRACN+Xhycel8mX9c0IW4+sfvLZ
	unyrlf7jmjns/ZBRyjNMIwY+y8YROaRMFYdFQDIVDfWHnrT8bTsFN1T5LeI3NOLjDp4iSKxhMMZ
	Cfml4qulODvOhyOsnuarHUF2BXi9HDOPJElqla7zfmZ1vGe6zuPfRlZDqq5IhgJeZFC9A9PlIq6
X-Received: by 2002:a05:620a:224d:20b0:93e:c619:92ef with SMTP id af79cd13be357-93ec61994afmr1003156985a.42.1791807327012;
        Mon, 12 Oct 2026 05:15:27 -0700 (PDT)
X-Received: by 2002:a05:620a:224d:20b0:93e:c619:92ef with SMTP id
 af79cd13be357-93ec61994afmr1003152785a.42.1791807326529; Mon, 12 Oct 2026
 05:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007182238.1154851-2-peter.hunt@opengear.com>
 <CAFEp6-2QsKyZfEdSotVPhxVNOyRzncUphqLY5cRwHXGJiEbzuA@mail.gmail.com>
 <20261009001714.1078580-1-peter.hunt@opengear.com> <20261010171531.1659006-1-peter.hunt@opengear.com>
In-Reply-To: <20261010171531.1659006-1-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 14:15:14 +0200
X-Gm-Features: AclHuK86CgairrG5EnLwkN2ULrA7W0dmSP8kvp0UdVoDkSumbBYBiXSg3WaZPEY
Message-ID: <CAFEp6-0vuU2sy3pfgyprMMiLOaKCoZMQN=nHQ+dQR1ku9dbwkw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control
 signals to port drivers
To: Peter Hunt <peter.hunt@opengear.com>
Cc: Daniele Palmas <dnlplm@gmail.com>, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: T8n1bF6r2-mRgfs8qqfUZniXotG6VdlR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX/phgoRgJyVsU
 jVPspVz+jRYihSX+8ODe80F4pei1ADiebYu7OTeoDBZ3hutP2Rlt0TxbQAkeEGb47ugRhyrPksX
 fzcz+g/GExe2URQ3q3W/TT1WBbdkhd0=
X-Proofpoint-ORIG-GUID: T8n1bF6r2-mRgfs8qqfUZniXotG6VdlR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfXxSRxB++fmFcI
 xL0EvgSsChLj76H88o/q/Jb6n4aQTxmJ9ra6eyrwabAAkmcTq7WjBOYxDX+QsTtW4TtJA6mYgvt
 45Iou/focgxVGGwF5X7IzrSxa5Nn+8rAV6H+jnbc8KPE6Z+5laYwzOccRtTDQhUrbxdY8/ByDqY
 5Ejp+TWij+w4KYio9PeFb5KvIpepH1Asg9b1vowaZvuHBZFOpAufruADzYB95NyrQEVanQNHQyD
 MAD+ZeAF69dbzDCCf+Xu5QRDElJWKyBcu4qM+sKSz8jYZu/u9DqYVJ2F196BXjxEaep3F3ir4pY
 kEZRPqrbMqVYCll8WDr22VbeaRr/XNbf/hSb/hZ3WH0NeV3D9elZnOu8nCYjYSAnbXvuRXD4Dj7
 04iSKMn6LWvwJdPhrxzSgp+JdWZLepxhyrA22VaCu/0hylWdJzVBc6Thl3jw3Tsqe6H5XAiXU9G
 oZ02GiiQ/5mrm0E6Gyw==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acccf60 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=t2vznHeBAAAA:8 a=088zT0Ob94ooJFCwm_YA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120048

Hi Peter,

On Sat, Oct 10, 2026 at 7:16=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> Hi Loic,
>
> A follow-up to my reply, as I overstated one point and would rather ask
> than argue on both. (Adding Daniele, as the first question touches his
> recent QCDM ioctl work.)
>
> On the AT-only check: I said QCDM has no DTR semantics, but I don't
> actually know that. I've only verified DTR/RTS on the AT (DUN) port of a
> Sierra EM9291. I don't know whether the DIAG channel behind QCDM ports
> honours DTR on these modems, or whether libqcdm relies on it now that
> QCDM ports have the TIOCM ioctls. So I see two options:
>
>   a) Keep it AT-only in all four places (open, close, removal, ioctl).
>   b) Call ->dtr_rts for any port with the TIOCM ioctls (AT and QCDM)
>      whenever the driver implements it, again in all four places, and
>      leave it to the driver to ignore ports where it doesn't apply.
>
> Which would you prefer? If you or Daniele know that QCDM/DIAG ports
> care about DTR, that would settle it for b).

I think we can go with option a) for now. The documentation I have
only references virtual RS-232 control signals for DUN, and we can
always revisit this later if additional use cases arise.

>
> On the locking: I agree the data_lock/ops_lock split is awkward, and
> it's this series that made the two locks interact. Most of the races
> found in earlier versions came from it. My only concern is the blocking
> write case I mentioned, so the options as I see them are:
>
>   a) Use only ops_lock, with the whole ioctl handler under a guard and
>      mutex_lock_interruptible() so a waiting ioctl can be interrupted,
>      accepting the wait behind a blocking write on rpmsg ports.
>   b) Keep data_lock for the termios/TIOCM state and take ops_lock,
>      interruptibly, only around the ->dtr_rts call. v9 already limits
>      that to when DTR or RTS actually changes.
>
> I'm happy to do either in v9, which do you prefer?

I would also lean toward option a). We may want more fine-grained
locking in the future, particularly given the blocking write path, but
I think the current approach is acceptable for now.

Regards,
Loic
