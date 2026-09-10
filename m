Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D414373BE6
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028446; cv=pass; b=CmBWGLIHhIJompfqe0IqIP9L4Hib2lDd7/eqvHUVhxek/TRwpfrLVaDLgsIB/Ti+PAXHHoTU6VpRUwioRVHivz+PwnHtWKI5+KoF0C0vsNzeVdp1yaoyzqOigrgZkjePaflrg5Tb5KECTknhJquBwZiw/xD0C14Q2oznzcleWDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028446; c=relaxed/simple;
	bh=WvmQjKnGuI0dGsnyCGxoMDIHpfNF476NUnQtUUHZ7Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9Qir979iYno9CL4EbE6UNPg9nmmC/8++YIQoNIiRZRny+q334bYULcl4J8l3gsUGCtOVIdDQ7COmK6MixOCZTvmovuymGMg54JbAuEEUuoPY/yFzyutDdO7MpE+6IJanFipD+y6kAJkZxyQV0gkgGF4Um6Z4grc2owIitt+BsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMVmnSIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnKDz7Xs; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMVmnSIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnKDz7Xs"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gs63810342
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=; b=WMVmnSIUNnQMnz+G
	E9htb2pX1Xxykkf68zC7TAYJgyqUHA1f3o5ozjQ8z7p2MSpQxex3q5ed/RPjsYEi
	1V1FpicOGtHk6bxkUR84+7y6ixvBxPCo29gDlr8JW+i5SRxPuCBok446iWdXJvRB
	mde5/iWYIa4j0QfcqhxfGSJFDptmxM9KeydmOXGnVjixZvS0bVsy/SAB0adwsoyN
	eIWPN+tjQ7fvKnHcoFy8yBM826WJfVogBgQzKfXHoLpcMazXnPgq/8xATJowU7Up
	v81UceUP+o2B3qNBVWkIVvSBh94v0Tg59/bLIQat7ZOvwyAjSAgMN/XgaXZU7w4C
	/777LA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydju25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:20:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-933023a5980so725678385a.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789028444; cv=none;
        d=google.com; s=arc-20260327;
        b=QNv3J4KvrTRC4/H5mZ+o+ENKS/Zum1nZ9c+pGK5YEo4TWirXNlo5J53+TKk5B6o76e
         XQbTIax6z9acAdv3We7FsrENmytebiyYrwJOeoUO01JxzNAurtDCk8rMMIwMVCBzvMLc
         WBVpjnruiFQoVjil5mmuqQhGuhTAC3n+asC4+RlLnSROhKcNWcALhPyKOvwzqE1riCRl
         wcNG3Dx56ynmWBBzQX4Ez+x9+VtHpTvpNToT0Hf+B7GdO0tz01v1b2ziEF5X0SZclDg0
         obh5ic/kt84cuQqpuu2e04Jpc0M8ghFwhVWt9YNredd39lYoax1esQpuFTJBh/GBdrSD
         ojKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        fh=4745yHFPoSQ5d0dhfwRfWJk/EGg9+0VUHiH2pXAsjMM=;
        b=Fbkz88UoppzweqEaEf6C/HYPbUrHr+/p5yCyF7nT/WToFx+9g9CirT734MQNv++8WB
         sgN/k9UFE23cHFK6fWNOPD/atN5k85flQftudDS0GQnCtcwGja5taxGW32RWwkD1wgbK
         OTIYwJ1X9IinhK664I9sieBpEnlR5jGP4Zdsq5eHKqeAddZkYIe46R+APgBrcvnsL0pQ
         H6piw5O2oxegAIbU81StxzsjfkF37pNUkevMToaw69SgSxHbrJtNpS26U8FKa/l9r2Fr
         Drbhvl0PMsXI+YhE/2Z55MxHmk6MMBxUbxcTdcH83CqCXi7ngSel8IqSdv9wcahudvyO
         gHMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789028444; x=1789633244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        b=FnKDz7XsWnpHfQoQtuFbl0A0VIepqmBwaXRxiLziQRRwGskfddSAB9MBRzJZQ9LqI3
         31eIvbWf6+hZthLm1TQvPtRvsKJNrDq7lI8tUMIDyy8mCeVX62+VVjB4ykF+bz5RmBiL
         CWTPpGcaN8BNcbvyDiuh7C3dlKN+UWARPzci1QMzFJIoYXix1VEbel+QgeuW8sEwQ5nL
         Ij5QAkYzZXtoK0M/DRMxqOeUPW08reO1lUAGdbcXf3STHIEKrqS7zGItk42FAMmm+Aio
         j5MTsIPWmqAZyO++V69gzbBleiOnn7h3MZYerlt3Pska7CGFEjFr6S8Nfc89N0PifAnL
         /T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789028444; x=1789633244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvo+gJKJcdSTFsytJP4C9fn/vpgKCrfkkU2F3RLp2rM=;
        b=JDiXlWcfAu5RQLJq4s3K+bz2SV5pL43QpZzaM1tyJY8Se1YKe2gR7Drx76IdARxhkJ
         vpQpxQD9M2WP8nNWc5NV54CDjVOwPXm2abI7OtIBf1JBLtEe01lGgR5Oa2v+MXkOKtBk
         c5Cuuw9AervAx8Ptr/Ctz+NiuaeqdlTomxunp3DotQcEPiC7dUbb2FOeliFTHnv4CvqJ
         S75RIwQ3xYgWwg3HkyMouLJs6YO9g9FoDQw01/6PSpu1MfwlT2ALVVMEeA6VjOTazfHn
         7OMk+y3zRd0z+14C1A9haWdavX+4JEskMIti1OOWFL5tfCHczpXTGh63Ttvf83STzqWu
         eQ4w==
X-Forwarded-Encrypted: i=1; AKwUvBzJFNrb6CZUCKwrbOu5eoNBWV0Ei4vyrSVnwcRj+ayxqHWoPazkmC0nvwK7DZHngWW00Px5aE4=@vger.kernel.org
X-Gm-Message-State: AFuF++noXRepNyGCo9ZPFpC3rqSSTRw1tc1UTcuVCZdQYQkue/94tMDZ
	1mWIC3vK2G/2xnpg6vdjCXZRQpOUCqgxQVo6E7PEImkCJQkrCdXYjrpgQxwlhUMUWXt7Z3wb+xA
	Sw60ZsJvB/jG3epUUNGFxnavxt072KZj9nhVlPkFkNrEW2wvPa2aLNeozgpBhZ3fgibgEl5BSYw
	AL4z6jT6VSwY7gfbo4RxAAB/jzu+gyW+Xbfg==
X-Gm-Gg: AYBFou180VKkRWeu6jjlwkxEo7+0PJ8IDqUJf0+ArbtNFgHtGLMcOYfIiSLg3tGM6h9
	eyBpbboDF5liD4lI/HwwPj5fcAbpq0pwmxteNI9lxmV9fArH1BAfir4HJL9AthoVEwVkkwRb5oL
	66s/bT8df3VgFUyPGPuZcBxNpQ77yRtsTowSwmUNvhJU/FvU9Z6WMuHmn+Y9BUNa2mbVl30fyvy
	NcweD86pA2qmU7fsDHLS8sdq2JhGWCFs5aSSeCODnzPKneKQHE9W3wlcNib429H/REVYWIaBhMR
X-Received: by 2002:a05:620a:4389:b0:939:6de8:43db with SMTP id af79cd13be357-939804d76e4mr4288469285a.47.1789028443710;
        Thu, 10 Sep 2026 01:20:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4389:b0:939:6de8:43db with SMTP id
 af79cd13be357-939804d76e4mr4288463985a.47.1789028443258; Thu, 10 Sep 2026
 01:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
In-Reply-To: <20260910033356.1052661-1-zhugl3@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:20:31 +0200
X-Gm-Features: AcwNN1UxpGXbZOkTtYTEFpfk69pJe6c5Zo9ztfNY-JIQ24mBlchhctEeZIV-neA
Message-ID: <CAFEp6-3QOiY27ViJKtSbXZs4fBDQ7pVr3T0V4Q7ERnmUw0jjOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5MiBTYWx0ZWRfX96so7bc2G5oI
 3iiK2uGcOvPoViaE1asAu1UtBSstFFPXImox1taGPLeOxaQW1RJ2ej2xpzioFx9wiLeZlivfJQE
 d7wt1zsgkGkHgoKldQxZnnVYkEtPR1Y=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa2685c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=bSoUDPcfU04rEmEJkLgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-GUID: nGmSJCorIPa899AZaDNCXteVwfbHYXJn
X-Proofpoint-ORIG-GUID: nGmSJCorIPa899AZaDNCXteVwfbHYXJn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5MiBTYWx0ZWRfXw7zN+rZmYyBx
 AdjQNleAtS8XdPaKFkEEbrQDYIE6Q/4vrN3OC/BQu8ygr+QYaAmtHHt/Nn0mn+Lj4eS7CyMiwYJ
 /EiOzQLZOEZdNyBpjrkCXY5+T/ozpKTXyK+yeH+nr56xF+FzJ5FLUA8gIKM2nIxXfNOXrCeQLcG
 BfSVS1x6eG7XpIIUtX+HcDLXpCJLYgGZNVYjUJG4qpabRsIGDhYmRQbX9ZSyLPwVGpP11Vjhm9K
 RONYHYDBT6KhRq3+UhoQQ5u2BcUIAC6KpO6RwYqOsDDiShOjz+2/W0oPG5hM+d0oL5Rudpfmcw7
 gd1of06HSdnsEaWgX51rDe79woQ2U2u4iWdWi6OoHncGhvTbcjI08ON0VGjKoBjOx2YI77nmegk
 8PMcKW+TY8t45yqonUms5aneo4lgko3M+rbhP7g9CnluEYUpvkSbKoOdKcZLl9qaL/95YGg1T/3
 By1DF55Xi4ifCFe70Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100092

On Thu, Sep 10, 2026 at 5:34=E2=80=AFAM Guanglei Zhu <zhugl3@xiaopeng.com> =
wrote:
>
> The NDP traversal in mhi_mbim_rx() only stops when wNextNdpIndex is
> zero.  Nothing requires the offsets to advance, so a modem that
> points an NDP at itself, or at an earlier NDP, keeps the loop
> spinning forever on one CPU.
>
> Break out when the next NDP offset is not larger than the current
> one.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>
> Verified in a QEMU guest with a fault injector feeding the driver's
> receive callback an NTB whose single NDP points at itself: the
> unpatched driver spins in mhi_mbim_rx() with one CPU pinned at 100%
> and the thread never returns.  With this check the loop terminates
> within one iteration.
>  drivers/net/wwan/mhi_wwan_mbim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index a94998712..ef158edeb 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -254,6 +254,7 @@ static int mbim_rx_verify_ndp16(struct sk_buff *skb, =
struct usb_cdc_ncm_ndp16 *n
>  static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *s=
kb)
>  {
>         int ndpoffset;
> +       int last_ndpoffset =3D 0;
>
>         /* Check NTB header and retrieve first NDP offset */
>         ndpoffset =3D mbim_rx_verify_nth16(mbim, skb);
> @@ -265,6 +266,13 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbi=
m, struct sk_buff *skb)
>         /* Process each NDP */
>         while (1) {
>                 struct usb_cdc_ncm_ndp16 ndp16;
> +
> +               if (ndpoffset <=3D last_ndpoffset) {
> +                       net_err_ratelimited("mbim: non-increasing NDP off=
set (%u)\n",
> +                                           ndpoffset);
> +                       break;
> +               }
> +               last_ndpoffset =3D ndpoffset;

It would be better to address this under the next_ndp retrieval, something =
like:
```
n =3D (int)le16_to_cpu(ndp16.wNextNdpIndex);
if (n > ndpoffset)
   ndpoffset =3D n;
else
  break;
```

>                 struct usb_cdc_ncm_dpe16 dpe16;
>                 struct mhi_mbim_link *link;
>                 int nframes, n, dpeoffset;
> --
> 2.43.0
>
