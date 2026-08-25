Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6C4908A8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787699612; cv=none; b=QBLNysqdll0KnHjwmc7dAUcdKNuHY09RmM/gw4P68Xm/v4G5ezUpDpn0M62vWy1rlW7vQgbc5NqjyIRlvCHw0AB7fI1bjbmiwjKbVxbTENKJxbnQbEwJNoNXCaZtOs9jT2LPnPuTnCZhEoxyFbOVvFtrt3po+kZa83SGkmgdh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787699612; c=relaxed/simple;
	bh=+8kyxbzRSdlKPFyXc2RnYu6fLUalD0ATNGrknbK33Zs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HbXKyZ2L50e+fXfmBBb5nZKMSA96v45B5MVDPtNavReSNXcak7AilBb45F8or/TZGyAQ2WqAmA3CS2ZCE69ZYCJQ8Q0gE8WpZnUlTm03QpneljgiS2+63J0MGpURM8nvtojCntNlckR8xMplpday/+PETjASJ0yTLxJYx5N6oIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=HRMy/tYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YENeyYXR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="HRMy/tYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YENeyYXR"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 767437A01B4;
	Tue, 25 Aug 2026 19:13:27 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Tue, 25 Aug 2026 19:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787699606;
	 x=1787786006; bh=9Ie+8tI5rV38pr+8jhODV7bmnON6qshNelvLTCVxfk4=; b=
	HRMy/tYwPLArhdh44gcmiqIzjanE9jqafIfHCOq1QzmgOps0BnYPhAfyHs9lo1Oi
	xFdmNf8DW2WsmIlP7z1orJFwJc5v32PhuMnVMML1fxXfJeebkZDz+Ob9sKr11xfm
	TznnSUoBGJ4bD4D52Sl2XIWac1LnZboeS4yf18zlZja/mMohhwSN99tmTwZSVKLk
	uMCuvoSGPxpHv+JztXIDk1m6LRiZPJP0f1N7apgsuozu1YMWt/Ftva/bRDHxbqxG
	TCjRRPY0Ra42FA4JZfRa6tCuGKkDs3PidRjEUcBe0lhdjJjX3QwYCORIQ+XdgEGt
	ENB0ynU25lrH5w/ZtQ7g8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787699606; x=
	1787786006; bh=9Ie+8tI5rV38pr+8jhODV7bmnON6qshNelvLTCVxfk4=; b=Y
	ENeyYXRYLo+XeN/sItZQWaFc6jX/4OoMnRlI3bs9Ek/HofctTs/Lvbs0NySXzkxW
	gaYjyzen5yvRsI7fGUnXR+x010uImNWrbwz2Il8IpOY0JLXRgF9THXB63lJrVqlY
	25cBK3DgemMvS6BQmC3biEdb0l2eT0Miqa9DGhJTOs+ZoxXi6Go10fDOFSt2DhNR
	wIr5lzOLyibkNWIsgiGjmL0qESFlcNj8Qq4diOjNK/G0CG5hLraQEc4E5cfxrqMy
	1rMFAqXOsAI82/QvGdE1MFdnKiITicTtn+lVC7KCk6aflksuv72qoUVBn3qaJ6Wg
	WxRlNkONpGd2pzmjQ2yIA==
X-ME-Sender: <xms:kCGOanh7ArIWhIaOkLlpHD4qBSM-8-tibltf0Tj9j4h2yiyM_m3_mg>
    <xme:kCGOau01K8Tn85w_vZDEfxa-Y3RTEdrdZFBrItn-z5kMVXmb-sTFJOnd-KpIzFXZD
    yuOx2fczKQoRwkQXDCOPQlv6hHppEAZllWaO-xtjF1nGz7QIArnCkg>
X-ME-Proxy-Cause: dmFkZTFLP25i3xTdpiJ71K88LK8N3kdnnBHPsKW41zeoXzslnDZ/6THlVcRovMiSzf56TE
    NisIrQpYenyw/Y1NJQFv+lrdLZ7YN6SohPVHrTVukycWXE8gRRpG5n46kubOw2KbrwdI/7
    MnSmv0nSHzhLfQJ1LpZwVxPOc1P4zqZyi6QWWxoh5Kryu3a5yPIrK52NUlgrR7+Bk2ByFL
    t/jswnba1kOPiUGfqyEJ1WV5sugNFU/bqIanb+37icj97OUthhpM1RdnEwiJc5l98bzhQF
    S+7EvI1zc2iULH3V++PYuc6HybKhq7gDcE9ShVJrFn0Mw1esON3lq7wy1usMXybxB8FYCE
    T2O93nOssrjd5gII7LhkBGC4LaeO0/4YBLKOoV/GZ7jlSp1Fkp6Z5vKGLk1yNOImHbgrZE
    RhMR0vYzJ1JTZwI95ptELfrhYgseNENVe9xspwUZvNjyN2aZ980H45iyMN0mzYF9IhhCco
    2nYHImXqCXSiqmDetJeVA50VY6Dd7rDl1nr7HAi/UzFkuNVKwhioCwgOiDhIBRiBjW0dOl
    m2xGz1Lilm52VKUVjAG+MOn2VXjH7AEifsuwX/0wX6VGFz02xVVAvXJ+Jwn/ejrcQJi4gU
    IFZ8lv/C4rRFQCNiaBWvQn9Fhra2FkdoqY0qSliPbc8cgQ+g+ftKdt3ufLXg
X-ME-Proxy: <xmx:kyGOagzLHzq5mCDXlXtwXKdZ3Sm9St5THTaVrWfEDF2oyya4BXzU4w>
    <xmx:kyGOaqzbc0yeBk_1FSnrqO4qZ5azXErmmFYA7cOvhgI2HO-9vOvu1g>
    <xmx:kyGOagUbK-gLBR8rs841c3k0CZEhjWPyJ9t2bBLiqtTH2Xm71ltbJQ>
    <xmx:kyGOahRL5-BZJjMt6jYphQ4A6T1WVvZrtZW0uMfhiOiKeIvrV9naUA>
    <xmx:liGOai9YwieFuIwrS8Xtjx1NqYbUU0BnHSNqRtCWSxC8udtqBimXZQSU>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7FDCF2F81646; Tue, 25 Aug 2026 19:13:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 02:13:00 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>,
 "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
 "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 "Alice Mikityanska" <alice@isovalent.com>
Message-Id: <a4fb63c7-4d1a-42bd-97ba-1f5c6bb0ad69@app.fastmail.com>
In-Reply-To: <willemdebruijn.kernel.351b61ea6fb41@gmail.com>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
 <20260822115717.1161782-4-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.351b61ea6fb41@gmail.com>
Subject: Re: [PATCH net v3 3/4] selftests: net: Test UDP length overflow with PMTU
 discover and big MTU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026, at 21:50, Willem de Bruijn wrote:
> Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>>=20
>> Two previous commits fixed overflow of UDP length when setsockopt
>> IP(V6)_MTU_DISCOVER is set to IPV6_PMTUDISC_DO or IP(V6)_PMTUDISC_PRO=
BE,
>> and a large packet is sent over a netdev with an unusually large MTU.
>>=20
>> This commit adds the selftests that replicate the described steps to
>> reproduce for IPv6 and IPv4, and also one more test that ensures that
>> sending UDP jumbograms over a raw socket is still possible after the
>> fix.
>>=20
>> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
>> ---
>>  tools/testing/selftests/net/Makefile         |   1 +
>>  tools/testing/selftests/net/cork_fragsize.py | 130 +++++++++++++++++=
++
>>  2 files changed, 131 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/cork_fragsize.py
>>=20
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/sel=
ftests/net/Makefile
>> index 0f5c178bc224..c6d332c90a54 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -25,6 +25,7 @@ TEST_PROGS :=3D \
>>  	cmsg_so_mark.sh \
>>  	cmsg_so_priority.sh \
>>  	cmsg_time.sh \
>> +	cork_fragsize.py \
>>  	double_udp_encap.sh \
>>  	drop_monitor_tests.sh \
>>  	ecmp_rehash.sh \
>> diff --git a/tools/testing/selftests/net/cork_fragsize.py b/tools/tes=
ting/selftests/net/cork_fragsize.py
>> new file mode 100755
>> index 000000000000..d89ef9892329
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/cork_fragsize.py
>> @@ -0,0 +1,130 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
>> +
>> +from lib.py import ksft_run, ksft_exit, ksft_true, KsftSkipEx
>> +from lib.py import ip, NetNS, NetNSEnter
>> +import errno
>> +import gzip
>> +import os
>> +import socket
>> +import struct
>> +import subprocess
>
> Various pylint and ruff issues, such as ordering imports

I'll make sure to run pylint and ruff before submitting Python.

For the imports: I'll reorder them as needed, but ruff also suggests to
squash all lib.py imports into a single line. I see that other
selftests also separate lib.py imports into meaningful groups that I'm
planning to keep.

For the missing docstrings: I see that other selftests don't have
them either.

I'll fix the rest (and probably use context manager for the dummy
device).

>> +
>> +
>> +IP_MTU_DISCOVER =3D 10
>> +IP_PMTUDISC_PROBE =3D 3
>> +IPV6_MTU_DISCOVER =3D 23
>> +IPV6_PMTUDISC_DO =3D 2
>> +IPV6_PMTUDISC_PROBE =3D 3
>> +IPV6_TLV_JUMBO =3D 194
>> +
>> +
>> +def check_kernel_config(option) -> bool | None:
>> +    for filename, method in [
>> +        ('/proc/config.gz', gzip.open),
>> +        (f'/boot/config-{os.uname().release}', open),
>> +    ]:
>> +        try:
>> +            with method(filename, 'rt') as config:
>> +                for line in config:
>> +                    if line.rstrip() =3D=3D f'{option}=3Dy':
>> +                        return True
>> +                return False
>> +        except OSError:
>> +            continue
>> +
>> +
>> +def assert_debug_kernel() -> None:
>> +    res =3D check_kernel_config('CONFIG_DEBUG_NET')
>> +    if res is None:
>> +        print("WARN: Can't read kernel config; assuming debug kernel=
, and running the test")
>> +    elif not res:
>> +        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
>> +
>> +
>> +def check_dmesg_clean(func) -> bool:
>> +    dmesg =3D subprocess.Popen(['dmesg'], stdout=3Dsubprocess.PIPE)
>> +    result =3D subprocess.run(['grep', '-q', f'WARNING:.*{func}'], s=
tdin=3Ddmesg.stdout)
>> +    dmesg.wait()
>> +    return result.returncode !=3D 0 and dmesg.returncode =3D=3D 0
>> +
>> +
>> +def ip_setup(ns: NetNS, mtu: int, ipv6: bool) -> None:
>> +    ip('link add dummy type dummy', ns=3Dns)
>> +    ip(f'link set dummy mtu {mtu}', ns=3Dns)
>> +    ip('link set dummy up', ns=3Dns)
>> +    flag =3D '-6' if ipv6 else ''
>> +    nodad =3D 'nodad' if ipv6 else ''
>> +    addr_local =3D 'fd00::1/64' if ipv6 else '10.0.0.1/24'
>> +    addr_remote =3D 'fd00::2' if ipv6 else '10.0.0.2'
>> +    ip(f'{flag} addr add {addr_local} dev dummy {nodad}', ns=3Dns)
>> +    ip(f'{flag} neigh add {addr_remote} lladdr 02:00:00:00:00:02 dev=
 dummy nud permanent', ns=3Dns)
>> +
>> +
>> +def test_ipv6() -> None:
>> +    assert_debug_kernel()
>> +
>> +    with NetNS() as ns:
>> +        ip_setup(ns, 65576, True)
>> +
>> +        with NetNSEnter(ns):
>> +            with socket.socket(socket.AF_INET6, socket.SOCK_DGRAM) a=
s fd:
>> +                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER=
, IPV6_PMTUDISC_DO)
>> +                try:
>> +                    fd.sendto(b' ' * 65528, ('fd00::2', 1234))
>> +                except OSError as e:
>> +                    # Ignore EMSGSIZE: it happens on kernels with th=
e fix.
>> +                    if e.errno !=3D errno.EMSGSIZE:
>> +                        raise
>> +
>> +        ip('link del dummy', ns=3Dns)
>> +
>> +    ksft_true(check_dmesg_clean('udp_v6_send_skb'), 'WARNING detecte=
d in dmesg')
>> +
>> +
>> +def test_ipv4() -> None:
>> +    assert_debug_kernel()
>> +
>> +    with NetNS() as ns:
>> +        ip_setup(ns, 65556, False)
>> +
>> +        with NetNSEnter(ns):
>> +            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as=
 fd:
>> +                fd.setsockopt(socket.IPPROTO_IP, IP_MTU_DISCOVER, IP=
_PMTUDISC_PROBE)
>> +                try:
>> +                    fd.sendto(b' ' * 65528, ('10.0.0.2', 1234))
>> +                except OSError as e:
>> +                    # Ignore EMSGSIZE: the check happens after the W=
ARN is printed.
>> +                    if e.errno !=3D errno.EMSGSIZE:
>> +                        raise
>> +
>> +        ip('link del dummy', ns=3Dns)
>> +
>> +    ksft_true(check_dmesg_clean('udp_send_skb'), 'WARNING detected i=
n dmesg')
>
> These two are identical apart from 7 constants.
>
> Dedup and use @ksft_variants decorators?

Tried to balance readability vs deduplication when introducing
ip_setup... But OK, I can go all the way. Thanks for the suggestion of
@ksft_variants!

>> +def test_ipv6_jumbo() -> None:
>> +    with NetNS() as ns:
>> +        ip_setup(ns, 65584, True)
>> +
>> +        with NetNSEnter(ns):
>> +            with socket.socket(socket.AF_INET6, socket.SOCK_RAW, soc=
ket.IPPROTO_UDP) as fd:
>> +                hopopts =3D struct.pack('!BBBBI', 0, 0, IPV6_TLV_JUM=
BO, 4, 65544)
>> +                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_HOPOP=
TS, hopopts)
>> +                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_CHECK=
SUM, 6)
>> +                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER=
, IPV6_PMTUDISC_PROBE)
>> +                udp =3D struct.pack('!HHHH', 1234, 1234, 0, 0) + b' =
' * 65528
>> +                fd.sendto(udp, ('fd00::2', 0))
>> +
>> +        ip('link del dummy', ns=3Dns)
>
> Should this have some test at the end? check_dmesg_clean or perhaps
> a socket receiving the data.

No =E2=80=94 when the test fails, sendto() raises an exception with EMSG=
SIZE.
There is nothing in dmesg on failure (hence no assert_debug_kernel
either). The successful return from sendto is the criterion.

Thanks for the review!

>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +    ksft_run([
>> +        test_ipv6,
>> +        test_ipv4,
>> +        test_ipv6_jumbo,
>> +    ])
>> +    ksft_exit()
>> --=20
>> 2.55.0
>>
