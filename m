Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EF50AC38
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665043; cv=none; b=c0MPx0VswAGZfg1CQWVKox3VDFI5cKxyQZwYN9BHnysW/0fSdszB/Ui7PydSeiyCXUPaIBJtSPuUJzGzaVCUUQOqOTtOU1ZcTwe4Yt+kk6InqmNgOyws4t4bi+UUAEyBVG81+32qMnsRane+vi61Bhbx+QEZ/B2KJPZASBhDCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665043; c=relaxed/simple;
	bh=dIYPq5sFKIxLtUGNP/CZRmD+OSboHKnYdjiQqfxygwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaJ/97esIRYFt3hUMh1YnBjgI4vEprbifYcTlupblfj7OrN8FIiJo578TNnUtc6dLoGqDHTPR5LHxMejqQTYLkgrW8A0ry/nq+FsqOIX4ejvcdC9jzfLxie4Udr+90NNUyHj74pgW+esq/E3HoAYtVSKaqBRjweHbE46+dOU1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADMf4+X0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DIJJI/bQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADMf4+X0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIJJI/bQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5LSn1007382
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UOIfBhA40d1n8PGVV7JnUyBrJvf/oegeKL4mbK8Sj08=; b=ADMf4+X0VvIg4+cY
	qhFgvhbSF2+YOJgeDEkgfW/y63HwFyW4u4joRNohoaYUKHcjP56NMONMo9PKl/Dn
	btkNJjvOGRR2bIz+jYyJJerhy5I11WW39CxkcAzs5RRsrRWUS95QNE5BqJidIgEA
	vZIou+/eNHJT5XqVWIETRD4oAbGGwIZRUSLTRRhm3zJP6dJQXQclNGxW8Np3stCI
	Z8a34uWaEhytiLJZdqAOxjbBv2OlcXEf1xUTkn5eFYeS0f5Tdb9fwcVLJ5kl4s2+
	M6KBOvQpjwm0buH2Gu6ogijiIy4swqB5cUwJtmigVVBJnzTA/vVXdrL1pYm5Gd4f
	EBkeNg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjttrgrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:10:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so1872450a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789665040; x=1790269840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOIfBhA40d1n8PGVV7JnUyBrJvf/oegeKL4mbK8Sj08=;
        b=DIJJI/bQN481uSuoyKlVig2qT5cSU/fJb8y1ZpYRxjbXnb+MV/QJWzIRxNCrgGPHGn
         M4H83T3EUDJMUpIm1cZj7NXCViYPbgAluNodXV72hTjb5m04kzeEGf9KPK4tJvDh4uK9
         3z3rIgFMT+NWFBpJvD0I+8oc4GOYbF0ud0Vx+v3QYKUGDFwy9NJPcYOhUDKxu4J8zfrF
         ShnQ+H+RBiL144sfauKGFOpqvtm6HAFWDT5iLSDqo/xq67aF0jktQsBZxT8F9HH/2729
         ejrm/ZWSy7FSV+r5EQdBs4HAY6TBe6Tq04kyQCUc9yQ6mW/YK7hJ/zXusS5Numtkv28L
         cN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665040; x=1790269840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UOIfBhA40d1n8PGVV7JnUyBrJvf/oegeKL4mbK8Sj08=;
        b=X97vC11oTxzgwAFOQrYMr6augD9XAOuaRj4qOUbLY7Iux5VA+JBD37SGgydl32Snhm
         sjSa62oYeyyedWvVxuEt70z0rsu8WvF9GABCl3WF+DBpueI1N2oXfrAutvJlWFjfxSil
         A2Cj/UvxsdyfzOYtDJ/QVYzpKYYaACZSUOwfYzI6qht/QN0M0AIiFyzlWF/WrKx/gYxO
         NFIET8Nt7IhQug2PG1YRXscyRtJsVgqZxQ129X92GsxmlqDimAHcvVubJmd9Yq6BR1Av
         /jhzIvM3xRMumNQYRj6n5RM56aitDfmoWfTcKmylEwHVRTXsJj0FIEp8hOFdlDir1X/o
         fA2A==
X-Forwarded-Encrypted: i=1; AKwUvBzfhctmftYUmVL8+UIRkst20mnp2pa1QMS+5SHxYzDgtpwZVHuai1hek+hg5UR5/TdJcTN5Vjw=@vger.kernel.org
X-Gm-Message-State: AFuF++mjPF9k8oLWBWWgGp05Cv46fPPp3gWn01YONW3eENkbYQIZV1+v
	epiz76kRu+hdell4STQd/hty/6Cw2rqhLe58DO4SqBGSmEwsDNLlXyMPqKACEzjdD34VvKXr9Y2
	C37/EeOGnwqkhfsB4+DEXXsh8gTt/EFvzQX0gqBpE/KUw7w9h+BlhK51yyC8=
X-Gm-Gg: AYBFou111bDbzSsjtkZYhlunyW58bgumg4oAFDR3WU6orLThI3EaILa/t00eUjjq5Nn
	qE2p/iwYPfe1nErpLA5aIYnFoO54I56xCcsJ6/3GlBkhdHIMgkMo+Cvs8XMpqjWxKqQ9+uh56VW
	gP5rpG7sso5PXg8tSHRe5L2s9btGJbfJ7oeq87nT2JU4ed3pJA2LEH2U0axBfaajzvfCph/v/hx
	kmeu9t8ZI1j189diuWDrHPn88Ok8eqRr9IYDmdpAY15RbawFt+ptfDu/MDdnhggBGUNnzdu0Nx9
	word0tt74h0q9Nnfexo3DMgqFDtDehYeLN03HP3pVUqA3KAsyHdh5de5tdIu+oep/9iYadLRND2
	530U4lnWbz347
X-Received: by 2002:a17:90b:4f81:b0:39d:febe:7460 with SMTP id 98e67ed59e1d1-39e1e4e354cmr15686544a91.22.1789665039953;
        Thu, 17 Sep 2026 10:10:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:39d:febe:7460 with SMTP id 98e67ed59e1d1-39e1e4e354cmr15686474a91.22.1789665039322;
        Thu, 17 Sep 2026 10:10:39 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35df479fsm6065347a91.6.2026.09.17.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:10:38 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:40:29 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, richardcochran@gmail.com,
        andersson@kernel.org, konradybcio@kernel.org,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        joabreu@synopsys.com, maxime.chevallier@bootlin.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/9] net: stmmac: qcom-ethqos: warn about
 legacy RGMII PHY modes
Message-ID: <aqwfBZmJehXB8d8U@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-6-bbe3389d0652@oss.qualcomm.com>
 <178912591683.219967.17377991068527504766@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178912591683.219967.17377991068527504766@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0NSBTYWx0ZWRfX44ZL398R5Vta
 XCFsdQjpafOnEkd0OCo5a+J/i5N174DkjX1pwM55t6CVPFg+9wJLbQcauv2mhsdvYT6YhFP8RGd
 3rRM2cdraqF8EsvxpPKBep87o6lWhjdx7lfD7A3aF8BEDdjQBifzn77ilrKCDhkQidY6wdRWhUT
 vV2LIXIqgYqwo/a/v4YnrniHEOPj7zxBjcU+5+ug8P1PsJL+vtErRFFQQgbDnCGc0MWdtRcBSw7
 OsSn1PZK2yep8JEDORUQe+PHqleUNFSPYFyb3lcBzfFX0jiP1QhQLQwjoI521KdemISZHrmKcle
 o3fGaVR1GWf57k+ZVkGuosXOmFBy7wjJPONVE6aYUHC9HC6FfQxXBME+biTRGxg0isBrZMGkpBF
 wemKhMt0Q3ECEwxhBdvuWqEYddihldWFlUXgWUPyfgeSNrS3qnBBSIeJxyBKTb6mElEpXhNGnTM
 lQNppv6/KgVp15X1BEg==
X-Proofpoint-ORIG-GUID: leFZ2GfUKtl6hWEpdYNHTb79avv6zywq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0NSBTYWx0ZWRfX2XzOYjnumODI
 Ew52La/oDvuAyfdZtcb0TLq+C+k32QtZZ6rcDNYlMiskUrDJUs/V4KZLlxzebNqSdV8r9mPbURl
 TmLpf/MUvtrn2ea05zU9jcEZwCXqves=
X-Authority-Analysis: v=2.4 cv=IP2XmQvG c=1 sm=1 tr=0 ts=6aac1f10 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=bzSRg-MVb8Bu9kwduOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: leFZ2GfUKtl6hWEpdYNHTb79avv6zywq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170245

On Fri, Sep 11, 2026 at 11:25:16AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> - [Medium] Unactionable boot-time warning on every in-tree qcom ethqos
>   platform: the new dev_warn() in qcom_ethqos_probe() (dwmac-qcom-…
> - [Low] Commit message / code mismatch: the changelog of "net: stmmac:
>   qcom-ethqos: warn about legacy RGMII PHY modes" states that "existing…
> 
> --
> 
> net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes
> 
> This adds a probe-time dev_warn() in qcom_ethqos_probe() when the ethernet
> node uses one of the older RGMII phy-mode values, suggesting a move to
> "rgmii-id" with PHY-provided delays.  PHY_INTERFACE_MODE_RGMII_ID is split
> out of the shared case group so that it does not warn.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 53fb9de4d92c7..a92bf4a6a2dbd 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -764,9 +764,11 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
> >  	ethqos->phy_mode = plat_dat->phy_interface;
> >  	switch (ethqos->phy_mode) {
> >  	case PHY_INTERFACE_MODE_RGMII:
> > -	case PHY_INTERFACE_MODE_RGMII_ID:
> >  	case PHY_INTERFACE_MODE_RGMII_RXID:
> >  	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +		dev_warn(dev, "legacy RGMII phy-mode detected; consider upgrading to a newer DTB\n");
> 
> [Severity: Low]
> The changelog says:
> 
>     However, existing DTBs use "rgmii" and "rgmii-txid" and must remain
>     supported for backwards compatibility.
> 
>     Warn when either of these legacy PHY modes is used [...]
> 
> but the warning in qcom_ethqos_probe() is attached to a group of three case
> labels, so PHY_INTERFACE_MODE_RGMII_RXID also warns.
> 
> Is "rgmii-rxid" intended to be declared legacy as well?  The driver does
> treat these modes differently, for example in ethqos_rgmii_macro_init():
> 
> 	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> 		phase_shift = 0;
> 	else
> 		phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;
> 
> so which phy-modes are being deprecated seems worth stating exactly in the
> commit message.

I will make this clearer in v3 that all non RGMII-ID modes are being
deprecated.

> 
> [Severity: Medium]
> Is there an upstream DTB that this warning can point people at?  No in-tree
> device tree for this driver uses "rgmii-id", and this series does not touch
> arch/ at all, so every in-tree board hits the new warning on each probe:
> 
>   arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts	phy-mode = "rgmii";
>   arch/arm64/boot/dts/qcom/sa8155p-adp.dts	phy-mode = "rgmii";
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts	phy-mode = "rgmii-txid";  (both MACs)
> 
> The binding example in Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> also still uses:
> 
>       phy-mode = "rgmii";
> 
> and the binding carries no phy-mode deprecation note, so the documented ABI
> still recommends what the driver now calls legacy.
> 
> Converting those device trees is also the only way the advocated
> PHY-provided-delay path gets exercised, since ethqos_set_clk_tx_rate() stops
> doubling the link clock only for PHY_INTERFACE_MODE_RGMII_ID.  Would it make
> sense to convert the in-tree DTs (and the binding example/text) in the same
> series, or to hold off on the warning until a migration target exists?
> 
> > +		fallthrough;
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> >  		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;
> >  		break;
> >  	case PHY_INTERFACE_MODE_2500BASEX:
> 

The plan is to convert the current DTs to use "rgmii-id" after this
patch series.

	Ayaan
