Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E33F4DF3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741777; cv=fail; b=TdngVTvoJMw6s4KXMLOk7NsvhWThAxX+f1E2ALU/tcRfgETIM7tXNNvdT3aE4C72YUCm/pWQPOLsp5DA+4TYjoHmlPzjUO1/hr6J9HxdVI/dHk7QIqe0XIFY94wmT0qEWCOLnJcRLoSVM7u1Zqh8UmhqOvIbg9uN8ekXh81JkIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741777; c=relaxed/simple;
	bh=RuRkvK6TON8U40xp2Jb1aWmuWGnKpCiIpVnFn7Lc1sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrJ3gvuTbCtqyJganZVM5aJAq3dQ3MgpIPNH9Of8S1vrwq+Vd/mdiecCXVuaBSS08mUh3uM2aFUks+8bRTeCLNv3qWN623n8myUhb2ufbQOpB1Vza2agegbDtGZWlx/3sL+tfjYKmAeWEDIo1a0plr9bDHjhvG08erZz8IC4OLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NitLHaT3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NitLHaT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784741777; x=1816277777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RuRkvK6TON8U40xp2Jb1aWmuWGnKpCiIpVnFn7Lc1sY=;
  b=NitLHaT3oQI84/bvQXFlVRXPLQLtFVhjI6Fp+XndkanY3xTVuWIFGse1
   3g2llOBrhsjoBuxxwDEKj9VJ2MT0yCX/D1WKC9+U3PC1RwesO1h7VQwmz
   3ooa4MOVK7Nrp+EE0vWLeqd3lCfTHI2G+np8zku4jMpsUYx/7intcVx1S
   0WqmeCoMxksVTAPn5/5iHr4UPXnltwWck1j2YNB/yo0wCKAD/ywRHOjuG
   5Wbn0ds5W6k0kWazQXM1+gBGw67uVv/TLJ35jNJd2Ibp3+5Uj3ffNyJfm
   ALCWAFqR9froN/hsRopeaiJwcqq5IGxKkcSBL/wSEo5GFWBuDaxBEACEK
   g==;
X-CSE-ConnectionGUID: hdC42xCmSY6Hp+QCTmYtbw==
X-CSE-MsgGUID: nekV/nPQRsmhG9bhQCQMYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85239882"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85239882"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:36:16 -0700
X-CSE-ConnectionGUID: Ns2tI89mSA2JfNQAPBkxmQ==
X-CSE-MsgGUID: q+kRcTI9Q+uwl3/+eO52aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="251848003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 10:36:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:36:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 10:36:15 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 10:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY8in90JEysCkm6G/zqJ29bxi9njtXvY+JI4/L0EJ+ZLTmLlSTaY4KikTea2DVxW7RiwjZu6FcCsn5de1MSU+ZK6tTHLbPEde1w4SwjHvfEvjOpQ7b2GRch+limuDMpKXIOnDoPqkvyPqupbfzqvxqbDTMVL0JHe2Kqw+Bx2kWQKAuzImreJBw+sW9aRT3d0ueldzASJFFj6MDVIuAnmCDK8wJfxgAPfuP1CLEKh+SFyiKlpoU2zFUwr8yNDmIQcbjMg8Zmr28ULOuKW9pD8eJ1yY7s62hR9ofbX5YXbUQUwSe6HYeWbZNRA5LiwBu2qIJ5nqn2cYMWY3q+0q9L9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuRkvK6TON8U40xp2Jb1aWmuWGnKpCiIpVnFn7Lc1sY=;
 b=jKIL2F8sblCt2td0Ppjmf1ViCLoYcBG0uXHM0+NGUFc3CWw17FXI8Q0OrpgxcE9iKWQC9GdENhID9c5ZBu4fH0RSNFUqCv2bq8GGlb8FOXkEC9MT9q4lfqYxXsQ8MJFen6qiOy6dmpMZ1VnlmZJAF2ayj5cnvi/nNBoRJW1/+49+EcTtXqvRZX1I4wZPo+9b1l6gbSi/X+pzBIB2PFH7yihZm2Kg1ftatwWeMowVEJdowCtBH9/n5z3JeBeWLC2Eh4Aiyi98wa+o18nCz5rJZhCKHFhElK9s9Cr1gCLst2dz2AbzXLDr0GrWpDaPofhxYs9L2cAA312Nxz+CBXqk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:36:09 +0000
Received: from BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440]) by BL3PR11MB6385.namprd11.prod.outlook.com
 ([fe80::a731:24a9:6c0f:2440%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:36:09 +0000
From: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "D H, Siddaraju" <siddaraju.dh@intel.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, David Laight <david.laight.linux@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccwACn/MAAA/6EgAABI/OgAB9dWZAADCGeIABZfngqgABXDYAAABB1MoAHFvhAAAJXdzP
Date: Wed, 22 Jul 2026 17:36:08 +0000
Message-ID: <BL3PR11MB63853AC8E50396A1B95E127988C12@BL3PR11MB6385.namprd11.prod.outlook.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
 <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
 <DS0PR11MB6397D3B945CFF9FA501AC6F688C22@DS0PR11MB6397.namprd11.prod.outlook.com>
 <a70dc967-6656-4eef-beea-d1894e983fde@lunn.ch>
 <BL3PR11MB63856413FCFB7F30D30E469688C22@BL3PR11MB6385.namprd11.prod.outlook.com>
 <e1d14d88-dbe4-4e15-b794-6277f9df7e6d@lunn.ch>
In-Reply-To: <e1d14d88-dbe4-4e15-b794-6277f9df7e6d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6385:EE_|LV3PR11MB8601:EE_
x-ms-office365-filtering-correlation-id: 5290d595-8c87-40f1-3961-08dee817b764
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: mH2xue/9bswFfwTUozQRWNtTOfZPeCLrwkC6wIxhq+f9VQ+jt7fSLdg/8pCB5vC72FjS7kyRcG/QZ2Sft9vLh7VEbr/GOzCEQ0uYLyQFslMGYW3MoagX5sQwA+DweeDRfGseVoKY7dZ26XU4l381W+6kSH4fmkAW+PK3ntLrTuNuXJhUokqbHNlRG+TNGQJOAo25DYRmlRw/zMG5CsXdBMamtmKp7J+RGCwjZLdUwqDOu5wpx+fPtdc9RrkizuKnlYiTLHym4EzwJUsnDoRsvTFjw4qpTT/bFW32T9fmYxr50wpFUdJc9SZ+pOdNCloKC5Nl/+VbLqqvZ9Rj0JTInH0VOPHU3BdYdp6LaQZgsgurp9iNmSFY/HWBErEzuANSGSoRQtLq3OufaOtPvtKyPlz63GWLEuo5/A6QxkNnYDw8MPArVWPsH/zwfibYsSMAHMtmzJaARxbW/2uhlgl99e+AfkHAAaR01rAivz60taxjm+FFVKDGCo3uHKbwPY8M1nWgvVZgUm4cpkeDBBbpuBuXALqTi3zxM14vb+6RC4PRMioqJzupleyfiRn2O63nZMlGXIYR8JbYI7t7vMDzibPtcqtGQV1zBxN0G/op4wYG1QDxXD5AFmv8jgCy8KYGJByPJNCr04UiZ70CVL5i8cEDpu4pbWAg9tn8wNXhbJmWGIXznk0f4AcFBX7hjP9u4AyVtBLc3jlYmUB66h/egqow+2axyLzRB+GCWdsOjWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6385.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WLsIPLA6V3Yd6oqHwYKCdGWvlG7DJj7fQpPNYmRdC+Tuqsu6qBYTuYzP2D?=
 =?iso-8859-1?Q?pP6g48a19nGhm2GooNSB8SXA5kGXaFNU4DfiHrqAJ7QPswh2Spi2UL9AKE?=
 =?iso-8859-1?Q?lNkPczrgXH911LCWHoGUogROlXjbZylApyWIvWKeP2TYML1fuUe+9vAE4c?=
 =?iso-8859-1?Q?dxXsFjQeDA9MByHpk6Kw+LdJZwyoG8XsNCslbSv9woJJW9W4j39gZJl4tP?=
 =?iso-8859-1?Q?DytPjnhD1s48V3kcU/8msHwBDRdF7sqYJSK+3tv95MAWuHYVTPeeo1d7f7?=
 =?iso-8859-1?Q?WTkVTD5pAI65A9gp9r6ahxHaqTH6udOLIAK0mLAJPcMiSs3dXBMdLRx7x4?=
 =?iso-8859-1?Q?0BaZ8TIEIRiKJuJLqDmQzSfoG4CEYELVkiR9tn7dcNohUZAV00iqUPLSKG?=
 =?iso-8859-1?Q?bQqqpN7e+wIIL6ou7yL6BDW6yHF/G3gYDw9t8+ZfI0KCth/CT9iDpfn4JZ?=
 =?iso-8859-1?Q?Rxwo/HdYjzfLdKXF+gOUNhJCftqDWXCjWc6hAroX1h6nXro+1x8QcYP2in?=
 =?iso-8859-1?Q?l3g314yu3BvNZ89odnuh/XCtMRrg9mOyAxZDSj9Udn+PHSoSUaR87wdLRh?=
 =?iso-8859-1?Q?AILkbqyir3kDTb/JIdpEe+3m462D6bw+DFec1Pr/ONu/cHCymF/S6XsdHF?=
 =?iso-8859-1?Q?fb7/g0Ns8lSv54r0lsHRT2yDWRbdjjc5vJ++FglJ2q1JzyYV7qLqtfsZaN?=
 =?iso-8859-1?Q?r3MNQhVQmI5Cbmh2sm6ICEIGaepYuTMOBmQ8UD4HhLahzpbf1o7qCAI5JC?=
 =?iso-8859-1?Q?/MKutCPy0yJ7nVrhEkXH3koUP7rSWoOsQHELPDry4VdR+J+My0FmG/qyvN?=
 =?iso-8859-1?Q?Py+dWxvYJnxVDaWHmlBg9LfkbYxnAkkm69gicjXH3nLqSj4LqbTHa908JV?=
 =?iso-8859-1?Q?bnoqbZLHlNQEO97IbLMJsnpXc3PLr/h/lZJJ/2lkRw6Q06PglFL7k7A6r1?=
 =?iso-8859-1?Q?Row5eCTCmqKdDRagDY5wo2kYs6o25jh38EkLGzg9Wo5w4MErtvRjrNBg11?=
 =?iso-8859-1?Q?TxBKZyo2RgrKoJIo7C5wGLVa2wrFyweC1gR06V8XZdX5tkZd8r1ihbTNPp?=
 =?iso-8859-1?Q?DbL06Pjlk+JpkQEHPHV51GmKGUX3XUsNLzkXrEfuW5doITca+jkTjPj9Ie?=
 =?iso-8859-1?Q?icVpZ0ZtDB8uvQD6dvmXKEj2HG+HB6q4cAYLb6ZMy3PmAABEX/ai6NE8l0?=
 =?iso-8859-1?Q?YtlweEZnaV/giQZEt4fwUI3vQ2JPTVrtCuQbeVzwtBXbQEz7hkDCbWODi5?=
 =?iso-8859-1?Q?WqU0zSXFL5JukXwo/4xkZ1ZOVfxcVGDmzQDeAfffiIdzT18UD71nSc3uF4?=
 =?iso-8859-1?Q?aQ+4jIiTNJTvPE1qTGTUIhB8giyf5iZGToPux8Ksl/UGHktTCF5Sx6as7L?=
 =?iso-8859-1?Q?mbFjD1VKGhvZnnAfz7ikfcWDEtMdWdPk3AQGhaD8c22wMIC3DioL/dLZ/+?=
 =?iso-8859-1?Q?ShlkQ0Ks/P7Fchlgb8HPRefzJhAxY9z43WQwbG8xgXahg57UtOgq/6I5CE?=
 =?iso-8859-1?Q?bnNa6UUx2sLxGaxUw7dIg+yalCowymhGf9YzWBkBW96ASCfKc191fcaouj?=
 =?iso-8859-1?Q?+bKcJuL2XPM9IJLFTDQjiVWAiQiSF9aG0Gng+lony3aseA36uBMhw9Rd5+?=
 =?iso-8859-1?Q?nrDSUVVokufLEAK4fKqFNxi4E9DGUxaLJ8pe+gu278+9YAdSDRvH/jjVPc?=
 =?iso-8859-1?Q?sKjSkq5BPkv6ra/shRsQLTBFWI6w+Alv8SySBCHVXNddT5Jisd8nBdElyW?=
 =?iso-8859-1?Q?iNkBidmszxeVa+xyzngcVWLpdAgtLSGZxjVfF9nj7xtEpKtqf9UCL9dkbY?=
 =?iso-8859-1?Q?EdgsugrxLA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AgVDBx1IlzFkVa4V6oWPoZAFyvHnPv7HDJ8Z1jP8TBR0SISgXukcWtQ9YAORxYDThdJsV5ORIaX3RmkI0lOV+9kfsjfSbmZrVHvOND7zmtgl6dESzKLWi4NA5OyTpzDSsxuJ34ZZyuP3x5bkVIxcqbY7Th5GnH6CJZdtnItrV3Z259xFEITk5aUfzkLlPOj+4sHcJME81jvNv67FuLDBM8Dqmexy95UD+jIx4ojjYZ8RHt3hcCY5yvTw8oDeiuBLJ37vm1M9qWnGLvm677IpWXike/HpcIgwaOyZJrkYCUtZdl9ehIQ8qqyNMnz+48S0s046ycXKCYUYoFn/C+GQqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6385.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5290d595-8c87-40f1-3961-08dee817b764
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:36:08.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PN4Yxr3eRRmuczFgirwfn1U0c0AsPIxm15COSmSCe0ucp0pQ7vIf1LppdG2rJl+yl166sIrbzsQPbVRmJH/SYyJvvJnZXgOxbsFwUqjjgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

> > As for your comment/question about FW vs linux controiling the HW, the =
intent here=0A=
> > is to use linux to tell FW where to go based on user input.=0A=
> > How the link is eventually achieved is all in FW.=A0 =0A=
> =0A=
> > I don't see how that works. ethtool has no APIs around=0A=
> > phy_interface_t.=A0 All ethtool offers is link modes. How do you see=0A=
> > this working?=0A=
> =0A=
> Correct me if I am wrong but isn't that the role of the driver?=A0 =0A=
> I expect device driver to translate Ethtool link mode argument and pass i=
t to =0A=
> FW via driver-FW handshake (device specific SET/GET functions). =0A=
> MAC and PHY config. which includes phy_interface_t for that specific link=
 speed =0A=
> is then implicitly handled by FW. No other intervention from user should =
be =0A=
> required.=0A=
=0A=
> It is. But if the driver is talking to firmware, it is using whatever=0A=
> proprietary values defined by the firmware.=0A=
=0A=
> It only makes sense to use phy_interface_t for communication between=0A=
> different Linux components, or uAPI and a Linux component.=0A=
=0A=
To be precise, what I meant by FW will handle phy_interface_t implicitly is=
 that the=0A=
*MII selection (from long list I included in a prior post) is automatically=
 done by =0A=
device FW and not via Linux components or APIs. This step of *MII selection=
 or=0A=
configuration may have been handled by Linux components historically (legac=
y =0A=
implementations) but it is no longer the case with device FW capabilities t=
o manage=0A=
link we have today (as someone alluded to in a prior post this being the ca=
se=0A=
even at the onset of 10G era >20 years ago). =0A=
=0A=
Vijay=0A=
=0A=
=0A=
