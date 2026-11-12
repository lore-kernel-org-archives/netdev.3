Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481790;
	b=hb3y4WuU8sdUpfuF9UsbYuYlBAG5xIZcL0l9vGXXJSu8VEEZfKJ8Hl4OAs2eldsd3ttx
	 8Ae8/IIv9Y5iITqoZe6fvz2b3GZJUC/BzKOhSfe1b7hDnX6DcdgSiL2rUMR9CLfi9YAzW
	 xIExbKzttZ1YNeMSTeXl/XU1ZLmhtMo1mov2xyMFdtbbFMX7fviCp9xHSeA/5W+Mmzanf
	 wlxFOwToP3ZIvgLiBeDi28vRIAPwJzSWSI84rc4shpNv6oicgPqPzuITRcfxaS+w/RxXL
	 kAT8qsVC/9FkXXGGE1b88seaJjsl2ynnUCUISSJrex8xGLkiwK0bnlzrZEdvrfTY9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481790;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:o:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
	b=1Z7hQCsu4i1jRespvV9KoZfvZf8ngwjgjborTIzIgLG1DTr5Yo7fx99I5b/FyjnCDIvK
	 zueevEy0Ds4XruNLduiBtdrMcI6RDdEd/6wEJAf4sx7Xh9+XbVDkXRRXZxkmbrCtAzece
	 24w7XJQlSLkMi3qwskJQsAzUpcrlNkhwpI1NCk/BnI/6fThgBvEKKMEkQCrd6XTVtsWhd
	 ADtLshtMw2pbiohwyMcm5+OQx9nDDxMh2o27E1gUeuNztkZw0qAGI+oqOuOGPWDOu8VGa
	 foNRFnSglbHXD+4sFJYupWNiwszwlEtYhZwmt4KpGoUXnxMDzgaDXC6iYnZxIzC0PtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZRczmZN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTZjtkJy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A2606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F3A2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZRczmZN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZTZjtkJy
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC53pm23477100
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject; s=qcppdkim1; bh=N8Sxm8XiSudcNG9BW8w5hvCi8/C
	mVau/gswvd5wgkPk=; b=aZRczmZNEnYsaFzeBhuPfu4rnEXN04hXMUB5/K7TEDg
	I/Ww4v8ot1+yIuz0l3V0LWg3kplM2IweieQ+Ga6VIhcJpbK2enkqkKywJ0jVqXUD
	FmOWV6/mnzhWUM9wAG29dHJEd+QE48nTlX4ga/AiOwk/Rq5nafrQORIBGzTaaBnk
	/enlTcT6fCXQPuxivCspDFfp8tKlVxt/TjEtsuFkNMNv8O3iMAPDW+yaCrlFQWUq
	ftvzQOWzupdzxSXKCiJ69t1EcQSYbAi8pJ4yhwpvLmOwyEldRkkK/6dUd0Jvtvcg
	L8KFnOttc4fEshfUlaEHwRatzwPpRqcxexLL9gdstJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuh87u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:09:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-944101e6367so140433785a.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794481788; x=1795086588; darn=vger.kernel.org;
        h=o:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
        b=ZTZjtkJylXZu4lpuwE4nE+o+M6DP2vhg9Uxb2VlJcFNPpnkPeK77zaTMRxAMOteVr3
         9Tm6NWIG91u+pSOfthuw/KqZ8/9MWcvRBEoIsIz7ig2xfGHjcz9BkSx7yGWKAW10K7LS
         7+JenCZ3j7nNFN9kCVO7hKJah+mrU0cB6Vq0ozeps2OANijbDqS29QWTXp4Sq0nHfE84
         i6BTH6FpwRaVOlMIZWMj6aYQPsz9yBjaOpynMV6hfNiXuBcfqznnUTzEYxd/H46P2zcC
         g2Ed1w90n0c83z4Qeoc/us88o3ybk9JbBWZK7aiC/XwGoASae/JtxoW7dHSnHE5QJn9Q
         RZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481788; x=1795086588;
        h=o:in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8Sxm8XiSudcNG9BW8w5hvCi8/CmVau/gswvd5wgkPk=;
        b=HwhzFzoe+yUFr6qY8u6Ppnvo+f0B3YgH4RZWCCz8u/spwnSzxk4o1bjSpnpmWyK75x
         i1KAxMMInWjDo3AFWYh7MwWZGQpfx2Ns0XE1FKTF6rIOv5YF/aqwChggEcrsiMzAI8nV
         AjPJrWlWdbjUhzw/JU6bl1wuZm+RFQ+rnSdjAV3TpxtVI3gqpUvnLhWCax/haCVrGmHf
         vQrZKoWW2SM7qguHQrylM7MR5QLNT5I2ZyzxILFdv8ZIQyvWDeVlhy8Ykiz+2Kxu78+A
         XD40GGdoGO85k+5TTKOzuW3q6HHZe5J4l+g+gtc/w0FbOlL69yDvaGOAvoxpXXS6Dtsj
         kmdg==
X-Forwarded-Encrypted: i=1; AL+hErFgeNbzObXKabKEKQjGVdMVW3R/NsOh7s5aCiwjbegF5DhwhkpoZlwG/mEh6eClqStRxHYURlA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/6UuXD8g/LsrpCJNvARYWgbw+lt2DNwqzWHm9xysUbHaaxAZM
	wl4GExENQ5VKmwFkiO03SeNPG9e/5uRw632+zh46dAzMB47SNQWJl4S4jKqjq3AwexeRRSQqpp6
	/nxHzjJ6S05rKnOwUlYYwAMb4qsCgGA5XsvBx57m7A7cVzs9ACifeASLioig=
X-Gm-Gg: AYBFou296E1Zmc7H8x8qLUCby+lOxP575lX7s/PXnJSTn3e/y+rWb60mF9D3uuO9Y59
	BKV94je5Pnh7/BtzXufPvVguzLj5Bbl4D+5W+xeD9uVJCgjWnMl0VjCy2Y/ZaKfVpwxdSroFGB9
	7hqEISljann4rnuuoM2djm7NWqUAyEC5Is43VYhv3ty37Fip/bCd5zisw9Ie75EpvShqCDesVWq
	fPET5HK/WNIs43+cKCpPT/akSqp9V4eglUFvMPvqunnFiB5YxOYSRJ9AmwKJck4rkNNc/nanzvY
	icpW7RqHgcCEUU0OyEX0lsapijhhF34BMSqsKdwK73RGcsC31cWLnJ03Qbr1vSu/3S8Do6oUmTS
	TuCLpn07bSV/83Y2oSDcLSMJ0QiXTx8t54Ne56YI1oO5TD7hC4mjQoM5rIkiD6SM=
X-Received: by 2002:a05:620a:412:b0:93f:4498:603a with SMTP id af79cd13be357-94933140d8cmr273169885a.35.1794481788283;
        Thu, 12 Nov 2026 03:09:48 -0800 (PST)
X-Received: by 2002:a05:620a:412:b0:93f:4498:603a with SMTP id af79cd13be357-94933140d8cmr273166685a.35.1794481787607;
        Thu, 12 Nov 2026 03:09:47 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e423dfsm120060095e9.1.2026.11.12.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:09:46 -0800 (PST)
Date: Thu, 12 Nov 2026 12:09:45 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v9] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
Message-ID: <avWeeUAo-87qexve@lore-desk>
References: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
 <20261111181341.56706354@kernel.org>
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
	protocol="application/pgp-signature"; boundary="b5Zoifa3Cp4gU6eN"
Content-Disposition: inline
In-Reply-To: <20261111181341.56706354@kernel.org>
o: Jakub Kicinski <kuba@kernel.org>
X-Proofpoint-GUID: _EjN84Ccg1jVMHlZntlhCxnflUQsm2Hs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX17oY0vot943G
 IguQ+bb9KtQcCpU+WKmVIlPLKQj6mdWqmUsVL3eV0WtbNspIL5Z6RcrxsKiApxJjtMnfvBlcN3x
 19DZtVy6OuLhr+qzBw55AaV1qQPzDsw=
X-Proofpoint-ORIG-GUID: _EjN84Ccg1jVMHlZntlhCxnflUQsm2Hs
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af59e7d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=9cW_t1CCXrUA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=07NEhHcJ6ct1wQha1QwA:9 a=CjuIK1q_8ugA:10 a=HwC5dmO7DALaZ-7ppEoA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX3mk4qKrfTR1G
 bCI0nkPGxyTjYfQ4aqdUnUJt1oqa04ea3Fsx9uHZ7+f2ahN6AiL2ctJFeLdR6z1PSgP2KtnfXxp
 IkFKj9R89tioDocDDswK0N86wsdl4GswOa9E1MqXVwjfxmo0J5K40IyhF4pOcI4gkgunaGI7LZD
 4QsDxyxveCA7y+naX4tCVrUMC/9t10AeOQGimNIlnL49gsExr0spCeWv7T8jknBb7kXQ6d4TZo9
 7nLzHWK6h4OPZRKkO5tLZ7ZK2u5SfcbS55d5u5TbZhY8HvZHiPw/V+70pVF8JNGplnMSHAo8F6+
 TzNYaNn2FKa+vju0mvguNk7YXVsci4tXo1FMTNav22WUR5IKk2eMFvUCS8SIdrej+AaW4i+LVc1
 I86TCKxMyO3UjFkoWAhiJLIfWfWkydyRCfY5dqmblOikPVto1Qe2HOG2yk3O/ivQfkRbyKEptou
 OjviTXdQ+8HhIOym64w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120044

--b5Zoifa3Cp4gU6eN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 06 Nov 2026 11:54:19 +0100 Lorenzo Bianconi wrote:
> > +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	u32 metasize =3D xdp->data - xdp->data_meta;
> > +	struct sk_buff *skb;
> > +	u8 num_frags =3D 0;
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > +		num_frags =3D sinfo->nr_frags;
> > +
> > +	skb =3D napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> > +	if (!skb)
> > +		return NULL;
> > +
> > +	skb_mark_for_recycle(skb);
> > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > +	skb_put(skb, xdp->data_end - xdp->data);
> > +	if (metasize)
> > +		skb_metadata_set(skb, metasize);
> > +
> > +	if (unlikely(xdp_buff_has_frags(xdp)))
> > +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> > +					  sinfo->xdp_frags_truesize,
> > +					  xdp_buff_get_skb_flags(xdp));
> > +	return skb;
> > +}
>=20
> This is almost identical to xdp_build_skb_from_buff(), why not use the
> common code?

Right, this is almost xdp_build_skb_from_buff() but we can't use directly it
here since it runs eth_type_trans() and we would need to run stmmac_rx_vlan=
().
I guess we can refactor xdp_build_skb_from_buff() in something like:

struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
{
	// Do not run eth_type_trans()
	....
	return skb;
}

static inline struct sk_buff *dp_build_skb_from_buff(const struct xdp_buff =
*xdp)
{
	__xdp_build_skb_from_buff()
	skb->protocol =3D eth_type_trans();

	return skb;
}


>=20
> > +static void
> > +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
> > +		    bool allow_direct)
> > +{
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	int i;
> > +
> > +	if (likely(!xdp_buff_has_frags(xdp)))
> > +		goto out;
> > +
> > +	for (i =3D 0; i < sinfo->nr_frags; i++)
> > +		page_pool_put_full_page(rx_q->page_pool,
> > +					skb_frag_page(&sinfo->frags[i]),
> > +					allow_direct);
> > +out:
> > +	page_pool_put_full_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> > +				allow_direct);
> > +}

ack, we can rework xdp_return_buff() adding the capability to specify
napi_direct.

> > +
> > +static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
> > +				  struct xdp_buff *xdp, int offset)
> > +{
> > +	struct skb_shared_info *sinfo;
> > +	int i;
> > +
> > +	if (unlikely(offset < 0 ||
> > +		     offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
> > +		return -EINVAL;
> > +
> > +	if (likely(!xdp_buff_has_frags(xdp))) {
> > +		xdp->data_end -=3D offset;
> > +		return 0;
> > +	}
> > +
> > +	sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	for (i =3D sinfo->nr_frags - 1; i >=3D 0 && offset > 0; i--) {
> > +		skb_frag_t *frag =3D &sinfo->frags[i];
> > +		int delta =3D min_t(int, offset, skb_frag_size(frag));
> > +
> > +		if (delta =3D=3D skb_frag_size(frag)) {
> > +			/* The whole frag is consumed by the strip: return it
> > +			 * to the page pool right away. Its ring slot still
> > +			 * carries the page DMA address until stmmac_rx_refill()
> > +			 * re-arms it at the end of the NAPI poll. This is
> > +			 * safe because HW cannot touch the slot until then.
> > +			 */
> > +			page_pool_put_full_page(rx_q->page_pool,
> > +						skb_frag_page(frag), true);
> > +			sinfo->nr_frags--;
> > +			sinfo->xdp_frags_truesize -=3D xdp->frame_sz;
> > +		} else {
> > +			skb_frag_size_sub(frag, delta);
> > +		}
> > +
> > +		sinfo->xdp_frags_size -=3D delta;
> > +		offset -=3D delta;
> > +	}
> > +
> > +	if (unlikely(!sinfo->nr_frags)) {
> > +		xdp_buff_clear_frags_flag(xdp);
> > +		xdp_buff_clear_frag_pfmemalloc(xdp);
> > +		xdp->data_end -=3D offset;
> > +	}
> > +
> > +	return 0;
> > +}

I guess we can exctract the logic from
bpf_xdp_adjust_tail()/bpf_xdp_frags_shrink_tail() and create a helper we can
reuse it in stmmac and filter.c. What do you think?

Regards,
Lorenzo

>=20
> These two OTOH could easily become new common helpers, they seem to do
> nothing stmmac specific?

--b5Zoifa3Cp4gU6eN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavWeeQAKCRA6cBh0uS2t
rPFeAP0VMe/78PkVnBIxUEdWOxWNS8mn/VHlUChXe7LArItcnAD/Z3cRi1H98JVr
c0eziNWwRX+hmLoGHFwU5ALqhPHhXg8=
=ojdi
-----END PGP SIGNATURE-----

--b5Zoifa3Cp4gU6eN--
