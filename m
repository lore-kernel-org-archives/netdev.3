Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5643F4DA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713291; cv=pass; b=YsCMewcG8vCvhooklGbULSGcLWG+F3z4Me5S+AzAujGNw3rNdvs/+x5R/ITWagEnD0jcYdjU74zxnLQ10iJ3R8oiExQ5WYL+jpmYUSHN154eCP5Zx4G6CpykuxtbqRrZTi23z9ZWCBtRI7kaC80poAgzP2aCfAFgzsdmGrhAgcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713291; c=relaxed/simple;
	bh=CAoVlKWQ0YnTODIMif4ui9JC0zhHzOKmEZ1JdTRyRC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luKzQf7g3rWEOZDptjykc/PeASE858H/5Yg1H1xImBOSAsalte0hgcKZqUZDZZM7WjqsXdSAqw/8nIPJXNOnZ5o5/exQU5FfPR1etezYgnkmVckVImb6msTjnyGKxctCczTI6Y1UMru1blu+vC3Ql+KVgX/xqwnRWrHw/kbxRzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VchPgRDc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZPw0KcZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VchPgRDc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZPw0KcZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x7oC140611
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EazkNmYA3rUka3rIWBcFYkITmkk4Q3+uxRuKGFRbbog=; b=VchPgRDcdtoLraOo
	WiCeAVoZpRCEbti6+nmGgMJRft8Cdw/KjH3zmqPpbA0oIqDZTOfD81UdR/BC6yqg
	UaTKokKrhrRqHehPINNYgBcV8hueQl0WlsYAkLB1sNpnjHSaCk+9ShB41Y9aGjlO
	X0LEU8A1w+VWrN7mmboqbXMrM8yrDViWzIPQBtV8VH/nlK5dZRVypnAxz9pK1lYk
	mr9i4IxvvXpDsv08CfqL/WGW8smx603lMBpv9gQH/WALb9lr95/gEgrvZAe3oTIO
	Kks/0gpFDK0Zj2NIN8qgFyIKX01Bp40OmoKGe2JP+1z+F7SyaBuDSNqf74cy30AM
	5yYPVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2r7w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:41:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so1607756485a.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784713288; cv=none;
        d=google.com; s=arc-20260327;
        b=dtARwEm0t4Bsb+Z1xiDoLZjCYsZ7RYWvVs/rC8DIw1F6ngTvKo//M+bkHWEQWxGaIC
         Oi2rW3tCamrZalj3nXGxoI6MJdfgkSemrgcZ7LGpUezTZMFfq94Suycfdhhvq4NoykbA
         HPycw2WhxvHZqsZIfTWjeva5uROwwiSoEtIlwhzQnAe4nDIkadQN4g7n+wTzcYArOVw0
         rAXCFGLPRfIQwj6gglk3aOjpyyKP3DnFTnPBaKDk9uRExBKVLzI6HVkP0MPTpVQwUz6t
         3urpIJlxCa/L1W+SYLyi4axXqo8N7ZAx1EA+Kump5aA6zOmlzOKj2Hva1bElQLihEJv5
         77xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EazkNmYA3rUka3rIWBcFYkITmkk4Q3+uxRuKGFRbbog=;
        fh=TWt6vieux/x/6MxcO84YznvyqgknLrCybv60IOh8lQU=;
        b=ihkQD4R7v7aQR3+tUleGzBPh/rzfKEJJTVSvJuHXR18is0iUblW47PYoaj3q2Sj80T
         w/EXiL5lUlmjmy6hNQ3ckeDTteUThzN3mMozoYtKGFAtL/hDj/CrGNmLL0Z7rJ88XFtn
         rckNLxJxbkLBE8QveQ/cYhl3yfJvWFHwzlU6S/FXlj9IIK/ROhnFcmzWDfNzfiaHG8D3
         2W7g3T2WPikjAMpz0FDdE2cJQyn1ojOrPum6hQS1HS980QmBdcTNWhaxZbTfQcWp9XZL
         m55QsX0GXpw/8G/9xR2Rx+vd1Jd6YWGkUAO2QpfOWezKH6bxzi2Ysq5nVnpF+M3BCniR
         qwKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784713288; x=1785318088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EazkNmYA3rUka3rIWBcFYkITmkk4Q3+uxRuKGFRbbog=;
        b=XZPw0KcZN9xkYaNP+2IKGAU3MuFnCIS4DarLWgn+5s/73zHLsMSrRgTl0lLKzZe49U
         mikEQwWNOn22/dxrV5B5XeQluQ//H09A445zx2/hpRfotZ3P+TCcRjJn+Jt0je4OdB01
         a18JFKyLSu1e0H0yJSfuIOykfznadRgc9m3SjSBtZqnjtZnBjnvuoQUpiBT+/uCqXCXp
         VnbjbMp+KcfKCJV8/ap6j0g7W7N+lL1wav6Qf4kaEAz7SPoDWML/uKeo8lIAr611UIPf
         JSNSnflaQrj12Ob48Z5CB1APb3A0tCOJ6d+n8UfHkM2L9LGSCAOXUISFQgjopRZlF1qv
         ++pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713288; x=1785318088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EazkNmYA3rUka3rIWBcFYkITmkk4Q3+uxRuKGFRbbog=;
        b=AAowIut6I8PS9m2l457MPr8eNIog0zt0Q5nTS1oSHPrnWk42Ts4Tfep6Hp+AHBtGzj
         DelRPFiuJapxQwubcyaAiLjLiTXuTigqGX8PBk/4t4FOlf/z+8EBqGVBM+5GYL11Mqh/
         4RJfoYQw7+vygaPZOpuO67RYVAiHuy7Xu9E3YHibu0GA/nMz3Egn/uHzJUHnhTlN7Hx5
         J0ctdBXzEJF+3BEvw2G4ak67d8tmy3Mcpn3dx0NjjhCqfq8yltczrtxh1EzStcY1mG9g
         n/Oh+cvmF5u3aEO7fcAMHQcw8buCq+TvUAvZAr0h7rjjrtwrSJsDg5A1JmvfL20mq40k
         021w==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Q02TJWVHCAyntLvBt9ilLIE9mdJPRYupfoiR5oaWL6ldsyo3PLuarprsZ96iQ8JtlgQGPN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd6kXwRWVXU3EbwOWcSEVOj0I7dfVODK/yJws2EH7gZmIatwl
	vHZSUfdUUWdj4wuXF9zsTBxgLhQpxP4xoGpN2bxmmGAfGyEjlwKqBQ+tPjv0bc8zvZ4l+jfmBle
	zwWBvFx194CfgM3f5Thw0fRl5uADVR0OFvfzvC08F/8zy2y+6cTfPZ/L7Zy6uWV1pCuuaF7Pz7R
	4jmibn0yvc3mM2ltDsMiWIKAK73K3rbD/fCg==
X-Gm-Gg: AR+sD13e0QBS19QiaoWUZ0sA0PTAqGXpkW11HmZZedAhmcV9Dd3lqkaJGz8jXJoRVlW
	CQ6JUhRp4O+NXyZlrqKWyMPf9W5evmu6oqg5UwrcgDDoD/wJza6nn+su1RRkl0FuYMv/yzOnzNL
	mUQ2+mORTbhMaw6XEWniQMx1alK6PoSfDQwII3NXRh+2/tcUJE5Kdk+UqDxXJG/szl0mEoH4CxE
	USSRG6ta81zI0NYfzolrtYs78tJcTvJeiGP8e2QZ6gS42AeWzNrD4v+ZMteM/X4mAJtOLSln8Y=
X-Received: by 2002:a05:620a:1720:b0:92e:8405:7ae8 with SMTP id af79cd13be357-930b3e8d4damr2154972985a.4.1784713287608;
        Wed, 22 Jul 2026 02:41:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:92e:8405:7ae8 with SMTP id
 af79cd13be357-930b3e8d4damr2154970785a.4.1784713286967; Wed, 22 Jul 2026
 02:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722090931.2637025-1-dnlplm@gmail.com> <20260722090931.2637025-3-dnlplm@gmail.com>
In-Reply-To: <20260722090931.2637025-3-dnlplm@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 11:41:15 +0200
X-Gm-Features: AUfX_mwsWRCo89PoD_LTOlUmO99jG6Svtvl2uWqWhui2lgxR458M9559M4nz09E
Message-ID: <CAFEp6-2UiSja11A6nLKqRX8A1eE=P4euEs+fbpKZxPE8fTX2QQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: wwan: add exclusive open mode
 capability to AT and QCDM ports
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfX8tdLqJwXIbs6
 y7oR1kkeylDs7FlWPhqd1b3960POVdI1kgmIbaF6BkuBfclGZJXd2uLrkddyD1hGPA3eWsbwXJK
 zi13cXvUEUWRKOyLfnvZzSA8r6wzIfUDH0Vxs6dQIxlaPheEZ27Srucp63P18GAgUjLpJfWeDKy
 wH3CqslfkLGKKx8WtjWw49RffJTcJZZ/4IF3cOom5qlVyEo574o8XqfhWDURnJxWav20t5YwO40
 uMX4v8SX5lp838MkPldY1YnHBwEKL65UNZ7sju41lyowfZKhlBROaU49kGxfuZ3gxw0I7vIEXN0
 Wu5LSidBz0sHFJq6ZxqFpRAKJbSga1rmeHAdxxmieXaVMuwHKUxjPWbh4cTDtnMt+fyoXCXT5at
 L7n/kKEGoMh4A7651+8hMyt/JvjSJtbPnexHkZ7JgVo6aZCj722vwoJczTJZ8f71qTWP1dkUhMa
 +WGasmxwaasiEkAkt5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfX+ZrsN1egaeK+
 8RZPxAmoma545u2XpttzQk8cKJl/gjDCbPnaOiSN8xClw+gsOFJh5v5KGaoQvK1CRYECdW2/Khu
 XNAkVPxzIyz0r8xz6khqH6OS+FTj6CM=
X-Proofpoint-GUID: XfuPk9B_GjmtojoXuvzbhmLWeROm4dDm
X-Proofpoint-ORIG-GUID: XfuPk9B_GjmtojoXuvzbhmLWeROm4dDm
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a609048 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=lI1Ai5pNZShcQUXG_BQA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220092

On Wed, Jul 22, 2026 at 11:10=E2=80=AFAM Daniele Palmas <dnlplm@gmail.com> =
wrote:
>
> Add exclusive open mode capability to AT and QCDM ports to improve
> compatibility with user-space tools using the Qualcomm diagnostic
> device (e.g. libqcdm).
>
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> ---
>  drivers/net/wwan/wwan_core.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 8168239e52c3..8acb09dcb83a 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -22,6 +22,7 @@
>  #include <linux/termios.h>
>  #include <linux/gnss.h>
>  #include <linux/wwan.h>
> +#include <linux/tty.h>
>  #include <net/rtnetlink.h>
>  #include <uapi/linux/wwan.h>
>
> @@ -79,7 +80,7 @@ struct wwan_device {
>   * @data_lock: Port specific data access serialization
>   * @headroom_len: SKB reserved headroom size
>   * @frag_len: Length to fragment packet
> - * @at_data: AT port specific data
> + * @at_data: AT/QCDM port specific data
>   * @gnss: Pointer to GNSS device associated with this port
>   */
>  struct wwan_port {
> @@ -98,6 +99,7 @@ struct wwan_port {
>                 struct {
>                         struct ktermios termios;
>                         int mdmbits;
> +                       unsigned long flags;
>                 } at_data;
>                 struct gnss_device *gnss;
>         };
> @@ -748,6 +750,14 @@ static int wwan_port_op_start(struct wwan_port *port=
)
>                 goto out_unlock;
>         }
>
> +       /* Check exclusive open mode for AT and QCDM ports */
> +       if ((port->type =3D=3D WWAN_PORT_AT || port->type =3D=3D WWAN_POR=
T_QCDM) &&
> +           test_bit(TTY_EXCLUSIVE, &port->at_data.flags) &&
> +           !capable(CAP_SYS_ADMIN)) {
> +               ret =3D -EBUSY;
> +               goto out_unlock;
> +       }

I would recommend simplifying this by relying on the already existing
wwan_port flag introducing a WWAN_PORT_EXCLUSIVE. This would also
eliminate the need to check the port type in the condition above.

> +
>         /* If port is already started, don't start again */
>         if (!port->start_count)
>                 ret =3D port->ops->start(port);
> @@ -769,6 +779,8 @@ static void wwan_port_op_stop(struct wwan_port *port)
>                 if (port->ops)
>                         port->ops->stop(port);
>                 skb_queue_purge(&port->rxq);
> +               if (port->type =3D=3D WWAN_PORT_AT || port->type =3D=3D W=
WAN_PORT_QCDM)
> +                       clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
>         }
>         mutex_unlock(&port->ops_lock);
>  }
> @@ -1031,6 +1043,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_po=
rt *port, unsigned int cmd,
>                 break;
>         }
>
> +       case TIOCEXCL:
> +               set_bit(TTY_EXCLUSIVE, &port->at_data.flags);
> +               break;
> +
> +       case TIOCNXCL:
> +               clear_bit(TTY_EXCLUSIVE, &port->at_data.flags);
> +               break;
> +
> +       case TIOCGEXCL:
> +       {
> +               int excl =3D test_bit(TTY_EXCLUSIVE, &port->at_data.flags=
);
> +
> +               ret =3D put_user(excl, (int __user *)arg);
> +               break;
> +       }
> +
>         default:
>                 ret =3D -ENOIOCTLCMD;
>         }
> --
> 2.43.0
>
