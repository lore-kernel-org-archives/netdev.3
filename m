Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEB1448E0
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728093; cv=none; b=RthfEdNlbVT1Fpru6s0jp8kZGT8XHtV42o3xZcOzlKD2layOdnf0yeokl5VdrgViPFhEIGwftyFXtfVL9MGLGA3zI+H7J2wLNafmxuG14SOlYElZNaLMWR3TPSApxGut4ObHFl6WvnIyaW36+gvUMCEROKJN+mZ+tG0yXjFGe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728093; c=relaxed/simple;
	bh=w5/bEXdHDh3KY+akMn8RDyg/anSTmKLCGOXpA3/bp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFY7BEXprurj1sVezzywez4aGUPaPGMFj2myJsoh/Y7ZuAvwSb0e3VoSXqAkzSVZeo3mQHoZIptxXGrrgZs0VG+owKxsHTPyEiSQKB7q//gKri6hlqjhr96N+mCPfJA+R4labuFiHxHx41qyJHoVpJ4Qwuob66mxKR5LaH95yQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4BI1wat; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G/6igWNK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4BI1wat";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/6igWNK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWod2755383
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7Be7ki6vK/xn0+oCLdCDxbR/
	0FpklBhaV2q9V9xUdT4=; b=G4BI1watR9030JH3rl0J/3CNSSnWc6Kc8DdT3/88
	hg24BRR+yqvQy+IolUOyKC4OAQ5CHy/1bdVWlAZZdvBGhZbjZVp3nTnf1yUe9VUu
	870pnyjDNYGixgo7CBgfl/I0MnTDKwzQon5n0aw9gLHxPc2u8SACus2KNkpzT5TA
	9O/ajon9KezgR9JXod2NtwenE+zhnRFO4qUg5ePvnzVKn7K+R0S932kJ/S5YiR+7
	XmDwIRygTYpZ/1hFm0Ow4YXcW/zgrDN8duiMaQ8Y+/QiXNBshSMJ0wwwWzLoruJO
	Zwg9OKDwa7u0U3h7gbk9kJqO6V+SVqn2KmFApagoddRjZA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4tdny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:48:11 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9f686e18cso10322277a34.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784728091; x=1785332891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Be7ki6vK/xn0+oCLdCDxbR/0FpklBhaV2q9V9xUdT4=;
        b=G/6igWNKKk261pZO3+GgDNIVR0JuWsGxwTRlC0h8lr2PuJ6xEmv+zUBKWc9kXgY8Ds
         fJ4qjWvPjWJBGmklkoerX2DZke9G2OKhCU1nqdgqV/abR8X7hOx0/NjZFTvGqP3hY1bB
         Pj4Qy3ZlKloDIbb0GKWfgDFtaLshNfGoNxb/FaMIiB/hrD5LLS8bhKqZRjD9ft2p4XkF
         SpFuwQPV5AuCmYJdj/GSpoR/L5h9akfNUIlvnDHBGow8O3nCRIraa1M5qHvVC2dPPh0d
         cgRDgmCDVVleZi3HMkYZlBoa3RZKLRr3VTmnhHVcnxn2ATP/0lzR2yq8zVlmfeqsvK44
         Kvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728091; x=1785332891;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Be7ki6vK/xn0+oCLdCDxbR/0FpklBhaV2q9V9xUdT4=;
        b=jvKxDVa9QHI709/k26jgshGw5v0X/re5uaVmfJyBoicFkIkykax5z5M/v4rxflzc7d
         Vm33BZ2H8vRmaka0M3DuO3p/4Z6LiA3RwypXIAFgjDDYvTIB7/qf5sYC2oi0TAPhsDHN
         rbIT5J2Oxx28DAmy93MX1J8e4lqUnlFooqi9dRLSXDTFFFVV9BNRx5c4MtpGS9OZVyKF
         QXdmBqa8dXOGqX4VsTabRBJIivkPlzMoDfJty9Pwpi5uYG0WRHriSJVo7FPaZtVi+48t
         PJ9sVqPV3giAGit/2C2IVKVhJUpVVr1Umt41emJcwMSnhE+mtFIhe+fgeINSxepaZ3Jy
         UuCg==
X-Forwarded-Encrypted: i=1; AHgh+RrRWN8xCRZD+fiQuoYlKRoBmv5TCRqd6AvvXcRZCb7C3O+sC8QiQSTOhIzjFjTSkjlmCg4y5vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylpy7l3dgsSXORna+jvSbaV22ZtjD18I1qjzn+lETLXFGvpq1v
	Vzi7g0tQAqyj+Q2dRx7Xz1BwhSB9Qw1yE65xhOnuOX2jAKP8/NtpWP7vJodobn/doZmh2mByWcb
	atiPm40G9L9Wu7s+Uq55nkOimIX7KYTFf1CoFHIKJv4k+V2Mr84/B+5LNrWY=
X-Gm-Gg: AR+sD104dh+IfnPwmIE1BjI9Nob1qaavjmwSDlP+uh8EhBqnlFw2qAWeG8eC85e3ISl
	QdZW/cQF0f33ccz8m4KhoywkzRxYs/WsRStVAN1Xg5zHasjEJiKQnKf+puKaf8uH3kqqAvrbH/U
	p2FiS9FilyJguR/kGu0wjVg7LOWbkSKTWUzwaL5J5KV/hNFX+e8pRBnm7zly4S08PApw21HnWKS
	BBm723JVfRlvZrozyOyAddfI6TfZsQRQfnbDAYZ+2csalJLGZhmi7/yELVlJtu+LffZb8NTq0YU
	kw5sv2s+P2qZHdcuGlkelz2uamS16FGAnv0tqTXlyYzKWknWJXNtF4EgTEDyGY6e4YrbVgrSOJH
	zCaL/GtI1JBAlnw==
X-Received: by 2002:a05:6820:178e:b0:6a3:8898:1811 with SMTP id 006d021491bc7-6a5366916ebmr12060453eaf.13.1784728090856;
        Wed, 22 Jul 2026 06:48:10 -0700 (PDT)
X-Received: by 2002:a05:6820:178e:b0:6a3:8898:1811 with SMTP id 006d021491bc7-6a5366916ebmr12060388eaf.13.1784728088469;
        Wed, 22 Jul 2026 06:48:08 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aa73256e7dsm1571864eaf.0.2026.07.22.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:48:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 19:17:59 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Skip PHY attach if custom PCS is in use
Message-ID: <amDKD/9aPYXctiWI@oss.qualcomm.com>
References: <20260722131918.685761-1-zxyan0222@gmail.com>
 <b8f125be-e91f-4b44-8664-5746edb28f33@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f125be-e91f-4b44-8664-5746edb28f33@bootlin.com>
X-Proofpoint-GUID: d1uZNT3t8Gcec7_RFjj5PFjN3m1Gyll8
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60ca1b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=A-68_CoszbapnMyn-RYA:9 a=CjuIK1q_8ugA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNSBTYWx0ZWRfX80ESNgWPw2o3
 bxgJ/AqjCad3Mod5jL8nlzF9cblHhqpzadA/U6knoDz84ntYF35KQc5anjwpLXA9EZ1zqewmx6f
 SaHyKjehy/NK2ioiYKaPZcNs4o2Ti7ciN8M4Nbnw2pPIh1CUtQ0WQODzSMB0QYtKL9d6JuXqvGB
 BiVHWi56PGnw++ekzFPGnZHu28gjL6mvk0cHSzNERk4XAyvnWWCPoxlrhDt7SQznGz1IJfyptjB
 4ZmfJ92m/XaoNw3Qf/FmIk/oq28mnYgZXATOe3v+fMsXB5nIH/ZhbZtSv+OH2aFQwfySrOX9fxZ
 hcsajVXtzCm3jhAw/pUgnI8UqmOmMCOnHEaev8YpgU8SiaBreYc/habLUhyJUrldSTKgISqRbGQ
 ExqsiXhXvrhoI4Q8PB6Y6zIuUcLPSHLvXsO8tIxQfCThmVRQp78PSZTrVZoBO6ZjfEgwGxaz82C
 0hI3wyU8tyo5TSdLsCg==
X-Proofpoint-ORIG-GUID: d1uZNT3t8Gcec7_RFjj5PFjN3m1Gyll8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNSBTYWx0ZWRfX4OfC4D2dQXCg
 jAJHaHfvfGOeGtAt8NZ+NzoeraYYxIWRIw0HnHfhTZ7lmA4YDRmleWoO+TuJoVBNTpIX4Pg+2rm
 SMT3s/HY+NfdcrtlMMykAcFzRvJYHmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220135

On Wed, Jul 22, 2026 at 03:40:08PM +0200, Maxime Chevallier wrote:
> Hi,
> 
> +Mohd
> 
> On 7/22/26 15:19, Zxyan Zhu wrote:
> > When a platform provides a custom PCS via the pcs_init callback
> > (e.g., for USXGMII with in-band autoneg), the MAC's phylink_pcs
> > is already configured. In this case, phylink validates against
> > the PCS's supported interfaces and manages link state through
> > the PCS, so no traditional PHY device is needed.
> > 
> > Without this, stmmac_init_phy() falls through to the
> > no-phy-node path and errors out with "no phy found" when
> > the DT has no phy-handle for such interfaces.
> > 
> > Skip the PHY attach when priv->hw->phylink_pcs is already set
> > and no phy-handle is specified in the device tree, allowing
> > platform PCS implementations to handle the link autonomously.
> 
> Hmpf this bug again...
> 
> There have been multiple attempts at solving this, cf this thread :
> 
> https://lore.kernel.org/netdev/E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk/
> 
> Now, there wasn't any conclusion on that, but I _think_ the proper
> solution is to re-apply Russell's original patch (the one in the link above)
> and to add this current patch on top of it.
> 
> Russell states that this may (will ?) break qcom-ethqos, but OTOH
> we're in need for a solution here, and with the pace of PCS-related
> work that impacts stmmac, there's going to be a point where we may
> need to think about compatibility.
> 
> TBF I don't understand the qcom-ethqos issue, maybe Mohd can help
> with testing here ?
> 

Sure, I can help test out qcom-ethqos and see if and where it breaks.

We could not arrive at a conclusion the last time because I ran out of
options to try and find a proper solution. So if it still breaks, I will
spend some time and brainstorm qcom-ethqos's interaction with the
integrated PCS, again.

	Ayaan

