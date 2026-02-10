Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805D1FCFFC
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683116; cv=none; b=T/Nw8vX3wUDaeDrIsREawwphyxPbcIxb9NkJCyPgm1WS+dd/ZvkwqobNczbd0FXhj1FHmIVmQWpIvkz9AdN3Jf5MspUHcsg0uso+sRbNIf8Ly63hWhWM1gUr/UT5x8WdSm2N5bIkp+tWLnFlU76FFPXfs9vBTqAkhTjrI84fP9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683116; c=relaxed/simple;
	bh=Wpfw2uqDmLqrlx715dbScHeqTNO7aVvos/5uQh5ZKms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NmDzo5qe3Up1XbyVm3Ebnd8xfev9WX6G4ZJUhU95h6puSCKWqTj5bpXgfUXOZ+Fo4w46bDVp0GQ8Pj6XNZzJmD1zsB5guh0tt2KChIZ/pgmjw9B7/0G18PLpxVTgmTHirQ+d/vodiv7ipUC4TJAinRS/HINs9FAvHT1DwtPa/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra5OCJdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra5OCJdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D640C116C6;
	Tue, 10 Feb 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770683115;
	bh=Wpfw2uqDmLqrlx715dbScHeqTNO7aVvos/5uQh5ZKms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ra5OCJdnfuCdFx6NO89ZSB9V2hj4VPkmFrvDZNdgGByBa5dfNQVHsoqLer8O2UTOv
	 X8zibP/PJ+MGMwrDXOs+srb/xtNvrxbY+ZVHdWSx1oR7HH8caBZ3OgALUkd14Bh6zX
	 pELM7Irep/kNcgWelpHebQ5VTTSv5PHSlrGU15w5YbFJhiH827vVZa/zPcCJy3mMvD
	 NM/g0rJFhA/L9jySY0X0iXDkINX3BXKNh0HwUX1P+w1C/drv/tZkShwco4Ilwm5egN
	 LI4PJ8izbzekt15Zbss65v9puacrwVzng32haZrfnNNIJ4i30xPF8vSXHtR2KxxjBd
	 gXdlTnjLgMniw==
From: Thomas Gleixner <tglx@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: i40e: Fix preempt count leak in napi poll tracepoint
In-Reply-To: <87a4xhbk6a.ffs@tglx>
References: <87v7g8zv2o.ffs@tglx>
 <aYpalNvTIiD4nym4@devvm20253.cco0.facebook.com> <87a4xhbk6a.ffs@tglx>
Date: Tue, 10 Feb 2026 01:25:11 +0100
Message-ID: <877bslbg2g.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 09 2026 at 23:56, Thomas Gleixner wrote:
> On Mon, Feb 09 2026 at 14:07, Joe Damato wrote:
>
>> On Sat, Feb 07, 2026 at 11:50:23AM +0100, Thomas Gleixner wrote:
>>> Using get_cpu() in the tracepoint assignment causes an obvious preempt
>>> count leak because nothing invokes put_cpu() to undo it:
>>> 
>>>   softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?
>>> 
>>> This clearly has seen a lot of testing in the last 3+ years...
>>
>> I'm the author who introduced the bug. FWIW, I did use it quite a bit when I
>> had i40e devices.
>
> Right, but always with PREEMPT_NONE and no debug option which would
> enforce PREEMPT_COUNT ...

Forgot to mention that's what is required before submitting patches
according to Documentation/process/submit-checklist.rst

But who cares about documentation aside of the people who write it?

Thanks,

        tglx

