Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407407;
	b=QNjXZP81RpcXTnItR5nHA8fEcWBDDPhmL4+7V8K+zXe1he2ojcdzeyI3f0a+tmFNvHdb
	 TRGW4cpRCWN77YAKYhI3nHZ7NSb8s2/GSTAifsSlGinP6PKHPMYL2h4tz4MHUIip1FE6p
	 NKwrFVKchLsDj7ILrg9mpk3Zl7dOWBOC5VOE5ffKmoJlhVeN0Hyp22MfiPZQo7RrZu8w2
	 OmPJW92iOO+M6KVWrNmum/0tqbRBnxpkb1VurHosGwS7faam/FDizQz50Scbemkrji3rK
	 apJQ+wBbH2lTCr48cigtZZQyqPFQIvt0UrME3HRHB1YrxpZAE7IeUXWHKFxBSCoqwhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407407;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
	b=KJd0ANoCVZsCP5ukYjcQiRlhlY0gqZ8i2L41WNXcYc7M82YN7Qhn0QolGPfs8h+XFjP1
	 tk1b4fvJm6Bk6OH5PpqU8qIu9RMrpMxkcU9AVO/flr+v8hApQoBY1f7mB5Y+A8nzOPwAI
	 4muI1eWmxVwQJLSe+wqgSVeyfiWS8LjVvo38XRWsM5HdBPnB/JsDqQzLu1NLXAa2DY+cG
	 7AaloJstiif9ySH0mhmMauIiYsBRqAkCqFALVuqLue+u1+HLUgcVXMvR1a59tX3ASRVsi
	 pdZ5yKWkmKLfT/MIW5j4nh8YOi/gnjmz+ANyeME/oROwg5lV6uyH0kqPnbHvjr/5spg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nxEl6DAq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X4AscMPx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A4606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B2A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nxEl6DAq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X4AscMPx
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEJ48L2223434
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vGEIt+0d09kkbPmVgRK9KARC
	j2NgxxPeIMDPZW+376o=; b=nxEl6DAqnVqU3uwhbW4/zp6ad3IRaesYmmV+nVZ1
	3ja+Jh5Nbo36D09D/fHZ2XN1w66Un7liWFyq95iL+h7LcoDsolwfjsvhgQ7D4cfS
	aK6VqcvLEk7jkHcxLCfmRhU8LTHnot3vg1uXgeL3zpc0NivLqrXI8f73QLWG2sw8
	xT6PGbCJ4x4CgEjO0ikVzhy3FohBc73bl0NogIQTgJrpNy7nfVB7QFpsXtXIv3ZV
	9L+cUvjSMRzvR1RbmDvF4sD09aduZClRpci/pE84CF0KLuYzYj8GD3qYSiXcjeLn
	ySPyLhX72ralf5SsOIjVNdgkkEVneHZMBYwNW76JJI1Qxw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh32dm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:30:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb98809caso544633785a.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794407405; x=1795012205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
        b=X4AscMPxrdED3fsmj1XunppdOq1XIsB9mno9fLW0GY5i+Dr5HYodA5su1Yq7ETub2e
         S7ASDcQD8hwhZX9GsSu2yNAlzBU05RC7wBELly5GZ/NoH5LcSqxxmSU8VwEZMnKv2UIZ
         ZpIGQD+h+iNMof+vhgWq7pgIvo3Kmay1kKi47zUzhe4LCrTxGEoh73VFfVz3uXU22hxj
         QmoGr57dR0FrfldhNrY7xcHVvfVGZvdWGwj6HGGUvtKb1vCZDItEdCpe6K7A7QQdmpQ2
         8yKLVu8LyEIt5HNCRIGSazPFXaIj60JBGyYdrePNQIzyCv3hls97dl+JHcWYUH/Qb8UW
         K7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407405; x=1795012205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
        b=cw4OeE2n04sBZNzFb+JCJAygjC4IdAQUWFKX9qnt1Z1Y9RHZzqYBAvoCCzLp4Mwp+y
         JKeAUc88mNdwuYJbJRshKitmEAEoGgzA6w5v5g0MWZ/kfry3JL+yWm7AHaBtZNWnKvu+
         qGW9USRiTKMnV6fCO8d6aMkslnaj//hyFjXsTPaVAYM9p6whcXNeGMFhy7vIg/pnBv7H
         aazErFsPosJ9LpVcqJkY0Vf84kasRRfXWI6VCGc/i7o3cWSOoOw23elRBq55tapF1CDW
         +p+ELHzOFaOGMJau9omRX+zl+APyPJUbOdBCb+NLX4XosIkAXoeqNTlDQxXBcFMOgjVh
         XqUg==
X-Forwarded-Encrypted: i=1; AL+hErHhoBNG+rhQgKkbcXcr7nOXpuOH8DrWh/I3RKD5eB5T1l5/2wTr7YONX+nW9LoleV/BN98qz74=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+TrQmTtzduTWKEiSSu4rTCjL4bM5zTgRFRYY20rUkNoNr0UuR
	2Vw41JNL1KcKu3Mu/qY0Oo3sG1EMiJxD0B4o5CpI9fgak1Y8cb0i0v1CQowR36VYBpvWwLW4HYQ
	KQz2b21M6awebzZi8pxiBscdzxbtUOaMm/C9YONCzBhQzgnrQ9UR8oWOGqjE=
X-Gm-Gg: AYBFou0SYYYFEMsM5i3tJzJ3d5Rs+u70t4tNEgtCAMfnGnE8fcAUGRDErXpbuWYDhQA
	ola4kyUMTQE6VuNBW6cPr+4xdSwLNNKJm4eVSsxYCc3TaXO1zUfBRALKikXJbMegj0VhzhJRomS
	0+gdNyENoyqJoTnL54nTWseW+ThaP2t3Huj/SQwLcLWWAlhBxKmFktJflpwOAMpP716p2atc/Ax
	iH9bQXI9Wqfkx5ZXEeW9nKdkIPhdMiEIGlcHNWgucAj2GAAlDH4tAyBJEVhPATxsx26PiuGs4Cq
	3wOePrLnlEcF+OLIo7Nn1oBmf7n+Tnt1IzVm5BXQBsqA6lHNbejWsoYUFHa4VMPi+Vo5UFsARsG
	tmPfwyrdoAwfLd7nMhpqL4i8ei94tj4Jz1G7YZS98i3VgLSo2IU/Y6XDSIZy0kxF1
X-Received: by 2002:a05:620a:199b:b0:93f:1823:308f with SMTP id af79cd13be357-947b00cd286mr387698185a.81.1794407404620;
        Wed, 11 Nov 2026 06:30:04 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:93f:1823:308f with SMTP id af79cd13be357-947b00cd286mr387688385a.81.1794407403677;
        Wed, 11 Nov 2026 06:30:03 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm12095367f8f.52.2026.11.11.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:30:02 -0800 (PST)
Date: Wed, 11 Nov 2026 16:30:00 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH v2 2/3] clk: qcom: Add NSS clock controller driver for
 IPQ5210 SoC
Message-ID: <zx5rw567pockk65r2joresyzjvytukupcrshtovnnyovmrmhba@tbrrnvlrebn3>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
 <20261111-qcom_ipq5210_nsscc-v2-2-7e2c1dda3ed2@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-2-7e2c1dda3ed2@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfXyPav0+tVFSqt
 pAxvl9unFAhsAFG4kaD3bY4bO0RH+DW7stnfEhdhQ7xfEL575U61D42gTyvjdiVQHHbtnpLRjIs
 YpebPGaPi/zsxmBx+r0LxKMYSSW2t7A=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af47bed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XlM99vnl-FaGDs3XFu8A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UrLwik_WYxOoauMJi4Wk57nasDEeVOes
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX96ini//dM5k/
 fwEvCD8vFNrueTT/5dHW6dwTTw4OvJS+Le4kYMSsmBCalRGKtp6QDkDjesJ/SMM4CvzMZCXvU9O
 HkwGvs6HliW61CBu5MHXKXGiyva2l8kw1u3p16tqbVt5qKvqCulW4ofp0AJwX8hx/RWl0dSSidu
 N+gc6V/9a3VJZAch64F/J97R25sibfwjreQi1BLcJPJXMsET8Z3fM8m0/gLzstkwxWjF9yym96V
 YUb9RXuwwbi0H9ERHnVc5vjw9CIM++7kKCfS6gpihS6L8c2wGTtV3Z5XtNvy9YejCqKI7CQgVuW
 /0/UHN5nDUOCZNURJr1HGnT+v5fRePFQWrimmyKw3n5iOhzfcNw15Ym1zRccm3YwN4HuO2qr6Ig
 mYnxiqKHczUuqQPfGsouc6mpHc5oTtr6G58EPMbYGytoaaDbzK1YQAYTAvaTMXi9ucKfmbL27DZ
 3w84wR+cuOxaeTcbLFA==
X-Proofpoint-ORIG-GUID: UrLwik_WYxOoauMJi4Wk57nasDEeVOes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110056

On 26-11-11 02:00:56, Luo Jie wrote:
> The NSS (Network SubSystem) clock controller provides the clocks and resets
> to the networking blocks such as PPE (Packet Process Engine), UNIPHY (PCS)
> and the integrated Ethernet PHY on IPQ5210 devices.
> 
> The icc-clk framework is used to enable NoC related clocks to create paths
> so that the networking blocks such as PPE can connect to these NoCs.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
