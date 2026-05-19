Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8431B833;
	Tue, 19 May 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209395; cv=none; b=IuF4AIvyohmr9fLS7TDES+NgEK/HTxlJunPVccPn7tDIVIQ2wI4g0c9eDgrrrm3Gdrv0cI416mBycJ9gdOC40ply+1SJmZwzRCRdZTZQhdRNh6WnWVFqs0gG/j/6FqqjYcvMh04aI3/OLxMPKz+zZhjBiD92ADt87r7mh1GEtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209395; c=relaxed/simple;
	bh=d04hpmUOFMf/LgeOZs6p/ha/O9QBNhM0gewMBwrb/IY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8A9t1Wsi+QlbAVU8IVng7seuJMXveJoVOsMS86Qqi4FbaOaw9//5JqcahAH2YU+pEhwFdubB6N7zo8NjWet7s1a7NBMKjsh5jDSHQXF+Lqlk/eaHH20ASmBL4GSsKFxnfLzS79Yyc+e+6dJWDzzaI9o+ZAvRoPBPH7MWwiKGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib6tNX9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib6tNX9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B88C2BCB3;
	Tue, 19 May 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779209395;
	bh=d04hpmUOFMf/LgeOZs6p/ha/O9QBNhM0gewMBwrb/IY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ib6tNX9q3vtnAf4l5Myan4bpZrF+2uRq1wFqpuBBcYqmbKA1LSjqDkRv7N0a7yjcv
	 gVsXeIYM9cFjfK3Vg77o5N6PYDHhtoqZJ0GmBGxkrTDYV6hqagD6hgBZvNF9UKhxqZ
	 j9TGrXKea/nZ9WzuSEf0ODeeCLfOIUQ3ahgs+M8V4g9cFp+jB5ggy/BhdRGHgkEtcL
	 jUvzhMuqQeC64Y0E5a+g9qZ5BKPzOcCXNQvcKen8eyuMutzGgxVa53c0rwx7ULIO5u
	 XucoYf2DAMmyD2wbLXa3XnSzPuUGfcjEuNm2Soq39pbEU91HMKy6uZTpCvAaA37jLK
	 7a7NmhMqtiFnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EA3930E36;
	Tue, 19 May 2026 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pps: bump PPS device count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177920940589.2805248.8550713248320702959.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 16:50:05 +0000
References: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20260515135028.2021318-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: giometti@enneenne.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 13:50:28 +0000 you wrote:
> Modern systems may have more than 16 PPS sources and current hard-coded
> limit breaks registration of some devices. Let's bump the limit to 256
> in hope it will be enough in foreseen future.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  include/uapi/linux/pps.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] pps: bump PPS device count
    https://git.kernel.org/netdev/net-next/c/9bf93cb2e180

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


