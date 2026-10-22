Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664404;
	b=i+eG7GlXWr4YKzR37ITppSi35gZCdmVOIEg09gLj+ErXbLTd7gICX5JBsDdcMAJUGtkg
	 LRlKAzIOHGh3U9tftIFzl/tOvkjfF8SQ4Fgx3l+i4ThVPbSh4dMB7zzAiv8u5B1xdkM0a
	 fpuOLyHk5qEiVICi9V8fOIxOhhFIVRs7sUeaxNrNqJe92N5j/HSfGZCnCrR68t2rsG1cq
	 I/cFqKHXvsrk1LSFHAjl5w5kTPkKpMXrJLdMBHLcfplXxWEK6OLr1LZGLBt22kd5Z7kys
	 0QBW4Hb3U3jve9S89dkyS0aZyJKbScNVOuHsGfu+xThGXMNl9ouB1ptH1LV1Wyfgm/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664404;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1yTztMrdHMBfhUh6agAGNzJxVjzAzGatJk/iS/1f99U=;
	b=CB9+qnp5zy8mHTXkSkelI4ibUsQvzTxxasQGJePNd6yKt0vxPBuIhlDmnLS/I4TBVuEn
	 j99Gd5kFq/G44+UorDy+87RN5kJHkTvp8x8lTCYPREd0bI50IN1Wk53INCDMrLOYQrNRl
	 memkxp2GcUuClSisvcuv2Z095e9dWJAXcs65ZW5V+nG8wCCMh2z3iWdslUIT1QPTMG4Pn
	 CG+DbKszgpkCQuKjINPZb7VMhnjNNe8mlhsUe4DsVH06p+BnQ+oUdw8fiMtIMIWdInTP2
	 x+/WzKk20/VBQxlGOTWVYTCaT0jrZfdRZMqHOwZ0AeVfgSwQQ4KsR/lOescr7wb+++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1J+ngFs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F2oTo221;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFE60A2601
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5EFE60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1J+ngFs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F2oTo221
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xpoV2574043
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1yTztMrdHMBfhUh6agAGNzJxVjzAzGatJk/iS/1f99U=; b=X1J+ngFsz1hmHuht
	7SMMQcwLO7nfB4+13U9onaCCqaDkC4XcNXruWt/Gd+xhjIFDtQVt2dLDfAkXYPo5
	Xxn2yjyth+uHLXwLjUazmce2wW+wZVxwKbPfZSELUcZwTZfM9QLkqVyLJbriloJj
	T9sIY+cx8r8swZrLnCo+2+n3AlZLTBbNY3zXzhnx0SIZ0yzTB1FZ5xOeicm3quhs
	At+BdD2+hcVdYTqWtvzMuy0QCHIA+VP5Z6mbDDmZpAZJmn4OTt+WKleDAt9Yuza3
	NFdaTul2XTSUYkkTS6R3N6J2iIVyblizQDKRArPquLxIcHlt0XgaaoL7DArVTHS3
	LVT9Nw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahyme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so2577526a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792664402; x=1793269202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yTztMrdHMBfhUh6agAGNzJxVjzAzGatJk/iS/1f99U=;
        b=F2oTo221nVKHDJDJCiDpqKiQvpzYzIjbDx07v0rR0nBFsKu+PcoBq0trvADdRfVl8y
         Vh6JAoO1SO0s4KcNZrWX4idcfWAsvtqfPFKnqThl8yeFVclnCm1cDGH0hodl96NuNITw
         +iU0P+MUnhvUf4wWMBt3W01JnmeMNLzPFGbwuNjSWBEXVlqhcbHkqRGkzy8XRLi7PM4D
         agynhbVt4pdrTvN6V7pCjtlHzQBpdhv4Znu4WFszCrppgnts5wzOJxcTblryhG0x09i7
         VsbZGf7IkOPNGs1ceyci/kM9rkZ7HzlnQ+yw23QSrl36VaYgs5K5Hii02FzZN+vy4ryi
         y+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664402; x=1793269202;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yTztMrdHMBfhUh6agAGNzJxVjzAzGatJk/iS/1f99U=;
        b=R/JjjV4wuqRqaCMKUuMBVJzKWtCTMMLpw8dkO4pt/ayV7fqQ0a5yaOGkHa9JfGDn1S
         +OTAr7qFFT4muQiHTwyD4DsEF7+9uptDmtvaZYRy3wuMy9dBn4320DnVKapGY6eHDVrw
         hO+1a2JTfK8P3eVgUoPnbLD7VoYHZg1IKsf4jKvy0q4Nzf7a1IFojtqvinm1GQ2hc7LA
         +qdlqqO/rky7e7eHT64PAW5LzaJAII8I2qYg+ilcbrl33YaEy3M2VEY0cn2b8x+L3HfX
         aKxZyYc/nGX7B7wULRQVnEr6pOrPXSlthUhvLevmvnyhWNVK9FbAUiwhrqhdKmSv4CLP
         mWKw==
X-Forwarded-Encrypted: i=1; AKwUvBy17hO0KRDD0CA+HVT+zseNA34lKhXrThxVrRgT8HgogDl1OzXo1z5CHtsL4J+/AhCVN8yv/wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeZjEyD88K2O54q4vHveATcmEgSqWilmcsTv4kaQu2cQVsVUlh
	utcd5HNGDcfJQ5P8naW34yS7ewjSVLcnurtH+xQ2OIBU0YgF0KKZN3tcLCSJVfN4k+hLfIlPskM
	AqKx4JHVUbPztWlAG2NzsEnfMk+LW2htjmN7Sqd5ybWs/92OS/tThjQX0xYA=
X-Gm-Gg: AYBFou0mlD8UqlRyYQWgEPfaRFSQAJe5OAB5gh2S9PX7cxMRfDIzOGbIPXoV3ELvmDl
	DFCcWGd5BvMfXouCyhPYtn8rn/cpOixQa/XAkn2VNV5br5FdLHk3TaAa9cyjuzN7Qhct7sZq8yv
	fO3PgJKWglHXpP/rbjwph0TqXHiEU1QapRTbe8pL5GT3O9Vee5Jmx/bx2EVSc4Dt3cfagpNc6qp
	wRBHLX/S8qoVDqtMhxcmlanDRAK0G4+OYc9u8dhLSFPMMtbr+1Z0yy/5LvhP2i30jlb2Aawk8If
	2t516cUq6FA+ejaMtOxT7RmyJ7GBfqtblJ8RH2Xb39dfrId8A8IfXNZGHo1+RpI5ryhCfkpf/Tq
	xbEpViMr9c9h52XEvrsz+pQZI
X-Received: by 2002:a17:90b:3f8f:b0:3ac:7c4d:8be1 with SMTP id 98e67ed59e1d1-3ad8708f735mr4053379a91.62.1792664401996;
        Thu, 22 Oct 2026 03:20:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8f:b0:3ac:7c4d:8be1 with SMTP id 98e67ed59e1d1-3ad8708f735mr4053358a91.62.1792664401432;
        Thu, 22 Oct 2026 03:20:01 -0700 (PDT)
Received: from [10.233.17.96] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5f8sm3582134a91.9.2026.10.22.03.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:20:01 -0700 (PDT)
Message-ID: <60f167e7-d790-4c53-a097-d037174cdbf2@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 18:19:56 +0800
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
Subject: Re: [PATCH net-next v3 1/2] net: phy: aquantia: restore EEE discovery
 in get_features callbacks
To: netdev-bot+sashiko@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-net-phy-aqr113c-fix-pma-capability-v3-1-0bbb1b84035d@oss.qualcomm.com>
 <179243437219.3135.15283018855918388042@kernel.org>
Content-Language: en-US
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
In-Reply-To: <179243437219.3135.15283018855918388042@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fNcRtwNhCEzwHZ4MbCM7qtP5YFiXF2WW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfXzou+2fwbHFzf
 XXBsgVan5OHVQytagraLjhNfYrcgnv7kq4MqmLc/hkJF+frQJd7OYOSbhN5wXDuyDjhQ8oatWPO
 KmjUn+rmZm1zSv5poLzCW2KEL9X3qQQ=
X-Proofpoint-ORIG-GUID: fNcRtwNhCEzwHZ4MbCM7qtP5YFiXF2WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX7IJ5u+obaBQy
 v0RifS7BmF4wIReC58F/GT+9HUahTZhLHqiSZFdke+VmsNivA46+pSwyVzQOwSrEx/AzWT/Eeda
 oPK/Zq4Z65WOjzcxuZeKxnbEU+RTxFv2C8JPUHsgSCsRH5ckyPjDI0bWYceOheZYzRlXX6WAW9S
 sLXfQK4flLdU5kc5azh+e/e8L5b8XgKNbA3vxs7xcKZHpdEdUXLkYq9c5G2+sz5QUjJrreQAdAi
 VEKtF6uaVF1CcSKBVbKFN1x0jsznh12QgNiHms3Md/Cq7xDxjJsr54GxMJF5SWHfIIMekKV/Xum
 H/MgKOreUmti8mNa36xXcfliz5SI3zcfeh/UTxswIeQaE+qvH7CrbUErDq2uVpywF8id1jQRT4d
 UGdR9zX98WGk1SKd7R2p0EeIqhY/WiqVsKSv3vIcuuERkTN4oN1XBeVTFeqkwOC1H24EzAZJ7RC
 wxaS8Et/+WxfSpnY8zw==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9e352 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bf0RVgVcwt4iFPmx6FUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220041

The High issue is legitimate. The v4 keeps the phy_gbit_features mask
and calls genphy_c45_read_eee_abilities() explicitly after the supported
mask is final. Commit message and Fixes: tags corrected.

pw-bot: cr

On 10/20/2026 2:26 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] This patch makes aqr115c_get_features()
>    (drivers/net/phy/aquantia/aquantia_main.c:1072) take phydev->supported…
> - [Medium] The commit message misdescribes the hardware and understates
>    the impact.
> - [Medium] genphy_c45_read_eee_abilities() runs at the end of
>    genphy_c45_pma_read_abilities().
> - [Low] The patch fixes a user-visible regression (EEE not reported or
>    configurable through ethtool on…
> 
> --
> 
> net: phy: aquantia: restore EEE discovery in get_features callbacks
> 
> This patch changes aqr115c_get_features() to build phydev->supported with
> genphy_c45_pma_read_abilities() and then set the 2.5G bit. Previously it
> used phy_gbit_features plus 2.5G. The aim is to fill
> phydev->supported_eee so ethtool can show and configure EEE.
> aqr111_get_features() now also returns the error from
> aqr115c_get_features().
> 
>> As a result, phy_probe() never populates supported_eee for AQR111,
>> AQR114C and AQR115C. The kernel then clears advertising_eee:
> 
> [ ... ]
> 
>> Fix this by following the pattern used in aqr105_get_features(): call
>> genphy_c45_pma_read_abilities() as the base, then set the 2.5G bit
>> explicitly since the PHY does not report it correctly in PMA registers.
> 
> [Severity: Medium]
> Is this description of the hardware accurate? aqr105_get_features() is
> for a PHY that fails to report 2.5G and 5G:
> 
>      /* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
>       * here
>       */
> 
> Earlier commits for this PHY family describe the opposite problem. Commit
> 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up PMA capabilities") says:
> 
>      AQR115c reports incorrect PMA capabilities which includes 10G/5G and
>      also incorrectly disables capabilities like autoneg and 10Mbps support.
> 
> Commit 0974f1f03b07 says AQCS109 reports 10G and 5G but doesn't support
> them. Commit 8f61d73306c6 removed an aqr111_config_init() comment saying
> AQR111 reports speeds up to 10G but only supports up to 5G.
> 
> That history is the reason for the "PMA capabilities are not useful"
> comments. The patch removes them without saying why the PMA registers can
> now be trusted.
> 
> The list of affected parts also looks incomplete. In aqr_driver[],
> AQCS109, AQR111B0 and AQR115 use these same callbacks.
> 
> The message describes an EEE-only change, but the supported and
> advertised link modes change too. 10G/5G may be added, and Autoneg,
> 10baseT, 1000baseT_Half and TP may be lost. Should the commit message
> say so?
> 
>> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
> 
> [Severity: Low]
> Should this patch have a Fixes: tag? The missing EEE discovery seems to
> come from 17cbfcdd85f6 ("net: phy: aquantia: AQR115c fix up PMA
> capabilities") and 8f61d73306c6 ("net: phy: aquantia: remove usage of
> phy_set_max_speed"). Those commits added ->get_features callbacks that
> skip genphy_c45_pma_read_abilities().
> 
> phy_probe() only reads EEE abilities on the static ->features path:
> 
> 	if (phydrv->features) {
> 		linkmode_copy(phydev->supported, phydrv->features);
> 		genphy_c45_read_eee_abilities(phydev);
> 	}
> 	else if (phydrv->get_features)
> 		err = phydrv->get_features(phydev);
> 
> Before 8f61d73306c6, AQR111, AQR114C and AQCS109 had no get_features
> callback. They used the default genphy_c45_pma_read_abilities() path,
> which does read the EEE abilities.
> 
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
>> index e95d391a6dc23..ed5631f2956ee 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -1071,23 +1071,25 @@ static int aqr_gen1_resume(struct phy_device *phydev)
>>   
>>   static int aqr115c_get_features(struct phy_device *phydev)
>>   {
>> -	unsigned long *supported = phydev->supported;
>> +	int ret;
>>   
>> -	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
>> -	 * are not useful.
>> -	 */
>> -	linkmode_or(supported, supported, phy_gbit_features);
>> -	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>> +	ret = genphy_c45_pma_read_abilities(phydev);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: High]
> Does this bring back the wrong speed capabilities that 17cbfcdd85f6,
> 0974f1f03b07 and 8f61d73306c6 fixed?
> 
> AQCS109, AQR115 and AQR115C use this callback. aqr111_get_features()
> calls it too, so AQR111, AQR111B0 and AQR114C are also affected.
> 
> genphy_c45_pma_read_ext_abilities() sets 10000baseT_Full from
> MDIO_PMA_EXTABLE_10GBT and 5000baseT_Full from MDIO_PMA_NG_EXTABLE_5GBT.
> The new code only sets bits after that and never clears any. As a
> result:
> 
>    - the 2.5G parts (AQCS109, AQR115, AQR115C) would report 5G and 10G
>      again
>    - the 5G parts (AQR111, AQR111B0, AQR114C) would report 10G again
> 
> The modes that phy_gbit_features used to supply (Autoneg, 10baseT,
> 1000baseT_Half, TP) are also no longer forced on.
> genphy_c45_pma_read_abilities() starts with:
> 
> 	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
> 
> It sets the bit again only if AN STAT1 reports ABLE. 17cbfcdd85f6 says
> AQR115C misreports this. If it does, phy_probe() runs:
> 
> 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> 			       phydev->supported))
> 		phydev->autoneg = 0;
> 
> aqr_config_aneg() then calls genphy_c45_pma_setup_forced(), and
> 2.5GBASE-T can't link without autoneg.
> 
> If autoneg stays enabled, phy_advertise_supported() copies the false
> 10G/5G modes into advertising. aqr_config_aneg() then advertises them to
> the link partner through genphy_c45_an_config_aneg().
> 
> The next patch in this series, "net: phy: aquantia: add get_features()
> for AQR113C", builds on aqr111_get_features() and doesn't fix this.
> 
> Could the hard-coded speed mask stay, with a call to
> genphy_c45_read_eee_abilities(phydev) after it is built? phy_probe()
> already does this for drivers with static ->features.
> 
>> +
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
> 
> [Severity: Medium]
> Can supported_eee still be missing the 2.5G and 5G EEE modes?
> genphy_c45_read_eee_abilities() runs at the end of
> genphy_c45_pma_read_abilities(). That happens before this line sets
> 2500baseT_Full, and before aqr111_get_features() sets 5000baseT_Full.
> 
> It reads the EEE capability 2 register (2.5G/5G EEE) only in this case:
> 
> 	if (linkmode_intersects(phydev->supported, PHY_EEE_CAP2_FEATURES)) {
> 		val = genphy_c45_read_eee_cap2(phydev);
> 
> PHY_EEE_CAP2_FEATURES contains only 2500baseT_Full and 5000baseT_Full.
> 
> The commit message says the PHY doesn't report 2.5G in the PMA
> registers. If MDIO_PMA_NG_EXTABLE reports neither 2.5G nor 5G, cap2 is
> never read. phy_probe() then drops these modes from advertising_eee, and
> ethtool --set-eee can't enable EEE at 2.5G or 5G.
> 
> Would calling genphy_c45_read_eee_abilities() after the final supported
> mask is built avoid this?
> 
> [ ... ]
> 

