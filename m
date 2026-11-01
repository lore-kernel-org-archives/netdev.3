Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.70.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559045;
	b=HRWh2y0C6qiFFEzjUoFUYgzNK9TdyBvEDXNVuHdNzmSjSwcm/3wZk7BZoCtyDVXiYScY
	 WjUhLsQ8kNUY7GmeDcVeSPmhcP3eBfWSPXMyDKzUuqy2z93vFsvYGzq0fGYkCY5Hyj0gQ
	 xidrOeQYhP8qoJB9+LZCVoDQISIy1EIfOOC3HFllm6DtFcWeD7TwgWDiuDi5X4pFxXHe3
	 JyJdteP7rot1+9+Q26s1vAn8PlhihTeldmR+hG3kKwDP13GFC+sboxhGU/whtyK2lXlSJ
	 aPtkOgG7POA+LVV6RlBk5hWjRdInJeuqSaD5CIv4Bju6bH5L1OJ8jbgFqz2YPCf+rEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559045;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Info-Out:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-JNJ;
	bh=GTWEkHLINMQZ4+DrDX6BlFZOxDS9gog4DMcrEDPlThA=;
	b=vlSVxtlGbP//80d6x8HG+lHXngVfksPDGlO5m1yes6ps+bp25MyMOAHbhCK35CKSN4B6
	 FsXotg1a3PD3NDgHE+8kchtT44rx/zFEs9A+QOWbuFKrLcvmMxyOduZIXmdfC03vvuJ7q
	 T0C/Zq0m3Y7+kg2q6X8u7qhUvNnZK/SacC/NiuzHm9to1GI6jDUEVvU2zw207xTc32B/r
	 9vpnIx76EERzUVk/KnbYOy+AY2MjOh1JNyvBvkiRRikfoALrf03bIpMFFdMw5KM3bn30s
	 P9oReUy/NzUwHtgU7lozMdtyC4y1RzEBWk9gaF+MFNCEl4nbZstCU4ZyIC8pcgme6GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=damex.org;
	spf=pass smtp.mailfrom=damex.org;
	dkim=pass header.d=damex.org header.i=@damex.org header.a=rsa-sha256 header.s=sig1 header.b=LqCILSWi;
	arc=none smtp.remote-ip=57.103.70.104
Received: from outbound.mr.icloud.com (mr-2006k-snip4-1.eps.apple.com [57.103.70.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD103606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 18:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD103606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=damex.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damex.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=damex.org header.i=@damex.org header.a=rsa-sha256 header.s=sig1 header.b=LqCILSWi
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPS id 3818E1800118;
	Sun, 01 Nov 2026 18:50:38 +0000 (UTC)
X-ICL-RepId: 01a19873-08ad-7e9a-b3d8-68abbe5d2d5b
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhMHV8EWRxBDE0dXBcOVk1LF14MWStWEVQdS0NYGVVQXxwOCVYGVwgXF0EKFxlRTQ5YWwhbBA8fTAxRAkIFVl5UCh0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQcUgBSExwfSx8TAF4PD0wBG1dZBlkDQRQaA18BRgZBDEAeVVJaCl0NTQcMDgpRQFsZVll3D1MdXAAdAkUMDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damex.org; s=sig1; t=1793559039; x=1825095039; bh=GTWEkHLINMQZ4+DrDX6BlFZOxDS9gog4DMcrEDPlThA=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=LqCILSWiYTpC3ostws/qeWZ3janAnI60AahvnawWy9x6Kb80FbINLxI88Sk35EJ7DbfMwfo+tL1sAUA/8Q+fT3pGHM8Wt4iWrut3Ujk1WLRS61bNelI0lT/LRqVU5qUJx/KSwUtUI+t84k05jS/bn/tiZBntVQJXHHo3vG7oTUScopfaryUWbp17gTnGjc7EoEjBMIgqhWPhWMx3mGzThrE4c8ZQYC/hU9pGr6M3py/0J8322t42WCnH8X5Qy5ME4ODrj9C7qbc+ZnEgfCeOU4ExGAIhs2+k+8lSdBMsp3NN8/wNm06dNFOHGGccrIpt1mvylvMyjJx3DbDXj6ksCw==
mail-alias-created-date: 1762459955661
Received: from [10.12.209.253] (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPSA id 1E4C61800133;
	Sun, 01 Nov 2026 18:50:34 +0000 (UTC)
Message-ID: <8cd41211-b026-4158-8e18-454a9ac0bae4@damex.org>
Date: Mon, 2 Nov 2026 01:50:32 +0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (tps23861) PSE-PD support, extend hwmon driver or
 move to pse-pd?
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org
Cc: robert.marko@sartura.hr, luka.perkov@sartura.hr, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com
References: <03055ffd-d015-4810-8b8a-678821fa6dcc@damex.org>
 <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
Content-Language: en-US
From: Roman Kuzmitskii <roman@damex.org>
In-Reply-To: <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX3G8SefKy7BR/
 CGO5YnpFIax83EkmGKoPuX/yRlRP59znFCV8d90XkWct+x3gdaD0EB+aq+/FGMSKfbjbJfT49a5
 burQn41atEnVccL+NC0t7W2j0hqthplowK4MctX+a2ntkDP3OfE6nI7jDdedSwqAZHMB7v40c1f
 hDA0TvtxKEYmLhyJAoncEdwe0fHqLp1y6n8NkyGhDNxEfcpXcBSi5djCkO/UYPJGwrr5NS9OgXQ
 4+2RwBdJqAB8iFUDD5FpJhQKWJYDUeCu3jX2U0uDqtjYF9VhRvoF2Rfhj4PlOW7VEg8YVL75+2g
 NYfkQ/LimuQQSxxPabYE+ZYKY/fK8LI+StGKTMGtUIdQw1Mz4kJ7CNnWan72F0=
X-Authority-Info-Out: v=2.4 cv=XM49iAhE c=1 sm=1 tr=0 ts=6ae789fe
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fTlRW_jb6KJ-_n0FyF8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yvFC1LDB0RorZ2aTko9neJ5TxfIPGeLD
X-Proofpoint-GUID: yvFC1LDB0RorZ2aTko9neJ5TxfIPGeLD
X-JNJ: AAAAAAABsgZKwLTXyyex8DsTDoYaIxgnrU8dNpxn4b1i6cS8inta5svvkN/WhNkaZWCubZ
 bCqk1Nsp1w4AWTeuJ4mJnJdUrZHqQMj124gsquue1XtVEyH/RGKiQ8X2UjILds4/IjSCKb
 xdugEYG8QZ0oXZnDicv9/qZn6vfSg2xT3kQ/HhWoECOGDiZMxieXxcVrf+KazcxoeVWywt
 QLDVWfr/+Pi7ZwUEGBMVB0yNaqgryHWeWZsBEBj+IEbZeMo3a2rxN+ZbL0A2n43wa227N3
 Zn0HbRCZ5+RpC31iN1Fi2Sx5MlrkHc1OoOVvDLyt6uhYdYChGPHRsyqgm4RKbr86BTLcEI
 eZ3DZsInZHQxAwCcYTFUyWPhXvyBgX6fC1+ZfYHEdj8rPVEOpYf/NHloUiJLiP4q+eFP66
 UvIi6YFsY7d3YDZjSzAr5SpL+nPvv/8BngJaoHhjo3rxCjWbKH7Ehrqa8YwhU1bmKE7O+i
 cLTCVnMIMZEFmceqM2gYpjaQDkOBAJEdAiRGDv0BKLmxm11gdGx6txGzrtZeYda2LBysCq
 zBMXCsp5hAkpd01ErMqNhPrcT++y7cZHMehKjvZYWnImHCbDnEWxrDnMMXInubDs9Iygyb
 qvxY94TwcLLU/sByy5oh1QKl+l1s+pxSdK7GtZIvuzyPIt+0egc83XUIWeDcaqy5jEUPQV
 MkYiwNcy1v5bvwK/xsBqQQWIZZfdgUmmjZX27kfcwjqVmv+ycTCLcpemP6rgChCUAPfrfQ
 YlUfO4CW7/9+Pi03sDN6lhe/EQy8UCvpd6O7Z3x142iyevWyBdOlSabU/9nWbjVrLVbaEx
 niYASt2rgeFbeDdZEwAvxsq96f6Tqu5Zub492AvpmgqUTDqlSzzTAviS7fAMzYjLqNKZsA
 Vq3rv2FiJYTGKxffbSqvmTvwcbbz4+5aLOpAx2//yDrNjglEYCf8+/b/nWM7urQvWdIi+z
 rIZqk2d8aQpDCrMKfVWiUs9VDzQkVE0iZphS3gbqVvD3OGuC/+mGMFqWWzVhf0Ii/XMzOx
 QQybjq9Xi6KAtpydxEcJTcviZspT9Zn/duOy3T2tQT1OiktQWAQx8g+v4q2S/e34WbIqCP
 /YSBjQI1T/rxuu6rfxc2p/TyuKphGFcgDMCLkDNzAAzOk/ihvGx3awMSXr7tHexDTb86X9
 azony4Mtoh4M+miBL6CLJWDe44dWIxU+1ggcKqzRZkXoLYHbhEZ4cSIZspnJjOzEs0DobO
 CgRKf2IVcb247sKuhxjWChMcbFvMrzibhokhguuFRHc9YlXU5+JDQJIbF6hdrGhEP+ItJG
 xemE2wJ+yxOMuaHBjCGVwisF008dA=

On 11/2/26 1:38 AM, Guenter Roeck wrote:
> On 11/1/26 10:02, Roman Kuzmitskii wrote:
>> openwrt reviewers asked me to check with you first which way you prefer:
>> 1. extend hwmon driver with PSE-PD (like it is done right now)
>> 2. move driver to drivers/net/pse-pd and extend it with PSE-PD
>> 3. something else
>>
> The hardware monitoring "enable" attribute is supposed to enable monitoring,
> not to enable some power delivery or network (or any other) port. That "port
> enable" feature using the hwmon ABI was sneaked in, and I am inclined to just
> remove the upstream driver for severe ABI violation.
> 
> Guenter

thanks, does second option look okay with taking tps23861 to drivers/net/pse-pd
with enable attribute going away?

Roman
