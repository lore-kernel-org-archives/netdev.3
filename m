Received: from CP5P284CU019.outbound.protection.outlook.com (mail-brazilsouthazolkn19010000.outbound.protection.outlook.com [52.103.21.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0C3AEB49
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.21.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382585; cv=fail; b=RzIMrsuo3FmAHwTOhYxQ3J8OifUh57jzULfmYD3bQqZEn1EhZS1UfYydY3AC3HAVF6aCoZKtCv6Uc27mqsMa/JcZwai4y7BpG9odBdGezgCmzzQzIjNBlM1/euHZ9lKrIBEUaAvhWjTRBqBo1wTXOqt/CxYo7KzPuX3xyGmCywY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382585; c=relaxed/simple;
	bh=Ubl/b26J36bxdAlcoTPgyUegvlTpuRLoTFp5RnxUYZ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dfzVkMmAh6iS1zjaFCtKp14Th1+alqUbq+ogV84+82Ux2I6zQCfsYVbHR403KjEG/cwzSqXuPvjVPdxz6Vb4r6vHgU/1NIT+pPwl14OKOEPGXnXx4V+8bTE0PRoW+e2ldonFLHIXnUS/vgHQkv8Ds/bI8/SHyCcOtpxj74IfcLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZLS7fu1/; arc=fail smtp.client-ip=52.103.21.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZLS7fu1/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxUH6Fok1a2ddAh7xlrhAdnRRdSbeH8gz2ofVUDUZ/UzlCuP04kN3rwiIZ4WBVYDV85Pzkpz1cVb7X0bXorbxZZJEAwiuR9pV9UpK3RfdqeHVSUJoQKlj78SJ3NAlII2XyJRZMvdPTqVV1yqo4nVIjcZTKIDPEZoL+is4VViVFdXEZjmKrSj8gwyey13YEjjsChPIIM0LULTYjPJZTiWxDtKTwJKQ0uLQg78bv3+2SvJ3WVavL0X0MygAYQ7uI5awhUgASkWtatk9T7cphfADq//bta1VediO/skjrJqQIFYwEHcrtg+c05YtV4aE5Or8okum84bU90CXp/7srYmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19slpFONuwUajdKBZGFvYn+8jXhn0cyQxkqqgXLKum0=;
 b=rEpkQH65Ekr2OzAI1HZhpWJOUYUYyLBU32iz+/CmGWX7pXSAlUe9EujqziyEz4fT3P/HyEVItGL9+6rCzifSvXHpNW+SdDAefqOjxTHruX38F1zDO1Db7Hu23Y/1UqloZUpQz7Oue4NMvJw7vbfwF8ITaVymItotaMicw84zrM6K5pYjhjQAa5ELahAbkZ5/iTCwMNrh0uE2AN7VrrrcOScwhMWLRq5JPC/tWtVwrMaHElYoy8oEUkPeWkalSZOwaS27uipTPnRhGhDZhJbrH8o3vQUsg5V84P/oUdoyVWW1nE5jfgro8o5LhF2N54Tdx+MLZfL8h6UPAP4XMlnE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19slpFONuwUajdKBZGFvYn+8jXhn0cyQxkqqgXLKum0=;
 b=ZLS7fu1/QVbJxB56j0IQe63h+BZ22LIYWpdaisUvLXOKMQ9VEgmY3cBerrQ9MDzuXgu8mGkW3dkkALj11U+ocqx6m1Pg3bNR8eK1mYhH64Jam3DrsL1xjMwFbpMDh0weNHx0/r8sWR5joJ06O6+hBousWsLgC35Scz7FmBNO82rDg4ksJMOJBqBl3dRh2xpAvPFkoy90IZ7iHXds9uZDOvzVyeWlupDRAtlAOHE2aCK1xBP4evYhN/jFntK1d0dDEqgGICOrfpYGBDqhDIh19Fms5i9w1uE50L+oBkO+imq3eV8ig1JocHyCfEC1M/4DrOsrwUnRuMzvm5XJ4+58oQ==
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:92::8) by
 CP5P284MB1600.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 04:03:00 +0000
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83]) by ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:02:59 +0000
From: Leonardo Souza Silva <Capleonardo12@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>
Subject: net/ipv6: tcp_v6_reqsk_destructor() frees ipv6_opt without RCU grace
 (v6 sibling of e3f33b0a1d89, deferred in your own commit message)
Thread-Topic: net/ipv6: tcp_v6_reqsk_destructor() frees ipv6_opt without RCU
 grace (v6 sibling of e3f33b0a1d89, deferred in your own commit message)
Thread-Index: AQHdX36n5MRQv0hNJkOHODGB7aSnuQ==
Date: Mon, 19 Oct 2026 04:02:59 +0000
Message-ID:
 <ROAP284MB1627D435EE8D0DD76EC11D06BD982@ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ROAP284MB1627:EE_|CP5P284MB1600:EE_
x-ms-office365-filtering-correlation-id: 1eaeee6b-19b3-47b7-5633-08df2d95dd7e
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGaTKmQmbVKSB08qRU3mi18UmGjDwr95MZxmK6Hs7ig0pDy3wPx4odZdLoOq8VcGG4DyPgjQENT7AtyjV8/BOAMFXtOl9IW3sWrnDUnGxFUlVsCNfCaMnVPbDoSwtDnR62DsXIVS2LDtx59RnWAZMPFwEqO4vTvO6SlS3Vqf4gqbauvHNfSFErxI+JSPfTq71L+9fVHAK0htFqAJaOQSFGH4efNcy1DaLbXJTr1ti4O0sJ4HcVvIqSpxHUN6e0VWqjKVaxt4rQinqGHw9dvhDhe798RtykJXP1ZgUEIYMymMUFaaBeGT3gBHtTH9WpBWMJKPQOqcYiV1QP4D6DveHsflfW/zjXCH+PPYGZi76cW/BS2baO8DncF/CM4czDMdjGpNpjLXnghY30QZ6KzowX5QU4/MHelcgx0P/ihxjCU6nElDgEXjv5bocdb47Pcka0xhNh0/FKbwDqtA92wzMvO3QoS5V6TW+CP/R2VVoS2iEz9Q1cLqgqFeKqVk4c9PjXt5dmzwkl4dNyrpRd/SZ2MjNXWMhJ+C11shj1erPfu1TKo1O5xVRX3fGmSUXr20a09DZkCJQf7k+DlsdE6vCu7s/GFdrAsXgEc5rKvozS6T1uOT+/dR0NcD4HqwWP+/PcnyRcugh3tV9+DOc3a65MKJ20l7fQvA3RLVHXlpxzuwzlqgRC14kzFVfYtOx633+LWzdo1f0Q1RipONaoxHPD/QSsmwQRsmY9ADNJXlCdXNCqG+E+h1I+xiS+7fatJppFl
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|31061999003|19110799012|25010399006|24021099003|4140399003|6092099016|15030799006|15080799012|5062599005|25031999004|40105399003|52005399003|12091999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?u/Xo1I7gkH2VgpVTCjrypWNyBVvVDIVq4yjPYLu90iRaPPK/JpdXSYtJtK?=
 =?iso-8859-1?Q?lYezZ7avyUWwNjwOT14aTr31gJ4W/5nYjJ8MxPq81vgUNizmcqACC62sZg?=
 =?iso-8859-1?Q?5+7Vw4zfLBoN549no03RhZE5lXa0ZPzTJWiiPNIYOaxplSn0Ldxkkk9YrL?=
 =?iso-8859-1?Q?aBn8L/iXZouWwFhVMzPQdKbu+RmFyO7RBeg6FVJo5oZEPvV7MK6xylmLs4?=
 =?iso-8859-1?Q?jTicBMmPGagipMQYJtzWKpn1lemZ0eJ0+JJ7JuKCJMqmyzPcduqhvW6Moa?=
 =?iso-8859-1?Q?t6l6Ih5j0jivEqQXQgIQLoUaf9CQJAMiBbVvXC2HRob2NUlz6jGsmOCj7F?=
 =?iso-8859-1?Q?Z74gLkkxP0KubxYBmMCvTzAtS9epsw874A2Tib2KeNDMdDAnxN4/6eT6Ow?=
 =?iso-8859-1?Q?mczQsR7mLqz5zJ4apeyFTzuw0ha+0RmEjrIazJCUGBpljhq+Am5OqnQLl0?=
 =?iso-8859-1?Q?EX5/EtaHxaIvI5nuUu6pt8B98U2U47lUMhMjJXkp2TfolLIUr6Df3tCU5F?=
 =?iso-8859-1?Q?6s9g2oj2zHSwSbXibZCXAMpSuOCt4EYHL9S9u4xnUZv423vEuZmkYwXQ7o?=
 =?iso-8859-1?Q?MtD2wqnuOUSrEBHrzN/MHV0PQZgYIrem6HjVKOtXxLRbdnwWh9JznkLn1m?=
 =?iso-8859-1?Q?Z9jb/Fo069akFKYEGeqYv0grevK9JBoOG59HzT5JbMnDeHrnaLurd34VCk?=
 =?iso-8859-1?Q?psI7nFWhlI0LI61w1YBEIQnfafq2v48rZQLqvQjaujoh9j+rwzYooM0+FJ?=
 =?iso-8859-1?Q?kjfVIhK0LPamtMuiGrj0fAO4QxqzC7UlFJgyb23Q8fiER1wOMdM9V8ujvg?=
 =?iso-8859-1?Q?fbaFTsEU8GlOuFEB2Onvya1vW76iDIqU5o/BKyNUuNisRfeOcZemk2hlcA?=
 =?iso-8859-1?Q?2Sr4bytvEwUoRUOonqv1fcZmS/jmXweXMhmJK6ZuVKqpUq+fmnlme/3/Ue?=
 =?iso-8859-1?Q?1YJJG4ZW5iMdmrRvtw6nLiK3G0CcAeEKYZ6GtJr9pzzkEnmdAWoNS+6XZF?=
 =?iso-8859-1?Q?vmuUVLQy1t2YJifLFWPiOe2miS7yLM21llIES1pwB8t7NbcvxXLUC8RVWL?=
 =?iso-8859-1?Q?C8ceJajXSUYzj83JVshJiENYN6b1Nv7tVhoeIbL3WmDiTUid0x/oqyMtk0?=
 =?iso-8859-1?Q?GevLzRow=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2Rd0BTbDX4GuyxqEJQAdQliQWE7lDIIZQQYQfaAwJBSUs3ySXqsA6LFYWf?=
 =?iso-8859-1?Q?snZIer16VLNg+YWWEQMrNpjghn7q+RhXJJJDd+ZA2hFyB+eylMR+VE6co+?=
 =?iso-8859-1?Q?xjWSQ26CHYne3rcqbnk36714mwb/lVX5eWOlLIl/HWthoWPiemiHFpi7LB?=
 =?iso-8859-1?Q?+ZzW24LooAaBDRVh05OL997gw07+5w2UN8sswrcfOUXow9VQR0IadjHvmc?=
 =?iso-8859-1?Q?GPeb9+zlnDGi25NkfePebSO3i7tdcK3MSHHgkdxJS3FZc2znJjOO471j29?=
 =?iso-8859-1?Q?w7IyxNuzrDgaqwsFqBRMPYsgcfI9lb7AtvxADL5VlN5I0cqcejVqpsFCmA?=
 =?iso-8859-1?Q?/Fzb9agfrRKjFUHnnb2hQ7ySwlrWN6plgdDEfiPNbLKBk11RioU5dh+Lg3?=
 =?iso-8859-1?Q?6ZOteInSZHCwsdLFjXvDs0DtKN4js4NbNS5p8CZZtqrfv+1rRQa+ONj4RB?=
 =?iso-8859-1?Q?Giuy/kHbi/WCMSLWru1hwft15eCRLWzenux5WIv9USizD811DpjaNfrnmQ?=
 =?iso-8859-1?Q?7ca6TzwsCbVoWZt5MPfwXUHtzfrFIQ3xa8mBHlOinbHeMfD/mzgg8PSv7k?=
 =?iso-8859-1?Q?48x90u6LzppHmQDEPFeJkPvtWBvoCozxPiTi2Qrd3FJNa0fno+b7UdWroM?=
 =?iso-8859-1?Q?lQ2xY7fKUbbG1LHW4iQ25jqqTogbCsatcI7N/3PwzYVgV1Mw2mC85CM+W9?=
 =?iso-8859-1?Q?cHQwjQftnjgz9F/pPcknnL8hvrFd8rtQPpZ5myCkmH8FZRjZPjPMebdijx?=
 =?iso-8859-1?Q?GvPVrBCUieBboCANG4db2iQRj6c20edWGgbBcSO3JyGUCqHfr+aDXtY80u?=
 =?iso-8859-1?Q?mOv0rk7hA16JDd/BBYM0nbZ0hVvTSnNxysYKVB9pIMpPKfnCEWhZdjSJ1l?=
 =?iso-8859-1?Q?iz9d+d4M4dSkOHYVt5CBYUDn2qvppIF7LrNFp+Ufb3qYGqNuwhPvFReq6H?=
 =?iso-8859-1?Q?dzjdBCuBW2sJO971WPTobqQs5Ips922w/r0G80jVki9GQfebAl3+N7JYjZ?=
 =?iso-8859-1?Q?6t+EPSDYVtEemFFvQLYT16het/d4VNoa67PrUNNMmxFnMS54cZ0TexmUjP?=
 =?iso-8859-1?Q?lGYErLr/URShr0qcUFYEfz1uK/pE8LPaw5ITgYB0YHclxsVa/7lE4fPC/a?=
 =?iso-8859-1?Q?Pc90a7jvRRNyi8p4RD6hTu4dd+UIssRPktwLhw5zewdqGAAwqHSnEyPHPh?=
 =?iso-8859-1?Q?V4pwPfwBUOusneBN/zvkQafvOgcG5Nbc1DPyqH3cGNF+PvVm+ZkUlClF/z?=
 =?iso-8859-1?Q?IXgxTQE+DqPIbrnb0btZy/UHWphIlp459y/rqiL9cO3mo6VEf6eLQMUzCW?=
 =?iso-8859-1?Q?q4GVBo9lMs6eM3lCE31vujaDV0jPCGwKVMHh0qLl3kqGNF6o1w2844EJMJ?=
 =?iso-8859-1?Q?FyvtS8s/x8Iy5Ub1ZE8stmPsiF7bdT7RewseQdvm23YxRnuCQT4bXX+a5o?=
 =?iso-8859-1?Q?Cwf9WNg4S7aKTolX?=
Content-Type: multipart/mixed;
	boundary="_004_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaeee6b-19b3-47b7-5633-08df2d95dd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 04:02:59.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP5P284MB1600

--_004_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_
Content-Type: multipart/alternative;
	boundary="_000_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_"

--_000_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

Commit e3f33b0a1d89 ("net: do not delay ip reservations... free inet_opt/ir=
eq_opt after RCU grace") fixed two v4 UAF sites by switching to kfree_rcu, =
and its commit message states about the v6 side: "This will be addressed in=
 a separate patch." As of mainline 58161ead2 that patch has not landed; net=
/ipv6/tcp_ipv6.c:605-609 still reads:

static void tcp_v6_reqsk_destructor(struct request_sock *req)
{
 kfree(inet_rsk(req)->ipv6_opt);
 consume_skb(inet_rsk(req)->pktopts);
}

i.e. plain kfree of a clone-shared ipv6_opt (req-migration clone via c905de=
e62232) against RCU readers (tcp_v6_send_synack at tcp_ipv6.c:591 reads ipv=
6_txoptions under RCU) - the identical pattern e3f33b0a1d89 fixed for v4.

Reachability today is gated: ipv6_opt on a request sock is only populated v=
ia calipso_req_setattr (NetLabel/CALIPSO), which requires an administrator-=
configured CALIPSO engine - so this is a hardening note for the deferred fi=
x rather than an unprivileged report. Verified the site is unchanged in bot=
h 7.2-rc5-era mainline and linux-6.12.y.

Suggested fix (mirroring the v4 side): kfree_rcu(inet_rsk(req)->ipv6_opt) i=
n tcp_v6_reqsk_destructor.

Leonardo Souza <capleonardo12@outlook.com>


--_000_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Hello,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Commit e3f33b0a1d89 (&quot;net: do not delay ip reservations... free inet_o=
pt/ireq_opt after RCU grace&quot;) fixed two v4 UAF sites by switching to k=
free_rcu, and its commit message states about the v6 side: &quot;This will =
be addressed in a separate patch.&quot; As of mainline
 58161ead2 that patch has not landed; net/ipv6/tcp_ipv6.c:605-609 still rea=
ds:</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
static void tcp_v6_reqsk_destructor(struct request_sock *req)</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
{</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp;kfree(inet_rsk(req)-&gt;ipv6_opt);</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp;consume_skb(inet_rsk(req)-&gt;pktopts);</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
}</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
i.e. plain kfree of a clone-shared ipv6_opt (req-migration clone via c905de=
e62232) against RCU readers (tcp_v6_send_synack at tcp_ipv6.c:591 reads ipv=
6_txoptions under RCU) - the identical pattern e3f33b0a1d89 fixed for v4.</=
div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Reachability today is gated: ipv6_opt on a request sock is only populated v=
ia calipso_req_setattr (NetLabel/CALIPSO), which requires an administrator-=
configured CALIPSO engine - so this is a hardening note for the deferred fi=
x rather than an unprivileged report.
 Verified the site is unchanged in both 7.2-rc5-era mainline and linux-6.12=
.y.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Suggested fix (mirroring the v4 side): kfree_rcu(inet_rsk(req)-&gt;ipv6_opt=
) in tcp_v6_reqsk_destructor.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Leonardo Souza &lt;capleonardo12@outlook.com&gt;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_--

--_004_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_
Content-Type: application/octet-stream;
	name="attach3-0001-ipv6-reqsk-destructor-kfree_rcu.patch"
Content-Description: attach3-0001-ipv6-reqsk-destructor-kfree_rcu.patch
Content-Disposition: attachment;
	filename="attach3-0001-ipv6-reqsk-destructor-kfree_rcu.patch"; size=1305;
	creation-date="Mon, 19 Oct 2026 04:02:44 GMT";
	modification-date="Mon, 19 Oct 2026 04:02:59 GMT"
Content-Transfer-Encoding: base64

RnJvbTogTGVvbmFyZG8gU291emEgPGNhcGxlb25hcmRvMTJAb3V0bG9vay5jb20+ClN1YmplY3Q6
IFtQQVRDSF0gaXB2NjogdGNwX3Y2X3JlcXNrX2Rlc3RydWN0b3I6IGZyZWUgaXB2Nl9vcHQgYWZ0
ZXIgYW4gUkNVIGdyYWNlIHBlcmlvZApUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZwoKVGhlIHY2
IHR3aW4gb2YgZTNmMzNiMGExZDg5ICgibmV0OiBmcmVlIGluZXRfb3B0L2lyZXFfb3B0IGFmdGVy
IFJDVQpncmFjZSBwZXJpb2QiKSwgd2hvc2UgY29tbWl0IG1lc3NhZ2UgZGVmZXJzIHRoaXMgc2l0
ZSB0byAiYSBzZXBhcmF0ZQpwYXRjaCIgdGhhdCBoYXMgbm90IGxhbmRlZCBhcyBvZiA1ODE2MWVh
ZDIuIENsb25lLXNoYXJlZCBpcHY2X29wdAoocmVxIG1pZ3JhdGlvbiB2aWEgYzkwNWRlZTYyMjMy
KSBpcyBmcmVlZCB3aXRoIHBsYWluIGtmcmVlIHdoaWxlCnRjcF92Nl9zZW5kX3N5bmFjayAobmV0
L2lwdjYvdGNwX2lwdjYuYzo1OTEpIHN0aWxsIHJlYWRzIGl0IHVuZGVyClJDVSAtIHRoZSBpZGVu
dGljYWwgcGF0dGVybiB0aGUgdjQgZml4IGNsb3NlZC4KClJlYWNoYWJpbGl0eSBpcyBnYXRlZCAo
aXB2Nl9vcHQgb24gYSByZXF1ZXN0IHNvY2sgaXMgb25seSB3cml0dGVuIHZpYQpjYWxpcHNvX3Jl
cV9zZXRhdHRyIDwtIE5ldExhYmVsL0NBTElQU08gPC0gYWRtaW4tY29uZmlndXJlZCBlbmdpbmUp
LApzbyB0aGlzIGlzIGhhcmRlbmluZyBvZiB0aGUgZGVmZXJyZWQgZml4IHJhdGhlciB0aGFuIGFu
IHVucHJpdmlsZWdlZApyZXBvcnQuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGZvciBub24tY2xvbmUg
bGlmZXRpbWVzLgoKU2lnbmVkLW9mZi1ieTogTGVvbmFyZG8gU291emEgPGNhcGxlb25hcmRvMTJA
b3V0bG9vay5jb20+Ci0tLQogbmV0L2lwdjYvdGNwX2lwdjYuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ldC9pcHY2
L3RjcF9pcHY2LmMgYi9uZXQvaXB2Ni90Y3BfaXB2Ni5jCmluZGV4IDAwMDAwMDAwMDAwMC4uMDAw
MDAwMDAwMDAwIDEwMDY0NAotLS0gYS9uZXQvaXB2Ni90Y3BfaXB2Ni5jCisrKyBiL25ldC9pcHY2
L3RjcF9pcHY2LmMKQEAgLTYwNSw3ICs2MDUsNyBAQCBzdGF0aWMgdm9pZCB0Y3BfdjZfcmVxc2tf
ZGVzdHJ1Y3RvcihzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEpCiB7Ci0Ja2ZyZWUoaW5ldF9yc2so
cmVxKS0+aXB2Nl9vcHQpOworCWtmcmVlX3JjdShpbmV0X3JzayhyZXEpLT5pcHY2X29wdCk7CiAJ
Y29uc3VtZV9za2IoaW5ldF9yc2socmVxKS0+cGt0b3B0cyk7CiB9Ci0tIAoyLjQzLjAK

--_004_ROAP284MB1627D435EE8D0DD76EC11D06BD982ROAP284MB1627BRAP_--
