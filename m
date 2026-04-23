Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE0346E7E
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936044; cv=none; b=eMwJ5aFmOTONhm2xldB2kBwSsi56IQROatwJHGMgaXNZs40vxuBIkqV24zFVp6apM9lsiq/UeyQjoIO87Hfj8DXxKkb0VgFo6kGFsQxFeB3ZIo0PqpqWj3qpNd/ExTiizxRCGuPZnIH/q3ENlf/SDcNg5bphK2YmROl6eYkS3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936044; c=relaxed/simple;
	bh=hZibIuf8B6sWKrCqrm1PQgixWt4op0i3DRH1V5iVFXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nPaqvb4IED0de8Ob0aS6QaW51GPl1PW4AFFZih9nPA5FXxYiDBcyrYfmtsAr0/vhGo5p9IbrkuqZ3E/QnVcy8Yymsdlu9e62hwBbj+VmP+QvTp76zRFCLCY/b1J32hje7/8Z4i5Nc3EV11aoGVvGA+1WowY0unELxmu1SCGEvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT96L0MK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT96L0MK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB13C2BCB2;
	Thu, 23 Apr 2026 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776936044;
	bh=hZibIuf8B6sWKrCqrm1PQgixWt4op0i3DRH1V5iVFXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gT96L0MK0ytiQXl65IEIxdQaWXhIlkW3V8BYYIpp2VMZ9DkHZbG9cTWtEqbYNMGaK
	 YCIwbKARs6cda8ZSMqjLJqCWyllkMiOTi/i28l8KJU4BGa/kW+AqAMxr6lNwGzVlUM
	 fnocY8/8HxRTCEkH9zc5dhC9d/PdTvdfOSyjYCMF3Lp+ONHfBKV6HuaHvKLV8eQQCo
	 cM/UPLbDGJV+TaeqmMVqPzC8tFIqK46wNJquFhWCbbAbvuPr5tkTrxMQxMUt4EInj9
	 B8tB8oBDR62udvODsbX9i7feGSDw4n0I2V7qy5M3XEha1X3/upq8kUUkFELyHcCOhL
	 aWKYeG/w1mCnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D5C380CFEE;
	Thu, 23 Apr 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: realtek: rtl8365mb: fix mode mask
 calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177693600580.63460.5923134705742202898.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 09:20:05 +0000
References: <400a6387-a444-4576-af6d-26be5410bce3@yahoo.com>
In-Reply-To: <400a6387-a444-4576-af6d-26be5410bce3@yahoo.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 Apr 2026 21:37:07 +0200 you wrote:
> The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
> the 4-bit mask (0xF) by only (_extint % 2) bits instead of
> (_extint % 2) * 4. This caused the mask to overlap with the adjacent
> nibble when configuring odd-numbered external interfaces, selecting
> the wrong bits entirely.
> 
> Align the shift calculation with the existing ...MODE_OFFSET macro.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: realtek: rtl8365mb: fix mode mask calculation
    https://git.kernel.org/netdev/net/c/0c078021d386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


