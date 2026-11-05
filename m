Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858371;
	b=WqqHWWIwsFD1RhVLuTjdXaqaS3aYTekupfJJ4F0Vem5ielVOtzbxKJCVODEsboZnSNc3
	 DTdxvgjbCIp6e9rmj0ZnuKUmXhnWXVr2yVu3H+G20ZQhHP/Fqw33CZ0OwzSLqr8rzclVD
	 b2GBE3T08MvNOZjm+izwkcyZnX0AIUeTEOo4y/bHwVyOObjoBameZAkDUzeoNzDeZNunW
	 ZRcjcTli2N18LyEsHXqRN+HHz1RXvXjElQu4RVMxEMBsa/fkYOGW1UozOy1QKfIWcQn2d
	 P1dI96ntF7uNwtmDIF+K7Qf4XzmF2wlWqpHob+jGYr5Bh+8UNPG4I6Slaex/UFPINxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858371;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zbh4wMZ9WUBs3S0LO6QMi4wquYaApdRMTQSw+mZIopg=;
	b=LNUFP0Vk6e0fgMh9uvg9Aq+zW4e3OE+SCHf4sT18HQWgqDfJpso+aG/qrdOkZtST20D8
	 QeuistDdsvOwmnHq/t+L0FDX5Me/GKON2+UVg7FQYfywHYgzJe1qB4Ft7UmUqC6ELg+KB
	 vCFU6D+nW+39Fqy3Ik1D5/mcE7AlhaiAPDs45TXg+CGNehtMU1elTz7TH7GN5cmrJV+HS
	 4BTpH9SNbMXfelflpeY8r+o+RU7IHIvAbkD8R2+lXIw03yccTFOmlCY0y2PHQqw0TZVht
	 hQmnggZg6OHibjMTPzhgUTaPE+ZkKhsCiPDgIVtRIqMjGEW/8spiKZNQQj/ijJQgjbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q8Ng1T+6;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDD606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79BDD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Q8Ng1T+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zbh4wMZ9WUBs3S0LO6QMi4wquYaApdRMTQSw+mZIopg=;
	b=Q8Ng1T+6DzvL1LHDfwPgQEcyk9skcgqpY/XcXAV1rX9ejkkkIqM3vkZIXckwr9
	7PXxCxWy1Skcmuqjd7Qxpv5sSon0A4RtTYQAUBvMQXej4j6DkaZ7hzG85FQgRXQL
	jAK8LGOOcfXCjbu87/aoHOOi5b52/2TFXA6bhvF/XrBNA=
Message-ID: <b7e35751-3947-4200-bc22-2d7b679d2c90@163.com>
Date: Thu, 5 Nov 2026 13:58:41 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] bonding: 3ad: update transmit arrays without
 waiting for RTNL
To: Eric Dumazet <edumazet@kernel.org>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, hangbin.liu@linux.dev
References: <20261104064409.281303-1-luyun_611@163.com>
 <CAL4Wiipu2VTRck9Es31krEKmYZuh9iCQu5fwqpOkWP6pQNqjvg@mail.gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <CAL4Wiipu2VTRck9Es31krEKmYZuh9iCQu5fwqpOkWP6pQNqjvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDn0JMRG+xqvwlmEA--.54657S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyrCFyfWr43CFW5GF4fAFb_yoW5Wr18pa
	ySyay0kFWqvw129r1q9a1xWrWru3y8KFW5JryFg348ArZ0qFyIvrW7KF1jgasrCrs3uw4j
	vFWjk3sI93WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIoGdUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xKgb2rsGxLnbAAA3y


在 2026/11/4 17:31, Eric Dumazet 写道:
> Le mer. 4 nov. 2026 à 07:44, Yun Lu <luyun_611@163.com> a écrit :
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> During 802.3ad bring-up, packets can be dropped despite carrier being up
>> and LACP having enabled ports for distribution. This was observed on a
>> machine in real use.
>>
>> The LACP worker enables ports before queuing slave_arr_work to rebuild
>> usable_slaves. The transmit path keeps using that array, which can
>> remain empty while the array worker retries rtnl_trylock(). Unrelated
>> RTNL contention can therefore prolong the packet loss.
>>
>> Rebuild the arrays directly from the LACP worker after releasing
>> mode_lock and RCU, and remove the retry worker's RTNL dependency. Retain
>> delayed work to retry allocation failures.
>>
>> Use a per-bond mutex to serialize array allocation, filling and
>> publication, and walk the lower list under RCU. Keep upper link/unlink
>> notifications outside this mutex. Exclude new slaves from both arrays
>> until all fallible setup, including XDP propagation, succeeds and
>> commits array_ready under the same mutex. This keeps concurrently linked
>> slaves from overrunning arrays sized from an earlier slave count.
>> Release completes its final rebuild or allocation-failure skip under the
>> mutex before waiting for RCU readers and freeing a slave.
>>
>> Retry failed final updates for running bonds. Also rebuild broadcast
>> arrays on open and retry failed open updates. Protect the
>> peer-notification array reader with RCU now that RTNL no longer excludes
>> writers. Updating the shared arrays also covers XDP and lower-device
>> queries without changing their selection rules.
>>
>> Tests used an RTNL holder, userspace LACP peers, slow notifiers and
>> test-only allocation failures under KASAN and lockdep to check recovery,
>> concurrent member changes and teardown. All 16 bonding selftests passed.
>>
>> Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
> I think this should target net-next. The rtnl_trylock() retry
> has been there since v3.18, and this patch adds a new locking scheme
> across enslave, release, open, uninit and the 3ad worker. With the
> Fixes: tag it would be backported to every stable tree, which seems
> risky for an issue that only shows up under RTNL contention. Please
> resend against net-next without the Fixes: tag, and keep the problem
> description in the changelog.

Hi Eric,

Thanks for the review and the routing guidance.

I will resend against net-next as v6, without the Fixes tag and with
the problem description kept in the changelog, rebased on current
net-next.

---
Thanks,
Yun Lu

> pw-bot: cr

