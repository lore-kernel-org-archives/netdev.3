Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860A35C68B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672456; cv=none; b=DJdFz+0xVYCAu3AwQbQ30mdm8K+3lki73iHF9ixyBH4k2lojAmiHidwzeyOC6BNMtT7OywchN9wrHaUAKg/hdeHrvHneBseWFzRlV8i2QUKLgJozH3iM8hQxQi2vleUiSYB457gusUeUGQelBIHu7ZOYhkuJtRCUsI1EAoGWywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672456; c=relaxed/simple;
	bh=pfCY3iyK6P9MuKKLRChH+2z8XmbWoRmpHfuWHgFBJl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lf+6+NU/D7Q+WDllpr0+ZI9FIC3yBQxQJL3tipiD8nyrbZxWyIZqzEli7NF0E79iRCkqo2kekj9P5XdmP17+vAG1U/G7xQJfpVPBkHpH7Dqcyn5qcPgr34xFA3tbW9CyFh7vvr++ekl9wse2ekPCusPMQF3YWPgwjpv4lHLqJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+JzC46a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+JzC46a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20D11F00A3A;
	Tue, 21 Jul 2026 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672454;
	bh=y8bUTAMyAli31Dc7ArDPd4xifAMKbsDPT9UuDmZtwHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H+JzC46a7u4M1OCaZWLUcXGNxVI+65ag5eVfE9IQRBeR8ZPmK3/kwWbwZ0KT3PqfB
	 VJrZ6O0ZxxOxlN46tKqMExZk6A742QRZ9LX76QYh9meDqib33llx/6JKXpduhqCyNF
	 LLlcVi/VEpi/GmIbwooC72l26iEvHGkB8HOtbelgnktIDM1nZ1c3zOybYX5MZfbu6g
	 WYzSGTheX2lLc5BgQtEP93rj4O0g1Q6s3Amc5ZHgDRa1IYAYcU4Tie5YhpAaraeloX
	 1hA+scKqG7vRsBpYxD1UDavkp9GI+RdGgNSqBU5R6XSRoPn+RCKwL/CU0XSzrDrA/8
	 Wa8b6w1kUY6jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C8380820D;
	Tue, 21 Jul 2026 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] net: libwx: improve VF ethtool support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467242388.1119846.9321402192869773546.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:20:23 +0000
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
In-Reply-To: <20260710015925.34769-1-mengyuanlou@net-swift.com>
To: mengyuanlou@net-swift.com <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jul 2026 09:59:23 +0800 you wrote:
> This series improves ethtool support for Wangxun VF drivers
> (ngbevf and txgbevf) in libwx.
> 
> This series extends VF support by enabling:
> ring parameter configuration via ethtool -G
> interrupt coalescing configuration via ethtool -C
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
    https://git.kernel.org/netdev/net-next/c/0ce45ae881fd
  - [net-next,v7,2/2] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
    https://git.kernel.org/netdev/net-next/c/e424cd462638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


