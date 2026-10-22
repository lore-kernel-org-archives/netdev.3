Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664438;
	b=DTlezbCY94A/MQUyOxQ3hSyyAkcfwaxqlSuEkCE4Oauq1haUO0sKdcfm0/OTnRtLxXNi
	 aDz4EndiGpqGJjXqKbBnDmSYCQtPFAfn5x/zgJO0MR/wps4bCvIvvp7ObsIaZbcjMFOBQ
	 BorL8XSAjaF05a2QalLHnaZA/7pmZC+WScZHJf81djDxVpEzkrSETIlU5R8ivZMwOq9h0
	 GQ/Ou4JwUh/R7sykVjvBrdVn1+QHp12vwSiBL5jJtOmeWrD5vmQHqgBXsqTJFDkE8t8UF
	 8vEbBHnBM6jt2NFhuA+vIvNrljs2XgqRLG5NRyGB5vqcSbmsq3rdZ5/VWH4mOyWfKxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CNFluKpc3PiFtbzuhbtuk0N/oHupR2ogDzznwiIe2cw=;
	b=vcym4gWfmsyM8S9KKoaT+1wJRP+yIZktatQbatDRzdaCzDxPWXaoz1KIlvnh/L6Zh8sE
	 Bf2hN+q3UzjWMHhR7LMR3AoRm+0ga2dNJ69wj96sHhLosrR53clJlzFi3Ogu7AvAkeYI/
	 wsdWFZRzM9oL+K0FatoOq8EXGEau0zibp//CyXcSH1b0Stnk2WOVKm8KPZWCAe1oI2Cwi
	 BZ/QknzsxR8dsoWvZQJuzF5MiDsItDOLBwxRbBUE5fHYrPdd+37CGfSUMx0Y3dC6nkrEb
	 ds+yDfrden+Vj9tEEw9X4yjURay2dpdRUHylyFbTKHdIHmESVN/lGB5WHja03amJpYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nkAys81o;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EesX9ODn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C1606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nkAys81o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EesX9ODn
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xloL2573576
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CNFluKpc3PiFtbzuhbtuk0N/oHupR2ogDzznwiIe2cw=; b=nkAys81o1wXYj6RC
	inL06ScI6mTc1xzSrV6YsKj3o2zTC5XgDk7iH2U44qmE3m2x0OAUKb6FpbD6c+vN
	UGNZde1EFEo4qbLOoPUQlkXrwlOOm9p4rijXuSEdvwPa0ymFma1gKDOxhFzFnXJC
	dSxCE7gE9jOoAXy6UEjFe2BBKVuZRR/FKp7hWdIJ7Onf2cn1s74MmOs283yuMRFc
	2U5EvMdrOcM3KJipkXb5wD+Tw6ZKb+P49JupCtaKs0AcHY2IMJ5GEWITfI0D86TC
	OaxOS0hdmyGrLyCL+7IsySd/g8s2+wGRKW6fmeTxjYouw+awRT41BvX4nX9CdU1l
	71UD5w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahyu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a6d30f66c9so1066068a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792664436; x=1793269236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNFluKpc3PiFtbzuhbtuk0N/oHupR2ogDzznwiIe2cw=;
        b=EesX9ODnKI0dNemzZXyDX44Uiw6sZpilS7Td2J/7h4gX4HqRMMPH4qPZjR8ltOdGFg
         6DZeoNJzUYqkBaGGjIJ0zpIs9LjaKat2na59Hdl+pB1F46IboKAhV+f0NGwXQUVehWoD
         h0HnSZ5pDmYmoQfwuGMTrco681MmIvtrnyLJ3hUSwDYbQA9aPJzEvWH67HPQYWviZqui
         sxLpNKWxw66ge0D/Eq1NqEntJksR4rLxJ1p8xrxJ/T+X6+PTr7o14BkaFoniAnezXsrn
         KW8cyV1l7C2aAAM6/cG3a8ZqD6fOZxrchK7TCTT8oeyNVAUH3GjqqS+xNlc1/V2D0Nbe
         miEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664436; x=1793269236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNFluKpc3PiFtbzuhbtuk0N/oHupR2ogDzznwiIe2cw=;
        b=SYUiM6v6tU5cVw9pN1rHRFizCzS2cLUgnbSdkCk4zsct+tFVJWTU5lmSU4tsLYN2E5
         9y2UAwro5CBzs165L7/J0ZQagVROpnPa9YQyX75fkp1TqCoxt+l62mcyH6DiTP9T98OA
         9KyV1UZvfZsJIs3Su0ZP5gp5n7Pn5zYR4D4hDeVue+PTjBjWTuxhnrwWTBBJl2d9NfSs
         EqzkYzevJP6Up6v+a8bX5SakkDrEdJwCQTN0lGfaYxDNicZ2bv+9TYcTI5HsQBbD77lD
         KhOnwB4HzHMbyjvMQ9rrjzfVfzdy5v+wsiAsEhBmVfZPyokXwv9yJ1PiCiCXNS2IIpng
         9IQw==
X-Forwarded-Encrypted: i=1; AKwUvBwbIvrj6FWHVPj/2oc4zEe3Bh2wwMSpD+14rjsFFpy/dz0fUm1LNSjcyfdZs8KtkhzJG5RQ7xw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL210214T6h0J23j5CFM7dgdghT5r9R+6qQdeKQox3dGYD/YjEo
	zZi4lLA1FA2JfPQdsHLas2QnQ5QxlW2gCKBEIyUbBGtiM0gztO3MWAJVzfzWLFWSOmtCdOj7EyK
	pyYp3K+kKIz+A6pVThSAPK1FHzHIkIvpejRvxzC+HZOi6Wi/Oaw83l1Zqcqw=
X-Gm-Gg: AYBFou0EG8fnjnmJ4Ezg3Ro5YHiLvJKYmPj36f4oEbM0xWg/gfMIDHx9RLUk0SyJTBg
	EZgfIo7PSee5Eu0F2759lnrj9C3q7kdyntCfIVInHAE6YY5W8lbPoazrS8WNN14mP/MkpmPOJtY
	XDZYH7OSP/SWOI9Im9KL4LfSpMjd9s47tQOwI9ozPFOiDTPT/XzicnT9WwwH/W/e9wZLcA++oHq
	dZKKF3J4TqUzGLVxQSmUiWpefpYPBtlNnzso5JDpOzuiFuz6CXwNWRvSzXU+rRMHaKPToci4seM
	bQMKXEyn66OZu3tKBO4eXXp0ZGTBmXVdKXVOpVXcAEdePTnGfsvViTbfh1ZMnXaNFpUSQtUY0bt
	hfVaqdWxucacPjr+6L+f43GPk
X-Received: by 2002:a17:90b:288a:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ada6c8df85mr1039598a91.23.1792664436195;
        Thu, 22 Oct 2026 03:20:36 -0700 (PDT)
X-Received: by 2002:a17:90b:288a:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ada6c8df85mr1039576a91.23.1792664435599;
        Thu, 22 Oct 2026 03:20:35 -0700 (PDT)
Received: from [10.233.17.96] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c71sm3844903a91.6.2026.10.22.03.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:20:35 -0700 (PDT)
Message-ID: <808fbc06-f1e7-4deb-9209-4056ab2e1a55@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 18:20:31 +0800
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
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: add get_features()
 for AQR113C
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-2-0bbb1b84035d@oss.qualcomm.com>
 <179243437352.3135.719818276407053323@kernel.org>
Content-Language: en-US
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
In-Reply-To: <179243437352.3135.719818276407053323@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Ys8zqanN2elXX-vUWE9fk3yOcNgo-Hm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX7FLxHBVjPTEW
 ar4UT9l5FRLoNfPBxlSPr3IvMYT+EwPBk6yNuCivyIr5Re2k7sDe3hIZBEgYpoSWD1mOI9UYKNp
 jIZwoVwWVVyEj9448FBAcAeNPzMDdxE=
X-Proofpoint-ORIG-GUID: 0Ys8zqanN2elXX-vUWE9fk3yOcNgo-Hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX2LhvcDfFpSab
 D1QL+qGl6wzeNAwuYbwAhfpPJnpqgopr0GJwHlQJVaIJdq0pKDFjEaRjqABJOyelI4HMnUjHb+P
 b7VTekfsTtaPeoO5VWq/DEtC5+YddS2cV4E5J+BRvPFM9VU6zOE/YLxVMyBz1ohuqHcK1zZ+1bF
 4FurQnuhb68cFu43FKudQE7QPuw/cHv3jzrWu2kWiCikkclEGTK2Yqxi0cCpldWAw5a5Xzc4Gry
 3jzgAp1u3LuagVWQ3yr5u/TnqeSwHnhdWBkjBdYSCL8EimmGeCOEd8naxCo7yleyEY9iv30DJu+
 DZ4aqiCJ9ldITjVNqDDxdGvosHp/eB9MNwzHIxYooR9xtQQvvwTWefujwCJjf9ZQIE00NRgvngJ
 ctGvwTVVlN3oo3Vypc4pKbNDKqTCbhxVnbrNRQUO0kZYUxHykhjlwPZCOaBDwPgKOUGETsBri0g
 F8rXEOQZxHRdkhwBj0w==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9e374 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Ghr841LcyMZEtTkRx-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220041

The commit message is inaccurate in v3 — genphy_c45_pma_read_abilities()
is still called via the chain. The v4 commit message corrects this.
Fixes: tag added.

On 10/20/2026 2:26 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says the patch adds get_features() to
>    "explicitly declare 10G/5G/2.5G/1G support instead of relying on PMA…
> - [Low] The patch is written as a fix for a hardware-reporting defect
>    ("AQR113c does not correctly report its supported PMA capabilities"),…
> 
> --
> 
> net: phy: aquantia: add get_features() for AQR113C
> 
> This adds an aqr113c_get_features() callback to the AQR113C entry in
> aqr_driver[]. The callback builds on aqr111_get_features() and also sets
> 10000baseT_Full in phydev->supported. The commit message says the PHY
> does not correctly report its PMA capabilities.
> 
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>> index ed5631f2956ee..8213d9a15b4fe 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -1096,6 +1096,23 @@ static int aqr111_get_features(struct phy_device *phydev)
>>   	return 0;
>>   }
>>   
>> +static int aqr113c_get_features(struct phy_device *phydev)
>> +{
>> +	/* Generic C45 PMA abilities do not fully describe the PHY's copper
>> +	 * autonegotiation modes, so add the 10G mode explicitly.
>> +	 */
>> +	int ret;
>> +
>> +	ret = aqr111_get_features(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>> +			 phydev->supported);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Does the commit message match what this code does? It says:
> 
>    Add get_features() to explicitly declare 10G/5G/2.5G/1G support
>    instead of relying on PMA register reads.
> 
> The call chain still starts with the generic PMA reads:
> 
> aqr113c_get_features()
>    aqr111_get_features()
>      aqr115c_get_features()
>        genphy_c45_pma_read_abilities()
> 
> So phydev->supported is still built from the PMA registers. On top of
> that, the chain only adds 2500baseT_Full in aqr115c_get_features(),
> 5000baseT_Full in aqr111_get_features() and 10000baseT_Full here.
> 
> Nothing in this chain sets 1000baseT_Full explicitly. It still comes only
> from the PMA extended abilities register:
> 
> drivers/net/phy/phy-c45.c:genphy_c45_pma_read_ext_abilities() {
>      ...
> 	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> 			 phydev->supported,
> 			 val & MDIO_PMA_EXTABLE_1000BT);
>      ...
> }
> 
> The comment in the function gives a third version ("add the 10G mode
> explicitly"). It does not mention that 5G and 2.5G are also forced
> through the callees.
> 
> Could the commit message and the comment say which abilities the AQR113C
> PMA registers (MDIO_PMA_EXTABLE / MDIO_PMA_NG_EXTABLE) actually
> misreport? For example, if the PHY already reports 10GBASE-T in
> MDIO_PMA_EXTABLE, the extra linkmode_set_bit() here does nothing.
> 
> [ ... ]
> 
>> @@ -1446,6 +1463,7 @@ static struct phy_driver aqr_driver[] = {
>>   	.get_sset_count = aqr107_get_sset_count,
>>   	.get_strings    = aqr107_get_strings,
>>   	.get_stats      = aqr107_get_stats,
>> +	.get_features   = aqr113c_get_features,
> 
> [Severity: Low]
> The commit message describes this as a fix for a hardware reporting
> problem. Should it have a Fixes: tag?
> 
> This commit added the AQR113C entry in aqr_driver[] without a
> get_features callback:
> 
>    commit 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")
> 
> Because of that, phy_probe() has always used
> genphy_c45_pma_read_abilities() for this PHY:
> 
> drivers/net/phy/phy_device.c:phy_probe() {
>      ...
> 	else if (phydrv->get_features)
> 		err = phydrv->get_features(phydev);
> 	else if (phydev->is_c45)
> 		err = genphy_c45_pma_read_abilities(phydev);
>      ...
> }
> 
> Earlier fixes for the same quirk on related Aquantia PHYs had Fixes:
> tags. Two examples are 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up
> PMA capabilities") and 8f61d73306c6 ("net: phy: aquantia: remove usage
> of phy_set_max_speed").
> 
> Would something like this be appropriate?
> 
>    Fixes: 12cf1b89a668 ("net: phy: Add support for AQR113C EPHY")
> 
> Without the tag, stable kernels that support AQR113C may not pick up this
> change.
> 
> [ ... ]
> 

