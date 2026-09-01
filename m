Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39FC43B3E6
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277114; cv=none; b=DfsrWn3pDkOzy4p7t33KNu7mekAx5bQjl6sTiNZvM3Tc9Tql/NQqFTzhRxSywvnW0mlZhaKq1cBzVZhNNpgb0B/0/NYHOJZd5vzn6pPjlU/TjgGmvOa68k6PlATTxQAirPsPJllHieMXgtChR7i4Q/oKH9Uo5nFUi0gGqPgXQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277114; c=relaxed/simple;
	bh=CtvXr8a0hzuXnlh4CTFTRbXjuma9IhrIxcX4uxpMyNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffUaDPzz84NIiqov+DQMdKI2iAycefxYYDb6SjN2k3LZ6iYv0imR8vdT0+ez5SYwISdR3lmGmdzlZM42cyJOTFGa0b98HiZw4FfnsO/leuMABlnbrsmwncsz4rnHL8T4X/oi41nDzPiU4l7UKHYBgt4sET2XhN4EqZSdswwfJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ghDllCN4; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ghDllCN4"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id 1QW3xKghu5Ste1QWAxBgfK; Tue, 01 Sep 2026 17:35:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1788276922; bh=CtvXr8a0hzuXnlh4CTFTRbXjuma9IhrIxcX4uxpMyNc=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=ghDllCN4+h8JJ2BAehCEljT9cPbnWg5jGvh2xiyV5ybIeg33KmzagJ5kOR5mU5eRi
	 drcgw2+L8tOIHeQvFY5+qxbhZmpezIoRKUJCaZ9B9QU6enSVMO/KGYCM+6rY84E7yz
	 49T9BlObOe/z1Er1yOIf2t+1FEBBtIJ7IPYLTGK0xuB48pI9g9LpWfZ8SUEgHiQulj
	 fhsXuj5bPomRiOfPLtM+QX/xDFewLfCzXO/mSQMy1gLDN5Neg/sYRaL7XPArmXGEF4
	 +K6lSda/iUJHipAnlrFd0C4VF6b9JnbizfFECzW1xbpOs69L+/KJrJFI1fTKV1j/CK
	 Fk3j0CCmvfXZQ==
Message-ID: <f6e90a49-8c68-42e6-bdff-ea9b3ecbaf7b@enneenne.com>
Date: Tue, 1 Sep 2026 17:35:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pps: Drop the !NO_HZ_COMMON dependency from
 NTP_PPS
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
References: <20260829210041.40649-1-dwmw2@infradead.org>
 <20260829210041.40649-3-dwmw2@infradead.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20260829210041.40649-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfENi9vL/3aKBLYaZ1CYQnY1dZHqqsCgRbq7woLVVqr0PXdIvi+gOU1KxLES32S5HZAwxSqpzHU8dkLkRBpvjT+ZdzU4RnosaNGGToDq7ikoOEtBPKDtp
 SVhigB4hLbwMgVRpgyCjBRAOQipMkYoBFHvWDcAP0nU3/ZxucRwMwL011fHEKcO4BHCbWIqjVGpvVs3EPpxwy734TN98LxcpfttdSM2syAaIANHh7p0eh08Z
 O0WQAfbXMYYQsB9ZiS9Iqw8aadzguhBtbXEF7bvGfKq1H6MqQ6KcFbPYY2Abux2nLprDReZackr4AuusMTR1hAq7+xXvXxYoBVAqlwrrjl1fShSLbl2Q4sFY
 hxFP9LD+lESr5QtapJBhIVbiQcL4GJGHjLbgDAFNPw3oEPE6pW3njb6Ffgd360VViOQzeDq+MZAydeUcj0eZ2IIUdjw9EwzWOseQrXyVT+AdYWUBO4XprNtD
 n4TthjeWARHPG+cMS0nVauwLIOaaGllK7mbzj+fLYAK96SV9aVkHFtXkg10KqiQE5psmYmgBSi6LmIlsuVT2RIC0B/4wN0y9SsL5iJCX1y/4/CoIu2ts33nB
 sHLwggalUg8eKkXmKmnjEV1nD+XIOMhlDqKnCyYEFcVfgg==

On Sat, 2026-08-29 at 21:57 +0100, David Woodhouse wrote:
> Whatever the original reasons were, the only *remaining* reason seems to
> have been that the accuracy of the time captured by pps_get_ts() was poor
> on tickless kernels due to the kernel's per-tick timekeeping mechanism.

"Whatever the original reasons were" and "seems to have been" is not
enough to drop a dependency that has been there for fifteen years. The
old comment is useless, I agree. But then we have to say what breaks
and what does not, not guess.

First a structural point. This is the only patch of the four that
applies to mainline, and it has no build dependency on the rest. It is
a three-line Kconfig delete that compiles on its own. That worries me:
a small "pps:" patch that applies cleanly is exactly what gets picked
up alone. Then NTP_PPS becomes selectable on tickless kernels without
1/4, and we are worse off than today. Reorder it last, or say in the
commit message that it must not be applied without 1/4.

> A recent change to ktime_get_snapshot_id() which is used by pps_get_ts()
> has fixed that problem, by applying a correction to the ::systime field

That "recent change" is 1/4 of this series, and it is in no tree yet.
Reading this, one assumes the groundwork already landed. Say "the
previous patch". Same wording in 3/4.

About the test. The pulse comes from 4/4, which derives it from the
same counter the timekeeping reads. No independent reference anywhere.

Before I ack this I want to see:

   - a real source, pps-gpio with a GPS receiver, where pulse and system
     clock are independent;
   - NO_HZ_FULL, not only NO_HZ_IDLE;
   - a run that goes through a long idle period, not just a busy system.

That is more work than a three-line delete suggests, I know. But those
three lines unlock a configuration people will run against real
receivers and then trust.

Rodolfo
