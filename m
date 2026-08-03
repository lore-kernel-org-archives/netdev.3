Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499764322F9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781748; cv=pass; b=hMbr1QCy69Vlrs3B12hSJXEB+4LrJAe1GsMtVF5Q+IdrQoBbB6z35xpjCiLRoblncTvD+ig3m3AktrMp2xEskcu3advQbAY+upUJe0Sg/WXjke0tcf5/p5YJxNZN5cOutHqC9WmHIUqkHTnIWPUzGB/M8Otw0iNGn0himPXAVOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781748; c=relaxed/simple;
	bh=E1TyiApiS5bm5Tut4IctQMM+vsxnN5fZtwjU08KtTEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NClzofcaTwB0r26OI5Z5eRy6HSXFsfdHyPfmsWG6iznjNSzhnQUCIw4yAYoqfZ2Gl9xQ4r7cvxFG9HdoKWRHn1cFX8eXFbmrB+ORhE6/gYcSuCoaUprHsfdAwa09AjQyuiTEO/j8YL+JrFtqtSgNunWAabygUWRCHvNAZJBN2VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOsysA/m; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOsysA/m"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacef7d299so19505ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781745; cv=none;
        d=google.com; s=arc-20260327;
        b=Ig+GHmQ7Fe6EykKXSjY2jF2pkFx07D8K8n2Ay+NISbONHEZvpQR8mkuzXMaEgYPH8w
         H/oC2K8apLgACqkGD9vKWDApJZYDetqPbAXXPFGqRXdQtgHx6q+rWp0x5KeK/JqGLaWm
         MI/M3mS51zQT7t4UjRKEYVbTNLM7EXFDVoBYnRX5BmxM5z51gyZ1ewSmNzv2UH9Q+Jhp
         miBqj1R1ACWd3Bw0N73fMrt634mCY5IleoWaYV4iOwc5Ic23w5HRCnp41f+qMxjd1sVu
         Ka6YT03yVlaRq69V0DAuV6yG3m2PQ/AovtlVMbpocmZaprTUMavNIAsE7KtkbqX0rbdM
         le3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        fh=5m7J9aZgDgy5VkeXLqWeITOJ8ntV0n9QtxmYINAGVjk=;
        b=S69rraUCP3fVXY/oKd/iFo2e39+tQ8MM+44iBG4kq77ma6Qjq2sNHBEYFOxgme2zsY
         GGPd21uoZUHGMFNKmqToSrcHz6+yiizVX/pg9+tkziTY7OV3Ig040u6UX6CPpeFPf76G
         +tsLQZJZNpZIlfvJTBwndWQ0KH9A9Y7jMA0hE5bokZL4m5y6EN3cGVjP8s23zL2unc/R
         nusvWOWHx5YHZUNNEWbTlk7Fm+Zl2NELz+QYLTm6gN/OVu3URdSPDCqxbY9K8JmZXp8a
         rKdW/sLMCzbG81mGsn2hFMhCFRqNbkoCDv1bm+iN8Sd4tm6aNsxiiStLM2hSm+uK4TWX
         81OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781745; x=1786386545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        b=UOsysA/m4xzaSv9EmCuqqFCmJelENK5zKJe2RX6RS42YGe+KbxDIShwX5dqhg6sr9K
         TF8Ct766bgV3bvSGm8EefCGQRQvxn5c8+7Eixq0FZRUyCZs9HSrhOsCeFFmDXM5S/hCX
         y4R7gOnZO4BCnoDyjuHKjNKMW7qR+kI5TpBu2+eGzh8D1WZ/XCxBr7nJSxctVmzVZO0T
         mCIgaExokwYUFjfir8cZo811MR2292sr4QaiNcXlSEqHLbbDBfAlaVgr5eKogUspEGR0
         nZaMeDofiRUJN53oWzRil26492UG+3U1R8iepQYLB29xdulr4VVMsC2DLG9gZ7/AHl24
         Xwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781745; x=1786386545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaNYqJr1zGl3zigrxrLoyTzIuzipTS2HMILZRq0rjdQ=;
        b=oC6Cb9l+S+QMt4Wlkp8vvVDKsBT+xy7c3djqygzJahgHSrtcjMi3FIyHExOkInzj2q
         nC6GhbYyMjUGrnGbKbC8XySW4W/iX98XPp/T5P0ww6o3xL0aFGi6qKaYPV6EaoD2CUae
         jbwwrSzjUu2u39cI8txW6+DGRj5UerAc4rxydR4jU/YUp+YezgUhes/QoisHc7KugnFS
         u1mdF4/c42T7LVtKPBg32H5++pDlN/BPyO3ASlxvrH/+TNnRINP+eJHF9bS3V8ncpSSe
         cPG9DrO6aqOyZWOLc30RlGRija+wsvSR/10MokIvfTxP1S+2wsTi/NcsAeCqNzKk0c/g
         srMw==
X-Forwarded-Encrypted: i=1; AHgh+RqEYAjolux3Bkwsix079y2dMa/+uiQO8RDcQ7qzbfcsfwfUGTBo4HbvgVQRImm1QRrLzg7Jf7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOT4/36Q1QmA7FUBkcS3i8u+I4PePTFYikNlcGFpFAK1iG/vtR
	haFJPkBn0xdTCa7ceHUhsMXgf+n80Mr59PJhMff49sKmmMWEU4EsUcgC0wghtfVrsjCzLi8wAvO
	3+3zEp5ImxJDVLnDo3jbeEhQUswluJBebfrT720Y5
X-Gm-Gg: AR+sD13T0xg7v6dEKxFnt9LXiTtNjNGZQNiamaQK8nJ5HD1Bmx52l1c+DeRUY8lPRSS
	/uLrC5zEUokYECPcqWCP1HonYPjpZi7otdPzkPOa6wVemEfeFDqwD/s1PUqaVFsxvOXaKLcl/m7
	BOLQL+bR6inG5OzWWyc501UczRmvF1gDO4BjgQlOglfml87ecEd1sUX2pQ7+jby40O5GCrZn2D1
	e/3mhAgANZe9r/CqrY61BayNgen3Tvf5r5vh/SoL3ao2Crnpcqk6YnH5mzs5h+mCf+DaLi5A6Y+
	V6+3zu68UMhBNdvg5lblqtKxTNnDpErwZUUmew8dSweG
X-Received: by 2002:a17:903:1aa6:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d08cbbfdc2mr1235065ad.3.1785781744793; Mon, 03 Aug 2026
 11:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
In-Reply-To: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:28:52 -0700
X-Gm-Features: AUfX_mywewkX4aY3CNMFdzMOYyTmV4cVRuojkSA4Tcxx7W5h3VoMAU_1bnR2eHw
Message-ID: <CAHS8izN2q1n4VEoTQ9PcMRCwBrekQx=hXXZ0QK53U9xzXfxhSA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: enable devmem TCP in the
 test config
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:38=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> The config fragment already sets CONFIG_UDMABUF=3Dy, but kconfig silently
> drops it. UDMABUF/NET_DEVMEM both depend on DMA_SHARED_BUFFER, which we
> can't enable directly, so we need to enable a config that selects it. We
> use SYNC_FILE for that purpose here.
>
> Additionally, we flip on CONFIG_NET_DEVMEM as well.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

While hacky, I think it's okay to find something that enables
DMA_SHARED_BUFFER for us here.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/drivers/net/hw/config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testin=
g/selftests/drivers/net/hw/config
> index ed8642b68094..d89a9ba17655 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -15,11 +15,13 @@ CONFIG_IPV6_SIT=3Dy
>  CONFIG_IPV6_TUNNEL=3Dy
>  CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_BPF=3Dy
> +CONFIG_NET_DEVMEM=3Dy
>  CONFIG_NET_IPGRE=3Dy
>  CONFIG_NET_IPGRE_DEMUX=3Dy
>  CONFIG_NET_IPIP=3Dy
>  CONFIG_NETKIT=3Dy
>  CONFIG_NET_SCH_INGRESS=3Dy
> +CONFIG_SYNC_FILE=3Dy
>  CONFIG_UDMABUF=3Dy
>  CONFIG_USER_NS=3Dy
>  CONFIG_VXLAN=3Dy
>
> ---
> base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
> change-id: 20260731-selftests-devmem-config-f4f843f0f0ad
>
> Best regards,
> --
> Bobby Eshleman <bobbyeshleman@meta.com>
>
>


--=20
Thanks,
Mina
