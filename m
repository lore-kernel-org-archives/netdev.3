Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021097.outbound.protection.outlook.com [52.101.62.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE82820AC;
	Sun,  2 Aug 2026 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642439; cv=fail; b=TvoqzW29ewpzoeGqpD1WX2vukI4y2vI6gnGklOG3gsCRiE+XvjFwzi5xhusV+wteZjjtolsBVuQdYHvRePULd80styLBV31SDcqB2jxzO4Qm0XF0+RExTp9nmyerKzgBfBoWaEnouv+u6BC8MZe9ewQLqYuFqtL9RivOBbPHkQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642439; c=relaxed/simple;
	bh=r0FIsWF7Pg0WAEP/7eJL4PuLPi6xHe4CFXlIiXjwGo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVBGbRTzzTrQIEGl6LIlh156GDCl5XIghiguCzPcr376IL++hzhXjD5hcGq/Ih735vuNMEVUTaYTtr7sQ+CzAh4eOF5tSa9xrBOTaGJfZD+8H0V1A9vP0xQL0ZOD7ZH/sVVU1CRE9NZT78UiktSAwKQrK7+DvPRsOsZASVKhn0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=Ph1dDCkj; arc=fail smtp.client-ip=52.101.62.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="Ph1dDCkj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/m3VM4XZlhByiiowl8hukiqeUgQAHkwDPmtPmDH9Lz5Igrw5vCT3r2rgyWmSViCokRdM9BEc3DleWbNZfoOnSxlKziIQyqLyr3VD0xjbkwdwn63YztKwKkjqwVvBLVFH2KMLWVlHNphQQRqlxW6E67mS2/kANnZViMamYdJ1ZsljuWWBJr9Nyqma2cwcjjYEPsJ+jiPFsCU7RXKRrTdl52ifyIkTr/0J2FHaMBlTNpoLgN14u67DuesU72hn/nNrFV9XVDaov55wDkLV8UOJSTzYN4gLjmVgd1uh5OnCBkDZKgdjs2/jIEtS0ugvDv72vw5mYqfWHB7UQQy09F+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0X9TNMeMCyEoX0qxV7Bbp7MQ6QxfzD44catuTc0d4o=;
 b=fwBZ2dTr0vE2U6q3l29pdKTP3jzPbxq3gLwkJAAJPJh/ueBWEJBOv6uzWE/0eRP+Sehz/505qTCbPJbRRpfIhy3lDkX1t+aNpq4F2izh4l/jx+HfMbS6z0DJAyZthDkZ9p+tn9gW91poYF5K6SDOBDwvifHVYFsbLQj7JKoPvXnt1yscRzF2aK36rSQMuVgVxNGn1GyHRRF8HOhz+8H8dyT/YvlN1lIX+1Sy46sDRADLZXi1ftEU6pZT3V3uBwNpoorKKIXdYHSVLeNcsMnL3I2L6WGR+1XbtS1lPAcWnsrUDhGsxQy0ekBR36QHihcWoRNnfebx0JgPD7V6FsFS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0X9TNMeMCyEoX0qxV7Bbp7MQ6QxfzD44catuTc0d4o=;
 b=Ph1dDCkjK6rZ3V5zzABxzzAIFXB0Iu1VXwliBCx09BMpC1tpVBVwIie0XoX9/pM2yQeISABgE9yfeFDy/jj5OqrUNJb27Br1r3Z7OM+wYgq4XQC6w/GKPYU29YjtLSF9inBN/PX3DFICsZHpnxa6Tw5m11/U0TWlXd8VMny+sQzEIJ0h0rfBxLC8nVJhZ6bAE1IFSetcvkfyajKIMcXMfPb2ASoALp0qOxCKB5WkOyjcvMx+qu9LqCGkN9aNrdrWzwSpmceW8zqjzBU8QjD4Ng1cZqxaNt1ZFrh6mUojkO+rsiaBjYr6v0BmOgptxVCbFYSWr9yQ8e3xE5I9kTqy9A==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by SA1PR20MB4298.namprd20.prod.outlook.com
 (2603:10b6:806:235::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 03:47:15 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 03:47:15 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "hzyitc@outlook.com"
	<hzyitc@outlook.com>, "lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next v2 1/6] net: dsa: qca8k: implement LAG FDB
 operations
Thread-Topic: [RFC PATCH net-next v2 1/6] net: dsa: qca8k: implement LAG FDB
 operations
Thread-Index: AQHdIjGb347/o5wIV0Cq+zIgzC7iFw==
Date: Sun, 2 Aug 2026 03:47:15 +0000
Message-ID: <20260802034701.3339052-2-brandon.mahdavi@mahcom.com>
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
x-ms-office365-filtering-correlation-id: 9a750547-bcb5-4ce5-9296-08def048be1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 H3yoivV7igiZ1qxQRlpad3q95UPLosBBt05tJ7NL1OeUDz6+KOt7GQSTgAR6x2DnUa+WIjqgWC94r0RuQG3i7hlaWrs7+S0E/hPbBA1Abh2oicXXxojir6HJFZO86UNY3jm+BD29SoU9SOWLtm5ebJ5FUTVQN9dJ2fwbEr8zstkRnigqvQCkwyrZaByxjWY7VJIQvK7SnhG2FvD3AffYRQpATAiNdu3Jla0R4+zVOctS1fxoxvlof3P7b5tl/sKaHKg3zPV3Rgj3bKJF1m8ZJ2uJs0qC6iP9fcdn2uuCX7ar5gYFehzCdCNiv6oDNlAWU1DyxXL4EvCyHUoltIy6ZDpwc+TmGDwG4UzDshS88RGMcTtuXWq9N9YsO+hfdU230sdTMsuhTjv90t+PRM8yFawqaV3bHoRiaVo4mrSzzuWH253w/kaRqi+rIwqFEJYwALuLs8mwpRrZKLyHkvMJBHbw6jiTQDEKkfHmWMEOII9YNwjG3IuEp5Rm7idP+0Qm0+PRo/ZCQpDLr9FOTzL2hW/j5AONYeLvydei3cIycmlB4ZRnATY/MMOVSPbjv9E03knl8CV/+K5Rjz30kymlZnsHbjxDLIKov5QzNFVu7G6t2Nwc1ySNr8sBbIEcVTHw5A2GgM3XgKxstTdhldpFgnUtIStsu81Lp7twkHKl997eaJWQn1VYYBwlaPZpHsEOqoMhnoS+MwpNrsp84QKhCHb5Mb1Q+1pXOgYLBNfDLUw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zaihbTgXVAZW3MM/qtMVyZzUuCWzcHyQxAgqtkdM5PGTtH7PTbGxdrKHj1?=
 =?iso-8859-1?Q?ULajQ9Bn0+l/fh8ET4jF9Hp5b5VL5K38DNHJRkT1NugBgEzwEDp8cp1ku2?=
 =?iso-8859-1?Q?MkBFZ+KrUHcvldqdjXh6UZKwUbMZg3y8X41/WIK+Z9fSumq83xzSXuNDtA?=
 =?iso-8859-1?Q?MqwITnpgSWfoC+TdAEGvtSmPFkUmVnBpM7AhgWQnpa/hLpsbqI2bR5Qmaq?=
 =?iso-8859-1?Q?4tNAF+huOqSV1oZKCx+54JGvV74AZF7pd9ym6p+Ds5/wdL+CH4U0a54Rsp?=
 =?iso-8859-1?Q?Tk5BPw2XBPTQgVm9nymQzPdQlRGyjzY0sw4b0fVNKXZvui0wBcYTDN8+GO?=
 =?iso-8859-1?Q?2RyOYXSC74E2XV7CM9VUwUlNgDMAUqmd9zFHnyGl8zvUwrkE71NU9bOYWO?=
 =?iso-8859-1?Q?eYV2ZwjDX5Qf+m7UC6/3urSGXbG5ZnhXqTGiKoOuiWn+A3ML9vxHxRQq0A?=
 =?iso-8859-1?Q?XQAxf7e1xa2lACWcrGA0akpcqO2dKSNw3i1SSYbqk9FVlfbd5H1JaYSSG/?=
 =?iso-8859-1?Q?vkZ8cvLir6BMTKJxe+sxBK7L5kAYQozXDzs4mQHs77XcjZ1RsZKjIwDc76?=
 =?iso-8859-1?Q?htT+ltnSxW472bIuPxBz4VFLrGmyuE0Quw7veKn8W4BiO103K8Of6DoUFR?=
 =?iso-8859-1?Q?H58pRUMcoP4h4h8leZMIz4N7pwa89LN5EFpfpbO075pgfGOvRlABatGxQb?=
 =?iso-8859-1?Q?VG11L5F41IaiOn0ZKi4+yOoQM4oFd1lAGTrZVe2t0fEhvKFvSGBYEgQ5DG?=
 =?iso-8859-1?Q?pNvtVp9JLVwR+s+bsz2vUBLiXV7cLHEbw1k+mJccUqEevOxTAdEjlGzhpp?=
 =?iso-8859-1?Q?xb7oCOGt3mfKo6BkxFLykQPwSNr1KWyxacmX7K43sgIqu/fR8jklDteufG?=
 =?iso-8859-1?Q?GkyUxmM+ud8YycFvmXZBdyFOM7HtZhCWPwpP36fEGnHAeT5q+2lRp+bu2G?=
 =?iso-8859-1?Q?HCUkCfj6wvBrFrMxK83kchZuXkd9tN1aX4SUo19trB6G0Nm3uUqvEFV0pe?=
 =?iso-8859-1?Q?rEI72KFy5D5F8ZHnV3Mu6g7GZhZaSoiS03rC3pUY/PiQp+PMiqjv/ql0g9?=
 =?iso-8859-1?Q?7tcMREH4Dixj8JihyyN/0iIZ/CT9mqSDjsoiJRtYzFPNacTxwgxGUFvAHq?=
 =?iso-8859-1?Q?hCyZQeLfzSK34acxS0Y2YE1g5HRAgib9PFLgP4hoWq1x/0qS6bKxZVyIx/?=
 =?iso-8859-1?Q?cp5AKyII9drkjTpUDlCdCBjjQOC3ads8PHKgd2WHnvcI5Z3nKR1L3Qk79Z?=
 =?iso-8859-1?Q?vjVLhc/8O9kS135x7EZhANZLmPisy8K7xtdSD7VjDC29n8LGr9GW/lHJ2i?=
 =?iso-8859-1?Q?TIojteAe10KNXb2gTi/c23YjGNkWRGAQQb4hCyKsKxAb8iNHdz5SHeiKAg?=
 =?iso-8859-1?Q?iCh9R1yH+gfzEvRfZhFgreMHFzCnP37SnBAPQcJh6F7PvLjeHkFue7cTnn?=
 =?iso-8859-1?Q?V+y9MMxEymthWyVhp7VMAMLC0kPXki1m3xReJiANONzmDVHbX56fSX0g+b?=
 =?iso-8859-1?Q?YW9bYayswJuEBMIqcCT4wdg95GaCZlTxnhCKegjIp+qMxUTHKYQrD9BDLV?=
 =?iso-8859-1?Q?phJ/SoCH3Cab05fookbGOmBLQcoBPIFlmmHv5lKUpoYxTDFvHWazUM/P8k?=
 =?iso-8859-1?Q?mUY3QMZhouWiU4LrKy2rvBskqZkZs2jnJoh4ZcXlFpPvLAdFTxNv8sHeK4?=
 =?iso-8859-1?Q?vaC7n3Lo6Ez4qCwcVIHnp/ZS6v7aKnzBTRKqCHOHnTfEj2Duna0vU85XJw?=
 =?iso-8859-1?Q?5lN46+JZn0lHUug83UbELZ6IuB8wmWvrviNYmHOJenQam6FE6JHZdZNUqr?=
 =?iso-8859-1?Q?jChafgKFhw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a750547-bcb5-4ce5-9296-08def048be1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 03:47:15.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4M9wB5sXTOqW3d58edSUnTawYmuz+m1SMLft2RqaNmlwbypmy8EDPoWAdIcdDDFGKhf6zgP3+QjBn2SZwflKvEwq41bgRPGDA1qaGJuEnD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4298

From: Christian Marangi <ansuelsmth@gmail.com>=0A=
=0A=
DSA sends FDB notifications for addresses associated with an=0A=
offloaded LAG through lag_fdb_add() and lag_fdb_del(). QCA8K=0A=
represents a LAG destination by setting every local member in the=0A=
ATU destination port mask.=0A=
=0A=
Build that mask from DSA LAG membership and use the existing=0A=
static FDB helpers. This also provides the callback path needed when=0A=
a DSA conduit is itself a LAG.=0A=
=0A=
Link: https://github.com/openwrt/openwrt/commit/500dbaefd2a6a1c9c0d81e275a2=
8c6a8e26519e4=0A=
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>=0A=
Signed-off-by: Brandon Mahdavi <brandon.mahdavi@mahcom.com>=0A=
---=0A=
 drivers/net/dsa/qca/qca8k-8xxx.c   |  2 ++=0A=
 drivers/net/dsa/qca/qca8k-common.c | 40 ++++++++++++++++++++++++++++++=0A=
 drivers/net/dsa/qca/qca8k.h        |  6 +++++=0A=
 3 files changed, 48 insertions(+)=0A=
=0A=
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8=
xxx.c=0A=
index 4c928983b862..9dce23aaed76 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c=0A=
@@ -2040,6 +2040,8 @@ static const struct dsa_switch_ops qca8k_switch_ops =
=3D {=0A=
 	.port_fdb_add		=3D qca8k_port_fdb_add,=0A=
 	.port_fdb_del		=3D qca8k_port_fdb_del,=0A=
 	.port_fdb_dump		=3D qca8k_port_fdb_dump,=0A=
+	.lag_fdb_add		=3D qca8k_lag_fdb_add,=0A=
+	.lag_fdb_del		=3D qca8k_lag_fdb_del,=0A=
 	.port_mdb_add		=3D qca8k_port_mdb_add,=0A=
 	.port_mdb_del		=3D qca8k_port_mdb_del,=0A=
 	.port_mirror_add	=3D qca8k_port_mirror_add,=0A=
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k=
-common.c=0A=
index 13005f10edb7..5f0a875e5c87 100644=0A=
--- a/drivers/net/dsa/qca/qca8k-common.c=0A=
+++ b/drivers/net/dsa/qca/qca8k-common.c=0A=
@@ -868,6 +868,46 @@ int qca8k_port_fdb_dump(struct dsa_switch *ds, int por=
t,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static u8 qca8k_lag_port_mask(struct dsa_switch *ds,=0A=
+			      const struct dsa_lag *lag)=0A=
+{=0A=
+	struct dsa_port *dp;=0A=
+	u8 port_mask =3D 0;=0A=
+=0A=
+	dsa_lag_foreach_port(dp, ds->dst, lag)=0A=
+		if (dp->ds =3D=3D ds)=0A=
+			port_mask |=3D BIT(dp->index);=0A=
+=0A=
+	return port_mask;=0A=
+}=0A=
+=0A=
+int qca8k_lag_fdb_add(struct dsa_switch *ds, struct dsa_lag lag,=0A=
+		      const unsigned char *addr, u16 vid,=0A=
+		      struct dsa_db db)=0A=
+{=0A=
+	struct qca8k_priv *priv =3D ds->priv;=0A=
+	u8 port_mask;=0A=
+=0A=
+	port_mask =3D qca8k_lag_port_mask(ds, &lag);=0A=
+=0A=
+	return qca8k_port_fdb_insert(priv, addr, port_mask, vid);=0A=
+}=0A=
+=0A=
+int qca8k_lag_fdb_del(struct dsa_switch *ds, struct dsa_lag lag,=0A=
+		      const unsigned char *addr, u16 vid,=0A=
+		      struct dsa_db db)=0A=
+{=0A=
+	struct qca8k_priv *priv =3D ds->priv;=0A=
+	u8 port_mask;=0A=
+=0A=
+	if (!vid)=0A=
+		vid =3D QCA8K_PORT_VID_DEF;=0A=
+=0A=
+	port_mask =3D qca8k_lag_port_mask(ds, &lag);=0A=
+=0A=
+	return qca8k_fdb_del(priv, addr, port_mask, vid);=0A=
+}=0A=
+=0A=
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,=0A=
 		       const struct switchdev_obj_port_mdb *mdb,=0A=
 		       struct dsa_db db)=0A=
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h=0A=
index 956338893032..ab8ea261c0b9 100644=0A=
--- a/drivers/net/dsa/qca/qca8k.h=0A=
+++ b/drivers/net/dsa/qca/qca8k.h=0A=
@@ -561,6 +561,12 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port=
,=0A=
 		       struct dsa_db db);=0A=
 int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,=0A=
 			dsa_fdb_dump_cb_t *cb, void *data);=0A=
+int qca8k_lag_fdb_add(struct dsa_switch *ds, struct dsa_lag lag,=0A=
+		      const unsigned char *addr, u16 vid,=0A=
+		      struct dsa_db db);=0A=
+int qca8k_lag_fdb_del(struct dsa_switch *ds, struct dsa_lag lag,=0A=
+		      const unsigned char *addr, u16 vid,=0A=
+		      struct dsa_db db);=0A=
 =0A=
 /* Common MDB function */=0A=
 int qca8k_port_mdb_add(struct dsa_switch *ds, int port,=0A=
-- =0A=
2.43.0=0A=
=0A=
