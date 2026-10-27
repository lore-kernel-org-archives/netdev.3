Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101147;
	b=NeUUdXfUDYBRQyK86y704AgW8/yTBDB2RRbuzyHm3ishzqSkvfXNMfMma/e2kNICpHek
	 ghA+aMh8+9me+pA7VBhIRJEHB+azOVLhxhBqyjw3u3wZZuRgy83F1u5fm/Y98nyhu8hgN
	 ZZ7cRuKftWclMK0FPFRWZxx+LApQ/7XDjna4mc6zEQloq3oQlyLeVXnNh4AT6Y4ux1gED
	 4IF+p+1Hq994HpmeST/KDLC9Fd4zRQzQlVXFUWdsAn4wDe5E93/W79E6bX8cQRqIknwvB
	 UnzuJEZ8ENFzx+MJRklszNr+B6U5ZtzIJ9s9gFjt1c0mShC6626hkfpLjgtJ03RZ4Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101147;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
	b=GudSHZY1TXf6PGRXp3pJtRYBO3AZWJU1xpaute4sh7+2pQiGayNv+i6woXnEqcTeBtGA
	 QFi6G/zt5aqMU64t4lXaiy4AOn9ilY+BpsIT/sbbrD6g7ZmoZhc2qOo3+vTuIun5snjsH
	 VhrzQQSleAOjnMQc2sqXmxagYZfjpiObG6L3qbnddzgYri1enNTFW4HjElZWgCN6pfRzL
	 1ZUIZZQwxeA+Pli+/4M4KUHMUUEHzLlu1Dlft00D6LSaQFMCmpmDl3qlY7NKNUUrGzTps
	 aJqp9iU1H+72FLU/BMGz0mnwY1g/BhuyutMxRWQ/L/+KQS4ukHwIOyprKw6SBrj3Taw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="VuCRiRC/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvrbCq4V;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C660A262C
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0C660A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VuCRiRC/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvrbCq4V
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeUpM1063061
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iqD5vVTTBfwoyL27JJNk8QW9
	87++ASEipnY8mTx2+X8=; b=VuCRiRC/VaFyAGrn6r+gYBN1zvuZ/8RX7thyBd7U
	XuGZU3AtaQzIPZ642s80omtQq4OPa7YVpGQNnWd0aM7Yx8ICHzQD0+bjfUEEaF/Y
	USegby5gMJG84trbWA+mgM9AKi24d+CpFx/jkpXkLzZFEFOqA0eGJfZR3GrkMeYK
	pouWkLCbRomvOO79HB26LtD1tDnLYTssi7N1U5+6HMqhFmBOXtOu3V2symLqsZiG
	M4jsJQD3G0F+slbafLirjxbPFJmVeA8XWL+XgMfDXcm5dYkCx3M9/kzvGDnJBSmK
	lUvhGtxZCyK6bmLTxHrST4SVGPRM4k+h4qcH/hUkESavpw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2t9a78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:39:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2005ce21so673005885a.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793101145; x=1793705945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
        b=hvrbCq4Vjfzrqrjh8cvT/34/cYa3fmIkMWz9qOLQT3LOHC1mejhBYQqc8AMN3PRJU/
         fcUQ/NOGX6VZPjU+yHzeYgL9nwnM4J1gX4DdJ3cWQ1wPFgrQTC5mvrYi/nXBDjlYhW/S
         3LDNMJKy7rFu0ffBVC6e4jWtsjr4l3VKxbpyl8JgzqkKoFyW6QYD4P2OMTuCXL+ZnzWW
         rx1XU5iPk2KMKFL2TGAtzf7tQttxseHcQCIO0vvPBphVOndICDKfKSVohdSbZLLHkCDK
         oRKkTFbnbfVtyXhRds47sq3hOo1ahktbMQubs0143Hgfzd1rLSEtVlRGlTDYkEmyWSd6
         7YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101145; x=1793705945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqD5vVTTBfwoyL27JJNk8QW987++ASEipnY8mTx2+X8=;
        b=kGGK9f0AtfPEJ1Fe2oTKWjL2n6SHuBK5FdPkLenSVHX/B0EaWEaaZSvbVwqg2YHf0i
         80GM4tiw2mp9j3YqOkZvAJKManFTadFHeXUh4RnXetwggwBwgPquliQBpwPOO1ViC8Sz
         wuR9nv9fLcCJpzmlKgdHjLNQox9v+BH9kOUgCtbR3Y3g8Ec/DqPPvCqsLma5JcMuWQJE
         MkT6czT4AsXIFgoqsDC/XJ0h0yniimEaGcQRhAXZ7BylaqANduMbV+kWfqeihqSgDSrK
         SdiOlCFX5jSPavGK0oN2DvY8H4643WvnrqIYytqjowsCCGpLtnzo4uSmKvUhDBpZF9Y/
         TOzA==
X-Forwarded-Encrypted: i=1; AKwUvBzLwNcAvdFP9Q0RXaX8kYG2isfEi1wBiMFcjyykGQ8xoXayNaugHL7sRGBVArvRIGGDgRHJOYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJQpQs4gyE+etXJm39/WSH0Ikkq5eSH/1PE1Xr63QLc/2Utq95
	bNJ/eywo0tLYMki9x/Z/39GzLgY8aQdfJ4tMJyHejNdryn/NHEFkD9IKDqAIFV1Veqv3gdJ+nuY
	AGO3wFEicvDpj/OhXpzZdYI/AutGT3/OR1DIMO2kMjE24O859ocfWZonRnp4=
X-Gm-Gg: AYBFou2vDuvsDa8awsPCzSoWukazE+jc36f/qHXJrj6WUWOYclRjA0qIIlwiGMKOVHa
	kgUSo1fKslKSB2Qm7gNEa0ZBDe93UTLp/HR6b4WWYuw+Hsm6WPjSuSKynmQksT+0ZAGSC90FP0x
	SexrYA+PBiZPdmjzMVRTNIh1AulW20jRWlqS6ua4s30YQQ0Qx3TARuAMWfA8bDsoKQv10kPWtA/
	kPWsvZarts1apKfwSdThQBE1t/hYCYszaEntV1mFI0UJKkWD34E+0eiN1hRe2zLyPIEJkbh2uR2
	Ga+vSe73NmKZwjeYmY2XJyZ82Af9QzKP9EqkzTw4oP2n0hakIuC+kIB5YwGBHwQa2w2FZEm/cLK
	YqXWAw0PZmPcjMmy6oFp9T8gs/7QtOevyqWHKjGJPJ3tZXErX
X-Received: by 2002:a05:620a:4515:b0:93e:48fc:aa85 with SMTP id af79cd13be357-940ef9571aamr1426241985a.43.1793101144068;
        Tue, 27 Oct 2026 04:39:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93e:48fc:aa85 with SMTP id af79cd13be357-940ef9571aamr1426228385a.43.1793101143118;
        Tue, 27 Oct 2026 04:39:03 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd39a9sm22840875f8f.46.2026.10.27.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:39:02 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:39:01 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, Jose.Abreu@synopsys.com,
        boon.leong.ong@intel.com, o.rempel@pengutronix.de,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net 6/6] net: stmmac: fix XDP RX buffer DMA sync length
Message-ID: <auCNVe1pMumVcF3s@lore-desk>
References: <20261023-stmmac-xdp-fixes-v1-6-efb37e19f5bd@oss.qualcomm.com>
 <179309225887.3134.17502896212947474889@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="meEQn4EyMsDIqBx+"
Content-Disposition: inline
In-Reply-To: <179309225887.3134.17502896212947474889@kernel.org>
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae08d59 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=3lS5nG9XOEgB1YPr8hIA:9 a=QEXdDO2ut3YA:10
 a=R8n3WUYfiK2D1sPUeuAA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: 1v89i0tZ2h6o-gvHq_gDhzUNaoudQkbD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXwTMN6OFIRQKW
 8m3ejZFzgapHfpZlZq9z2I7MDXy9ykOIPy+3StF1bqET+EeSOWvRUyjALEmNQVhbvhdWmVr7qEH
 cVLZy5m8tTWhHmq9iBiMkztr4gglXAE=
X-Proofpoint-ORIG-GUID: 1v89i0tZ2h6o-gvHq_gDhzUNaoudQkbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX2YLCrJp4+pRz
 kQ3504BADUcF+rNDMVTGvd3tztnlMiMSCrbfkQA4H4O4yRb9An0afGxvo5tyCB/TF2ayLHf/NTI
 iEsCQ9YTluW6PF4HkOXaGsX1gMP2I7Ivsq8xbHbluPDbFAEAmL6VfTIZqS3l5qCyiRksYFYhOSV
 f/DlSqiJBUJ/HbvBRvdjW9ijX+ZvLuIUBacvY1UwyVUYtUKVY1r9D9SmH+ZzZ4YfLV9Wa91oCOV
 e8vIvU4PHnEMNfq4iztp1fPAX32xlAKmyQ1y5PGSNCw9nbJ807B2Rn3ukzoCAr5ynweZ70ttwpE
 Vr3MDIfItYvsoKxoiw0L6eme/FnbNBAOpEQw82374IMf9CDdPfVZ6r3JLBdTH5SK9urGjPEUOYL
 vLwHknTfJObOU4lf3TFlwhrWJhe5vhp7PH8oaipkK9ZI5nBoA9nTFDhlNRuFmp757trWVKgfezy
 +7ECUxoPG0IzH6CQ8LQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046

--meEQn4EyMsDIqBx+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 27, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] In stmmac_rx()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the length passed=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: fix XDP RX buffer DMA sync length
>=20
> This commit changes the XDP path in stmmac_rx() so that pre_len and
> sync_len are measured from data_hard_start, and buf->page_offset is no
> longer subtracted. That matches the page_pool DMA window, which now
> starts at offset 0. The goal is for page_pool_put_page() on the
> consumed XDP path to sync the whole region the CPU touched.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 32b2c5834c340..c51358c51fae7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5980,8 +5980,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
> >  					 buf->page_offset, buf1_len, true);
> > =20
> > -			pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
> > -				  buf->page_offset;
> > +			pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> > =20
> >  			ctx.priv =3D priv;
> >  			ctx.desc =3D p;
> > @@ -5991,8 +5990,7 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> >  			/* Due xdp_adjust_tail: DMA sync for_device
> >  			 * cover max len CPU touch
> >  			 */
> > -			sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start -
> > -				   buf->page_offset;
> > +			sync_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_start;
> >  			sync_len =3D max(sync_len, pre_len);
>=20
> [Severity: High]
>=20
> Does this cover the furthest point the CPU touched if the XDP program
> grows the tail and then shrinks it again before it returns?

ack, I agree this is a real problem. I will fix it in v2.

Regards,
Lorenzo

>=20
> The comment says the sync covers the "max len CPU touch". However,
> max(sync_len, pre_len) only looks at data_end before the program runs
> and after it returns. bpf_xdp_adjust_tail() writes to the grown area
> when the tail grows:
>=20
> net/core/filter.c:bpf_xdp_adjust_tail() {
>     ...
> 	/* Clear memory area on grow, can contain uninit kernel memory */
> 	if (offset > 0)
> 		memset(xdp->data_end, 0, offset);
>=20
> 	xdp->data_end =3D data_end;
>     ...
> }
>=20
> A later negative adjust only moves data_end back.
>=20
> Take a 64 byte frame at page_offset 256 and a program that does
> adjust_tail(+512), then adjust_tail(-512), then returns XDP_DROP. Both
> pre_len and sync_len end up at the original end, around 316. The memset
> dirtied the cache lines in [316, 828), but this call does not clean
> them:
>=20
>     page_pool_put_page(rx_q->page_pool,
>                        virt_to_head_page(ctx.xdp.data),
>                        sync_len, true);
>=20
> __page_pool_dma_sync_for_device() caps the length at p.max_len but
> never extends it. The direct recycle cache does no further sync.
> stmmac_rx_refill() gives the buffer back to the device after dma_wmb(),
> with no more cache maintenance.
>=20
> max_len is dma_buf_sz + stmmac_rx_offset(priv), which is 1792 with
> dma_buf_sz =3D 1536. So that range lies inside the window the device DMAs
> into.
>=20
> On a non-coherent platform, could one of those dirty lines be evicted
> after the device has written the next frame into the recycled page, and
> corrupt that frame? It looks like the same failure the commit message
> describes:
>=20
>     Dirty cache lines in the tail of the frame can be written back
>     after the device has DMA'd a new frame into that page.
>=20
> The commit message names "grow the tail" as a trigger and says "the
> whole CPU-touched window is synced". The max(pre, post) approach was
> already there before this patch.
>=20
> Would it be better for the STMMAC_XDP_CONSUMED path to sync the full
> pool window instead of checking only the two endpoints? Passing
> p.max_len, or using page_pool_recycle_direct(), would do that.
>=20
> > =20
> >  			/* For Not XDP_PASS verdict */
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

--meEQn4EyMsDIqBx+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauCNVQAKCRA6cBh0uS2t
rC55AP9UGxsbij3J4aUzASRo/KyX2he35yAIxxiEqHkTq1acuwD9H5JR/kGUZHLc
maP+Ju/MorEuwb/frXx/LrWFlgWzdgQ=
=hxk0
-----END PGP SIGNATURE-----

--meEQn4EyMsDIqBx+--
