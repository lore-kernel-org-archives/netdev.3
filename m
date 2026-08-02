Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021087.outbound.protection.outlook.com [52.101.62.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF52E03EA;
	Sun,  2 Aug 2026 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642442; cv=fail; b=TbuzYNiQG66oLVAs95Ww4ij6UiZBVkFZBEHlJdOti5wWUTU+Vs8FnfWxjC/6j2Zm6SUh7LtOV+pJLQia+rf0AylUw+6rzbh0XR/pgSSxl25OnwFje2LLjpAqYx7D0chjzlNGUzTaFxjwu3p+v5kBZBlwBejZi/r2v5CeKZOFUYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642442; c=relaxed/simple;
	bh=mvliq8UcRMlvceDwCk8vcSfT6toyHrch3ar8rHQI1qI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VWIyb1RdH5yEkar5Er9Ms0OGiyZnkZu7rVxOO6eYEg5O3kSmuPUAvU2V5W1lVLgfzJxqOCiFfdaahAuWHkYhFkkAsbPBFoliPfBECGVvpIqxwsuyoM+703kYfdHFBV8wFFaQ/OyMWgOF1qgs9Xf+9GsO+45Fq4cjIzQPvtT/TkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=aUW/F7Ev; arc=fail smtp.client-ip=52.101.62.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="aUW/F7Ev"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKZas8wE4+QqBhbEnKhe9re0iHBi+4tJLbh6uTJfVnj445RcRdenL65EPh89X2/YTQw1cVqw4WZrK3BgyUefBovT+gNQzb/73uTee7yZ0pM1zpFGm8XmjtKIZnpx7KZXzdiSi/yxmRi7MRLZ32j/oXL7d6VHL8u/a+wd5HYOilnOtkGgpV5v+KZSvwrk4k72SlgXC5hJ21rh/B27KDND58GJ9JvJwt2qqsesgrDtuC54WCnxUuuGaGQjbpsO+C1MLpKs96/xrVGR7fM9LtknF5f/UuwxaALyV0OWmvPQdRR7jdxCBpWk2dl/ZTXuULkmq5f543v1hEQAzNdOUudrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN9HEOP/brrCyyIGG8v/o/x7ZqObQAcwN+DaeI7e4lc=;
 b=jyNBoz3AGx87wIsPa7bdcjggKooOUUiokK4faQRYz6woOdtHEvZ92r/vE4UZGXwm/bGXBUrJl5F42LeV6Zn4Di47rEEl6b8g5a2OTo+xwXFq3F0YUMJjn7DhqMGLYt0tyHcxcExgNRwPf6oxUki1H11Y1DUN7RrsxR0r34qidCTUTs5NQ9/oVSzhIFULPBHkg9xxblPdeLLFiyHCnkHdoAiLq8nYapGA75dcfcUiXTjZ1FM/D5ioqLBZVWfHEjdt9KelgDTRr+SxU0dkA4zHagOQJuydLkNHLUIYpHWWUvjBzWmNVf5BPx7fXo/tMe6WeSQTGWopJcrfksB6R8pbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN9HEOP/brrCyyIGG8v/o/x7ZqObQAcwN+DaeI7e4lc=;
 b=aUW/F7Evlcrde+HzlRX4nMBxDGKbDk1rt5E1FdDbsdQqS+ExRtGYOuX7+3c1HbU8Gmr/yqrPl8ylc9btoNIglKAoLI0TZIjCjsLrNZDpDxr+6AMkZZp4oGKUiKyuh+bULs7JEFllcB+WyhVelWmrkfezBQmo8EFvLynDM1rpMUMWUOPcWDlatlGQ5N6e8uid4HZIRtmJlmlaTVTJS9/JBxjrSsNzoe9MhfMQ7bLEWetssSzEwBzD8c6JW/IffUr6GIopixf3WZJ/7P2hMeXvvHz3n7e6RTX76xwLIhld2hdOaI80PBsgbDWE/k7EPHuAXlZTs6Ln+qXr2ATBuTYnqA==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:18 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:18 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 2/6] net: dsa: qca8k: skip host FDB entries on
 CPU conduits
Thread-Topic: [RFC PATCH net-next v2 2/6] net: dsa: qca8k: skip host FDB
 entries on CPU conduits
Thread-Index: AQHdIjGd/UKqm9oaIk+DgCJ6HjyZgw==
Date: Sun, 2 Aug 2026 03:47:18 +0000
Message-ID: <20260802034701.3339052-3-brandon.mahdavi@mahcom.com>
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
x-ms-office365-filtering-correlation-id: d1d2d23c-3128-4097-08f5-08def048c01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 PAb3TJ3H6d5IwVBVwOLW0JuXmKraUwHx465lDVHbmZp6dIrfp/GJjHVJV8CzTA2OCwqbsN/4It1isv9lMicAPKy0SWM+sCaSCmyDdaHDWXX1BUVToZqtKyj4xTEftFG6SrJX7T/L5KrY4d49dcMhapQ53SPkqV7/o4QDauXjo+fbtiwZHTgFikVZqBdZaHvNWDsQGeMRBaSZlZdc6gNJotbBBxB9Pfb1k9UN7BZy3kU4PHelF4Kl6LgiGMKMKnrkJxVTj08Rf8wW7X0f7WxJSTVph/gBy772ilMO71oCpzd7cKog9SGzfNgv7wsxqKmylDDvczyyX0alZfcvz5xiif/C2Cj4ozoPggvw0LKahAPRoAEuLj/4yOY0yq3pf5z7jFMpmZtw2yBNoBWVLe1ASL2HzsSdN9EQJ23GwDX5A0iSaTwvXAWk4tfc2hTU7ejxh8nni3lsHOumpSJKBVbTvK8YaXFn/LUJSb12zzV0NRdMRlrFnmqCUOAzAWlS+jthj8zwp/xT4M8TVZM+ThLWvgQuna5P8R9TruWk/jKct5HRPA6Y5w332WBY1xlS3vIW1ZAPrXZcGMhq7XIqqxvGbqNq6mSss3qWc8H5aXCRBpvxosvfrEueaHtpfhZaXZd+O36gntx25uUUsCiKUVwm7FsIl3oTAM4KmMU+S8USBwV7yQL7/Jemrv9RK1QtRCfci3MW0RQLomyx1cbZRTT9DZNobFVtc4f9vgCaaMcKBXQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XR/45nzPMA+6vqv2koxg00f92C9D/nsl8hG5lAm2e8DSuL5fQ8hnOrUlRQ?=
 =?iso-8859-1?Q?RAo2pRyJo+p9HzvS5rYH2fxqTW8vz4l+ncQwt0i/hWz+iBBo9fzEGyOPfS?=
 =?iso-8859-1?Q?lTt4pkf1hOWWgNXPH0P2NBSUcoWzLHUbsl3RBBPERV2ovAVucxyXVxibC6?=
 =?iso-8859-1?Q?pyJttuvGfzHQbWX2SkcsdGeMF386NNUx8rwTcAsbUpa8YYFFavW/OkjZw/?=
 =?iso-8859-1?Q?glJMcmT5qOmwEeJyFvmsMDQNZ7rwvDjDBoA60QL2YWZ7cm9x0fevTkExeh?=
 =?iso-8859-1?Q?VBVh0R46bPRv3TGKoetVvtuvJSA/fGL1nK5cUTBgXioVRLLz7xRDbMXzxz?=
 =?iso-8859-1?Q?4fe/7Fi96pWZCxBfEM+mKoS0aO8D5q9+IuR2++9BN8MJNyqIdickY5Golj?=
 =?iso-8859-1?Q?Uh9iuYUYw3MKhrInYZ9/pfEu50UN/H/C5TF+pNuag3KItNVx3njm9xODVS?=
 =?iso-8859-1?Q?etdy+P/Tbnoi9xhPYauUKQFmvfniFgbw8QdLan4vjYkKBgv6teQffeDGu5?=
 =?iso-8859-1?Q?GLbph1iAxHS72n1jriGSY2Uz7QqeqWzNY0lo8NHZIQ+J/4SIfLBPaFWTKj?=
 =?iso-8859-1?Q?ZXH+8mAM8d9vuvZpQ4n8Oavudt0Ib7q3Ul+Mf/hnDN1/NBEdFxPvcqhoS0?=
 =?iso-8859-1?Q?vNb0gcn54UMcWxJGke1NEvR6rtmpropVzeisYZc9RLOTzGTfiJvoWLbtrw?=
 =?iso-8859-1?Q?aMDdPsCax4iZyePUtF6aaz8Ye9vChRVrR3PUiKQNPVgm6SAPn87KS1Jr7z?=
 =?iso-8859-1?Q?bdtjbrcxShkssmIXbq6pFCh9KX+Xno5DREmHdgVIqKnB+/OruVLz4V2AcK?=
 =?iso-8859-1?Q?P/PdThHVJIhHaDdvJKX6xBYa6+1AFjuzM00z0CrmB3tKFtHW8tQ0Dbw019?=
 =?iso-8859-1?Q?dAytxRtHhHR/IFUtheuM9Jg6HZm/qcO3buXDSKUkHUrhX14GxctEKIX2Fq?=
 =?iso-8859-1?Q?QZJl8vwf8iwIfpgpCkbs+54CsI2yIv7CLo8kRdYgHZ9o8qX3RDUoOZqwPz?=
 =?iso-8859-1?Q?7P6T8EojHgMjpfvchVRVu6XSG2l41TJpHydRIqok/kPue/la+FCG3e0UBY?=
 =?iso-8859-1?Q?oX9UwsoYgjtrKG9ua+SyE6zHtCFxTVV0KAARgmP+ADvX5eBLztzDYmSQcy?=
 =?iso-8859-1?Q?zZUnA8emwbAviSgu30YKVH6tfVWoEDEav1YayTOUDVR3WBKDFCqEJ5IoAL?=
 =?iso-8859-1?Q?vPO7aWVScPcUc7gWkRHiaKiUK+nkBYs48qVH3oglx1h2GCd/QIASos2VVP?=
 =?iso-8859-1?Q?NXWlgAJDI0qsPq4VZUYaBlja0qLagoYeh9cs68uSiZcyi6dKUGVigmlQ2k?=
 =?iso-8859-1?Q?LLk1GI6UdYdpIhswIu28GJXxfr+uvorBLK4ajaOr+yXGEORt9IbfHwzXtU?=
 =?iso-8859-1?Q?TxyItY161d26xD3osPzJZqMiK45JvCRw6kxwL8VTNXekJi1XL7U+GRJoDR?=
 =?iso-8859-1?Q?pACPS/8ccgCV3+6F4kSMWVNTsZBddaERk2FUtgOSDf68XKfUFmIYkyRJgn?=
 =?iso-8859-1?Q?OoOrR1L8jivoB5eE0yT+uUH246K8+G/I3z0CSloU9rHqXykmbQ/cpBaF5Q?=
 =?iso-8859-1?Q?7NCPNM79cjqSKPF5l8DX7Slj3bGw8iHfGj1ZnD0W8/d1qqe97tUCszKJcL?=
 =?iso-8859-1?Q?WnKyibxmmWMjtpCw3D85YICKNCRjTM7LFU9AmIIWUVgWSZ+MdFSuanW4YK?=
 =?iso-8859-1?Q?s5n+GH+eAe8++HvpMGJGSfrtnRApfVcavFYmJkiw1R29x4mPMnTBOXWO6X?=
 =?iso-8859-1?Q?Sx7lxpRod+DMfY8nkwQBE89WJntYT4Dv1KHWpA71z4B4uF/daasQsA/MYQ?=
 =?iso-8859-1?Q?hyyCyNCHBQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d2d23c-3128-4097-08f5-08def048c01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:18.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xkv+Vl4jWzDp1mjqZjzho5furf6NQ0pps4be0ga+6UWzzvDDkz6S/Qw7Qf+G7lcg+dIVI1Q9KQGHIG5n3xp+CSyIB5xInHdvPqICodWI8HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

DSA installs host FDB entries on the CPU path for addresses behind=0A=
software interfaces. QCA8K has one ATU entry per {MAC, VID}, so=0A=
successive adds for independent CPU conduits overwrite the destination.=0A=
Combining those ports in one destination mask can instead duplicate=0A=
host-bound traffic.=0A=
=0A=
These entries are not required. Unknown unicast flooding sends host=0A=
traffic to the CPU path, while ingress lookup membership restricts=0A=
which conduit receives traffic from each user port. Skip host entries=0A=
on CPU ports, including the lag_fdb callbacks used by a CPU conduit LAG.=0A=
=0A=
A station which roams from a user port to an interface behind the=0A=
CPU can leave a dynamically learned entry pointing to the old user=0A=
port. Such an entry suppresses unknown unicast flooding and blackholes=0A=
host-bound traffic. Purge it when handling the skipped host add, but=0A=
preserve deliberately configured static entries. Skip the matching=0A=
delete so it cannot remove a newly learned entry.=0A=
=0A=
The non-LAG host FDB purge path was tested on IPQ4019 with assisted=0A=
learning enabled. Stale entries were removed when a wireless station=0A=
associated and downstream traffic recovered immediately.=0A=
=0A=
Link: https://lore.kernel.org/netdev/20260725032159.421627-1-brandon.mahdav=
i@mahcom.com/=0A=
Link: https://github.com/openwrt/openwrt/issues/21317=0A=
Link: https://github.com/openwrt/openwrt/pull/24162=0A=
Suggested-by: Olaf Marzocchi <lists@marzocchi.net>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-common.c | 70 ++++++++++++++++++++++++++++++=0A=
 1 file changed, 70 insertions(+)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k=
-common.c=0A=
index 5f0a875e5c87..c0a0d44e7c70 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-common.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-common.c=0A=
@@ -322,6 +322,36 @@ static int qca8k_fdb_search_and_del(struct qca8k_priv =
*priv, u8 port_mask,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int qca8k_fdb_purge_dynamic(struct qca8k_priv *priv, const u8 *mac,=
=0A=
+				   u16 vid)=0A=
+{=0A=
+	struct qca8k_fdb fdb =3D { 0 };=0A=
+	int ret;=0A=
+=0A=
+	mutex_lock(&priv->reg_mutex);=0A=
+=0A=
+	qca8k_fdb_write(priv, vid, 0, mac, 0);=0A=
+	ret =3D qca8k_fdb_access(priv, QCA8K_FDB_SEARCH, -1);=0A=
+	if (ret < 0)=0A=
+		goto out;=0A=
+=0A=
+	ret =3D qca8k_fdb_read(priv, &fdb);=0A=
+	if (ret < 0)=0A=
+		goto out;=0A=
+=0A=
+	/* Keep deliberately configured static entries. */=0A=
+	if (!fdb.aging || fdb.aging =3D=3D QCA8K_ATU_STATUS_STATIC) {=0A=
+		ret =3D 0;=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
+	ret =3D qca8k_fdb_access(priv, QCA8K_FDB_PURGE, -1);=0A=
+=0A=
+out:=0A=
+	mutex_unlock(&priv->reg_mutex);=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 static int qca8k_vlan_access(struct qca8k_priv *priv,=0A=
 			     enum qca8k_vlan_cmd cmd, u16 vid)=0A=
 {=0A=
@@ -829,6 +859,14 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port=
,=0A=
 	struct qca8k_priv *priv =3D ds->priv;=0A=
 	u16 port_mask =3D BIT(port);=0A=
 =0A=
+	/* Unknown unicast flooding delivers host traffic to the conduit. */=0A=
+	if (dsa_is_cpu_port(ds, port)) {=0A=
+		if (!vid)=0A=
+			vid =3D QCA8K_PORT_VID_DEF;=0A=
+=0A=
+		return qca8k_fdb_purge_dynamic(priv, addr, vid);=0A=
+	}=0A=
+=0A=
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);=0A=
 }=0A=
 =0A=
@@ -839,6 +877,9 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,=
=0A=
 	struct qca8k_priv *priv =3D ds->priv;=0A=
 	u16 port_mask =3D BIT(port);=0A=
 =0A=
+	if (dsa_is_cpu_port(ds, port))=0A=
+		return 0;=0A=
+=0A=
 	if (!vid)=0A=
 		vid =3D QCA8K_PORT_VID_DEF;=0A=
 =0A=
@@ -881,6 +922,25 @@ static u8 qca8k_lag_port_mask(struct dsa_switch *ds,=
=0A=
 	return port_mask;=0A=
 }=0A=
 =0A=
+static bool qca8k_lag_is_cpu(struct dsa_switch *ds,=0A=
+			     const struct dsa_lag *lag)=0A=
+{=0A=
+	struct dsa_port *dp;=0A=
+	bool has_cpu =3D false;=0A=
+=0A=
+	dsa_lag_foreach_port(dp, ds->dst, lag) {=0A=
+		if (dp->ds !=3D ds)=0A=
+			continue;=0A=
+=0A=
+		if (!dsa_port_is_cpu(dp))=0A=
+			return false;=0A=
+=0A=
+		has_cpu =3D true;=0A=
+	}=0A=
+=0A=
+	return has_cpu;=0A=
+}=0A=
+=0A=
 int qca8k_lag_fdb_add(struct dsa_switch *ds, struct dsa_lag lag,=0A=
 		      const unsigned char *addr, u16 vid,=0A=
 		      struct dsa_db db)=0A=
@@ -890,6 +950,13 @@ int qca8k_lag_fdb_add(struct dsa_switch *ds, struct ds=
a_lag lag,=0A=
 =0A=
 	port_mask =3D qca8k_lag_port_mask(ds, &lag);=0A=
 =0A=
+	if (qca8k_lag_is_cpu(ds, &lag)) {=0A=
+		if (!vid)=0A=
+			vid =3D QCA8K_PORT_VID_DEF;=0A=
+=0A=
+		return qca8k_fdb_purge_dynamic(priv, addr, vid);=0A=
+	}=0A=
+=0A=
 	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);=0A=
 }=0A=
 =0A=
@@ -900,6 +967,9 @@ int qca8k_lag_fdb_del(struct dsa_switch *ds, struct dsa=
_lag lag,=0A=
 	struct qca8k_priv *priv =3D ds->priv;=0A=
 	u8 port_mask;=0A=
 =0A=
+	if (qca8k_lag_is_cpu(ds, &lag))=0A=
+		return 0;=0A=
+=0A=
 	if (!vid)=0A=
 		vid =3D QCA8K_PORT_VID_DEF;=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
