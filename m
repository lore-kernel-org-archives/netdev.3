Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10B31E84F;
	Mon, 24 Aug 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585296; cv=fail; b=d0uDeMHlf3YKu+6S6/jcy1SA6NrKhDgEQTAPcjOhPXJe5795pVnQDNr8L2GVkbtVwtJgsO9E3N7RNLhqgiTGGFdADAHIi8xyAAD+RXizszDyWcLPu5wq/jIGint5czR7VnKVhgDshMGkwdfRs77qJ0yYGyj1BLYWaZtJWBMENFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585296; c=relaxed/simple;
	bh=W3/TCqNCrma9YAl4WAK+9HqZ2RRZ7BItNdkmqT6KA7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TMcgONKGloPnMsj/azA1+q7lxrF+O/c3WF/fA05n98pZo8SNtPjsqpb0bKxHBcLhcMAZqr650dk+/h7ddOkKnu6QSjaROeDs0vJmbxHJV+9/0qKMt5WBPNLJvdfVPv31hW6oy1Gc4VZYnBdMFcrQGUQH44Ob+YzQmkWOCpQnD0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LI+DDEMk; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LI+DDEMk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJQzKESstpRVh/6eEarVQ3G6CaM3XG7sXlEg9ckcq6vVinxMBDC4W/A85wL2Z5hBPMMWEWC52oqrbOqF03BuXB2qGPDBlagSp2JubuhdTS4dvcvbMTNBpAXJg+KWFkzR1RMgU8ARpPBYDBNlEQw0EboDGSxWMesySTHLkcGvnaHFiaywQ77fG6E/Bq9J0BK0gLV/wkYHhK4tQ+C/H5eTwVs5Tb7iA7afuWhTWxiLmArHFzlmxbs0kXlYr33n4L02MfIkRtakDJ4RCa38qEemuJMZut2B9FkAW+a8CxTlADAEN3ojWzTdfIHAOKDAdl3HozFeMxlLXGz8HdEjL1hXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcXcrrvdcRTtKiKBIMknobDUj+GzimROGErO+jH4W3g=;
 b=dkE4KLIasV0Da5jlYe3OoG7Cy4N8yIahmz0WKCZLj3jgPpcQOn7M6ig/X6NkbwcOBoXNHy7puDHvtZPP49iZu9UFzCzFLBI1LCjXH/8BnTfCjfZMSnZTAR91SZ13hC4iQnC+bQwoTifEwZ4H/Rfmppy798EZNiCef4XeiERZHUa2KjpJrnCOKBDytVAwoRtVmvInAbi0x45XoW6m6wXFnuNyr6lpR5jAnb9gl9CwjEr6MdFAwKAbE2M76mmmsCfBxU6xL2Fvo8+ItOBAnT6itBfmLS0RtmvTjnepIy4S/T3hdkG5j1xfeIQj9Quog1sd0HplNZefooONz4GPtYXOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcXcrrvdcRTtKiKBIMknobDUj+GzimROGErO+jH4W3g=;
 b=LI+DDEMkfcogYm0qZY3xlqOML1rGHeWnIPRUSXJOqrTwY5Oihk3peJPIp6Wat3z2OVkKTk4y0A/Afz1AOz/CYTSysqRi9iJba38HvOntf0O71qr38G1Jqsz2vFH876T/Hrj/2WF2B1jlsZ31Y0kWUzzk3mMFbcW21gSvWvROIhrqLM73L7SxdTi7eXIHpTpB27u4d9XG1EZ26EAevk1Iy0VYs+2bpIih++SFLRP/Qq3UL3bWaaYrUAvIpPDo1F91AdzsyzWUYTcEk30tvr8HRHOe3xC7A3ZqJJIYqa7CLfx8BINL/LrbdxbaRBuM9+Fv5Rl5F0X/Qs8iloMSlrhL3A==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PA2P189MB2730.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:414::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 15:28:08 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 15:28:08 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Roland_Kov=E1cs?= <roland.kovacs@est.tech>,
	=?iso-8859-1?Q?David_Nystr=F6m?= <david.nystrom@est.tech>
Subject: Re: [RFC PATCH net-next v2 1/2] dt-bindings: net: pse-pd: Add
 bindings for LTC4266 PSE Controller
Thread-Topic: [RFC PATCH net-next v2 1/2] dt-bindings: net: pse-pd: Add
 bindings for LTC4266 PSE Controller
Thread-Index: AQHdMK/H4sHRpwAA2kaN6PafYQKwZbatCkqAgABOowA=
Date: Mon, 24 Aug 2026 15:28:08 +0000
Message-ID: <aoxi_jERN69gqnx1@p620>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
 <20260820142429.2285172-2-kyle.swenson@est.tech>
 <4b16ca01-a09c-49bd-8c3e-ffa9921a0823@bootlin.com>
In-Reply-To: <4b16ca01-a09c-49bd-8c3e-ffa9921a0823@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PA2P189MB2730:EE_
x-ms-office365-filtering-correlation-id: 55f51336-81e8-44fe-6950-08df01f44cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 PN762UP69fdlNcYgCJOPMn+/RYVaq/CO3DuJx+uA/U9ANjmqDXTJy/Qno1ddsx+u9w+0JSoMlFI8hBipUXqW/S6oXQkfOgTX6BbYMHjJOwQP1Gur6g2St7AG6Tupn/FIn8urJVO7OI8pEbxPz2V5NX8jqwj1gU+cewMKXAHaEEUfyzJJ15ptrLEe8XsAj5Z684IbGCraNrfDN6ciYR/DkGQ+caB93GbbrNNSq9PmBPTWoTArLrGIQ9RYMWrASXeoEHDuGwjYQ3WNRJXglqHbSof1zgkGRtoK+lWXKtd3ZGq0jwdQSfswkC1WQrj79SlnIKYqQk9k/K8hNgezxoxb53kMEDt9+sC6xIZUCaLqX0NezyFLvSd5SPBizcCOy6IeASLjM+1EKviCgQRDrUigLK9JUai7INQXN+80yDDL/rjeXJQAglIh5iwTKTPUmF6fThSshl64CCTlf97d8//kbMgS3doU9opi0kRSCnkPwYdOViHGXfVeLj4kcGzRjmSIbgr62doxGs/1/nEHbgxdXGK+PoFhsPtvL8OENBUgolVQ8bXBRBSqI7SNd5iB9T4OSn31UM3KQWslkm3RHgkD4U8n1zRLFebyg6R/oqEUllsGtvAuJ8ehGUn73wQg38/HfipaUX64BeoBvLlkLWFxecevHg4BxMXBQuaxvzZBr+k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ctsDzXOUNGn4D5LhSgbx6U4Mqkd2nwGL5Fwkxh+ZpIpgtiE78KK6FE9VGw?=
 =?iso-8859-1?Q?Z/OfL5bho5z0FYSCMidcYFrzFfwi1PO0jUxCfxRhraoowN+J1v4fwt9K4t?=
 =?iso-8859-1?Q?aGH5rAX8gsCheg0fgy1cfjAjlQG8wrqtDZVQZP4sTaxDP1QYR3uf/WLF4I?=
 =?iso-8859-1?Q?VxvHR3e30K5mVZfWjvCOHxWsbIVW3vEb7H5gizOTit55kmdiTuUtzsUc4E?=
 =?iso-8859-1?Q?R+zauwwZ/7A5SA1CHy71BjQOWHitE442oxW1iqrb2wFdbmge88LhoU7lxr?=
 =?iso-8859-1?Q?zyrjygNaJHZnjDHtB2vAgmYnFt6Vvx+IDj4cPwqVnRcFJBK2OV6hvOY6Qh?=
 =?iso-8859-1?Q?dywhi0G31ZAZXssWDjLDfYikTJ8SSRUNe19j/cGn1pZCNNOQ581FN4cO1Z?=
 =?iso-8859-1?Q?KMWn+SCgE0zwMS2IvBuhcneuZxBr6JYHP4zJdlYZ/VzlNdGCADHk98tc6G?=
 =?iso-8859-1?Q?U1atSCi8pECdmaiXlACcENUY12zc/y+ZZYLYorThQj2o1bnNlDJuit/ySJ?=
 =?iso-8859-1?Q?D494J3UoaOhXoTwnbEo3y1mGQBPyy0SPuHjB71/YC75pzcYxJ/Y1KuAV+P?=
 =?iso-8859-1?Q?L/kBJRKEBETi5NpG/hHYUkcHUBZofCxmWx9rnHu3CQuutxkZpdfFPbW+BZ?=
 =?iso-8859-1?Q?aFtAGdyQbPz+vOzu7rc2FXa8Jtqu/nub+qA4XYGwvb92Nhr2/0VM8uSHsz?=
 =?iso-8859-1?Q?4NmjZPqTyuBeUhSSh0wc73aN+v1YNbBnuB2WmObreNmj2eeWUekVvVhEtB?=
 =?iso-8859-1?Q?UGfXtGqLGMlitlNRkesSM1E2PJgogxMREqBieEJ9fgUiRfWKRregnHIdzX?=
 =?iso-8859-1?Q?PH9JW+5m+cEfOLxbP1wMl0uaR8q3u+E3f0yNyNLcGFs3SzcqsGUXGsNhlu?=
 =?iso-8859-1?Q?j5CjWob0EnmPWLT19s39tlfzEn5LShlgaLof8qqIlYD3Oj4+W2yZ1bQ/dL?=
 =?iso-8859-1?Q?ZjquH3iqVjGUK5tuywVpdvM1x6pVqTnRZupJkToyV/GMEmUdsfJKgmQR6x?=
 =?iso-8859-1?Q?GMd3PZJW/5isTCCabmJnA9p2QIUNxY/c6e8n+j/GjHgvrrL3+GhBG0XUt+?=
 =?iso-8859-1?Q?Q2MsrplGfISs/Jro2X706pEzLB3ODxU8IZ5ihpc+eyXituvU+H0iylaD/k?=
 =?iso-8859-1?Q?1fyXvuo/URXuBHnPpIQI8UfCq9cMfwQP8OKOn4R8K4exs5oa5VCO+4eyDQ?=
 =?iso-8859-1?Q?OEDxVWbzewFpnd92uvJ9VNJL8DUUKNq44B2Ni/ndC2YcvcKMs4uV+gQUoI?=
 =?iso-8859-1?Q?HQ+mgRjnZkjO8eI/srRHExvUn7iUBF004bHCS/qsfXO0uLiK5GxWp27qXB?=
 =?iso-8859-1?Q?+tciMJWXF/stULwdk4LRJ+cKr1zsESUdw6N9vIsKdfvq4k8l1YZXdCtbZ+?=
 =?iso-8859-1?Q?W1xlwP/iRBcDMovp4o84Ci5wxUXYENb39QdDKrlsx1oCT9kk7Oq5HyAtga?=
 =?iso-8859-1?Q?iTt8hqMTeHr6U98ce7qnT+waiSO/UIH8C4VzSONuLyj1mN0C4Hr5sGNwoW?=
 =?iso-8859-1?Q?8sz4yXnbZ9dFiyyMK0s7ws3MNTgOHXQivuxDkq6xsrJ7IKyrz9yLxG9HvU?=
 =?iso-8859-1?Q?ToIes+NUjH9zTka3onuzdTRK3zDYEl65VQd5qaRN8GBR2NsIVuvw4D/tm8?=
 =?iso-8859-1?Q?LKN9P1xtUve7DCnk5aK4L7bjF3XXLOtMqmJ4o5viHORol3P7QXHvewNvse?=
 =?iso-8859-1?Q?9hHefgUIQx07Sw0HR+q72fO3TVW6niK06RugE6uOpQGx7MOu0KJLCiNi3h?=
 =?iso-8859-1?Q?PAN+3+OXfeIAtlYLte34Msu9ZAcHteRJqqZcJRkcfwbcr7d0jUOroZ14Gg?=
 =?iso-8859-1?Q?0JCDIZaxPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3BCBB2A3C5CAFF43A638A5CFBCE46934@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f51336-81e8-44fe-6950-08df01f44cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 15:28:08.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Kzo0pWwnaJRJgPKQH+RLjF+kgVOmjo1QOD+Hly0SJq+JpDyqx4fX1u8QkZLx9tmm8xA5q7uUCPwBe4q76N68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2730

Hello Kory,

On Mon, Aug 24, 2026 at 12:46:35PM +0200, Kory Maincent wrote:
> Hello Kyle,
>=20
> Glad to see the v2 landing in the mailing list.
Sure has taken a while, but finally here....

>=20
> On 8/20/26 16:25, Kyle Swenson wrote:
> > Add the LTC4266 Power Sourcing Equipment controller device tree binding=
s
> > documentation.
> >=20
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > ---
> >   .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 +++++++++++++++++=
+
> >   1 file changed, 180 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,=
ltc4266.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.=
yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > new file mode 100644
> > index 000000000000..b3da8fea0b07
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > @@ -0,0 +1,180 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Linear Technology LTC4266 Power Sourcing Equipment controller
> > +
> > +maintainers:
> > +  - Kyle Swenson <kyle.swenson@est.tech>
> > +
> > +allOf:
> > +  - $ref: pse-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lltc,ltc4266
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
>=20
> The reset-gpios is currently not implemented in your driver. Maybe add it=
 in
> the binding when it will be the case.

I was trying to follow the "bindings document hardware" model but I've
no problem dropping it in future versions.  I would have added the
reset-gpios support in the driver, but the hardware I've got with the
LTC4266 has the LTC4266 reset connected to the board level reset and so
I can't test this functionality if I were to add it.

>=20
> > +  channels:
> > +    type: object
> > +    additionalProperties: false
> > +    description:
> > +      Defines the 4 physical delivery channels on the controller that =
can be
> > +      referenced by PSE PIs through their "pairsets" property. The act=
ual port
> > +      matrix mapping is created when PSE PIs reference these channels =
in their
> > +      pairsets.
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      '^channel@[0-3]$':
> > +        type: object
> > +        additionalProperties: false
> > +
> > +        properties:
> > +          reg:
> > +            maxItems: 1
> > +
> > +          sense-resistor-micro-ohms:
> > +            description: Sense resistor connected to the channel's MOS=
FET, used
> > +              for current measurement for overcurrent detection.
> > +            enum: [250000, 500000]
> > +
> > +        required:
> > +          - reg
> > +          - sense-resistor-micro-ohms
>=20
> I am bit skeptical about having sense-resistor-micro-ohms as a mandatory
> parameter. As you have described it's only for current measurement so it'=
s
> not a requirement for PSE functioning. Maybe set it as a default value if
> not specified.
Well, on the LTC4266, the chipset depends on this current measurement to
enforce per-class current limits, which is required for power budgeting.
Maybe it'd be good for me to expclitly state that instead.

>=20
> Else LGTM.
Ack.
>=20
> > +    required:
> > +      - '#address-cells'
> > +      - '#size-cells'
> > +
> > +  pse-pis:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      '^pse-pi@[0-3]$':
> > +        type: object
> > +        properties:
> > +          pairsets:
> > +            description: The LTC4266 delivers power to a PI over a sin=
gle
> > +              pairset, driven by one of the controller's four channels=
. There
> > +              is no 4-pair mode spreading a PI over two channels, so e=
xactly
> > +              one channel phandle is expected.
> > +            maxItems: 1
> > +          pairset-names:
> > +            maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - channels
> > +  - pse-pis
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      ethernet-pse@2f {
> > +        compatible =3D "lltc,ltc4266";
> > +        reg =3D <0x2f>;
> > +        interrupts =3D <8 IRQ_TYPE_LEVEL_LOW>;
> > +        interrupt-parent =3D <&gpio>;
> > +
> > +        channels {
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +
> > +          phys0: channel@0 {
> > +            reg =3D <0>;
> > +            sense-resistor-micro-ohms =3D <500000>;
> > +          };
> > +
> > +          phys1: channel@1 {
> > +            reg =3D <1>;
> > +            sense-resistor-micro-ohms =3D <500000>;
> > +          };
> > +
> > +          phys2: channel@2 {
> > +            reg =3D <2>;
> > +            sense-resistor-micro-ohms =3D <500000>;
> > +          };
> > +
> > +          phys3: channel@3 {
> > +            reg =3D <3>;
> > +            sense-resistor-micro-ohms =3D <500000>;
> > +          };
> > +        };
> > +
> > +        pse-pis {
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +
> > +          pse_pi0: pse-pi@0 {
> > +            reg =3D <0>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a";
> > +            pairsets =3D <&phys0>;
> > +            polarity-supported =3D "MDI";
> > +            vpwr-supply =3D <&vreg_pse>;
> > +          };
> > +
> > +          pse_pi1: pse-pi@1 {
> > +            reg =3D <1>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a";
> > +            pairsets =3D <&phys1>;
> > +            polarity-supported =3D "MDI";
> > +            vpwr-supply =3D <&vreg_pse>;
> > +          };
> > +
> > +          pse_pi2: pse-pi@2 {
> > +            reg =3D <2>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a";
> > +            pairsets =3D <&phys2>;
> > +            polarity-supported =3D "MDI";
> > +            vpwr-supply =3D <&vreg_pse>;
> > +          };
> > +
> > +          pse_pi3: pse-pi@3 {
> > +            reg =3D <3>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a";
> > +            pairsets =3D <&phys3>;
> > +            polarity-supported =3D "MDI";
> > +            vpwr-supply =3D <&vreg_pse>;
> > +          };
> > +        };
> > +      };
> > +    };
>=20
> --=20
> K=F6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>=20
Thanks for the review!

Thanks,
Kyle=
