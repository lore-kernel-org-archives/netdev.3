Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BC2D7D47
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791597407; cv=none; b=tcXaaVsOerBs7JQ5ZCj31W8rbgRW/tZ8Y20MMxvhfGFsnRbxtLl23fkzT36EZoZWiU8NZdXZPAA11oEUajBTxTuwXCmNYSfg9OHMgw1HuiOhx/6M+b05ATzEyg3MR4gcK5xVpjwj7wfUhfM+ooO5WUX/K28nB9LpFf4c0wI1/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791597407; c=relaxed/simple;
	bh=nRWWSqttABLgvI6rHSvRK2FHG22JPBDQFBFelUWKTD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPeps9I92C7cd+TQNtl28Ov7szymU3iFq10PGuXHy3ul06IniTsZEwLxEw+/irQ1Tm1u23SWxlaBrdF61ef4k4HwKVdpjtGk6oHP7ZpzQvjr7xChLAYowPaamhPq21sIx1sjE/hV2LJnzOkRn+43pDZQpMB4iWXmprUTqmv8Um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgwlBGMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZaoL6hCl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgwlBGMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZaoL6hCl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699NK104013519
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KxjhuLW8bicssN0QGk4iHUCA
	7gR7h2LYV43TTRknoWY=; b=HgwlBGMYYXTInqbf/JgR8awbJxjpcG72EdTNY5r1
	FaL6qROAgg/isI5cSzisf69EUvycd2o7emB468DOXPauP2SH3m9CdfW4PhKsrqRC
	IRlOpZj0TQxIhYbzKuN8+l/XsEEEeMnJmdQFC+iy9y82hUBcXWbHN6JIexpaUgux
	ketI6/yWQi5uZ8Ig/ZlLRa2gTlsycLD1/UNTWkTH+bQMbhRIIy/97OY2bgtHrBqD
	XD/TudvuUhaYSIDKpyRHlnm662YYt4yDNBJ3AJRCn4NvNTsWLBWzBexyiIulWF3G
	8/h9EJMeDSHUl5GnapYwJ/8gobhIXgcjksvvhmvadCcvvQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t81eyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:56:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso447129eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 18:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791597405; x=1792202205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KxjhuLW8bicssN0QGk4iHUCA7gR7h2LYV43TTRknoWY=;
        b=ZaoL6hClvzHf1D8y5+Ckn0Z3bFLXyMaEF2Ph7qS6v2YmwT+xG9rjGE4/7cAOM+6WP9
         F3/6qrTEXxaT4No8JQP7V/mx/Q/+wdB9mXlQy/C7/iXYS8S4Hy612XRHWF0iN3Lz7NMe
         KLYkyqcAohmZuOB/fdETNw51xs8kdaAevnjBF21t59+w7sXZRIhsFymSDxbLzRsvHWmn
         wHk/lCwRCJ4I6Q5iBfGkNfxoitINFm7CFfqIOAX5FB6DraWd/RRw5qThOJvC9wBPG1xo
         VogNWdE0yxz97j3r2+WfFtP/O7VcMjwEeys6Czu1Rrmq/0NCYHszGLXv1fULqUas8cwb
         blnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791597405; x=1792202205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KxjhuLW8bicssN0QGk4iHUCA7gR7h2LYV43TTRknoWY=;
        b=RX1obfZWD5mT0aGD56rT69zZSKfNbn2V820T3gYj0H0eoH63KYOQvUGUz/GLM4bfNN
         8k4f88pbZvxWWFa2GhiJMOrGcxYtYqoMbNz1X2bBpI18jzElHrunGPx4lDwPVP5KMng9
         O6Fa0Q42KXjBEx0UtaZQIAhLe9O9nsSPcZcsM4eoN825Y9KOspheeQv2n4fd9O5J+tde
         EPWtC3cia3D3+thsREwWG4c15T7Vm4QtRQGD3gmDdpH9FZ68XJURhDJsmMdroz9nYWHQ
         7ShW+vmsyc4PEG/FFnmMapG+4pK+QB9qVBdqFNuMtzN5l1ocJR8hg2a/tOGeGjSk1NyS
         lPdA==
X-Forwarded-Encrypted: i=1; AKwUvBziIFNxx5z1uYt7ht3cXRfV9by0urJipLxaMTS9m5rHIxm/VS1TN78aiM9AyTSIxnRIxF8BSM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwlm1089Leio6gJOowpja8HnyovV0aUv63NBWdabFD8/cbb/ZR
	EMifl0O5dgeODBWGLxZA17QqIevJpAp6LmQSKQIaVcFJ56E03wBqzw/067iZfbLtzfLGSwTvXZi
	L49BBHRPh9rMApCJ+Z8irhFpTQvI7i95jQkh6sfxMxbVYdzrdJFCtlF7EdB4=
X-Gm-Gg: AYBFou1DzNIKzqof0KiYLOjh8ZTAzMgaJxn+aqOKU8Icx3HHLZQtL3UCwLakiuhofcP
	+a2rtpZSNPMw3X62BXjXXWFixjU4cDxMcpsEdEVIyPjmoE9lO+/M6b1LwfNwrtUjPfdYoMCguhl
	nX1o/jlog9g3zrYX1rdyyfWnF6jtHg1TDkyuoMybnItvQQNpcNvjfWXjl/kpTLwxDIJMopJzp+4
	F/SZ4KwBiCU69oWnVAoJgfjDqhzYF4gsxYEywFqm5dP/ZWoJE/Qihx33COeRZzeNDk3N2Z9yYH3
	WgWG8je/aDD7h1NOeCIEe1t65oXl9IxcPnhOxMDwaUd84fpJO4Y83h+6z2KeNgkcnYVO6dz8OhF
	Qdg5rVAZ7ReK5onnldoQ3T+NYVnkiLWxH01xVj20ZiQ==
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3537df95584mr6419930eec.16.1791597404892;
        Fri, 09 Oct 2026 18:56:44 -0700 (PDT)
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3537df95584mr6419888eec.16.1791597404305;
        Fri, 09 Oct 2026 18:56:44 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm12289803eec.0.2026.10.09.18.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 18:56:43 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:56:37 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: bartosz.golaszewski@oss.qualcomm.com, mohd.anwar@oss.qualcomm.com,
        maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Nord ethernet followup
Message-ID: <asmbVX7U4cgm7XNB@QCOM-aGQu4IUr3Y>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAwNyBTYWx0ZWRfX0cX0RNQPVNyX
 /Yv3VeAcdPgKMttk4QsLpQhaNkTsW+0/w7ZXFfKxsz4lgmPbPwTD7rCu5yAdZn+1DiTzq4/XPKe
 obVLtVdNg9vOAR4FSKjrqFIZrFQ9hPU=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ac99b5d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=0v7sVypaBCCyGkb-lEsA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: bRd2wMG_MKdQzsHWeJwmdd2GSMA-kaWB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAwNyBTYWx0ZWRfX3FxUeNnuszCn
 i2ojA3NuKzJvlBJVexUpIKloIFmyIdp6VUbdnnNlml0VhHyVQjKpK3Ausz6iEak3L2I9lShvviP
 OHyymkQgbGrrgkokGnd/w/IKJHorF53NzBA2Qr0dk5aVzCDLbs14A7mkUwBOaENEhzuRA1Ggrqm
 BIo/hvVzH7OKkbz6UmgVcZs7epGI+aXaPmTEpOh5zJsL+DqHXUrkLLAp8XTDE7kypwfYZ3Lyxyk
 v7y+sp/251hYUA1vOggHprqEpnvUjcjE+H5SvE9ZE2iQgKLxJRGhPPM5rXX7hNVRTDQ1hmMP7yG
 7DTx9SUeNa8dzlN9HMxhex7h5P32MTnjTJtwYVlwm5vJcUTXxrmZ07TvNZoBNxPFZO9xD2WJDIj
 hwwiEIYy1OlfH2HczA1VSeJiaQjZxu/z6V1r8l0bYoFnOGnSkLgqLXmW7ceQ6lT+Z/STlEf5LfL
 iiYNaevXLozUcCRuaAg==
X-Proofpoint-ORIG-GUID: bRd2wMG_MKdQzsHWeJwmdd2GSMA-kaWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_07,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100007

On Wed, Sep 23, 2026 at 04:49:18PM +0800, Zhangfei Gao wrote:
> This series verifies Mohd Ayaan Anwar's patch set:
> 
>   net: introduce Qualcomm XPCS support and add Nord Ethernet plumbing [1]
> 
> Tested on both IQ10 RRD and Ride
> 
> The full test branch is available at:
> 
>   https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23
> 
> 
> [1] https://lore.kernel.org/linux-arm-msm/?q=qcom_xpcs_nord_emac

Please do not post a patch series in reply to another. It makes life
harder for thread viewer and b4 tool.

Shawn
