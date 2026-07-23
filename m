Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8D23E320
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771891; cv=none; b=cuRBcm9PpNZTdnLHUFlHnX2mSmz+d6Z8PsEMMI3N212u8Za8T8zRIBVLzdw7Y1HY4W7TkK0Ok/5AKzErtWuQybvfFAC6Kz96Ut44BGzzqpL8qxT89p0bpFYah4CUUpykq4rLokhWyfxeqkPm2d/Fh/h6iExTa7brHCVLIsHCR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771891; c=relaxed/simple;
	bh=LYoHj0aZPGNOk+dFScXb1iL1VDdnRp9jX+D2s4r5hvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xmp99z6xYMpFmIziVdtBvpyVoYa5sRrRlhMBc8hsk36Kp+ExauJk1TvHCoFrmmufibRcVLlMlZik9uUyetROcPVGCA5mF5cY2uSGM8/0cgyotvUCWsqnJ8YUkNwpHAs9XCAYkNGT5/j9aKjFXXdF4nD4wlhmDSrQub16bc8qNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RkJPRVV5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RkJPRVV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LYoHj0aZPGNOk+dFScXb1iL1VDdnRp9jX+D2s4r5hvg=;
	b=RkJPRVV5iZCWZxfw303eR0KBkZ0TMAj4D/VMYKMrEpIRLxNgLPCwB1j5D+UXQS
	d+jhMCe8W83bKfwH3WK0bCB3oowoHHgBwwb9H+fbNrG4HO55sPFdDRnJ87zoz4Hp
	FOoXBxRT9ZXrctWpMRxbG+hVNmVCCET/CaPSvSabyi9Vw=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3eDMMdWFqvPiiHQ--.48445S2;
	Thu, 23 Jul 2026 09:57:34 +0800 (CST)
Message-ID: <9fc1c459-f72c-4b94-bf1e-290920c68d23@163.com>
Date: Thu, 23 Jul 2026 09:57:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] 8139cp: fix DMA mapping unwind on TX frag map
 failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <20260717103724.13971-1-luyun_611@163.com>
 <20260717103724.13971-2-luyun_611@163.com>
 <43379065-5916-42a7-8ecc-4b875ea53d22@163.com>
 <20260722124349.0bad10cd@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <20260722124349.0bad10cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3eDMMdWFqvPiiHQ--.48445S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWrJFykJw4kWryxCF45ZFb_yoW8Zr1xpF
	Z5ta1YyFs5JFWqqw47X3WFvrySvr43ta47XryrJrZFvwn8CF1fKrWxta4jkasrCa18X3yI
	9r4jv3yDuFW7Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-dbnUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxA5TImphdQ6EuAAA33


在 2026/7/23 03:43, Jakub Kicinski 写道:
> On Wed, 22 Jul 2026 15:37:02 +0800 luyun wrote:
>> A gentle ping for this series, the number of patches is 2, not 13. I made a mistake
>> when generating the patches. Please ignore it.
>>
>> Any comments or reviews would be greatly appreciated.
> You must describe how your discovered the issue and what HW you have
> tested it on. We don't take LLM fixes to Orphaned drivers.
Hi Jakub,

Thank you for taking the time to look at this, and sorry about the
patch numbering mess in my first submission.

On how the issue was found: it came out of a systematic audit of
the driver's error handling paths. I should be transparent that the
initial scan was assisted by AI tooling, but I then verified every
finding myself line by line before writing any patch.

Both bugs are deterministic logic errors provable by inspection.
Patch 1: in cp_start_xmit() the head descriptor is written only
after the fragment loop, but on a fragment mapping failure
unwind_tx_frag_mapping() unmaps the stale address still sitting in
that slot (a double unmap), uses fragment sizes shifted by one
slot, and never unmaps the head buffer mapping at all.
Patch 2: when cp_init_rings() fails, cp_clean_rings() has already
dropped all rx_skb entries, yet the hardware is restarted and NAPI
is scheduled unconditionally, so cp_rx_poll() hits BUG_ON(!skb).

On testing: the series is compile-tested only (full kbuild, -Werror
clean). I don't have RTL8139C+/RTL810x hardware, and QEMU's rtl8139
model is driven by 8139too, so I have no way to runtime-test this
driver. I want to be upfront about that.

I understand and respect the policy on orphaned drivers. I take
full responsibility for these changes, but I'd rather ask than assume:
are statically provable fixes like these acceptable for an orphaned
driver without hardware testing, or should I look for someone with
the hardware to confirm them first?

Thanks,
Yun


