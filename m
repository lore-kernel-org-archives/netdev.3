Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020085.outbound.protection.outlook.com [52.101.167.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076033537FF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959816; cv=fail; b=LbNKMagEziEKHbp6AzRO9OcRUgfqjlwbQz0MfgVtXFR/uYA30cs64fllEGJzveGMadz6nFljlBU/G5Vt3YVcTYtcG9CbGoUcyO92z5kmKasYPathpDi5HVxL4OPcQ2Gw4562c0ITBZYIpapqKzvUW9y7MBR878f398Dw32+kOps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959816; c=relaxed/simple;
	bh=8d/5pOT7APl+v2ILyy8IHWT73fqB8QfS4GVePJVjfWE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PpEJZ1TZA0F+yYeX2Ak+e8EMuOR9mlPHEmp+XQVwEL/OT4lrsH8Xfsdl66PM2TDpjm2gZGM64ZfmKjetQ9oita8d57HErJY92dfa+kWbOWQEUNUkNB3MI6X+ITDOHJ5snuWbEBZ+MeYvZGRVj+OC5AJHgJKJpALF/kMP+odiEp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com; spf=pass smtp.mailfrom=ateme.com; dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b=LZyWS7ba; arc=fail smtp.client-ip=52.101.167.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ateme.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b="LZyWS7ba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvKlpVAYBAtdsKP34u2+CJz4Qje4F+NrgG2KyQh50QdNXG14pL5sS2vQ4ixmRIuc0QHJZ9OEyMqjugoSrHlxoYKtEgsrH40PmwupZ+B3Ol1pQBk73QceUB5yIT0qzlKjD4BlDqghKuTYs3XVMiEz6VqibPfD2POeFz+T9K2A9NylAREy/CAOhtY3cHwLENbKo/dBo5WPjVLHjWvvEdlDcpSGB3CRm08lbSKLJ08D8VemqC5RbIXg0jQIwzomu+H5b5bgyOUCGfw6uc9qKmC3cbRz9iEyXqZhGN0Fs8nOAu4ZoXsITzJ5lHGEkV+laFSSrQ0oM4NI5swP573gWQpxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc8/lmJQeSRq9sukvRDVygyrIpsF/RqkOzX5orDE2To=;
 b=rRQUUbluwkNOcja1ulBO5omz4Gvr/UABrqyV7mV7MHuR2nkw63/0+JefT9C2Z0tkFtKstcLBL7SP+TB0okwA3XSq/8xlav+D/sCbZVcJWayyqQzmDi0YIuXX1lzqdrwCPDXrDqrPJpGCD9QXDEXEKzUcuGU3cLP/fZJn/N6j0GMKX927v9MxhkN5aOtfy7O9/yyLN05hShFMaQ1gExMpMf2E4vppiZzrT6Pm6mP0H+rh+/sghP6zrsvPn9mWZuiEWaON/sMweMwypxbSR8kzljsejevqCtaBxXjpoF1Gv2SBs4ikHJfiKB0aeVSp4XtNGU/vTpoWSOWTZrldhXSx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ateme.com; dmarc=pass action=none header.from=ateme.com;
 dkim=pass header.d=ateme.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ateme.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc8/lmJQeSRq9sukvRDVygyrIpsF/RqkOzX5orDE2To=;
 b=LZyWS7baQ8neuA7oxesCSa7VmLz1fmNbQsY9t9FmPPdN2B4vv4SsdQUezArVOVM/q943vQROOberRU5tQ1aozN15e3patGSggWIBuaiK/UoFqBwGu2QSPFmmRe29dELYoCnSDf4LvHyzjM1wi+jpSkwdSYxbzgHoA792dpHQlVeV1fALIZZ5d9IeY2i43gm8TkNN9AUtzW8HQn2iD0j9TBO2QRwzq4zNaj2Y1wjt0nbVYHCmWMwihT12pkMydluQQKJvCULTFqeEhy+tfPCLvWZf6jp1pTy3TLu0L6+8mGNnNHyNaRsMedAyFBDKW1OwKy9R9ThdC5HrbNBpjBp0cg==
Received: from PATP264MB7825.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:58e::5)
 by MR0P264MB6888.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:50:07 +0000
Received: from PATP264MB7825.FRAP264.PROD.OUTLOOK.COM
 ([fe80::823c:6758:f014:f6d5]) by PATP264MB7825.FRAP264.PROD.OUTLOOK.COM
 ([fe80::823c:6758:f014:f6d5%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 16:50:07 +0000
From: Christophe Burdinat <c.burdinat@ateme.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [BUG] net/sched: netem: delay correlation has no effect
Thread-Topic: [BUG] net/sched: netem: delay correlation has no effect
Thread-Index: AQHdUoYTcHetoRSevkOyIjQeGAj8Bw==
Date: Fri, 2 Oct 2026 16:50:07 +0000
Message-ID:
 <PATP264MB7825D08FBDEB801422FD6EFD93892@PATP264MB7825.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ateme.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PATP264MB7825:EE_|MR0P264MB6888:EE_
x-ms-office365-filtering-correlation-id: 67adcf56-06a7-4ba7-7665-08df20a53722
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|6133799003|3023799007|11063799006|55112099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 pA3NpKJYrR0bdSlgY2T6LPHD2YrJvav7RwF4qlGdljYmKZ/iwwjCIjOPiKb0l9eFVjI/4ftwmyvr4noPCntvR3QSuC9P/pnDeEhsowYT4bAn0EEEGf/6ZKOveTYLMRs/vM/O9sTOyC2ubtAsKoIIVhcEv4ELJQIO+wCVC58zKaicJ5vOqnRhoteQOy9Xv1J8InacPbDftBBodUl46ZtQNzeHKsuDOoYFp3XTL5I8T5cJfkTYqoTxK9NYh4Q6kcOi+S1gBFJgRF6Yw/OZfFTn2BSA6CFKCNWzggk+HrUV8ktNal3uo5oRLcje+Ubgsqnbg51LjdXEYadmy6YqnRmTzcvBObUNpV0Sdb52wDB/wHLOBuVyKqqyxfmcjV9hU/Ui710/pKzTd6Uq0A/176/RAb7VROJn2KzzYcdMCzzMdKiLGqJmJ1tXHN7WfJEuRVgakcMEc5ghzBZ+sUGIOWpNOzv6YQo1VZxQREJfjFeDA7GNcrF9o58qKQGK+W8IS4jCLBxLb8dePNRjpiQu9Vy0l82mD3rsr5Zl0qdEcmb3zgMnxEpk4CHmiLj4BmJ0HFpHTFU3f6dPULUE47Zh074teoJmPo5jLAlCh6BLp4a6jXj1gcKENbwfJiFxFP/+EKufNNDO+iVgemqbyMftwLggF/0gvv2Fphqt2XnkGXrhOu8rjroSjnsJgHEuinCHFVQuPBa91dNYyXwg5INAuCQsflw1bRgwcarx/JWxCUt3q/s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PATP264MB7825.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(55112099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l/JlGNe4rnzHHdxO3neC7y2DrlfS/wCFccxJc+GPk6ACU9S6g9WnMotVeS?=
 =?iso-8859-1?Q?guAbtVEyvt1gtKK2xKNbeoZAmfL0kUablTiEun/kPkcJXy1zOOqMkhH9GG?=
 =?iso-8859-1?Q?Bf5Gm7MXns7NTIOmTZBi7adDlo6QmfFkHTIzL0JbKYrGLQ1N7zsTeGtv9O?=
 =?iso-8859-1?Q?pxH4jdnblgK74Jyk/S0JpZpiuhK43CfKNX7e1BaG6cgF61xV2cHYdB1P3d?=
 =?iso-8859-1?Q?PfBNl8CWutJ0kwFzju9gZiv5z8zWVK+4/WCN/UpDShIGYncR+598izohfy?=
 =?iso-8859-1?Q?D4I7L/ZUTxhUaIaRYo8kLoh2hkAJgFaA2YvAXRgFP4z5m+vcnENMDAkRv9?=
 =?iso-8859-1?Q?6JaNMqRLf6yw+RFXFYc4jLLcp5o+LyEm+zRKnDT8fptCNAu+LyJMge92ZI?=
 =?iso-8859-1?Q?+lVsY4MpJ04LhFsPDVcr9wqRyWldmkRbNH5mdIEBdWk/UNB5Rtyxm/PWDX?=
 =?iso-8859-1?Q?T0FuNWkAKgy/1F4Q6FLYPfQrRxS6PSnr7qjNMAuMmYp03JbVBwDTw3QcdG?=
 =?iso-8859-1?Q?qMqz8I4mODN0zH4gVHnVmKy65yIjhOJY/FPsRpP3f58XzXHQpxHQmvmBlZ?=
 =?iso-8859-1?Q?Du4ochcPYK+wThqN8/HhxC+93n8Z94Lo5yX7qirJzRhU3pfajfhuAA+mTB?=
 =?iso-8859-1?Q?rd0MN38nuS0EK2FIDFNyTB1CmfnxVeOEiGqwiNMdugEud9O3Yjk0OH6vLy?=
 =?iso-8859-1?Q?hL5m++XwJG7MmRjNoEMPKgxLJnvDtFd6fiW/zZtrqbJ43b0O0yfrjFPuJl?=
 =?iso-8859-1?Q?OgtP9le/wztDDtVOYwU1rixth3VsKKHdwmexAmUzikhCmXKejjBu9eKEYJ?=
 =?iso-8859-1?Q?OwrQj1DL1ZisEaJXs19qiSQ/3id6dZkk8/03E0D1UnIt+5Fli7BRqR7GPe?=
 =?iso-8859-1?Q?fQj34Jcc+NXtH9cJbh9WMvXM0o3ymkQzNIOxDI1dCEwKNuysFBPlt9lU3n?=
 =?iso-8859-1?Q?2BNu/zW0jqX3cih7EynhytXFiVWb3kPwlsDUAQnxYb/PQPQvoMr6+JfpLn?=
 =?iso-8859-1?Q?qf+yUVQOrBhTcZfzLBjmC0KLoWZmDySpALjnY4VUU2no/nP5O+jxWFaoS7?=
 =?iso-8859-1?Q?LNfLBDs8mXy09GwZ6WCniB+0UiKa2ddFPpk3v5N7c/476Z6YeGi8wc7nDM?=
 =?iso-8859-1?Q?YbFNUrH3bXVaduVafNheuEpyvVbEsZpsBNk4mO/vVH766q6M4nkc3/4OoL?=
 =?iso-8859-1?Q?MpIF1NC/IXQPU5CZQpzW/fzlyeqjNwUoa6pTPTdYRx57+U4c/8BvgBXWCH?=
 =?iso-8859-1?Q?IVirJbwlCnC/ujjEW90N9iVECXLuf4gQd/qIKiLf8f/esIm0Uz5AkJmlum?=
 =?iso-8859-1?Q?rOaFkheMYf5hbgsbOm4gvRm/1zZfgcY2TuY+D1KUH+LteKFLL2ZhyUYer5?=
 =?iso-8859-1?Q?C+fw9FsPqI5VNXapv4Gi/HaakzFnCG/W2bx284DPB69FjsCcBXt6Cae1G4?=
 =?iso-8859-1?Q?ORqVLfFqGbsbUoe5S5XyDgeu4d94Q6oMZ+XQqn+cH4NEmBV10Ian+DM73K?=
 =?iso-8859-1?Q?goXRKhz8qX/91cjTZasuu/wza7Hkql2cJu0/l0wweQS6uHpBFTePOOEZ7T?=
 =?iso-8859-1?Q?UHgDJaI4hKFmdoBn7CbhYCbdVioyGa9AycbTNgHEQ4fJjAODtwyvZL4dUF?=
 =?iso-8859-1?Q?qboz4BXhjeL6Phz2LnxvJIkBl7PXzu9GszJy/d5m5EUXaxlaqfp9uHwj0u?=
 =?iso-8859-1?Q?tjAlAn96HMEQwQ0UI3cgd+CetNueznq/904UTTm5w8MVFVhWikmyH9odBP?=
 =?iso-8859-1?Q?b696UOvsTdXaVjcwGJct5ngxhuVdS3/ahhbRc4cNxLTWNK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ateme.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PATP264MB7825.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 67adcf56-06a7-4ba7-7665-08df20a53722
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 16:50:07.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99ffcb0b-61fb-4a70-9dbf-700e3874ace9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGo49NinTm9j29jx/bV3JzVPOb8tqasZ3+uPI1fv110XeTmgLGoxNrAoG3WcwNycHh2WBn76F9kvs6q4V37xzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB6888

Hello,=0A=
=0A=
Context: we found the following while evaluating a QUIC-based protocol (Med=
ia over QUIC) with netem-based network profiles from a 3GPP study (TR 26.93=
4), where the reordering caused by per-packet jitter makes QUIC declare man=
y packets lost and changes the results substantially. The following report =
has been generated with Claude code, but humanly reviewed.=0A=
=0A=
=0A=
netem's delay correlation ("delay TIME JITTER CORRELATION") has no measurab=
le effect: consecutive packets get independent delays whatever the correlat=
ion, with or without a distribution table. tc-netem(8) says the correlation=
 "isn't a true statistical correlation, but an approximation"; in practice =
it is not applied at all. =0A=
=0A=
How it was measured=0A=
-------------------=0A=
=0A=
Two network namespaces joined by a veth pair; on one end:=0A=
=0A=
  tc qdisc add dev va root netem limit 100000 \=0A=
      delay 100ms 20ms <corr>% [distribution normal|pareto]=0A=
=0A=
5000 UDP packets, 1 ms apart, each carrying its send timestamp; the receive=
r (same host clock) computes the one-way delay of each packet and the lag-1=
 autocorrelation of consecutive delays (first 100 packets left out: they wa=
it together for ARP resolution). Script below (repro.sh; needs root, iprout=
e2, python3).=0A=
=0A=
  distribution  correlation  delay median  std      lag-1 autocorr.=0A=
  normal          0 %         100.4 ms     19.6 ms   +0.013=0A=
  normal         50 %         100.2 ms     19.8 ms   +0.010=0A=
  normal         99 %          99.4 ms     20.2 ms   -0.008=0A=
  pareto          0 %          93.6 ms     16.7 ms   +0.021=0A=
  pareto         50 %          93.5 ms     15.3 ms   -0.003=0A=
  pareto         99 %          93.6 ms     15.5 ms   -0.003=0A=
  (none)          0 %          99.6 ms     11.5 ms   -0.019=0A=
  (none)         50 %         100.2 ms     11.4 ms   -0.002=0A=
  (none)         99 %          99.9 ms     11.5 ms   -0.025=0A=
=0A=
With 4900 samples, |r| < 0.03 is noise. The delay spread doesn't change eit=
her. A consequence users notice: with jitter larger than the packet spacing=
, netem reorders packets heavily (in our tests, 90 % of packets arrived aft=
er a later-sent one, normal table, 1 ms spacing), and raising the delay cor=
relation, the obvious knob to make delays vary smoothly, does not reduce it=
.=0A=
=0A=
Cause=0A=
-----=0A=
=0A=
get_crandom() blends the new 32-bit random value with the previous result:=
=0A=
=0A=
  answer =3D (value * ((1ull<<32) - rho) + state->last * rho) >> 32;=0A=
=0A=
so the correlation is carried by the high-order bits of answer. =0A=
tabledist() then keeps only the low-order bits:=0A=
=0A=
  t =3D dist->table[rnd % dist->size];                   /* size 4096 */=0A=
  ...=0A=
  return ((rnd % (2 * (u32)sigma)) + mu) - sigma;      /* no table */=0A=
=0A=
Between two consecutive packets, answer moves by a step on the order of (1 =
- rho/2^32) * 2^32, e.g. ~4e7 at 99 %. That is far more than 4096, so the t=
able index is effectively uniformly random and the correlation is lost. Wit=
hout a table the step is comparable to or larger than 2 * sigma (4e7 for 20=
 ms), with the same result.=0A=
=0A=
A model of the two functions in Python (below, model_crandom.py, using nete=
m's normal.dist), 30,000 draws per row, mu 100 ms, sigma 20 ms:=0A=
=0A=
                     current code          high bits instead of modulo=0A=
  table       corr      lag-1     std                lag-1     std=0A=
  normal     0 %    -0.008   19.98 ms       -0.003    19.99 ms=0A=
  normal    25 %  +0.005   19.97 ms       +0.270   12.95 ms=0A=
  normal    50 %  +0.007   19.98 ms       +0.510    9.08 ms=0A=
  normal    90 %  -0.003    20.00 ms       +0.901    3.40 ms=0A=
  normal    99 %  -0.004    19.97 ms       +0.995    1.63 ms=0A=
  (none)    50 %  -0.007     11.55 ms       +0.500    6.67 ms=0A=
  (none)    99 %  -0.036     11.57 ms       +0.995    1.11 ms=0A=
=0A=
The model's current-code column matches the measurements.=0A=
=0A=
Possible fixes=0A=
--------------=0A=
=0A=
1. Index with the high bits:=0A=
=0A=
     t =3D dist->table[((u64)rnd * dist->size) >> 32];=0A=
     return (((u64)rnd * (2 * (u32)sigma)) >> 32) + mu - sigma;=0A=
=0A=
   This restores the correlation (lag-1 ~ the configured value), but it als=
o shrinks the jitter as the correlation grows (20 ms -> 1.6 ms at 99 % in t=
he model): get_crandom()'s output is an AR(1) blend of uniform values, so i=
ts variance falls by about (1 - p)/(1 + p). The=0A=
   "approximation" in the man page would become visible, and existing confi=
gurations that set a correlation would see much smaller jitter.=0A=
=0A=
2. Keep the configured marginal distribution while correlating, e.g. rescal=
e get_crandom()'s output to full range before indexing, or correlate in a d=
ifferent domain. That changes the meaning of an existing parameter too, so =
I suspect it needs discussion.=0A=
=0A=
3. If neither is wanted, document in tc-netem(8) that delay correlation cur=
rently has no effect, so that users (and test specifications tha rely on it=
) stop expecting it to.=0A=
=0A=
=0A=
I'm happy to test patches.=0A=
=0A=
=0A=
Christophe Burdinat=
