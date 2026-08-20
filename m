Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542821D54FA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248873; cv=none; b=EiQnRNc9GY/OZdVDsvbbVKL1hMYZha6jyeaEMplI5OcZE5L9DX1+c95qjtfHSja2rB6uLSpLV3qTjByxdCB/aXw9bqZXGq1XkvNpljSoNXIHIJ6MpQSCLB305G2oWylx8YMfPTzX+NZ/cbNiEe9vZ7ucMzGVxiT8RcI7AZM9Fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248873; c=relaxed/simple;
	bh=VEXnQra9k6V+m354UMX/hahQNUSRIlisEfWNAK66TYc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OCpR+s4jlEn3lJr4XXd4h0uDJ7PQaNDxwMTy2l1dK3wRzIYZFZA+oBMZ8Ith+b4FYvuyZ0gQDoe6JShOuHrs7TrRpYW8zRf27vweKRLR4EZOE+YlkDlPFv4dZpfPbNPryWmcaYjRglaQmu5Z6sCjzVnmLbVnde1dzecT81T20CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIAkTUod; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIAkTUod"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ff20870ac7so1452806d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248871; x=1787853671; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oScT+ENnlXTLQHf3HxenqBsWnHCI1YjhKxNuZRXNgT8=;
        b=LIAkTUod2Crl2f2xJ7dHCxcXtDqnuiHxkc6dRtKLzVLKTC36dvtr5EJC1aVTmFKO/c
         2LomNFBjCHB81WunlU/0MOrh6fL7PSfYIcX4b/eCi3t5jaBIuveq93LRcIzAcQnHKGD2
         KJaGOy/DS10eJLDLYXC2HERdDBDADZM8rKx5eN8PdByi4/UOo7XOyOgkwPdAuwbXA/e1
         juuJVbedX90hZHKI9vHyTHJJapBWcr/Zvx+aQHM0wDt1yTxaNX0N6XWSIsu8eBHwpMrG
         4AxlxyU4xiERF5XMVoCrwZRmHSFd/OrAfOL2taQUUv4n03k53S7cX0fPgKz4beH9I18V
         MCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248871; x=1787853671;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oScT+ENnlXTLQHf3HxenqBsWnHCI1YjhKxNuZRXNgT8=;
        b=jZb9bDtkSLUGksiDMqBCdf9UFK6JeWaUR4dYK+jvIWfl8qos7KpmrOPgasPNRZLMsV
         Iawr9TsS+KCwnVDZ5TRJCdWiIkQGzEadIY7f3IaqSHfJRcFmIfLRqXzT5dnzmJLjTdax
         LCOkOz0VVAMuXLpIu4UjkcHihAbIZNo/IPwujxRQgTTf+h3lbYrQzQpHPnPua29mTq+3
         nv8M4J2DZx5GmDkQh2xbLQm4yezQHiP6VYoPaDhzUgCgypK7HagGqg6AUBvyrlZXFFUj
         /Kk1SjLTVcuR8ORC+l63sXjbwIfoxPdiceFVIo3cP1E8W9DlQBYymOj4q2NhAKC5IX71
         0PWg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3Pe7BxVC+8jNyPZcXDqfZHWEHTKxDo0/0geKdf6Qznsz7cjeW/aDHcxhdqk7WBRBR0fQEpvk=@vger.kernel.org
X-Gm-Message-State: AFuF++k1xn5XWsininBQaBzkUhrkt3y14vS9rgC08APuafY3NxTA4+Jv
	hoCpmOf4DDZkioE5T9o4ksARgkhd0/1G9WZsF/a65406zB4bAcakMAyCEXQS0KZW
X-Gm-Gg: AR+sD11JmRfRBrw3Qr+K4txb2JAjO/3GgRxSWDMUbeN0hSrd15X22cuWvbzXRfZ+nJz
	NO5Bpe5wSqzsTowFfMDJfwG3eccbwmeuaQuUB6DZ3q3ooSvqQZPkAsaxlkFoGYIWJVmJYay0la/
	H40254bEKN/+CXjFKqIqIbrLAAoRvCSh/CPZvn/GmSMNaa0T6by3p2+LLc3YEdvzisWI7cuyX/x
	4aVzgiz6gPH3urgwAO5BDjrDOqiO1Xjg0YYA6YLMHScrTUGKDXkG7nITuGWP2bdrl49IDbnlVzk
	geYipyYmRtqcFgzfMOob+Ur7BLV2ay0c0d13S7J/uW5uCBAt5DanH289Jk5jsMNRGPIY7GhJT4S
	h2H5Gx8S2GcRNg/heFAgs0Vb/CKMBansgvsZRMBv2SgcomaAwNxooKf3DhGGvlvSkghj9Ao6Weo
	X+tzpszVlXNh2+UUyJTrjXzjCKzcG6Y6fV8XBR/VdD11IbsAJeZH+n6Ybh72Wmq7bwKUEXFjJfU
	e0Il1m2n0qUtltmQY0D+bXyj2bdZfs=
X-Received: by 2002:a05:6214:2a49:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-90c80942e22mr127546d6.4.1787248870845;
        Thu, 20 Aug 2026 11:01:10 -0700 (PDT)
Received: from smtpclient.apple ([165.85.199.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b4ad5sm43810486d6.42.2026.08.20.11.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:01:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] nfc: KASAN: slab-use-after-free in nfc_llcp_rx_skb
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <CANn89iL2_QhxnZvng7LJ-Rx8KSX5pvymYf_mBgP8aFSeVkPY=g@mail.gmail.com>
Date: Thu, 20 Aug 2026 14:00:37 -0400
Cc: David Heidelberg <david@ixit.cz>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E2F7328-DA5E-428D-8A2B-37479B1435EE@gmail.com>
References: <20260819002050.3476701-1-shuangpeng.kernel@gmail.com>
 <CANn89iL2_QhxnZvng7LJ-Rx8KSX5pvymYf_mBgP8aFSeVkPY=g@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Aug 19, 2026, at 03:55, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Wed, Aug 19, 2026 at 2:21=E2=80=AFAM Shuangpeng Bai
> <shuangpeng.kernel@gmail.com> wrote:
>>=20
>> Hi Kernel Maintainers,
>>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in nfc_llcp_rx_skb
>>=20
>> on commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c (2026-01-04)
>=20
> Are you sure this was not already fixed by 2b5dd4632966
> ("nfc: llcp: add missing return after LLCP_CLOSED checks") ?
>=20

You're right. I overlooked commit 2b5dd4632966. I confirmed that this =
issue
has already been fixed by it.
Sorry for the noise, and thanks for pointing it out.

>>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/70e3bdc241dbd675970fe89f30f0b84e
>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>> Decoded source path:
>>=20
>> use: net/nfc/llcp_core.c:1185 in nfc_llcp_recv_disc(), reading =
sk->sk_state
>>     after nfc_llcp_sock_put() at line 1182; DISC dispatch is called =
from
>>     net/nfc/llcp_core.c:1483 in nfc_llcp_rx_skb().
>> free: concurrent socket release drops the final reference through
>>      net/nfc/llcp_sock.c:646 sock_put(), then sk_free() releases the =
same
>>      struct nfc_llcp_sock allocation.
>>=20
>> [   81.172360][  T830] BUG: KASAN: slab-use-after-free in =
nfc_llcp_rx_skb (net/nfc/llcp_core.c:? net/nfc/llcp_core.c:1483)
>> [   81.173044][  T830] Read of size 1 at addr ffff888119369812 by =
task kworker/1:2/830
>> [   81.173940][  T830] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
>> [   81.173941][  T830] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+ PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   81.173943][  T830] Workqueue: events nfc_llcp_rx_work
>> [   81.173946][  T830] Call Trace:
>> [   81.173947][  T830]  <TASK>
>> [   81.173952][  T830]  print_report (mm/kasan/report.c:379 =
mm/kasan/report.c:482)
>> [   81.173959][  T830]  kasan_report (mm/kasan/report.c:597)
>> [   81.173965][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:? =
net/nfc/llcp_core.c:1483)
>> [   81.173973][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
>> [   81.173976][  T830]  process_scheduled_works =
(kernel/workqueue.c:3262 kernel/workqueue.c:3340)
>> [   81.173980][  T830]  worker_thread (./include/linux/list.h:381 =
kernel/workqueue.c:946 kernel/workqueue.c:3422)
>> [   81.173984][  T830]  kthread (kernel/kthread.c:465)
>> [   81.174000][  T830]  ret_from_fork (archkernel/process.c:164)
>> [   81.174011][  T830]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:256)
>> [   81.174014][  T830]  </TASK>
>> [   81.187221][  T830] Allocated by task 4409 on cpu 1 at 75.384100s:
>> [   81.188593][  T830]  __kmalloc_noprof (mm/slub.c:5658 =
mm/slub.c:5669)
>> [   81.189018][  T830]  sk_prot_alloc (./include/linux/slab.h:961 =
net/core/sock.c:2245)
>> [   81.189420][  T830]  sk_alloc (net/core/sock.c:2301)
>> [   81.189779][  T830]  nfc_llcp_sock_alloc (net/nfc/llcp_sock.c:979)
>> [   81.190222][  T830]  nfc_llcp_rx_skb (net/nfc/llcp_core.c:971 =
net/nfc/llcp_core.c:1478)
>> [   81.190656][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
>> [   81.193365][  T830] Freed by task 31 on cpu 196609 at 78.490492s:
>> [   81.195183][  T830]  kfree (mm/slub.c:6670 mm/slub.c:6878)
>> [   81.195531][  T830]  __sk_destruct (net/core/sock.c:2285 =
net/core/sock.c:2384)
>> [   81.195937][  T830]  nfc_llcp_rx_skb (.net/sock.h:? =
net/nfc/llcp_core.c:233 net/nfc/llcp_core.c:1194 =
net/nfc/llcp_core.c:1483)
>> [   81.196379][  T830]  nfc_llcp_rx_work (net/nfc/llcp_core.c:1533)
>> [   81.199084][  T830] The buggy address belongs to the object at =
ffff888119369800
>> [   81.199084][  T830]  which belongs to the cache kmalloc-1k of size =
1024
>> [   81.200297][  T830] The buggy address is located 18 bytes inside =
of
>> [   81.200297][  T830]  freed 1024-byte region [ffff888119369800, =
ffff888119369c00)
>>=20
>>=20
>> Best,
>> Shuangpeng

