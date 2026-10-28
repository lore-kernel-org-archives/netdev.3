Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149848;
	b=KIMtu7lCfsjHbyQjmmR4cfPcdME39h/OGVDRQsLReS8ZJZ50KEtYLy3DDTPBSwYqmOQY
	 sCicjz+fBIH7mEuVdFTi6MxTGxJwOXQxn5zc3QoOqYPYRh3fQ5UAEcZhKjwl2PbuiZhoj
	 qX5sprjzbE0oAt7CwuLWG7IvDllbLzJ5KBeBgXDXst/4tc+UBkML0L5vN4hX4MqBc5nwi
	 klDzgqVNrOi7FLb/Vqx5jkrbdCqGQtYD6hZqYqgCViaDE7+Q8lyH4iJAMRVzDGE8vI5uk
	 Pint3+XU0D3qyh8f4jilH5cs77+EjbvrCeCGcVzZiKddJAH2Fj+URFyuxYVgZe101lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149848;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RJPAJwTyk99Ed4rKr5mXpNq6/k97CEUnT+YCoSZgg30=;
	b=4Qr1E2h+PbbybKvd7JrwUXKIGmwNE3jF6G7uoFlSXEI8G+7YBEIn9U4Hxtfy5QNJgD39
	 hTOcmSJ65syr4JXmn0aBfR5qzQUncbWQcy7CMxPfnklKxdR8P9f5LpAe/M6UhPYqsw4fB
	 yUB44BZcRgc0VoN7A+XV0UywOtroupY2xSJeU0NkWR2DVAKBL/STATzhb8VQ5EwMPp2qO
	 mfK/gpRuzr2GqkrDSR5y71059mcKYVlvhsQ3ZQe62ZYBi8zQZfkM97zlut8hrEB7Xtjaf
	 MJg158hPVqwOooB2mHfLMe62E1l2B3RkRvsmIu00AvCBxEuicRWlH4JGhI7cDCWKVZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hZDWih+e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7TM+tJa;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDB606A321
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CDB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hZDWih+e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i7TM+tJa
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0jRWr2735277
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJPAJwTyk99Ed4rKr5mXpNq6/k97CEUnT+YCoSZgg30=; b=hZDWih+en3WP1X/t
	eMjn++8sX3oLIoaOoa2bJDDkhbzruXNPzWmN4FrhHjZkAXSiQqORHY5b1gu+/0G0
	ZbTkooi2Nmgj82v+9u9yMWmxmWjXwjkrOqPa0EZj+KWTKJs63Fxtn7dHFqJ4SgGx
	jXu4vpU4BHcYVc6eoy9/wOqQZJCiRhHMdFI6Jb4uhLyoejB8LjTdR0P5sXo3zCDK
	CNE7JgdJJv+nFzxQJfesBNmWw3TPqyxQJ0PZU75zbrH00m2MACfdmRGtedSN9xQj
	5cbDgz0+A3yHQSs4Ktamf4BLb7OdU+MNJwZ94CAEkqFzNZqdUwuWfzm1wnxjAOzp
	pj6KTQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux9av6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:10:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so928654eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793149846; x=1793754646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJPAJwTyk99Ed4rKr5mXpNq6/k97CEUnT+YCoSZgg30=;
        b=i7TM+tJahUzuLudZwfJbYuZ7N1JL0k2G5viug9r6E6BMisnfyH2Mlt/+M+ZkGS0Fg9
         bt11GNYV/X5c9E1BYS65Uwmt2sKEfS/Gl3vxLnphFRfRLUBHoCq5uHFXJNo3RrBXpRIC
         CHNWfNf88eAH9dTxNSs2s7lxVLFUZHtPQ7+7Mj/G2htVPskPgOpomLAwe0TZwyAMRdg4
         up8Sei1GBQn+v2jTBdkZFGS6C9aGDHLfTAjajTj1kUI7X2SPRp3JjpDP/HGLAKWE0Xhz
         X98tSsMysLiBGg6mNJ3DhFeoO2uYm+baq+JPRf5yqNJUvEr1LZpdODHRXMWrtlxioPQv
         MXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793149846; x=1793754646;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJPAJwTyk99Ed4rKr5mXpNq6/k97CEUnT+YCoSZgg30=;
        b=kRhRqSxTYIgfGPB1yOUaOK9ObW8FomZXQkbHFOGJA9kopz13/ZxcdpoUjLo2k9RT3g
         78KZzHGr73EmJh0MXAMiLJrDdTGIq1eYyOi0QQxr9yCsywnCOatp8uzFGhDxcguRuWE/
         RvyTHaSUKWQDPf4CjkPwlcInO1dKMbG3jzgdf+wAhJmWOPd2jIpE9Q/kteVReSbSjhsa
         orjfdaNz4Ddg+rI5MKKG3tOQihY3A1xbFqu/4hI6scdH9WQR6Y0+R1z29W3Qv2g62Ffv
         2EOCQpaGV0CmQlv0yejC9eQ2QvBhfX0r1O1IEYWcRvCPrG6Vgtwy1fVpirWGoUZAoUe+
         4tTg==
X-Forwarded-Encrypted: i=1; AKwUvBxc5w6dvg4BHLcghd7PghzoN+gdnrBcR14zsQH+skG1Pej3PF2LysiZFlx2ChbYKUYxVVs9z+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaksgKHjTmRg11lBs79MXnvY0S5hRAL9SrwvTxy30AQvhHjVgo
	XZiCkzAElxv3EsmsQLm0khcqQM4FHDabykkF1yEHq31eH6tre+87HIWQI9lof0xh6qvE1m4G6cw
	yGtFzpGzs5f9A2WoYS4pzUG1iKQk67LFtLmrXbGaWiuDNQpo18GlJFJuWdMw=
X-Gm-Gg: AYBFou21AXCRhRTIQFsmoFgUswcBuy4XBwAoMWd/P0eZsMkqtGrli2XpsaDDP71SK4P
	uzLLF5pvd+uv1M3wJc+fsT1cS00Pke2bcMb2mN6x6LSjubagwpHoP96aYvNYzHn90Gn177KliJ5
	9pYrM66VMKtsnH2jybSuluqpwdO7l10ONpxMWPrCP5j24m49C+zSviPGVsfdxsTAINE6HYI1D5j
	I/fkUB0Eepo521Eok8tOjCnY0s0fuyNpL0cq4t7d9b+C6t/Q1nYdlpfFmOxgxZAHUneW/wDme8K
	tvHErGFwKXEwWzKPCGQVz2KtU+1yNuHzL9KS4C5TEgIW5JxlX4fJy1vKYjZJzHn+U4PWd5A0qZj
	wFyI9rCd4dNfo1B9Z97lbrNpqO1O5D26UZe9eatWkk5xuptoY4M05RrNtFrJVBfDEDNRuV6snsn
	m5nEJ1rQdmHOSf
X-Received: by 2002:a05:7022:110c:b0:18a:3911:ec1 with SMTP id a92af1059eb24-1a6ce2ff7f6mr1084995c88.39.1793149845523;
        Tue, 27 Oct 2026 18:10:45 -0700 (PDT)
X-Received: by 2002:a05:7022:110c:b0:18a:3911:ec1 with SMTP id a92af1059eb24-1a6ce2ff7f6mr1084949c88.39.1793149844674;
        Tue, 27 Oct 2026 18:10:44 -0700 (PDT)
Received: from [192.168.1.199] ([68.248.129.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f51bdebsm675047c88.17.2026.10.27.18.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 18:10:44 -0700 (PDT)
Message-ID: <32fc0379-0c45-4011-a7ce-795c44594b89@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:10:43 -0700
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
Subject: Re: [PATCH net-next v4] net: stmmac: dwxgmac2: enable L2 split header
 support
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.bianconi@oss.qualcomm.com, hongmei.xu@oss.qualcomm.com,
        abhishek.chauhan@oss.qualcomm.com, sarosh.hasan@oss.qualcomm.com
References: <20261015221215.1714047-1-sagar.cheluvegowda@oss.qualcomm.com>
 <179244898962.3135.12890405028818098249@kernel.org>
Content-Language: en-US
From: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
In-Reply-To: <179244898962.3135.12890405028818098249@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae14b96 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=djYDpCgIitZxdph7ACYjJA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=WVQ7OhcWbFtDb6XmBhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: e__U18lUaa9G8mBVtYIh87c9zw7Zcz7a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwNCBTYWx0ZWRfX0tjXU7cliQJ3
 +cLkeVt0/hKlDUX+8ntbwPtnacZVyuaIUt7mk+505GuZlIYD04+0j2QC+37vj+Yxf46sL+og4xb
 jo2m9qA4fnDEujg3ywebMzp8lJOV17z9mni68eK5zbWouZpv/O1LlulumThXb1GgYCre+V/PZWP
 QEiAl2WBdK6drskWEpX5jrztMLxzHTb/+XzamBg0KBUO24fIj2r7kOVY67ds8NaEVP+/f1T8y0T
 l1Yls3GxI1UAJwdyKOkV/Kdv0inB/53Flr+MSZldk3OGi2gjx4tUD4km7RPjU+OlWI077rBOVIA
 HFt5blV1gCaASQZtbFcOllgpz0p+3H+7pXCW/GaOWE3e9tzMjA3zBsr8L2wKls5ELIKWbI3EgQX
 gUlYYPQLBJzHXx9IBGyUM7FVBSWz+evOuDW0Lys8cGj0aOnNT3WUAC7c9PH8J7BtfwLSc/C1wR4
 YB7+tV61FtuTuxtfn0Q==
X-Proofpoint-GUID: e__U18lUaa9G8mBVtYIh87c9zw7Zcz7a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwNCBTYWx0ZWRfX7sC+ZP0+z6+G
 0nVwQ7O82n5bUZiA1GDgKYMN+WmLweYuOPSdZF1kfbeov4UQmWIsn0WhCRJHv4cdapx5wHTKupQ
 KnryP1fQbf8VL7B9IYfXz7OqtugwYTU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280004


On 10/19/2026 3:29 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 · High: 1 · Medium: 1 (1) · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] On XLGMAC cores, dwxgmac2_enable_sph() now corrupts the RX queue
>   enable register.

Agreed. DWXLGMAC_CORE_2_00 shares dwxgmac210_dma_ops, and on XLGMAC
offset 0x140 is XLGMAC_RXQ_ENABLE_CTRL0, so clearing BIT(8) would
disable RX queue 4. In v5 I will move the EXT_CFG0/EXT_CFG1 L2 split
programming into a MAC-level callback implemented only for XGMAC, so
XLGMAC is no longer touched.

> - [Medium] dwxgmac2_enable_sph() programs MAC-global split and preamble
>   settings regardless of `en`.

Agreed. In v5 the MAC-global configuration will be done once rather
than per RX channel. SPLM/SAVE_EN will be set and the variable preamble
disabled only when split header is enabled, and reverted when it is
disabled (e.g. when RXCSUM is turned off via ethtool). The commit
message will be updated to match.

> - [Low] The patch includes a fix for an existing XGMAC split-header bug
>   inside a feature patch, with no Fixes: tag.

Agreed. I will send the FD/LD handling in dwxgmac2_get_rx_header_len()
as a separate patch to net with:

Fixes: 96147375d49f ("net: stmmac: xgmac: Only get SPH header len if available")

and rebase the L2 split header support on top of it for net-next.

> - [Low] dwxgmac2_enable_sph() sets the 2-bit SPLM field
>   (XGMAC_CONFIG1_SPLM_MASK = GENMASK(9,8)) with `value |=…

Will clear XGMAC_CONFIG1_SPLM_MASK before setting the mode in v5.

> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the stmmac
>   RX path has no dma_rmb() between seeing RDES3.OWN cleared and reading…

This is not introduced by this patch, and the new FD/LD logic does not
depend on it. It affects the common stmmac RX path rather than just
XGMAC, so I will look into it separately from this series.

I will also fix the checkpatch line length warning reported by the
netdev CI in v5.

pw-bot: cr

Regards,
Sagar

