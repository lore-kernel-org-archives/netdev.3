Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F24E0B65
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885645; cv=pass; b=jX4LDQEM/qSuA8MlPUW5JU2d2YJaTHPEY+iXHJRd3LjZrd0aGau1jtsDO8i8UKQ4ym7oaYPm8LulKpO4Oxb16C8GMFBfFQ5QPBFC0d8GL0dNnnxZJ60qMvhY2RPib6gGRKSSVJjiykI/F1q8SrhJS6zxOCHLIFUcVv8PhBHISXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885645; c=relaxed/simple;
	bh=D9KSjrkHPD8Wu2Nm5hyfS9vz6EafslLeeY+LM1Mhy+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsbyDYYvft6yOHWOvL+bj4J26tViqzSoofeB7NxuXqMOxiNx6tfVB8idpW1z/V0oTFkearG5ILJIBufuzNRz/iGqbD/h17pqCY4GQfpWoZa+hC3hVbW0U9xSnhJEdlNTOOkhuXjxbMJOfG4f5Yr7Xj5VfyxuMO0cilPzpKewuSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAoP5ra1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KzKgoWRL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAoP5ra1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KzKgoWRL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9cm383475941
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TxMcC0othliemrbg2EMDjZga3pMywAt4z8NnU3vrza8=; b=AAoP5ra1XH7UfZlm
	oq19m+s0RaYgFq+usT8+rWnRG6rk+iJXuri1hnu2sY6hNX/Lb4AP/bqh0VFpOkjw
	yrEmut00ASZElCiWB4Q5xY7MA2KD0w1jCUWsmN1/Mz44CnU8lEbmo/G/kKn8wmHv
	f/smJB8Q4NkV6TeDpMXFuOeGJPij5/G6wfyGjT/ALePmE6cYJ0uh2PF2foK38kPS
	akP2laU+aqQjaAcXBxEZyoUKo/mPGD70bFLycx1FO7hqJU5V2VwHXB/HpdtxNd5w
	azJ4kD40GSGpO0tEIpxHcQ0kyREW8hlEKsiWPvXg9uo7dvdyP6ZHaW8VnXnCCOKp
	hz47DQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j9djv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:00:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ecdc701a2so330754785a.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791885642; cv=none;
        d=google.com; s=arc-20260327;
        b=nn5FioTFPJTQwv5kChGJK9+2JBJSIt7VrF5vMNj9gPo/xYDyBGBkT9yeFo4dzcEf2f
         NzJ23oPRDhPNH03Y3CJEq+A0/BhPtQwAU9MOpKCuERD8FZ9PsSGBoVom9x/rYBZroCez
         CTiapimW6wZBVcD7MZw3SRKFfBG8oMJEw+TDN0nX4WlcW5FppyfTv5+PNbtotJRQR4Ay
         PllKy4Y4rigTkNSO5MzgY7OZIXA05gsSm6DCx/lU8mVi4uTYx3H++xc6xu3WPTvDHGoG
         nTHZN97yq6znTiHLWtaKceOPuEfPetK2pCw6vV92Sc5Fef+mCO8D1PIpuaVVq23dRp6x
         zx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TxMcC0othliemrbg2EMDjZga3pMywAt4z8NnU3vrza8=;
        fh=LZb3kUN/qwrrXEXlEHuaPz9DoMySa9rSFdekJTrXecY=;
        b=fMAUxpWKRjPqrMKR6VplmfOCt7CnTo0cs5M6Np54/jhiJD/PcdMdZLVzh1YCQVf3ES
         QvxevQoWsf04mzqUxA4E0k3tN1mNF1PD6V4LQdqovn6PjBawcdosCXV+oucq58GMQCBF
         L96tg2UeivzkfQhFkFP38XiDEN6CS1u3fNkBd/RPW+iIMfShWhcuAA4FHKFAbhmgyM7f
         WAOgXLaXXforM43p0RZh3nxlErh4GuyFLZ82+ib3PLIsjrr7cIBC695/Qr7yX19xQjS+
         NGb+jKtQFPKrla3lA3n/rHj0QHCTcxR6Z/Dmc9CATDEMuzc+UQJjMi5/zB8HmRK7LeAu
         I4ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885642; x=1792490442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TxMcC0othliemrbg2EMDjZga3pMywAt4z8NnU3vrza8=;
        b=KzKgoWRLggQswV9Yh3zTn133QC/NTnwOxy14oLnhmwecUD4UysLkTAIIZ+C8ogZBEE
         xqkc0di9DTItEob6Yn6WDYd3Pe4dPMbnhSaGj6NevftRKDyERmNemiGL6dN3KEictgza
         m19YswXbg2ipIYCniqXsPqNiBkq5aeve8vdC1fMhhysEr2VJpPYBg36RABR8PmE5/sWZ
         MhTxeMhvILg7cn2wwjPUucfA0YwhtGrLChIlv2Ouu9P8tJMMmWMkueXcLGsjSPMX6cf6
         iIBxkrFuY25gtKCQdecjXgX0W/JNf7fw1YXaGUci94+Sn4Mr9ouDtysCabzoDnx/B96f
         zxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885642; x=1792490442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TxMcC0othliemrbg2EMDjZga3pMywAt4z8NnU3vrza8=;
        b=RdMWwrRBduu1tirAPd+QQc7/1XxHfHeubZrh/50YbYK1NY/5kMLMR1XxaXU/FDlK6J
         nCln4DNtPK6xqYa6T3uOafOVqlR33d2z+8k5Sa5rFIcatuP4wNHIrlwDP2r3gFrjb/wP
         qj2MMfFWyky5KONXZNfwr6LQ3YrjjJ2PEq6FM78DS82kbL0AWpu91ir/TZgWcWmu9NKX
         372vkfR3VnctfADn7WrhTMCZtF608eAAvSpnKKs1CT2xGmmni28CT3Kvj+T4x/v2/POR
         pweuJWmUfqI8GvyyIP4j3uN5kVaZZRWrfvZ/XJyipZ4HgZ0yHMYGeU5v6KIWYovQU2FJ
         Duvg==
X-Forwarded-Encrypted: i=1; AKwUvBxKAPAFZ9raHg6/cJxpAgyKVkIxzwHRK254AtINGpPA490e5HmxCozy3Sa/tEE2SccIiC1Uot4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd8PQAYWxu3trZYyXauHQyz4ZmNuAhFJ/4BLznGz/EIlAGo8tb
	EEWfaKdyes/21P/ws2xTZPIGOaAOzF4voz+fKmMAb3geEXawSrhpxYZcxnOVt5QPj7aYIFbZTpJ
	xqqv/HJE4HXXv3omEqxQr85+xOMorJkKmOmrwdRNfBlC6MpFIF5Lik0rabcbUiKDWV5hNnaMf64
	dObv0TrzG5IjIhiocBXvtF+xOv5d07lg3pIw==
X-Gm-Gg: AYBFou3pe25ak2vfFiwkls28dsjsmwU/3DKRKixvoHIZkcLlm64VQHu7T2q4z8+Htng
	5UFiEjT6oprZwbsJJxY1yY7vhdhfxvTElzoDSdWpzBrvWQ2nIsnSWRxfRkJsCyl9D0m2ZYFUEXM
	RNfCiYG/CzzCt1AT6dDNx+2UFmgq05flEfu/I/DYrIiwZrlG7TM+/3htCzKbY1iKXtL8mmK+wLO
	b0gyTi6ZyLnMuGnQSd6DAAl/Oj9tzu2RBG6gqWDzRBFPVq9xx8CKNZfXLnJPWI7CPqbWK/h6+o0
X-Received: by 2002:a05:620a:469e:b0:93e:c12c:fbce with SMTP id af79cd13be357-93ec12d06a0mr1932844385a.74.1791885641218;
        Tue, 13 Oct 2026 03:00:41 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:93e:c12c:fbce with SMTP id
 af79cd13be357-93ec12d06a0mr1932836485a.74.1791885640539; Tue, 13 Oct 2026
 03:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012172219.3668624-1-peter.hunt@opengear.com> <20261012172219.3668624-3-peter.hunt@opengear.com>
In-Reply-To: <20261012172219.3668624-3-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:00:28 +0200
X-Gm-Features: AclHuK_mIfVIPFBQp7jWsz92VzUndal8Q1t_85zebew0TJk8kBYu92wm03aKn6c
Message-ID: <CAFEp6-3JJy_3uFiwyAej_rV68sCm_f5Bx79223QUmDhuoQNWUw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, Daniele Palmas <dnlplm@gmail.com>,
        johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TYewW-7qrfLSD_cMA3zTIN-tztVksCoE
X-Proofpoint-ORIG-GUID: TYewW-7qrfLSD_cMA3zTIN-tztVksCoE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfXxKksiCGEni0F
 xY+oiQsru2u870IrTTs3PbtFxS2TqJvbZ9C9D3pJBaO2NuEoSj9KYjoMmlk4Ac0SVEJHQDHNtA8
 S2kLuvujgn2ogiUbByP60AUBz3Xon9Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX8ZOvy8+bjefQ
 FGsGYc3sp2ULlHadenBke7kOGpHonrMj40thxSHl1bXQE/fwjACeOf4G/zwyoW9eBrEUd920JAk
 nXxGGSLs1VKhbtzgUMfpE/TmLmyDWAxc75rpi4WBDatfJ+SGQd6EczmRzooZRrzXdnmus8EMfrf
 NUGSkliuIkc7PCj3i7ufKg9gP7KGqTMrAkriCf/XkT87U1EyXwtFKuUNjuRutWajYUgMNZC6+pZ
 nz8WwFeLUztDbKVx/LbjMD9HVx22XSW8WXbkVIJY6iRzKvU81vq28lnuAIUObwbWRkYu+gbT4km
 1xrERdQFb3Zlw38eTy+s4LVAnMuewSrSKmnzDRReTKMkJB/puJHulheVTgfgX7Gv6se3gsCHMvO
 0dTaU9nyUd9QK/aZPcDL1HjH6fnhZt9DkrgUPIlyU9NFisMxIZhxTZNhExXtPQ0nDfYG7ip5jc9
 GTBXXuKRi8EZTDII2Bw==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace014a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=NXuk3Y-Jq4XySTnNiK8A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=V_BghkRpYkFyHJIZkSH6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130039

On Mon, Oct 12, 2026 at 7:23=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
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
> The wwan core, with "net: wwan: core: propagate modem control signals to
> port drivers", raises DTR/RTS on first open and drops them on last close
> (if HUPCL is set) for any AT port whose driver implements ->dtr_rts, so
> no open/close handling is needed here. The new ->dtr_rts op lets
> userspace assert or de-assert them via TIOCMSET/TIOCMBIC/TIOCMBIS.
> Received device->host serial state messages are silently discarded; a
> single recycled sink buffer keeps the IP_CTRL DL ring live so the
> modem's transmit path does not stall.
>
> ->dtr_rts is void, following the tty_port_operations model it is modelled
> on. Delivery is best-effort: at_data.mdmbits always reflects the committe=
d
> userspace intent for TIOCMGET regardless of whether the IP_CTRL message w=
as
> queued, and the next ioctl or open/close cycle will resynchronise the mod=
em
> state. The DL sink buffer is requeued from a work item, which retries a
> transient -ENOMEM so the DL ring does not stay empty, and which remove()
> disables before tearing down the channel.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> v9: Requeue the DL sink buffer only from the refill work and disable it
>     with disable_delayed_work_sync() before mhi_unprepare_from_transfer()
>     in remove(), so no requeue can race with channel teardown (Loic
>     Poulain, Sashiko review of v7). Leave unpreparing to mhi_probe() when
>     probe fails. Name the wwan core commit instead of "patch 1"
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
>  drivers/net/wwan/mhi_wwan_ctrl.c | 233 ++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index a31d8540fbb8..1cbbfcb3b920 100644
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
> @@ -255,6 +342,112 @@ static void mhi_wwan_ctrl_remove(struct mhi_device =
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
> + * This only runs from the work item, so remove() can stop it before the
> + * channel is torn down. A transient mapping failure is retried, other e=
rrors
> + * mean the channel is going away and the next probe queues a fresh buff=
er.
> + */
> +static void mhi_wwan_dtr_refill_work(struct work_struct *work)
> +{
> +       struct mhi_wwan_dtr *dtr =3D container_of(to_delayed_work(work),
> +                                               struct mhi_wwan_dtr, rx_r=
efill);
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
> +       schedule_delayed_work(&dtr->rx_refill, 0);
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
> +       /* On failure mhi_probe() unprepares the channels itself */
> +       ret =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +                           sizeof(*dtr->rx_buf), MHI_EOT);
> +       if (ret)
> +               goto err_free_buf;
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_add(&dtr->node, &mhi_wwan_dtr_list);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       return 0;
> +
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
> +       /* Stop the refill work, and stop a late DL callback re-arming it=
, before
> +        * the channel is torn down so no requeue can race with the teard=
own
> +        */
> +       disable_delayed_work_sync(&dtr->rx_refill);
> +       mhi_unprepare_from_transfer(mhi_dev);
> +       kfree(dtr->rx_buf);
> +       kfree(dtr);
> +}
> +
>  static const struct mhi_device_id mhi_wwan_ctrl_match_table[] =3D {
>         { .chan =3D "DUN", .driver_data =3D WWAN_PORT_AT },
>         { .chan =3D "DUN2", .driver_data =3D WWAN_PORT_AT },
> @@ -278,7 +471,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver =3D {
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
