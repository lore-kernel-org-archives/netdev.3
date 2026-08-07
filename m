Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF910379C48
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088299; cv=pass; b=UP7HLnBRol4iiO/Wlk6DrAyC8Sck+Ad3A7FiEFEruGE3jxM6MpVvSnIA2s7sJnbKiZL4lXFdv6tSs3/+wH55NV2VZT7REn/1Qto5Ql9Ww0zdMhLsyrpe0xaoMKRlsz+ZBhCOg0eAZ1LFASeP3efOTEhYYMp+JsWo9HhAPCcX2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088299; c=relaxed/simple;
	bh=Ht8zSv5f6QYfm6RWcb2eoL2rXQiDciiI0lKtxaNwgf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+0f74E8U6iJeGPc2ijazgy8y5wi7+r35WT6k9tc2tJSu/4BL+/8aOPkfGTPWsic+E8w/JEzxTcBI5WrkJy17mJf0ue0h7GuyNsI6BJkX8fvoUGmWQfQyL+EpIfkxFvfuxZSuowJP6p7QgPXV+SfAhnwzEm/jd5T8M780mC/fDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVmaOKOU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J4ZyPaGy; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVmaOKOU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J4ZyPaGy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HILb3535125
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 07:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Sl4y9uawSGtcsCGxz2VIhjePc9AClmG5YR7AytZb0U=; b=FVmaOKOU6N1e28iH
	agtBdnX9xb16FlJnlA5hibhqU4y3noAYdzx8g5SDjm9BG8F4o8Sr6C6nEPQSIT50
	c0XhmFRp92/tRJK5RLTFhK5BrGWEVmixg4YdM/WO3p6Go55axx0Dz/U+dHv+uOtc
	s/nAdMoZHdMy137mQVQGwwx8zyXjp3J4o57AyJpxyBXQ6sZ+MyPKeGaET60T4utj
	DWXKFqfBV5+tljqcSIDzdTYx0nrB7SIqLrluwv/WmDS80rATAoXY832jj42GMDOV
	HRblXAeHxB0fJaidpzjDIP3in1fazdGJwbbahCh5saLkLh66JteYct3aTn2EcdzQ
	1bSO1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6ftx4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:38:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so307080785a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 00:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786088294; cv=none;
        d=google.com; s=arc-20260327;
        b=jxy6AB0D1ldf2aZ1R2ZN37lQInuQYuFaB1ofVvH4h7jOU3yNdXlMGSZxRT9A6jRMXy
         RYgZs2P10npAl3eMGBuiI+Vy2vu+QyxbJeoH3e/oVrqYFYa+nFl91zIiwEoR7AUtCG6s
         Y1Sa+UT7EvvStRi+A1XJLuUPRbtKWu+0VmwpAfcRcxyABXwVGV/TKTPPP5IA1rcp309m
         lSx2OUiS0G1cQcU5RmEfGLsPtBL/5vZmTByGPj+8dmItd8Ikj+wRk2F7dpUCiX9Ubk8N
         RxopcnJ0faxaW8C8c+0L/v1OlHk/bNLP/2VSXbMaPitpgIuYt1OWlr8YI5LBBV4wzb4W
         XndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Sl4y9uawSGtcsCGxz2VIhjePc9AClmG5YR7AytZb0U=;
        fh=xqji0j2mRULXd8Lvlys8huTCfq8FJQNCiZ/Tu5Q9EkM=;
        b=qtwYq9WMzn/CebDkRMP0DJeW36CIZa4cDpH2n43LIIBWyu4py7JxQFAlbxXc6B6Qvm
         WqJy7zKX6ByyojHdx89tAPGRonTgr5feKd3u71ffCYlqAGI3n36PizNR+Hhm74gHGLA1
         eLuEqf06MpZs20w4l5n/IbcY5Fru9oTAy21UCcor5PB/5FVnGJnvcpV3ULyowOUcK4wB
         Y81AWrfQ/K/GZwJgg//zy+X0rpUgJfD6VdN6NRwu1a7xFqAs5ziHQZHpQmBcu2QV5MYG
         wDUfUECMKTM9LI/0e0UgdARNkq0Y755J2BLsJNnzAzYMiMKSIyfgd/4XfvHWXqEEVzoN
         rjhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786088294; x=1786693094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Sl4y9uawSGtcsCGxz2VIhjePc9AClmG5YR7AytZb0U=;
        b=J4ZyPaGyrnLxTOO6Ra8eORV8c46GW8un2CfWP503XooSsUun7wNh5zCgTBMpm21m7s
         YA5jaaBP11PR80qjjkQ4P8XbQktoGywAJC2QDTPfSmoNsQ8J5XJ69pS2CovAoHfcPkJP
         wO+sEjndXk83lqkJgWlXo6pVEH7EDP8dxevRWv+/A8aI04RPI+xg/E6reRPNHS5Yjqp8
         nMpkpRbfqOmXY/7E8rXszTBCnnWzYr+CFRe7mINsbyA0Q5FC1DI3X3tPcq2p/W85nxcb
         Ee7WNCY2NsXB1tCC5DdVEFQo9kt3YgKNOouC/v+ukMpNjOOTab1uVIgAK0j3IlQr8pJ6
         Osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088294; x=1786693094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Sl4y9uawSGtcsCGxz2VIhjePc9AClmG5YR7AytZb0U=;
        b=rLWbTtH/lOo0u63x8MUabQZLmSWO7JKsMQ3fQVqdSjtIGfG61o06N+3LHMhinkw6Tz
         e/tiNR5Mt1z+iSBJiMQSMGL09Ecmt/apWoLFTRbqBc5nUJKt/FUsnow5l9tUwbpE4L7X
         PLz8bwOjFCJWB/4o82h8jBvIhdjfmI8ZVQOp6zbsi6d9rpN56ys8HqlknXdkMrFcnahL
         UtniVlmmEfr8CRbscl3e4d79WzZCcBD1UxWJBUsyaeOCDrNiR4v4APwjvHTVLpddh8nU
         431/Fon4LFcsmDskmTHKeRS9RRP+YuXj3/qZKlGzdjfwrdpputdmTaCncQy3S+m5jsnE
         SwdA==
X-Forwarded-Encrypted: i=1; AHgh+RqnkEmKiHOB1KUMeQp66+MnmZYNJE8pzeHLcFG56y4ibQR0oQCaAv6ztFXA08w/P9s6sHHZbs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp/UGfMeJLLsUcmWmlI3ICJLK4aHkPwb2vNr80ct+oQ4B+zQZ
	/yTAKVt3xsVDRDCy/HB+NJnAqqX0d8RpHcU3aht76wnNC0vgUbzZX3gtmJob7P9964iwlb1B7zX
	w2ixRu9qGr/5HZGlinFgPBoZz4gXcvZbQzNnlH9gvOpFG42w499Ky3Egm8H+fzRgQvDYEuXnzes
	f55OxzsbHtadlMkZktvoRu0PBXHPn8kVO4Pw==
X-Gm-Gg: AR+sD13D5SHZFdK75TQRBkrGppmEghq6hkS9ISptWM5Smry8gcaeoGA8v2JsQ81HNgI
	7NrMMbxmGbzrdao/zIBUHrciVM7PcIV6dppdrFF230Eet+FQ9WhkIAg45F2xElK+QIHzL8MO99D
	VzCGL35egXmoalezjx0KFXTK5i/NeYwoWHm3SogJBUYSSHFAS7ZSbEad2iEkY/uGe+yNZp018RU
	Jzax5Mn+Wv7j612pF31V0UEJ88E241y5v6nPaFozT4QvrIt7s987Ro4kcPO0RETq+sPYM+eV2Mk
X-Received: by 2002:a05:620a:7101:b0:931:403:2442 with SMTP id af79cd13be357-93649165163mr1865748585a.18.1786088294327;
        Fri, 07 Aug 2026 00:38:14 -0700 (PDT)
X-Received: by 2002:a05:620a:7101:b0:931:403:2442 with SMTP id
 af79cd13be357-93649165163mr1865746085a.18.1786088293818; Fri, 07 Aug 2026
 00:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806155253.3378294-1-peter.hunt@opengear.com> <20260806155253.3378294-4-peter.hunt@opengear.com>
In-Reply-To: <20260806155253.3378294-4-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 09:38:01 +0200
X-Gm-Features: AUfX_mymPBs_CKPM1r3s_yuQ5hXL1UneU-S790QkrTlZF-_1-fWvwgvXd3VHYQ0
Message-ID: <CAFEp6-18g8VOZ00m1D=ncOJd9oHq-r3pwmj9dCnsqw0L9RSu7A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
To: Peter Hunt <peter.hunt@opengear.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1NSBTYWx0ZWRfXxUUAg6zF6k8c
 v7LORQWpzmUu3gP6y4xxgEGz6euUcnhV/rqNJjyq58guKmOyFwW+Nfz5jEXJ2FPpx6rUymypI5J
 76lzASW3bIjWbiyoIaMSYS2fKGbXn0MbQV43cLV0Jmtpe15VIvuMw2ZLxjLqU/A+z0IxxC+GI95
 sao585Oa/8ox4EqqiHaVLAHuIGMyFEkKw9d6XD8zspyMevgLqvvuckgpARuw6ogkauTVfF+9C/t
 Y29B3bbTOukBE4n07ggPiXROycSB7nsVLIorHL2WPhk2jYTVGOpTbKXj1+Adat2GzG7Tg59joFB
 HvwBxGpvmJS689+ZsFl4TCCgssM+Z8vs+NVOcsT0T11BxzeBdQcCjILt6htpmY0RWX7m90yq0/A
 LeMmc70/3ABxMIHqD2SYLVF9KsU9SdHiI6rfY6AhtkHp+XmYV1WyESRI+POtxPe7TiHvvbXTlHE
 YGAAcigSvRyPahoWj3w==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a758b67 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=t2vznHeBAAAA:8 a=KKAkSRfTAAAA:8
 a=IxGcHqfq4pMj3a99btUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=V_BghkRpYkFyHJIZkSH6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xVvVwb2BdtJvO63vWj0HnTI6o774sVWb
X-Proofpoint-GUID: xVvVwb2BdtJvO63vWj0HnTI6o774sVWb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1NSBTYWx0ZWRfX24ducqMvecd1
 5LJNAsGPMsGjlgvIvmwgtcQY0a0MOPJoM+PmEaGvYmjLcRQ/QIBlTLaONttIu/EmzgdeoaELfLP
 KsPT8jMTH9SUpHvf1Yc1Ac9aSi/K0KI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070055

On Thu, Aug 6, 2026 at 5:54=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com>=
 wrote:
>
> Qualcomm/Sierra SDX55/SDX65 modems (e.g. Sierra EM9291) withhold
> unsolicited AT result codes (URCs such as +CREG, and the +DMI OMA-DM/LwM2=
M
> session indications) on an AT port until the host asserts DTR.
> mhi_wwan_ctrl exposed the AT (DUN) ports but had no way to signal DTR, so
> URCs never reached userspace.
>
> Carry the host serial-control lines to the modem over the dedicated
> IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
> separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path i=
s
> untouched; the control-channel device for each MHI controller is tracked
> in a small registry so an AT port drives the IP_CTRL channel of its own
> modem (multiple modems are supported).
>
> Mirror TTY semantics: an AT port raises DTR/RTS on open and drops them on
> close, and the new wwan ->tiocmset op lets userspace change them via
> TIOCMSET. This matches the TTY-based USB and legacy PCIe drivers for the
> same modems, where DTR is asserted on open. Received device->host serial
> state is not needed and is ignored; ->tiocmget is left unimplemented so
> the wwan core reports the cached bits.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
> ---
> v2: Use __le32 for mhi_dtr_ctrl_msg fields and cpu_to_le32() on
>     assignment. Use guard(mutex) in mhi_wwan_ctrl_send_dtr. Return 0
>     when IP_CTRL is not enumerated so TIOCMSET does not regress for
>     devices without IP_CTRL.
>
>  drivers/net/wwan/mhi_wwan_ctrl.c | 183 ++++++++++++++++++++++++++++++-
>  1 file changed, 182 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index a31d8540fbb8..95f4f0e6e4aa 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -1,8 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mhi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/wwan.h>
>
>  /* MHI wwan flags */
> @@ -14,6 +18,30 @@ enum mhi_wwan_flags {
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
> +};
> +
> +static LIST_HEAD(mhi_wwan_dtr_list);
> +static DEFINE_MUTEX(mhi_wwan_dtr_lock);
> +
>  struct mhi_wwan_dev {
>         /* Lower level is a mhi dev, upper level is a wwan port */
>         struct mhi_device *mhi_dev;
> @@ -23,6 +51,9 @@ struct mhi_wwan_dev {
>         unsigned long flags;
>         size_t mtu;
>
> +       /* AT (DUN) ports raise DTR/RTS on open to receive unsolicited ou=
tput */
> +       bool is_at_port;

Do we really need that? the wwan core already has this knowledge and
so will only forward/support tiocm ops to AT ports. Also this info can
be retrieved from the wwan_port type.

> +
>         /* Protect against concurrent TX and TX-completion (bh) */
>         spinlock_t tx_lock;
>
> @@ -103,6 +134,55 @@ static void mhi_wwan_ctrl_refill_work(struct work_st=
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
> +       if (!ctrl_dev)
> +               return 0; /* IP_CTRL not enumerated; best-effort, not an =
error */
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
> +       if (ret)
> +               kfree(dtr_msg);
> +
> +       return ret;
> +}
> +
> +static int mhi_wwan_ctrl_tiocmset(struct wwan_port *port, unsigned int m=
dmbits)
> +{
> +       return mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbit=
s);
> +}
> +
>  static int mhi_wwan_ctrl_start(struct wwan_port *port)
>  {
>         struct mhi_wwan_dev *mhiwwan =3D wwan_port_get_drvdata(port);
> @@ -122,6 +202,10 @@ static int mhi_wwan_ctrl_start(struct wwan_port *por=
t)
>                 mhi_wwan_ctrl_refill_work(&mhiwwan->rx_refill);
>         }
>
> +       /* Raise DTR/RTS on open so the modem forwards unsolicited output=
 */
> +       if (mhiwwan->is_at_port)
> +               mhi_wwan_ctrl_send_dtr(mhiwwan, TIOCM_DTR | TIOCM_RTS);

Why not handling this enablement directly in the wwan core?

> +
>         return 0;
>  }
>
> @@ -135,6 +219,10 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *por=
t)
>
>         cancel_work_sync(&mhiwwan->rx_refill);
>
> +       /* Drop DTR/RTS on close */
> +       if (mhiwwan->is_at_port)
> +               mhi_wwan_ctrl_send_dtr(mhiwwan, 0);
> +
>         mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
>  }
>
> @@ -163,6 +251,7 @@ static const struct wwan_port_ops wwan_pops =3D {
>         .start =3D mhi_wwan_ctrl_start,
>         .stop =3D mhi_wwan_ctrl_stop,
>         .tx =3D mhi_wwan_ctrl_tx,
> +       .tiocmset =3D mhi_wwan_ctrl_tiocmset,
>  };
>
>  static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
> @@ -223,6 +312,7 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi=
_dev,
>
>         mhiwwan->mhi_dev =3D mhi_dev;
>         mhiwwan->mtu =3D MHI_WWAN_MAX_MTU;
> +       mhiwwan->is_at_port =3D (id->driver_data =3D=3D WWAN_PORT_AT);
>         INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
>         spin_lock_init(&mhiwwan->tx_lock);
>         spin_lock_init(&mhiwwan->rx_lock);
> @@ -255,6 +345,59 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *=
mhi_dev)
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
> +static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
> +                                   struct mhi_result *mhi_result)
> +{
> +       /* Modem serial state is not needed, drop it */
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
> +       ret =3D mhi_prepare_for_transfer(mhi_dev);
> +       if (ret) {
> +               kfree(dtr);
> +               return ret;
> +       }
> +
> +       dtr->cntrl =3D mhi_dev->mhi_cntrl;
> +       dtr->mhi_dev =3D mhi_dev;
> +       dev_set_drvdata(&mhi_dev->dev, dtr);
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_add(&dtr->node, &mhi_wwan_dtr_list);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       return 0;
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
> +       kfree(dtr);
> +}
> +
>  static const struct mhi_device_id mhi_wwan_ctrl_match_table[] =3D {
>         { .chan =3D "DUN", .driver_data =3D WWAN_PORT_AT },
>         { .chan =3D "DUN2", .driver_data =3D WWAN_PORT_AT },
> @@ -278,7 +421,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver =3D {
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
