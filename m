Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF14D599C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474056; cv=pass; b=KVJlDMo+IIzaVmSqyH36nlzF7tW/fm4rIn5SKbbR4kg0CY6+Q4BMV37oPnr/MJMeObQ6zADksYawRLStVtuOepB8Dkn25SOW5h4oHnGa4GJwO1bf2uYLVi6CR+Un0+1kq0gWPX1jgjD4Mt1vD2c1cZQWs4xIUpcM3DGg/uYgIzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474056; c=relaxed/simple;
	bh=slHR1YPhUF2z2kHNvGzhmvIQDaVz3ep5Ayu3yeXEfQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5tvD07cxPnSk9kMTNmU9DyV0mY6wcLcRMtPsb4HFYA6mBjVqB6qpqXOtw1Nf6iYtKfnf8TkNOsTIAUkOh6GvZW/qzUO6QKJhU/8rOM1Sfz86iZ/2sWHX/jnS1PbGVUBgZMtered6EWHj0S+WwdwI8+dgdpMsJVSD7PGfbrjKQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=miALOFsE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dFhwebxJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="miALOFsE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dFhwebxJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVDde3017498
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 15:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=; b=miALOFsEvXC+BHex
	VPS5UDhe+EAl/hpkRBmbgkKUSW3YhYq8c6TDOMQo8yjC7C5QSLKDKsHG2EUShkRz
	cInGnpWjWX9lV8b8XM1uak4uv4P5GoJX708boKAxyHFR4bJG6CFtRQ8BuyTQjAGT
	Bd5OEfn49AmVigZbQ40mLDsGO/ygoOzcGMEDaMw4deK91qbUN1iljAYC2m3Bx22E
	Jox3jhvBnPxXrQbCx1UavRJU8pIfWe3mbP/bG30NWK+0Ts01RPm51/NCiWvSmJ9T
	ncME7QLp0Ln/5G6fib+V3tGHIUneif9gqnZZPLDKdky9xOS85XEAmutg3zQrxI4F
	mzzpvg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kgpjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:40:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbacbb996so883801485a.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791474053; cv=none;
        d=google.com; s=arc-20260327;
        b=slrpI8eTW+69XpaodTM54AyR9/yZ/KgYJ4iSovXGPncBUvXXc1b7LnbVqSLrqsSZi/
         3jpJMvnBWDRlOswOqi22AlmFoDRUgrgAGJszTYWCpUnm+gXzY40RXJCdfscP4k1NcZJc
         NT5PV/pDEA3ooDgOJXrbMEUyN2Klor8gSpquFJj8UfnoC0hpMdHbIX1F8Fg/ojI1b+g2
         nXCVadzyQ6rp9biMmfu7Vbhy2+IahMtSNV7yl2vDl4PgxN6M06TUZj/PGQMt2nnR3MoJ
         z86oErjEvN1P1Xzcs18GSmu9jYDYeuBCt4pWxlGIiuPOOxg3Sw69Q19zwogIYso4qtIG
         PmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        fh=Tnhp5LvBYXHRHbjqSCAvHI553mb+HHb8lDmCoePjPJY=;
        b=X/FIHryQaXQ2kxQGeqsDx7ZmRRY3yW3baD7EicFqPbBSu7emnwx9a7sqL7pL68Pivj
         g19Fto7zPIr1w3JZWvFkGVFtQobwYHqryBv7o7sT7f0lVFzGYEaEHfFedy35oxVTY7I1
         F9tHzMFJitKrlHy7OB28za8vVD32YwZT513a7/jNktQ5sitOrXkPByX2qMq+7qW5iioj
         PMaRk+kTYn/1j0Lra6sSKptE8TdRpIU9FxYwS1dpFtGcCf1qWO1/65KL6l7YQjBKj+g5
         UqSTmmNwe0XHdlAcPemUd3AAesPxhj7iBe7FdocXkQnUuQpmjmr4Sbni6hl1xfzL+qpc
         s0Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791474053; x=1792078853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        b=dFhwebxJiPe7dwkLsc8puOiJFVNFtfLCW4Svzin9vxvj8ADbr9r/JDf0afbyXUTzNK
         mpn8dxK6y+79rRWttt5P26f/A/2ChKy2rhXOhWMgUVfsWp8C01RwrethiLtg9VXtzOoV
         8g6Ku81rZT2XdTCYhA3tgqQE6ao0thT3X/8wL6E4fxsZ/H2b9QLW+QbzZPSsquic/3h5
         lYSBPL2QN3d6Vye8TCjYoTzoedjNHT1rAFBhRWXsIax3rJF/UXSjwj6FjUIOEErHX6gY
         U9sYZmKhAWjFIVrHrVPU3UUnNKtm2NVuaDOCrNfThcHzGrh0FpDQP8ETT74tS6lPFAYi
         z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474053; x=1792078853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        b=HHsIdySi0cagNzFH8JfiIUzrNnLhP+mZqESlXP4PkpZcgSVgHzOdQBVnrJZTEB4coA
         OsdpqJgxZDHJJsHfCyF65brbrfwpVKt7tjm2jo+htCyCVACclWIKSDi5CFgVCse4Myut
         qhuroWeSn6SKynxR3AGh+pg+Fu5LGrMhYw9ITcr+GaxHdu5L5kWuo8o9CrVwSkBw+2Dr
         byQ8ztP4TL1yyWa/vwIq3EAHsvatER+kjXJp/7uX4FqIAzec59G9V0NjU4JWJHC4Sscl
         vBG/X7X7vVk8ybZbSEPn5SjX7f/p/DTtwPsJhJMtYywPyoygThQKbZO2PTD8yUlAN2bN
         Rqng==
X-Forwarded-Encrypted: i=1; AKwUvBzSKhcoZZcINVvNfZaObc9fP31OsAQAZT8Bla56e1Kao0Q+ezEabIMcBJ3bcjJaxaLIuxTvJIE=@vger.kernel.org
X-Gm-Message-State: AFuF++n6324A4oLBSf5diVpOwnW9c7Xp+nalu530CmIrVVRLIVp4RU4F
	B5r15RybHU/R88ViSyFYBP2CVYuLgcI0y3Q+/Q6SMkhdqhbgb3iosrErbPTur4Ix2uFwRR3P/xi
	jDeTKHUhYSl/PuJox+ZnFi3sFgFQA3RV2GSyhcGCWnVamDcadYcBL9C1bwKIeB4Jj7BbTmRf44x
	x88iYXbR18XzHpmOkJgTMrlX93yX6NE/QGpQ==
X-Gm-Gg: AYBFou0L6wKDqR9Yw25vprEYcRQ1RIbWEgJxnY1DLq+UADU23/0q8BVjaffu43LwShu
	svFYmDXuTY4ibO8F/AerQ9GLYLC2Jtw/W7vbs0OvSD6fv2KCQSOhsQuSsCKSUyvYDnI8OWapWAs
	59jZqa/JLKPOFn3M16AQbnyLVcRlRm2T5Ir+ZAVtF/CIwj5Jsjt7w8yww3mfiUuaRRB/zFAIJyc
	a8C9MCuii6rXt7TByw5tKw1pGhlJhXIcS2h1x3f1cctLA+ueSG07qd2xczGyNxnz4TNAjPK0Qg=
X-Received: by 2002:a05:620a:6f0e:b0:93e:980a:2ff0 with SMTP id af79cd13be357-93e9b7fe93amr1059915685a.68.1791474053418;
        Thu, 08 Oct 2026 08:40:53 -0700 (PDT)
X-Received: by 2002:a05:620a:6f0e:b0:93e:980a:2ff0 with SMTP id
 af79cd13be357-93e9b7fe93amr1059908985a.68.1791474052817; Thu, 08 Oct 2026
 08:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008130753.313875-1-dungvn2345@gmail.com>
In-Reply-To: <20261008130753.313875-1-dungvn2345@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:40:41 +0200
X-Gm-Features: AclHuK91Ghq1YzJ21SVhtTCbMeYC0aUPIQJSnVLk0PyF10TXbgdDoIar-HRc14M
Message-ID: <CAFEp6-1EHK+H+mvetOvDbQP8CD_JXtt8a-5zEA_bpT581Td-PA@mail.gmail.com>
Subject: Re: [PATCH] wwan: wwan_hwsim: Pin module for debugfs file operations
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: o16zASx6fShnJlLXHENt5-IYg89AjieX
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac7b986 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ICYLl7Pk4l7hwN0V23EA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfXxHTl3etX3U+U
 BEJK8fN9TxsaLHkz3mEgJBhylt+lo/y35y0aMBR33UHyTqDdwXKVzniCM6kEhApFS8CZy+2cilK
 vkD0hhAgBjo7vvFUIeUKfBM5Z7hnxmw=
X-Proofpoint-GUID: o16zASx6fShnJlLXHENt5-IYg89AjieX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfXxUFods30maLz
 309nH7qqySZr+sx9O7IXeDsKSNNyf2UnIJ6lQQxgckyGKolz3zakeSPIRN1WLyEyXBsfgfvQPwz
 o0/Z7k20svPf7fSm1aR1LnbyjY+9vV1AIx8QiVct930ntCu3MapuvYTA+DVKgYOp+NSAhX7y+aU
 3Drf7hqu66nxuWhDsRUr1z0lMuNr7bq2auA9OoYOm/EO5bwN//5JU0RPPuIqNU4vlpFLh2FyjLq
 1vga5g1FxxhGEA0impbyOPO6ZtRFPaMbmkl7dagmdWpiYnnwm6i4biBOX76pjdv2PpniKVQdQUg
 zgHCnGtDq6DBRrHsfLfpyVG0asJFlp0/skF/7OY41D6fF44NpQ+yBKQmNsIt8F0GNNzf8+rLfV7
 IcBWS9q3+YhhuGOCXUOD8hej/mR9Wgw/8uP5YS2FUvGDksgizgBgzP5x5VuA59681qAiDQQwJaf
 v7sPu5Iv+hG7AWrvh2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062

On Thu, Oct 8, 2026 at 3:08=E2=80=AFPM Bui Viet Dung <dungvn2345@gmail.com>=
 wrote:
>
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, wwan_hwsim_debugfs_portdestroy_fops,
> wwan_hwsim_debugfs_portcreate_fops, wwan_hwsim_debugfs_devdestroy_fops,
> and wwan_hwsim_debugfs_devcreate_fops in wwan_hwsim.c have no
> .owner set to THIS_MODULE.
>
> As a result, full_proxy_open_regular() calls fops_get() which succeeds
> without taking a reference to the wwan_hwsim module. When a userspace
> process opens any of these debugfs files, a subsequent module unload
> (rmmod wwan_hwsim) can succeed while the file descriptor remains open.
>
> When the userspace process subsequently closes the descriptor,
> full_proxy_release() accesses the already unmapped file_operations
> structure, triggering a kernel oops in full_proxy_release():
>
>   BUG: unable to handle page fault for address: fffffbfff84f90ef
>   Oops: 0000 [#2] SMP KASAN NOPTI
>   RIP: 0010:full_proxy_release+0x8e/0x140
>   Call Trace:
>    <TASK>
>    __fput+0x357/0xaa0
>    fput_close_sync+0xe6/0x1a0
>    file_close_fd_locked+0x17e/0x2f0
>    do_close+0x33/0x70
>    __x64_sys_close+0x44/0x80
>    do_syscall_64+0xc3/0x590
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>
> The issue was discovered via manual code audit of wwan_hwsim.c and
> reproduced on a Linux 7.3-rc6 test VM with CONFIG_WWAN_HWSIM=3Dm.
>
> Set .owner =3D THIS_MODULE on all four debugfs file_operations structures
> in wwan_hwsim.c so that debugfs pins the module until close has
> completed.
>
> Fixes: 9ee23f48f670 ("wwan_hwsim: add debugfs management interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/wwan_hwsim.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.=
c
> index c3c2d2a68767..34eea3edc824 100644
> --- a/drivers/net/wwan/wwan_hwsim.c
> +++ b/drivers/net/wwan/wwan_hwsim.c
> @@ -500,6 +500,7 @@ static ssize_t wwan_hwsim_debugfs_portdestroy_write(s=
truct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_portdestroy_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_portdestroy_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -524,6 +525,7 @@ static ssize_t wwan_hwsim_debugfs_portcreate_write(st=
ruct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_portcreate_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_portcreate_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -545,6 +547,7 @@ static ssize_t wwan_hwsim_debugfs_devdestroy_write(st=
ruct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_devdestroy_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_devdestroy_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -568,6 +571,7 @@ static ssize_t wwan_hwsim_debugfs_devcreate_write(str=
uct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_devcreate_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_devcreate_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> --
> 2.43.0
>
