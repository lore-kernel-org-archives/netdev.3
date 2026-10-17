Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543238DC44
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255172; cv=none; b=ndnkf1M6B4QCb4N+RkYmbM41woTKoqujBzQR64xxpwSFw2k00riRePuwv/EBWI9XuhUGG5j80K5lvMKB9tFBzdGrlWa5qyV4z9yV8ISVQuW4g2T4dKGSK5wBLLj0+w08t3NIm5AvsjXplA7supCjhTuJj4FxVvf3f9Z7lzr2e6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255172; c=relaxed/simple;
	bh=VjJXPVvJ28GFo5oaYh5V0N4OmfzYXgOo11M2D9Ou1Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlH7PBgliG89WlOtPPDHpm8ip4BbvPf89jZ60R92F7TdHeT1Fxvy6IYXipS0LJfiQVZIDsCJLKkUkcscPdW35psDsEq4wdYGiJ60XkhGiYnrCr0AM3U42kdvnXmaYkhknFq3DvUziGA30yPmiARmrqNTdqCOWA56O6fzFH6JIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqcI3njC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bkWXpWKm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqcI3njC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkWXpWKm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGAmgw1180752
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hz4iIDuDhHEcy2mIuGeKuord
	9GLsrFZT6JV2X218PUA=; b=iqcI3njCDzM4e7mRHLw+YV3xmeKx13qdpNpYLO1c
	uKuJcnhcRz3rtqo+XqDGeMCZv2dURNY8sE4Up/wSPorj21shN+H4P4PvOUiE1k4f
	HrKJsV+TXCcL1K6rMrtrXUEtT4Vlu4w4TsY7ngl01CsdTZz1rKlYemGVmnu3eNHV
	+HjThJ6ViFeCJyAVpyHQYmZUV+RGbosOkNtCwmXNHB6OUn0sulMIxvCNKMz7qg71
	VvhPs8OoWfwTc1Wwi9VbA8nr0EEah65QxY+qlhZZrIAZfY7QJDXrV6PujpiUFd11
	LA1oKqK2zNAXkDqjMldYzsbUJ7V6A2GAOrlTldaC5GhPdA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0bghdw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:39:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35d4538fd74so2935981eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792255167; x=1792859967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz4iIDuDhHEcy2mIuGeKuord9GLsrFZT6JV2X218PUA=;
        b=bkWXpWKm0NRUSG9PhLYNTHN4FhE5pXgWKQ2BiFrJAtTOrxb/gAywrLXj2xi2b2VLXZ
         LAsW4tMXgcBZ3lKecm3kdB0a4DKW24THIoB/56X8kIN0VF9ox4X7T1NACIHdwP/POypx
         lqaugXapDVanzTkTWB24hmEnFf1Ab8LYqWDH5iHSXodjQU5aiJ322S32y+58ZHZv4ROb
         Vaz7JgGfa+6hEBy4UOSi/BatVitZ+27XBj+/l/NORlB+y1kEnbo0zKOtqwfJj8Bcr43a
         oN0VoMC6vkfxjAeQ5r1phAXB7gAfVYB/qGtUecgSc6M93dRlw/4Yd8ZoMgu9IDGawDgP
         9r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255167; x=1792859967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz4iIDuDhHEcy2mIuGeKuord9GLsrFZT6JV2X218PUA=;
        b=y3bgmC1Eqlj+i1k8fWUjrwFbviDKSGdY87hL5cV96c7caeSVFHzc/5IDBFjyGJKEqE
         1ED/jdN6EvAffJKYEsaOiojOsqlWBZ59+RPXAN88usv3MDA6yMtz6SWozh+EYTl93316
         T+YR0c4r+PysxQpHVuXTjitxckuS63fFHVKFBiGr0toT9fUkRxYFi5f8glabO1cPGJBR
         91SPtmGujflA3Juj17rh+5h1IkZNXSqk7uQYCjZWUeqVZEO+FgbldkmP4i/Y3h2U/Qi3
         4W9ORlWldeEC5frbTdnNemElMZxOCK3H4YClMpGuQnPNwb8BY4FFZCm4W6j0pdWu3tTF
         Kg9w==
X-Forwarded-Encrypted: i=1; AKwUvByZ/yU7txGl6GfG7jdr9LXF9UMWQu5gLb+yetzqw4Z/g75//+t1x2SsGEsz8SGA5WDSJ5hhBAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC1eTwDmniOxpsXYigQ7AqJDYuSGL64Thyjk+4mY5JfcgtLbjQ
	a5pwf5T0fcKoRswzW7cagmnX721oE1WjXkeRu6lZU416P2VPtqpHMS4wFeulhwztOWDfzok02e6
	b4K3hB0neZ8C7HMIJ9JayyivKktmhNJ9W8uFCHghjbqtO6AKenG8gXBwiAy4=
X-Gm-Gg: AYBFou31HJbm499GXWqSW3/iI6xdC1Be6ytKR9C88wYCZOm9PI49rqkvgUgh8TPbQnr
	9kYOdtH+S9LzNa1isPBOIJHFLzF6Vfk7SH7bej6ZQtXpkwYpABrBcc8wMCt2UWlQmKwIIILhlrE
	DpadCHcanmAgNqTbLhGb5zOhAbr/RaW/HsXu+QQI1i5NbFIRipO9o8U/QPRM1ZwzuVyJG8sZ6oQ
	70kIASycAH9LNHlqyRKzdF3U3vh7JHikqVeHCzVbzdE150SQrrRaeMh+bup0ManKgflsF3YOXh/
	nY5AO48OlG3ssYocHj5S6MZC067r7YCDOYyiADMcSFV3kr9j0QxXswtzutBkzKKSGexig+jgza2
	u0MGReHd8xfZI
X-Received: by 2002:a05:7300:2406:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-361a254da08mr4629954eec.32.1792255167310;
        Sat, 17 Oct 2026 09:39:27 -0700 (PDT)
X-Received: by 2002:a05:7300:2406:b0:360:5f7e:2eb9 with SMTP id 5a478bee46e88-361a254da08mr4629905eec.32.1792255166648;
        Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm17691508eec.7.2026.10.17.09.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:09:10 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Radu Rendec <radu@rendec.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v16 4/7] net: stmmac: qcom-ethqos: update
 phy_mode to the resolved interface in mac_finish()
Message-ID: <atOkrubiz/V7aFiu@oss.qualcomm.com>
References: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
 <20261014-qcom-sa8255p-emac-v16-4-0266c2ead980@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-qcom-sa8255p-emac-v16-4-0266c2ead980@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfX6u53c+yZIRod
 BuLVWg0DoTyNEskMi9Yym1UtzLK4CE4XkJ1ke0zK0XSBuds8SRvwhLe5BsUCpIz7AR2vGuGfjMS
 BUYhyDJ+LSG+n9o57xMVTLIDMsCPv6Q=
X-Authority-Analysis: v=2.4 cv=FayiV5+6 c=1 sm=1 tr=0 ts=6ad3a4c0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=K33ZUWoUxhUzfzW7EYwA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfX9gtYSjyE21/c
 d79OGG8ruOXsVkgSokfj79k5WIfdFVEP/eX114F0CW3HlYye0qBAB8vT9P4hcWojbRKao3p6kss
 YGxmv5By0nxml8evk0kYsbr7kdBaFBj4S4jzAw9qdpybbk/FAoryM6pzWu6x9rxcuxN06MwyycE
 s+teUB+m+RR+VwOejLWQbY+/v16VU1INpUJZcpY2rUW8SDSmnfpeLkWrHgWQsECxpVSh/GfPSc/
 K3sJG1/1N76ZhkKwsmNV2kCzFq9CZFbKyawkqVtqvhCv+vZTEPLFfoLgUdNvUqYjp1YaVmT4Vx1
 VuY5GObtE6XIPucl4Wrvo/MwnwgXJy2XSs9uhWMyUYupV8AJZ4PylO+t7agidPog5h553tyyXen
 hlZjNkB7iTpQAlF5GltKbItEvQ1QfrAeE+z4gEm2LBbVMAtuIgCLlB6vjQw9AEV5I4pdxzHPxCx
 W0QEgoWhirOAEz+TQpQ==
X-Proofpoint-ORIG-GUID: QEJhlvkFZGhPMVxXM_LzR7nwdyqQpC3s
X-Proofpoint-GUID: QEJhlvkFZGhPMVxXM_LzR7nwdyqQpC3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170066

On Wed, Oct 14, 2026 at 02:36:43PM +0200, Bartosz Golaszewski wrote:
> ethqos->phy_mode is read by serdes_powerup() and
> qcom_ethqos_set_sgmii_loopback() to configure the SerDes and its
> wrapper for the correct interface. It is set once at probe from the DT
> phy-mode property and never updated.
> 
> phylink resolves the actual runtime interface and passes it to the
> mac_finish() callback. On platforms that only ever operate at one speed
> these two values are always the same, but when the interface changes
> at runtime - for example switching between SGMII and 2500BASE-X - the
> stored value becomes stale. The next serdes_powerup() call, on
> a subsequent link cycle, then reinitializes the SerDes to the wrong mode.
> 
> Update ethqos->phy_mode from the interface argument in
> ethqos_mac_finish_serdes() so that it always reflects the last
> resolved interface.
> 
> With that, we now update the phy_mode to the runtime-resolved interface,
> so any subsequent resume with a 1G SGMII link skips the loopback setup
> and the DMA reset hangs. To remedy this, extend the guard to include
> PHY_INTERFACE_MODE_SGMII.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

I am not sure but should this have a Fixes: tag?

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

