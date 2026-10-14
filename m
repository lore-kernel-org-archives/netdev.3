Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04744BD36E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981428; cv=none; b=jKHyhJ7BPORPDjjnKi7sEzrC8er9s/HYHvqkxJU1eR4hjFzri3fUzGa/CJghHVZ2GFg4fIX75J/4mbdThq4MDnWjn5/J6XIuQ0y7Vo2pqCqVS3z3/fhKHgNEcYknFGkOGq8WvuwNloB8l/hGQFx6kcOaO2q2BNzbz8c1tY7q/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981428; c=relaxed/simple;
	bh=3JI92fChNel+xLl9nSTOo1s0KJ3h4nXbqoiyZakFteo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ViN6QnALJlWXIUO+cJ6tIOgBqRQ+PcTIDzuiEWlff82okOrCfTubXMQ3zch5FOnVRPJ1tQOvfkTPfjgg7PGQGygc1hkO4/T0XZa2rsswZmG/2Gdkn80nXKqZvEXDlamgYw5Pf3k57l8Lb9S83T9PKrYXFlnnnTJPhrRlh75ottE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oEaAZpzQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QiJycpD0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEaAZpzQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QiJycpD0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8oUjg3000901
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EVpFNB3CilehugVbDMWv6b
	Xoo9vCpK+FUU09DpaShRU=; b=oEaAZpzQnRbW6odHN3Vc0Ke0cjE66Hax9LD3Qd
	77MOTgT2nx+LnmVlaDJNhBJLk27an0caCqtbIi1+j33OpqUoKTX5lYgkyDUJi8zb
	QvRpqwR197fXX30KKofHac1+bP4u/Ki1gMHSHOjIr+Lnj7JZsN8U43WHkgNFCIze
	WO1jSCbCQ+eWwP6X0uqohJlLMagM3itjEpyfgnZ8CrygJEh2vBQBIMrLO+ChmgoW
	K807Zdtd1Vfm+dvHodUlUUAO+Fo7xRk/8E6OiN8cfqfvl+CoqFl0FKhgCQMf7bH7
	qry7cn3jG9NxoHZscZjQ7pEclEu2AqhAp0ZFSKn4twS+AhiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeux9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so789349585a.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791981425; x=1792586225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EVpFNB3CilehugVbDMWv6bXoo9vCpK+FUU09DpaShRU=;
        b=QiJycpD0W3mLmn5iAr3CfGdwvnH4E9TlfGi6KgV8tgl/A2FsAs0pkHPlNwfK9XlicI
         iHF8j51Wwr26cMCYCqeMyB+eVSTaB24O/QmsJONIMXWl1RTL2+hSTqCuQJNqtqfLU3tV
         LfOasm03MlxW8VC0FK4oaqqtpJFVXvVCSou5DMKVUx2teTbEvOC40LssP3jjG/poAcv0
         WLZ6dX9UlGKfzU8LBaOi5sBnj9mheBuJjYOjCwvVRqfZpp/7+nfb9Q7YUAlFwJpX+/kn
         zKFTNxLespu2EXsTfwyqpbdA04ZDui01LOz7Jp7yaABNTX6rpm2VcdtUqV2UeYdFGtXp
         mW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981425; x=1792586225;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EVpFNB3CilehugVbDMWv6bXoo9vCpK+FUU09DpaShRU=;
        b=ngpAHDDG6MTGHyYzdCj3YIDoNxVmZFu3F0Sg/VzXNFvD7vD6lTqB2kaQoUqTp9ryA3
         N1jwXGgSpqIiJ8hzdDlnHxps9dABWHLElAXHP2Y4ojgKF6K7LCaruxr6HqViIyWG+nC3
         CR+bFqVDZAakgGNJEcRjQ1mTvoFj5+qGllhZpUa45pYvRFaklFJCJcyDoruZ4KdN51JL
         AgP2x81kKS77xmJbboCvo4LX160A8dcK7RzxisuU2X9aVcVe4xYgAbGkKTdfdb6PDa9J
         4mQqwpC5FTBPWiDnUCRAaKG8kg0pG2dH/ihrfp01dDtzIfbK63sD3y7ZJpv5J/NeQitk
         qaPQ==
X-Forwarded-Encrypted: i=1; AKwUvByw0CC6j5hWw+KlKh6n2hE+MT0GfWb4Ak/r5DIgKO1swY/EIiMPBMTgy+YmDYEixB6MZTldG8U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN3PR69/fsi11miRzFFdfoSE+fNyznsJRIzpF86/6sD0iyJTHC
	MTx03Wi+q4svmLnlKE12+gliGx2KSt2O8VA04qoIKVDIIFCNiKwk4846W4a7JZ2HPtkN0kyIb//
	7370v/PEat95OKS6GeLi9DiiX/VFATkz93sooGLtBp/4oVMxEx3NzDDGiA9k=
X-Gm-Gg: AYBFou0ahYmNYaNwjGjiGmm3fE0dMlhqVjL7P8Vgpr8eVEr4n1T3ielRcpfljb9brqt
	B/ZPq/YZVy9fdINr3VwLgnw3IGeXY9fIBAEEYitcphBzUjwyb4jmJl9kj6JS/Jt+xQRX+aeBsaH
	hoKDdsf/pZI+m49Wy9gIsDulAzkGw1i8qnS0mTpmDarqjwOAdL6DBjTLTQCaxoklZE9tx1WMfl7
	blCZtijMtAnlYAD8h4AsWs9l43HcDNmebQDF1OObZokIgrqhN9IUBjlzKoW5UZ5DnrvPN6/CTZw
	frcyPCwRZrZj1VKcbedhRjF97FBfvOcGnt69bv+NZWV1+Q/fdDT8bTJt129euWwTWj1Xr1ksCPu
	FJTt9BZq+Gv3e0FML3bU57pEzqQBJ
X-Received: by 2002:a05:620a:8389:b0:93b:d79a:c463 with SMTP id af79cd13be357-93ebd26b5e0mr2523457585a.59.1791981424750;
        Wed, 14 Oct 2026 05:37:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:93b:d79a:c463 with SMTP id af79cd13be357-93ebd26b5e0mr2523450185a.59.1791981424148;
        Wed, 14 Oct 2026 05:37:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm206122615e9.3.2026.10.14.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:37:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH net-next v16 0/7] net: stmmac: qcom-ethqos: add support for
 SCMI power domains
Date: Wed, 14 Oct 2026 14:36:39 +0200
Message-Id: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFd3z2oC/3XTy26cMBQA0F+JWJfRfdi+dlb5j6oLG+wEKQMJT
 FGqaP69BqkFaewNEhgO9/ndLHEe4tI8P303c1yHZZjGfIPmx1PTvfnxNbZDnx80BKRBQLWf3XR
 tF29J6482Xn3XWmWAWPtOIzX5u485puFrR382Y7y1Y/y6Nb/yyduw3Kb5z/63Fffz3XUIBXfFF
 lomL65LGI2xL+/D6OfpMs2vO7fyfwKBpERwJkSLkeCIwYcHQh0EFrNbVSaSGGMArHTRPxD6TBS
 j0JkA7Dmy94ntYyLmIAhdiTCZUFYSgiVlML5My3L5/O3f86vXS75slc+AAUSqAdZ47lUg31t+B
 PZI5F8kBhhMCZIM9RkCZHAqSAWyJwixBNkMaUskIfcX0FYgd4aKEbkMddo6VlFMSlSBEE4ScXH
 iYJsXx0CB2Ho0NQoPylCxYbhNLwZJwemgMbkaRQcl5YrnhkKbZydg7BI5wBrFJwrLCW4LgeiSN
 c7FZGONUgflwBapbTFiR0hBlHjpa5Q+UZWybwsSLSVmIRAuzdT9fv8LafKE/q4EAAA=
X-Change-ID: 20250704-qcom-sa8255p-emac-8460235ac512
To: Bjorn Andersson <andersson@kernel.org>,
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
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7865;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3JI92fChNel+xLl9nSTOo1s0KJ3h4nXbqoiyZakFteo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqz3dh44xUDWD4gypAZq0VHb6gBzU8G5BnVE4C1
 /e3UOQADJ+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas93YQAKCRAFnS7L/zaE
 w1rgD/416+tDKuxenpypb4rL9y/Y7Z5Ro6iQ7GKyeMUxd7+uqf03H+7frSbWAU+kLIVZZu+e/ip
 cRvtQj+uBEjl9AsaFzDX7RWqgYB2KEaPMsbjzzKqrQYrH2+u3QZpx5F65j5a2HzopoCIBYupQJt
 4Pyxg0m5tTq6PSNVvB/tRKk6zDvwjPZ4KYOWJAEbRrPT0GfjMDbi7lvRwO3VEObjxoaOaToq1F3
 V5lN9MfgUfYDC6pX/YQjX1SJkKRmxOz0SgUQSgoN43OBN+lOkQdzAUnnq9usDPAw6RQW2vwbXEM
 huGteMONpZmYMVL6qz9N1eU9jEe0YR3Cqn+3gcnzhiPtzP71wSPBGC5HV4ysmdh+PHBPF++VpmU
 Zt2ejLLjwgbHEKR95etuZXzVbxE/1kEzIca31WpjmE5d/k+yu87SVXtx2r51nITrCIdAjTZsTHt
 62dsa4AuNlmZwdZrqxIEgA7IOlCMTPB2Br50JxL3g/dmH2EjYojeG8GikqKPai2PZlVAUN5fESr
 L+z8y9d0yOjcbPuTvs3i7MUEMlQwOZCrrvl9HYPrQi34U3Zhas2dOuDHPMi5tAemeY3QZWJS7zs
 IkUWljHunYnwT2K1vMKSNQT9DE8eNscl2KdUZnQjQNrTvrS5LRRFTx6O3/2m8Ne01oUxca5Zin9
 yxencD94IX2Gsjg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: RO-1l-CgUEqqbvKOQH1p_W2G7p_CoyGB
X-Proofpoint-GUID: RO-1l-CgUEqqbvKOQH1p_W2G7p_CoyGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX857iNEg2mV9X
 w6uhc+qGXcSqzM0fBktzCIwQWqc+MWOsWgdPjg7rFcobRWX5fUk1b3pdzA7UQoDsO/KRwA2YRFO
 qARqAZfZH8fuVJcyI3SL9Ziq6vo4USiyY2gari/M5A6HT8qpljVfPyRfeANw7vhoVClpeKyYmab
 wfC9AV55b4WKhtkGI6SGjyFFxCxmIA3t42zaq1vqOypXCcm/sUbuM4TUVd1NYPLlfESO7DO1lDK
 uXEFW08Cs5sFR+Bm0dldPvt9e+xUFy6yvXrGQBh56+dL/OjH8v7w5hMbVj+wF4IKsY3yyuBoCPR
 Eq9YPTfzXgY8b4C2YEPbjg4LNvNlVqHWKqQEy/jhy4hTpZMhlL9ueRvyq+2WkZCirTJx4AeXGuc
 7fxXpmHHa6EJlfSBzBoPx+pBUdmzyGBbNBOW2SyhABh7TdnZid8cXG8j1bByUi9wfw+gxzQhsK/
 WtTuGtm5ghXAg9EQatg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX2Q6tF/SiiU3I
 694Jn9evpwmsUZvVnn0jgfsEwvLmIyjJMMLjqiqqR+T0twgUVCQestneuLLqPK+Ef6koAkotcDf
 Fcvi4iXUQib2WFhwQu5611L6MFYnhpk=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf7772 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=PHq6YzTAAAAA:8
 a=LD4EYYuP07UOpJRtIbAA:9 a=Wuut_rWLunZvJXiu:21 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140050

Add support for the firmware-managed variant of the DesignWare MAC on
the sa8255p platform. This series contains new DT bindings and driver
changes required to support the MAC in the STMMAC driver.

It also reorganizes the ethqos code quite a bit to make the introduction
of power domains into the driver a bit easier on the eye.

The DTS changes will go in separately.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v16:
- Split out the SerDes PHY patches into their own series
- only set the serdes mode for actual serdes PHY modes
- reject non-serdes PHY modes on SCMI variants
- extend some comments to unconfuse sashiko
- add a fix for an issue reported by sashiko where the tick counter would
  get reprogrammed even without the CSR clock
- Link to v15: https://patch.msgid.link/20260923-qcom-sa8255p-emac-v15-0-e82f33720737@oss.qualcomm.com

Changes in v15:
- Squash patches 6 and 7 to avoid a potential hang-on-resume regression
  (Sashiko)
- Fix the AUTONEG_DISABLE early return path in forced mode (Sashiko)
- Fix Kconfig dependencies on generic power domains (Sashiko)
- Set the performance level back to 0 on unbind in the PHY driver
  (Sashiko)
- Use devm_pm_runtime_enable() where applicable
- Link to v14: https://patch.msgid.link/20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com

Changes in v14:
- let genpd's own runtime suspend/resume callbacks own the perf state entirely
  by calling dev_pm_genpd_set_performance_state() in set_mode()
  unconditionally in the sgmii PHY driver
- drop usleep_range() from the PHY driver when setting the state as the level
  setting is already synchronous
- add missing power-domains limits for ma35d1/k3-dwmac
- fix ordering of clearing the sgmii loopback
- configure the wrapper clocks synchronously in scmi setup
- Link to v13: https://patch.msgid.link/20260713-qcom-sa8255p-emac-v13-0-119f8699ef8e@oss.qualcomm.com

Changes in v13:
- Reapply OPP on speed change in the PHY driver
- Use linux/device-id/of.h instead of mod_devicetable.h
- Fix the "invalid PTP clock rate" warning on sa8255p
- Add commits necessary to allow correct link speed change with SCMI
- Link to v12: https://patch.msgid.link/20260706-qcom-sa8255p-emac-v12-0-e3ab1ecf2901@oss.qualcomm.com

Changes in v12:
- Drop the power-domain-names from the SGMII PHY DT bindings
- Add missing Kconfig dependency on PM for the new SGMII PHY driver
- Link to v11: https://patch.msgid.link/20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com

Changes in v11:
- Take a new approach: add a dedicated driver for the firmware-managed
  SGMII PHY and simplify changes made to the MAC driver
- Link to v10: https://patch.msgid.link/20260323-qcom-sa8255p-emac-v10-0-79302b238a16@oss.qualcomm.com

Changes in v10:
- Fix unit address in DT example
- Link to v9: https://patch.msgid.link/20260316-qcom-sa8255p-emac-v9-0-c58934e76ff2@oss.qualcomm.com

Changes in v9:
- Rebase on top of current linux-next again
- Link to v8: https://patch.msgid.link/20260311-qcom-sa8255p-emac-v8-0-58227bcf1018@oss.qualcomm.com

Changes in v8:
- Rebase on top of recent changes in linux-next which required an
  extensive rework
- Drop partial R-b tags
- Link to v7: https://patch.msgid.link/20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com

Changes in v7:
- Restored the correct authorship after learning git uses .mailmap for
  the --author switch
- Rebased on top of changes from Russell
- Fixed resource management issues in error paths
- Link to v6: https://lore.kernel.org/r/20260112-qcom-sa8255p-emac-v6-0-86a3d4b2ad83@oss.qualcomm.com

Changes in v6:
- Fix $id value in the bindings
- Drop patch 3/8 from the series
- Update init/exit callback signatures
- Link to v5: https://lore.kernel.org/r/20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org
- Link to v6: https://lore.kernel.org/r/20251219-qcom-sa8255p-emac-v6-0-487f1082461e@oss.qualcomm.com

Changes in v5:
- Name the DT binding document after the new compatbile
- Add missing space
- Make the power-domains limits stricter
- Link to v4: https://lore.kernel.org/r/20251104-qcom-sa8255p-emac-v4-0-f76660087cea@linaro.org

Changes in v4:
- Remove the phys property from the SCMI bindings
- Mark the power-domain-names property as required
- Set maxItems for power-domains to 1 for all existing bindings to
  maintain the current requirements after modifying the value in the
  top-level document
- Link to v3: https://lore.kernel.org/r/20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org

Changes in v3:
- Drop 'power' and 'perf' prefixes from power domain names
- Rebase on top of Russell's changes to dwmac
- Rebase on top of even more changes from Russell that are not yet
  in next (E1vB6ld-0000000BIPy-2Qi4@rmk-PC.armlinux.org.uk)
- Link to v2: https://lore.kernel.org/all/20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org/

Changes in v2:
- Fix the power-domains property in DT bindings
- Rework the DT bindings example
- Drop the DTS patch, it will go upstream separately
- Link to v1: https://lore.kernel.org/r/20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org

---
Bartosz Golaszewski (7):
      net: stmmac: dwmac4: don't program the 1us tick counter without a CSR clock
      dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
      net: stmmac: qcom-ethqos: set serdes mode before powerup
      net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()
      net: stmmac: qcom-ethqos: reuse the address of ethqos_emac_driver_data
      net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
      net: stmmac: qcom-ethqos: add support for sa8255p

 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |   3 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |   3 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |   3 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   3 +
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   3 +
 .../bindings/net/loongson,ls1b-gmac.yaml           |   3 +
 .../bindings/net/loongson,ls1c-emac.yaml           |   3 +
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml         |   3 +
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   3 +
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.yaml |   3 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |   3 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   3 +
 .../bindings/net/qcom,sa8255p-ethqos.yaml          | 107 +++++++++
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |   3 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |   3 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   3 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +-
 .../bindings/net/sophgo,cv1800b-dwmac.yaml         |   3 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   3 +
 .../devicetree/bindings/net/spacemit,k3-dwmac.yaml |   3 +
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   3 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |   3 +
 .../devicetree/bindings/net/tesla,fsd-ethqos.yaml  |   3 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |   3 +
 .../bindings/net/toshiba,visconti-dwmac.yaml       |   3 +
 MAINTAINERS                                        |   1 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 265 +++++++++++++++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   9 +-
 28 files changed, 402 insertions(+), 54 deletions(-)
---
base-commit: 07d73541fde12a6c05f230509142a66e6c8751eb
change-id: 20250704-qcom-sa8255p-emac-8460235ac512

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

