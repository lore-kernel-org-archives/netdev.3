Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794236074;
	b=sehghjmi7OJcGM3Yy+XrIhqDI7cmor/S4vFyOuf+7oCCAI1PxnvEyEf5cyXkIdj+7/iw
	 USWr2B5ltoRmYWG9azhUti8ppB8GFVrEEqr7XyZTV3eVcY0XRLrbyMLnOsWu3TVG5HNtf
	 Q0X/hhopJM+VOXfVA507tj2bfrwv8o2u9PGuqjXE9AUTkSBOQoPUMlPovKGYJkjZGKOFf
	 lx3nQcPaRpJ1sHgtDHukzEAygjZzalCBzlQEm6XlTEvSANu2F1qqaEatZxAAPayF29ylr
	 9gVN8lgl19MExKFgqh9RXYxjjU0NM4Cd661nxEapxq1lka7Hk2ml6GvAUJyrBZm81Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
	b=dGP7mjPLxKXUDYWGSyUfMvlnzSy/gV0aoxx/gbgaIt8AqOZDI0gcheBE/okkr8uF6PLY
	 +f3V2RMySLw9hJOZYedYaNqfULRqU9PlVoVuQy5Jl1XOPqJju5khQDR3RI7lPxCplUgw1
	 3vuCKDhalbc+EmN5di+pPw1hae0PKUgGEkS87X6GvBBzwWJ4Ww7n5E4Wj5KC7eihuud41
	 CnRISuQxlvZjcclH6dOTZm+fwE4gBcCprK7P+JYbu+vTtHmL9QUR7p8CelqYoAiQLeqty
	 /sJ3iIgLIXJVzQkwaNLxE6KcpIKOdGBkYc9ySpNica27dJTpLyv3CSlVtmB6j7zewnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i0L239Ly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEF606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCEF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i0L239Ly
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533202fe429so228731cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 06:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794236073; cv=none;
        d=google.com; s=arc-20260327;
        b=WXTVUn103D4N3FsH2EAJ7mOmUBxqDwPPfta+3nwadTceTkJeHcRagmYMRSXrfM1nJO
         W9vYAUBUKvYLgwfwRrJoEDGAa72icoNM5BLwooFusbCYjlrJk26jt8tb45f2eBbNyufK
         y0FxTgC1vzBfB0w6ZEtziNs4TyJ+EgkryP0wK8RVfBH2E6HkUhpfZWqU/03AsdSagUd+
         /fCdPd2N7wiKvZYJr4/lIWt3n8KPpKjZ9DpMxF51uxXHzV4+iCYnDEhH9qCVdR61qn4f
         SqADWLRExaHV7S5b56E6Ya3krcyKaI6JONy+iVHPBZlgqdfc7BZG7BU6T1uLntfT9NS3
         Oq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
        fh=U+ysQBQK4t9H4NWxgBIJBmLCO4Ca7nBRCqFYT4NiqlI=;
        b=aMAVsO7sLNzzp1WGWsLTwluU7Zi+UjEI6iJNceJSYFtEgoZE9LaKe/OygjoVOQGqWD
         AiX7IO7AixHl4t7ow5/3sNgmcbmd9xCh2xtmRRXrH0TIvFU7f5WYjfdwx1ygt1nWhuQF
         Z0lfc+kcsGW52rAUdcusQbz9UgBXbBYH6s/9FXqeA7CywoHGRTmr+8wE3dlmchim2UUr
         g9f340nE4Imb4Gp84Yi7XOtVQ771PH/08G3feEcIIG3LZWsdOl5DOfCJp/YozgHKFqxB
         DNkpWd0rGXp85b35VhUrV1FR3Vu8SYu/h+hMa2Pg3/ryzhps9krC0qb20NIcSSa2nKPN
         eFRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794236073; x=1794840873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
        b=i0L239LyS5taVUuVZGIVY2/a1cXvU3Ff5r0hhHz/SBdHYeMYijNZuMUNb0oov1J8pZ
         dbjjtQBnhfo+wuQKQOIgh/EZSfqFrx4X3PJOlSi7RqKU8Ek/PcgcKr2bBPXMC/Q7LRYR
         ow0R5YhyxfEuZlewUbhuzmJAHVhrt52nILSGfBeCCWI3enl7aUsojsx5Ufb6zWPS/n/j
         Aa5FsAlInEbzIe5jJ3BWTYkNzs7c2uTb5oA6kD3SLfZBDVOj018FHHFDLMnEQdqg8/qu
         zq6KBT16hfP1p3EuLqzxYd3muF6BIGIMEg/HITgsWSBArPs44LhJ8Ayy019s4oS4gAqb
         XLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236073; x=1794840873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uu2ycv9me8mHBGrXAn80H1Hsv9lPp2MX3pjtM0lSbsk=;
        b=fNpfk0yD5QsVdiwToKOHD4J1DxmGbjy5yx6gI8g6SnT6eck4qaqP0xWPsdjS3l3kfB
         oBJFrWiWOTLaOmbYhWCePte+FXwGP18dkFwBWi8tu3D0+MLB7uEGnWsh9SeDMNLzIpMr
         W6/nCYi4HeAHEBDaYA9f4yIkCHqEwkebg6DHbxfFLDe52rOEbNoI2ssm3f6jvl1EFvnk
         +XIZzAccNuDmyDxGOIFXJr26ynvbP6eQK2mnt5TQ4mOpOVc6Jy740/65y4ePkvSC42ue
         QQnpxLpbnL8d5zs2qsT2MCQvRCkokStJTUpPUXT9DDWq7RSJISE/gaodB/PbTQwehIpV
         NOPw==
X-Forwarded-Encrypted: i=1; AL+hErE2Q6jVmVfKW7JCIsSqng/tObD/zgsJunaZdvk+DzBHfgmXqw0CaGrUJSOs2b+0wepz3axrXko=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WNbqLBYLHXFKA/tERNRC3F7Xqp2NDoVglSLfEklbNcvQAw8v8
	bB6z+1O0PA1TmcZpHaCKI4uRuClkVxWqa1sd35oiFk71joLl8qva2Xhc/7GSogpYH6Il63UAcMJ
	KUXO7MHjBFGxxF6MAHldr8dD40O1boa6BItCa/wxF
X-Gm-Gg: AYBFou3YAl9nzrXpbWzK26Jq8k9rAOjUVrr9shbWRqzxxLGmlqpbSgBIGtwPdEaRFyC
	uqmLrEVG7+KpsgDkhXuYPXhQ8SjKFnPYv1Hpz0LYzZjcFHNwIBKEtTufaGe2Imc/Rsf2dqYatFu
	tnezgPV7Q8as+FXFbQEQ16uNVpR50d5JhVLySjMEJImI1FVIAqZThZXSVPap4nqI3ZlW0j+AQ9x
	q6i82hy5rfJlf47OUkIjWTgEMJEGONIk33TqkphqD0ff5XuDeMY/TBXQ4j5tizGkaiRh2PVprSi
	1SDCkndHd641SrqgCHa/dUNB1z++PIMpS9XjsUH/HuELICTqsRzFo/A0Yj/R4KEEUqyMSTNvgK6
	rB4/4VPLHbsAuduT2Q5gQhWXkFHinwtcRJHSx9j31ABueHTVsG5fSj7Aofa4=
X-Received: by 2002:ac8:5c88:0:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-54f9fd8f8d1mr38320671cf.2.1794236072272; Mon, 09 Nov 2026
 06:54:32 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103162326.3615979-1-lrizzo@google.com> <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
In-Reply-To: <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 9 Nov 2026 15:53:55 +0100
X-Gm-Features: AclHuK8TskNldJ9T-2m3-q5kqcKrV-1RZ0T7vtN0-Um1ktY8-kpgA25IyzuryKc
Message-ID: <CAMOZA0KTYjRGuD3axNKaNb-o5=c8Zt=zG4Q3JFxPbWuBVu5MKg@mail.gmail.com>
Subject: Re: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Brian Vazquez <brianvv@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:08=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Luigi Rizzo <lrizzo@google.com>
> Date: Tue,  3 Nov 2026 16:23:23 +0000
>
> > libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> > driver fills its Rx rings at open or on queue reconfiguration. That
> > fill runs in process context, right after page_pool_create() and before
> > the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> > needlessly restrictive there: it can neither reclaim nor compact, while
> > the initial fill can allocate tens of thousands of buffers across all
> > queues.
> >
> > Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
> > libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> > Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> > to GFP_KERNEL.
> >
> > v3:
> >   - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
> >     argument on its own line in page_pool_alloc_netmem() (Alexander Lob=
akin)
> > v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.co=
m/
> >   - split into two patches (libeth helper and idpf consumer)
> > v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.co=
m/
> >
> > Luigi Rizzo (2):
> >   libeth: add __libeth_rx_alloc() to specify allocation flags
> >   idpf: use GFP_KERNEL for the initial Rx ring fill
>
> For the series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Looking further at the problem, gemini pointed out that libeth_rx_alloc()
is called in a way that makes it easy and robust to tell when it
can use GFP_KERNEL. This would greatly simplify the patch.

Alexander, do you like this version better perhaps ?

cheers
luigi

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e6..38c0e5066f0ef 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -104,10 +104,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
 static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u3=
2 i)
 {
        struct libeth_fqe *buf =3D &fq->fqes[i];
+       /* fq->fqes is zero-allocated and pre-filled in process context for
+        * indices [0 .. fq->count - 2]; slot fq->count - 1 is first alloca=
ted
+        * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC afte=
r.
+        */
+       gfp_t gfp =3D (buf->truesize || i =3D=3D fq->count - 1) ?
+                   GFP_ATOMIC : GFP_KERNEL;

        buf->truesize =3D fq->truesize;
-       buf->netmem =3D page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-                                                &buf->truesize);
+       buf->netmem =3D page_pool_alloc_netmem(fq->pp, &buf->offset,
+                                            &buf->truesize,
+                                            gfp | __GFP_NOWARN);
        if (unlikely(!buf->netmem))
                return DMA_MAPPING_ERROR;

>
> Thanks!
> Olek
