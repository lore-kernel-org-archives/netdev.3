Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25104A9D7D
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375705; cv=none; b=Mb85+YRC/oVEHayjuygMsSRG99Bz7GkfQe/fzY2bDSjeJIEQjuPGavF67WVn4ADwCyDkXAAdSWaZLEQiWxV1dswbGvB7bggLnD3SyVHmy8HqVapAIHTqDyJwXsBZMw0LGwvbSsq2BMbqK63tAoR9p7y3DmLzRMxhJnlvZYJFfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375705; c=relaxed/simple;
	bh=NfuJ+ulKb7PoJieV1+7TH+pCz3TxmNiK7fjksCT87fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDZihiiWELlfndEDODNZYG+1hEKYeq2j40Lq9rJib9/+Geho24E31e0kHz/I1qXhdtIXsXXW80CDdapTCNHaqbyUuCJFiSZ+AHzlgjzmrJZPhr2ZPWuSWokTR5FC/WvYsx0QH2wyvQlR9FJbPVErl9IaKz0L0kNIUAm3bN24IJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxxBFNzA; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxxBFNzA"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04be84so1652766c88.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790375702; x=1790980502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HnhwV0sMyfX8Q0UH1SywwM5PpJXEsDt0+jjzY6WI5t8=;
        b=bxxBFNzAfDqw0kIavQ6Hz92CcpOfyhWpa6ynCfsmMjt+fQ8u3vygQb/OA4aXxYzbFu
         6bZTN5CG7I9JpWyT2hyqGM3ruZoWECUZzAxYfxc0WhsONAkcuh8p1Kf7jeZb8YtLlJow
         eW6u6OiFSaKqJUTgMMYjcNcJeiJLAUh4IpEfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790375702; x=1790980502;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HnhwV0sMyfX8Q0UH1SywwM5PpJXEsDt0+jjzY6WI5t8=;
        b=f9AA2EcxzUBXqXgB6z4UT2MWjpmJrwsNtcamqI1RSeaHlX6ZI06mpodEVz2zqlMH1g
         ZBwel5SFpFF4mEXHSJR2VDRrXe2nnmzdCOdODMOlSVhVLOBQ3kiw6LMcyGXclLyFcViQ
         2VkB5HpA6kTSRHSkb+MsueJUJQxRwa+dqtr3bJPQaGLlHqHeUjZrBFWJIYOjYhwyYtL7
         v61S3SNFqijWKSW9BjcIrtmVyl8kGC57XsBHiJ/WnAYNyO1JFhCALUMzze5nbAUE3IrC
         BCqOsBTKWF/TwbbZNQD5kdGRv6MqwxLxTEFF651pJFmzvphDKFLeLOU8j1spMFHqIs7h
         E0bg==
X-Forwarded-Encrypted: i=1; AKwUvBzVwegxQjkdbW8pZ4SgEEQHi/1TUpAfDV6BsjB5/r38RhfmPAC0UeEk0/+pbTw4wrZhx4Cz16Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mntXgZoAcz4wL1iVw2mkNj5rM2fIBqmpUUbaQCjmXYmP21FyJk
	p8oY2VcYnAmdsmnDLFC+jP4eh1XMYjuPh6mNjLx3iMIiZuL1j4Xl2LvQQ3WLa7jOow==
X-Gm-Gg: AYBFou12gcEUyt8dNrpliz8I83DXZROyZzyTiRiCHV2LCqwtWl5zjznJjLx9VNtR9gP
	vCnZE4ceWceYiQTP0UAJqNfRnPeE9nfLxuCLrN0HSfEOr3ilRodD7onONC5/fRl85I3Hr85FRsM
	/M4jBjkNwegF0+gENqMmuDDHyjMnL2Lla+ESC+UF6s+1jo7FclmkvKjluzSejOajy0mKwvux7JC
	SCdsSPGnedWxkprVaCRJd6i2hsE8NeosX0fQfwzNnkHQPIf5veRpRPZveQFEPE3q0Mk6lDLZ1LG
	VseZEep50P532Li9brgOLlibm4MbaaqPeHXwqgJW9HLE3FXNBURi4Fv79XCLMuCB14gu7Y5czHZ
	tViKjjbG3WHyNkA5Cjfqm2/y4VKIILjS+gjeL9qzGq9xtqz8Clg941vcl8LIKV/2mBHrZwD50Oa
	5tyXYsuQAdutUkmppIU3WJQLUHVzJ1rZKRxiIsA9kXwM5nxBP58Oa41kfMPdPfK7jIKHOdSmi8Q
	V9cp+2muZ85Id1KhSQ3dzc6KOVm6QWDA8kq3A==
X-Received: by 2002:a05:701b:20de:20b0:145:5c7:71bc with SMTP id a92af1059eb24-146cddbcfddmr1428825c88.5.1790375701802;
        Fri, 25 Sep 2026 15:35:01 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:41fb:1648:4395:5cc4])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-145ac67c505sm7608861c88.5.2026.09.25.15.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 15:35:01 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:34:59 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: francesco@dolcini.it, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: bound SDIO fw dump count by memory table
 size
Message-ID: <arb3E_cVtzMC5eKj@google.com>
References: <7d886d74276c05eeb1b1698e31b72a5aed98612a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d886d74276c05eeb1b1698e31b72a5aed98612a@linux.dev>

On Fri, Sep 04, 2026 at 12:57:55PM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> mwifiex_sdio_fw_dump() reads the number of memory regions (dump_num) from 
> a device register and uses it to index the static 15-entry
> mem_type_mapping_tbl[] without any bounds check. A bogus device can
> report a dump_num larger than the table, making each loop iteration
> store a vmalloc pointer and a device-controlled size past the end
> of the table into adjacent .data (up to ~5.7KB when dump_num is 255).
> 
> The dump path runs after command timeouts or firmware crashes, so a
> bogus device can first force an error to trigger the dump and
> then report a bogus dump_num.
> 
> Aborting the dump only loses the firmware snapshot; the card reset 
> that follows is unaffected, so error recovery still completes.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: 54881c6b37c8d ("mwifiex: add firmware dump feature for SDIO")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>

I'm not sure if we're in the business of distrusting SDIO registers, but
sure?

Acked-by: Brian Norris <briannorris@chromium.org>

We also read this same register a bit later and use it for computing
potentially-enormous buffers to allocate and fill. Dunno if we consider
OOM a potential vulnerability (or infinite loop / DoS, or ...).
