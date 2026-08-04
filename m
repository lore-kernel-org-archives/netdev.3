Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8C2FE575
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824146; cv=none; b=tydybsrF1Baeh0FB7ZZXcO6gQH1NvwykXkIn+DCXqLABveaN+oiPsIRH7CMixc0ftSy6vuHrq/XfGO5iiyyRxpbXk3T0eRdBwNMcU1I25NOI1GywiJlzz0p0PnV52rtWvBmkWdOwPTk9M5Uwhk4MsDVVOReLvzKGCtI8mQKopsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824146; c=relaxed/simple;
	bh=OMTYknmyi+Kf0MkGf+5N5zv/GKFdOXnsgRB6z8/YHwM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O6hJI7fKftwTIyKKpqD+u6X5Gq0vlr8EVv2coQ6y81db5r+qJdYtAY4dibqKee5eBdB8wWnBn+0N6ulgv2gIwXbznE2cpCNCDokbJ2oLfn0JRRF7/hNJ5hOFAJWAdxISllI3dJraa25xtC4Q+jDVLuv543o0J54MgfINMkt0/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpsz10t1785824086t8cfb8f8e
X-QQ-Originating-IP: DO/ilig9mEocfbU+OSEUl1tCGiyNx2mbJJ+64EjgAWQ=
Received: from smtpclient.apple ( [122.235.196.25])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 14:14:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12982565464166425355
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
In-Reply-To: <20260803135915.1fd95602@kernel.org>
Date: Tue, 4 Aug 2026 14:14:34 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F44139D9-C43A-4D62-BEF7-C56161FE5D4C@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
 <20260731164407.4ca13f14@kernel.org>
 <5FB351D7-A14F-4B30-A172-6D81417E4E69@net-swift.com>
 <20260803135915.1fd95602@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NpfbsqbTlzxU138b1mTWDtejPvmZpoV5C3voYi3+bcsumT/pj37iwFx+
	o7iKOJE7U96bka11rkunusm87xBNKvx3U1VtEB+bsBi7JYi8zzAEga0vkdZLxQ1iRGJOHep
	Kiis5Z/455y4JVk9muT75jyd6ZoqIVtXOqs1VwOyNEupZy8O8cMKEdrKqzdBJNxIcqKhNfG
	F/bopu9gcqyc/5gRGuaMUnOwdSAWCzLxs+78n1iloaRVbS8wgmL/8QwA1YBve5aXofpWg25
	yjoAruEGGnMr6uwB790QUGvuUzmnPIyFj/R1CurOB8WNjjKNIpfQmUzFp9CxusqXPJE5zRD
	yIhl8sjesxhdighlEW6syPl7Ua5cFRqUoeF8nUNpvo7tECKFKVo3De9nnTRrrLD9TilQo08
	7uTU6hgWtBtAHau/2vFix4svAfxe0/Or9H/iKfj0HRpGyObKpjpMX26iM5Djtjxa+SYKZ2R
	MmH4gGhZvkPaR3RpqjK3ISjf2lqQZXGO3Iz/CZcHPeYvWMdn2lEiJXl3hharPopN5p7uiNp
	HC8Yr5usRjNIOjWiUBsi8zUee1EJvljt22KUf2R6vIPfAoQFWk+IVKfeCnBN2DmIbvXnhxO
	eflBMik0UdMr5m7bsmthLvXJx++gBRrZPiIEHrI9aaFL/m08NYRYXj+1yuxJuKLKRIfOP+v
	46T4WgP+NYPsXz7AhPheA0ajceGBjIn0zJzl9q+d0EJQUuN9r5Q8aE91tHCjqzoqBwVxVeC
	ZYgN0139M5zLhxzMKnjXGSS1rU5gq7ihUxdkSX3UxI2IyBgbYOtcYOg6t0J3PWTMwd3RG6+
	Tg69/iAoUxWfOVHYpD5rmciSnzar7k0kVeAMfdBQ8PQw0P/qE/CQ/lhxiHRX80jd5GNGWDM
	/+nZnX0azMKqvYnUzxWQk5Vhv+mookSwQw7/kqavT/EzsU/OCTylxykHWepE57f7rYL+I63
	ZroWlgnBS/uKMGuy90JQ2BWIrw/0c6RKchc7ZsfQC4totxYJSzGDAhBR2RS+1KWoHs+/zxe
	EG1c8eCTCP+Hn5CQLVYnO0w0CdXV6zQ9fa6ca4A/hY53U1ZSLeQXaJ3FwGOfo//I+IsOQ9F
	/9RQcpU2S4dACeO4apC594=
X-QQ-XMRINFO: NS+P29fieYNwXa6WNmDbxN9kmko6wt4pnw==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B48=E6=9C=884=E6=97=A5 04:59=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 3 Aug 2026 16:00:15 +0800 mengyuanlou@net-swift.com wrote:
>> root @roy-System-Product-Name =E2=9E=9C =
=E2=80=A6/mirror-net-next/tools/testing/selftests =EF=87=91 =EE=9C=82  =
=EE=82=B6=EF=90=98 main=EE=82=B4 ?3  =EF=90=BA 15:54:46=20
>> =E2=9C=98  python3 ./drivers/net/stats.py
>> TAP version 13
>> 1..8
>> ok 1 stats.check_pause
>> ok 2 stats.check_fec
>> ok 3 stats.check_fec_hist
>> ok 4 stats.pkt_byte_sum
>> ok 5 stats.qstat_by_ifindex
>> ok 6 stats.check_down
>> ok 7 stats.procfs_hammer
>> # completed up/down cycles: 76
>> ok 8 stats.procfs_downup_hammer
>> # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
> Thanks, did you set up the env variables like NETIF?
> The context you shared does not specify how you set things up..
>=20

Thanks, I just set NETIF to PF/VF(ngbe) devices. And do the tests again.


=E2=9C=98  NETIF=3Denp6s0f0 python3 -u ./drivers/net/stats.py
TAP version 13
1..8
ok 1 stats.check_pause
ok 2 stats.check_fec # SKIP FEC not supported by the device
ok 3 stats.check_fec_hist # SKIP FEC not supported by the device
ok 4 stats.pkt_byte_sum
ok 5 stats.qstat_by_ifindex
ok 6 stats.check_down
ok 7 stats.procfs_hammer
# completed up/down cycles: 50
ok 8 stats.procfs_downup_hammer
# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:2 error:0

dmesg -w

=E2=80=A6=E2=80=A6
[1283721.111104] ngbe 0000:06:00.0: removed PHC on enp6s0f0
[1283721.187152] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[1283721.187455] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[1283721.187496] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[1283721.262749] ngbe 0000:06:00.0: removed PHC on enp6s0f0
[1283721.286142] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[1283721.286289] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[1283721.286329] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[1283721.309968] ngbe 0000:06:00.0: removed PHC on enp6s0f0
[1283721.386142] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[1283721.386389] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[1283721.386430] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[1283721.460411] ngbe 0000:06:00.0: removed PHC on enp6s0f0
[1283721.484139] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[1283721.484255] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[1283721.484295] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[1283721.506989] ngbe 0000:06:00.0: removed PHC on enp6s0f0
[1283721.583146] ngbe 0000:06:00.0 enp6s0f0: PHY [ngbe-600:00] driver =
[Generic FE-GE Realtek PHY] (irq=3DPOLL)
[1283721.583446] ngbe 0000:06:00.0: registered PHC device on enp6s0f0
[1283721.583487] ngbe 0000:06:00.0 enp6s0f0: configuring for =
phy/rgmii-rxid link mode
[1283724.663809] ngbe 0000:06:00.0 enp6s0f0: Link is Up - 1Gbps/Full - =
flow control rx/tx
[1283724.855515] ngbevf 0000:07:00.4 enp6s0f0v1: Link is Up - 1Gbps
[1283724.919544] ngbevf 0000:07:00.0 enp6s0f0v0: Link is Up - 1Gbps
[1283726.903575] ngbevf 0000:07:00.4 enp6s0f0v1: Link is Down
[1283727.927585] ngbevf 0000:07:00.4 enp6s0f0v1: Link is Up - 1Gbps


=E2=9C=98  NETIF=3Denp6s0f0v0 python3 -u ./drivers/net/stats.py
TAP version 13
1..8
ok 1 stats.check_pause # SKIP pause not supported by the device
ok 2 stats.check_fec # SKIP FEC not supported by the device
ok 3 stats.check_fec_hist # SKIP FEC not supported by the device
ok 4 stats.pkt_byte_sum
ok 5 stats.qstat_by_ifindex
ok 6 stats.check_down
ok 7 stats.procfs_hammer
# Exception| Traceback (most recent call last):
# Exception|   File =
"/root/Work/mirror-net-next/tools/testing/selftests/net/lib/py/ksft.py", =
line 420, in ksft_run
# Exception|     func(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File =
"/root/Work/mirror-net-next/tools/testing/selftests/net/lib/py/ksft.py", =
line 257, in wrapper
# Exception|     return func(*args, **kwargs)
# Exception|   File =
"/root/Work/mirror-net-next/tools/testing/selftests/./drivers/net/stats.py=
", line 268, in procfs_downup_hammer
# Exception|     channels =3D ethnl.channels_get({'header': =
{'dev-index': cfg.ifindex}})
# Exception|   File =
"/root/Work/mirror-net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1440, =
in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File =
"/root/Work/mirror-net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1397, =
in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not =
supported
# Exception|=20
not ok 8 stats.procfs_downup_hammer
# Totals: pass:4 fail:1 xfail:0 xpass:0 skip:3 error:0

Dmesg -w

[1283852.025298] ngbevf 0000:07:00.0 enp6s0f0v0: Link is Up - 1Gbps
[1283869.049493] ngbevf 0000:07:00.0 enp6s0f0v0: Link is Up - 1Gbps


