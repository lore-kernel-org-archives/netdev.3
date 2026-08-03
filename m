Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76E9463
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744081; cv=none; b=AF/O0/nlnIwFvndI07xFakWs8dI8ySRpDYB5uLcrATR34okOcIQ4Oovtrd0pDHbcPDUzl9oKrTGL7wfdM6akxGF8nFPWjUhfbM8p1CRbnTgBCrxhzENDE8sQU2bVrYSKYnwF3u7FlXjqDGiYAPFaYM7WhNe0RbVjT2FDmOqb94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744081; c=relaxed/simple;
	bh=Y6Iobmfjdv2QPyopt8ifpiNvIE3fl2snHzpGNT44/Xo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=twSNqvlVrwn3H0lkY4BWAoflp6joO3XKAo3boQ1TzNKH8RZbC/W6/ihmA+bHWWRQWQdf93yP1OOrn4UePPcua9Kqejct/6pR/v5dJKC97GkKB849p/3KK0r3d7JLt+GEylMAXj8W1BuqL6fHh/TWJ9tEKH6rPQzm2PfTx4YHR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz4t1785744027t5b428cb5
X-QQ-Originating-IP: MhhT18gcvevJf047QMn9HuexwxcF8yxWrq/8Yry1DbE=
Received: from smtpclient.apple ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 16:00:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 216033531120402893
EX-QQ-RecipientCnt: 9
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 0/5] net: wangxun: improve statistics support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20260731164407.4ca13f14@kernel.org>
Date: Mon, 3 Aug 2026 16:00:15 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FB351D7-A14F-4B30-A172-6D81417E4E69@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731164407.4ca13f14@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MIBXG9KNq+3G9ErhWerfn7D6fIz16RcEdP+aVIpRTSfPGS1QckatPfwK
	4/hYX6+djUCxg3/NeOYDoD0kq7fVZnLs6zNQ2LQpgLuyodRP/ymTRtEMM+hi2/Ev32VqmZ1
	DpfWYRdAb/x0zPn/P3DDT3Zu8SFELUTYDuqRc14SbKYEOZe90UqBB3GVugtLb60QSZsxWSf
	lVgFJE3PdQjq0yteIa+/aZTb4y+45Eq44ly1M7yriusNE5QLX4VuyP/iZQAO85wk5EIBtrz
	H3lnfEaLIMWJXZ+Bf3I070cpBdjQDVpHf9umEtDFE8XDtg6SeZQGCbCM9wmJiUDMb4jbMIN
	ZGQIExzTI+LEc7gon+NoWOzDRDKm2iGADsIiRUnLLfA/N5B0DjPMAahSrReoEaMx54Bf9ro
	7+73hq2vgwTBEhJVq5y+2KXIEoFvCmgKvtnDQPGrOnEi9QZYwyUHJecZDJApL3ZIxnkdYx7
	VTwqNA8my3GjP783rNqWZc8tblRPG9LrvW34VglEG5kGhBNYH3XIXtHy7G9SglEb9gcft7r
	VxqjDkOZCzub1CJ2zOkiDboe2TvFICpUobbvdB9Bmi1I+Gnr8C32R6HGqmii38NvzpmbvGQ
	jbU7RgVtqfb4pw4buEjVj8XJgiGEWt6MxhPP7nWINWZsUi+G+OspbpV27LZ0DSoLvOBtEes
	rL57RSUkveYAktIaPPBTOLx4SOJkhgyXCXzVVYlWqKVCfBehkAMEp5zZqrhw/IoGRVLDnRw
	UmH2QYeohwSETAyFSJnoPJuXYAlCDyLd6q2CAJXgs220CNJtytGoUqmADcPC4YspnXgUD6S
	RhnMAruVMOLNPWw7JxtRydRn9HT8oxWnpM0BthbzgftjGAR27PUiy/rwSEJxSxUt01Tqn1o
	GwsAlhO15Z6ltyKYI/BxgJgZCg+uwfCUBVMJwEBrixZMTDNwiju9iKI1Skhcj3mlwVaMmx3
	hO4GnKVi6o48DaIdlK/O22ZmPx3ZPF3qeUhBITfCOUcXElEWi04WCo6lu+ejq60HN5TtJGz
	6yMABdVIqchIwSwaFXiPmQCj69w+f8NPcbNte493vhdkT0ba9HhWpDwT+DaNZL3ouSvA40k
	b6Zu0dTZjwKFT5njT/eR720B0v3ZgVNhy/0T4KYIl78a6fu322IeVtOmp0kpCDLN7UZfv65
	Zo/cfiNGbZx5NTM=
X-QQ-XMRINFO: MPJ6Tf5t3I/yszlkyYblB6BTkL4Q6eR+Bw==
X-QQ-RECHKSPAM: 0

Hi,

=E2=9E=9C PF
python3 -m pyynl.cli \ --spec =
/root/Work/mirror-net-next/Documentation/netlink/specs/netdev.yaml \ =
--dump qstats-get \ --json '{"ifindex":160,"scope":"queue"}' =
[{'ifindex': 160, 'queue-id': 0, 'queue-type': 'rx', 'rx-alloc-fail': 0, =
'rx-bytes': 16737, 'rx-csum-bad': 0, 'rx-csum-complete': 28, =
'rx-packets': 61}, {'ifindex': 160, 'queue-id': 1, 'queue-type': 'rx', =
'rx-alloc-fail': 0, 'rx-bytes': 1507, 'rx-csum-bad': 0, =
'rx-csum-complete': 28, 'rx-packets': 11}, {'ifindex': 160, 'queue-id': =
2, 'queue-type': 'rx', 'rx-alloc-fail': 0, 'rx-bytes': 0, 'rx-csum-bad': =
0, 'rx-csum-complete': 28, 'rx-packets': 0}, {'ifindex': 160, =
'queue-id': 3, 'queue-type': 'rx', 'rx-alloc-fail': 0, 'rx-bytes': 5831, =
'rx-csum-bad': 0, 'rx-csum-complete': 28, 'rx-packets': 17}, {'ifindex': =
160, 'queue-id': 0, 'queue-type': 'tx', 'tx-bytes': 880, 'tx-packets': =
8}, {'ifindex': 160, 'queue-id': 1, 'queue-type': 'tx', 'tx-bytes': =
4672, 'tx-packets': 36}, {'ifindex': 160, 'queue-id': 2, 'queue-type': =
'tx', 'tx-bytes': 6860, 'tx-packets': 20}, {'ifindex': 160, 'queue-id': =
3, 'queue-type': 'tx', 'tx-bytes': 992, 'tx-packets': 16}]

=E2=9E=9C VF
python3 -m pyynl.cli --spec =
/root/Work/mirror-net-next/Documentation/netlink/specs/netdev.yaml =
--dump qstats-get --json '{"ifindex":236,"scope":"queue"}' [{'ifindex': =
236, 'queue-id': 0, 'queue-type': 'rx', 'rx-alloc-fail': 0, 'rx-bytes': =
16836, 'rx-csum-bad': 0, 'rx-csum-complete': 0, 'rx-packets': 58}, =
{'ifindex': 236, 'queue-id': 1, 'queue-type': 'rx', 'rx-alloc-fail': 0, =
'rx-bytes': 1507, 'rx-csum-bad': 0, 'rx-csum-complete': 0, 'rx-packets': =
11}, {'ifindex': 236, 'queue-id': 2, 'queue-type': 'rx', =
'rx-alloc-fail': 0, 'rx-bytes': 3448, 'rx-csum-bad': 0, =
'rx-csum-complete': 0, 'rx-packets': 24}, {'ifindex': 236, 'queue-id': =
3, 'queue-type': 'rx', 'rx-alloc-fail': 0, 'rx-bytes': 7546, =
'rx-csum-bad': 0, 'rx-csum-complete': 0, 'rx-packets': 22}, {'ifindex': =
236, 'queue-id': 0, 'queue-type': 'tx', 'tx-bytes': 0, 'tx-packets': 0}, =
{'ifindex': 236, 'queue-id': 1, 'queue-type': 'tx', 'tx-bytes': 2750, =
'tx-packets': 25}, {'ifindex': 236, 'queue-id': 2, 'queue-type': 'tx', =
'tx-bytes': 12671, 'tx-packets': 53}, {'ifindex': 236, 'queue-id': 3, =
'queue-type': 'tx', 'tx-bytes': 1670, 'tx-packets': 25}]

=EF=8C=9B root @roy-System-Product-Name =E2=9E=9C =
=E2=80=A6/mirror-net-next/tools/testing/selftests =EF=87=91 =EE=9C=82  =
=EE=82=B6=EF=90=98 main=EE=82=B4 ?3  =EF=90=BA 15:54:46=20
=E2=9C=98  python3 ./drivers/net/stats.py
TAP version 13
1..8
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.check_fec_hist
ok 4 stats.pkt_byte_sum
ok 5 stats.qstat_by_ifindex
ok 6 stats.check_down
ok 7 stats.procfs_hammer
# completed up/down cycles: 76
ok 8 stats.procfs_downup_hammer
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0


> 2026=E5=B9=B48=E6=9C=881=E6=97=A5 07:44=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 31 Jul 2026 15:49:53 +0800 Mengyuan Lou wrote:
>> This series improves statistics support for Wangxun drivers.
>> Currently, VF drivers do not periodically refresh software =
statistics,
>> do not expose per-queue statistics through the generic netdev =
statistics
>> interface, and do not provide ndo_get_stats64().
>> The first patch fixes the suspend/resume flow for wxvf so the service
>> task and device lifecycle are handled correctly. The second patch =
makes
>> wx_update_stats() safe for VF drivers by allowing it to cope with
>> temporarily missing queue pointers during queue reconfiguration.
>> Once periodic statistics updates are available, libwx can implement
>> netdev_stat_ops, allowing Wangxun drivers to expose standard =
per-queue
>> statistics through the generic netdev qstats infrastructure.
>=20
> Were you able to run the qstats-related selftests against these =
devices?
>=20
 I have tested these devices with netdev.yaml for pf/vf devices.



