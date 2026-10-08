Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A04E5357
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473466; cv=pass; b=hTfDPpqcrUY5048IBe8t6YpmvMYdLBGj3ooOi4PLXBNtXxsgagbDOxnLRs6gBwhI4uZqt+3ouCG7s2mZHvGG5hhbkhqIZefSYsjiX7h667L937XR6ftPFeodB3rJCXmTDxBVLgDmBWooeutUGPmjw/WqlkJ9//uPlAvCEInvMmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473466; c=relaxed/simple;
	bh=6X1oax62eG/jAsEtXsfnS/etOl4pWJtGAdc/PQtvw3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmUetaHSt1ccTN8qSE2rK4PB4CGw2pG3d5nEce9GsOtA5o8hq30pkrq6ZnYvVsZrLVCSSYcwYMPtBXXO9uR7/u3rFEJ54vxkzXj5A8q6e0dmgpkz3MDtc6BjJgZFsH32S8uvIwdnAleDTamsv9CohiuIuUwavrVYzX6KJvk6DlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EChaCNpu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1IaNOsV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EChaCNpu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1IaNOsV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVml62124229
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 15:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+vJLD5+Kwx54quixrsgjaIt1Rx3QDCVYV45JpTScVo=; b=EChaCNpuUMQQhvyk
	R3yJW1xVhc/RmoH4NqZXV0BemSJhUxLxe4ZsvajjzumWVQfOsTV/UBtgrbVJBSY4
	sZwfiLxekJQ0j6Ul3w/Bg9fuFZOS+wuHIR06gdAaBGmkzgtYR5NU6VTdX2lVqwpl
	/SFaWq+pqjiHj52k2dOMXI2y0SZAcT4gtHHAjrN/UDtvhXjV2B/IAuFQzMbVeS7B
	bCEAFC/39sUZiK1N7e+qVErc0UQA55php5KWYD7sNsOUaSqW/uYX2T/imO9z2jEZ
	06Nrl6qugfp4/ttvp5ARe/kG+9Wms11AEruundowhAmQ9pjGoYOOl+bAiMyuwXfv
	q6ebXw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3bghk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:31:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-917a2de2cc1so75885836d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791473463; cv=none;
        d=google.com; s=arc-20260327;
        b=hdnfuk8rPP0JR+csycbU300KJPy/8IG8lJwclWhE7sHKsU1Cs4P5/3W+Y3zz2aVd57
         KrMbBdh0je5fsF0hSJh0ZbjAv3oaueFmffgNtALE2nCw798o7IHMWdmdjCrfn7gZYsR2
         hd0S+Hx+fMlAjZjI1sLqDuempEeBCDdWFxgbSLyOm4W0LVxnLiuRMi7KBnzmPWo+mLUI
         NeCWIyKOcXFGGvQKlQhk3wiHYaLzxb0hq4R/IjInKysqO3lk1fBlw2S+j+oNZk8de3nO
         nY0ThbUTXRuFry3/LJHwNyTyuWhvHZ5RckbAA9+Dzx4gEO4aDwMVk6Bs6qHr5yeMJjFA
         Pj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X+vJLD5+Kwx54quixrsgjaIt1Rx3QDCVYV45JpTScVo=;
        fh=Y91pYYTrVbFG3HslNtslEi3VRB8Ec1vn4CwUSTvuj4c=;
        b=UOJ+vTEzHsSXBhcyquyygz58/1FhaQFWYTMfef9g7gFM0H9NYtqYAoFCBX22xfYAeG
         TxMxdkyyd4hFc9Vq4FUG8WGyzzos1e+hTwPpPdDtFjGdtcrUUsWv7cu69xWn1+gHInat
         fNCDZReRXMj4zQWECEqIbDqy8ckikBCjelrCuM2Yw/XRLNAjkKFvaj0PCZy6pAnGu/2s
         YyaxsTEnm0PMXqTILSLWwQcWsJSLSRAxJRuQDvNXE27SFgmcuRfYXqpbEBqO1Azi1vhN
         AzBIZO6UCJPLTTmL0cOmiCK/MDruPEprw+kHkQ4k95BmRlvwUvpbPanox3GtWtzI6iJI
         lnxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791473463; x=1792078263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+vJLD5+Kwx54quixrsgjaIt1Rx3QDCVYV45JpTScVo=;
        b=G1IaNOsVVG46aAIPrjf9DHjWwWJzbX8dXlIuKVYK1sg1GbxiF//WJaf9/MtL0B825A
         y0kMf/1AL1hHJ/MSG4a8XLd4ObzauqtMZhFFaqmttVaALtnxojYCy/bZZgi/l0J28Hzp
         qX8dA/nFgS1y7XFJULARw2WYQWK1V4N+Y7BdcHVcTbdAumeXsY5yyhvH8BQxvOtQuRH7
         n2QEciqg6rGWA5TdtJ+QzMBZDdbFozrH0syFp/Haw0fVHQEZZujaIvqD78IE5YvtkSQi
         ZxKRlCJ9DcTf+Gm0RGSwvya4TzqOe6mb5K2myR/z80Jt6lTrEh/pfmcRkVu/lIuXf1XA
         TS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473463; x=1792078263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+vJLD5+Kwx54quixrsgjaIt1Rx3QDCVYV45JpTScVo=;
        b=VVOrcwsoTjvIMPWgBXmMZV3zYuDtCH/bBUcg3z0TsUhcTb8KE1Pn3qyQg9hiuMJ/Y/
         MiSPMxogy9o/jWcGvHJuG0HFJscHDLuZQV9hg+2ZB17/38eefVj7NgrzNzoNiMBIKVoD
         DmjpnbM/lBU3/sO+XZXebK0KjgYToFjj6OZM7rK4jdCaaeqosCj2jG91h8cJ/7OusCKH
         aeTyWYeQKbzp3X+jhO9vZBx6RdPxlydSD7/9KuLC29lKxOKUsbhFRpuCP1QeYboz+veC
         X7VxVbdZwJZA9mqH+C08Nqyv1VQyLk84exv8qLkwYpg0dcTO4m5rNdyVVIKnqTns0mkX
         k4fg==
X-Forwarded-Encrypted: i=1; AKwUvBznfVA47O9TW7dYymqg3EK5Zin7CwLr4nV0ci4eIAL9QuivpcnLV1+zD2EIWx91UFuHo4mLnhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjM3NfwZAQMaTeqtzlPV6XCHzVEDIpes/de/bUx1jNlVX+HVCM
	NCdluJ7GqHcHHm+Wik/mnLbi2N4SiR3OhO0XjFs3cWgjmKUyyPcU8Ex8yu459y0m63bVTFqtxqq
	e4FgGE3wmyKfeULtVBz5Fe3kd+Ghvl3g77hOg3r96SrGpDpNFY7mHDmVNYRrGdpe/udswifMxHk
	j1XpVDCnyCeMxnSTpFn2BSP5WTZMiwSvgqyg==
X-Gm-Gg: AYBFou1zuV30fJLLLKsXK5PUnOczb4TrQAKKiu+o4tQYpTK+Q3ofwCakqamgpq4dTTt
	F+2ttHEoe6QObOY/lMBo2Sro9tRgoI6R0rTHKVyFUJ4UdK5TYyH/Tvu9Hl2+aZeuFKfYfKKPcGr
	bKF9Hgfxi9cz1jNKZblKMAxAMvcFrh2blEpeLUgP1fvQ4nsReBm1MF6uUpLXtGC2mgTgTEnJUvE
	S9N1NeSNuA7Bdv/FfkXZ/eM6kOKSS8VjIbVh3iU6FtNSnfm6JcWFgt5XmQ9hMaKJYEX7KyB9eo=
X-Received: by 2002:a05:6214:509a:b0:914:4bd3:d98a with SMTP id 6a1803df08f44-9199782605fmr102503686d6.14.1791473462369;
        Thu, 08 Oct 2026 08:31:02 -0700 (PDT)
X-Received: by 2002:a05:6214:509a:b0:914:4bd3:d98a with SMTP id
 6a1803df08f44-9199782605fmr102502536d6.14.1791473461449; Thu, 08 Oct 2026
 08:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007182238.1154851-1-peter.hunt@opengear.com> <20261007182238.1154851-3-peter.hunt@opengear.com>
In-Reply-To: <20261007182238.1154851-3-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:30:50 +0200
X-Gm-Features: AclHuK-uVpIAd1gIfe8WTI32KePFUly9kKe_PWHylywQ78pMXbf6tIVIvgmbx3c
Message-ID: <CAFEp6-1gb5KgK5rtz4U80AGvs_g2ZPELUge9Q=bhy4+=coJ-GQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, mani@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _vhZI9OddazJAqDiPLX0Bp69zoSrq_mD
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac7b737 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=t2vznHeBAAAA:8 a=KKAkSRfTAAAA:8
 a=NXuk3Y-Jq4XySTnNiK8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=V_BghkRpYkFyHJIZkSH6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MSBTYWx0ZWRfX4uKjClS7ShMh
 kpOQa9qzD+EhN8rQqJ3vfTIaaViyBv7kP1xqfgudqjK/QIZ4jkeT8dqXu0mnVLH/8SjjUNL74Pa
 Ceqvkz+RybUEdRFuPhbncMjw6Jnr3oY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MSBTYWx0ZWRfXxSjV6TOGHU2j
 iJj5JWMbSccZMnICY4vlFEhU5A1Khd13psLiQkX42jIhWYDtQEeJthdUgjfn+cijjmpwdleI0s1
 bQ3mfA3XxGnEhlp7UZz48WKqLOUF4wRnJei3142UqLKZkfNqDx+jG4D4pGuMywDug/l4WRjC8UQ
 uAvzXQaLvdulft5gKZiEl0wW+l3PQa+HJjRWmQEa0TXrIeAL4MOP8LNDoIwIOPYn3LyqAYUSq/1
 m7sDThhQy2IOyX/khPkLgMhwCFbAxCtn60Upa84ijKzXT3VfJxibQQbvkY09Zu1yZWnDX6dJf9Y
 B2gqb7ZIo+pFHJ6snxUzK9pRrYk6Blyx/4/lsyPqKdwhpKT84HNwglTxeIs59Mmt30Afq/gQWoe
 1CgaCGDerUNuXYHmuN9c922+d9/vfS+Pdd3ENCAJtMZNOheuXg4KOum2oiGVy1sTyUpQSj2UyDO
 WEICn7UMgKOah6kxeZA==
X-Proofpoint-ORIG-GUID: _vhZI9OddazJAqDiPLX0Bp69zoSrq_mD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080061

On Wed, Oct 7, 2026 at 8:23=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com>=
 wrote:
>
> Qualcomm/Sierra SDX55/SDX65 modems withhold unsolicited AT result codes
> (URCs such as +CREG, and the +DMI OMA-DM/LwM2M session indications) on
> an AT port until the host asserts DTR. mhi_wwan_ctrl exposed the AT
> (DUN) ports but had no way to signal DTR, so URCs never reached
> userspace.
>
> Carry the host serial-control lines to the modem over the dedicated
> IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
> separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path
> is untouched; the control-channel device for each MHI controller is
> tracked in a small registry so an AT port drives the IP_CTRL channel of
> its own modem (multiple modems are supported).
>
> The IP_CTRL channel has to be declared in the controller's channel config
> for this driver to bind. For the Sierra EM919x/EM929x this is done by
> commit 83c29a55b89e ("bus: mhi: host: pci_generic: Add IP_CTRL channel
> for Sierra EM919x/EM929x") in the MHI tree. On controllers that do not
> declare IP_CTRL the driver does not bind and ->dtr_rts is a no-op.
>
> The wwan core (patch 1) raises DTR/RTS on first open and drops them on
> last close (if HUPCL is set) for any AT port whose driver implements
> ->dtr_rts, so no open/close handling is needed here. The new ->dtr_rts
> op lets userspace assert or de-assert them via
> TIOCMSET/TIOCMBIC/TIOCMBIS. Received device->host serial state messages
> are silently discarded; a single recycled sink buffer keeps the IP_CTRL
> DL ring live so the modem's transmit path does not stall.
>
> ->dtr_rts is void, following the tty_port_operations model it is modelled
> on. Delivery is best-effort: at_data.mdmbits always reflects the committe=
d
> userspace intent for TIOCMGET regardless of whether the IP_CTRL message w=
as
> queued, and the next ioctl or open/close cycle will resynchronise the mod=
em
> state. If requeueing the DL sink buffer fails with a transient -ENOMEM it
> is retried from a work item, so the DL ring does not stay empty.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
> ---
> v8: No changes
> v7: Retry a failed DL sink buffer requeue from a delayed work item on
>     -ENOMEM, and log other failures. Note the dependency on the IP_CTRL
>     channel entry in pci_generic, now in the MHI tree. Both from the
>     Sashiko review of v6
> v6: Rebase onto net-next. Allocate the IP_CTRL DL sink buffer separately
>     instead of embedding it in struct mhi_wwan_dtr, so DMA cache
>     maintenance on non-coherent platforms cannot touch neighbouring field=
s.
>     Do not requeue the sink buffer from the DL callback when the transfer
>     completes with an error (e.g. -ENOTCONN during channel teardown)
> v5: Implement ->dtr_rts(port, mdmbits) and drive DTR and RTS
>     independently. Pre-queue an RX sink buffer in probe and requeue it in
>     the DL callback so the IP_CTRL DL ring does not run empty and stall
>     the modem's transmit path
> v4: Add dev_dbg when IP_CTRL channel is not enumerated for this controlle=
r
>     and when mhi_queue_buf fails, to aid diagnosis of the "URCs missing"
>     case on controllers that do not declare IP_CTRL
> v3: Remove is_at_port, implement ->dtr_rts instead of ->tiocmset,
>     open/close DTR raise/drop handled by wwan core (Loic Poulain)
> ---
>  drivers/net/wwan/mhi_wwan_ctrl.c | 239 ++++++++++++++++++++++++++++++-
>  1 file changed, 238 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index a31d8540fbb8..feb9c03b6392 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -1,8 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mhi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/termios.h>
> +#include <linux/workqueue.h>
>  #include <linux/wwan.h>
>
>  /* MHI wwan flags */
> @@ -14,6 +19,32 @@ enum mhi_wwan_flags {
>
>  #define MHI_WWAN_MAX_MTU       0x8000
>
> +/* IP_CTRL channel message that sets the modem's DTR/RTS control lines *=
/
> +struct mhi_dtr_ctrl_msg {
> +       __le32 preamble;
> +       __le32 msg_id;
> +       __le32 dest_id;
> +       __le32 size;
> +       __le32 msg;
> +} __packed;
> +
> +#define MHI_DTR_CTRL_MAGIC     0x4C525443      /* 'CTRL' */
> +#define MHI_DTR_MSG_DTR                BIT(0)
> +#define MHI_DTR_MSG_RTS                BIT(1)
> +#define MHI_DTR_HOST_STATE     0x10
> +
> +/* Per-controller IP_CTRL channel, used to signal DTR/RTS to that modem =
*/
> +struct mhi_wwan_dtr {
> +       struct mhi_controller *cntrl;
> +       struct mhi_device *mhi_dev;
> +       struct list_head node;
> +       struct mhi_dtr_ctrl_msg *rx_buf; /* DL sink, separate allocation =
for DMA safety */
> +       struct delayed_work rx_refill; /* retries a failed sink buffer re=
queue */
> +};
> +
> +static LIST_HEAD(mhi_wwan_dtr_list);
> +static DEFINE_MUTEX(mhi_wwan_dtr_lock);
> +
>  struct mhi_wwan_dev {
>         /* Lower level is a mhi dev, upper level is a wwan port */
>         struct mhi_device *mhi_dev;
> @@ -103,6 +134,61 @@ static void mhi_wwan_ctrl_refill_work(struct work_st=
ruct *work)
>         }
>  }
>
> +/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL ch=
annel */
> +static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned=
 int mdmbits)
> +{
> +       struct mhi_controller *cntrl =3D mhiwwan->mhi_dev->mhi_cntrl;
> +       struct mhi_device *ctrl_dev =3D NULL;
> +       struct mhi_dtr_ctrl_msg *dtr_msg;
> +       struct mhi_wwan_dtr *dtr;
> +       u32 msg =3D 0;
> +       int ret;
> +
> +       guard(mutex)(&mhi_wwan_dtr_lock);
> +
> +       list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
> +               if (dtr->cntrl =3D=3D cntrl) {
> +                       ctrl_dev =3D dtr->mhi_dev;
> +                       break;
> +               }
> +       }
> +       if (!ctrl_dev) {
> +               dev_dbg(&mhiwwan->mhi_dev->dev,
> +                       "IP_CTRL not enumerated; DTR/RTS not signalled to=
 modem\n");
> +               return 0;
> +       }
> +
> +       dtr_msg =3D kzalloc_obj(*dtr_msg);
> +       if (!dtr_msg)
> +               return -ENOMEM;
> +
> +       if (mdmbits & TIOCM_DTR)
> +               msg |=3D MHI_DTR_MSG_DTR;
> +       if (mdmbits & TIOCM_RTS)
> +               msg |=3D MHI_DTR_MSG_RTS;
> +
> +       dtr_msg->preamble =3D cpu_to_le32(MHI_DTR_CTRL_MAGIC);
> +       dtr_msg->msg_id =3D cpu_to_le32(MHI_DTR_HOST_STATE);
> +       dtr_msg->dest_id =3D cpu_to_le32(mhiwwan->mhi_dev->ul_chan_id);
> +       dtr_msg->size =3D cpu_to_le32(sizeof(__le32));
> +       dtr_msg->msg =3D cpu_to_le32(msg);
> +
> +       ret =3D mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*d=
tr_msg),
> +                           MHI_EOT);
> +       if (ret) {
> +               dev_dbg(&mhiwwan->mhi_dev->dev,
> +                       "failed to queue DTR/RTS signal: %d\n", ret);
> +               kfree(dtr_msg);
> +       }
> +
> +       return ret;
> +}
> +
> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int m=
dmbits)
> +{
> +       mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbits);
> +}
> +
>  static int mhi_wwan_ctrl_start(struct wwan_port *port)
>  {
>         struct mhi_wwan_dev *mhiwwan =3D wwan_port_get_drvdata(port);
> @@ -163,6 +249,7 @@ static const struct wwan_port_ops wwan_pops =3D {
>         .start =3D mhi_wwan_ctrl_start,
>         .stop =3D mhi_wwan_ctrl_stop,
>         .tx =3D mhi_wwan_ctrl_tx,
> +       .dtr_rts =3D mhi_wwan_ctrl_dtr_rts,
>  };
>
>  static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
> @@ -255,6 +342,118 @@ static void mhi_wwan_ctrl_remove(struct mhi_device =
*mhi_dev)
>         kfree(mhiwwan);
>  }
>
> +/* IP_CTRL channel driver, bound separately so the data-port path is unt=
ouched */
> +static void mhi_wwan_dtr_ul_xfer_cb(struct mhi_device *mhi_dev,
> +                                   struct mhi_result *mhi_result)
> +{
> +       /* MHI core has done with the buffer, release it */
> +       kfree(mhi_result->buf_addr);
> +}
> +
> +/* Requeue the single DL sink buffer so the IP_CTRL DL ring never runs e=
mpty.
> + * A transient mapping failure is retried from a work item, other errors=
 mean
> + * the channel is going away and the next probe queues a fresh buffer.
> + */
> +static void mhi_wwan_dtr_queue_rx(struct mhi_wwan_dtr *dtr)
> +{
> +       int ret;
> +
> +       ret =3D mhi_queue_buf(dtr->mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +                           sizeof(*dtr->rx_buf), MHI_EOT);
> +       if (ret =3D=3D -ENOMEM) {
> +               dev_warn_ratelimited(&dtr->mhi_dev->dev,
> +                                    "failed to requeue IP_CTRL RX buffer=
, retrying\n");
> +               schedule_delayed_work(&dtr->rx_refill, msecs_to_jiffies(1=
00));
> +       } else if (ret) {
> +               dev_dbg(&dtr->mhi_dev->dev,
> +                       "failed to requeue IP_CTRL RX buffer: %d\n", ret)=
;
> +       }
> +}
> +
> +static void mhi_wwan_dtr_refill_work(struct work_struct *work)
> +{
> +       struct mhi_wwan_dtr *dtr =3D container_of(to_delayed_work(work),
> +                                               struct mhi_wwan_dtr, rx_r=
efill);
> +
> +       mhi_wwan_dtr_queue_rx(dtr);
> +}
> +
> +static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
> +                                   struct mhi_result *mhi_result)
> +{
> +       struct mhi_wwan_dtr *dtr =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +       /* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
> +       if (mhi_result->transaction_status &&
> +           mhi_result->transaction_status !=3D -EOVERFLOW)
> +               return;
> +
> +       /* Modem serial state not needed, requeue the sink buffer to keep=
 DL ring live */
> +       mhi_wwan_dtr_queue_rx(dtr);
> +}
> +
> +static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
> +                             const struct mhi_device_id *id)
> +{
> +       struct mhi_wwan_dtr *dtr;
> +       int ret;
> +
> +       dtr =3D kzalloc_obj(*dtr);
> +       if (!dtr)
> +               return -ENOMEM;
> +
> +       dtr->rx_buf =3D kmalloc_obj(*dtr->rx_buf);
> +       if (!dtr->rx_buf) {
> +               ret =3D -ENOMEM;
> +               goto err_free_dtr;
> +       }
> +       INIT_DELAYED_WORK(&dtr->rx_refill, mhi_wwan_dtr_refill_work);
> +
> +       ret =3D mhi_prepare_for_transfer(mhi_dev);
> +       if (ret)
> +               goto err_free_buf;
> +
> +       dtr->cntrl =3D mhi_dev->mhi_cntrl;
> +       dtr->mhi_dev =3D mhi_dev;
> +       dev_set_drvdata(&mhi_dev->dev, dtr);
> +
> +       ret =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +                           sizeof(*dtr->rx_buf), MHI_EOT);
> +       if (ret)
> +               goto err_unprepare;
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_add(&dtr->node, &mhi_wwan_dtr_list);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       return 0;
> +
> +err_unprepare:
> +       mhi_unprepare_from_transfer(mhi_dev);
> +err_free_buf:
> +       kfree(dtr->rx_buf);
> +err_free_dtr:
> +       kfree(dtr);
> +       return ret;
> +}
> +
> +static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
> +{
> +       struct mhi_wwan_dtr *dtr =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_del(&dtr->node);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       mhi_unprepare_from_transfer(mhi_dev);
> +       /* No DL callbacks after unprepare, and a pending retry now fails=
 on
> +        * the disabled channel without rescheduling
> +        */
> +       cancel_delayed_work_sync(&dtr->rx_refill);

This function ensures that the work is either cancelled or has
completed, but it does not prevent it from being requeued
concurrently. That can happen when rx_refill is rescheduled from
mhi_wwan_dtr_queue_rx(). Using disable_delayed_work_sync() here would
be preferable.


> +       kfree(dtr->rx_buf);
> +       kfree(dtr);
> +}
> +
>  static const struct mhi_device_id mhi_wwan_ctrl_match_table[] =3D {
>         { .chan =3D "DUN", .driver_data =3D WWAN_PORT_AT },
>         { .chan =3D "DUN2", .driver_data =3D WWAN_PORT_AT },
> @@ -278,7 +477,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver =3D {
>         },
>  };
>
> -module_mhi_driver(mhi_wwan_ctrl_driver);
> +static const struct mhi_device_id mhi_wwan_dtr_match_table[] =3D {
> +       { .chan =3D "IP_CTRL" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(mhi, mhi_wwan_dtr_match_table);
> +
> +static struct mhi_driver mhi_wwan_dtr_driver =3D {
> +       .id_table =3D mhi_wwan_dtr_match_table,
> +       .remove =3D mhi_wwan_dtr_remove,
> +       .probe =3D mhi_wwan_dtr_probe,
> +       .ul_xfer_cb =3D mhi_wwan_dtr_ul_xfer_cb,
> +       .dl_xfer_cb =3D mhi_wwan_dtr_dl_xfer_cb,
> +       .driver =3D {
> +               .name =3D "mhi_wwan_dtr",
> +       },
> +};
> +
> +static int __init mhi_wwan_ctrl_init(void)
> +{
> +       int ret;
> +
> +       ret =3D mhi_driver_register(&mhi_wwan_dtr_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D mhi_driver_register(&mhi_wwan_ctrl_driver);
> +       if (ret)
> +               mhi_driver_unregister(&mhi_wwan_dtr_driver);
> +
> +       return ret;
> +}
> +module_init(mhi_wwan_ctrl_init);
> +
> +static void __exit mhi_wwan_ctrl_exit(void)
> +{
> +       mhi_driver_unregister(&mhi_wwan_ctrl_driver);
> +       mhi_driver_unregister(&mhi_wwan_dtr_driver);
> +}
> +module_exit(mhi_wwan_ctrl_exit);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MHI WWAN CTRL Driver");
> --
> 2.43.0
>
