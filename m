Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18789381C4;
	Sat, 10 Oct 2026 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617455; cv=fail; b=otvYlCWAlugFZKpFfKSwoU7E17hfe6gPlhUX5fQjvJNoM8buWV71Yzkc9fQbd4H5B+jwXiRYd/wP0+NTGT4ELHcytiX/TdXMUvOXKwqRBssk8CaDvF0A1iTZmf8k42twW/K6iBtMwNAzsIL8LRoo8h7O7M92bwvVLIy5Ygow0qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617455; c=relaxed/simple;
	bh=NQQLsshSZpTWdQ4HGFgeVNyerex0K+z+QMh4/wbX9FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aqg3gcy8qgqVSN87QLplV+0fFBMyOPPNX+2rv5D9NvtrhkGbfR/pWc9m+nG+5jmK76VCC9qupJFFxGxZdC1hLDaWjZRxauwwDyT4mktUphmnFmFvpE2gdbPCsVzleTJE+Re9TCulz0BUiooqazfe3y8JOt/wEd3gurI9uZQGxxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=EBDbxZAD; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="EBDbxZAD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYwTjgUE2VDWYl+TZ2iN5eIlTSS5yR3tbAiwS0iJeTrdk8aHEsKP5fr7OGLiwMxiPsYpWQiZjTsBzHc9CxIfZzTVnETCcc6idDYus/+csXgq/zaA38MSxvAMgFH/mMt1p0hasAE2sope91IH62Nq6caU9tmQzU4zaKawrOECZqIPtUY/bACTdY5M0yxwQbGSDx3m4oO2PxiZ9Y4bxUHqtctSqD0lKUS1VuILRoHIMeYE88iDWIySmgOqoRSErWSWiVOUERtuMM2GRsYcARwRbRKWyZQ7sI0ZA3dJAi7v+1kM6vz9R66nDPk0wFFUdmO/bT85q1GqpxChqdPEGzA35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M3joYhGgHVwJcE1yo9G2E9hTLrwIsdxdrHIKwe5938=;
 b=aUuzOitbUYvbhNrKMMcgVe1mSBr2ks6w0WhyUQm3NzEE514rT+UcXkIhCswHXs/pqtmMEODSROkJS4XiZcBm3V6BADFrWeHlJIAWWgdfWemp0FJGQ/kQe08RhXS03F89w+xEC4kiUdwlx0fFRpxd7FfSaOJObZ14t+wZZB15YqkHdnwFV/pBm3vWRAZm6Mabsmb5qWKQhtBBGSuOkH4YUFuC1SN9RlHUnDyPDVSKcMkIXIqqEVb3u7CXSQ4nqb5nX8On44p1QulwYVM8MaWDlwB05bCq2CxiWF3bN3UzurnJRnnUxDwGTRuk1kUT85ET3VL4G5aEBHBK4ARGFDn97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M3joYhGgHVwJcE1yo9G2E9hTLrwIsdxdrHIKwe5938=;
 b=EBDbxZADUGe5Y17RdM9eSdS+1EZqbGikS5vhGjmGQH4Kqw0xVgAQKI7psZ/yrxNT28eyHfPWeOB6MswyUneT6heO9vCqv7TOE2L5558pB3nPP2adk/dkBhxdl08fLfUewX4M/EghZbwoFEZbC3Rw0c41VQm2+8HX0vZncef5wAqPAxgsT6cy1Gs3C/uLxYmb2LMLrAmdcyIBbEiYuggEadByWnQj/d+XTgc4CfPvpFX7Ia6NbL2f/1AIB7phZMsRRvrG9HduPs1ZmGNtMG28AWLwdcoZRa1rZN07YFBUdTkKwd8ZvZpKEkpAC6sPncE+JIQ6uV54Bf1vEoP4hOsang==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB0777.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 07:30:50 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0496.017; Sat, 10 Oct 2026
 07:30:50 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Rob Herring <robh@kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Roland_Kov=E1cs?= <roland.kovacs@est.tech>,
	=?iso-8859-1?Q?David_Nystr=F6m?= <david.nystrom@est.tech>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
Thread-Topic: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
Thread-Index: AQHdTsdSZejWFg7FL0SFdqli66xuK7byoXEAgAPTeIA=
Date: Sat, 10 Oct 2026 07:30:50 +0000
Message-ID: <asnpHkvHsFy2dX-9@est-xps15>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
 <20260927212929.593366-2-kyle.swenson@est.tech>
 <20261007210454.GA281943-robh@kernel.org>
In-Reply-To: <20261007210454.GA281943-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB0777:EE_
x-ms-office365-filtering-correlation-id: e12ae4a3-7c34-486c-06e1-08df26a068c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|13003099007|3023799007;
x-microsoft-antispam-message-info:
 62c+P7YMj3aCLtBnJtYbeUznlEI5vFUqa7wOGlf6MndTEgKbTcTc5I8Y0Ye5OA8GgvAkRUntcs/mGrntDEg7zUkvgiqrX0cm7iQMZaFLpl/IAy5h8ZJB4PTRTSmGZh74h618Y2RNOqk/j0vSsoCxwi3NDyC09jwBj+zZd9yi5nYciOyWiNDmJZpIFWhtmybHpwAClv2zS2Yv0DbPqro2jOuhwH9FAxs9O0x2oz0TVlt5GS/vsyfFz1UP8XxuDMAFeZuwgT39xm6t+krEA7UMwRyNUQgcfcrjmJ2wO3xBfgzwHDPssK4D1I5YivPSbzKv5NpgrBpd8nDyEqvvZvL+wXZMox/Rlw69gXwCNIQBAL8h+yZvzoNKGwy7LxcCzqRYg7n+18YnpFSJaCDdtQTGiIlcxYYu7gVLLi15G0lAQcy5TqzqthN1Unixxd0uVx51EAOEnINI9Ogfm2ZWJyNa49JCSs1bF9k5zxGHUVTzfPnfYrf0T3nWPaEnaGF7h2LS2wu2COMGiVS51V5yEU8eYwmOJgcJ9nxvBEhi6cclNQmTQsv5eofRsyxz4Fruls1Me61M26JyCkmrJecW6M6hctjE7X/mFIuhLhG1L4g0SiCJw6yFsGeFzLXIBiZjWk1o3rTMkBiML6jpjI5vxDZeVY6EqgdXrMG9m2PNLaYNZx4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MwHqN+VZmSAM0vrmLnnKJt8675vYJIakXz/kUDwSiBFkF4qgqZmVNDmPYA?=
 =?iso-8859-1?Q?kFAjfASryMb5XPZMNCSzPmxpaA1Bbwb4uxTArhaR2sACNY1jy6n6fkhVgN?=
 =?iso-8859-1?Q?YDe7qfcSEQaDTbPzusssu8CZvSN28Uxx71bv4ym8nTPCzMxqdt1nghba/D?=
 =?iso-8859-1?Q?fnv06fSIRAnfLbFjUoKDVEsUFfwH8IDvEHM9Q/Nq0pDAMBH7WMargtNO9M?=
 =?iso-8859-1?Q?Y6d+8O8nIYYnDmYcVpplN07kmAgr6HRIX+/thhodkBcaMJroCEjVYN6tSx?=
 =?iso-8859-1?Q?lM5Xuo8wY2V9lCqLx6ORnexDTlIfeDxToPhWyPx2Z//iiStPK7RjzY7lNW?=
 =?iso-8859-1?Q?7n4s/3DDe4b8YDBrMkv7YbrpVXjCK8aFKeF2mPUxxp1KaDndACBStOP7k3?=
 =?iso-8859-1?Q?ioptwpr52xo2DXDEQlNjvDnCTDnB2h536aMK5g7WRpfH8BUIkL4j9sGEr2?=
 =?iso-8859-1?Q?SYZ6v4lF8kbYjbFwXCfU24py6WKIwU6xvM7Lnvid4/KAcE5WryylOOZ2de?=
 =?iso-8859-1?Q?bXjwjY4bm/eW0HhcWxMBjw9H6msJwTg/kOlQBoGI+7Tj2KJ5C8OxIrrW4R?=
 =?iso-8859-1?Q?11k7Y+nYL6uqZ/1wEIwofv/goPFgkUhGXD9NF340oD2gAToRJiHnQN1FH2?=
 =?iso-8859-1?Q?TlZmtclw3HEoUw8ID0zN223nzw552YBEMpOFW5c02oNyqhU8/kd8ui1DZX?=
 =?iso-8859-1?Q?P9ITe0Hk+6jG+4HyFmund9Nsw5qSm0y4Cb9a6RKfu5syWAMOC9ebNbI2GG?=
 =?iso-8859-1?Q?eDn6zl6osMY9yECOlQHmzdXXI/W90kJIEzVDAolTOzLX6ubyQl9uJn6dII?=
 =?iso-8859-1?Q?ALo8MOxklWOrzM7TI6tBgF9+mYgpCBVUliN3V7J8i6rBfQ9vHIm2qhHXCO?=
 =?iso-8859-1?Q?n/xiEbGiX9+rHyOy3pU+4kG4mV/BW8OjA7M4VxvdH1VHVcBexQImpf4Ad1?=
 =?iso-8859-1?Q?9I3soF8brUf6Q5qoydgjw58kVoxMv2qQzuO+4/QM3FgoAjJAPTe0uPVx7u?=
 =?iso-8859-1?Q?sCGYekJenjBQ35biz6e6zfyKwYhb8URwqjiDrBsVYlwayjDwWHtPiYKoej?=
 =?iso-8859-1?Q?F5lfboJckSoWZUUsD1ZbEunq6w+dPGop8Rk5WcKXOasO7BVnsEghkNfcb1?=
 =?iso-8859-1?Q?Nl9Y4oH8DLQvw52CVPUdSUtKK7L6JIppt2Jr+c1eHqGtTDyigyEPW+A5Br?=
 =?iso-8859-1?Q?xC8bBBg2kBViDyzaHAQhZuS9CrQKQmeVlcunsWv2GG88QsWnp0hXi+4ts4?=
 =?iso-8859-1?Q?oaU/E7F4dop1MRc+42dAqQ0yefsUsmSkNNVZMiYNjClWgdxCr/+lQB86vW?=
 =?iso-8859-1?Q?iQtQGYw5WvGxe0bXlg8MlwcgU+gpJmz3ob2bhiRX8Ujet3jl9xwwf1zxo0?=
 =?iso-8859-1?Q?Yt2O5BK1sVHl6f1FGOhdP0HQIT+KSmJba5wW/LMU6gHt4PZq5eqtUW7npc?=
 =?iso-8859-1?Q?hRRNGUIFHcJdz9CfLInDMg2eJVy7BS0IbeLNUHLasYUOV+wa+WaP0wEqLS?=
 =?iso-8859-1?Q?mPutQSos28xPDW9YNZzAbZGYj5ou9gAHBwy00KAhG9MTr2DvDeBPX55S5i?=
 =?iso-8859-1?Q?QAVso/R7DdAvR0ExzUMi9FfdEkXoajWyohfMRElj2DWpZCm8/dSXEsx9L/?=
 =?iso-8859-1?Q?eURxCEqmhvxBcnfOFA1xMME0Kz7ejwsIOmGiO38/SaLEMnA2h1YTXL2gmK?=
 =?iso-8859-1?Q?B3NETV8ps1H1cq635MlI7liX+wo1RrFyqSJTGk+7/gsuXnpvIGK+aX12aY?=
 =?iso-8859-1?Q?znrP3eZ8IEjcSFXvqCjQ87BsMz/kCHoEnwWBohgRGFxqyroOqpx/8o2Plt?=
 =?iso-8859-1?Q?ogHPDwZnmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7962ADC17FAE084DA89585FEA09B4B32@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ae4a3-7c34-486c-06e1-08df26a068c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 07:30:50.4041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7AwkyQ8JUYixgXKNpIZgEV80maNAG528jPqTNILpxDDwfERBPwLTDTi8tzhhyaKAYNU9EKxq8Am6pA4TISQAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0777

Hello Rob,

On Wed, Oct 07, 2026 at 04:04:54PM -0500, Rob Herring wrote:
> On Sun, Sep 27, 2026 at 09:29:48PM +0000, Kyle Swenson wrote:
> > Add the LTC4266 Power Sourcing Equipment controller device tree binding=
s
> > documentation.
> >=20
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > ---
> >  .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
> >  1 file changed, 180 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,l=
tc4266.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.=
yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> > new file mode 100644
> > index 000000000000..e11c9d601eee
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
> > +              for current measurement and for overcurrent detection. T=
he I_CUT
> > +              and I_LIM register encodings depend on which value is fi=
tted, so
> > +              a wrong value programs the wrong thresholds.
> > +            enum: [250000, 500000]
> > +
> > +        required:
> > +          - reg
> > +          - sense-resistor-micro-ohms
> > +
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
> > +        additionalProperties: true
>=20
> This cannot be true. That allows adding any property.
>=20

So my intent with the additionalProperties: true was to avoid
replicating the entire pse-pis node from pse-controller.yaml.
Conceptually, my goal was to inherit everything from the
pse-controller.yaml binding, except limit the maxItems to 1 (since the
LTC4266 only supports power over a single PI).

Is there a better way to express this?

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
>=20
> An empty node is valid? Needs 'required'.

I thought the 'required' comes from the pse-controller.yaml binding.
If I adjust the example dts in the binding with something like

           pse_pi2: pse-pi@2 {
-            reg =3D <2>;
-            #pse-cells =3D <0>;
-            pairset-names =3D "alternative-a";
-            pairsets =3D <&phys2>;
-            polarity-supported =3D "MDI";
-            vpwr-supply =3D <&vreg_pse>;
           };

Then make dt_binding_check will fail with=20

  DTEX    Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example=
.dts
  DTC [C] Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example=
.dtb
Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dts:83.33=
-84.17: Warning (unit_address_vs_reg): /example-0/i2c/ethernet-pse@2f/pse-p=
is/pse-pi@2: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dtb: ethe=
rnet-pse@2f (lltc,ltc4266): pse-pis:pse-pi@2: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yam=
l
Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dtb: ethe=
rnet-pse@2f (lltc,ltc4266): pse-pis:pse-pi@2: '#pse-cells' is a required pr=
operty
	from schema $id:
	http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml

But I'm probably missing something obvious, so please don't hesitate to
point it out or point me to docs.

>=20
> Rob

Thanks so much for the review!
Kyle=
