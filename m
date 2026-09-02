Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C472EEE79;
	Wed,  2 Sep 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327150; cv=none; b=iOdJEjpTc4onXiOIFQsxw+rAsGowgGfhepvzScaHpIV4prItl1IqNa82NcYfAVRVs3nYQbEqgouupzdrxTKAB4UBFlrOIykEex25K2IHylx1iGb8JhjXQeeOMpo5JxSkn2gutOLmC/FkRFxlWKt4m6ux85fmiXJbpmx587cDXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327150; c=relaxed/simple;
	bh=jwt4/P6m39Q7cHGZNupVohOKZcnBDb8tWoIqwc8oGpw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSc4VoG9W8Vf3e8lWs0M0IuVVXFSx/1RUw6G1QUbuKk0+4rymzkCfbFoEMnPMkgRSCaKofURSkaoKbb9ZLUaCkviWN/UbdiDpfdWmUv+cwAF5VOyy3B1qKSYaTUUQQACYTP7YzBgy47Vpv7gHVT1fC0Al60bHl+PRk4FEQAu0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=FUYcAVnc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="FUYcAVnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788327130; x=1788931930;
	i=markus.stockhausen@gmx.de;
	bh=jwt4/P6m39Q7cHGZNupVohOKZcnBDb8tWoIqwc8oGpw=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FUYcAVnc0J6TE3kguQ7YZbBqDAvWJpRhNCnflOATALbzwT4qd5OYkkoGTr0ubyfn
	 jB3eZpx6g75uQfiSkN7qRY0sNfqnVZEWoXenof8sOfcowoF8GKxJpxnM/Uao27FOL
	 Ye/8w2O/K2U/jrO6wRU1eFF9XI6JuYG85HSxBxyGEoCqn0rIfiO7oDfsX/BKjdJG8
	 nX2xYO5wuY4Tv4z+11L5A9qwEtBVtec5pLwXZCRn8RHSDQBVMkVHji2PwNeOI/2HE
	 nOv0RcFON9d3OQslEjXXDHBVpPWQVoCsFhr/4cC0UIXZOpGT3CeVVdd7jzhuHeVqU
	 xDZhUBEJAHyhasMtoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1wsjZx3dp2-017X3N; Wed, 02
 Sep 2026 07:32:09 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<robh@kernel.org>,
	<krzk+dt@kernel.org>,
	<conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de> <20260831143439.2404484-13-markus.stockhausen@gmx.de> <be7ca09a-25ca-4ef9-b753-715db4223be7@lunn.ch>
In-Reply-To: <be7ca09a-25ca-4ef9-b753-715db4223be7@lunn.ch>
Subject: AW: [PATCH net-next v15 12/13] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Wed, 2 Sep 2026 07:32:05 +0200
Message-ID: <006101dd3a9c$66ca8340$345f89c0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGFLzUwCgAarOf0mfSqlWbH5pzTGQGGgBcjAehB7du3T2PtwA==
Content-Language: de
X-Provags-ID: V03:K1:dKLeWeKggaTj+G+uFbGo6ZOak26yMvdL4on3dDMkbE2/asHZYzd
 12XYqlb4uQaCSuSIWICsBgOgf/8uDYUhMGZUHp3tDRbYRMYeVlNTzfTEkXws5zp4RMZG8UF
 zRuF+Dhdjm2y9DDB8n/dw6sBOhg3Vn6Mrd03vh0kQH8hhd5DjbOpAMnXBn6JT9PeFKvgTfD
 wjbMXePoSh0yOPsjYFcNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t82UNLBqphs=;Iu7AqP5l4rlmnUdTaDi2klsB734
 Ew1Gd//dg4btLZqsmwysQP7DdP9l1pmK9vBl4GZOM/ADqYQ/QC6REhjLCbR/2U1q6LKMHwpks
 m4EaJ1mEhn2LnhDiAj4DBZCwHH86S88c24XWPMZqs7PXQ2QFC9Ke7EYwXrDiXgSKIF5LpQrpo
 1os5OOIXLHZqlcN87Ub/ciVHqvNoAzB9cofyEsPB7Ogp/hnv5jyUSWWGlrOdXPtV+yRoXi87W
 7mmOW8hCruQ9E/94MPJGXB2e0r/rOMOxl/speUFJzaxzbrU7gguSB816DoVuTXB9QenoRbLcw
 11YEZCAb6XF2kpo/8QxbonYeL0zeksDCzt1EYrrKk0f7CDg8b+rfDrwh/dZny3MbjULegRONW
 JPFmTylv4E3756uE9b9mOz8Vk+G/JWzfujpJfDg3kd3X1X97q+jDGWYAeUegbaoY0HKw4RmqA
 nYaLm/il6xPRr1LMWWKc6FmH5v5o00kS3fKjzua+eEqPq/Pl9OzQXPtBLrTH8uQq7sfYcAsjx
 oSDWEEzXZwu2aZXPEcNVNbR3nYsFl/KOA3yTZ7nGtfR2bwgwDYp6iF58VZmu2lMz9odnfRpqR
 79RDlOo1MTzILrg7wRKjMRUQWjw3g4mUThWWazGQFl4HNiT6cMfaDzK/gkGMlenGw9isFf0sx
 if0MW5oyexqKbO7CTT6cFbxY8ya06cPt+pJF+W4gkh5wfUf4/ONoCgeyvU2JGqGuGQHRUPnXx
 bDdrqBTMPisZnWRiY2WKxLV8HLul0Z7ChUSQMOGyNzlanzdohfbynvLVko9XMsLotkA/f5KMQ
 JFGsaWuv31B7+ZT38ofiIol2cncbimdo3EBuMGCPPRpTk5noiFWEdpcPwmEZCfyXYMz6+89EQ
 Ym9fFzx1K9nJfddTvIWioWkD4vgZTijc/TYEx1E1sv5KCgkQWiXLRsIQxWnGEwUHZAmIjpHJ2
 vMsKRS/zuDK6cPHt9GJOWU4ajeIUPyxPT24mK2VOPDONegVekg/YGa3j/0G47l0eishK7lTFz
 NUPcjEWt9HXoLQgme2MTe5cmifM4RHL8REFCNh0QJ14rgP8mcdtiucsLtGv6pqB+RZRaeFuZY
 n+3ChA9oX9bQAELyh+zEiOen56xGfpZkXW9iuWnd9395w0vy9TSZLh2ZyMXPzDBdBo+WOyacY
 w17gm//pWSBh/9030ln2bmdmjhur3K88ffP3h8nAG5DuiOrHCihYi4UzqZ2IlXkw0BawjMAYW
 MLdt6DWt12Cc4SULIPpdJR+xSddNqdEVX8EegyEUqVi71wGqPilgCgMLGtt0YoucenSMqEZB7
 yoLzDV7epOuXPHbunp4u3f4h03ed+ahhgEkUs6ykYCZ0l1dvv/ZZzRXF3RKVtXfqYKyLqjgac
 m8G2dp3klvdOn1SMLRPOOjAkBqp3z5Cuad/+c8GCE4qlUp4XDIMdiHWaJsKKGJ2CuNP91KVBN
 w9Vg60SEy/Y6oGAnwkPEIdkDgxZscfqt4J0wLM23RJeeo+QLnceBQAg7jP8lDNx7JX2eaMlKM
 h+03puSx8aJFczqygaVqsIkIYfaLJxaFuJaB2tLwWERqgRfLU4vq/zXqoQJ457H4CkXy9Qk/k
 iu4xqTbO/DdrQm0UopTfoNwfCrUqRzgixUxIYuhYjgb8PuNlb6b2dp5bGiwg1oJMHBzzGGHTw
 7mXlG+Idxjs5o+lHshcymPSzOFoc7pKPvOLoN4ACGl/jEM5z9VzodWu9FkJ/GCP+NkQvu2xlT
 bJn8sFln3qiNdNCiF5Qx7l46sfD716yrrh6E4XZMLvHXmyX1XlOMlprZseqvPAi5B5nGajz+D
 ZhFZNgElcDitCNdojr/ntlxYRfwlpb11D3811ebL7eiYI4BKXU03/lSbECvzMssa7me2WYR9o
 D3kEcoQB0TcFP0frcmcTYumjnIhDhQqFxYD1GL1uP03OHxBGDY9GjfHWQRCiSfwz91gw8M08F
 fsyvXMjPVbyUXgJlC2WM0MqzzRuBN0/httl4V0tGYGUR1pMA/BZqy930SUVVDZcoRMPK+DXip
 jVscod1MVthMjF6vkOpDK6JtDE6eHRok2lpx1MRgmH+bws3KrCcBdl+kLtRzJdKDVOpupEpXp
 5us7dV94BMBcKxn32PzRdTHMv9UVbGY/PKksVJbq2+xCE+z8nGEzQSflwyZS00Di82dTPNR+O
 5Vy9PQ76dO53OjKYS67dOakbsSvU9IDAdpIY8KNciZfznCukjkonfGKYdaWfTxEqAiUpIrKE/
 WJ8vhLwUKUpAMimOGbeOOn2Mye1ArLtF3JiLMd8zMdlfbZwhEe7rouD6fBz0slkaeUdCLRbqv
 Dk7MOlRNxEXxf517sp8DHrJRD/Xx4sCtgYKX4VZO9uIQNwrThy7mNLRT85O4ps+X+BuefEDXS
 EmKYsLTbD5POqxbn4VPqSnbrRwN7nzymIgz8XMgnRvoV5pKSZXuvR0m2C/WZCf5Ny2CxJuO57
 imRRq2QTpnu9RTBpJgDqlPR+UWIcCC+9XstWftJWasm+EgEahve09uVrr0y31y45qxPgMLLS/
 NqmAPXnTRuMw4y+Px/YfPOlRe8QfAWHTMPVPG+n+JW+Ssk9qcggaJQhhvE8WFHz/C643Bl4mF
 EBNikRyoEdbl/ZQZwGi0LI7+vdlpK7sW6uYRmBLt8acabM0fvGcsgwLXGXrf1dF82KwJS589P
 NNb7t06Y7eEHeD4Sbh7UyF2+J7djoyYtrfHacZAea/Yy65O2y+T/jLSr7ql5t+EBocwoksGF0
 yE+Axvd+QPcIOzvU7bl0UDF3UKpnm2JUs+s+ND2KOkdaMaRXL2Jxu0R5NN2IOOQNqNrSGkIwA
 MF0aJ51eOT8fkxFhXbfKwE5TQmMR6hghUC0QMruX459jvwNPIbQzpWE3oO5RQlpYhgbJDR5L+
 AYtvrkoSmXPj38hfCp4PZeDrSXfISYOjRufAIDuYqJmxKnpBz0Ubzm69UySPvhrLmp4KBj/bV
 ZpQIrarR79HMSViSBJSu8SCwx6l2JNEF2UC/60TBMbxG163isswWVsSzYvfTFoOEj9WwCYA6D
 R5zBJ3daKRBwLFEQ41oMzP1WN33TYsAxyXdnyXdDmMlQ6SppLFjCBgYQ10YguJXtSVtntLqXS
 C2sr6uzgHAEKQjsvtQO+DxzW1DSnuJAnMrblxWjT1YZTqgWynTNPX4T0yqyYPpbh6RcPdPPzn
 9lFnQwfg8UzXWAekOm7iv49C+4C1f4Xv40lYRZ4Nq/d1OBFjIPhrDX9HoCmJG3cBKXVoyqoe/
 V/hf3qHODlI7+h5ftowqKaQCEo8+QLhKWRPBFKykd1nlL+0MkJNYIRTtxLz1a5EPn7sXvaOSg
 vmpwNWx45bzxSCI0R8MyDRyyCDiuPTc55PzXPxCV6sUXt8HK8FYGisFlz02LpQR3zZyxHE/gW
 3lV6RcwidGBcpmdQ+GRaRO1gLMPwT0jvpkWUVtqulBAlNdHqKJeupovsMnksprjlVmiH5mmzL
 fygsuMNGz7HlM08ftl6sxtqtLw6Vi2dTPAPop6YWX/4WWgXb3haSwAbEdCwAWL3sqzu89J+hd
 HwNyQMg1D21Ut46isOXfV2r6P4NxoJzcUel7LovpOradzhQu2/WwDxmY0sV8GTvhgRr6lSY+i
 tSejX7HEfSmLt4YROiY2W1pGPtBkNN+Ks/eEFrMnnnhVEisZDM181EGbv6O6X1Yw8hXqsNjSs
 fU4nSdN63sWsDnEzFlCfn7cgMV6PmFHxMZS7RraK4wMtVgBtbB/52caWsMQEG+iw9HLK2t4W5
 JzqdvBWkO5xhWcJAzksAAyrnEZTANl28MFZDUqdNPW8cmqRx6J0IV6FtJYIF/zv2A4YIu/+QD
 M/p49tS2vQBrT9iazxYI7flpt6Cg5FsZon6S8JitJTGxrmVSpkfGBsVzPOxjcCNLi3ihlRRa6
 VsKIvoGYFlFuFG8BRqOAaZhjnaBOhX5eNjoicuzA4PiusKgP3l7EGJyv9MAwGqItPPDggggTH
 TtsUg+YkunT80CF5msepfnH+MZc9G4eG8gd/R2a3Mo4GT4BeorGzoN5daTlhZm6BqQ7w0dZLa
 HDbztEghDRSe9XfeIspcs7PFFs3ytRG3a2aUvvtkmvObonF+L9HwPchag/2uu39nt1FXotsGY
 UH7tK/7DnNedx/5PDxA4LwjzkL4HB8p+C2n1k1yLQ28+5uzQo0R46GardipAgYhA8Y3XPICuf
 EsRppPdRGhhZGt9LPYbtySYHPvlL/dfX0qtiNkMRUuSErIlakU8ucIyUJiVZxKBsPnVlo+2D4
 wQUZmrKHNfsoIKiHRlg4yhUE17rCm6IuoJS/DfmR7+7ugeOUSvuhk40lqlWGRNp+gj2zImbCB
 wXM5tLtFF7l5DgEg59D4xpH4hAPT+Ab3YBQEGCL1khX80eIkBFYHSbchPx9u72+h0v6BbOL2/
 1eFq2BPuQg3gtTzwRZ1BveecZ8iC/Wxmf9Y74q1bQ/IDKprCqS8iPHi61tXR13UlFdangxZJi
 Fqrhb4yKXNRjGcmdbS0weZlfM01Ci9YQ/0SePBGHNCqZEz+vPr7kH8OoT4jWoArLS8Nd9QCAd
 M2IMyYXvyUQI6YGOPqgw5tDvhlSWYx+BcsQHP0WsdWxuHwvi1JU5VD9IrrdbyjJdrxJMdaDaN
 CXuUG7zXBOaCdpakpL6OJV1J6m3vuxIAuGUWzxaCoPjReJEXGxojXLlFzGwS74YNLDA/4/d2s
 qWVYrP6YO6Ui8yxMdHfSIpvrE66WInDqMBF8YjQA9gPhcvIqsz5LfCdv2egzSB1mvsX0x4E9b
 jzsHZ6/BbSlprSE8F2nEtHevvDNxuWwfC1DXGUr2NWnBv+IgcZRf4muPtgIDEvnwivQoX7rDU
 dOVXU4y456g34SmlqVwzovTo4JAo8Tbodgzp93FSBBHvPqqgYj2wW9mR8dnLwmL0cg21L3LwK
 8adXmbYACa/mLmGtWbDvfQfEV8u7Kwe8ZZgmXzR/HrnqyC9P8NHVHLSeVzbJlialF2S5CPNaq
 myjAXPUMHbp/p59RzJ2ZteZLsejS+zxHRACL25ghDijG0n5mti0HOcmwownMByinDwcNAXVRQ
 0jhCGAzF6nVgaS0/LCz7uV1rL4hhwl0xesJUFy2xT4o1YjbCDUqfqIJbd/HifYymIhAxM5d3u
 cpreqXAP7qJX+wlsBaDE7kKTgKmcWc2C7wf+MSdWJSTDCEe4BU/DZ5TOu0nbNVIbB1DLFxEL9
 bEpabGvQqC6l2fnGfkzjZZpMpwhbGjKqojI2zwq4NidHbZHF50WDm0ZIYz0Cs6Qo4OktBHoSM
 EifmIQbDijvERUM0biYcF6o25lrn2hVLggxhQxUVVLMRDC1ckswWPYntjGMiGU5W3xK+uF+PY
 Le0OUtMxanSjN/sIsCocCt3ErHj3lv08FeDNk/In76lh8NaDtCan0SOGEVY6wNXDR+rT1BkfC
 P7hPGCnftmA+VGcIAgGt7ZXjjMuEZOtTZezqdfak1vhW4A+ioD+SRAev96Gn2veL7VhAlrvK4
 IDPmB3OxqQffexdBBehmf7KlrgGm1pPf1NwmxXMC0WUAEW4z0sIImk+P90l9wBzQ3AZWZgc2v
 Lf73c52I32SbvD1Um2GXp0FpDa1tPe9r+KdFDsoewBOMzuVDYJYVHO8367kRS3HDJEy2uKSw2
 yMxB1nqCvFRqs/a7L4vL8AjcJcgnLknYAyrUE/714uOQ0lGou/9ZQ5FYKwveWrnZdDaGeekF0
 PG6R/g295rAzbSc30VnSdauPksEtOXxbE10blgfvq4ZAWXuWGTgKHcKb1c3s7sR518vVcbMI8
 0U5AbOkN8uIgjYHuIgcAS7xXM1iaH1oqjUcUK7FjkWyocBgsDygp1IPRYWbKTodwEk61nIdFD
 ocwUJjPP1pBfE3Hq/d81bljTExwIhH8AWEjR1rWjNcgcD5wFyAb1jH3M3ymF3/cLlGO7wUG85
 EHCOKlYKFmroY4BJcRrmp9tLgJQTp2zF7ggMs8X88WvcUQMYMbIQs4MZt4bDSdlVf7CdtKAWV
 oV0H9WYhBmmUf4dIvMtQeUw5HslRrAlnP+GurBvH8IfN+RXF8FxdIUrh9DFvnnJNcNirsgBjF
 slwR6ORBSCIh/S4yezeHB9uFhV3x+m3ueBmN9mxXTv4qN4c1JXtWY51mSbV154ITf3HMsOa59
 Se4m9nCB3OdIuQiSkdiccVNfWcy0FMAT5cmaZmlMOst9gegWoHtHSUoHVuhDD1UO2CCQvuQ3i
 PtCTyXsUhchkLctduaDcgYKVgnsjQLj7lbopvWsGkSv+Lg9oUUjbEG0Rp3tKRG1IQZeZQgWab
 0LnuwHLgqPp1ZR6FUstk6Q4Rvp44O/a91+Zc0bnIUGI139slXTChSGRq2h+1YKMGImhFM85Bu
 Vmi2IvzsFTPyep5mP4r2IMIhjmc31Pw51Zef6jNzGxzbBZGCvbzAvaSgv8fwmy+TsPfDkBoBQ
 1cCJR9H8Qlgm6ocF8+VsI60kwk4rhoxsdfzKG20acSEFUrvD/M83EtWlP1jAQAQ4E7hJzuurU
 KHH2Cb3ReDbak0ftJ0RMXHjysALi+VaFalNoSPgDcKmATEDYJhepwOey5WCL2nUoEoVuc/po9
 Pbcu8phnvdV5319ZhR4g55f59bgSQN9GcdjIqAKG1Q0bQFUx2/TdTYuimUpx86eBjnx4rhogO
 kgK//nQv6kihn1eXk7Vd+YwN7AqHV5hydSq0Q8nP00QFGfzLZwJM63jrHkkh2fOWDi914WXP5
 0VpINbOfvzE=

Hi Andrew,

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Mittwoch, 2. September 2026 02:18
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next v15 12/13] net: mdio: realtek-rtl9300: Add
support for RTL839x
> ...=20
> > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thousand thanks for your support.

Markus


