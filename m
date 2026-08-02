Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023073.outbound.protection.outlook.com [40.93.196.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD90305670;
	Sun,  2 Aug 2026 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642448; cv=fail; b=gC6tBR4er0WdeuaQdTvpvLjFc3IsJusFgVxXnpLQLP3p3bgp69s1UlACjJLdNzHKu2qC4c5sBIjB1roAGLEyNh+tSp/tzEkKPzqn3TlnkA/Hm/NzKHyHBmKc3LE3yVHMDSf3XZ8NFeBAkQQvSOo35Fox8dz2KZBwlxuDocB1YWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642448; c=relaxed/simple;
	bh=JcymnhgRfc0lDCc2nd1fxMFXu0V+bB+fz8DVmGTEd84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNLdXtXO6A05sxyvLl2afMV0uZ4yR0qjzf1E6VeAzqrk7r+6qxYGbY/VqQeGMsye3h3b4DYXGcde62lXD1PbgfV9QavJgXr2Ls3Y7usOps8x2rhN3KnaA6POIB7PlLjaI/15fp60nspFQ/tXMfLIrWvL4jPpJpO5ICPfuJx1F/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=lCgadMvj; arc=fail smtp.client-ip=40.93.196.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="lCgadMvj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQX1s43yrH9mhHS3oVZ4fnS+D8+31NbB41fABrmz/pAo3yFUW+RcGAOAomlsu0TDzNWLOVnfJmtopQ4G7bE+Q4CnXrGDCSTdLukF7sHuhIcCyHAK3EcoIlRc8yIO0iZEoOLsslD8mm8j9QUs/P+9jwU2WX9VbNK2AorVzv1ssbDqqL8XjhvWn1gmGrL8MB6NAmVDwdV4SHT5Wqp6E8UrAvZTydza5ID9w71WNL0ZVvfNxI9yj8Q6ZyGHOdkgVTBhngWv/wAm98CbVBvFhgTKaVCFIWG5BErHlhkycD9BceZqQmj4b39lg4xgg83yGfb1ZJc+CaZruQbAgaYN05EQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFn8XVnsAoEyxoX/t05sPg5MwNM/NUJQxR80H0lbVdU=;
 b=M6a7wny6oxVOQnQXLKPzKOlwQseC9EekPKVKx3Z1nLMqJ7Fyy6ZjCsMosP5JkbTA3Tpcqc/NJ+D2okAgUE2JcjKi8HElPezXKe9jZcS6M0HFG361mUb4CN6ctlmRACZXhunxc8DDaut58ez1qy6te+xNFCurdu8CuX5aq+lhjms7ms+IxFXUhnLhiTcwYj8G5zw5zkJjLRswri3Pdzg0qtWXK6X/tlMkcmbbTAVAwMUi5ZPF54EROQBbHECGD4AK8AjfEy8MwX77yotwVah4p9e/f3DCEA615U9SrFgeoSfNOGM0aBNU1x2nRSfB5h1XgUIPcfPhXvC1jiqwDf3rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFn8XVnsAoEyxoX/t05sPg5MwNM/NUJQxR80H0lbVdU=;
 b=lCgadMvjWGaUs0GaQeLEPnQMVFk9wcbjekR7X+bp9UVvM6OyBAikfBal+PEUJ+1tGsO9gE+WgeVk3UFSdcgFKrU0k3oYaROQA+R3Jdj3IKj+MDDFP/+O2GI3uNK3ifPUToE8aBbGRZEEZM/b4+nXx7/Q7e5YQNOPMNNSfx97LdSqWL575tfl5cE+jM0crQc+w/Zm3vvaQ8QL89jrf5DYRoQi2BoXxaDDfICybLRMkA30g2JjIrfm+paPaCpCo4eRO4WBCypohkoq2B1Siw2QX1fBa20X43Ahodi1/sY0VENyTPoLcrlGh2r26U6g6RMF3HUXTGZMy553uLaVhLpcQQ==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:25 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:24 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 4/6] net: dsa: qca8k: use each user port's CPU
 conduit
Thread-Topic: [RFC PATCH net-next v2 4/6] net: dsa: qca8k: use each user
 port's CPU conduit
Thread-Index: AQHdIjGh3/75PVcuzEOR6x7xmbdV5Q==
Date: Sun, 2 Aug 2026 03:47:24 +0000
Message-ID: <20260802034701.3339052-5-brandon.mahdavi@mahcom.com>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
 <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
In-Reply-To: <20260802034701.3339052-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|SA1PR20MB4298:EE_
x-ms-office365-filtering-correlation-id: 3c4ce35b-882e-4bed-e8bc-08def048c3f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 clQr2d1Xmoz35FYU/aeVfZSCfXEaRyzQOi9JGchkg0qTNC3Xs1HR0ar9iqsK6D4JlBdfnJZKv4BaZSO7Ab/jtZrjAIxefV7IbgoYOD7MLN2Az2LwgmLGcaOLO8eBh6EFPOIflhiMPWi8Q6QAO0kbazpmfIcWKvKD0K5q4zkIoyr2NpT/8L7rdsqDEarRh0koz560R2JaEk3sj04oW7AKU8VTOSt9P1K4EjisxZ0Rb2fKq6Ar5hAjoircG7xtACowA44tC8tpt0on/fpaHC+01lsXGaB5amf6fm4a14MbJpurIygdn/PwLgyEwXESTxVIs3yKWPsl+Cb5nmNnc9g8clqiLEEG1GTwd876KqroDWTqrtx/9CFogmQUDZREL1HwVY4iq40yuULr2WDmZLheW5uiDb6DUcLb2yDrptwwEagVP2JgjwDP5fg99mFPySCV0y4SSn9BCYTj2xB/MmrBK9tQd2GsA8XuD9igl/YoBCcfcCHwsMUwKngVR264esDlmsjlqNvt0KWrzwyK0YFG41nV7dCvnVOOumCHkr+jKgpxtFsEuFsS3R7iNnFoReRGcev8/IG5iE+Q+skpEMp+DUjSIM/pU18nidx1MUfiABt1O3BJM+7j07dv4qiaz+ysVCAZNuVIqVKUyWl+aWG+TsjyAEhCypxiXXOJksifT/27+ZZ+en3xAVxEdMH1WMu5d9odE1z/CdZMqtyLZ6Yvc8UExZcZG1FMuJFciz4F9Ic=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hQamAVFcH7o9hzeeV1yu3N2JmHgYhIlIiAqVYw1tYTfMhz83xao1TJxvY1?=
 =?iso-8859-1?Q?R0AaX/w8MfEUdgIDBZ+SpbPXT6U4HFx4+QQUFRYDPlfLyoboVax3XIBTzB?=
 =?iso-8859-1?Q?9iPGRhlytT3wFks2I5tA0VdvqtdmBMRKlKCsTs7CZgxhE1k+faekp1Aiye?=
 =?iso-8859-1?Q?Odv/heK7VYKfD854n0MPT9YiHhB0OKwtlR+Bq3TiTYm4LQqUb64Hd7g/eS?=
 =?iso-8859-1?Q?Hg8tsht2YXq67sdF6avIGVIRww3K533WFwF7Kqe1ZnIGggqPzwCQeATPum?=
 =?iso-8859-1?Q?oCnrw4F62ZLB1+2sXW7EBYBEaC5VythD4IeEqacXWXYRvDGw2qKxxJ4FN7?=
 =?iso-8859-1?Q?wexAdOVPIWADD5tOHidgBkewT75cS6nOghgWvsOah4F+zZOJ8PsIcKp3tF?=
 =?iso-8859-1?Q?t96jPS6CttxMCInLFE3zLxeziq2sjXtGzywjPdEtRXVTDazM5yAnMTmiyi?=
 =?iso-8859-1?Q?Cvv7F9qXbQy9jOiFpfmRFbUXbNDoSPvA5z0rPatKvPzqG2OzFchhUmx+El?=
 =?iso-8859-1?Q?1vgm4bPW+6lB5v2S69J8teB6Gy4ri4LwZgKaqFnPWp7ptZFDZLmmsJJfrN?=
 =?iso-8859-1?Q?8Zo4ycnzJwzVXgpuAIWjHYfnSso0hWmn7c6sn55UYfzIBleHtbGljKrV1G?=
 =?iso-8859-1?Q?SvSKiSOZsIz4r8KuWnggwK9h5mLI9AAAgFQJ8WS/J5/V/Txnecdi6/ElZp?=
 =?iso-8859-1?Q?he+nLEWRhPV0OACrJx1mns2XwNPyPqw/a6zCLQekEfI1D6Lv+z74eok2jM?=
 =?iso-8859-1?Q?xQ21WNt2iVzedOtB8eoRNdxccMxXdaa7GQxLw/zKAZVNKhPfRiHUv23pJD?=
 =?iso-8859-1?Q?2uBPPFpLTcfLmMc/W5BvasFp8Xgpd1L14KCnUWiCnuEaxd2l+EMfvP5fJX?=
 =?iso-8859-1?Q?zJE/7I0SZiRshzgoT/EV/N8iIyP9J9qVJroRC3SGotoXqOnXHLjLE59z1L?=
 =?iso-8859-1?Q?YePjTPtabvA0rBAHOFC6i6SXA5Ak3hLIs1keOp8e0RW1p+2JHdhbNErdGb?=
 =?iso-8859-1?Q?7ABtyKYJCoSTfbDUvc76VZEMNPs2Rm8/9wTjwLKUzS1ZCH3HnqQD4K/9OI?=
 =?iso-8859-1?Q?xGZAgpAkBf+573Eon8/TMtdVR8MZCMaPJ386nNChZ5jl5eCTYPEERbKn1k?=
 =?iso-8859-1?Q?m9QYjObIIcSMTal6OC0oda3IuGReKlwVz6aK/RqGoPTUMZUmIppnlldh7v?=
 =?iso-8859-1?Q?Yh3Mr9PTg8Jf6wn1J8ItYhLVF6LGPQb/eDbEVYq/IhnPSYH6g/5RxfRLqu?=
 =?iso-8859-1?Q?yhj7WNxL7FUUjr/m5NbpvjNdqXSAZ1NNFehQgFJLShzAJj8/TBUr+hHeyz?=
 =?iso-8859-1?Q?vI1XIgTEuq0Qslt+8t7pF1CPhS4dTQF+P7KF+yGmx2zfpaWDsmePOvKvNK?=
 =?iso-8859-1?Q?8mfelQxNva/7v046xQTTz3endxIUwUkdH+27axR4nhkXN14LnlyaR+ScYL?=
 =?iso-8859-1?Q?NHZrYoCExsED/CWy2Ig0Sfm/tw8UzpMAdyw8WwlExwwuFNwSwZZj63wYFD?=
 =?iso-8859-1?Q?bTbcK1kO2CD+Tz1ZUf8QkypkYKS6WyxHl9e5b+HwatO8yXlGJHbhEfIyhk?=
 =?iso-8859-1?Q?ho5JPyd31n9XrkcOBJ9ZYYWdOj3SyjQLptEOw0z+GAyj9zZNq+Sae8Dzp/?=
 =?iso-8859-1?Q?QzHlJsSYsXN83KXzKerrLUGM9qgeYtalNcu2lYAkk2h9b8FBR4UQ1VAgnG?=
 =?iso-8859-1?Q?wcMV2nfoEuvAm63g5mcsV0dH1DwXaKyAXCS9qxHBI2lNZ+ssRr5kv81K/p?=
 =?iso-8859-1?Q?G2PonVu0yLYk3uP5n94TwlRkxl3f3Clx5+akcgWvs4r0FAPRif2cakF+GJ?=
 =?iso-8859-1?Q?7E1ShNP7mg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ce35b-882e-4bed-e8bc-08def048c3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:24.9339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMoREl6ub576RPWujY+QANxtitaauAk//G0OH0PgpEUeyzt2n6TEEbde+I3tVn0LkyS0gANjEi2kTRhDqBxXoDyg1tG/kF0aCDzjgjrsrAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

From: Ziyang Huang <hzyitc@outlook.com>=0A=
=0A=
QCA8K can use ports 0 and 6 as CPU ports, but the setup path=0A=
selects only one of them. This leaves the hardware topology out of=0A=
sync with the per-user-port CPU assignment already made by DSA.=0A=
=0A=
Remove the separate CPU-port selection and validate that every CPU=0A=
port is supported by the hardware. For each user port, program only=0A=
its assigned CPU port into lookup membership and add the reciprocal=0A=
membership on that CPU port.=0A=
=0A=
Together with flooding unknown traffic to every CPU port, ingress=0A=
lookup membership limits delivery to the correct conduit and avoids=0A=
duplicate frames.=0A=
=0A=
Link: https://github.com/openwrt/openwrt/pull/21496=0A=
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c | 56 ++++++++++++--------------------=0A=
 1 file changed, 20 insertions(+), 36 deletions(-)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8=
xxx.c=0A=
index 4adc5081d05d..9eae921ad716 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
@@ -1087,22 +1087,6 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
-static int qca8k_find_cpu_port(struct dsa_switch *ds)=0A=
-{=0A=
-	struct qca8k_priv *priv =3D ds->priv;=0A=
-=0A=
-	/* Find the connected cpu port. Valid port are 0 or 6 */=0A=
-	if (dsa_is_cpu_port(ds, 0))=0A=
-		return 0;=0A=
-=0A=
-	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");=0A=
-=0A=
-	if (dsa_is_cpu_port(ds, 6))=0A=
-		return 6;=0A=
-=0A=
-	return -EINVAL;=0A=
-}=0A=
-=0A=
 static int=0A=
 qca8k_setup_of_pws_reg(struct qca8k_priv *priv)=0A=
 {=0A=
@@ -1844,13 +1828,13 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 {=0A=
 	struct qca8k_priv *priv =3D ds->priv;=0A=
 	struct dsa_port *dp;=0A=
-	int cpu_port, ret;=0A=
-	u32 mask;=0A=
+	u32 cpu_ports, mask;=0A=
+	int ret;=0A=
 =0A=
-	cpu_port =3D qca8k_find_cpu_port(ds);=0A=
-	if (cpu_port < 0) {=0A=
-		dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6")=
;=0A=
-		return cpu_port;=0A=
+	cpu_ports =3D dsa_cpu_ports(ds);=0A=
+	if (!cpu_ports || cpu_ports & ~(BIT(0) | BIT(6))) {=0A=
+		dev_err(priv->dev, "CPU ports must be port 0 or 6");=0A=
+		return -EINVAL;=0A=
 	}=0A=
 =0A=
 	/* Parse CPU port config to be later used in phy_link mac_config */=0A=
@@ -1922,25 +1906,20 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 		}=0A=
 	}=0A=
 =0A=
-	/* Forward all unknown frames to CPU port for Linux processing */=0A=
+	/* Forward unknown frames to every CPU port. The ingress port lookup=0A=
+	 * membership restricts each frame to its assigned CPU port.=0A=
+	 */=0A=
 	ret =3D qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, dsa_cpu_ports(ds)) |=
=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, dsa_cpu_ports(ds)) |=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, dsa_cpu_ports(ds)) |=0A=
-			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, dsa_cpu_ports(ds)));=0A=
-	if (ret)=0A=
-		return ret;=0A=
-=0A=
-	/* CPU port gets connected to all user ports of the switch */=0A=
-	ret =3D qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),=0A=
-			QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, cpu_ports) |=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, cpu_ports) |=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, cpu_ports) |=0A=
+			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, cpu_ports));=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	/* Setup connection between CPU port & user ports=0A=
-	 * Individual user ports get connected to CPU port only=0A=
-	 */=0A=
+	/* Connect each user port bidirectionally to its assigned CPU port. */=0A=
 	dsa_switch_for_each_user_port(dp, ds) {=0A=
+		u8 cpu_port =3D dp->cpu_dp->index;=0A=
 		u8 port =3D dp->index;=0A=
 =0A=
 		ret =3D qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),=0A=
@@ -1954,6 +1933,11 @@ qca8k_setup(struct dsa_switch *ds)=0A=
 		if (ret)=0A=
 			return ret;=0A=
 =0A=
+		ret =3D qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),=0A=
+				BIT(port), BIT(port));=0A=
+		if (ret)=0A=
+			return ret;=0A=
+=0A=
 		/* For port based vlans to work we need to set the=0A=
 		 * default egress vid=0A=
 		 */=0A=
-- =0A=
2.43.0=0A=
=0A=
