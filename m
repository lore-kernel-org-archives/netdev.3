Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744669;
	b=BnBmI7YtyjSr8J4CXE5fa+23iBub88V81tB9dMtUD/kf46YrDUjdCarQm8yPvT5Gjsk7
	 jNZ5I36SGh/vmGobGqSSYfs+648zxP95muXHb2JNilovGupilExDhdwnWeC2yw0yuuo58
	 crL9V18IQv9SBX0GexQjSWUewE7rAsDoyF2TQBhWNHQftpWLmoW4FoKh4Wg4LG8gWu4kW
	 5O1MezDPKq/eTHjFlBu+nnZOSzxNDz+N4k/IK164eW/VY9MmPJsUaf7Aq9VkLCqR/XJx3
	 hQWn6/x09KCknHRTT2Niz5Uq80XegLX0ZGnz+WfRX4vSXggjaFr5+461Iu4P1AKQaZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EMAdBXKIQjZ2eL7On2GKJg/pfvU0OBX71fOIYOXfups=;
	b=oupvADdL3zPbtmabPmM0TCl3x4GLvHmHR5RSWrn8Gp+BV3mYK4Okg3S91LqTCfCdzmfF
	 Di0Jc+Cus7nuCa+BwtJSbNqo16quCUbiSE7h45H8jbd1bKeMqiHkp/gekCzqajOTJo2BJ
	 Xn/pdVAJcXENyRJqbcYVZy4pB796Ph84OIbqgr2doazas1b2dmQsSQleCAoAmJ5wcWwf0
	 DIJkWz2HGHuNKLZ1JGk7wVWJizINpl6Ff1IXAw4aL9oDC7fmNXyr+8863RMsX9/2bjv7J
	 bCwcODuxjQTChgYtTEvY6UfSv6sMz8jkHtXfhKbX1vyGLBQ0pG7m3iHtLRq7vKJHEyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KnI0Qk2S;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ApWYkHN8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD7606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 22:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FBD7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KnI0Qk2S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ApWYkHN8
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKvHO4024537
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 22:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EMAdBXKIQjZ2eL7On2GKJg/p
	fvU0OBX71fOIYOXfups=; b=KnI0Qk2SbqDCLKnqF7TjJYZQN+gtlqsWfIsQUuoF
	kSui/QCIVGQvaHTCBXbPksOHvcgOFkQ/gSCp/m8J+luleeqzmqpiTJcrwPSMl9cl
	TlQkQMXxGYPahM9XwdiI72PsaO7IGZzm27vUoUx8Xi2ox/oh+g6zDQiF32KF+cua
	ymvlKl5EXvqZVTs8OXb31Vejxkbx7qNanoRQY43urT4iLc8l7lbafXp6F9jsTk6Y
	wLItYkj0IYNoDoS5vpcvd/ff8rEw+cdbcuymaC1TkKzX9Se99FiZ8luW6scBqEU8
	cy97EF65LuSO7nTk6WdEPqpasGKrsA+ivMAYVLZxA3v8jA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubhgjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:24:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1e62510cso33972885a.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793744667; x=1794349467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMAdBXKIQjZ2eL7On2GKJg/pfvU0OBX71fOIYOXfups=;
        b=ApWYkHN83J43dj9FLgXWWDnltra4sEQoWcokoforB3BECeNzSq+Bed4FgQ9a+s/ZKt
         PzlPYv74WFMzV6G7HEnr7x7IulLd1M5DdhmLGVATbro80pYLMEtajZZvY4K/L+h58u40
         1cL6TMX5xvAaDgyYM3vWG2tN4pEXvSz7dydKHGXqdCwLCZNDkINJLQ+mEw524H+Fwh4C
         gl/9XNRKDII5OwHj/Az74H9Jz6EGrl1DcWMlYydADKizyje+z8Pq4Qj4k4Iu1HiLTWTi
         h5+V4vKy4TnkdkzR2DgmuPRLGzv+Q4/uCWZE9MfeWCPQpKNKPYK5jXS6TF8eD/GBO1Sq
         tqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744667; x=1794349467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMAdBXKIQjZ2eL7On2GKJg/pfvU0OBX71fOIYOXfups=;
        b=Yk22TtD6WGBq1TkHIkmn2RQG+ZS2SmjT414dODiXkN6USJomq5GnTFyuY5NnK7HgcI
         StHayKdGzf17t0ZIplPDQ2h3CC7KC+eePO8076BF+oeE2/OpnKVOngHAkluwoq9DuP0U
         JWR+eFC/tamB+fYdIROpB5FbLi9wJvg8uJfsz14oRANUUfD2PAfYjZKELA+uf4yWb5bB
         JrQFKG7Mh46EW6bDgoSvfKOf3tEJGYCJBUr6ZQ6OvXzibvuq+LwL5C5jerXJqxruqA5k
         uA+NwyQNUQ3MIQ3bmmUrUSBTfWnrlC3crumEwnNF1eEWs4i3/u+TMpqcfCU7Qbk5qQsS
         JUKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnG+wxEmmEs7zfj8MYH+O9HlvQ/Ljm5xygJEZpEZG5KwtS/sRHYKSfivJC6aKAg/wHlw/F3/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C0vbEqoQHl5kPaO/meMmAxymDfKyxhISd627Qk589yXHEGgNh
	n+V/NVgkKvQv7cPC9lCv71DqWW7PMWAnbSQSB5ySKf2uGB097rpCtQ6zsxtMQgMe9bd0K+lvSFH
	UIWRG4xCFdjQ/YFGJyZxWn5inyIrt/mYO8gQTWCi6IxqJiLCMH4h/JLeBrMQQBAiGhls=
X-Gm-Gg: AYBFou3D158qpR50nUuUVzGwksqt/BFA00aT+d4z6aWjFwea801gggIS0Q9oii2Gpgx
	Q66bFASJzHwsOPELxGMK+ZI3aLEhKsbRa200kOPC8Yo2cMMK2nv5QVJgsNBBH9Ldb1OzMsUVBLd
	jXqtkqweoOXx6GA28AhTbMJbvzs6N3N7jDFxHvEqWlFLqjXuAeevXuVBJRTZ7aoaSsmunyL9rD/
	0N/0kbys9kPNCs8jcRK1KsWGPawHwJt6oaUGSeoyGRHnDFVOek2D1DlCfXl4QAF5VvHoXLj/wj8
	puaFAaBMTXXFMRKWAXxkO0JQ0kj5sv5s3Dq4fmcpisJmrNb4ttiPiBUlNdwSAy8mNWeC92xdohw
	kHz7d4OcWEqXIkWR+kZg/wxEUO0HG+b7Q79U7hzFCxiYcegjIH/xxkkAIgNbjlQ==
X-Received: by 2002:a05:620a:2807:b0:93e:910c:5fbd with SMTP id af79cd13be357-944217b5558mr2432817985a.63.1793744666729;
        Tue, 03 Nov 2026 14:24:26 -0800 (PST)
X-Received: by 2002:a05:620a:2807:b0:93e:910c:5fbd with SMTP id af79cd13be357-944217b5558mr2432814885a.63.1793744666057;
        Tue, 03 Nov 2026 14:24:26 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43cb234a1sm5835195e9.9.2026.11.03.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:24:24 -0800 (PST)
Date: Tue, 3 Nov 2026 23:24:23 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Marek Majkowski <marek@lysk.ai>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nf-next] netfilter: flowtable: tunnel device poisons
 h_source of fast-path frames
Message-ID: <aupfF8g1DH2lQQkV@lore-desk>
References: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
 <20261103213430.2850-1-marek@lysk.ai>
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
	protocol="application/pgp-signature"; boundary="lbqjb6ASYjPDv1q1"
Content-Disposition: inline
In-Reply-To: <20261103213430.2850-1-marek@lysk.ai>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4OSBTYWx0ZWRfX5dXhQNBzVHl8
 BtdHA+dMkphtBbBWQxd0URTSMQYoNF1O+5f0zkjNzPHFHdYdPBjK2uNABp5yFiyWoiKjAZsSjp7
 wE5N083ZV1t6T3ZN09LXVkp0DweTaz4=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aea5f1b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JOjV33QCGg08e02vQs4A:9 a=CjuIK1q_8ugA:10
 a=I-4OuOSVAtTkjluqnT8A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: jtACo0MLfXOhdXGkAiXDXXHZV9HDAoeG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4OSBTYWx0ZWRfX3Iz2YgvH5NBq
 WzEBfsBX7R+7ckzXvqyqVBznOyBvY8QudML4Danu+ZcTnCa7oHu0VVtZy3M7OfL1m5O8LHMzVAA
 uYGA83GK4a1ptiT7B3td6LB6Oz7/VHp3tQeBOtuKnfYVP6Pr4sppR4UCO/XaU+546M2O7TOvyKU
 mFC4whnW9jiBFCReX1CxL8kxtQvVA2v1IaA/VkRRi3ob1wma7Uu0r8hwaWUV6m17b4rEqeJAnc9
 wXtiYWgJzPoUD9iul7C9D88ryBLuoPV5HiSnkJrx1ZzKRhE1aekv2sqNo7D3i7P11UnfFVR0OLG
 99WgB/57M3gFpmUj/Bm0P7CfoyXwj4IF2MreLLrUYPVmfaBTUfm7+h9H948xr+oprY4DgMwxi8M
 ppVkWLFxN+77C68W/ao+ssDtO05/Nqs0wayohio84Rzp0Ty6TgF1oH5PdfX3Cz72SuUpsXpi4Yr
 zQtVVMhm7PRphwH0jWg==
X-Proofpoint-ORIG-GUID: jtACo0MLfXOhdXGkAiXDXXHZV9HDAoeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030089

--lbqjb6ASYjPDv1q1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When a flow enters an IP tunnel, the forward path discovered by
> dev_fill_forward_path() starts with a DEV_PATH_TUN entry for the tunnel
> device, followed by whatever carries the outer packet.
> nft_dev_path_info() handles DEV_PATH_TUN in the same switch case as the
> Ethernet-like path types and copies path->dev->dev_addr into
> info->h_source if it is still unset. For a tunnel device dev_addr is not
> an Ethernet address: ip6_tunnel stores the 16-byte local IPv6 there and
> ip_tunnel the 4-byte local IPv4. The tunnel entry is the first one on
> the path, so its "address" wins and poisons h_source: every fast-path
> frame is transmitted with the first bytes of the tunnel local IP address
> as the Ethernet source MAC.
>=20
> Seen on a DS-Lite setup, LAN -> ip6tnl (IPv4 inside IPv6) -> PPPoE ->
> 802.1Q VLAN -> Ethernet, with conntrack flows offloaded through an
> nftables flowtable ('flow add @ft'). The first packets of a flow, still
> on the slow path, and the fast-path packets of the same flow differ only
> in the Ethernet source address:
>=20
>   slow path:  d8:58:d7:00:2e:bd > 80:ac:ac:39:ef:c2, 802.1Q vlan 35,
>               PPPoE [ses 0x454] IP6 2a01:110f:4328:c400::1 >
>               2a01:1000:0:1::2216 next-header IPIP, 192.0.0.2.40010 >
>               1.1.1.1.53
>   fast path:  2a:01:11:0f:43:28 > 80:ac:ac:39:ef:c2, same frame otherwise
>=20
> As you can see 2a:01:11:0f:43:28 is the start of 2a01:110f:4328:c400::1,
> the tunnel local address. The PPPoE endpoint binds the session to the
> subscriber MAC and silently drops the frames, the effect is that every
> TCP/UDP flow dies the moment it is offloaded, while ICMP, which is never
> offloaded, keeps working. Received traffic is unaffected.
>=20
> Do not let DEV_PATH_TUN poison h_source: skip the assignment for it. The
> real link-layer device appears later on the same path and provides the
> correct address; for a path with no Ethernet device the address stays
> zero as before.
>=20
> Fixes: ab427db17885 ("netfilter: flowtable: Add IPIP rx sw acceleration")
> Signed-off-by: Marek Majkowski <marek@lysk.ai>

Hi Marek,

thx for testing the series and fixing this issue (I guess this is occurring
since the PPPoE path forces the xmit_type to FLOW_OFFLOAD_XMIT_DIRECT).
Since the issue is related even to IPIP or IP6IP6 tunnels, what about
targeting nf branch instead?

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
> Found while testing this series on a Turris Omnia (Debian, armhf) behind
> a DS-Lite ISP: with the series applied, IPv4 flows through the ip6tnl
> were offloaded but no fast-path frame ever got past the PPPoE
> concentrator. The problem is in the existing DEV_PATH_TUN handling, so
> it applies to net-next with or without this series; with the fix the
> series works here (tested: UDP flows with a fixed source port, TCP, bulk
> downloads through the tunnel). Without the series the same wrong MAC
> should affect ipip and ip6ip6 tunnels in front of PPPoE.

Since you actually tested the series available in [0], can you please provi=
de
your tested-by tag? Thanks.

Regards,
Lorenzo

[0] https://lore.kernel.org/netdev/20261103-flowtable-sw-accel-ip6ip-sit-v3=
-0-60b5f063f1df@oss.qualcomm.com/

>=20
>  net/netfilter/nf_flow_table_path.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_t=
able_path.c
> index 841f09943..4ca6e09c7 100644
> --- a/net/netfilter/nf_flow_table_path.c
> +++ b/net/netfilter/nf_flow_table_path.c
> @@ -121,7 +121,12 @@ static int nft_dev_path_info(struct net_device_path_=
stack *stack,
>  		case DEV_PATH_PPPOE:
>  		case DEV_PATH_TUN:
>  			info->dev =3D path->dev;
> -			if (is_zero_ether_addr(info->h_source))
> +			/* A tunnel device has no Ethernet address: its dev_addr
> +			 * is the tunnel local IP address. Take h_source from the
> +			 * real link-layer device further down the path.
> +			 */
> +			if (path->type !=3D DEV_PATH_TUN &&
> +			    is_zero_ether_addr(info->h_source))
>  				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
> =20
>  			if (path->type =3D=3D DEV_PATH_ETHERNET ||
> --=20
> 2.39.5
>=20

--lbqjb6ASYjPDv1q1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaupfFwAKCRA6cBh0uS2t
rGH+AQDgda84U4c6W4mIKUck4bn7r0IPxlKt96wo/OmRNwWvDAEArTJ5Z5WqcuNg
/xoQ4b16WmI9WymzJHhiWTivWLa+Swg=
=KkDk
-----END PGP SIGNATURE-----

--lbqjb6ASYjPDv1q1--
