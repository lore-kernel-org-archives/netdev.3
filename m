Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684D444716
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917362; cv=pass; b=idTZM+3Vuy249kEMHOT6qDL69XMQ3EiHquPEg4Q0FBAYGxbK+9/aUjJq3NRD79qrX5n8pD+urzmStPjkJ78tj0ZtlN0V+y3uYHg0RmrMan0st82eF3BMEKY3ux0Ws8anSCWSMEVlPbSMSO0wojpI0Ve69oLhreoTO8xM2hqQ40w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917362; c=relaxed/simple;
	bh=BaDEW4Kw0UFLMLjmpgBY9XxkSDSx5RzGKaTgky3g3HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2sy66kMXmVX2oBDPfe4gIA/1G3t8Y/4yo/WHpCfm8tB4NSIyfbnLQv8zeqhy/PEt+jxb2cHj7iWIW7lqCw6LpZEuN+unas51kFsCm5fgDU5KE9z+jvQQl08AqDiliRYXTb6IsPdap2oK6KrjSJTctwuMjxSsyhkxSMAh9nkT7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=paRKfpBK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jqpc0ih9; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="paRKfpBK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jqpc0ih9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OGrBO63628942
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FoCXTYJ4sQumIftnxF18DxoX4FvHxTEP4RAQOXs1gBw=; b=paRKfpBKiU61VIHp
	55luVi+n398tYthDUxfn/8/kdYWZE35fTMAXVsv4J2uwUtndNGzweHANJVkwCwnO
	plHFi6UKo7U3sLPgSsh6Z3P+iKwLR7drfWFoqQQaev3YUusyaekFr93hf1/dnI46
	CTvxBqm/vEXfzD0OLvc1hI1BN63OxKI0WjTYqDaiNrDZ+W0JDKmKVk7o6FUu5AKH
	CT23TK9rzZIHInX/qYRtSQ5F2JfKyBYVTukR4lm2NtorBXgjYffy6EcGq3NDTaNr
	+6tyTCn+CXmviLLDVNXQ6PbBVizbbUob0ZFgEbR1y8xnZtRpg4SEqBahJGer00tq
	bag5iA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yahsgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:22:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ef31cd429so91191685a.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 11:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784917353; cv=none;
        d=google.com; s=arc-20260327;
        b=hhSnmJr7TWl7Xh88z6atw372c3hQRyhaL56rDMPerfTu5kesYObo4eHI0J7DcbsnJf
         98Yb/9kHOYLna8uzexTqVOF1d8n4HI8J25KWf7Fzr1bY0lfR/8hfpu011ladjhiZyv/G
         7Em6PeN64qWCpm4Q6AbOLgHSPm6zaw9ldWkqE5Ac7R715uvdjzx7cZKTxOXT+xR936mL
         AHav7Ro/dFIzXjjpMeXXIIGLjjDaRGBNuw3ir49BtAHaLAAWQTNDYwnUeZptBAeWMFjY
         XPkEvkdhrJWlO/BE82R/fXAI+6kAy6Enc0MMgUQlnOBjQaYKpHLJn+2CCL7JN45mVV4r
         oOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoCXTYJ4sQumIftnxF18DxoX4FvHxTEP4RAQOXs1gBw=;
        fh=LeXVFtiIaSz/zkSauafhJ0LtrGvj2rFa8/GHej02YTY=;
        b=hlBza6X4Q5WGa6sElk4RLXAT6CyEu3a9oFMphcOm9ruoOZHfG9zZqCk9w+/XDkJCTk
         qfzVV/5Lyw6puDVNE91iCtZOdEkiUYy4+PVCIcc70P99L4l1LMOArC3OoOlk87/n7sab
         X1D84OAOJvtWEo60gF8q8oM7m1t3IHVlXf+HC1VCwhjStUe+rz1QTLVvYhpPtboxBJr2
         MIXpWqe/APfV8t89ZnP19K5fI409SFL3JZEtWIzl8MlGFF0tcTxycRAyhbmvfIkXfxFb
         8vr7nr/RRBTxURnWXot5yhC24I4a69sH5YVUjqD5XmLeb8WXx/kZL77vvDh3YNchm43H
         11QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784917353; x=1785522153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoCXTYJ4sQumIftnxF18DxoX4FvHxTEP4RAQOXs1gBw=;
        b=jqpc0ih9Jkar+p0nGo1D2t4MF0ncXumDw/L0b+Myp4vR4tzbfQ/cB9fQOpKLl4jqSK
         +ACgXTP3Y2xhErKp3cLqiFU9AMaliQ3KQTWvnioAIwp4Mt8pldnONjvn0kidC5xaFYbB
         eSTDWdpJp+zxFus9c+GGDEz9m4XGabLaXHG+YrnG6Q+wqiGRETLzZw0maT26XmMyJ+g2
         T3F2L1IJqtKaNboipZPsDbWiocANHtjbWItNZZFQkGBFQ2rpF5m8rx6TGcW3fh4Y93dJ
         wm/kTBqNIpU+3yGR+s9+a4K4s1DO7BJmIOXZE/dKkD88iLIffllSMpdjldImj8jAgdpO
         HwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917353; x=1785522153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoCXTYJ4sQumIftnxF18DxoX4FvHxTEP4RAQOXs1gBw=;
        b=OEFKYS1YIy92c6xdGvg7F50XeT3m2RdrWiPZwHj9exPZt76xde6q408ypZx3PcD6kq
         NPEzjb8uSRAeeYwTgv8HhOkQ/kh35spw29Aw6u1QFPibPqvU3kNWNlpKuyW7Jq9ICcBx
         rDMNv5zWHhblix4plg5ZoYLVdajCGxEdBUKFyOqOpDQjAnr7G1lQc+xpLN0z6gNMrLXT
         dgq0OfQ+kH6hJQjMeMKXzVc8rOR2mpzutVGLZQA3N+pwcReW/W3og7XtIrp7+EkS/jxl
         An4YPCBhlTTTtgv2uh/wCsb16L+KkVDQ0Yx+VbkvYI/ZDh5P6uWWXkR42yqvbMjDbxoI
         r8Lg==
X-Forwarded-Encrypted: i=1; AHgh+RqgIZaZngsJRJ0qrkcxVHq+8R+ufcyqeE3wgFI8BnvljqggQD2YphCS1O+Cnu/Do/29X0fOiKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1vFUGojUCIOFV40bNpZsg8roLVUS1rkKyWWzHQV6VPKbTvzr
	Lq2CAwDXvqTon0dis0CYlA16VZdB0dh8piaVwg4v/cfoCKYm05ktF1gaTkLBoAUXGNxv6UZo0cG
	VJmMa9lJQptFMBC1okcWxtQ6NKMMJjbkRoUG2onqZPGRFTVSYSakSrrIBk+tqWFIi8T/BjFleA8
	9BRfvS8AE6fFBrhrqd1HHdZt/C+LmRT3Bs9arzAN59Mw==
X-Gm-Gg: AR+sD119sT1S/hvYAuqfEugiboupUHOA5ScRwtn5LF6r8CNS3+URPj0aTe0amO705mW
	vulIvipvQ+kM2npmU+DqaFiQUCvNJVi9cJlzesakgyeaBFWQNV4qelAbfbHg1le0g+lgZ10jVJE
	SStit0o4ZTHdrqMHheejz3krlo+k/TWTCmk+NafWpfEKANkAr7kKu2ILPwXeEquZ2whQ/ajuHKr
	MXhkDkhOe+CfRAGVG7u3uAbgOoB6h/DOCcGiE/zpf9e5SBhg/bg1RZ5JquDlS6IC+V0dYRuC9g=
X-Received: by 2002:a05:620a:4706:b0:92b:6805:9197 with SMTP id af79cd13be357-93103910d40mr987775085a.63.1784917353468;
        Fri, 24 Jul 2026 11:22:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4706:b0:92b:6805:9197 with SMTP id
 af79cd13be357-93103910d40mr987772485a.63.1784917353032; Fri, 24 Jul 2026
 11:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724142909.3270824-1-dnlplm@gmail.com> <20260724142909.3270824-3-dnlplm@gmail.com>
In-Reply-To: <20260724142909.3270824-3-dnlplm@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 20:22:22 +0200
X-Gm-Features: AUfX_mwCGyAsZagm5QhLdHjg1adHZWrNfL8ZeUXsyQFRx4srozYxezt_5pygFic
Message-ID: <CAFEp6-3WtvrymbQvrq_oTnuFOW9AJJhxX=Kj92cEG_GxeZgeRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: wwan: add exclusive open mode
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NSBTYWx0ZWRfX6isJ1+ghsMRL
 njCuzZF+5SGSN+DZsA/yPt4z6vrnEioymLq/Y0Abi14G+oDUF3ZK6J/wOuyi+ekKNOLJ9BpVD5y
 nbDIYXhvHZRGil+BJSWFcPgNpaUGrfk=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a63ad6a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ai5p6xNhIYTwrweCe2kA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 47Rp_G2vjF1wDXeTUajV00y5Hm3wXN8v
X-Proofpoint-ORIG-GUID: 47Rp_G2vjF1wDXeTUajV00y5Hm3wXN8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NSBTYWx0ZWRfX4VM8Qkrv9I8e
 8zo14jKIdqVPm+BKi8xF1tbQFGvaKEZVAJXJ0TD2M9y1c0hY79g0Rjwxgk/8P4FIA7YGzvbJccO
 ITIJZqlrj0IUrLNAQUE0TPGJJhiEgyIC7ebtGeciux4qqvmLz3EyiAe/CghJ3iGW6C+wXx7OtWh
 LMCJY3E3NHDM6FXON3sjCirvpGlY/98auwxyBNsIcobdg+lX8yC/OK47PsmKCtaHg5i/fpJXSFg
 Q5WKUvJTzo3G5PCVXv8xznW3Msvi4IqBy99qXEJiMlptK3KDYf64cFegxaunW5BDkkls8KRiBZY
 C2dpqQoHaRUrUZc6UezlFCmZAdswCmGyF8ehsr7CMODaVCn8rU253+CNeEtSzqjqJ9byJmwIMMm
 KFgbuU/J22xrb+UffmPrpiGEeWRLZfGJ3SI85bT7W7szG4X8sUOOxfVZgOqIhJEMGJ9XP3iYwoH
 g5KHs/Jskb6Jvmay1HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240165

On Fri, Jul 24, 2026 at 4:32=E2=80=AFPM Daniele Palmas <dnlplm@gmail.com> w=
rote:
>
> Add exclusive open mode capability to AT and QCDM ports to improve
> compatibility with user-space tools using the Qualcomm diagnostic
> device (e.g. libqcdm).
>
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>

This looks somewhat fragile in scenarios where a process does not
properly release the bit, such as on a crash. That said, it appears to
be consistent with the mechanism used by tty, so:

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/net/wwan/wwan_core.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 8168239e52c3..ffbcf11e4e68 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -42,6 +42,7 @@ static struct dentry *wwan_debugfs_dir;
>
>  /* WWAN port flags */
>  #define WWAN_PORT_TX_OFF       0
> +#define WWAN_PORT_EXCLUSIVE    1
>
>  /**
>   * struct wwan_device - The structure that defines a WWAN device
> @@ -748,6 +749,12 @@ static int wwan_port_op_start(struct wwan_port *port=
)
>                 goto out_unlock;
>         }
>
> +       if (test_bit(WWAN_PORT_EXCLUSIVE, &port->flags) &&
> +           !capable(CAP_SYS_ADMIN)) {
> +               ret =3D -EBUSY;
> +               goto out_unlock;
> +       }
> +
>         /* If port is already started, don't start again */
>         if (!port->start_count)
>                 ret =3D port->ops->start(port);
> @@ -769,6 +776,7 @@ static void wwan_port_op_stop(struct wwan_port *port)
>                 if (port->ops)
>                         port->ops->stop(port);
>                 skb_queue_purge(&port->rxq);
> +               clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
>         }
>         mutex_unlock(&port->ops_lock);
>  }
> @@ -1031,6 +1039,22 @@ static long wwan_port_fops_at_ioctl(struct wwan_po=
rt *port, unsigned int cmd,
>                 break;
>         }
>
> +       case TIOCEXCL:
> +               set_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
> +               break;
> +
> +       case TIOCNXCL:
> +               clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
> +               break;
> +
> +       case TIOCGEXCL:
> +       {
> +               int excl =3D test_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
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
