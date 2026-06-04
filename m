Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D1405C47;
	Thu,  4 Jun 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588828; cv=none; b=siFyywnLnI6RinZiIoPA/kyNbjPH8xGpMra3IFUK3KE3OyjqxiwArtwspg9lKrM1UrVHiENRap0n1oREqYto2gXvDk969OjZaZ7+F2Df1gnHA3DBRpGGVCuhjZ10FM7YeIb63UDNhbGkyZFlcfYZVX2tQI3SXDzceDoqKBfFc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588828; c=relaxed/simple;
	bh=ypR96IrQoOzGi+Fcf010+SB6gEtTsDX8Dp7tAjnbv7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NysbnSZ1aAw+x1Fq3e9J229ZcbgoO4ZKWXUf4FMOAtMZm5r8JO5quDnih/mpemH4LJDHOU3OWqAQMK8eJohQ40BNIce6kP9fKTDLJp7EXc7v66FI2mbzO0+13CKFkHnHn96Q0DypYv5qpd827g2PQ1aurHR9T2Bf+9ZYc+uJSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL+1Kh4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL+1Kh4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D9C1F00893;
	Thu,  4 Jun 2026 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588826;
	bh=PkuSGZUyjfZCaNq7tverjM8boOF6AWYFbE7yr2uGwEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UL+1Kh4OoXnPj0dOSEIc681JENcE+gL17pT33qYV29DWMAxlGUhAqwVMJrkxju/qU
	 QDgkMHkbPWSCZ5o1rc0B0gBMeS/urpB1//VdG2o7XWI8SrCp3DIPUpViYFLO6Ipk9I
	 9OBF68Pb8hKyU6GXGb9ClVIEhL4RI1rExjYob0cD6rfmuc37wuVFhvH6Jfa3gnmo5U
	 Hnk59ElF0sCO1wTHN1xV52/j23Q+Fl5oMXRHi2FDW4B6vJKHi6kJJjyUv+V0UJhaFw
	 pHRWQ8sDCgABhIfUujMuqkIpnVKuRJulwYpSP4PIieIgKkS0syscGhhHgoOkKkoGOS
	 1eeC6rrgdPWig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B5C39309B7;
	Thu,  4 Jun 2026 16:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/802/mrp: fix vector attribute parsing in
 mrp_pdu_parse_vecattr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058882739.2493857.9626725543438968509.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:27 +0000
References: <20260603060016.21522-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260603060016.21522-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:00:13 +0800 you wrote:
> In mrp_pdu_parse_vecattr(), vector attribute events are encoded three
> per byte and valen tracks the number of events left to process.
> 
> The parser decrements valen after processing the first and second events
> from each event byte, but not after processing the third one. When valen
> is exactly a multiple of three, the loop continues after the last valid
> event and consumes the next byte as a new event byte, applying a
> spurious event to the MRP applicant state.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr
    https://git.kernel.org/netdev/net/c/7561c7fbc694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


