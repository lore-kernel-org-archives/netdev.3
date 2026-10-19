Received: from CP4P284CU005.outbound.protection.outlook.com (mail-brazilsouthazolkn19011032.outbound.protection.outlook.com [52.103.21.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64D26ED37
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.21.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382338; cv=fail; b=DpszshZALgaTMiOm8Jh7GXCxJN+Pq78dQqhFUBHM6TzZUHJaVZy9yieoVPS6v5EYeNp8VhUKRS9Ud1VR4iCZ2X+L+huX5qbHZX5yQ0zJRoRCG7X/4OJvIoxCnDJdWoHk0NzfLGphaqkYHy6Ewr36qHQvrmmTtDxE/G5Z18S8kto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382338; c=relaxed/simple;
	bh=hLbWrI1lq2qjNP5GBkNmbjUa1YogYPuFi0o+xqpbex8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RGVhSA+v3YdsX/vJCgOt7IdXA7EP/c+zNXnSipxECNxEPhbWm2Awu5iFDbP72kwUlEOBUX06gs7vHO8hCB1bx+uW081WcbquGFFgDLgLry9Nbr1vPc3K0ffLAimBVmH0n8UjzCvvoht2B+n2FVupGhnUkQbF0VDKTBXRfktXo9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bsMYevMF; arc=fail smtp.client-ip=52.103.21.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bsMYevMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC1Gr83AP4bwKtjLbmZC8V94ttO6JDkD0D+cLywx8C4ozBXy6T+wYXL63MX/VZUm6qcLiPtVGFZPN+ie+ufQRE/uqFmJo7vApTrmVgzuJFS6ZY7AQAIXtSPEauhCnolQX72uvNqcH+r/k+ZU1ErBC1NWBf0jWwoMTe2QyFeqeAQM97hmSMIw7uJGFVvTfOoKqe5+ZkvQpQDKztGJp6YEz5mMqvefaraP1z8N6yxroYkoLYjeVclhFPRlLElIANxkFdtZFMY3x7eKwzAFVqlVltM7KcjqSGUiXxWsZ0ZGlALL9Luai9t0EVaxH1r2KWbmJ60lwumncyXhwoszi4yMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9KuIq8Prf3mSGoc40rWsRlZbpjZ//uvDBzZLjgGjok=;
 b=gGpuW/AdqmvGoywPUbw/59D2E8/aNB3AWSm3pX0KB7yIxiii/MAFmL7mKYb6sym9rFFrRYUq2KBIRyharyR6J2EO+Fm85CjWReqPN6d5p0Zs2oqF8ulvkHadzKTMA5YnMf4s4+xDId+RgEqo97qxNNDdhsVleQRf2OltkQlnYDJJmUN+zvbIIl5+y1BIOfcKKPfpK3w1H17rraI3x5jaJtp4Y1qnQDOE8XIbWxizjfGXRel8VQvnSfNzmIxwqjmG4bNTHaw42/eegtVu2yXrvRZ3qWGhC686P3rBXzfG3wEFmWPHEcKAzhPZWsmeTIvdtv+yWkOzHWVxR3KjGMFYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9KuIq8Prf3mSGoc40rWsRlZbpjZ//uvDBzZLjgGjok=;
 b=bsMYevMFXScu9fHdDfULIh8N8OUIsnLd+eAy78GDU4SAFfsc5N+oNSmO7AIdDWUT/1RqdPTuBFHCoFIJcswX6OdtwyFctgs02HEJQDKd7epOo1udOjpmwPOzNr2KomF/TgUPA5LHlNNXNHJ7fRqCjBZxxgcOMbQPnfsLa67ug1Aj61tobCwVwRIXin5Mpb6S6qlB08qdCK94In5d2U+D+9aGxjQgibU3bqyGQHxHN+zbEnU7zfHyzJ5/ZXvbUBWtcI1GUF9vXHDL8jb5q2ESP2rSBrH0oIcAe5dGdwdzHpctZc/D7b4QQ6/bKYTCoe4h16EDO90rzDUWjlbW1VvFZA==
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:92::8) by
 CP5P284MB1600.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 03:58:51 +0000
Received: from ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83]) by ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM
 ([fe80::d40b:6372:7b2a:8e83%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 03:58:51 +0000
From: Leonardo Souza Silva <Capleonardo12@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com"
	<syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com>
Subject: [PATCH net] tcp: fix copied_seq double-count in tcp_eat_skb after
 partial read (syzbot 06dbd397, 1048 days open)
Thread-Topic: [PATCH net] tcp: fix copied_seq double-count in tcp_eat_skb
 after partial read (syzbot 06dbd397, 1048 days open)
Thread-Index: AQHdX3wQ8bQp1kI9bkikBdUXsFlpwQ==
Date: Mon, 19 Oct 2026 03:58:51 +0000
Message-ID:
 <ROAP284MB16278289FDDB6644C099AB3ABD982@ROAP284MB1627.BRAP284.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ROAP284MB1627:EE_|CP5P284MB1600:EE_
x-ms-office365-filtering-correlation-id: c74a56b9-02ef-4a2e-1e39-08df2d95494d
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0Al3Sx3Z1Z2x0bAR6iD4UHO+UgVeHot7w6WpU4hLR7e/Wo5KuDO2F+IFX+/HmzoIbXxOfxqX7fxfizoMxx4tLhlLoY+3ayct2AksSH6S5+gwl7uTDPco1EA3MLwwFJIpwpEocgS5Qf6mnbnSTGrLQC3E17wbHvQN3/1E3+gUJ4yhzdcISdOsZFlzSVu/CxeOo0RA66oHyBQjmdEr62kzuKqBW5uK95Rdz2Q8mRtM6HzrnMZmk9VryQ8+zVhZl7h2H4VhJsj+x/ziVmaSoYJwdBe6ov/wwiEoOvUQXdPCh3CCPApXtt/7mPDVJ2QWQbngRqXMary0W1598JToIlMIzS9Xn/A1RkGyNEtFv4rdjGxq7VV+DfSFQw2g7urhZfazF3Xr9N2n/3pCxki1mM3LTbWLywmsaOKzhWXJ57sbZ5Fk0rtFc6xuQw4K9uGx081zpGS29rAci2K4CsFZ4fFcJWlAv0N4nap+V7TPdErjC3lgCSOoqao5W+havWAOuguG+Kr4kRD2clk0Gg3NrCVvoiH/M/LrepRopsIxf0/xLEn8zBfsaZWKvbyd9YtjtUJrMIOElfnykjx7z2DoqM4HlGhn/FafOfYhbpr9vNaWTu3kwXoi+6U0R35THbnQUII0APfK0Ay9eeOJss0t4Yg6VaknfGtAn6fdw83Bdr7n6EUgcPTAlCjRDqd/lbXIXn4WK1c1uGuy0lOIQUp/40ruLqNxtl9iLKlwjROZk6ZJWMq090Px3Suaps4qZL/uH9ifAO
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|31061999003|19110799012|39105399006|25010399006|24021099003|4140399003|6092099016|15030799006|15080799012|5062599005|24071999003|20031999006|25031999004|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?da2YzQSYK6fZPPUClR6xNAsnYfaud8S5QG0tbMJavH1ZN+M4roomWz6YxG?=
 =?iso-8859-1?Q?u8KI/+AgQ4BUuqZ9m3wp8XvV6iUhAq0r5FAKlAMqYUIn4aXmOe+YmlO/WR?=
 =?iso-8859-1?Q?egeeooKa0Qgw3NGZYbVcIVoePNKOZNitz7IWSz+FWBkT/bHXgc80d26bAv?=
 =?iso-8859-1?Q?AcBQgELbkh9iZiLA+Fbf2VeVqNYwdrWYY7UxuLxGjBRjgtNrFBrLbtWfC4?=
 =?iso-8859-1?Q?GBlOgCMMB9qw0t5SNg5vTLkrreYYvlYJtB6b/JVojLvQozUsYlp8hrkbcd?=
 =?iso-8859-1?Q?6b1QpzB1dGPLLRmFjQcnq0nPecbaKSGEQ2mJuGz46YYngR51NOjBe+vC5b?=
 =?iso-8859-1?Q?NaSTV/kfsH+VDkREWSG8qOE8dr56jViDmL53Dziv6ylwcG68ZjU/4uut99?=
 =?iso-8859-1?Q?urtzHZIudDV95dP9K+yTVmOAn6iRa9QnxcmGrV2sfQX1xhxXKv1uGo5B+D?=
 =?iso-8859-1?Q?RYbStqWkkUTzbIWYNs4mmNyz/6YJvztgl6MEQtSle2+Jd3uqpuaSj3pZIt?=
 =?iso-8859-1?Q?pyXPb3VKlCO11BPdrnA7Ic2rC/T3si+P27m4qNy/2LvZuOmuH2q1asO1Rk?=
 =?iso-8859-1?Q?0XD5XfNOYeqfErP2N7Srhl+w+jAWhGgdvPuVtmXmQessM6DhknVg8UOR6D?=
 =?iso-8859-1?Q?3LOACD54VpW6wK0O4HWkzl2k3wDM4ss/dqWtKxc9x5qr5Wr92EpLdIHEsM?=
 =?iso-8859-1?Q?ug37vjeWfmTrw6LLeG3esxy2NphUD7OAOOs0kF6Xr0LsDwOELjhCyCW9y9?=
 =?iso-8859-1?Q?f3crFrdyCc144zDw6oFFA9TT3gbFzI/NVxBy330Q36+W/9a38A8QNgNBfo?=
 =?iso-8859-1?Q?XYR5dnrnzWIgpb3MrwNBbnEaZytsh+xa2vlL8hAdnP9xjP6/3p7HBoRSlJ?=
 =?iso-8859-1?Q?WAzOOC8hKByPDI+gLUmMcxZyXWLVEbx3pOamtHhvQyX1bkwoIAZeHFWYzG?=
 =?iso-8859-1?Q?AA/0BvZKYuVM70QKDh4mDbdn6KXOkFpCdUCUMfFuQLZm+NcklBTdlGquyy?=
 =?iso-8859-1?Q?GyvjgdBL2Z4kDSfKAZsNyoZZ4WrbghSejuv5aZGDOCdMyTilBkB0qz4ZsJ?=
 =?iso-8859-1?Q?gmhNDt3Geee3JfZAXK8b0JXbMBthx+H6xHHbLBgO59VXRDBbjFXRK3WsrD?=
 =?iso-8859-1?Q?PIki7lGM5Vx/qR0VQ0GoeCPETgP2DoWlKoPHVsVJZQMahup+sD?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NUGjTVbpzHDlMvRaGe8OeNMiYQd1plbhAHSakj0ftgVyF4fhqsg5umwryj?=
 =?iso-8859-1?Q?8LdiOiXQy3mkWmciCRpXeMEGOnG4xlg2OJJqkKkVXQvYIOyB54Sk3e8bJ6?=
 =?iso-8859-1?Q?UUV0mQrBqJG484yXXZd70/4M70Mz0flDVSN64b/V8+gvsv+7x1OpsR9sU+?=
 =?iso-8859-1?Q?5wV0iB1JAmUs9c7Di9R32EWHO8RniLjOUEhcnPh+WpaH2SojZ2iAbKbd99?=
 =?iso-8859-1?Q?mGTh7g6K+bpMaHFe0FusvAOnHc0BWFk/tRW6k79Ka0a+oKW3Uv1lkcT38R?=
 =?iso-8859-1?Q?UPb9qPnoyqEE3EJMXkvfh9CGrEXDdxDqZV5/T5iYx/3W9kP11EezM5fr7f?=
 =?iso-8859-1?Q?qCTs+slXW1NSbXFQsQfMvu2KGBlqLLPFvoozlIw8FdP9Rg1x6EIovbI6A8?=
 =?iso-8859-1?Q?J7CNK/0JUH8ZoeXnPTSYeseMIHa8NAV6fpyQ3SO++T+JCd1ZfanNtHUgCc?=
 =?iso-8859-1?Q?eKSV/IUSIeJtxR4A6pwkqkjoM08WEzQw+fK13f4OzZ21KX6s63fVTTvwOl?=
 =?iso-8859-1?Q?qeS4Yp9fFXjf9Sil3PoHi8CwVYqC8XuJDrbt7IS7kDYi42J+P+eehFUBKK?=
 =?iso-8859-1?Q?AA/wrrPTrXwKKr41w3AD9bTDG3J14ajvX24jwEWbdX3lBzXIL26wSXzpKg?=
 =?iso-8859-1?Q?lAUCiHRlalhUcUb7FD28KNezZhKfsUklp3qWPJBDaX1HJD9rze2oQhQ25+?=
 =?iso-8859-1?Q?pWkfTq1tjB5eqQJrK387gfo6PJlJXZsWWulAIGlu67athJCxt0dKwMJYAG?=
 =?iso-8859-1?Q?ePqAux313m+YNuFKlKgUqmyEVV9Of1oeEnjfRyCs8jcRdsCdGTOtg3fXCw?=
 =?iso-8859-1?Q?3x0zrPY4/oGPN4Wtdw8ZBdtMHot8+ihbFJwlNrszOcCAm+kUCyVP0CHTGc?=
 =?iso-8859-1?Q?FZq7zeW8xxjAqXXUzAlv2wC7Yv0qQx593exG7zNgjX2dXzqmooiyHmW8Zl?=
 =?iso-8859-1?Q?mAPJv5x2d+GvejsvzRCQpPOeV02U5iHZLd1zSogUW8kiJ4aCZ3YA5tKmvQ?=
 =?iso-8859-1?Q?lwgjNcOT2KADR+a10cW1N8uhVjpb1zjhnI9Md2piML4ab2XU7Bp01aTjGr?=
 =?iso-8859-1?Q?rAqBE6qAcU9G8TW2co95nPOge+U1ym4w5FdaQ3cX4EuJGHEXXNgIlrzbkq?=
 =?iso-8859-1?Q?crmoi2RghGeHwjG9g7EQe1XL8IkI7/UzaIDoQeVyUV85M70JbYxmIeQWjI?=
 =?iso-8859-1?Q?6HgYKlEY+VCIYGEV365ODV8odCXy1Rlm7OuPCKp/xUzUTNs1bg2iJAXcUd?=
 =?iso-8859-1?Q?wWVdEtVzd6GPb4BZWduh5xQ78wqTrJYyE2HiF+TAFdFqGN9NHWV8yp2eEI?=
 =?iso-8859-1?Q?n8uTqI+HZQ8ZXivRfmCFjiE3K+veEoU2dGhYXzSW1qhTwaOn2gDH57A/aN?=
 =?iso-8859-1?Q?geUCPx9UrRCcE0HDymwynBt/BQYXlDDD8KlYNQv5shhx8I2DlostEspr4W?=
 =?iso-8859-1?Q?mGi/hSo7phUFCUBs?=
Content-Type: multipart/mixed;
	boundary="_004_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c74a56b9-02ef-4a2e-1e39-08df2d95494d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 03:58:51.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP5P284MB1600

--_004_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_
Content-Type: multipart/alternative;
	boundary="_000_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_"

--_000_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

We root-caused the 1048-day-old "WARNING in tcp_recvmsg_locked (2)" (syzbot=
 extid 06dbd397158ec0ea4983, last crash 2026-10-08, C repro available on th=
e bug page):

Root cause: tcp_eat_skb() (net/ipv4/tcp_bpf.c:15-33) unconditionally advanc=
es copied_seq by the FULL skb->len ("copied =3D tcp->copied_seq + skb->len"=
). It is invoked from the sockmap verdict paths (net/core/skmsg.c:1047/1054=
/1213 via tcp_read_skb, tcp.c:1755), which hand it the queue-HEAD skb. If u=
serspace has already partially consumed that skb via recvmsg or getsockopt(=
TCP_ZEROCOPY_RECEIVE), copied_seq is already past skb->seq; the eat then do=
uble-counts the already-read prefix and jumps copied_seq past end_seq. The =
crashed state in the lore report (copied=3D...C633, seq=3D...C601, rcvnxt=
=3D...C602, 1-byte head skb) is exactly the double-counted prefix.

Introduced by 965b57b469a5 (->read_skb(), 2022-06-15). Still present in 6.1=
, 6.12.66, and current mainline (verified identical tcp_eat_skb at 58161ead=
2). We are aware of two stalled fix attempts: the end_seq-based rewrite pos=
ted 2026-07-02 (no v2, no review) and the FIONREAD/copied_seq series (v9, s=
tuck on bpf-next since 2026-01-24).

The WARNING itself is WARN-only today (every copy in tcp_recvmsg_locked is =
guarded by offset < skb->len), so there is no memory-safety consequence we =
could demonstrate; the invariant break is nonetheless real, reproducible wi=
th the public syz repro, and the condition is exactly the one the recvmsg W=
ARN guards.

Proposed minimal fix (end_seq-based, matching the 2026-07-02 direction):
 - s32 copied =3D tcp->copied_seq + skb->len;
 + s32 copied =3D TCP_SKB_CB(skb)->end_seq;
   WRITE_ONCE(tcp->copied_seq, copied);

We are happy to test any patch on the repro (quiche test infra available) a=
nd to provide our full analysis (trigger matrix: partial recvmsg then sockm=
ap verdict; partial zerocopy-receive then verdict).

Reported-by: syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com
Analyzed-by: Leonardo Souza <capleonardo12@outlook.com>


--_000_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_
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
 color: rgb(0, 0, 0);">
Hello,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
We root-caused the 1048-day-old &quot;WARNING in tcp_recvmsg_locked (2)&quo=
t; (syzbot extid 06dbd397158ec0ea4983, last crash 2026-10-08, C repro avail=
able on the bug page):</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Root cause: tcp_eat_skb() (net/ipv4/tcp_bpf.c:15-33) unconditionally advanc=
es copied_seq by the FULL skb-&gt;len (&quot;copied =3D tcp-&gt;copied_seq =
+ skb-&gt;len&quot;). It is invoked from the sockmap verdict paths (net/cor=
e/skmsg.c:1047/1054/1213 via tcp_read_skb, tcp.c:1755),
 which hand it the queue-HEAD skb. If userspace has already partially consu=
med that skb via recvmsg or getsockopt(TCP_ZEROCOPY_RECEIVE), copied_seq is=
 already past skb-&gt;seq; the eat then double-counts the already-read pref=
ix and jumps copied_seq past end_seq.
 The crashed state in the lore report (copied=3D...C633, seq=3D...C601, rcv=
nxt=3D...C602, 1-byte head skb) is exactly the double-counted prefix.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Introduced by 965b57b469a5 (-&gt;read_skb(), 2022-06-15). Still present in =
6.1, 6.12.66, and current mainline (verified identical tcp_eat_skb at 58161=
ead2). We are aware of two stalled fix attempts: the end_seq-based rewrite =
posted 2026-07-02 (no v2, no review)
 and the FIONREAD/copied_seq series (v9, stuck on bpf-next since 2026-01-24=
).</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
The WARNING itself is WARN-only today (every copy in tcp_recvmsg_locked is =
guarded by offset &lt; skb-&gt;len), so there is no memory-safety consequen=
ce we could demonstrate; the invariant break is nonetheless real, reproduci=
ble with the public syz repro, and the
 condition is exactly the one the recvmsg WARN guards.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Proposed minimal fix (end_seq-based, matching the 2026-07-02 direction):</d=
iv>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp;- s32 copied =3D tcp-&gt;copied_seq + skb-&gt;len;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp;+ s32 copied =3D TCP_SKB_CB(skb)-&gt;end_seq;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp;WRITE_ONCE(tcp-&gt;copied_seq, copied);</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
We are happy to test any patch on the repro (quiche test infra available) a=
nd to provide our full analysis (trigger matrix: partial recvmsg then sockm=
ap verdict; partial zerocopy-receive then verdict).</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Reported-by: syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Analyzed-by: Leonardo Souza &lt;capleonardo12@outlook.com&gt;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_--

--_004_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_
Content-Type: text/plain; name="attach1-tcp_eat_skb-analysis.txt"
Content-Description: attach1-tcp_eat_skb-analysis.txt
Content-Disposition: attachment; filename="attach1-tcp_eat_skb-analysis.txt";
	size=3293; creation-date="Mon, 19 Oct 2026 03:50:48 GMT";
	modification-date="Mon, 19 Oct 2026 03:57:36 GMT"
Content-Transfer-Encoding: base64

dGNwX2VhdF9za2IoKSBjb3BpZWRfc2VxIGRvdWJsZS1jb3VudCAtIGZ1bGwgYW5hbHlzaXMKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKGF0dGFj
aG1lbnQgZm9yIHRoZSBzeXpib3QgMDZkYmQzOTcxNThlYzBlYTQ5ODMgdGhyZWFkKQoKMS4gVEhF
IFdBUk4KLS0tLS0tLS0tLS0KbmV0L2lwdjQvdGNwLmMsIHRjcF9yZWN2bXNnX2xvY2tlZCgpLCAi
VENQIHJlY3Ztc2cgc2VxICMgYnVnIDIiOgpmaXJlcyB3aGVuIGNvcGllZF9zZXEgc2l0cyBhdC9w
YXN0IHRoZSBlbmQgb2YgYSBGSU4tbGVzcyBza2Igc3RpbGwgbGlua2VkCmluIHNrX3JlY2VpdmVf
cXVldWUuIFRoZSBpbnZhcmlhbnQgaXQgZ3VhcmRzOiBjb3BpZWRfc2VxID09IHNlcSBvZiB0aGUK
Zmlyc3QgdW5yZWFkIGJ5dGUgb2YgdGhlIHJlY2VpdmUgcXVldWUuCgoyLiBST09UIENBVVNFCi0t
LS0tLS0tLS0tLS0KdGNwX2VhdF9za2IoKSAobmV0L2lwdjQvdGNwX2JwZi5jOjE1LTMzKToKCiAg
ICBjb3BpZWQgPSB0Y3AtPmNvcGllZF9zZXEgKyBza2ItPmxlbjsKICAgIFdSSVRFX09OQ0UodGNw
LT5jb3BpZWRfc2VxLCBjb3BpZWQpOwoKVW5jb25kaXRpb25hbDogYXNzdW1lcyB0aGUgZWF0ZW4g
c2tiIHN0YXJ0cyBleGFjdGx5IGF0IGNvcGllZF9zZXEgYW5kIGlzCjEwMCUgdW5yZWFkLiBDYWxs
ZWQgZnJvbSB0aGUgc29ja21hcCB2ZXJkaWN0IHBhdGhzOgogIC0gbmV0L2NvcmUvc2ttc2cuYzox
MDQ3IChfX1NLX1JFRElSRUNUKQogIC0gbmV0L2NvcmUvc2ttc2cuYzoxMDU0IChfX1NLX0RST1Ap
CiAgLSBuZXQvY29yZS9za21zZy5jOjEyMTMgKHBzb2NrIGdvbmUpClRob3NlIHZlcmRpY3RzIHJ1
biB2aWEgdGNwX3JlYWRfc2tiKCkgKG5ldC9pcHY0L3RjcC5jOjE3NTUpLCB3aGljaAp1bmxpbmtz
IHRoZSBxdWV1ZS1IRUFEIHNrYiBhbmQgaGFuZHMgaXQgdG8gQlBGLiBJZiB1c2Vyc3BhY2UgaGFz
IGFscmVhZHkKcGFydGlhbGx5IGNvbnN1bWVkIHRoYXQgaGVhZCBza2IgdmlhIHJlY3Ztc2cgb3IK
Z2V0c29ja29wdChUQ1BfWkVST0NPUFlfUkVDRUlWRSksIGNvcGllZF9zZXEgaXMgYWxyZWFkeSBw
YXN0IHNrYi0+c2VxOwp0aGUgZWF0IHRoZW4gYWR2YW5jZXMgYnkgdGhlIEZVTEwgc2tiLT5sZW4g
LSBkb3VibGUtY291bnRpbmcgdGhlCmFscmVhZHktcmVhZCBwcmVmaXguIGNvcGllZF9zZXEganVt
cHMgcGFzdCB0aGF0IHNrYidzIGVuZF9zZXEgd2hpbGUKcmN2X254dCBzdGF5cyBhYm92ZSBpdC4K
CjMuIERFQ09ERUQgQ1JBU0ggU1RBVEUgKGZyb20gdGhlIGxvcmUgcmVwb3J0KQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KY29waWVkPUFBMjhDNjMzLCBzZXE9
QUEyOEM2MDEsIHJjdm54dD1BQTI4QzYwMgpoZWFkIHNrYiBpcyAxIGJ5dGU7IGNvcGllZF9zZXEg
aXMgMHgzMiBwYXN0IGl0cyBlbmQgPT0gZXhhY3RseSB0aGUKZG91YmxlLWNvdW50ZWQgcHJlZml4
LgpTdGFjazogdGNwX3JlY3Ztc2dfbG9ja2VkIDwtIHJlY2VpdmVfZmFsbGJhY2tfdG9fY29weSAo
dGNwLmM6MTk3OCkKPC0gdGNwX3plcm9jb3B5X3JlY2VpdmUgPC0gdGNwX2dldHNvY2tvcHQoVENQ
X1pFUk9DT1BZX1JFQ0VJVkUpLApmbCAweDQwID0gTVNHX0RPTlRXQUlUIHNldCBieSB0aGUgZmFs
bGJhY2suCgo0LiBISVNUT1JZIC8gSU5UUk9EVUNUSU9OCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KSW50cm9kdWNlZCBieSA5NjViNTdiNDY5YTUgKCJ0Y3A6IHJlYWRfc2tiKCkiKSAyMDIyLTA2
LTE1LgpQcmVzZW50IGFuZCB1bmZpeGVkIGluIDYuMSwgNi4xMi42NiBhbmQgbWFpbmxpbmUgQDU4
MTYxZWFkMiAodmVyaWZpZWQKaWRlbnRpY2FsIHRjcF9lYXRfc2tiKS4gU3RhbGxlZCBmaXggYXR0
ZW1wdHMgd2UgYXJlIGF3YXJlIG9mOgogIC0gZW5kX3NlcS1iYXNlZCByZXdyaXRlIHBvc3RlZCAy
MDI2LTA3LTAyIChubyB2Miwgbm8gcmV2aWV3KQogIC0gRklPTlJFQUQvY29waWVkX3NlcSBzZXJp
ZXMgc3R1Y2sgYXQgdjkgb24gYnBmLW5leHQgc2luY2UgMjAyNi0wMS0yNApMYXN0IHN5emJvdCBj
cmFzaDogMjAyNi0xMC0wOC4KCjUuIFRSSUdHRVIgTUFUUklYIChmcm9tIG91ciBzb3VyY2UgcmVh
ZDsgYm90aCBwYXRocyB2ZXJpZmllZCkKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBLiBwYXJ0aWFsIHJlY3Ztc2cgb24gdGhlIGhl
YWQgc2tiLCB0aGVuIHNvY2ttYXAgdmVyZGljdAogICAoX19TS19SRURJUkVDVC9fX1NLX0RST1Av
cHNvY2stZ29uZSkgZWF0cyB0aGUgc2FtZSBza2IuCkIuIHBhcnRpYWwgZ2V0c29ja29wdChUQ1Bf
WkVST0NPUFlfUkVDRUlWRSkgdmlhIHJlY2VpdmVfZmFsbGJhY2tfdG9fY29weQogICAodGhlIG9y
aWdpbmFsIHN5emJvdCBzdGFjayksIHRoZW4gdmVyZGljdC4KQm90aCBuZWVkIGEgc29ja21hcC9T
S19NU0cgcHJvZ3JhbSBhdHRhY2hlZCAocmVxdWlyZXMgYnBmX2NhcGFibGUoKSkgLQp0aGUgV0FS
TiBpcyBub3QgdW5wcml2aWxlZ2VkLXJlYWNoYWJsZTsgaXQgaXMgc3RpbGwgYSByZWFsIGludmFy
aWFudApicmVhayB3aXRoIGEgcHVibGljIEMgcmVwcm8gb24gdGhlIHN5emJvdCBwYWdlLgoKNi4g
UFJPUE9TRUQgTUlOSU1BTCBGSVgKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgIC0gICB1MzIg
Y29waWVkID0gdGNwLT5jb3BpZWRfc2VxICsgc2tiLT5sZW47CiAgICArICAgdTMyIGNvcGllZCA9
IFRDUF9TS0JfQ0Ioc2tiKS0+ZW5kX3NlcTsKICAgICAgICBXUklURV9PTkNFKHRjcC0+Y29waWVk
X3NlcSwgY29waWVkKTsKCihlbmRfc2VxIGlzIHRoZSB0b3RhbC1jb25zdW1lZCB3YXRlcm1hcmsg
b25jZSB0aGUgd2hvbGUgc2tiIGlzIGVhdGVuLAppbmRlcGVuZGVudCBvZiBob3cgbXVjaCB1c2Vy
c3BhY2UgaGFkIGFscmVhZHkgcmVhZCBmcm9tIGl0LikKCjcuIFdIWSBUSEUgV0FSTiBJUyBOT1Qg
TUVNT1JZIFVOU0FGRVRZIChob25lc3Qgbm90ZSkKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpFdmVyeSBjb3B5IGluIHRjcF9yZWN2bXNnX2xvY2tl
ZCBpcyBndWFyZGVkIGJ5IG9mZnNldCA8IHNrYi0+bGVuOyB3ZQpjb3VsZCBub3QgY29uc3RydWN0
IGFueSBPT0IgZnJvbSB0aGUgZGl2ZXJnZW5jZS4gVGhlIHJlcG9ydCBpcyBmaWxlZCBhcwphbiBp
bnZhcmlhbnQgYnJlYWsgKyBmaXgsIG5vdCBhIHNlY3VyaXR5IGlzc3VlLgoKQW5hbHl6ZWQtYnk6
IExlb25hcmRvIFNvdXphIDxjYXBsZW9uYXJkbzEyQG91dGxvb2suY29tPgo=

--_004_ROAP284MB16278289FDDB6644C099AB3ABD982ROAP284MB1627BRAP_--
