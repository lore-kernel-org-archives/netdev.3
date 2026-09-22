Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EE2E0914;
	Tue, 22 Sep 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067884; cv=none; b=BQSX8kf6NbDIdWl5QK2y9eaSyArHPwRSdFwF8A523ic+a26dJoBOCpwXDF1Grzz1JaWCCjygmhTmrJk6E5ALXuu1DagxvHYo3LF8f8pfH5dedjntRdCxP9DSPJDmQ6UAx2RrAAXLzOtVVdIM0GRKS58BlmZP1e3VqVdYqySjfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067884; c=relaxed/simple;
	bh=Jf5TgPOWPr/IWQ3Fxcfs0nj27Ygld0uLJckXIAnNGNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1A4qXIudl/8bV90xgubR2hh141z1mUnUPz/69AcqebW7lFXc8t4Uw0XjE4Gtml2wwtrVnZDBNqC+/lcmwALzrMPT+6lIBnAJpSuOMyTfugolLzhQWATjk5REGXpJEhF8znJXNPEto1RDdGwcYehdaAtz5zXnfomqyygPV50jNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YxeMJOUD; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YxeMJOUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6VtLFD1vg5tvTIM6vKNjHT1kkApQA/KZte/hT3YtnlI=;
	b=YxeMJOUDVswV4aSX/zGsIOqW+2onEoHyh74L+dNKTTQ/bqwyBjcviEo/qcpcbV
	5t+4VlKk6aXVGaRoJK4XZmEBgC506vEmh5W3msN5gGjNf8AxMz3zvSCunY0BaqSh
	2HaLCz8GM7Os5Tm9D4riuyH1k9OKyy8Pi40SxkjF5zqzY=
Message-ID: <ef2b48b9-0f57-46e6-8209-8f4b9d6e42dd@126.com>
Date: Tue, 22 Sep 2026 17:03:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile
 count returned by the firmware
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 aleksandr.loktionov@intel.com
References: <20260920063244.1927792-1-xiaolinkui@126.com>
 <178997248483.2160803.11710552261264563604@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <178997248483.2160803.11710552261264563604@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXtwRvRLJqOwMZAA--.52160S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykWw1kWw4fXrykCF17KFg_yoW5Ar1rpF
	WYq3yDtrykK3y0kw1Ikr4xWa48uws3AFy5Xw1rKa4vk3y5Krs7Xry0qFs0qa47AFsaqr1I
	yF1293yUAF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBB0S2qyRHDs-gAA3F

Thanks for the review. Both findings are addressed in v3.

- [Medium] Incomplete fix in i40e_ddp_does_profile_exist() and
   i40e_ddp_does_profile_overlap()

   Agreed on the clamping half. Silently limiting the count and then
   returning 0 hands i40e_ddp_load() a definite answer derived from a list
   that was only partially read: the add path proceeds without having
   examined every profile the firmware reported, and the is_add == false
   path reports a profile as missing that may in fact be loaded. Both
   helpers already have an error return that i40e_ddp_load() turns into
   "Failed to fetch loaded profiles." and aborts the operation, so v3
   rejects the list instead: if the firmware reports more profiles than
   I40E_PROFILE_LIST_SIZE can hold, the helpers return -EIO and no scan
   happens at all.

   I did not plumb the response datalen out of i40e_aq_get_ddp_list().
   For this command the driver has to set desc.datalen to the buffer size
   it passes in, and i40e_aq_get_ddp_list() does not report the writeback
   descriptor back to its caller, so the length would have to come either
   from a new output parameter on that helper (declared in
   i40e_prototype.h) or from a wb_desc routed through cmd_details. Either
   way it adds a second firmware supplied number to validate on top of the
   one this patch is about, and if the firmware leaves the field at the
   requested 772 bytes the derived bound is exactly the bound we have
   today. That is a bigger change to the common AQ path than a net fix
   should carry, so I would rather bound the scan by the size of the
   buffer the driver owns.

   The remaining half - comparing against p_info[] slots the firmware
   never filled - cannot be detected independently of the count, because
   the driver is not told how many records were actually written. If the
   firmware reports a count of 16 or less while writing fewer records, the
   unread slots are indistinguishable from real entries. Zero
   initialization makes the outcome deterministic (an unwritten entry is
   all zeroes rather than stale stack) but does not make it correct;
   deriving the bound from the response length would be needed for that,
   and that is the larger helper change described above.

- [Medium, pre-existing] uninitialized buff[] handed to
   i40e_aq_get_ddp_list()

   Agreed, and fixed as suggested: buff[] is now zero initialized in both
   helpers. i40e_asq_send_command_atomic_exec() copies the full buff_size
   into the DMA bounce buffer and copies the full buff_size back on
   completion, so those 772 bytes of stack were both readable by the
   firmware and compared against afterwards. Both hunks touch these
   declarations and the root commit is the same (cdc594e00370), so it is
   handled here rather than as a separate patch; I can split it out if you
   would rather have it on its own.

v3 keeps the unsigned loop counter from v2, and drops the Reviewed-by tag,
as the code changed after the review.

pw-bot: cr

