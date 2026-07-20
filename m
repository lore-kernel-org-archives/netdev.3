Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF803D6498
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539557; cv=none; b=c6Xs1EgC2RgE18Y7yN7j5yzACEcybEVuXVM3XrqyFTgEcF85nZ3oqq4RwJlZVjiaRIUvE29dc0e+1hxdfS+oyIYKe34mj8gw4sR/3w5c3mpEsH4AbrPAoiLI/PU65bXiH4tjOGnyh50tydOO4X30uML9Im2FB5JNpfYbmsJkU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539557; c=relaxed/simple;
	bh=xqsPX1hXJ5p8S4DkE8vtCmD8bNryEUzUedAtz3x4vb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6qiMTlLxb7Z65ArD5DvV8zeMWHbHtGgkuijUEorZgZX1ibHROFvjWqL93L6jYRGnRqTdpFD81HTTKXvs2dKeIXNyHu9XnjjbhILRRtRHYyJDoH3K9J6eJvWfi8MNWsanpP8gvd29MAd2DnOkd/DrIA/bXrddn1S8FZqIE0q+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KlqIfYj2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPxGIhmz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KlqIfYj2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPxGIhmz"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7reG82979868
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=; b=KlqIfYj24yaFf79w
	7Rebwfq6wOB8LJIJfcOSwVzj8iaykOD+BlPcDZSb0cBdWQ/OJ8g/3RUKCH8I84dF
	bTklcwnNbIC8LgFDvh2Zd41sQa4Z4qY1zfhH5zztNgAHUzbG2j33ECwyTCj4sYeg
	2LdXdFfBk8SiLKdVSnwAmEnDPSHtSk4ZVYbojPcQcNWXIcZypczqSyWi9G+LaMkX
	aZkg1tjB1QO21JwFUq0BmbAHIvd8q/a4xCzpwESVMJTdxYAw7vYZo0Rqn+oMRnt6
	2a0leS5KgupFo3792wHUl9yNhKjib47ri1ajCPMMrb4qrUNfn4M+W+Y9eJkYXbyl
	lfcfHQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0er7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:25:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0e702df8so139484841cf.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539549; x=1785144349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=RPxGIhmzKguQNdJw187nXUU2NTpp+odZ09EgZrTO5RhqF7P4Bnxx/fDwbu2SIpB9QW
         PGC2u32b4XdBw4MA+q8lLNn0bZv+q7thDJzpDjFWXt9ARFoeojoR7AA1/6t4kdTNzB8J
         Y0QgXDpfY6dRaDcw+rTiZ1y6y8PbO0uAgbk/Z4/TZxhNzUT5SoM9bEYrmK3CphEiMo9U
         NYRiFHlZz5sJG2dabkmWIG7IAgoH/Xe4wZjwRE6y3lWhMbTjPivTo2CM1Fd1uiWdEVYx
         uMiAkbgXcn9tABllZJ9Upd31GKurHR8AKTKPpXrnMaFBIu9dazjj71IX9ImTeHc/5GoU
         M8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539549; x=1785144349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C15lnSQu9nB/PyhjrNzGtTe7xWsSDZpgOoprGffw2I=;
        b=DdcQA2bYBa9Wb22JU1AleRjfxXwH2eMdq6CZWL0qFmGFZjqlSx1U/MqGo01oXejHPh
         Z+R7WPUYssZm1rvHEgGPcFYhNOl1C2c3mjXaev//+CkuKrWcNjHwaC9JTgGLV8REGXYQ
         yaKXqVMuWrNUwGIfJuUwSrLgtJnQ5Jc4hUDExGtCoH6T4si5YufKlOg9Evm//k0S8OMl
         l4BamvYdZOc/dbVHNdOpJVc8QmQE06WB4M+g0TpG3z5WdouJAY9ivKQEkEqKncEvWWH6
         ZC5+PRFY6SKsgwh0Ud5GrqF2NYAy1K7Yv6byUfEhkGP6DR3CErRlaIILTq4ss4+dW/gU
         SL0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrWVdYxw6ba3prAWH/G8rFuq/T12fnRxvjuOUN3URbcJmATfNnZ1z4y2x19opFacz2W0G5MQmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nRire6s/uJMmmiFerPJmvygHUf1pp/GGCXCziF85tyu9ab6G
	yW08woisX9UQaphXwNyqGRNjBBjbH4L3gqU6Z0r/7NY3NNG32l/cVm/nnpsLM8rIYONwZWM1jL7
	Lbgcniy5BZVIWsc8/jBXj+naNDmMCJKIHmvSgsYEeyUPAIpxSrdvSAlYIGC4=
X-Gm-Gg: AfdE7cmGwk1TN5HFO9Q/PLQWNv1VBbSTnX4GWNfPTYim8Nu6fFjWRPRrE90inLlfPGu
	4peBve2OsUMFpJCtZwiOOi5bW2Nzo9AnRavJJYXjNaIkCVhngIVu2RlAYixEYsoc0zDPVoFJbrs
	j/IklgQyFUTBcxMPQR3Q7cbVD1Nk2JHuJWapS1SQQuEt8OF1kibgn5WzalCE30vZdDqjMeQPeHt
	Fr/SaAdCe5SLY+Z8W8K7GVOkDxzASfG2xJCn4MLgEXY6ZcEPIw1nnn4w6fADo7hzgCj0Wn9VcPV
	1W1YRqyau4YYSubENVfSncCy0K+r8A+zzH2BKKSpWfxwLfr4w1oNu5LDBrVgfb2n4tG9x7uucOp
	NCirJsRwQ57sHYNVJWSrI6Yqs23xgfA==
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276741cf.59.1784539549621;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:22c5:daf8 with SMTP id d75a77b69052e-5213e886569mr118276431cf.59.1784539549156;
        Mon, 20 Jul 2026 02:25:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:54 +0200
Subject: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=995;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xqsPX1hXJ5p8S4DkE8vtCmD8bNryEUzUedAtz3x4vb8=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGpd6X+h/ifYFhQyBjNRAMZp3sKfs2dOQQAGWOSJWeEWTFT5/
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJqXel/AAoJEAWdLsv/NoTDaPwP/RCK
 7Pwxf8vZOh5uaFiaUylNW9sFBv0DTkc12XbVDBYvSH/UfZrhZNMpdObQiVZ0SMsBjpcFYp/1AZB
 bv/F5eIASG2zBoN057E5VLLCsx82l6r/JbeVQgw5sCPYBDfaFMn5uPaQXGHdfCtVzj107jr0atg
 MpQOTuIilyBFr3uTKuOU7pU31UrvyYd/WaJ9iIF6yscrWH/v4Qs1NgyuD5SXNzXQy3CdXMuZWPw
 OfBtGBf6WPhpJYK8SJ8cxHXNTC3mp02VZHt8QJoXG+UcIywc7z9x2aIXBI2wqX000BykBPNlSWC
 mY3n3CcQ2YJPZstI6l/D5a5Ag1tvZyjFn23kZX27b2b+0vfEWAo3XxJs4LD96b8ru1CihZM4DNr
 J7ePsCpJxshz8tCUh/g8vlubXLhRCQuMOCve6JfkiVWeFuCbbrtw/uB+qI4BX6ItSyElc3Pkd9A
 zqucZ40Ol3KJyC0Hpqxv0yAHDnt73BHlxnotHkeJUkco+UU572qEZp2P/tHBng23kf7VdgJKzfM
 0Vmj+kL6FAYBqwOZUqDULhVWTcaepaa6iM5W9ZkRvjLWWBLCdYGzVZKBmU+3X/B1u1vnRuKOPdc
 vNkkEAD4/hll03aBOJFx5J4KIfwjuuLHfYesAeoCPVMULek6L0iDo1ICKKxFU2N/ZGUpG50fB24
 46Qsg
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX08n/VPfYO4Gd
 yw9c4i+A1XBYdjROwZgQC+76Fe9kyhEmKef43/lRtdBCGp3JYSla4fkQhZRl3y93B5loITMsqhg
 YJVX4P0MiiCezK6O5miTaTiI83ftZkU=
X-Proofpoint-GUID: 2Bd9vq2GY2HuEmpZE6Cbd0RDYW5KSSp0
X-Proofpoint-ORIG-GUID: 2Bd9vq2GY2HuEmpZE6Cbd0RDYW5KSSp0
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de99e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Ue-CkOehRSWfgkZZKZIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX1z2rTkeSrcr0
 V92g8mVqK2qFx83tDKQzqCZIKfv1Udfhx6cLuIFG9KSDwNB1BSTFIuZSdrfgQF4nP8M5/yHaWBV
 Pp5xUdpT6skhQNiL4Pu28o0yweOLUF2mLbMXptBYNKUha14Wc5PRNmUYukTykvM1kNojJ+DOYG8
 yL+ljDcQ1Qaaj9DiADWA2BroNfD3dVo7NFs5HH0KO9+6tfdmIQT3lzUtA5o8rdDtMmbG6ACkYds
 GdHGr9gXfSs6dCxxeVIn28jKPeAARhgmRvT8SqIEWs9AE584+0mNhGwg1b0Je9LraYvmyZaM59k
 c0pWOwG99gam/3+Jx7J/p/VrrFxakRCxzWTk2bGLYOwe/3cdkhMdtQRCQvI0p8MhIk84m87CF8+
 w3pyHq0FxXe3nGEqzheV4hcIMHVbyfkx+OXxLWeN93dVAT7ssk7cXiblOhmwoJTeL1P9evI2Wyi
 wc1o+66xdsISNP/0BsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	platform_device_set_of_node(ppdev, pnp);
+	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

