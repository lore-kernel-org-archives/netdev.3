Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2E2EEE7E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289295; cv=none; b=Asl/YPimHkxlrOfx4fupWvB2IhLpRi9xMF4Vh93rWk401TWDePqAAOGP+8b9YbHuWPUajppgCHTAU5C3EzQCyd2iiSb4qPcj3ZTt59f67foXj7uKgyG4CrCUFkoHcZjt7N47DPUfzSToO+k8lJdPO+yy3cfNXlDLD+A3uZOhtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289295; c=relaxed/simple;
	bh=KzvNUUkydSWhvX9fmd3nLhLQL9gkZYhRhTFU1L0+feQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNNz1aTbr02mqX2RFwOJ8n06Kj0nD0wCF2d8vpq85VOo2a/6RAx6eBiaw1R82nXGKklLPHc5u8NRk4xWbodR7QTnEgJ3WSPsnpbqwXdlfnfm2+1Id9zzfdqNvWC0p1uvx4tBJuO4YEOBqEddme+1nSePIy6F6Vuvr67b1l8aWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TcWiLFfd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fgy40g43; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcWiLFfd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fgy40g43"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPOHC1045951
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 12:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z5f8BNGzj2OByoPvskvqwGDg
	iUC9QQz7w6fWEEjqF/k=; b=TcWiLFfdX0LJuVMZ18iuI6Jl/+QXSLur/mBnovyV
	CRNhe66+8ajLa+1HUeGAWRfzcfBzb7R7Jzmj6DFfPgk08AjLbETC6oclEDyk7loi
	6t9Mem04GdDOksmmRi9HepbGbwaLzfaOVSVC9YxSg0IqB/Na0D0fVD1UBvKQKHTM
	tIGBn9in2L8ldGopQlp3MUDNQlxqqFSFKwxXcAqGgj9AjaLgMfeYllVy34U1voPh
	Q7T8GUS6ZH6gntF+bqtw08YUAJ8SsCgZx52chvePGlL2qAFMJSqgLTSgImALRf3H
	Tnt9ipgraQ1iCqvvi7MXXTF24PwPBW3k3frxnHLEAbycLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xfbggr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 12:21:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbacbb996so450551585a.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791289291; x=1791894091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z5f8BNGzj2OByoPvskvqwGDgiUC9QQz7w6fWEEjqF/k=;
        b=fgy40g43SJhh3giZpKrGQ7eoFqatv5OEgRV9lhhecLSpcR8qlWc967s5R1m8Nhk67W
         fhJliwSlO/EO8yEu1d2uDmtO7NBc1VitMUdhcVsMNseo/C0S1NO/Qhm29vAdBHZdtUbD
         AmhZDKGUuVtOtJoU6NDdTGMk/WppDMPwB+s6KksyI0Kos4u95HuAKRsj2k1px90O5td7
         Df57akhVtYcRyHQqOLhx1U/EQEpPnZ/e4Nou4tEJETqArNVmyawQQ6W8eoOcqLIAhKqV
         BlHgsb0A3LJhrmbWrN6ROrctXld0oiEToP/7/ljznZty9XimCOZM/LdQfIRrdBL2xeXI
         ERuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791289291; x=1791894091;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5f8BNGzj2OByoPvskvqwGDgiUC9QQz7w6fWEEjqF/k=;
        b=15ep2Is+qzNe//2msfVeHmqykY7uC17W45REELgmFTQIjh2JJdjszTrgT8lQhCf0x1
         eH/FFpwA3U+zgLDBF0indLNrUWKRaRNJoPI9EqtAY0c13/JQp7orlRDrHi1VVMtUDr0a
         3ro2Da2zY+bYG8v2aby7S18EyHaXoPISEADSZCLM6qqpWr+n3OuZvW/aGBcgRCYGg6S8
         +YyFvzwHNnRwWzLDCn+8ypDkNbyyw95y/wqxW8ShDDidA5Xx2QIS7/T8phPg4B93HYji
         nQlnJBLJyHowR2vGgzxGFXWrqydR5HWJrZDhCGvCQDhNpf+1UYwM+tPKG8air5ne6Z9Z
         fTfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV9jivXAEWSeYjIhNKVzlSQHj3IUtlDJdfMkhZRYbdYYqPSY9dkMtUvQEMKTUU+17rZXjSxUU=@vger.kernel.org
X-Gm-Message-State: AFuF++kdCbtZgV6DLvxnAeVkyi252kEmOomizFGG/KlxaR6fokoRMqJz
	12xcXEZwB2Z3WTaQHR9LVyztz32HCe6ev7PK9kk9KhLem1uW6x55AtUBiu8FKYZfu6ynbsIQS3b
	BbNsLwcLrYmoA5zx4CXSAGTRWMRTekflg6ntH0QNaD0q/JMs2mswV7HTx1Pk=
X-Gm-Gg: AYBFou1ImZ4Da4ACfIaG5pxGTmDTdEQsPrSPnu1XCW2Z0G0OmCM6lPsJzvokqJYjWbV
	bu1uxlOtF7wkTHucEpI2/s5cpiWTuGoYWt+gc07UERuCjoiPkR2CgsWEPQnGpTq8KLq1MPnVNFN
	okfqwIaS+tRt33Qt0PjPO8Sd7ZNah/Y8n4PYZWiWWZPP4F73FOF70vFitICiHFZINz9mFx5kF7t
	g6kIMl4BmLpN/EEnycG4o6xS5F2Mp45CQwidV7osTGQsmbYKZ2AbCm8PhyLV87O5OccbUUZoRoK
	bJqEuiMGBl9e+kxgBlVLukqk8yKssUzK2YRqfIielLqQYLQS5FhOngGMSkVhOQgHkkwdK4nDUoA
	U7LNd2J5f4bvfNg==
X-Received: by 2002:a05:620a:26a9:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93e8f531b27mr198162485a.59.1791289290510;
        Tue, 06 Oct 2026 05:21:30 -0700 (PDT)
X-Received: by 2002:a05:620a:26a9:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93e8f531b27mr198156085a.59.1791289289924;
        Tue, 06 Oct 2026 05:21:29 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62289e77sm10409233f8f.21.2026.10.06.05.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 05:21:28 -0700 (PDT)
Date: Tue, 6 Oct 2026 14:21:28 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sinfo@kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
        Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v5 0/3] net: stmmac: Introduce hw queue priority
 offload
Message-ID: <asTnyCWBTMC-B191@lore-desk>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
 <179128376932.2231598.7510820392039419594@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xowIYDwRSgTsKp6W"
Content-Disposition: inline
In-Reply-To: <179128376932.2231598.7510820392039419594@kernel.org>
X-Authority-Analysis: v=2.4 cv=D8TSufRj c=1 sm=1 tr=0 ts=6ac4e7cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=DvzmiShtAS2h_ptsr6QA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=41xhF3IbKvr52oIostYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: jVzGcjXWdss7kvvrm8IES85rQfsxsKP4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OSBTYWx0ZWRfX01RagFfcvTgV
 khUjUks1V8dEA0Oq7iUKltwpTxRqL2M8s/VvnuljkMmqxk0oXQfvAkyKCEYnUrhm2awvEcvZ2DP
 qli2OweI5W0irYBytjdLgdX1uRxhlzo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OSBTYWx0ZWRfX+PvpoxDu/+7U
 rhslguFDjnNYV1smf36qMqgLef9vz+bVAdBzNH7fZ6bDlb2Ansj8m3wzjFnVfHl230gXWVRR3sy
 RLuH1TzVhABYrcjXDe8RE2gYueEfqYwPQWNttsFVCLZs8PWqditolsr5Oep+15VTa4nHIxA0XkU
 JgUVAXBAFpkbM+DqZKoZVny7Xl1ghgKfqK8Iq3q9BbDcb8PHncjZDvusGDJhxHh0v2OZflP1WdT
 nbWAs22HLP5pPUHvCAd72VNAdaxMvNZ8VOZz+alOTVqKBsLFUw0o3k8UF4BHnjanEBo9u91aW87
 26MuhmQlXrvzLaY7W2ZD22ReknTL9x9lC7SMJSURX8+LGKjPQ4rPuX5KDI5Pg4/3deWpeXyeOIR
 Q8CGYea6FTkRxbM7vdSavKzzF0Lq7MZaT4AcdrCjG77xmt5gDjm9FI362cCioAAlMygB1PpB1Fr
 +gtFTSnNKLpKltXJkng==
X-Proofpoint-ORIG-GUID: jVzGcjXWdss7kvvrm8IES85rQfsxsKP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060049

--xowIYDwRSgTsKp6W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

This is a theoretical issue found during code inspection.

>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

--xowIYDwRSgTsKp6W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasTnyAAKCRA6cBh0uS2t
rMg1AP9v/VzOkL2KWMhFrdvcFRagaZkWaJ5iym10aMMZrYr2ZQD/ZuXdvASU16J9
OwpZ4BB/pQX016iaD7kKw/CX7SJWaQk=
=LW+l
-----END PGP SIGNATURE-----

--xowIYDwRSgTsKp6W--
