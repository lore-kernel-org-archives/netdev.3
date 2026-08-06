Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CC37F333;
	Thu,  6 Aug 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035086; cv=none; b=Ftk1y3o2Lq9RqwHwPu6MXe/ZHUrlzHPuJ8NzLLVKY/gwOv/x0v5e+nOHysdiwvc/7lFKuZuHLNGGH61en1fGgi7o1F1yXbLyZ2SYle5s2D9uqw5dcxj/lExjngzjvfo7rsussAAeYZ0X9s54pSa5l0S7Q6ZCOpf3wY1tCfeMr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035086; c=relaxed/simple;
	bh=4CPyy0LZc2ljdgeL9KmdT1Qagqkx7zBCFJtvNoTr7X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cV4U0Q7yyhsxF7Z2ykwigGSp/WtxRii37X0nBUi0xQWgUs9YbeXDKzN3h4SS0J4lorxZ4YWMJeV8qyDoe9ftU/FC2OqluZasltbzqjvQtBaKskFqDz5N8c57Dfib/J800y809a0LffUrBDZ7xnlEtGYgsMWPG2Sx4jyI58GqvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mihzMuaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mihzMuaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142DB1F00AC4;
	Thu,  6 Aug 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035069;
	bh=VW5cd1p5XRC+w4p35sqH/MTb9tIs/OKUWXyCRBOYF1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mihzMuaQ9VdQu6IEel0W5l7eqgsJVuPrQCqpwiRKxYxdMSdpnUJ6CCxtlTUNtCJ4K
	 05BMkRUp6JfxKuc5ZGQIwNcRksPjHrSB7aFvOrKwpBdT8hGGqfFxfZv5j4s+dLdGbs
	 BByJ0r957c7QsM1sdJnTMPvf7QP9iD48Nb8EbhJ+94g1HddFb6YL9U80ll04RcWPzy
	 HM5sxQpZ64Hm7AV6vqujkSEL0rVU/cjZgUpOGaNV6YUvCalBWRGe1uWZY+Xj3z7PkA
	 fT2Esl7812rf76enQv9YVU4z4Z8LuRH9Ist4dYjkOTF6HDj5jZK3a0YcAYJFC+gOX3
	 CJGUFpT3xyVUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E6380820D;
	Thu,  6 Aug 2026 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: dpll: zl3073x: replace Prathosh
 Satish
 with Min Li
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502813.1375455.12779072373721769736.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:28 +0000
References: <20260805155425.38808-1-ivecera@redhat.com>
In-Reply-To: <20260805155425.38808-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, kuba@kernel.org,
 jiri@resnulli.us, min.li@microchip.com, pabeni@redhat.com,
 Prathosh.Satish@microchip.com, vadim.fedorenko@linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 17:54:25 +0200 you wrote:
> Replace Prathosh Satish by Min Li as the Microchip co-maintainer
> of the ZL3073X DPLL driver.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: dpll: zl3073x: replace Prathosh Satish with Min Li
    https://git.kernel.org/netdev/net/c/03a736fde464

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


