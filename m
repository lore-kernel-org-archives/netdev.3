Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED04A7C9E
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002004; cv=none; b=mDAGxsOtcwQ/bJI7S9hjMfDSu3a1FflDFWQ2OfzaBoer+aqgzRNRvbrfWql60APgF4mhfVSE7liLSggHE/6qZIFOKk+fGf6FlGMuh1IZUhtuUA9oy4Uu2ctA4hJvnTi20RhJzN42o2O3M1aZ5ZHQkF9mmV+80z8kYzd0gqeRYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002004; c=relaxed/simple;
	bh=LWT8l+lPVhSRd0cdjeCypI3qOq4lZstO9fsRN+jSH4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oZH0hvLIW4ESy72P8SeDFFHD4PIMytsdmJrrNIR+nhGqLsE5JDR9b9a4Gsq2ji20N9GX6bLhqibHg413LUb+Cbbhm7xah+NWSLiyXL9K5KGxcG/dnG/XF/Mmapyv9rYo5F/KGbGyNtQlaoR3uRqf06wai680mvjWHiOLNMZZHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7yowuV1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DGdo8PdB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7yowuV1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DGdo8PdB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LEGooI764141
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uRhdawbhyQ6OC6sNBvfH76
	ZxrTZqGFlWNJLmdegdXbY=; b=i7yowuV13QLEFISq8zrHIeJvmMgErXwLvQBLle
	58rR6Ykg5dbX9j/eB+S2iRQwPejE9LYEmNehYEK975Z1UeT21B0t9iRcimksXzk2
	6M2PoG3oj0CXOzZRurZpN5qvYLhNUj/appGe7uQub+Vtz9YV6qOuPK972FBzEnhG
	QhPu9993l54Wf4fkCwo+eEF82hN9NnTXLuzFVBB3+LlHWPDKPA6dzBHD3sPuO5HO
	hNj7KcFhL+rtYRaE5LzoUu2sjzpxYVmg2UKkggul/BbC2i0hIwhIN80aktsJBliG
	QliGTdynLQMaqsG5hjTj/wRBUmY+Rl/8MMYK/H+6Sb9QujMw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj1n3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 14:46:40 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c8337b12d0so879803e0c.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790002000; x=1790606800; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uRhdawbhyQ6OC6sNBvfH76ZxrTZqGFlWNJLmdegdXbY=;
        b=DGdo8PdB+8KUHc7bR9rctnkzG7DPlAMa1VWTMF45wjqaR4/9fC2C+8ABIcLqsjK7At
         b5JsCKaDoNfbg8mTQpTjqTsgwt1cJgdFhnjXPuzy92EcYCzNU/smLTmenTZRKdP10mXj
         yZsJXAi/TP82zUMv3mCEJPobULVJU8D3oiy8ql3OhAic7KLFArNg/NY2jc3nUV70Lj9E
         T1NKvJBo2qwlvjyzUWF0DAhqpHt8qVE31pXwZE2d+ag0ENE/7SIZZbxOlS6y90oAH/LM
         iUatkcKx5fz7sMNBnAojEB8G+0piW+lEa853QbZm3muymvvrTK5r8eRmNi1EzsBSNMVO
         eaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002000; x=1790606800;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uRhdawbhyQ6OC6sNBvfH76ZxrTZqGFlWNJLmdegdXbY=;
        b=xekxPYtOhdjVlxv99FjX4/WNur7HpmafCeKegUI91TMmL7mcIQI22Fs5lxMZQ6gxyz
         3PXCpugRM5A4mwGfU+76eR9ImndtFyTgavrBJVGP6m/UlXYmwomoVihQpNAqtzfRKgBA
         hgOSBy+O1pgQR8TFszMXAWcTmsAZTfsLjQB9wdEd1HGsmk7SZDzs2vuLhVwswkLTPTi2
         gk9Ji2fYQqzXieipaekjoWJ9/pHMuBDe2iBJHrZiUWWzMa4xxHrJuyjgfpyTNqfwXfNw
         QBTUwSkTlvA+13Y2F4aZP3VkH6wXx9u3T8Te8cpAvbvkw1y2SPb9HqLVQ+S36f+cTsE6
         w+6A==
X-Gm-Message-State: AFuF++mwqnuwNrlC6iVYpgd+k10QZ1iww0nINvqLKaBYIIfW24oYm1c+
	7CoW09vpFRoRJr2jLMFmhrPVsTkdFI6PZIVgE8rU0/ahsw+7Sg586omw/ofDJ6o5H3yTj7q9Jh6
	yu8+14fWFCt0rpS553YfD3G46tZSwx/eXnd8qC5LHDWx9IlDIaQKt5B36o/s=
X-Gm-Gg: AYBFou2UcCdR0C3Pa1cwbscUzoNFAU77uuSK1eDnVgWdk2or1xZDwaRxBJTvt+RO6Ag
	onTiouMMJQSZmLxOyB0iVZ/1k8dXx471EErMUdFqPksgYDcegyXFRZnPe8SVMvyeKqa189uriDa
	ilM1Pjzasfhj0sF/eGYJHbY5xQ/jE+Y01siKPXabvh507Zr8dmaGUJlnWplnVyx+xyB9dC56db1
	JkP8cQEPykndaFNG32ZWWdQmtxAvkUMhfRDy/TACXHzV2JerUrpnbc7S5B0nY4oYyT96FbJT+Fh
	L7eAynOkMHO2bvC+/tEiTDlBamKtPcrGULUMPITcwx1z8+iH7P9vUrEOkFR1ZE26w/dn9uzRaCQ
	rEQKxaLPjrAko3Q==
X-Received: by 2002:a05:6123:12f:b0:5c7:ab80:2922 with SMTP id 71dfb90a1353d-5c9b591f65cmr4767627e0c.6.1790001999828;
        Mon, 21 Sep 2026 07:46:39 -0700 (PDT)
X-Received: by 2002:a05:6123:12f:b0:5c7:ab80:2922 with SMTP id 71dfb90a1353d-5c9b591f65cmr4767584e0c.6.1790001999250;
        Mon, 21 Sep 2026 07:46:39 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244608e7sm24733825f8f.6.2026.09.21.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:46:38 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:46:18 +0200
Subject: [PATCH net] net: stmmac: clear stale buf->page after recycling on
 skb build failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-stmmac-fix-napi-build-skb-error-v1-1-3d54bf6d9bb6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QqDMAwAf0XyvECtIKu/Ij6kNm5hWiVRGYj/v
 rLHg+PuAmMVNuiqC5RPMVlzgfpRwfim/GKUVBi8860Lvkbbl4VGnOSLmTbBeMic0D4RWXVVJOe
 p4WcTYgpQKptycf+HHjLvMNz3D4IexRF2AAAA
X-Change-ID: 20260921-stmmac-fix-napi-build-skb-error-a02a3e839bd9
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yanteng Si <si.yanteng@linux.dev>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Furong Xu <0x1207@gmail.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxNSBTYWx0ZWRfX0jd/4FtH20Zy
 cZlhdWpl2J6H7V2kaRLLg9zg0XitH0J+aKiTY/GUavBaT9hvcWJujxEZW9+mHWKS0NkkZZOBLap
 17dNBrbebqXyKOFL9QgpoY9kDOJw1Yw=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab14350 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VSNM358jKuvYd8pqHCUA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: xqJeCF0OCqV8EvX9zZ4JCb6f8vBf5tz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxNSBTYWx0ZWRfX7wjaIWgwhs5Y
 YHcSQSptYcuKESIG4JJGPHo/O52tjWkxrnkmQpMyQ0Fx/mupT0A4PvHhQFKCQPWf7hDkgI/9BZC
 h8958D+QJppD2SSvveJHt4yXhtIquzzoAT+nF/9vVyQDwFEJ+EpTo8VBbOmiuACjQZdLnHnFKyW
 MR30118VBdKBU8E+UfoVOM2pUQFjolA3JhFHZJ5gmklbbUPxhV3PafGCqs0rEnPEA1ruQGhgtIk
 StkQ+iPKSP5GXbj9wmmZQzwiwK8yuTyPKewbLO4xsF2ZpjqdLvLQZ0GWqbh9GxcuG8ccCXEabM7
 xc9SyN8YMAewO9lSkCeiwoEBMS4TSgXd3OyzvAfGVk4UsBvajb4ytJ2fogeKrrxeHXMVI59xnsd
 34L2PVH3iy0/YphTAEo/haiNJPqxHsP8YdDqu1hY8r6Wnla+HrZB1RCH/wPqaZgJYXjxbK6fhMp
 aiviazOifHrTdjGiS/A==
X-Proofpoint-ORIG-GUID: xqJeCF0OCqV8EvX9zZ4JCb6f8vBf5tz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210215

In stmmac_rx(), when napi_build_skb() fails the descriptor page is
recycled back to the page pool with page_pool_recycle_direct(), but
buf->page is left pointing at the recycled page, unlike every other
consumption site in the function which clears the pointer after handing
the page away.

With the stale pointer stmmac_rx_refill() skips the replacement
allocation and programs the already-recycled page back into the RX
descriptor.

Clear buf->page on the napi_build_skb() failure path to keep the buffer
lifecycle consistent with the other consumption sites.

Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f804ea23..11035b7d944e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5887,6 +5887,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			if (!skb) {
 				page_pool_recycle_direct(rx_q->page_pool,
 							 buf->page);
+				buf->page = NULL;
 				rx_dropped++;
 				count++;
 				goto drain_data;

---
base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
change-id: 20260921-stmmac-fix-napi-build-skb-error-a02a3e839bd9

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

